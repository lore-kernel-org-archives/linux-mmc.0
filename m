From: Sascha El-Sharkawy <elscha@sse.uni-hildesheim.de>
Subject: [Patch] MULTIMEDIA CARD (MMC): Avoid useless selection of
 MMC_RICOH_MMC quirk
Date: Fri, 22 Sep 2017 14:21:13 +0200
Message-ID: <F6127EC53C695C46907CD6EE43F3462352911290BD@messagesink.samelson.uni-hildesheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from messagesink.samelson.uni-hildesheim.de ([147.172.172.66]:52642
        "EHLO messagesink.samelson.uni-hildesheim.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752148AbdIVM1K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2017 08:27:10 -0400
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

RW5zdXJlIGNvcnJlY3QgZnVuY3Rpb25hbGl0eSBvZiBNTUNfUklDT0hfTU1DIHBjaSBxdWlyay4N
Cg0KTU1DX1JJQ09IX01NQyBpcyBhIHBjaSBxdWlyayAocmVhbGl6ZWQgaW4gL2RyaXZlcnMvcGNp
L3F1aXJrcy5jIGxpbmVzIDI4NzcNCi0gMjk1OSksIHdoaWNoIGluIHR1cm4gZGVwZW5kIG9uIFBD
SV9RVUlSS1MuIEhvd2V2ZXIsIE1NQ19SSUNPSF9NTUMgY2FuIGJlDQpzZWxlY3RlZCBldmVuIGlm
IHBjaSBxdWlya3MgKFBDSV9RVUlSS1MpIGFyZSBnbG9iYWxseSBkaXNhYmxlZC4gVGhpcyBwYXRj
aA0KYWRkcyB0aGUgbWlzc2luZyBkZXBlbmRlbmN5IHRvIE1NQ19SSUNPSF9NTUMgdG8gZW5zdXJl
IHRoYXQgaXQgY2FuIG9ubHkgYmUNCnNlbGVjdGVkIGlmIHBjaSBxdWlya3MgYXJlIGFjdGl2ZS4N
Cg0KU2lnbmVkLW9mZi1ieTogIFNhc2NoYSBFbC1TaGFya2F3eSA8ZWxzY2hhQHNzZS51bmktaGls
ZGVzaGVpbS5kZT4NCi0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyB8ICAgIDIgKy0NCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZyBiL2RyaXZlcnMvbW1jL2hvc3QvS2NvbmZpZw0K
aW5kZXggOGMxNTYzNy4uODExNDNmYiAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvS2Nv
bmZpZw0KKysrIGIvZHJpdmVycy9tbWMvaG9zdC9LY29uZmlnDQpAQCAtOTEsNyArOTEsNyBAQCBj
b25maWcgTU1DX1NESENJX1BDSQ0KIA0KIGNvbmZpZyBNTUNfUklDT0hfTU1DDQogCWJvb2wgIlJp
Y29oIE1NQyBDb250cm9sbGVyIERpc2FibGVyIg0KLQlkZXBlbmRzIG9uIE1NQ19TREhDSV9QQ0kN
CisJZGVwZW5kcyBvbiBNTUNfU0RIQ0lfUENJICYmIFBDSV9RVUlSS1MNCiAJZGVmYXVsdCB5DQog
CWhlbHANCiAJICBUaGlzIGFkZHMgYSBwY2kgcXVpcmsgdG8gZGlzYWJsZSBSaWNvaCBNTUMgQ29u
dHJvbGxlci4gVGhpcw0K
