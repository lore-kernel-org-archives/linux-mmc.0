From: <tomas.melin@vaisala.com>
Subject: [PATCH] mmc-utils: Fix register number in error message
Date: Thu, 25 Aug 2016 12:35:19 +0000
Message-ID: <386cc2bd-4826-af2d-8cb6-f56300296bf2@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:60449 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757095AbcHYMfZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2016 08:35:25 -0400
Content-Language: en-US
Content-ID: <4A044F17E1C2F44AA07AC79AFD4B02BB@exch.vaisala.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: linux-mmc@vger.kernel.org, tomas.melin@vaisala.com

UmVnaXN0ZXIgYmVpbmcgc2V0IGlzIG90aGVyIHRoYW4gbWVudGlvbmVkIGluIHByaW50ZWQgbWVz
c2FnZS4NCg0KU2lnbmVkLW9mZi1ieTogVG9tYXMgTWVsaW48dG9tYXMubWVsaW5AdmFpc2FsYS5j
b20+DQotLS0NCiAgbW1jX2NtZHMuYyB8IDIgKy0NCiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9tbWNfY21kcy5jIGIvbW1jX2Nt
ZHMuYw0KaW5kZXggMjFkZGQ1NS4uZWYzYTUwZiAxMDA2NDQNCi0tLSBhL21tY19jbWRzLmMNCisr
KyBiL21tY19jbWRzLmMNCkBAIC01MDcsNyArNTA3LDcgQEAgaW50IGRvX2Rpc2FibGVfNTEyQl9l
bXVsYXRpb24oaW50IG5hcmdzLCBjaGFyICoqYXJndikNCg0KICAgICAgICAgIGlmIChyZXQpIHsN
CiAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJDb3VsZCBub3Qgd3JpdGUgMHglMDJ4IHRv
IEVYVF9DU0RbJWRdIGluIA0KJXNcbiIsDQotICAgICAgICAgICAgICAgICAgICAxLCBFWFRfQ1NE
X0JPT1RfV1AsIGRldmljZSk7DQorICAgICAgICAgICAgICAgICAgICAxLCBFWFRfQ1NEX05BVElW
RV9TRUNUT1JfU0laRSwgZGV2aWNlKTsNCiAgICAgICAgICAgICAgZXhpdCgxKTsNCiAgICAgICAg
ICB9DQogICAgICAgICAgcHJpbnRmKCJNTUMgZGlzYWJsZSA1MTJCIGVtdWxhdGlvbiBzdWNjZXNz
ZnVsLiAgTm93IHJlc2V0IHRoZSANCmRldmljZSB0byBzd2l0Y2ggdG8gNEtCIG5hdGl2ZSBzZWN0
b3IgbW9kZS5cbiIpOw0KLS0gDQoyLjEuNA0KDQo=
