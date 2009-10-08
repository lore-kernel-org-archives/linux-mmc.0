From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Thu,  8 Oct 2009 12:12:42 +0200
Message-ID: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Pierre Ossman <drzeus@drzeus.cx>, Linus Walleij <linus.walleij@stericsson.com>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

VGhpcyBmaXhlcyBhIGNvbXBpbGUgYnVnIGludHJvZHVjZWQgaW4KCgk2ZWYyOTdmIChBUk06IDU3
MjAvMTogTW92ZSBNTUNJIGhlYWRlciB0byBhbWJhIGluY2x1ZGUgZGlyKQoKVGhhdCBjb21taXQg
bW92ZWQgYXJjaC9hcm0vaW5jbHVkZS9hc20vbWFjaC9tbWMuaCB0bwppbmNsdWRlL2xpbnV4L2Ft
YmEvbW1jaS5oLiAgSnVzdCByZW1vdmluZyB0aGUgaW5jbHVkZSB3YXMgZW5vdWdoLgoKU2lnbmVk
LW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZT4KQ2M6IENhdGFsaW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+CkNjOiBMaW51
cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQHN0ZXJpY3Nzb24uY29tPgpDYzogUnVzc2VsbCBLaW5n
IDxybWsra2VybmVsQGFybS5saW51eC5vcmcudWs+CkNjOiBQaWVycmUgT3NzbWFuIDxkcnpldXNA
ZHJ6ZXVzLmN4PgpDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCi0tLQog
ZHJpdmVycy9tbWMvaG9zdC9hdDkxX21jaS5jIHwgICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9o
b3N0L2F0OTFfbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0OTFfbWNpLmMKaW5kZXggZTU1NmQ0
Mi4uNjM5MjRlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9hdDkxX21jaS5jCisrKyBi
L2RyaXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwpAQCAtNzIsNyArNzIsNiBAQAogI2luY2x1ZGUg
PGFzbS9pcnEuaD4KICNpbmNsdWRlIDxhc20vZ3Bpby5oPgogCi0jaW5jbHVkZSA8YXNtL21hY2gv
bW1jLmg+CiAjaW5jbHVkZSA8bWFjaC9ib2FyZC5oPgogI2luY2x1ZGUgPG1hY2gvY3B1Lmg+CiAj
aW5jbHVkZSA8bWFjaC9hdDkxX21jaS5oPgotLSAKMS42LjQuMwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBs
aXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
