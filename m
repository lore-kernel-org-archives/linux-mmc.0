From: =?utf-8?B?SnVzdGluIFdhbmcgKOeOi+S4gSk=?=
	<Justin.Wang@spreadtrum.com>
Subject: [PATCH] mmc: card: Fixup request missing in mmc_blk_issue_rw_rq
Date: Tue, 19 May 2015 06:32:31 +0000
Message-ID: <dbf65349aac343abbd215129dd3ceefb@SHMBX03.spreadtrum.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:17141 "EHLO
	SHSQR01.spreadtrum.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753863AbbESGde (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2015 02:33:34 -0400
Content-Language: zh-CN
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'ulf.hansson@linaro.org'" <ulf.hansson@linaro.org>, "'kuninori.morimoto.gx@renesas.com'" <kuninori.morimoto.gx@renesas.com>, "'jh80.chung@samsung.com'" <jh80.chung@samsung.com>, "'akpm@linux-foundation.org'" <akpm@linux-foundation.org>, "'JBottomley@Odin.com'" <JBottomley@Odin.com>, "'ben@decadent.org.uk'" <ben@decadent.org.uk>, "'chuanxiao.dong@intel.com'" <chuanxiao.dong@intel.com>
Cc: "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>

RnJvbSAwNTg0OWRhNTYzYzgwYzIwNTk3YWI2Mjc1ZDU4ODFhOGVkNDI2Zjk2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbToganVzdGluLndhbmcgPGp1c3Rpbi53YW5nQHNwcmVhZHRydW0u
Y29tPg0KRGF0ZTogTW9uLCAxOCBNYXkgMjAxNSAyMDoxNDoxNSArMDgwMA0KU3ViamVjdDogW1BB
VENIXSBtbWM6IGNhcmQ6IEZpeHVwIHJlcXVlc3QgbWlzc2luZyBpbiBtbWNfYmxrX2lzc3VlX3J3
X3JxDQoNClRoZSBjdXJyZW50IGhhbmRsZXIgb2YgTU1DX0JMS19DTURfRVJSIGluIG1tY19ibGtf
aXNzdWVfcndfcnEgZnVuY3Rpb24NCm1heSBjYXVzZSBuZXcgY29taW5nIHJlcXVlc3QgcGVybWFu
ZW50IG1pc3Npbmcgd2hlbiB0aGUgb25nb2luZw0KcmVxdWVzdCAocHJldmlvdWxzeSBzdGFydGVk
KSBjb21wbGV0ZSBlbmQuDQoNClRoaXMgd291bGQgY2F1c2UgdGhlIHByb2Nlc3MgcmVsYXRlZCB0
byB0aGUgbWlzc2luZyByZXF1ZXN0IHN0YXkgYXQgJ0QnDQpzdGF0ZSBmb3JldmVyLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBEaW5nIFdhbmcgPGp1c3Rpbi53YW5nQHNwcmVhZHRydW0uY29tPg0KLS0tDQog
ZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jIHwgICAgOCArKysrKy0tLQ0KIDEgZmlsZXMgY2hhbmdl
ZCwgNSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvY2FyZC9ibG9jay5jIGIvZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jDQppbmRleCA2MGY3
MTQxLi5mMDVjZDFmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tbWMvY2FyZC9ibG9jay5jDQorKysg
Yi9kcml2ZXJzL21tYy9jYXJkL2Jsb2NrLmMNCkBAIC0xOTEwLDkgKzE5MTAsMTEgQEAgc3RhdGlj
IGludCBtbWNfYmxrX2lzc3VlX3J3X3JxKHN0cnVjdCBtbWNfcXVldWUgKm1xLCBzdHJ1Y3QgcmVx
dWVzdCAqcnFjKQ0KIAkJCWJyZWFrOw0KIAkJY2FzZSBNTUNfQkxLX0NNRF9FUlI6DQogCQkJcmV0
ID0gbW1jX2Jsa19jbWRfZXJyKG1kLCBjYXJkLCBicnEsIHJlcSwgcmV0KTsNCi0JCQlpZiAoIW1t
Y19ibGtfcmVzZXQobWQsIGNhcmQtPmhvc3QsIHR5cGUpKQ0KLQkJCQlicmVhazsNCi0JCQlnb3Rv
IGNtZF9hYm9ydDsNCisJCQlpZiAobW1jX2Jsa19yZXNldChtZCwgY2FyZC0+aG9zdCwgdHlwZSkp
DQorCQkJCWdvdG8gY21kX2Fib3J0Ow0KKwkJCWlmICghcmV0KQ0KKwkJCQlnb3RvIHN0YXJ0X25l
d19yZXE7DQorCQkJYnJlYWs7DQogCQljYXNlIE1NQ19CTEtfUkVUUlk6DQogCQkJaWYgKHJldHJ5
KysgPCA1KQ0KIAkJCQlicmVhazsNCi0tIA0KMS43LjQuMQ0KDQo=
