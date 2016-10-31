From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Mon, 31 Oct 2016 09:53:50 +0000
Message-ID: <C1EB6DD6-A419-4E21-843F-40545CFAE87C@sandisk.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
 <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com>
 <2D82096E-231C-43BA-801D-381F8191F26C@sandisk.com>
 <CAPDyKFo=xUkGvqghr3zFB_anvzVQDJgkjFziveceQ+jpjjxdbQ@mail.gmail.com>
 <9277d105-9603-c011-25c4-083590fb4709@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0057.outbound.protection.outlook.com ([104.47.32.57]:7384
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S938931AbcJaL3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 31 Oct 2016 07:29:13 -0400
In-Reply-To: <9277d105-9603-c011-25c4-083590fb4709@rock-chips.com>
Content-Language: en-US
Content-ID: <B787F5675F16E94491695274A97032B1@namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

R3JlYXQuIFRoYW5rcyBmb3IgdGhlIGluZm9ybWF0aW9uIQ0KDQpPbiAxMC8xMy8xNiwgMTE6MzAg
QU0sICJTaGF3biBMaW4iIDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+IHdyb3RlOg0KDQo+5Zyo
IDIwMTYvMTAvMTMgMTU6MzYsIFVsZiBIYW5zc29uIOWGmemBkzoNCj4+IE9uIDQgU2VwdGVtYmVy
IDIwMTYgYXQgMTU6MzAsIEFsZXggTGVtYmVyZyA8QWxleC5MZW1iZXJnQHNhbmRpc2suY29tPiB3
cm90ZToNCj4+PiBIaSBTaGF3biwNCj4+Pg0KPj4+IE9uIDkvMi8xNiwgMTA6MzkgQU0sICJTaGF3
biBMaW4iIDxzaGF3bi5saW5Acm9jay1jaGlwcy5jb20+IHdyb3RlOg0KPj4+DQo+Pj4+IEhpDQo+
Pj4+DQo+Pj4+IE9uIDIwMTYvOS8xIDIyOjI0LCBhbGV4IGxlbWJlcmcgd3JvdGU6DQo+Pj4+PiBB
ZGQgTU1DX0FVVE9TVVNQRU5EX0RFTEFZX01TIGRlZmluZQ0KPj4+Pg0KPj4+PiBJJ20gdGhpbmtp
bmcgc2hvdWxkIHdlIGV4cG9zZSBpdCB0byB1c2Vyc3BhY2UNCj4+Pj4gdmlhIHN5c2ZzLCBzaW5j
ZSBJIGRvbid0IGtub3cgd2h5IGl0IHNob3VsZCBiZSAzbXMsIG5vdCA0bXMsIDVtcywgZXRjLg0K
Pj4+DQo+Pj4gQWdyZWUsIHdlIGNhbiBjb25zaWRlciBleHBvc2luZyBpdCB0byB0aGUgdXNlciBz
cGFjZS4NCj4+PiBUaGUgZXhwb3N1cmUgdG8gdGhlIHVzZXIgc3BhY2UgaXMgbGVzcyBjcml0aWNh
bCB0byB0aGUgY3VycmVudA0KPj4+IHBhdGNoc2V0LCBidXQgd2UgY2FuIGRvIGl0IGFzIGEg4oCc
Zm9sbG93LXVwIGNoYW5nZeKAnSBvbmNlIGl0cyBhcHByb3ZlZC4NCj4+DQo+PiBObyBuZWVkIGZv
ciB0aGF0LCBpcyBhbHJlYWR5IGF2YWlsYWJsZSBmb3IgdXNlci1zcGFjZS4gOi0pDQo+Pg0KPj4g
RWFjaCBkZXZpY2Ugd2l0aCBydW50aW1lIFBNIGF1dG9zdXNwZW5kIGVuYWJsZWQsIGFsbG93cyB1
c2Vyc3BhY2UgdG8NCj4+IGNoYW5nZSB0aGUgZGVsYXkgdmlhIHRoZSAiYXV0b3N1c3BlbmRfZGVs
YXlfbXMiIHN5c2ZzIGZpbGUuDQo+DQo+SW5kZWVk77yMIEkganVzdCBjaGVjayBpdCB3aGVuIGVu
YWJsaW5nIHJ1bnRpbWUgUE0gZm9yIGR3X21tYyBhbmQgY291bGQNCj5hYmxlIHRvIGNoYW5nZSB0
aGUgdmFsdWUgb2YgYXV0b3N1c3BlbmRfZGVsYXlfbXMuDQo+DQo+VGhhbmtzIGZvciBzaGFyaW5n
IHRoaXMuDQo+DQo+Pg0KPj4gS2luZCByZWdhcmRzDQo+PiBVZmZlDQo+PiAtLQ0KPj4gVG8gdW5z
dWJzY3JpYmUgZnJvbSB0aGlzIGxpc3Q6IHNlbmQgdGhlIGxpbmUgInVuc3Vic2NyaWJlIGxpbnV4
LW1tYyIgaW4NCj4+IHRoZSBib2R5IG9mIGEgbWVzc2FnZSB0byBtYWpvcmRvbW9Admdlci5rZXJu
ZWwub3JnDQo+PiBNb3JlIG1ham9yZG9tbyBpbmZvIGF0ICBodHRwOi8vdmdlci5rZXJuZWwub3Jn
L21ham9yZG9tby1pbmZvLmh0bWwNCj4+DQo+DQo+DQo+LS0gDQo+QmVzdCBSZWdhcmRzDQo+U2hh
d24gTGluDQo+DQoNCg==
