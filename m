From: =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>
Subject: [PATCH] sdhci-esdhc-imx: fix timeout on i.MX's sdhci
Date: Tue, 19 Oct 2010 14:49:01 +0200
Message-ID: <1287492541-3060-1-git-send-email-eric@eukrea.com>
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
Cc: r65037@freescale.com, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, w.sang@pengutronix.de, shawn.gsc@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

dGhpcyBwYXRjaCBmaXggdGltZW91dCBwcm9ibGVtcyBvbiBpLk1YNTEgYXMgc3VnZ2VzdGVkIGJ5
ClJpY2hhcmQgWmh1Lgptb3JlIHRlc3RzIGFyZSBuZWVkZWQgdG8gY2hlY2sgaWYgdGhpcyBxdWly
ayBjYW4gYmUgcmVtb3ZlZApmb3IgaS5NWDI1IGFuZCAzNS4KClNpZ25lZC1vZmYtYnk6IEVyaWMg
QsOpbmFyZCA8ZXJpY0BldWtyZWEuY29tPgpUZXN0ZWQtYnk6IFNoYXduIEd1byA8c2hhd24uZ3Nj
QGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgICAg
MyArKy0KIDEgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgYi9kcml2ZXJz
L21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jCmluZGV4IDJlOWNjYTEuLmU4ZjcwNDggMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMKKysrIGIvZHJpdmVycy9t
bWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYwpAQCAtMTM0LDcgKzEzNCw4IEBAIHN0YXRpYyBzdHJ1
Y3Qgc2RoY2lfb3BzIHNkaGNpX2VzZGhjX29wcyA9IHsKIAogc3RydWN0IHNkaGNpX3BsdGZtX2Rh
dGEgc2RoY2lfZXNkaGNfaW14X3BkYXRhID0gewogCS5xdWlya3MgPSBFU0RIQ19ERUZBVUxUX1FV
SVJLUyB8IFNESENJX1FVSVJLX05PX01VTFRJQkxPQ0sKLQkJCXwgU0RIQ0lfUVVJUktfQlJPS0VO
X0FETUEsCisJCQl8IFNESENJX1FVSVJLX0JST0tFTl9BRE1BCisJCQl8IFNESENJX1FVSVJLX0JS
T0tFTl9USU1FT1VUX1ZBTCwKIAkvKiBBRE1BIGhhcyBpc3N1ZXMuIE1pZ2h0IGJlIGZpeGFibGUg
Ki8KIAkvKiBOT19NVUxUSUJMT0NLIG1pZ2h0IGJlIE1YMzUgb25seSAoRXJyYXRhOiBFTkdjbTA3
MjA3KSAqLwogCS5vcHMgPSAmc2RoY2lfZXNkaGNfb3BzLAotLSAKMS43LjAuNAoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwg
bWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
