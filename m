From: David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Subject: [PATCH 4/4] mmc: sunxi: Removing unused code
Date: Tue, 16 Dec 2014 01:38:01 +0100
Message-ID: <20141216003801.15488.82217.stgit@dizzy-6.o2s.ch>
References: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20141216003412.15488.54812.stgit@dizzy-6.o2s.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, David =?utf-8?q?Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>, =?utf-8?b?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

UmVtb3ZpbmcgYSByZWxpY3QgZnJvbSByZXZlcnNlIGVuZ2luZWVyaW5nIG9mIHRoZSBBbmRyb2lk
IGRyaXZlciBjb2RlIGluCnN1bnhpX21tY19jbGtfc2V0X3JhdGUuCgpTaWduZWQtb2ZmLWJ5OiBE
YXZpZCBMYW56ZW5kw7ZyZmVyIDxkYXZpZC5sYW56ZW5kb2VyZmVyQG8ycy5jaD4KUmVwb3J0ZWQt
Ynk6IOadjuaDsyA8bGl4aWFuZ0BhbGx3aW5uZXJ0ZWNoLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9o
b3N0L3N1bnhpLW1tYy5jIHwgICAxMCArLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9z
dW54aS1tbWMuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc3VueGktbW1jLmMKaW5kZXggNTMzMWM4OC4u
ZjczYTU2OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zdW54aS1tbWMuYworKysgYi9k
cml2ZXJzL21tYy9ob3N0L3N1bnhpLW1tYy5jCkBAIC02MzUsNyArNjM1LDcgQEAgc3RhdGljIGlu
dCBzdW54aV9tbWNfb2Nsa19vbm9mZihzdHJ1Y3Qgc3VueGlfbW1jX2hvc3QgKmhvc3QsIHUzMiBv
Y2xrX2VuKQogc3RhdGljIGludCBzdW54aV9tbWNfY2xrX3NldF9yYXRlKHN0cnVjdCBzdW54aV9t
bWNfaG9zdCAqaG9zdCwKIAkJCQkgIHN0cnVjdCBtbWNfaW9zICppb3MpCiB7Ci0JdTMyIHJhdGUs
IG9jbGtfZGx5LCBydmFsLCBzY2xrX2RseSwgc3JjX2NsazsKKwl1MzIgcmF0ZSwgb2Nsa19kbHks
IHJ2YWwsIHNjbGtfZGx5OwogCWludCByZXQ7CiAKIAlyYXRlID0gY2xrX3JvdW5kX3JhdGUoaG9z
dC0+Y2xrX21tYywgaW9zLT5jbG9jayk7CkBAIC02ODAsMTQgKzY4MCw2IEBAIHN0YXRpYyBpbnQg
c3VueGlfbW1jX2Nsa19zZXRfcmF0ZShzdHJ1Y3Qgc3VueGlfbW1jX2hvc3QgKmhvc3QsCiAJCXNj
bGtfZGx5ID0gNDsKIAl9CiAKLQlzcmNfY2xrID0gY2xrX2dldF9yYXRlKGNsa19nZXRfcGFyZW50
KGhvc3QtPmNsa19tbWMpKTsKLQlpZiAoc3JjX2NsayA+PSAzMDAwMDAwMDAgJiYgc3JjX2NsayA8
PSA0MDAwMDAwMDApIHsKLQkJaWYgKG9jbGtfZGx5KQotCQkJb2Nsa19kbHktLTsKLQkJaWYgKHNj
bGtfZGx5KQotCQkJc2Nsa19kbHktLTsKLQl9Ci0KIAljbGtfc3VueGlfbW1jX3BoYXNlX2NvbnRy
b2woaG9zdC0+Y2xrX21tYywgc2Nsa19kbHksIG9jbGtfZGx5KTsKIAogCXJldHVybiBzdW54aV9t
bWNfb2Nsa19vbm9mZihob3N0LCAxKTsKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
