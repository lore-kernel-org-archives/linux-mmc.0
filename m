Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6BCC10DCE
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 02:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA2B20674
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 02:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D8AL8R5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCKCNr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 22:13:47 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:26415 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727506AbgCKCNq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2020 22:13:46 -0400
X-UUID: 218c2fd95ab34211a8a2d29563292645-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=eHyDzzzQzAR6JtKByln/bitPmsMF+K7rggSluh9gcpE=;
        b=D8AL8R5iN87jeN7frLfJS6eNwEoZEtulWZ+lH7fzRJYCZK7RHvRuh5I5pUmT2Vc7LLMYJG+1Kfc1eCmHj/WyicRLUnLUknKy2e7MlkzSqFFP617Wbfx6bj2Q+AtRi7fLAym4ktL3WiVFvIRRrWB4csHqAAB8gk49r6mxwpj86uE=;
X-UUID: 218c2fd95ab34211a8a2d29563292645-20200311
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chaotian.jing@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1635624644; Wed, 11 Mar 2020 10:13:37 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 11 Mar
 2020 10:11:55 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 10:13:03 +0800
Message-ID: <1583892806.24941.7.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
From:   Chaotian Jing <chaotian.jing@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        "Seo, Kyungmin" <kyungmin.seo@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Mar 2020 10:13:26 +0800
In-Reply-To: <CAPDyKFosrju6y5mOKePsNwqgDr=QeBozFTrWKz4MNpsMmeZdCA@mail.gmail.com>
References: <20200212024220.GA32111@seokyung-mobl1>
         <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
         <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
         <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
         <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
         <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
         <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com>
         <CAPDyKFosrju6y5mOKePsNwqgDr=QeBozFTrWKz4MNpsMmeZdCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 9B0AA9BD5B97F94CCFC5924657ABB18489DF020570DF3153483317F51FCDCD392000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTEwIGF0IDE2OjQxICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gVHVlLCAxMCBNYXIgMjAyMCBhdCAxMTo0NCwgQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRl
ckBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gMTAvMDMvMjAgMTE6MDUgYW0sIFVsZiBI
YW5zc29uIHdyb3RlOg0KPiA+ID4gT24gVHVlLCAxMCBNYXIgMjAyMCBhdCAwNToyOCwgU2VvLCBL
eXVuZ21pbiA8a3l1bmdtaW4uc2VvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPj4NCj4gPiA+PiBJ
IHJlYWQgdGhlIGxpbmsgYW5kIHBhdGNoIG9mIENoYW90aWFuIEppbmcuDQo+ID4gPj4gSSBhbHNv
IHBvaW50IG91dCB3aGF0IENoYW90aWFuIHNhaWQuDQo+ID4gPj4gTW9zdCBob3N0IGNvbnRyb2xs
ZXJzIGhhdmUgRExMIHR1bmluZyB2YWx1ZXMgZm9yIGVhY2ggbW9kZS4gV2hlbiBob3N0IGNvbnRy
b2xsZXIgaXMgc2V0IGFzIEhTNDAwIG1vZGUgd2l0aCA1ME1IeiBjbG9jaywgaG9zdCBjb250cm9s
bGVyIHVzZXMgRExMIHZhbHVlIHdoaWNoIGlzIHR1bmVkIHdpdGggMjAwTUh6IGNsb2NrLg0KPiA+
ID4+DQo+ID4gPj4gSWYgRExMIHZhbHVlIGluIEhTNDAwIG1vZGUgZG9lc24ndCBoYXZlIHRoZSBw
YXNzIHJhbmdlIGluIEhTIG1vZGUsIGNvbW1hbmQgdHJhbnNmZXIgZmFpbGluZyBtYXkgZmFpbC4N
Cj4gPiA+PiBJbiBvcmRlciB0byBtYWtlIHJvYnVzdCBzZGhjaSBkcml2ZXIsIEkgdGhpbmsgdGhl
IHBhdGNoIG5lZWRzIHRvIGJlIGNvbnNpZGVyZWQuDQo+ID4gPg0KPiA+ID4gSSBoYXZlLCBidXQg
SSBhbSBub3QgcGlja2luZyBpdCB1cCBpbiBpdHMgY3VycmVudCBmb3JtLg0KPiA+ID4NCj4gPiA+
PiBPZiBjb3Vyc2UsIENNRDYgd2l0aCBIUzQwMCBtb2RlIGFuZCAyMDBNSHogY2xvY2sgc2hvdWxk
IG5vdCBjYXVzZSBhbnkgcHJvYmxlbSBiZWNhdXNlIGl0J3MgY29ycmVjdCBjb25maWd1cmF0aW9u
Lg0KPiA+ID4NCj4gPiA+IFllcywgYnV0IG5vdCBmb3IgYWxsIGNhc2VzLCBhcyBJIHNhaWQgaW4g
bXkgcmVwbHkgaW4gdGhvc2UgZW1haWwtdGhyZWFkcy4NCj4gPiA+DQo+ID4gPiBXaGF0IEkgaGFk
IGluIG1pbmQsIGlzIHRoYXQgSSBJIHRoaW5rIHdlIHNob3VsZCBpbmZvcm0NCj4gPiA+IG1tY19o
czQwMF90b19oczIwMCgpIGFib3V0IHVuZGVyIHdoYXQgc2l0dWF0aW9uIGl0J3MgZ2V0dGluZyBj
YWxsZWQuDQo+ID4gPiBEZXBlbmRpbmcgb24gdGhhdCwgd2Ugc2hvdWxkIGVpdGhlciBkZWNyZWFz
ZSB0aGUgY2xvY2sgcmF0ZSBiZWZvcmUgb3INCj4gPiA+IGFmdGVyIHdlIHNlbmQgdGhlIENNRDYu
DQo+ID4gPg0KPiA+ID4gV291bGQgdGhhdCB3b3JrIGZvciB5b3VyIGNhc2U/DQo+ID4NCj4gPiBV
bGYsIHdvdWxkIHlvdSBjb25zaWRlciBhIG5ldyBjYWxsIGJhY2sgZS5nLg0KPiANCj4gVGhhdCBj
b3VsZCB3b3JrLCBidXQgSSBhbSBub3Qgc3VyZSB3aGF0J3MgYmVzdCwgaG9uZXN0bHkuDQo+IA0K
PiBUaGUgcHJvYmxlbSBtYXkgYmUgZ2VuZXJpYyBvciBpdCBjb3VsZCBiZSBzcGVjaWZpYyB0byBz
b21lIGhvc3QNCj4gY29udHJvbGxlcj8gSSB0aGluayB3ZSBuZWVkIHRvIGFuc3dlciB0aGF0IHF1
ZXN0aW9uIGZpcnN0Lg0KPiANCj4gV2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiBCcg0KPiBVZmZl
DQo+IA0KV2hlbiBzdGFydCB0byBzZW5kIENNRDYgdG8gc3dpdGNoIHRvIEhTIG1vZGUsIGJvdGgg
SG9zdCAmIGVNTUMgZGV2aWNlDQphcmUgd29ya2luZyBvbiBIUzQwMCBtb2RlLCBzbyB0aGUgdGlt
aW5nIHVzZWQgaXMgTVVTVCBhdCBIUzQwMCBtb2RlIGFuZA0KdGhlIGNsb2NrIE1VU1Qga2VlcCBh
dCBjdXJyZW50IGNsb2NrKHVzdWFsbHkgMjAwTWh6KS4gYWZ0ZXIgcmVjZWl2ZWQgdGhlDQpyZXNw
b25zZSBvZiBDTUQ2LCBOZXZlciB1c2UgQ01EMTMgdG8gcG9sbGluZyBjYXJkIHN0YXR1cyBmb3Ig
dGltaW5nDQpzd2l0Y2guIGlmIGhvc3QgaGFzIG9wcy0+Y2FyZF9idXN5KCkgb3IgY2FwcyBXQUlU
X1dISUxFX0JVU1ksIHRoZW4gdXNlDQppdCwgaWYgbm90LGp1c3QgZG8gbW1jX2RlbGF5KCkgZm9y
IHNwZWNpZmljIHRpbWUuDQoNCnRoZSBuZXh0IHN0ZXAgaXMgdGhhdCBjYWxsIG1tY19zZXRfaW9z
KCkgdG8gc2V0IGN1cnJlbnQgdGltaW5nIHRvIEhTDQptb2RlIGFuZCBjbG9jayB0byA1ME1oeiB0
byBsZXQgSG9zdCBkcml2ZXIgdGhhdCBlTU1DIGRldmljZSBoYXMgYmVlbg0Kc3dpdGNoZWQgdG8g
SFMgbW9kZSBhbmQgSG9zdCBjYW4gc3dpdGNoIHRvIEhTIG1vZGUgYXQgNTBNaHoobWF5IGFwcGx5
DQpwYXJhbWV0ZXJzIGZvciB0aGlzIGxvdyBzcGVlZCkuDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvY29yZS9tbWMuYyBiL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMNCj4gPiBpbmRl
eCBjMmFiZDQxN2E4NGEuLjFiYzE4ZmUyNjMyZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21t
Yy9jb3JlL21tYy5jDQo+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9tbWMuYw0KPiA+IEBAIC0x
MjM3LDcgKzEyMzcsMTAgQEAgaW50IG1tY19oczQwMF90b19oczIwMChzdHJ1Y3QgbW1jX2NhcmQg
KmNhcmQpDQo+ID4NCj4gPiAgICAgICAgIC8qIFJlZHVjZSBmcmVxdWVuY3kgdG8gSFMgKi8NCj4g
PiAgICAgICAgIG1heF9kdHIgPSBjYXJkLT5leHRfY3NkLmhzX21heF9kdHI7DQo+ID4gLSAgICAg
ICBtbWNfc2V0X2Nsb2NrKGhvc3QsIG1heF9kdHIpOw0KPiA+ICsgICAgICAgaWYgKGhvc3QtPm9w
cy0+aHM0MDBfdG9faHMyMDBfcHJlcCkNCj4gPiArICAgICAgICAgICAgICAgaG9zdC0+b3BzLT5o
czQwMF90b19oczIwMF9wcmVwKGhvc3QsIG1heF9kdHIpOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+
ICsgICAgICAgICAgICAgICBtbWNfc2V0X2Nsb2NrKGhvc3QsIG1heF9kdHIpOw0KPiA+DQo+ID4g
ICAgICAgICAvKiBTd2l0Y2ggSFM0MDAgdG8gSFMgRERSICovDQo+ID4gICAgICAgICB2YWwgPSBF
WFRfQ1NEX1RJTUlOR19IUzsNCj4gPg0KPiA+DQo+IA0KPiBbLi4uXQ0KPiANCj4gS2luZCByZWdh
cmRzDQo+IFVmZmUNCg0K

