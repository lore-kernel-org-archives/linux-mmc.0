From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Thu, 08 Oct 2009 14:14:27 +0200
Message-ID: <4ACDD7A3.1040908@atmel.com>
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
To: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Pierre Ossman <drzeus@drzeus.cx>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

VXdlIEtsZWluZS1Lw7ZuaWcgOgo+IFRoaXMgZml4ZXMgYSBjb21waWxlIGJ1ZyBpbnRyb2R1Y2Vk
IGluCj4gCj4gCTZlZjI5N2YgKEFSTTogNTcyMC8xOiBNb3ZlIE1NQ0kgaGVhZGVyIHRvIGFtYmEg
aW5jbHVkZSBkaXIpCj4gCj4gVGhhdCBjb21taXQgbW92ZWQgYXJjaC9hcm0vaW5jbHVkZS9hc20v
bWFjaC9tbWMuaCB0bwo+IGluY2x1ZGUvbGludXgvYW1iYS9tbWNpLmguICBKdXN0IHJlbW92aW5n
IHRoZSBpbmNsdWRlIHdhcyBlbm91Z2guCj4gCj4gU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1L
w7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KPiBDYzogQ2F0YWxpbiBNYXJp
bmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4KPiBDYzogTGludXMgV2FsbGVpaiA8bGludXMu
d2FsbGVpakBzdGVyaWNzc29uLmNvbT4KPiBDYzogUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFy
bS5saW51eC5vcmcudWs+Cj4gQ2M6IFBpZXJyZSBPc3NtYW4gPGRyemV1c0BkcnpldXMuY3g+Cj4g
Q2M6IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwoKQWNrZWQtYnk6IE5pY29s
YXMgRmVycmUgPG5pY29sYXMuZmVycmVAYXRtZWwuY29tPgoKPiAtLS0KPiAgZHJpdmVycy9tbWMv
aG9zdC9hdDkxX21jaS5jIHwgICAgMSAtCj4gIDEgZmlsZXMgY2hhbmdlZCwgMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L2F0
OTFfbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0OTFfbWNpLmMKPiBpbmRleCBlNTU2ZDQyLi42
MzkyNGUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwo+ICsrKyBi
L2RyaXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwo+IEBAIC03Miw3ICs3Miw2IEBACj4gICNpbmNs
dWRlIDxhc20vaXJxLmg+Cj4gICNpbmNsdWRlIDxhc20vZ3Bpby5oPgo+ICAKPiAtI2luY2x1ZGUg
PGFzbS9tYWNoL21tYy5oPgo+ICAjaW5jbHVkZSA8bWFjaC9ib2FyZC5oPgo+ICAjaW5jbHVkZSA8
bWFjaC9jcHUuaD4KPiAgI2luY2x1ZGUgPG1hY2gvYXQ5MV9tY2kuaD4KCgotLSAKTmljb2xhcyBG
ZXJyZQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LWFybS1rZXJuZWwK
