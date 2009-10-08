From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Thu, 08 Oct 2009 07:18:12 -0500
Message-ID: <4ACDD884.1060608@billgatliff.com>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
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

VXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gVGhpcyBmaXhlcyBhIGNvbXBpbGUgYnVnIGludHJv
ZHVjZWQgaW4KPgo+IAk2ZWYyOTdmIChBUk06IDU3MjAvMTogTW92ZSBNTUNJIGhlYWRlciB0byBh
bWJhIGluY2x1ZGUgZGlyKQo+Cj4gVGhhdCBjb21taXQgbW92ZWQgYXJjaC9hcm0vaW5jbHVkZS9h
c20vbWFjaC9tbWMuaCB0bwo+IGluY2x1ZGUvbGludXgvYW1iYS9tbWNpLmguICBKdXN0IHJlbW92
aW5nIHRoZSBpbmNsdWRlIHdhcyBlbm91Z2guCj4KPiBTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5l
LUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgo+IENjOiBDYXRhbGluIE1h
cmluYXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPgo+IENjOiBMaW51cyBXYWxsZWlqIDxsaW51
cy53YWxsZWlqQHN0ZXJpY3Nzb24uY29tPgo+IENjOiBSdXNzZWxsIEtpbmcgPHJtaytrZXJuZWxA
YXJtLmxpbnV4Lm9yZy51az4KPiBDYzogUGllcnJlIE9zc21hbiA8ZHJ6ZXVzQGRyemV1cy5jeD4K
PiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCj4gLS0tCj4gIGRyaXZl
cnMvbW1jL2hvc3QvYXQ5MV9tY2kuYyB8ICAgIDEgLQo+ICAxIGZpbGVzIGNoYW5nZWQsIDAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9o
b3N0L2F0OTFfbWNpLmMgYi9kcml2ZXJzL21tYy9ob3N0L2F0OTFfbWNpLmMKPiBpbmRleCBlNTU2
ZDQyLi42MzkyNGUwIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwo+
ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3QvYXQ5MV9tY2kuYwo+IEBAIC03Miw3ICs3Miw2IEBACj4g
ICNpbmNsdWRlIDxhc20vaXJxLmg+Cj4gICNpbmNsdWRlIDxhc20vZ3Bpby5oPgo+ICAKPiAtI2lu
Y2x1ZGUgPGFzbS9tYWNoL21tYy5oPgo+ICAjaW5jbHVkZSA8bWFjaC9ib2FyZC5oPgo+ICAjaW5j
bHVkZSA8bWFjaC9jcHUuaD4KPiAgI2luY2x1ZGUgPG1hY2gvYXQ5MV9tY2kuaD4KPiAgIAoKQWNr
ZWQtYnk6IEJpbGwgR2F0bGlmZiA8YmdhdEBiaWxsZ2F0bGlmZi5jb20+CgoKYi5nLgoKLS0gCkJp
bGwgR2F0bGlmZgpiZ2F0QGJpbGxnYXRsaWZmLmNvbQoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
