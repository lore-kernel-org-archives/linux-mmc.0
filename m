From: Jialing Fu <jlfu@marvell.com>
Subject: RE: [RESEND PATCH] mmc: core: fix race condition in
 mmc_wait_data_done
Date: Fri, 28 Aug 2015 10:22:35 +0000
Message-ID: <1243788837884e859a8959cf8265125c@SC-EXCH04.marvell.com>
References: <1440731589-22241-1-git-send-email-shawn.lin@rock-chips.com>
	<55DFD4B7.3070601@rock-chips.com>
	<CAPDyKFqZXx11qsnPH_uTDptfkUFfDykNKPgVcH6AW5CbH6Fi8g@mail.gmail.com>
	<55E02F7C.1020204@rock-chips.com>
 <CAPDyKFqYDdwvTCw3oKhkxqu9zmTAC8osLgd6eC4zDY7JOMGGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:14222 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688AbbH1KWl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2015 06:22:41 -0400
In-Reply-To: <CAPDyKFqYDdwvTCw3oKhkxqu9zmTAC8osLgd6eC4zDY7JOMGGPQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

DQpbLi4uXQ0KDQo+Pj4gSGksIHVsZg0KPj4+DQo+Pj4gV2UgZmluZCB0aGlzIGJ1ZyBvbiBJbnRl
bC1DMzIzMFJLIHBsYXRmb3JtIGZvciB2ZXJ5IHNtYWxsIHByb2JhYmlsaXR5Lg0KPj4+DQo+Pj4g
V2hlcmVhcyBJIGNhbiBlYXNpbHkgcmVwcm9kdWNlIHRoaXMgY2FzZSBpZiBJIGFkZCBhIG1kZWxh
eSgxKSBvciAgDQo+Pj4gbG9uZ2VyIGRlbGF5IGFzIEppYWxpbmcgZGlkLg0KPj4+DQo+Pj4gVGhp
cyBwYXRjaCBzZWVtcyB1c2VmdWwgdG8gbWUuIFNob3VsZCB3ZSBwdXNoIGl0IGZvcndhcmQ/IDop
DQo+Pg0KPj4NCj4+IEl0IHNlZW1zIGxpa2UgYSB2ZXJ5IGdvb2QgaWRlYSENCj4+DQo+PiBTaG91
bGQgd2UgYWRkIGEgZml4ZXMgdGFnIHRvIGl0Pw0KPg0KPg0KPiBUaGF0J3MgY29vbCwgYnV0IGhv
dyB0byBhZGQgYSBmaXhlcyB0YWc/DQo+DQo+IFtGaXhlc10gbW1jOiBjb3JlOiBmaXggcmFjZSBj
b25kaXRpb24gaW4gbW1jX3dhaXRfZGF0YV9kb25lID8gICA6KQ0KPg0KDQpBIGZpeGVzIHRhZyBw
b2ludHMgdG8gYW4gb2xkIGNvbW1pdCB3aGljaCBpbnRyb2R1Y2VkIHRoZSBidWcuIElmIHdlIGNh
bid0IGZpbmQgb25lLCB3ZSBjYW4gYWRkIGEgQ2MgdGFnIHRvICJzdGFibGUiLiBKdXN0IHNlYXJj
aCB0aGUgZ2l0IGxvZyBhbmQgeW91IHdpbGwgZmluZCBleGFtcGxlcy4NCg0KTGlrZSBhZGQgb25l
IGxpbmUgYXMgYmVsb3c/DQpGaXhlczogMjIyMGVlZGZkN2FlICgibW1jOiBmaXggYXN5bmMgcmVx
dWVzdCBtZWNoYW5pc20gZm9yIHNlcXVlbnRpYWwgcmVhZCBzY2VuYXJpb3MiKQ0KDQoNCktpbmQg
cmVnYXJkcw0KVWZmZQ0K
