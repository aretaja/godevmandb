package godevmandb

import (
	"crypto/aes"
	"crypto/cipher"
	"crypto/rand"
	"crypto/sha256"
	"encoding/hex"
	"io"
)

// Returns AES GCM encrypted and hex encoded string
// "instr" - plain text input string
// "secret" - secret string for encryption
func EncryptStrAes(inStr string, secret string) (string, error) {
	key := sha256.Sum256([]byte(secret))

	// Create a new AES cipher
	block, err := aes.NewCipher(key[:])
	if err != nil {
		return "", err
	}

	// Create a new GCM cipher
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	// Create a new nonce in place of an IV
	nonce := make([]byte, gcm.NonceSize())

	if _, err := io.ReadFull(rand.Reader, nonce); err != nil {
		return "", err
	}

	eStr := gcm.Seal(nonce, nonce, []byte(inStr), nil)

	return hex.EncodeToString(eStr), nil
}

// Returns unencrypted string
// "instr" - AES GCM encrypted and hex encoded string created with "EncryptStrAes" function
// "secret" - secret string used for encryption
func DecryptStrAes(inStr string, secret string) (string, error) {
	eStr, err := hex.DecodeString(inStr)
	if err != nil {
		return "", err
	}

	key := sha256.Sum256([]byte(secret))

	// Create a new AES cipher
	block, err := aes.NewCipher(key[:])
	if err != nil {
		return "", err
	}

	// Create a new GCM cipher
	gcm, err := cipher.NewGCM(block)
	if err != nil {
		return "", err
	}

	nonce := eStr[:gcm.NonceSize()]
	eStr = eStr[gcm.NonceSize():]

	dStr, err := gcm.Open(nil, nonce, eStr, nil)
	if err != nil {
		return "", err
	}

	return string(dStr), nil
}
