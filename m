From: Jongman Heo <jongman.heo@samsung.com>
Subject: Writing emmc write-protected area gives no error,
 though the protection is working
Date: Tue, 17 Apr 2012 03:35:12 +0000 (GMT)
Message-ID: <15237741.51731334633712478.JavaMail.weblogic@epv6ml06>
Reply-To: jongman.heo@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:31465 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab2DQDfO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 23:35:14 -0400
Received: from epcpsbge1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2L004VSTX41TE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 17 Apr 2012 12:35:12 +0900 (KST)
MIME-version: 1.0
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

DQpIaSBhbGwsDQoNCkkndmUgdGVzdGVkICh0ZW1wb3JhcnkpIHdyaXRlLXByb3RlY3Rpb24gZmVh
dHVyZSBvZiBlTU1DIGZsYXNoLg0KDQogICAjMS4gc2V0IHRoZSB0ZW1wb3Jhcnkgd3JpdGUtcHJv
dGVjdGlvbiAodXNpbmcgQ01EMjgpDQogICAjMi4gd3JpdGUgZGF0YSB0byB0aGUgd3JpdGUtcHJv
dGVjdGVkIGFyZWEgICh1c2luZyBkZCBvciBzaW1pbGFyKQ0KICAgICAtPiBnaXZlcyBubyBlcnJv
ciBhdCBhbGwuDQogICAjMy4gY2hlY2tpbmcgdGhlIGFyZWEgY29uZmlybXMgdGhhdCB3cml0ZS1w
cm90ZWN0aW9uIGlzIHdvcmtpbmcsIGRhdGEgaXMgbm90IG92ZXItd3JpdHRlbi4NCg0KSW4gc3Rl
cCAjMiwgSSBleHBlY3RlZCBzb21lIGVycm9yIHJldHVybiwgYnV0IG5vLiBPYnZpb3VzbHkgd3Jp
dGUtcHJvdGVjdGlvbiBpcyB3b3JraW5nLCBidXQgdXNlciBjYW4ndCBzZWUgYW55IHZpc2libGUg
b3V0cHV0Lg0KDQpTaG91bGRuJ3Qgd3JpdGUoMikgcmV0dXJuIHNvbWUgZXJyb3IgZm9yIGFib3Zl
IGNhc2U/DQoNCkpvbmdtYW4uDQoNCg0K


