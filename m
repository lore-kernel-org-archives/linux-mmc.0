From: y@pengutronix.de
Subject: [PATCH 09/11] mmc/omap_hsmmc: add a const qualifier
Date: Fri, 13 Jul 2012 14:32:12 +0200
Message-ID: <27612.411886412$1342183276@news.gmane.org>
References: <1342182734-321-1-git-send-email-y>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1342182734-321-1-git-send-email-y>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>
Cc: Balaji T K <balajitk@ti.com>, devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, kernel@pengutronix.de, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClRoaXMgcHJlcGFyZXMgb2ZfZGV2aWNlX2lkLmRhdGEgYmVjb21pbmcgY29uc3QuIFdpdGhvdXQg
dGhpcyBjaGFuZ2UKdGhlIGZvbGxvd2luZyB3YXJuaW5nIHdvdWxkIG9jY3VyOgoKCWRyaXZlcnMv
bW1jL2hvc3Qvb21hcF9oc21tYy5jOiBJbiBmdW5jdGlvbiAnb21hcF9oc21tY19wcm9iZSc6Cglk
cml2ZXJzL21tYy9ob3N0L29tYXBfaHNtbWMuYzoxODA4OiB3YXJuaW5nOiBpbml0aWFsaXphdGlv
biBkaXNjYXJkcyBxdWFsaWZpZXJzIGZyb20gcG9pbnRlciB0YXJnZXQgdHlwZQoKU2lnbmVkLW9m
Zi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
Q2M6IENocmlzIEJhbGwgPGNqYkBsYXB0b3Aub3JnPgpDYzogVmVua2F0cmFtYW4gUyA8c3Zlbmth
dHJAdGkuY29tPgpDYzogQmFsYWppIFQgSyA8YmFsYWppdGtAdGkuY29tPgpDYzogUmFqZW5kcmEg
TmF5YWsgPHJuYXlha0B0aS5jb20+CkNjOiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGlu
dGVsLmNvbT4KQ2M6IGxpbnV4LW9tYXBAdmdlci5rZXJuZWwub3JnCkNjOiBsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnCi0tLQogZHJpdmVycy9tbWMvaG9zdC9vbWFwX2hzbW1jLmMgfCAgICAyICst
CiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L29tYXBfaHNtbWMuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvb21h
cF9oc21tYy5jCmluZGV4IDM4OWEzZWUuLjViY2QwNDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbW1j
L2hvc3Qvb21hcF9oc21tYy5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvb21hcF9oc21tYy5jCkBA
IC0xODA1LDcgKzE4MDUsNyBAQCBzdGF0aWMgaW50IF9fZGV2aW5pdCBvbWFwX2hzbW1jX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaWYgKG1hdGNoKSB7CiAJCXBkYXRhID0g
b2ZfZ2V0X2hzbW1jX3BkYXRhKCZwZGV2LT5kZXYpOwogCQlpZiAobWF0Y2gtPmRhdGEpIHsKLQkJ
CXUxNiAqb2Zmc2V0cCA9IG1hdGNoLT5kYXRhOworCQkJY29uc3QgdTE2ICpvZmZzZXRwID0gbWF0
Y2gtPmRhdGE7CiAJCQlwZGF0YS0+cmVnX29mZnNldCA9ICpvZmZzZXRwOwogCQl9CiAJfQotLSAK
MS43LjEwLjQKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
