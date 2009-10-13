From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Tue, 13 Oct 2009 09:19:48 +0200
Message-ID: <1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
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
Cc: Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

VGhpcyBmaXhlcyBhIGNvbXBpbGUgZXJyb3IgaW50cm9kdWNlZCBpbgoKCTZlZjI5N2YgKEFSTTog
NTcyMC8xOiBNb3ZlIE1NQ0kgaGVhZGVyIHRvIGFtYmEgaW5jbHVkZSBkaXIpCgpUaGF0IGNvbW1p
dCBtb3ZlZCBhcmNoL2FybS9pbmNsdWRlL2FzbS9tYWNoL21tYy5oIHRvCmluY2x1ZGUvbGludXgv
YW1iYS9tbWNpLmguICBKdXN0IHJlbW92aW5nIHRoZSBpbmNsdWRlIHdhcyBlbm91Z2guCgpTaWdu
ZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4
LmRlPgpBY2tlZC1ieTogTGludXMgV2FsbGVpaiA8bGludXMud2FsbGVpakBzdGVyaWNzc29uLmNv
bT4KQWNrZWQtYnk6IE5pY29sYXMgRmVycmUgPG5pY29sYXMuZmVycmVAYXRtZWwuY29tPgpBY2tl
ZC1ieTogQmlsbCBHYXRsaWZmIDxiZ2F0QGJpbGxnYXRsaWZmLmNvbT4KQ2M6IENhdGFsaW4gTWFy
aW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+CkNjOiBSdXNzZWxsIEtpbmcgPHJtaytrZXJu
ZWxAYXJtLmxpbnV4Lm9yZy51az4KQ2M6IFBpZXJyZSBPc3NtYW4gPGRyemV1c0BkcnpldXMuY3g+
CkNjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKQ2M6IEFuZHJldyBNb3J0
b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+Ci0tLQpIZWxsbywKCndoYXQgaXMgdGhlIHJp
Z2h0IHBhdGggdG8gTGludXMgZm9yIHRoaXMgcGF0Y2g/CgpCZXN0IHJlZ2FyZHMKVXdlCgogZHJp
dmVycy9tbWMvaG9zdC9hdDkxX21jaS5jIHwgICAgMSAtCiAxIGZpbGVzIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0
L2F0OTFfbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0OTFfbWNpLmMKaW5kZXggZTU1NmQ0Mi4u
NjM5MjRlMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9hdDkxX21jaS5jCisrKyBiL2Ry
aXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwpAQCAtNzIsNyArNzIsNiBAQAogI2luY2x1ZGUgPGFz
bS9pcnEuaD4KICNpbmNsdWRlIDxhc20vZ3Bpby5oPgogCi0jaW5jbHVkZSA8YXNtL21hY2gvbW1j
Lmg+CiAjaW5jbHVkZSA8bWFjaC9ib2FyZC5oPgogI2luY2x1ZGUgPG1hY2gvY3B1Lmg+CiAjaW5j
bHVkZSA8bWFjaC9hdDkxX21jaS5oPgotLSAKMS42LjQuMwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0
CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
