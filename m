From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: Re: [PATCH 0/3] mmc: Check BKOPS Level On Runtime Suspend
Date: Thu, 1 Sep 2016 05:02:24 +0000
Message-ID: <CC3EF0FD-A9AF-4FA9-9843-3A435B827DBC@sandisk.com>
References: <1472491952-395-1-git-send-email-alex.lemberg@sandisk.com>
 <CAPDyKFpYSZwQSoeA-aMh9P7gDuSDa6gzouusWpBOOidf3jw=Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0080.outbound.protection.outlook.com ([104.47.34.80]:27358
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750750AbcIAFRO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Sep 2016 01:17:14 -0400
In-Reply-To: <CAPDyKFpYSZwQSoeA-aMh9P7gDuSDa6gzouusWpBOOidf3jw=Fg@mail.gmail.com>
Content-Language: en-US
Content-ID: <0EE0EB4F13AFBD47BCA5B820E8BF22CC@namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

VGhhbmtzLg0KUmVzZW5kaW5n4oCmDQoNCk9uIDgvMzEvMTYsIDQ6NTEgUE0sICJVbGYgSGFuc3Nv
biIgPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+IHdyb3RlOg0KDQo+T24gMjkgQXVndXN0IDIwMTYg
YXQgMTk6MzIsIGFsZXgubGVtYmVyZyA8YWxleC5sZW1iZXJnQHNhbmRpc2suY29tPiB3cm90ZToN
Cj4+IEZsYXNoIGJhc2VkIHN0b3JhZ2UgZGV2aWNlcyBtaWdodCBuZWVkIHRvIHBlcmZvcm0gdGhl
IGludGVybmFsDQo+PiBCYWNrZ3JvdW5kIE9wZXJhdGlvbnMgKEJLT1BTKSBpbiBvcmRlciB0byBp
bnN1cmUgYmV0dGVyIHBlcmZvcm1hbmNlDQo+PiBmb3IgdGhlIG5leHQgY29taW5nIElPLg0KPj4g
Rm9sbG93aW5nIHRoZSBkaXNjdXNzaW9uIGluIHRoZSBtbWMgdGhyZWFkOg0KPj4gd3d3LnNwaW5p
Y3MubmV0L2xpc3RzL2xpbnV4LW1tYy9tc2czNzc3OS5odG1sDQo+PiBUbyBsZXQgdGhlIGRldmlj
ZSBjb21wbGV0ZSBpdHMgQktPUFMgZHVyaW5nIFJ1bnRpbWUgU3VzcGVuZCwNCj4+IHdlIHN1Z2dl
c3QgdG8gY2hlY2sgdGhlIEJLT1BTIGxldmVsLg0KPj4gSW4gY2FzZSB0aGUgZGV2aWNlIG5lZWQg
dG8gY29tcGxldGUgaXRzIEJLT1BTLCByZXNjaGVkdWxlIHRoZSBSdW50aW1lDQo+PiBTdXNwZW5k
Lg0KPj4NCj4+IGFsZXgubGVtYmVyZyAoMyk6DQo+PiAgIG1tYzogcmVwbGFjaW5nIGhhcmRjb2Rl
ZCB2YWx1ZSBmb3IgcnVudGltZSBQTSBzdXNwZW5kDQo+PiAgIG1tYzogQWRkaW5nIEFVVE9fQktP
UFNfRU4gYml0IHNldCBmb3IgQXV0byBCS09QUyBzdXBwb3J0DQo+PiAgIG1tYzogQ2hlY2tpbmcg
QktPUFMgc3RhdHVzIHByaW9yIHRvIFN1c3BlbmQNCj4+DQo+PiAgZHJpdmVycy9tbWMvY2FyZC9i
bG9jay5jIHwgIDMgKystDQo+PiAgZHJpdmVycy9tbWMvY29yZS9tbWMuYyAgIHwgMzYgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQo+PiAgaW5jbHVkZS9saW51eC9tbWMvY2Fy
ZC5oIHwgIDEgKw0KPj4gIGluY2x1ZGUvbGludXgvbW1jL2hvc3QuaCB8ICAyICsrDQo+PiAgaW5j
bHVkZS9saW51eC9tbWMvbW1jLmggIHwgIDIgKysNCj4+ICA1IGZpbGVzIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0NCj4+IDEuOS4xDQo+Pg0KPg0K
PkFsZXgsIHRoYW5rcyBmb3IgcG9zdGluZyB0aGlzLiBBbHRob3VnaCwgdGhlIHBhdGNoZXMgZG9l
c24ndCBzaG93IHVwDQo+aW4gdGhlIGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVj
dC9saW51eC1tbWMvbGlzdC8uIEkgZ3Vlc3MNCj5pdCdzIGJlY2F1c2UgeW91IG11c3QgaGF2ZSBs
aW51eC1tbWMgb24gdGhlIHRvIGxpc3QuIENvdWxkIHlvdSBwbGVhc2UNCj5yZXNlbmQ/DQo+DQo+
S2luZCByZWdhcmRzDQo+VWZmZQ0KDQo=
