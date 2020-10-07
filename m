Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79E5C41604
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 16:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753B621707
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 16:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rLbVquys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgJGQJY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:09:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:57426 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGQJY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 12:09:24 -0400
IronPort-SDR: SmHH8eb3MeNvZON+EMV5x1+3uPYm0f5A+z3ukxsAGG9lt1yE8woUJutXJ875CirnMq8Dscer6w
 +XKRW/LEnX2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="249714407"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="249714407"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 09:09:23 -0700
IronPort-SDR: +hjR7tOycIlmBKNx+t7+4cU9ZyOhqQopXkPrrqPKsciL50icPZBtxU0EiWpqbmCcUwLdCZ6ifi
 qumk2UsM9iFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="316275809"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2020 09:09:22 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 09:09:22 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 09:09:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 09:09:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 09:09:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf7ECL3vBU5UvZ4OWGVkRNjnclW3OrqLiPPCjKMBZrBHzgoVsUPnHDQVcCUtcmhcClYVCYxaxy8r/SfEAyUutAcJWEydaVHBoDk70CJU3biIRdsqrphO8CF0tozTHdPlAdYRORzqS03FCT1eK/+bGC1ULyMqbp8u8zNSKUKQYxsX2Ym21PIlRYaGUr7HXteuisuHN19++glMRSNyleYC0++cqE5vvK0fplYpPGEb8eY0uJbr+NN5N5vhHJ55qikUDCZaJaQqrlkthylK7JxJeRrqTsCCsmKwU10vEeXPXiAMFsvAwulu0ltTZYYbfaAYRPSzd2SJAjEe2uBspgkSZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebuVvRS+2COTsOeXQopw0NhfiSVRzC4rj/1QDM5f8WY=;
 b=GdMM/XK7Rb4FJW+04d6MKIz3OQC7rH9wFMopnOLTd0t1f3q1Jt9vt8yqlixdY61psPhfF/1d49ZNn76yW6JR/7tq+LPpL2yO1cIm8w1mUTUXq4FBlz+wdjVAtggejkN/nmoAKQBBvFKuaRkg38gZEaElgPgKSX8EG9161J22/mre2EHmo+XnTVSGGBoNTUnKo2E/3hfWuYR1ITu8PK4XcseIeoCmnQLgGrFa5BhVwpdWyfWEiCDU60ElC8jrB5Lep7luk/N24BJILi+HTL4CV9sNiLalQu/9GrzsqUmcXLUMxl1gYc9kAeIVr0nIUgYOPv/NLfQ0F5pEhretN7G4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebuVvRS+2COTsOeXQopw0NhfiSVRzC4rj/1QDM5f8WY=;
 b=rLbVquysio9aiwgfH5p2UI8ckztex69iZrs/tVKKYM5x2iIhvzs6EQh0XHsPYXxEkaDCcOGC+Mr/XA8edr6acCYsDxm/ox4UXSmd12ux5VCN9ywieNlPpd8IBdseFCe0ze2KsYH1yPRwosTykwNFcz0HNmVwBhR1MXoq+TD3Ijo=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB3451.namprd11.prod.outlook.com (2603:10b6:5:5b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.43; Wed, 7 Oct 2020 16:08:47 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 16:08:47 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-arm Mailing List" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWm/miHZrYTgP7dkS6mFSOGlc+ZqmL0SmAgAAGHwCAAEuN4IAAGNIAgAAUkFA=
Date:   Wed, 7 Oct 2020 16:08:47 +0000
Message-ID: <DM6PR11MB287669F4020B415D6EAA8403B80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
 <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
 <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
 <DM6PR11MB28768EDF354D2ED4A43B4AD2B80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAHp75VeyO1XErkO=sGnY2VTyPQT9Gp-rkfPdmj0AMM95fA2J1g@mail.gmail.com>
In-Reply-To: <CAHp75VeyO1XErkO=sGnY2VTyPQT9Gp-rkfPdmj0AMM95fA2J1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d156daf-6e0f-4d63-2485-08d86adb45fa
x-ms-traffictypediagnostic: DM6PR11MB3451:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3451AC43E6051F12947E619EB80A0@DM6PR11MB3451.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4jNH02AuiEsQsr7NZ58G0POUdw9ev0pfCBdOi3wnwPCoVaKvpq56ahYILJEYmvlqHm4qGd6g6Enl2tGL/s3L0mAQ3GLzwRAWprQ2fligdovGT+9jv0B5uQXD2UaCR8jQJrcllVEvLx2JOoZBd1LPRcBRgQaKybLt8MfGp/ZMXeF6ASYAC+/F0cEO9UNFZB0Gv/p/nzv9DNdmhvX6x8+Waems41zQAqCTshWwoawgsyjIBBcyD9i2+G/X05yPsKSdGQ8Q1nRlmOSKxUC8jZBPLICNJD9oD9HqBH3DTjnjqQzhOVgub9MQAwfggvoyjFip246XKhCdsHHl44fwDHhBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(52536014)(8936002)(4326008)(478600001)(66946007)(8676002)(5660300002)(54906003)(86362001)(64756008)(2906002)(316002)(7696005)(55016002)(186003)(76116006)(26005)(33656002)(66476007)(6916009)(83380400001)(6506007)(66556008)(66446008)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: XN5yoSZjRonUru4LyvMZ35z4dp+3irptvZg+d05uxG0ob3/w0A2NDzMyH8z0DaDSrwaEKJsVs0BANdMl+0F24xdsQwSLGddL7iIPo+3EdIMB7okep/7mpncumJZGLOnTYulZRPBnofnXIVFrS+EiNyLWqUqRT00zboQelKMvTTr9grb5DAN2/L7IeGPVloSHQGnBFDJuidCqY0nUMY8iDBEh7p/5Wa0LnQTQaLAXB6IA0I9JP2L5Ipk34TT002U95Rypewdj8RTrpvLioxYnQ91Pbp7SsCOHTN1It0lD2bofgq/8o0XVHUg03sS7eMrXnLh+92FXOKx27tucd2DXExA4U8pSN+i3wJWCuS2YFwyO6oePPJI4WAdhKpiFi7jHuEb+av7EVaJ5X9E0ZDJYfpL+9c/qUIFmF1TXFtAfHb5faZcD0GemsrW3i15NfYscwaE4vPCj2GlVWMK+B6rm9sKbP0Cn2nITN5i5uP+oHP/8YyoVaXyTWNMLLPYaivbjeCoRgOwl5FcQ4M+qMTvu8+1mYJ2gZ84XLEoRknhmL+wEJi7R3tWG4+gqNEashRaOr73+5VmpswCdS3Ut7zN55OJ//6sv5lKBn4yyQuyCFJftF1VwQHR1fIoQAS+3+gohaJg6QjemB0Lcr0aDy3Mm8w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d156daf-6e0f-4d63-2485-08d86adb45fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 16:08:47.5399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XywVKd9EgSfXQKye+XBsHwyIUGaI5u1o7bIMSjWEayEES4nwJj1h1AR9QMFkmMAqYXNlVSPJZucUq2Ovy/dqad8veXM1Crl8nMFHCqCeAOWTvrZUIU36vvtxazJ7iZZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3451
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBBbmR5IFNoZXZjaGVu
a28gPGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBPY3RvYmVy
IDcsIDIwMjAgMTA6NTUgUE0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFt
bWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBNaWNoYWwgU2ltZWsgPG1pY2hh
bC5zaW1la0B4aWxpbnguY29tPjsgSHVudGVyLCBBZHJpYW4NCj48YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+OyBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPjsgVWxmDQo+SGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz47IGxpbnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZz47DQo+bGludXgtYXJtIE1haWxpbmcgTGlzdCA8bGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsDQo+TWFpbGluZyBMaXN0IDxsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnPjsgUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj48bGFr
c2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+OyBXYW4gTW9oYW1hZCwgV2FuIEFo
bWFkIFphaW5pZQ0KPjx3YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IEFy
bmQgQmVyZ21hbm4NCj48YXJuZEBhcm5kYi5kZT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDEv
Ml0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IEVuYWJsZSBVSFMtMSBzdXBwb3J0IGZvcg0KPktlZW0g
QmF5IFNPQw0KPg0KPk9uIFdlZCwgT2N0IDcsIDIwMjAgYXQgNDoyOCBQTSBadWxraWZsaSwgTXVo
YW1tYWQgSHVzYWluaQ0KPjxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4gd3Jv
dGU6DQo+PiA+RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29t
Pg0KPj4gPlNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA3LCAyMDIwIDQ6NTYgUE0gT24gV2VkLCBP
Y3QgNywgMjAyMCBhdCAxMTozOA0KPj4gPkFNIE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhp
bGlueC5jb20+DQo+PiA+d3JvdGU6DQo+PiA+PiBPbiAwNi4gMTAuIDIwIDE3OjU1LCBtdWhhbW1h
ZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbSB3cm90ZToNCj4NCj4uLi4NCj4NCj4+ID4+ID4g
KyAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4+ID4+DQo+PiA+PiBuaXQ6
IEkgZ290IHRoaXMgYnV0IGFzIEkgc2VlIDMgbGluZXMgYmVsb3cgbWF5YmUgd291bGQgYmUgYmV0
dGVyIHRvDQo+PiA+PiB1c2UgaXQgZXZlcnl3aGVyZSBidXQgaXQgY2FuIGJlIGRvbmUgaW4gc2Vw
YXJhdGUgcGF0Y2guDQo+PiA+DQo+PiA+SW4gdGhhdCBjYXNlIEkgdGhpbmsgaXQgd291bGQgYmUg
YmV0dGVyIHRvIGhhdmUgdGhhdCBwYXRjaCBmaXJzdC4gSXQNCj4+ID5tYWtlIGZvbGxvdyB1cCBj
b2RlIGNsZWFuZXIuDQo+PiBJIHdhbnQgdG8gZ2V0IHNvbWUgY2xhcmlmaWNhdGlvbiBoZXJlLg0K
Pg0KPj4gRG8gSSBuZWVkIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMgc3RydWN0IGRldmljZSAq
ZGV2ID0gJnBkZXYtPmRldjs/DQo+DQo+SXQgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcGF0Y2ggYW5k
IGJldHRlciB5b3VyIHNlcmllcyBzdGFydHMgd2l0aCBpdCwgc28gaXQgd29uJ3QNCj5pbnRlcmZl
cmUgd2l0aCBuZXcgY29kZS4NCj4NCj4+IENhbiBJIGVtYmVkZGVkIHRvZ2V0aGVyIHdpdGggVUhT
IHBhdGNoPw0KPg0KPkJldHRlciB0byBhdm9pZCBtZXJnaW5nIG9ydGhvZ29uYWwgdGhpbmdzIHRv
Z2V0aGVyIGluIG9uZSBjaGFuZ2UuDQpOb3RlZC4gVGhhbmtzIPCfmIkNCj4NCj4tLQ0KPldpdGgg
QmVzdCBSZWdhcmRzLA0KPkFuZHkgU2hldmNoZW5rbw0K
