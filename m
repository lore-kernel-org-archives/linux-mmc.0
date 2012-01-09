From: JONGMAN HEO <jongman.heo@samsung.com>
Subject: Erasing MMC partition from kernel module, what's best way to do that?
Date: Mon, 09 Jan 2012 10:14:28 +0000 (GMT)
Message-ID: <21845361.155711326104068000.JavaMail.weblogic@epml02>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:55523 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2AIKO3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jan 2012 05:14:29 -0500
Received: from epcpsbge2.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LXJ00L630F0S3J0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Jan 2012 19:14:28 +0900 (KST)
MIME-version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

DQpIaSBhbGwsDQpQbGVhc2UgZXhjdXNlIG1lLCBJIGhhdmUgc29tZSBub29iIHF1ZXN0aW9uIHJl
Z2FyZGluZyBNTUMuDQoNCkknZCBsaWtlIHRvIGVyYXNlKGRpc2NhcmQpIGNlcnRhaW4gTU1DIHBh
cnRpdGlvbiBmcm9tIGtlcm5lbCBzcGFjZSAoaS5lLiBrZXJuZWwgbW9kdWxlKS4NCkkga25vdyB0
aGlzIGlzIHF1aXRlIHVnbHkgZGVzaWduLCBidXQgSSBoYXZlIG5vIGNob2ljZSBidXQgdG8gaW1w
bGVtZW50IHRoZSBmZWF0dXJlIChlcmFzaW5nIGdpdmVuIE1NQyBwYXJ0aXRpb24pIHdpdGhpbiBr
ZXJuZWwgc3BhY2UgZm9yIG90aGVyIHJlYXNvbnMuDQoNCkFzc3VtZSAvZGV2L21tY2JsazBwMiBu
ZWVkcyB0byBiZSBlcmFzZWQuDQoNCkZpcnN0LCBJIHRyaWVkIHRvIHVzZSBCTEtESVNDQVJEIGlv
Y3RsLiBGcm9tIHVzZXIgc3BhY2UsIGl0IHdvcmtzLg0KSW4ga2VybmVsIHNwYWNlLCBJIGhhZCB0
byB1c2UgdWdseSBjb2RlLCBsaWtlIHNldF9mcygpLCBmaWxwX29wZW4oKSwgZXRjIGluIG9yZGVy
IHRvIGFjY2VzcyAiL2Rldi9tbWNibGswcDIiIGRldmljZS4NCkkgc3R1Y2sgYXQgc3lzX2lvY3Rs
KCksIHdoaWNoIGlzIG5vdCBleHBvcnRlZCBzeW1ib2wgc28gdGhhdCBJIGNvdWxkbid0IHVzZSB0
aGUgc3lzX2lvY3RsKCkgZnJvbSBteSBtb2R1bGUgZm9yIHRoZSBCTEtESVNDQVJEIGlvY3RsLg0K
DQpBbHRlcm5hdGl2ZWx5LCBJIHdhbnQgdG8gbWFrZSBhIG5ldyBleHBvcnRlZCBBUEkgdG8gZXhl
Y3V0ZSB0aGUgZGlzY2FyZCByZXF1ZXN0IGZvciAiL2Rldi9tbWNibGswcDIiIGRldmljZSAobGlr
ZSBtbWNfdGVzdF9hcmVhX2VyYXNlKCkgaW4gbW1jX3Rlc3QuYykuDQpIZXJlLCBpdCBzZWVtcyB0
aGF0IEkgbmVlZCB0byBnZXQgInN0cnVjdCBtbWNfY2FyZCAqY2FyZCIgaW5zdGFuY2UsIHdoaWNo
IGlzIGEgZmlyc3QgcGFyYW1ldGVyIG9mIG1tY19lcmFzZSgpLg0KDQpIb3cgY2FuIEkgZ2V0IHRo
ZSAiY2FyZCIgaW5zdGFuY2UgZm9yIGN1cnJlbnQgTU1DIGRldmljZT8gSXMgdGhlcmUgYW55IHdh
eSB0byBkbyB0aGF0Pw0KDQpUaGFua3MgaW4gYWR2YW5jZSwNCkpvbmdtYW4uDQo=


