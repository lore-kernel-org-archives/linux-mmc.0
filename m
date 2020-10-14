Return-Path: <SRS0=DFdp=DV=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855BC433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 02:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DA721D81
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Oct 2020 02:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XshiTFUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgJNC3G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 22:29:06 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:61302 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726120AbgJNC3G (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 22:29:06 -0400
X-UUID: f8b928caf53c4b9f816c5b72a857c7ee-20201014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=86OsRMMbYlWcUWN23W9NddA6ngFDdGK9EuPCIrIysn8=;
        b=XshiTFUN3XBYADa3ihYOxO4edxF77hPRWlu0DNiPapZ+I51vZHI0pkvsVOGXHiCY/dg9DZgZ47pDSBYByDZiFAJ4KCbTRlUvkeK4TEXsukCZroXr78ERNzqmUe7tAYEv+i5lBeOcWvFln6taEKUuJWfGDw2VTla0Rdw7KMLe3bk=;
X-UUID: f8b928caf53c4b9f816c5b72a857c7ee-20201014
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1418329566; Wed, 14 Oct 2020 10:28:52 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 14 Oct
 2020 10:28:50 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Oct 2020 10:28:50 +0800
Message-ID: <1602642530.11864.3.camel@mhfsdcap03>
Subject: Re: [PATCH v6 4/4] mmc: mediatek: Add subsys clock control for
 MT8192 msdc
From:   Wenbin Mei <wenbin.mei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 14 Oct 2020 10:28:50 +0800
In-Reply-To: <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
References: <20201012124547.16649-1-wenbin.mei@mediatek.com>
         <20201012124547.16649-5-wenbin.mei@mediatek.com>
         <72ae1d89-fe31-4f50-15c0-29119d662ea1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EA5C87158EF05DF46265A81A6E9FE3CD459D96D9A1D5B523820C9EA2686636C02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAyMDIwLTEwLTEzIGF0IDE3OjEwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTIvMTAvMjAyMCAxNDo0NSwgV2VuYmluIE1laSB3cm90ZToNCj4gPiBNVDgx
OTIgbXNkYyBpcyBhbiBpbmRlcGVuZGVudCBzdWIgc3lzdGVtLCB3ZSBuZWVkIGNvbnRyb2wgbW9y
ZSBidXMNCj4gPiBjbG9ja3MgZm9yIGl0Lg0KPiA+IEFkZCBzdXBwb3J0IGZvciB0aGUgYWRkaXRp
b25hbCBzdWJzeXMgY2xvY2tzIHRvIGFsbG93IGl0IHRvIGJlDQo+ID4gY29uZmlndXJlZCBhcHBy
b3ByaWF0ZWx5Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlbmJpbiBNZWkgPHdlbmJpbi5t
ZWlAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tbWMvaG9zdC9tdGstc2Qu
YyB8IDc0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiA+ICAgMSBm
aWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9z
dC9tdGstc2QuYw0KPiA+IGluZGV4IGE3MDQ3NDVlNTg4Mi4uYzdkZjc1MTBmMTIwIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNkLmMNCj4gPiArKysgYi9kcml2ZXJzL21t
Yy9ob3N0L210ay1zZC5jDQo+IFsuLi5dDQo+ID4gK3N0YXRpYyBpbnQgbXNkY19vZl9jbG9ja19w
YXJzZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkgICAgICAgc3RydWN0
IG1zZGNfaG9zdCAqaG9zdCkNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlo
b3N0LT5zcmNfY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJzb3VyY2UiKTsNCj4gPiAr
CWlmIChJU19FUlIoaG9zdC0+c3JjX2NsaykpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoaG9zdC0+
c3JjX2Nsayk7DQo+ID4gKw0KPiA+ICsJaG9zdC0+aF9jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYt
PmRldiwgImhjbGsiKTsNCj4gPiArCWlmIChJU19FUlIoaG9zdC0+aF9jbGspKQ0KPiA+ICsJCXJl
dHVybiBQVFJfRVJSKGhvc3QtPmhfY2xrKTsNCj4gPiArDQo+ID4gKwlob3N0LT5idXNfY2xrID0g
ZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5kZXYsICJidXNfY2xrIik7DQo+ID4gKwlpZiAo
SVNfRVJSKGhvc3QtPmJ1c19jbGspKQ0KPiA+ICsJCWhvc3QtPmJ1c19jbGsgPSBOVUxMOw0KPiA+
ICsNCj4gPiArCS8qc291cmNlIGNsb2NrIGNvbnRyb2wgZ2F0ZSBpcyBvcHRpb25hbCBjbG9jayov
DQo+ID4gKwlob3N0LT5zcmNfY2xrX2NnID0gZGV2bV9jbGtfZ2V0X29wdGlvbmFsKCZwZGV2LT5k
ZXYsICJzb3VyY2VfY2ciKTsNCj4gPiArCWlmIChJU19FUlIoaG9zdC0+c3JjX2Nsa19jZykpDQo+
ID4gKwkJaG9zdC0+c3JjX2Nsa19jZyA9IE5VTEw7DQo+ID4gKw0KPiA+ICsJaG9zdC0+c3lzX2Ns
a19jZyA9IGRldm1fY2xrX2dldF9vcHRpb25hbCgmcGRldi0+ZGV2LCAic3lzX2NnIik7DQo+ID4g
KwlpZiAoSVNfRVJSKGhvc3QtPnN5c19jbGtfY2cpKQ0KPiA+ICsJCWhvc3QtPnN5c19jbGtfY2cg
PSBOVUxMOw0KPiA+ICsNCj4gPiArCS8qIElmIHByZXNlbnQsIGFsd2F5cyBlbmFibGUgZm9yIHRo
aXMgY2xvY2sgZ2F0ZSAqLw0KPiA+ICsJY2xrX3ByZXBhcmVfZW5hYmxlKGhvc3QtPnN5c19jbGtf
Y2cpOw0KPiA+ICsNCj4gPiArCWhvc3QtPmJ1bGtfY2xrc1swXS5pZCA9ICJwY2xrX2NnIjsNCj4g
PiArCWhvc3QtPmJ1bGtfY2xrc1sxXS5pZCA9ICJheGlfY2ciOw0KPiA+ICsJaG9zdC0+YnVsa19j
bGtzWzJdLmlkID0gImFoYl9jZyI7DQo+IA0KPiBUaGF0IGxvb2tzIGF0IGxlYXN0IHN1c3BpY2lv
dXMuIFRoZSBwb2ludGVycyBvZiBpZCBwb2ludCB0byBzb21lIHN0cmluZ3MgZGVmaW5lZCANCj4g
aW4gdGhlIGZ1bmN0aW9uLiBBcmVuJ3QgdGhleSBvdXQgb2Ygc2NvcGUgb25jZSBtc2RjX29mX2Ns
b2NrX3BhcnNlKCkgaGFzIHJldHVybmVkPw0KPiANClRoZXNlIGNvbnN0YW50cyBhcmUgbm90IGlu
IHN0YWNrIHJhbmdlLCBzbyB0aGV5IHdpbGwgbm90IGJlIGxvc3QuDQpBbmQgSSBoYXZlIGNvbmZp
cm1lZCBpdCBhZnRlciBtc2RjX29mX2Nsb2NrX3BhcnNlKCkgaGFzIHJldHVybmVkLCB0aGVzZQ0K
aWRzIHN0aWxsIGV4aXN0Lg0KDQo+IFJlZ2FyZHMsDQo+IE1hdHRoaWFzDQoNCg==

