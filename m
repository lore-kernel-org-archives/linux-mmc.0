Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39938C2D0E4
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 01:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD34D20DD4
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Nov 2020 01:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="qIaUjWVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgKYBLI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 20:11:08 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4163 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727771AbgKYBLI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 20:11:08 -0500
X-UUID: fc41a31c1a234de58e1ccec4b1de961b-20201125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zD9PnRSDQkta5y5sYo0Myaz8oC9QbODb/1/hmrtOsFo=;
        b=qIaUjWVq4nUIkNiohHGbdTY+G8hI3xCXqGp46//yzaclqEWFABHi93KzjWnVIZr1WctGi6DxYtFCENOQjZ6pYO6zWvxC4YGp4NWrf6Gg7bIviCZcg03HW4l1ChPJW6lL4UBJSW5NapJk3KSqCqc9oUcoW2PlzGUJe+8n44tfwVY=;
X-UUID: fc41a31c1a234de58e1ccec4b1de961b-20201125
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2077199661; Wed, 25 Nov 2020 09:11:01 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Nov
 2020 09:10:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 Nov 2020 09:10:55 +0800
Message-ID: <1606266655.11864.7.camel@mhfsdcap03>
Subject: Re: [PATCH] mmc: mediatek: Add system suspend/resume interface
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 25 Nov 2020 09:10:55 +0800
In-Reply-To: <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com>
References: <20201118063405.24906-1-wenbin.mei@mediatek.com>
         <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E0BA17202977CDA0ADCBF4E0D56DAFAAA7974C1D3AD563521464216FB75063672000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTIzIGF0IDE3OjA2ICswMTAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
T24gV2VkLCAxOCBOb3YgMjAyMCBhdCAwNzozNCwgV2VuYmluIE1laSA8d2VuYmluLm1laUBtZWRp
YXRlay5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQmVmb3JlIHdlIGdvdCB0aGVzZSBlcnJvcnMgb24g
TVQ4MTkyIHBsYXRmb3JtOg0KPiA+IFsgICA1OS4xNTM4OTFdIFJlc3RhcnRpbmcgdGFza3MgLi4u
DQo+ID4gWyAgIDU5LjE1NDU0MF0gZG9uZS4NCj4gPiBbICAgNTkuMTU5MTc1XSBQTTogc3VzcGVu
ZCBleGl0DQo+ID4gWyAgIDU5LjIxODcyNF0gbXRrLW1zZGMgMTFmNjAwMDAubW1jOiBwaGFzZTog
W21hcDpmZmZmZmZmZV0gW21heGxlbjozMV0NCj4gPiBbZmluYWw6MTZdDQo+ID4gWyAgMTE5Ljc3
NjA4M10gbW1jMDogY3FoY2k6IHRpbWVvdXQgZm9yIHRhZyA5DQo+ID4gWyAgMTE5Ljc4MDE5Nl0g
bW1jMDogY3FoY2k6ID09PT09PT09PT09PSBDUUhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09
DQo+ID4gWyAgMTE5Ljc4NjcwOV0gbW1jMDogY3FoY2k6IENhcHM6ICAgICAgMHgxMDAwMjBiNiB8
IFZlcnNpb246ICAweDAwMDAwNTEwDQo+ID4gWyAgMTE5Ljc5MzIyNV0gbW1jMDogY3FoY2k6IENv
bmZpZzogICAgMHgwMDAwMDEwMSB8IENvbnRyb2w6ICAweDAwMDAwMDAwDQo+ID4gWyAgMTE5Ljc5
OTcwNl0gbW1jMDogY3FoY2k6IEludCBzdGF0OiAgMHgwMDAwMDAwMCB8IEludCBlbmFiOiAweDAw
MDAwMDAwDQo+ID4gWyAgMTE5LjgwNjE3N10gbW1jMDogY3FoY2k6IEludCBzaWc6ICAgMHgwMDAw
MDAwMCB8IEludCBDb2FsOiAweDAwMDAwMDAwDQo+ID4gWyAgMTE5LjgxMjY3MF0gbW1jMDogY3Fo
Y2k6IFRETCBiYXNlOiAgMHgwMDAwMDAwMCB8IFRETCB1cDMyOiAweDAwMDAwMDAwDQo+ID4gWyAg
MTE5LjgxOTE0OV0gbW1jMDogY3FoY2k6IERvb3JiZWxsOiAgMHgwMDNmZmMwMCB8IFRDTjogICAg
ICAweDAwMDAwMjAwDQo+ID4gWyAgMTE5LjgyNTY1Nl0gbW1jMDogY3FoY2k6IERldiBxdWV1ZTog
MHgwMDAwMDAwMCB8IERldiBQZW5kOiAweDAwMDAwMDAwDQo+ID4gWyAgMTE5LjgzMjE1NV0gbW1j
MDogY3FoY2k6IFRhc2sgY2xyOiAgMHgwMDAwMDAwMCB8IFNTQzE6ICAgICAweDAwMDAxMDAwDQo+
ID4gWyAgMTE5LjgzODYyN10gbW1jMDogY3FoY2k6IFNTQzI6ICAgICAgMHgwMDAwMDAwMCB8IERD
TUQgcnNwOiAweDAwMDAwMDAwDQo+ID4gWyAgMTE5Ljg0NTE3NF0gbW1jMDogY3FoY2k6IFJFRCBt
YXNrOiAgMHhmZGY5YTA4MCB8IFRFUlJJOiAgICAweDAwMDA4OTFjDQo+ID4gWyAgMTE5Ljg1MTY1
NF0gbW1jMDogY3FoY2k6IFJlc3AgaWR4OiAgMHgwMDAwMDAwMCB8IFJlc3AgYXJnOiAweDAwMDAw
MDAwDQo+ID4gWyAgMTE5Ljg2NTc3M10gbW1jMDogY3FoY2k6IDogPT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiA+IFsgIDExOS44NzIzNThdIG1tYzA6IHJ1bm5p
bmcgQ1FFIHJlY292ZXJ5DQo+ID4gRnJvbSB0aGVzZSBsb2dzLCB3ZSBmb3VuZCBUREwgYmFzZSB3
YXMgYmFjayB0byB0aGUgZGVmYXVsdCB2YWx1ZS4NCj4gPg0KPiA+IEFmdGVyIHN1c3BlbmQsIHRo
ZSBtbWMgaG9zdCBpcyBwb3dlcmVkIG9mZiBieSBIVywgYW5kIGJyaW5nIENRRSByZWdpc3Rlcg0K
PiA+IHRvIHRoZSBkZWZhdWx0IHZhbHVlLCBzbyB3ZSBhZGQgc3lzdGVtIHN1c3BlbmQvcmVzdW1l
IGludGVyZmFjZSwgdGhlbiBicmluZw0KPiA+IENRRSB0byBkZWFjdGl2YXRlZCBzdGF0ZSBiZWZv
cmUgc3VzcGVuZCwgaXQgd2lsbCBiZSBlbmFibGVkIGJ5IENRRSBmaXJzdA0KPiA+IHJlcXVlc3Qg
YWZ0ZXIgcmVzdW1lLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmlu
Lm1laUBtZWRpYXRlay5jb20+DQo+IA0KPiBJIHRvb2sgdGhlIGxpYmVydHkgb2YgcmVuYW1pbmcg
bXNkY19zeXNfc3VzcGVuZHxyZXN1bWUgdG8NCj4gbXNkY19zdXNwZW5kfHJlc3VtZSwgYXMgSSB0
aGluayB0aGUgIl9zeXMiIGlzIGEgYml0IHN1cGVyZmx1b3VzLg0KPiANCj4gQWRkaXRpb25hbGx5
LCBJIGFkZGVkIGEgZml4ZXMrc3RhYmxlIHRhZywgdGhlbiBJIGFwcGxpZWQgdGhpcyBmb3IgZml4
ZXMsIHRoYW5rcyENCj4gDQo+IFBsZWFzZSB0ZWxsIG1lLCBpZiB0aGVyZSBpcyBhbnl0aGluZyB5
b3Ugd291bGQgbGlrZSBtZSB0byBjaGFuZ2UuDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0K
PiANCj4gSXQgaXMgT0sgZm9yIG1lLCB0aGFua3MgZm9yIHlvdXIgaGVscC4NCg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgMjIgKysrKysrKysrKysrKysrKysrKyst
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVy
cy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+IGluZGV4IGZjNWVlNWRmOTFhZC4uYzVmOWNkNmZjOTUx
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysgYi9k
cml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gQEAgLTI3NTgsMTEgKzI3NTgsMjkgQEAgc3Rh
dGljIGludCBtc2RjX3J1bnRpbWVfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgICAg
ICAgIG1zZGNfcmVzdG9yZV9yZWcoaG9zdCk7DQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4gPiAg
fQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBtc2RjX3N5c19zdXNwZW5kKHN0cnVjdCBkZXZpY2Ug
KmRldikNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG1tY19ob3N0ICptbWMgPSBkZXZfZ2V0
X2RydmRhdGEoZGV2KTsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAg
aWYgKG1tYy0+Y2FwczIgJiBNTUNfQ0FQMl9DUUUpIHsNCj4gPiArICAgICAgICAgICAgICAgcmV0
ID0gY3FoY2lfc3VzcGVuZChtbWMpOw0KPiA+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4g
Kw0KPiA+ICsgICAgICAgcmV0dXJuIHBtX3J1bnRpbWVfZm9yY2Vfc3VzcGVuZChkZXYpOw0KPiA+
ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IG1zZGNfc3lzX3Jlc3VtZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpDQo+ID4gK3sNCj4gPiArICAgICAgIHJldHVybiBwbV9ydW50aW1lX2ZvcmNlX3Jlc3Vt
ZShkZXYpOw0KPiA+ICt9DQo+ID4gICNlbmRpZg0KPiA+DQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZGV2X3BtX29wcyBtc2RjX2Rldl9wbV9vcHMgPSB7DQo+ID4gLSAgICAgICBTRVRfU1lTVEVN
X1NMRUVQX1BNX09QUyhwbV9ydW50aW1lX2ZvcmNlX3N1c3BlbmQsDQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZSkNCj4gPiArICAgICAg
IFNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKG1zZGNfc3lzX3N1c3BlbmQsIG1zZGNfc3lzX3Jlc3Vt
ZSkNCj4gPiAgICAgICAgIFNFVF9SVU5USU1FX1BNX09QUyhtc2RjX3J1bnRpbWVfc3VzcGVuZCwg
bXNkY19ydW50aW1lX3Jlc3VtZSwgTlVMTCkNCj4gPiAgfTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4x
OC4wDQo+ID4NCg0K

