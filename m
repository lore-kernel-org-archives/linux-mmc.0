From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/6] ARM: dts: dra7: Increase max-voltage of pbias regulator
Date: Thu, 31 Aug 2017 15:48:46 +0530
Message-ID: <20170831101849.9489-4-kishon@ti.com>
References: <20170831101849.9489-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170831101849.9489-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: devicetree@vger.kernel.org, kishon@ti.com, Sekhar Nori <nsekhar@ti.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

RnJvbTogUmF2aWt1bWFyIEthdHRla29sYSA8cmtAdGkuY29tPgoKQXMgcGVyIHJlY2VudCBUUk0s
IFBCSUFTIGNlbGwgb24gZHJhNyBkZXZpY2VzIHN1cHBvcnRzCjMuM1YgYW5kIG5vdCAzLjBWIGFz
IGRvY3VtZW50ZWQgZWFybGllci4KClVwZGF0ZSBQQklBUyByZWd1bGF0b3IgbWF4IHZvbHRhZ2Ug
dG8gbWF0Y2ggdGhpcy4KCkRvY3VtZW50IHJlZmVyZW5jZToKU1BSVUkzMEMg4oCTIERSQTc1eCwg
RFJBNzR4IFRlY2huaWNhbCByZWZlcmVuY2UgbWFudWFsLSBOb3ZlbWJlciAyMDE2CgpUZXN0ZWQg
b246CkRSQTc1eCBQRyAyLjAgUkVWIEggRVZNCgpTaWduZWQtb2ZmLWJ5OiBSYXZpa3VtYXIgS2F0
dGVrb2xhIDxya0B0aS5jb20+ClNpZ25lZC1vZmYtYnk6IFNla2hhciBOb3JpIDxuc2VraGFyQHRp
LmNvbT4KU2lnbmVkLW9mZi1ieTogS2lzaG9uIFZpamF5IEFicmFoYW0gSSA8a2lzaG9uQHRpLmNv
bT4KLS0tCiBhcmNoL2FybS9ib290L2R0cy9kcmE3LmR0c2kgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9kcmE3LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9kcmE3LmR0c2kKaW5kZXggMGYw
ZjZmNThiZDE4Li5mYzE0ZTQ4YjQ4MmUgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2Ry
YTcuZHRzaQorKysgYi9hcmNoL2FybS9ib290L2R0cy9kcmE3LmR0c2kKQEAgLTE3MCw3ICsxNzAs
NyBAQAogCQkJCQkJcGJpYXNfbW1jX3JlZzogcGJpYXNfbW1jX29tYXA1IHsKIAkJCQkJCQlyZWd1
bGF0b3ItbmFtZSA9ICJwYmlhc19tbWNfb21hcDUiOwogCQkJCQkJCXJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDE4MDAwMDA+OwotCQkJCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMw
MDAwMDA+OworCQkJCQkJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+OwogCQkJ
CQkJfTsKIAkJCQkJfTsKIAotLSAKMi4xMS4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
