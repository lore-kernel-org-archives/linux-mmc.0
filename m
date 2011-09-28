From: Sebastian RASMUSSEN <sebastian.rasmussen@stericsson.com>
Subject: RE: [PATCH 3/3] mmc: mmci: Change vdd_handler to a generic
 ios_handler
Date: Wed, 28 Sep 2011 11:18:04 +0200
Message-ID: <ECD438FDEF6BD742895E554C24725A401C4F1AE111@EXDCVYMBSTM005.EQ1STM.local>
References: <1317123753-29902-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdZpbs06Gi27dpVearp1zV6Xi-8-88E1GJmRca3u_N1zbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:39907 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753571Ab1I1JSR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 05:18:17 -0400
In-Reply-To: <CACRpkdZpbs06Gi27dpVearp1zV6Xi-8-88E1GJmRca3u_N1zbg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Ulf HANSSON <ulf.hansson@stericsson.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>

PiBJJ20gZ3Vlc3NpbmcgaXQgd2FzIHNvbWUgZmVhdHVyZSBpbnRlbmRlZCB0byBjb250cm9sIGUu
Zy4gYQ0KPiByZWd1bGF0b3Igb2Ygc29tZSBraW5kIGJ5IHJvdXRpbmcgdGhlbSBvZmYtY2hpcCAo
c2luY2UgbWl4ZWQtc2lnbmFsDQo+IGNoaXBzIHJhcmVseSBoYXZlIE1NQyBjb250cm9sbGVycyBp
bnNpZGUuLi4pIGFuZCBtb3N0IGRlc2lnbmVycw0KPiBhbHJlYWR5IGhhdmUgdGhlaXIgb3duIHJl
Z3VsYXRvciBkZXNpZ25zIHNvIGl0IG1hZGUgbm8gc2Vuc2UNCj4gZm9yIGFueW9uZSB0byBhY3R1
YWxseSBpbXBsZW1lbnQgaXQgdGhhdCB3YXkuDQoNCll1cCwgSSB0aGluayBBUk0gUEwxODAgSFcg
SVAgZGV2ZWxvcGVycyBlbnZpc2lvbmVkIHRoYXQgdGhlIFNELWNhcmQNCnJlZ3VsYXRvciBhbmQv
b3IgbGV2ZWwtc2hpZnRlciB3b3VsZCB1dGlsaXplIHRoZXNlIHNpZ25hbHMgZWxlY3RyaWNhbGx5
DQp0byBjb25maWd1cmUgd2hhdCB2b2x0YWdlIHRvIHVzZS4gQXMgZmFyIGFzIEkgcmVhZCB0aGUg
b2xkIFRSTSB0aGUgd2F5IA0KdGhlc2UgYml0cyBlbmNvZGVkIHZvbHRhZ2UgbGV2ZWxzIHdlcmUg
YXBwbGljYXRpb24tc3BlY2lmaWMgc28gSSBjYW4ndA0Kc2VlIHRoYXQgdGhlcmUgd291bGQgYmUg
YW55IGNvbnNlbnN1cyBvZiBob3cgdG8gaW50ZXJwcmV0IHRoZW0gZWl0aGVyLg0KDQo+IElmIHNv
bWUgdmVuZG9yIHdvdWxkIGFjdHVhbGx5IHN0YXJ0IHVzaW5nIHRoZXNlIGJpdHMgZm9yIHRoZQ0K
PiBpbnRlbmRlZCBwdXJwb3NlIEkgZ3Vlc3Mgd2UgY291bGQgYWRhcHQuIChUaGUgcGlyYXRlIGRy
aXZlcg0KPiBtc21fc2RjYy5jIGRvZXMgbm90IHNlZW0gdG8gdXNlIHRoZXNlIGJpdHMgZWl0aGVy
IEJUVy4pDQoNCkkgbmV2ZXIgZGlkIGNoZWNrIHdoZXRoZXIgbXNtX3NkY2MgdXNlZCB0aG9zZSwg
YnV0IGl0IHNlZW1lZA0KdW5pbXBvcnRhbnQgYXQgdGhlIHRpbWUgc2luY2UgaXQncyBub3QgdGhl
IHNhbWUgZHJpdmVyICh5ZXQpLg0KTmljZSB0byBrbm93IHRoYXQgbmVpdGhlciBkcml2ZXIgdXNl
cyB0aG9zZSB0aG91Z2guDQoNCiAvIFNlYmFzdGlhbg0K
