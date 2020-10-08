Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB30BC433DF
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 17:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C23B221FF
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 17:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="W9pYsw5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgJHRVi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 13:21:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:57525 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731937AbgJHRVh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 13:21:37 -0400
IronPort-SDR: mZQsoq++HRr5mSdVLJK1V0B7z30zy71PykukoSkTprxWOGFdtpwezjKsSfC+A3CJMQnXLcD6t9
 zpVvpeUCu7gQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9768"; a="229561625"
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="229561625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 10:21:36 -0700
IronPort-SDR: o7AFRgOpDA7dJ4HjuN7/weblczsdG11ooOr21YZb+JAmteKu463Adlr8DzQjGZoKOhDuJlozen
 1e81k6Mfb3dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,351,1596524400"; 
   d="scan'208";a="343494237"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2020 10:21:36 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 10:21:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 10:21:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 10:21:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 10:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHEN4JEKsyv2KBj6Npy6dHeb+gZb10x2iIONFOKYRXGZm1BzoF+1PUb214s3x9pV5B5YHObWkIhVn+RWz3os7hi21gyHuM5vnxPmyLgI0e4QyayBttFdV0mpFRFWyyg/JwJ7jCK3hHuKB2dfEfmJ8qlsSBxuvsEjDzhyaftE3ncIARMPkfs+b4wxwjYbsw4yTdbKlEz/QFw3ke26H9i9BJUmunkgpA5u/cHw5PEVW7xUdTqU3ZLZvdIBJ1KkbqR2AiM+0l1vOJSoNvmuSvHZwWyR8ghfCSqT1hpWGKt9Aks7zsnOHxxQ5+A5FW2VBim2rF9jJBLE9bnsviUSbxsNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzhemOUI2IvnO/kxfXG9H6d0nJQ4Pcg/5CG9Y8pukh0=;
 b=Xg3Bg00Jr5BtfOaiBAGJqAsIKRif76Zrbe3wqBiwxxUKsfVjdecJpghWIrfNVpd62tx/jPhRbaSKTcnQ7OtdznXsL/6IvYSvJKHIr0WBi3KLjehuH5eWHBmJrbRLUM3DXi9NQmbdZlfWZiyvwWMav9ASMg8uryCQTNO0w4ks1Vix0wf2wx6CUMnji2dDkWXx9FdDkWpwUXQFAVhF6R8TysrPwmZ5fFZbdjVYDb4oOpdOzHiie3tE5NgSwI8Ark+oQLXFac7ZdgCavBh7oyre+BsCuIwBFn2Iza5raEcm8Zg/JDF0PSXMKiCZc9P9tpl0DysZlsbbl2xav+YRi5LQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzhemOUI2IvnO/kxfXG9H6d0nJQ4Pcg/5CG9Y8pukh0=;
 b=W9pYsw5veRtILhZP/v1GcNq6Z6cK7hiciO0god3Pz0dOjwSEcXDeN8FilzAknVWJevgSJ2TccrVATQDnIYpEkIWsof64Z/CgrheWsTosIaqZQ4lagNUffDpmJyORgf/2wWUo9DWGIw0PNDAGAjljywFtKvGVrA+xd2zCioFz0vg=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2874.namprd11.prod.outlook.com (2603:10b6:5:c9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Thu, 8 Oct 2020 17:21:30 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 17:21:29 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v4 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWnRiQsJ+XebQSo0uGE+XglmG5+KmNcEsAgAAYHQCAAEouAIAAIK+w
Date:   Thu, 8 Oct 2020 17:21:29 +0000
Message-ID: <DM6PR11MB28761F10936FF0D2695FAF19B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-5-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFpUv8yeVrWVLRKvz4eKsSDdk0y4dKY2mYs07zpA2UqNdw@mail.gmail.com>
 <DM6PR11MB28764EC5E1F89D417D700F29B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
In-Reply-To: <CAPDyKFptgKG8uvKUkN56sooFL4xqaBcNdbpo645xRQqPOH4BkQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1355780c-9f74-4973-0b42-08d86bae9881
x-ms-traffictypediagnostic: DM6PR11MB2874:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2874269D6BEEC74B631E55D0B80B0@DM6PR11MB2874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tdQ8tNrMrvng5S0dj0w+d+OMFJqA64nc0xge/yXVQMSlsqKYs5keWotiCfvpvZwI8eZFAjgLaShTr9veXnVx1YvI94CNHf+HCHC51L7XbJTjnpAk+eVZhuUtksG2LCMTlQDdI0RlUq0n3tLNokYGQfOivzrTgTv2qHa1382WzOJ3vhEsgNbUAi9Xr4FDzJIeRYhj3a2A8XJDjCsJGWFIOlQw+DhdwDn3LOSINALZbGCxTNEpqQsaOY6O0+Hez7y+wuDRoiiTfMOVpZETHrv/hRtm0aSb2FqAwA0j78CNf6PQCTjeU2RSlzaKfcg/TnS53PVdt5KsPHyUX68h6rgO+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(8676002)(9686003)(55016002)(6916009)(66556008)(71200400001)(66446008)(186003)(64756008)(83380400001)(54906003)(66946007)(66476007)(478600001)(6506007)(5660300002)(52536014)(76116006)(8936002)(316002)(26005)(4326008)(7696005)(33656002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gGcx6JCc5UO0m2JK3mf6ufGNsxHXyHbAmL1qczX2i+3EL+7TgPkpv7iU5D4PP8nJrTaxRzCwQ0xBseUXfKdFY7Unk3aRTn+wFwdh71I/RLM5vPeh94w/FfEmONtiWnyta1m2R6x1LHEpP6V8OG2bA9x5NrG80CPr7pf/cK56R5CpjR1jil033Z1C7iZTCHecv82y1GC7BbmTbwmPzAk2xp9NVCPv0cCS5nPlbNnbE8IWNmkB7kkBv3G00ugoeHxCpQFEfc/RFT/DWacquvhdJ9EGzihT4IuFdOm966hvMLDetrhmM0NRRfdtdjAsf2K3mKgcmgQetRhm0OsEtHduGHVShP7QES6/+88NDIqEB02oJUSGq6mra/OxL2BvLP+91rSm4D1tKXVIlr8lFBlgrLgvt5clJ8BuJVIjxkh3ajgdrChTtyYAJchsDE+IrR5Txnkbsp1eF5Dj+FnLWtsRFCkHf4ZG2IpZv/PLbui/TxyTTbCFCRPFHqepTuoqOIBl6TQoJ/hNmYRaC7dqcLJvJpxnLJvxKdIXOUoJ4/a2GV6xn34sp7cpWlUJEHBZpZIzTZzxTiV4fWf8TAugoPyjTxTQC8fbVxvlVWsmr8YLKpS4KRdHaZdrGKN88hZcFl5e/kcgjI6RDPOqC9D4hSbiiQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1355780c-9f74-4973-0b42-08d86bae9881
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 17:21:29.8341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +vv8gkLt3xGs1pUpHsVNIiT91Ee6bWZYiYqpOAwQVOiE6i5UsDHgJhZ1TclXvbj3WBpjh7+kMng+uaBbClRBQt4yLC54Y1EyqgRLqvYiK0rbgqha97yajZNoKI+pJqo/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2874
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGksDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFVsZiBIYW5zc29uIDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDgsIDIwMjAg
MTE6MTkgUE0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1c2Fp
bmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRl
ckBpbnRlbC5jb20+OyBNaWNoYWwgU2ltZWsNCj48bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBT
aGV2Y2hlbmtvLCBBbmRyaXkNCj48YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgbGludXgt
bW1jQHZnZXIua2VybmVsLm9yZzsgTGludXggQVJNDQo+PGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPmtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc+OyBSYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPjxsYWtz
aG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47IFdhbiBNb2hhbWFkLCBXYW4gQWht
YWQNCj5aYWluaWUgPHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPjsgQXJu
ZCBCZXJnbWFubg0KPjxhcm5kQGFybmRiLmRlPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNC80
XSBtbWM6IHNkaGNpLW9mLWFyYXNhbjogRW5hYmxlIFVIUy0xIHN1cHBvcnQgZm9yDQo+S2VlbSBC
YXkgU09DDQo+DQo+T24gVGh1LCA4IE9jdCAyMDIwIGF0IDEyOjU0LCBadWxraWZsaSwgTXVoYW1t
YWQgSHVzYWluaQ0KPjxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gSGksDQo+Pg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJv
bTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+PiA+U2VudDogVGh1cnNk
YXksIE9jdG9iZXIgOCwgMjAyMCA1OjI4IFBNDQo+PiA+VG86IFp1bGtpZmxpLCBNdWhhbW1hZCBI
dXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+ID5DYzogSHVu
dGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgTWljaGFsIFNpbWVrDQo+PiA+
PG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgU2hldmNoZW5rbywgQW5kcml5DQo+PiA+PGFuZHJp
eS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExpbnV4
IEFSTQ0KPj4gPjxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBMaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0DQo+PiA+PGxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnPjsg
UmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj4+ID48bGFrc2htaS5iYWkucmFqYS5zdWJy
YW1hbmlhbkBpbnRlbC5jb20+OyBXYW4gTW9oYW1hZCwgV2FuIEFobWFkDQo+PiA+WmFpbmllIDx3
YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IEFybmQgQmVyZ21hbm4NCj4+
ID48YXJuZEBhcm5kYi5kZT4NCj4+ID5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNF0gbW1jOiBz
ZGhjaS1vZi1hcmFzYW46IEVuYWJsZSBVSFMtMQ0KPj4gPnN1cHBvcnQgZm9yIEtlZW0gQmF5IFNP
Qw0KPj4gPg0KPj4gPk9uIFRodSwgOCBPY3QgMjAyMCBhdCAwNDoxMiwgPG11aGFtbWFkLmh1c2Fp
bmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPndyb3RlOg0KPj4gPj4NCj4+ID4+IEZyb206IE11aGFt
bWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+ID4+IDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGlu
dGVsLmNvbT4NCj4+ID4+DQo+PiA+PiBWb2x0YWdlIHN3aXRjaGluZyBzZXF1ZW5jZSBpcyBuZWVk
ZWQgdG8gc3VwcG9ydCBVSFMtMSBpbnRlcmZhY2UuDQo+PiA+PiBUaGVyZSBhcmUgMiBwbGFjZXMg
dG8gY29udHJvbCB0aGUgdm9sdGFnZS4NCj4+ID4+IDEpIEJ5IHNldHRpbmcgdGhlIEFPTiByZWdp
c3RlciB1c2luZyBmaXJtd2FyZSBkcml2ZXIgY2FsbGluZw0KPj4gPj4gc3lzdGVtLWxldmVsIHBs
YXRmb3JtIG1hbmFnZW1lbnQgbGF5ZXIgKFNNQykgdG8gc2V0IHRoZSByZWdpc3Rlci4NCj4+ID4+
IDIpIEJ5IGNvbnRyb2xsaW5nIHRoZSBHUElPIGV4cGFuZGVyIHZhbHVlIHRvIGRyaXZlIGVpdGhl
ciAxLjhWIG9yDQo+PiA+PiAzLjNWIGZvciBwb3dlciBtdXggaW5wdXQuDQo+PiA+Pg0KPj4gPj4g
U2lnbmVkLW9mZi1ieTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaQ0KPj4gPj4gPG11aGFtbWFk
Lmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4gPj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hl
dmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPg0KPj4gPj4gUmV2aWV3ZWQtYnk6
IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPg0KPj4gPj4gLS0tDQo+PiA+
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYyB8IDEyNg0KPj4gPj4gKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTI2IGluc2Vy
dGlvbnMoKykNCj4+ID4+DQo+PiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1vZi1hcmFzYW4uYw0KPj4gPj4gYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5j
DQo+PiA+PiBpbmRleCA0NmFlYTY1MTYxMzMuLmVhMjQ2N2IwMDczZCAxMDA2NDQNCj4+ID4+IC0t
LSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4+ID4+ICsrKyBiL2RyaXZl
cnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4+ID4+IEBAIC0xNiw2ICsxNiw3IEBADQo+
PiA+PiAgICovDQo+PiA+Pg0KPj4gPj4gICNpbmNsdWRlIDxsaW51eC9jbGstcHJvdmlkZXIuaD4N
Cj4+ID4+ICsjaW5jbHVkZSA8bGludXgvZ3Bpby9jb25zdW1lci5oPg0KPj4gPj4gICNpbmNsdWRl
IDxsaW51eC9tZmQvc3lzY29uLmg+DQo+PiA+PiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
Pj4gPj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4+ID4+IEBAIC0yMyw2ICsyNCw3
IEBADQo+PiA+PiAgI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KPj4gPj4gICNpbmNsdWRlIDxs
aW51eC9vZi5oPg0KPj4gPj4gICNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS94bG54LXp5bnFtcC5o
Pg0KPj4gPj4gKyNpbmNsdWRlIDxsaW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJl
Lmg+DQo+PiA+Pg0KPj4gPj4gICNpbmNsdWRlICJjcWhjaS5oIg0KPj4gPj4gICNpbmNsdWRlICJz
ZGhjaS1wbHRmbS5oIg0KPj4gPj4gQEAgLTEzNiw2ICsxMzgsNyBAQCBzdHJ1Y3Qgc2RoY2lfYXJh
c2FuX2Nsa19kYXRhIHsNCj4+ID4+ICAgKiBAc29jX2N0bF9iYXNlOiAgICAgIFBvaW50ZXIgdG8g
cmVnbWFwIGZvciBzeXNjb24gZm9yIHNvY19jdGwgcmVnaXN0ZXJzLg0KPj4gPj4gICAqIEBzb2Nf
Y3RsX21hcDogICAgICAgTWFwIHRvIGdldCBvZmZzZXRzIGludG8gc29jX2N0bCByZWdpc3RlcnMu
DQo+PiA+PiAgICogQHF1aXJrczogICAgICAgICAgICBBcmFzYW4gZGV2aWF0aW9ucyBmcm9tIHNw
ZWMuDQo+PiA+PiArICogQHVoc19ncGlvOiAgICAgICAgICBQb2ludGVyIHRvIHRoZSB1aHMgZ3Bp
by4NCj4+ID4+ICAgKi8NCj4+ID4+ICBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX2RhdGEgew0KPj4gPj4g
ICAgICAgICBzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdDsNCj4+ID4+IEBAIC0xNTAsNiArMTUzLDcg
QEAgc3RydWN0IHNkaGNpX2FyYXNhbl9kYXRhIHsNCj4+ID4+ICAgICAgICAgc3RydWN0IHJlZ21h
cCAgICpzb2NfY3RsX2Jhc2U7DQo+PiA+PiAgICAgICAgIGNvbnN0IHN0cnVjdCBzZGhjaV9hcmFz
YW5fc29jX2N0bF9tYXAgKnNvY19jdGxfbWFwOw0KPj4gPj4gICAgICAgICB1bnNpZ25lZCBpbnQg
ICAgcXVpcmtzOw0KPj4gPj4gKyAgICAgICBzdHJ1Y3QgZ3Bpb19kZXNjICp1aHNfZ3BpbzsNCj4+
ID4+DQo+PiA+PiAgLyogQ29udHJvbGxlciBkb2VzIG5vdCBoYXZlIENEIHdpcmVkIGFuZCB3aWxs
IG5vdCBmdW5jdGlvbg0KPj4gPj4gbm9ybWFsbHkgd2l0aG91dA0KPj4gPiovDQo+PiA+PiAgI2Rl
ZmluZSBTREhDSV9BUkFTQU5fUVVJUktfRk9SQ0VfQ0RURVNUICAgICAgICBCSVQoMCkNCj4+ID4+
IEBAIC0zNjEsNiArMzY1LDExMiBAQCBzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl92b2x0YWdlX3N3
aXRjaChzdHJ1Y3QNCj4+ID5tbWNfaG9zdCAqbW1jLA0KPj4gPj4gICAgICAgICByZXR1cm4gLUVJ
TlZBTDsNCj4+ID4+ICB9DQo+PiA+Pg0KPj4gPj4gK3N0YXRpYyBpbnQgc2RoY2lfYXJhc2FuX2tl
ZW1iYXlfdm9sdGFnZV9zd2l0Y2goc3RydWN0IG1tY19ob3N0DQo+Km1tYywNCj4+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBtbWNfaW9zICppb3MpIHsN
Cj4+ID4+ICsgICAgICAgc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QgPSBtbWNfcHJpdihtbWMpOw0K
Pj4gPj4gKyAgICAgICBzdHJ1Y3Qgc2RoY2lfcGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNp
X3ByaXYoaG9zdCk7DQo+PiA+PiArICAgICAgIHN0cnVjdCBzZGhjaV9hcmFzYW5fZGF0YSAqc2Ro
Y2lfYXJhc2FuID0NCj5zZGhjaV9wbHRmbV9wcml2KHBsdGZtX2hvc3QpOw0KPj4gPj4gKyAgICAg
ICB1MTYgY3RybF8yLCBjbGs7DQo+PiA+PiArICAgICAgIGludCByZXQ7DQo+PiA+PiArDQo+PiA+
PiArICAgICAgIHN3aXRjaCAoaW9zLT5zaWduYWxfdm9sdGFnZSkgew0KPj4gPj4gKyAgICAgICBj
YXNlIE1NQ19TSUdOQUxfVk9MVEFHRV8xODA6DQo+PiA+PiArICAgICAgICAgICAgICAgY2xrID0g
c2RoY2lfcmVhZHcoaG9zdCwgU0RIQ0lfQ0xPQ0tfQ09OVFJPTCk7DQo+PiA+PiArICAgICAgICAg
ICAgICAgY2xrICY9IH5TREhDSV9DTE9DS19DQVJEX0VOOw0KPj4gPj4gKyAgICAgICAgICAgICAg
IHNkaGNpX3dyaXRldyhob3N0LCBjbGssIFNESENJX0NMT0NLX0NPTlRST0wpOw0KPj4gPj4gKw0K
Pj4gPj4gKyAgICAgICAgICAgICAgIGNsayA9IHNkaGNpX3JlYWR3KGhvc3QsIFNESENJX0NMT0NL
X0NPTlRST0wpOw0KPj4gPj4gKyAgICAgICAgICAgICAgIGlmIChjbGsgJiBTREhDSV9DTE9DS19D
QVJEX0VOKQ0KPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FQUdBSU47DQo+
PiA+PiArDQo+PiA+PiArICAgICAgICAgICAgICAgc2RoY2lfd3JpdGViKGhvc3QsIFNESENJX1BP
V0VSX09OIHwgU0RIQ0lfUE9XRVJfMTgwLA0KPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBTREhDSV9QT1dFUl9DT05UUk9MKTsNCj4+ID4+ICsNCj4+ID4+ICsgICAgICAg
ICAgICAgICAvKg0KPj4gPj4gKyAgICAgICAgICAgICAgICAqIFNldCBWRERJT19CIHZvbHRhZ2Ug
dG8gTG93IGZvciAxLjhWDQo+PiA+PiArICAgICAgICAgICAgICAgICogd2hpY2ggaXMgY29udHJv
bGxpbmcgYnkgR1BJTyBFeHBhbmRlci4NCj4+ID4+ICsgICAgICAgICAgICAgICAgKi8NCj4+ID4+
ICsgICAgICAgICAgICAgICBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoc2RoY2lfYXJhc2FuLT51
aHNfZ3BpbywNCj4+ID4+ICsgMCk7DQo+PiA+PiArDQo+PiA+PiArICAgICAgICAgICAgICAgLyoN
Cj4+ID4+ICsgICAgICAgICAgICAgICAgKiBUaGlzIGlzIGxpa2UgYSBmaW5hbCBnYXRla2VlcGVy
LiBOZWVkIHRvIGVuc3VyZSBjaGFuZ2VkDQo+dm9sdGFnZQ0KPj4gPj4gKyAgICAgICAgICAgICAg
ICAqIGlzIHNldHRsZWQgYmVmb3JlIGFuZCBhZnRlciB0dXJuIG9uIHRoaXMgYml0Lg0KPj4gPj4g
KyAgICAgICAgICAgICAgICAqLw0KPj4gPj4gKyAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgx
MDAwLCAxMTAwKTsNCj4+ID4+ICsNCj4+ID4+ICsgICAgICAgICAgICAgICByZXQgPQ0KPmtlZW1i
YXlfc2Rfdm9sdGFnZV9zZWxlY3Rpb24oS0VFTUJBWV9TRVRfMVY4X1ZPTFQpOw0KPj4gPj4gKyAg
ICAgICAgICAgICAgIGlmIChyZXQpDQo+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gcmV0Ow0KPj4gPj4gKw0KPj4gPj4gKyAgICAgICAgICAgICAgIHVzbGVlcF9yYW5nZSgxMDAw
LCAxMTAwKTsNCj4+ID4NCj4+ID5Obywgc29ycnksIGJ1dCBJIGRvbid0IGxpa2UgdGhpcy4NCj4+
ID4NCj4+ID5UaGlzIGxvb2tzIGxpa2UgYSBHUElPIHJlZ3VsYXRvciB3aXRoIGFuIGV4dGVuc2lv
biBvZiB1c2luZyB0aGUNCj4+ID5rZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKCkgdGhpbmd5
LiBJIHRoaW5rIHlvdSBjYW4gbW9kZWwgdGhlc2UNCj4+ID50aGluZ3MgYmVoaW5kIGEgcmVndWxh
dG9yIGFuZCBob29rIGl0IHVwIGFzIGEgdnFtbWMgc3VwcGx5IGluIERUDQo+PiA+aW5zdGVhZC4g
QlRXLCB0aGlzIGlzIHRoZSBjb21tb24gd2F5IHdlIGRlYWwgd2l0aCB0aGVzZSB0aGluZ3MgZm9y
IG1tYw0KPmhvc3QgZHJpdmVycy4NCj4+DQo+PiBUaGUgU0RjYXJkIGZvciBLZWVtIEJheSBTT0Mg
ZG9lcyBub3QgaGF2ZSBpdHMgb3duIHZvbHRhZ2UgcmVndWxhdG9yLg0KPj4gVGhlcmUgYXJlIDIg
cGxhY2VzIHRvIGNvbnRyb2wgdGhlIHZvbHRhZ2UuDQo+PiAxKSBCeSBzZXR0aW5nIHRoZSBBT04g
cmVnaXN0ZXIgY2FsbGluZyBzeXN0ZW0tbGV2ZWwgcGxhdGZvcm0gbWFuYWdlbWVudA0KPmxheWVy
IChTTUMpDQo+PiAgICB0byBzZXQgdGhlIEkvTyBwYWRzIHZvbHRhZ2UgZm9yIHBhcnRpY3VsYXIg
R1BJT3MgbGluZSBmb3IgY2xrLGRhdGEgYW5kIGNtZC4NCj4+ICAgIFRoZSByZWFzb24gd2h5IEkg
dXNlIHRoaXMga2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlvbigpIHZpYSBzbWNjYw0KPmludGVy
ZmFjZSBpdCBiZWNhdXNlIGR1cmluZyB2b2x0YWdlIHN3aXRjaGluZw0KPj4gICAgSSBuZWVkIHRv
IGFjY2VzcyB0byBBT04gcmVnaXN0ZXIuIE9uIGEgc2VjdXJlIHN5c3RlbSwgd2UgY291bGQgbm90
DQo+ZGlyZWN0bHkgYWNjZXNzIHRvIEFPTiByZWdpc3RlciBkdWUgdG8gc29tZSBzZWN1cml0eSBj
b25jZXJuIGZyb20gZHJpdmVyIHNpZGUsDQo+dGh1cw0KPj4gICAgY2Fubm90IGV4cG9zZWQgYW55
IHJlZ2lzdGVyIG9yIGFkZHJlc3MuDQo+PiAyKSBCeSBjb250cm9sbGluZyB0aGUgR1BJTyBleHBh
bmRlciB2YWx1ZSB0byBkcml2ZSBlaXRoZXIgMS44ViBvciAzLjNWIGZvcg0KPnBvd2VyIG11eCBp
bnB1dC4NCj4NCj5JIHNlZSwgdGhhbmtzIGZvciBjbGFyaWZ5aW5nLg0KPg0KPlRvIG1lLCBpdCBz
b3VuZHMgbGlrZSB0aGUgYmVzdCBmaXQgaXMgdG8gaW1wbGVtZW50IGEgcGluY3RybCAodG8gbWFu
YWdlIHRoZSBJL08NCj5wYWRzKSBhbmQgYSBHUElPIHJlZ3VsYXRvci4NCj4NCkV2ZW4gd2l0aCBw
aW5jdHJsLCBpIHN0aWxsIG5lZWQgdG8gdXNlIHRoZSBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0
aW9uKCkgdGhpbmd5IGZvciBBT04gcmVnaXN0ZXIuDQpQbHVzLCB0aGUgR1BJTyBwaW4gdGhhdCBj
b250cm9sIHRoZSBzZC12b2x0YWdlIGlzIGluIEdQSU8gRXhwYW5kZXIgbm90IHVzaW5nIEtlZW1i
YXkgU09DIEdQSU8gUGluLg0KVGhlIGJlc3Qgb3B0aW9uIGlzIHVzaW5nIHRoZSBncGlvIGNvbnN1
bWVyIGZ1bmN0aW9uIHRvIHRvZ2dsZSB0aGUgcGluLg0KVGhhbmtzDQoNCj5LaW5kIHJlZ2FyZHMN
Cj5VZmZlDQo=
