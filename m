Return-Path: <SRS0=dO/k=5E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87903C4332D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEFB20663
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Mar 2020 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="uWEBYFVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgCSMQD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:16:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:25640 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgCSMQD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Mar 2020 08:16:03 -0400
IronPort-SDR: lja7DXNEkPArgVA0YuWHpsRq5J3PBkx6zTiEhQ+uO7hkJlT8sml+LqsSIv4uy/yAp9Sd4LKjQN
 prZZvKmdw2Eg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 05:16:01 -0700
IronPort-SDR: r5u+4ca9kRHTIvQW14LT6LHpFI+mq7vgRifV+/GjCWdHV8yPi+Z2X/i/BbTN5V0NubDBQByKif
 Lx5EqKcmjvQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,571,1574150400"; 
   d="scan'208";a="418322925"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 19 Mar 2020 05:16:01 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 05:16:01 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX111.amr.corp.intel.com (10.22.240.12) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 05:16:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Mar 2020 05:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LagID5k2wEE4I3CD10kvoQ0eJA20HgidbyejThvShUfEKNzVf3H4AVSYslQcgJ43Ccy+PhvekNjF5WDoilGnKCQaKGW9OxtAUmb4s6JuiLim+9hgbuL3VRUT6qFpAIIbFDDevVPBrg3fBtdQLg16W7b57rJXYAci5MO71sgtpG06v4kQwRf5sIyoecfmziurkwXvQQMF5V97vjVtAenVxw1Q0tNlvNKcdOhAtGcVKPvZ4xSuo7gAV27UjPJnEu8auRM7n5mlgAzPj7uTwDShF5l9bDexzIxmlUWJifwKwe0DAPjCipbpwIK1XwDglxTyjMfddq8bv/0/YDjk5M0mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXeVOUFxg195LIevN+cvN/A1lFJ+OQvxkNSt2ubCVwk=;
 b=LL2QOPpZSB+/rbPgU4hBCYA+G86yLVr+cLQJ+AluqNQJyyJxjjRYBHGM0IxqBzpMOshYaHtgpcW9JUKxOmJExRVGA2m5pT4jGAWh5wPuuboc1SfxOfGWGwxY6bmSVeqXqPPFC940v5HQu2+nzwK2llrzX/fOCgBoAconG0fnZA0ES9nmM/CufbMSK2OLQrJ5pLGXp+mwNQY3DmDvV+TMrd2ZKYYaMYrh/19IKLTFMrv+hD1m3DXVDYaOM4StFdZzfPDSFn2F060JRO1NO1VBXtOK9tpz1HqxnweAHY2WtP6Ys5PT4x3ybkmCi4NJtYK1hNJgsuTe47o6KA6SZOO77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XXeVOUFxg195LIevN+cvN/A1lFJ+OQvxkNSt2ubCVwk=;
 b=uWEBYFVFh4FkuNLZmaLeLmrvye8rWov0TaxI6SYF0KgW1nAsZtq1bjGqxA9RPnSvWqGWB+YAUx2dSie6Y9S8EMDxfOPtcU4pRZX/cGG/Fd7Ayio45dFOkZbjm+MRG4ArK8+IAKlKBcLLTDTkG0yEdgJsVuhrzBbtnYfyRayNZeo=
Received: from BN6PR11MB0050.namprd11.prod.outlook.com (2603:10b6:405:68::32)
 by BN6PR11MB4052.namprd11.prod.outlook.com (2603:10b6:405:7a::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Thu, 19 Mar
 2020 12:15:59 +0000
Received: from BN6PR11MB0050.namprd11.prod.outlook.com
 ([fe80::2c23:377c:4765:e7f2]) by BN6PR11MB0050.namprd11.prod.outlook.com
 ([fe80::2c23:377c:4765:e7f2%7]) with mapi id 15.20.2835.017; Thu, 19 Mar 2020
 12:15:58 +0000
From:   "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: mmc: arasan: Add compatible strings for
 Intel Keem Bay
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: arasan: Add compatible strings for
 Intel Keem Bay
Thread-Index: AQHV+3NDyg/HWRDk3UOrAcVTkRdq4ahONBsAgAGi3fA=
Date:   Thu, 19 Mar 2020 12:15:58 +0000
Message-ID: <BN6PR11MB0050B32D3A0A1ABCE1FCE88DDDF40@BN6PR11MB0050.namprd11.prod.outlook.com>
References: <20200316091324.15968-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200316091324.15968-2-wan.ahmad.zainie.wan.mohamad@intel.com>
 <CAPDyKFqpeCXqbMZi7cffKEQ1=2xZnUT4Jpi85Fqyfk2eaTU1gQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqpeCXqbMZi7cffKEQ1=2xZnUT4Jpi85Fqyfk2eaTU1gQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wan.ahmad.zainie.wan.mohamad@intel.com; 
x-originating-ip: [192.198.147.223]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35e9ef48-236c-4b25-0a58-08d7cbff4883
x-ms-traffictypediagnostic: BN6PR11MB4052:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB40523A4FD57719B6C576043BDDF40@BN6PR11MB4052.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0347410860
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(396003)(39860400002)(346002)(366004)(199004)(8676002)(4326008)(9686003)(55016002)(54906003)(86362001)(7696005)(316002)(186003)(26005)(5660300002)(6506007)(53546011)(66446008)(66556008)(66946007)(478600001)(52536014)(76116006)(81156014)(64756008)(2906002)(33656002)(71200400001)(81166006)(6916009)(8936002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR11MB4052;H:BN6PR11MB0050.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: deTvNTtLRWXFS3Uve3q2OIpoSb60WbKKCGEw/E9pXzOA8wu/Q10mz4xK3z4MKO4Xi7/k4KpziF4n4ePP8CCfSVgYiaUXL74jQ/zb3zhx9O8k5ypINwbpYEyHUTocx2pn7/C8iyZRD/jLkt/VVNIM5+PW36J+v5E9VciT//e4dafmq2hyU6ESx8r1wr2NJujyV/iXq5ISLO0HR/qvnaa5Aj779vXYxo54xAmY/0SJBojzJdKdP2KH8qQTy/qJjBBl1losYQvUv6sDIGUcKOzIDdOxrvRZTH7eLWtVM8rtn3RmJnQOpQpq670ZOxeQlkcFhyC13tylOocEmEDSE4O0ks2Y/WxzX916Dgl8FyAEh4Whk2xgev4AugQNZv2eKkY49aOVrpyF2VSijPR9tBhtaxJG5NYP+WAPZkdn6Qv/2kq7Z5M7FK6DLU30KKQrC29l
x-ms-exchange-antispam-messagedata: RuwEY7Fz4vsKkDxJmCDA0nH/gr3r3cidLPAg+l/PcHpllxzedSzYgKvQIDnufoLAZ4HSNC3FqnKJKvgvVAtBgOym9F6C7L0m9jNyhG9bHdb3VeaswosPZraY+WDPVJqQ6Q0N2UMa2aGj0Q4Mq7bICA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e9ef48-236c-4b25-0a58-08d7cbff4883
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2020 12:15:58.9491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A26ELi1w411x3stvBQ9SnGJD+jCGa2gQGrWQ2CCIzt/QQ6vi33uYybXrkicsrFJk/4uiZHHRIB9Rbh2GkEwxtdU8Q0O39M3KJHaoJ7WOx/DgrO5xCS1zGXu8QXWHFdTe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4052
X-OriginatorOrg: intel.com
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMTgsIDIwMjAg
NzowOCBQTQ0KPiBUbzogV2FuIE1vaGFtYWQsIFdhbiBBaG1hZCBaYWluaWUNCj4gPHdhbi5haG1h
ZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPg0KPiBDYzogUm9iIEhlcnJpbmcgPHJvYmgr
ZHRAa2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZA0KPiA8bWFyay5ydXRsYW5kQGFybS5jb20+OyBI
dW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+Ow0KPiBsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnOyBEVE1MIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBtbWM6IGFyYXNhbjogQWRkIGNvbXBhdGli
bGUgc3RyaW5ncw0KPiBmb3IgSW50ZWwgS2VlbSBCYXkNCj4gDQo+IE9uIE1vbiwgMTYgTWFyIDIw
MjAgYXQgMTA6MTMsIFdhbiBBaG1hZCBaYWluaWUNCj4gPHdhbi5haG1hZC56YWluaWUud2FuLm1v
aGFtYWRAaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBuZXcgY29tcGF0aWJsZSBzdHJp
bmdzIGluIHNkaGNpLW9mLWFyYXNhbi5jIHRvIHN1cHBvcnQgSW50ZWwgS2VlbQ0KPiA+IEJheSBl
TU1DL1NEL1NESU8gY29udHJvbGxlciwgYmFzZWQgb24gQXJhc2FuIFNESENJIDUuMS4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IFdhbiBBaG1hZCBaYWluaWUNCj4gPiA8d2FuLmFobWFkLnphaW5p
ZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9hcmFzYW4sc2RoY2kudHh0ICB8IDM5DQo+ID4gKysrKysrKysrKysrKysrKysr
Kw0KPiANCj4gV2UgYXJlIHN0YXJ0aW5nIHRvIHJlYWNoIGEgcG9pbnQgd2VyZSBJIHdhbnQgdG8g
c2VlIHBlb3BsZSBjb252ZXJ0aW5nDQo+IGJpbmRpbmdzIGludG8gdGhlIHlhbWwgZm9ybWF0LCBy
YXRoZXIgdGhhbiBleHRlbmRpbmcgdGhlIGV4aXN0aW5nIHRleHQgYmFzZWQNCj4gb25lcy4NCj4g
DQo+IENhbiB5b3UgcGxlYXNlIGhhdmUgYSBsb29rIGF0IHRoZSBzZGhjaSBjb21tb24gYmluZGlu
Z3MgYW5kIHRoZSBzZGhjaQ0KPiBhcmFzYW4gdmFyaWFudCwgdGhhdCB3b3VsZCBiZSBhIGdvb2Qg
c3RhcnQuDQoNClllcywgSSBjYW4gc3RhcnQgYnkgY29udmVydGluZyBhcmFzYW4sc2RoY2kudHh0
Lg0KDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDM5IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvbW1jL2FyYXNhbixzZGhjaS50eHQNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dA0KPiA+IGluZGV4IDQy
ODY4NWViMmRlZC4uNTBmOWNjMGVmZjJhIDEwMDY0NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvYXJhc2FuLHNkaGNpLnR4dA0KPiA+IEBA
IC0yNCw2ICsyNCwxMCBAQCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KPiA+ICAgICAgICBGb3IgdGhp
cyBkZXZpY2UgaXQgaXMgc3Ryb25nbHkgc3VnZ2VzdGVkIHRvIGluY2x1ZGUgYXJhc2FuLHNvYy1j
dGwtc3lzY29uLg0KPiA+ICAgICAgLSAiaW50ZWwsbGdtLXNkaGNpLTUuMS1zZHhjIiwgImFyYXNh
bixzZGhjaS01LjEiOiBJbnRlbCBMR00gU0RYQyBQSFkNCj4gPiAgICAgICAgRm9yIHRoaXMgZGV2
aWNlIGl0IGlzIHN0cm9uZ2x5IHN1Z2dlc3RlZCB0byBpbmNsdWRlIGFyYXNhbixzb2MtY3RsLXN5
c2Nvbi4NCj4gPiArICAgIC0gImludGVsLGtlZW1iYXktc2RoY2ktNS4xLWVtbWMiLCAiYXJhc2Fu
LHNkaGNpLTUuMSI6IEtlZW0gQmF5DQo+IGVNTUMgUEhZDQo+ID4gKyAgICAgIEZvciB0aGlzIGRl
dmljZSBpdCBpcyBzdHJvbmdseSBzdWdnZXN0ZWQgdG8gaW5jbHVkZSBhcmFzYW4sc29jLWN0bC1z
eXNjb24uDQo+ID4gKyAgICAtICJpbnRlbCxrZWVtYmF5LXNkaGNpLTUuMS1zZCI6IEtlZW0gQmF5
IFNEIGNvbnRyb2xsZXINCj4gPiArICAgIC0gImludGVsLGtlZW1iYXktc2RoY2ktNS4xLXNkaW8i
OiBLZWVtIEJheSBTRElPIGNvbnRyb2xsZXINCj4gPg0KPiA+ICAgIFs1XSBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3NkaGNpLWFtNjU0LnR4dA0KPiA+DQo+ID4gQEAgLTEz
MywzICsxMzcsMzggQEAgRXhhbXBsZToNCj4gPiAgICAgICAgICAgICAgICAgcGh5LW5hbWVzID0g
InBoeV9hcmFzYW4iOw0KPiA+ICAgICAgICAgICAgICAgICBhcmFzYW4sc29jLWN0bC1zeXNjb24g
PSA8JnN5c2NvbmY+Ow0KPiA+ICAgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICBtbWM6IG1t
Y0AzMzAwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaW50ZWwsa2Vl
bWJheS1zZGhjaS01LjEtZW1tYyIsICJhcmFzYW4sc2RoY2ktNS4xIjsNCj4gPiArICAgICAgICAg
ICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDgyIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+
ICsgICAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MzMwMDAwMDAgMHgwIDB4MzAwPjsNCj4gPiAr
ICAgICAgICAgICAgICAgY2xvY2stbmFtZXMgPSAiY2xrX3hpbiIsICJjbGtfYWhiIjsNCj4gPiAr
ICAgICAgICAgICAgICAgY2xvY2tzID0gPCZzY21pX2NsayBLRUVNX0JBWV9QU1NfQVVYX0VNTUM+
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICA8JnNjbWlfY2xrIEtFRU1fQkFZX1BTU19F
TU1DPjsNCj4gPiArICAgICAgICAgICAgICAgcGh5cyA9IDwmZW1tY19waHk+Ow0KPiA+ICsgICAg
ICAgICAgICAgICBwaHktbmFtZXMgPSAicGh5X2FyYXNhbiI7DQo+ID4gKyAgICAgICAgICAgICAg
IGFzc2lnbmVkLWNsb2NrcyA9IDwmc2NtaV9jbGsgS0VFTV9CQVlfUFNTX0FVWF9FTU1DPjsNCj4g
PiArICAgICAgICAgICAgICAgY2xvY2stb3V0cHV0LW5hbWVzID0gImVtbWNfY2FyZGNsb2NrIjsN
Cj4gPiArICAgICAgICAgICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgICAgICAg
ICAgICBhcmFzYW4sc29jLWN0bC1zeXNjb24gPSA8Jm1tY19waHlfc3lzY29uPjsNCj4gPiArICAg
ICAgIH07DQo+ID4gKw0KPiA+ICsgICAgICAgc2QwOiBzZGhjaUAzMTAwMDAwMCB7DQo+ID4gKyAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiaW50ZWwsa2VlbWJheS1zZGhjaS01LjEtc2QiOw0K
PiA+ICsgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgODMgSVJRX1RZUEVfTEVW
RUxfSElHSD47DQo+ID4gKyAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgzMTAwMDAwMCAweDAg
MHgzMDA+Ow0KPiA+ICsgICAgICAgICAgICAgICBjbG9jay1uYW1lcyA9ICJjbGtfeGluIiwgImNs
a19haGIiOw0KPiA+ICsgICAgICAgICAgICAgICBjbG9ja3MgPSA8JnNjbWlfY2xrIEtFRU1fQkFZ
X1BTU19BVVhfU0QwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgPCZzY21pX2NsayBL
RUVNX0JBWV9QU1NfU0QwPjsNCj4gPiArICAgICAgICAgICAgICAgYXJhc2FuLHNvYy1jdGwtc3lz
Y29uID0gPCZzZDBfcGh5X3N5c2Nvbj47DQo+ID4gKyAgICAgICB9Ow0KPiA+ICsNCj4gPiArICAg
ICAgIHNkMTogc2RoY2lAMzIwMDAwMDAgew0KPiA+ICsgICAgICAgICAgICAgICBjb21wYXRpYmxl
ID0gImludGVsLGtlZW1iYXktc2RoY2ktNS4xLXNkaW8iOw0KPiA+ICsgICAgICAgICAgICAgICBp
bnRlcnJ1cHRzID0gPEdJQ19TUEkgODQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAg
ICAgICAgICAgIHJlZyA9IDwweDAgMHgzMjAwMDAwMCAweDAgMHgzMDA+Ow0KPiA+ICsgICAgICAg
ICAgICAgICBjbG9jay1uYW1lcyA9ICJjbGtfeGluIiwgImNsa19haGIiOw0KPiA+ICsgICAgICAg
ICAgICAgICBjbG9ja3MgPSA8JnNjbWlfY2xrIEtFRU1fQkFZX1BTU19BVVhfU0QxPiwNCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgPCZzY21pX2NsayBLRUVNX0JBWV9QU1NfU0QxPjsNCj4g
PiArICAgICAgICAgICAgICAgYXJhc2FuLHNvYy1jdGwtc3lzY29uID0gPCZzZDFfcGh5X3N5c2Nv
bj47DQo+ID4gKyAgICAgICB9Ow0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
