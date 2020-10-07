Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBF1C47095
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 353A020870
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="adri8PbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgJGN2a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:28:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:49639 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgJGN2a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:28:30 -0400
IronPort-SDR: AMsI86lDm+LMdVY40JdsfXkqznk3nXtMo5cyFk+f2b32e69QAZ4XBCLBdFoojvFmaXYVFD+9xi
 oRer3+OHH2lw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="144856245"
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="144856245"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:28:29 -0700
IronPort-SDR: DX5MA6TA09ijqn9yXPZA9LFsl3CwgaWCUSxkuv4n2daL7vr0qWRht0uhIS0XOfTA3Nx0EGDhNc
 BGFoAq4p/FWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="328059199"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga002.jf.intel.com with ESMTP; 07 Oct 2020 06:28:29 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:28:28 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:28:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 06:28:28 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 06:28:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hK0JMurieNWgiaK3ZonuX1bGR9cpF0mJBZ0BF5J7sHth/lk3JZ8Tg6xYpvVKikkzganuncgXprNHfFKyyIX1Lm86BWHTnj0lhKqsuL3se7L1jEDSoqrO97AEs1l7EaKyH1xN84lBVDidN6Nk1DIodauQKZsAJLRJnjcH5ONtCQYU4NQYggdYgASTlUMe8pXiH9dwmGqCNifu1suzciwOk5f33t8Um9OItcWviqx4kz/ZywqkdVyjv0KySLBnoTOEdl/DO9E+PHEAZuXjkqv4m6M2vwMcr0grlOd+N1uELOMUke4nPG5eeIH3gLqyMIKIX0Sh+7/oKRrgXYjOG2+mEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxMGZTwNNCjH+lE61nchxUwtlsnvJ35lwiMba6RoHdM=;
 b=MrMPOVrGajwYkQhjYrSoMmvKTAj2qjTc5T1Q4G3k+I59ZzAl3XkQn/0GsLK56JNzLqoPiRGcs+29c/DZ1psyxJOFycB2S0O8O7Y2qXLf4ZDkOKGWTi/7ygCQ6+XSfspxgmaNRT4bYKu19M2/4pqOfXH9o8yMzti3VsLTkyWfiFtDtLEfP+lGkC+fCwz5O7SuamWM0GcuYVmSEHfYaLiQKyBAcNyNUi1MsWEEAqLKXO825OO1tvzVqe+7c+5PL9ejI9mNPeqbRnMP5CkqzaJzgPFtRNqt+upTKlRisKIvfZuOptO3EbNRnRHxPlVzA22UR/zfdhlJzxZ5pgvUCJrkaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxMGZTwNNCjH+lE61nchxUwtlsnvJ35lwiMba6RoHdM=;
 b=adri8PbZZ7z2v6P23tA59qTrQKWAZSGGZjZp+McV8VRqfIB+cthSLKzLWtmJP9iUiz0vDJFrO3kR4Dc5NQ/pnJW+D+Z2H6kbrKRZTiC7AQ2+DQ1wrDldwGufZ4GVcAXPLtCsKwfOoBevIQVmyk3Yju4LClvvZM8A31r363UWdSk=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB3211.namprd11.prod.outlook.com (2603:10b6:5:58::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.38; Wed, 7 Oct 2020 13:28:22 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:28:22 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWm/miHZrYTgP7dkS6mFSOGlc+ZqmL0SmAgAAGHwCAAEuN4A==
Date:   Wed, 7 Oct 2020 13:28:22 +0000
Message-ID: <DM6PR11MB28768EDF354D2ED4A43B4AD2B80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com>
 <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
 <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
In-Reply-To: <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: d8956302-8d0f-4c96-450b-08d86ac4dd14
x-ms-traffictypediagnostic: DM6PR11MB3211:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB32116CC4AA3327937102CB1BB80A0@DM6PR11MB3211.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIbfx4E60v3xGD8jKI8+w/BBTVsMkxvZQdRbZU+u+cN9kVWNwhFs1vnVr0EzgMf3lli7icq6BnXuvQWZxbbd2z70Li/bMZD3yyS0Z8Aqzb3nCzAVYhxKFA5jrx3uw7cGSgJ9LTmhBxXYPtDVLv01clMrDKBB+m31HIT6clAWjtm7dBPorKca2Gqh2qIuPA9xjLtnsB71BRnfFDp9cx35JkRpVsc8MnxU56+vE1SAlqaIKKQH1eHP9I2O4zfojM3+xoU98hsXe5/iR6FfIzd7+P05Qv98hhdwC8lu9Uae6zaNGt2Tm3lEJ/iWMYeY/zZnEJWnX3AbscLBt0tEiaHw9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(64756008)(66476007)(2906002)(5660300002)(52536014)(66556008)(8676002)(66946007)(33656002)(8936002)(9686003)(55016002)(66446008)(4326008)(86362001)(7696005)(478600001)(54906003)(110136005)(6506007)(26005)(186003)(83380400001)(316002)(76116006)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WgfE1T4Pjio93aJWKiR5JYcbT/y37E1jCGuuFF8ESEmAbqWhUaedRkM+taaw6+6koJ3L03kkM8oJRbWjK6xSwcAnElvu4/taNI8TgYHRdSnOb4AgC2u5m28zFE4lUVj3AYKif1UeNPuXd4gHmOz2hzKPn3J7tW5AN1q9QLgn1I0AGw3IwLdAmWFG3zFc+aZq/c5paYR4pEUkdN6oslnSvSeMNp4THScyAkBeX8hJLKqiJ3Ey7KrSxO4kJ8yR0ARExOy6+iFrjDVvl8L5o29ZIYsuHYBUjTyxmfOd5D9RkpcmahbMxthmJbjE2ALNqXkPrNst55Jm4r6M4/8TSjNK/dDhO4usoOgq+ZP+EgH41MsiRZ+AlfZPOVSJoQw/CsbhYG0fFOJTtg1KTh8I/MMZkfcPgTzbGhoLHOZsjwlPy/WylYFQ6yMTK3BDEUyP1jjXrfJ3qxNo93gr6oUpDW7mkfqUmnDfj0aaVhl88LiR0Pb9NFzwnqxL+AMq/HqgEWjAJ22r0K72otoi9co1CFfDXD3CaNr0x1plC6+YlrKnWERwP5/VugEwvQ6cLuoLYbWl9WPClaOKGG8h3ExFyGJW/m1uvvDaT2egdzO+dQRIY6Jv2hT2TokkjDxY8TYTNPp/XLRjezzl6dniFlCsEDHHlA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8956302-8d0f-4c96-450b-08d86ac4dd14
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 13:28:22.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/mnpdD2qwempNjfsl6ee14gIiK3B1u+Evg+8jhA9rNqglf8Is72KeBl92ZHtIQds07kvyYzLkjivQ0rtpxSoErwnoTfCqb93i8eXmbzhsAMEZqDSlHNIcvqF/vfGSWJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3211
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEkgcmVwbGllZCBpbmxpbmUNCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5
LnNoZXZjaGVua29AZ21haWwuY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA3LCAyMDIw
IDQ6NTYgUE0NCj5UbzogTWljaGFsIFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT4NCj5D
YzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlA
aW50ZWwuY29tPjsNCj5IdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBT
dWRlZXAgSG9sbGENCj48c3VkZWVwLmhvbGxhQGFybS5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz47IGxpbnV4LW1tYw0KPjxsaW51eC1tbWNAdmdlci5rZXJuZWwub3Jn
PjsgbGludXgtYXJtIE1haWxpbmcgTGlzdCA8bGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+a2VybmVsQHZn
ZXIua2VybmVsLm9yZz47IFJhamEgU3VicmFtYW5pYW4sIExha3NobWkgQmFpDQo+PGxha3NobWku
YmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsgV2FuIE1vaGFtYWQsIFdhbiBBaG1hZA0K
PlphaW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBBcm5kIEJl
cmdtYW5uDQo+PGFybmRAYXJuZGIuZGU+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIG1t
Yzogc2RoY2ktb2YtYXJhc2FuOiBFbmFibGUgVUhTLTEgc3VwcG9ydCBmb3INCj5LZWVtIEJheSBT
T0MNCj4NCj5PbiBXZWQsIE9jdCA3LCAyMDIwIGF0IDExOjM4IEFNIE1pY2hhbCBTaW1layA8bWlj
aGFsLnNpbWVrQHhpbGlueC5jb20+DQo+d3JvdGU6DQo+PiBPbiAwNi4gMTAuIDIwIDE3OjU1LCBt
dWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbSB3cm90ZToNCj4NCj4uLi4NCj4NCj4+
ID4gKyAgICAgICAgICAgICAvKg0KPj4gPiArICAgICAgICAgICAgICAqIFRoaXMgaXMgbGlrZSBm
aW5hbCBnYXRla2VlcGVyLiBOZWVkIHRvIGVuc3VyZQ0KPj4gPiArIGNoYW5nZWQgdm9sdGFnZQ0K
Pg0KPmxpa2UgYSBmaW5hbA0KTm90ZWQuIERvbmUgdGhlIGNoYW5nZXMNCj4NCj4+ID4gKyAgICAg
ICAgICAgICAgKiBpcyBzZXR0bGVkIGJlZm9yZSBhbmQgYWZ0ZXIgdHVybiBvbiB0aGlzIGJpdC4N
Cj4+ID4gKyAgICAgICAgICAgICAgKi8NCj4NCj4uLi4NCj4NCj4+ID4gKyAgICAgICAgICAgICAv
Kg0KPj4gPiArICAgICAgICAgICAgICAqIFRoaXMgaXMgbGlrZSBmaW5hbCBnYXRla2VlcGVyLiBO
ZWVkIHRvIGVuc3VyZQ0KPj4gPiArIGNoYW5nZWQgdm9sdGFnZQ0KPg0KPkxpa2V3aXNlLg0KTm90
ZWQuIERvbmUgdGhlIGNoYW5nZXMNCj4NCj4+ID4gKyAgICAgICAgICAgICAgKiBpcyBzZXR0bGVk
IGJlZm9yZSBhbmQgYWZ0ZXIgdHVybiBvbiB0aGlzIGJpdC4NCj4+ID4gKyAgICAgICAgICAgICAg
Ki8NCj4NCj4uLi4NCj4NCj4+ID4gKyAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRl
djsNCj4+DQo+PiBuaXQ6IEkgZ290IHRoaXMgYnV0IGFzIEkgc2VlIDMgbGluZXMgYmVsb3cgbWF5
YmUgd291bGQgYmUgYmV0dGVyIHRvDQo+PiB1c2UgaXQgZXZlcnl3aGVyZSBidXQgaXQgY2FuIGJl
IGRvbmUgaW4gc2VwYXJhdGUgcGF0Y2guDQo+DQo+SW4gdGhhdCBjYXNlIEkgdGhpbmsgaXQgd291
bGQgYmUgYmV0dGVyIHRvIGhhdmUgdGhhdCBwYXRjaCBmaXJzdC4gSXQgbWFrZSBmb2xsb3cgdXAN
Cj5jb2RlIGNsZWFuZXIuDQpJIHdhbnQgdG8gZ2V0IHNvbWUgY2xhcmlmaWNhdGlvbiBoZXJlLg0K
RG8gSSBuZWVkIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIHRoaXMgc3RydWN0IGRldmljZSAqZGV2ID0g
JnBkZXYtPmRldjs/DQpDYW4gSSBlbWJlZGRlZCB0b2dldGhlciB3aXRoIFVIUyBwYXRjaD8NCj4N
Cj4uLi4NCj4NCj4+ID4gKyAgICAgaWYgKG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAiaW50
ZWwsa2VlbWJheS1zZGhjaS01LjEtc2QiKSkgew0KPj4gPiArICAgICAgICAgICAgIHN0cnVjdCBn
cGlvX2Rlc2MgKnVoczsNCj4+ID4gKw0KPj4gPiArICAgICAgICAgICAgIHVocyA9IGRldm1fZ3Bp
b2RfZ2V0X29wdGlvbmFsKGRldiwgInVocyIsDQo+PiA+ICsgR1BJT0RfT1VUX0hJR0gpOw0KPj4N
Cj4+IEkgY2FuJ3Qgc2VlIGNoYW5nZSBpbiBkdCBiaW5kaW5nIHRvIHJlY29yZCB1aHMgZ3Bpby4N
Cj4+DQo+Pg0KPj4gQmV0dGVyDQo+PiBzZGhjaV9hcmFzYW4tPnVoc19ncGlvID0gZGV2bV9ncGlv
ZF9nZXRfb3B0aW9uYWwoZGV2LCAidWhzIiwNCj4+IEdQSU9EX09VVF9ISUdIKTsNCj4+DQo+PiB0
aGVuIHlvdSBjYW4gYXZvaWQgdWhzIHZhcmlhYmxlLg0KPg0KPkFjdHVhbGx5IGl0J3MgcmVhZGFi
aWxpdHkgdnMuIGFkZGl0aW9uYWwgdmFyaWFibGUuIEl0IHdhcyBteSBzdWdnZXN0aW9uIHRvIGhh
dmUgYQ0KPnZhcmlhYmxlIHRvIG1ha2UgcmVhZGFiaWxpdHkgYmV0dGVyLg0KPkFyZSB5b3UgaW5z
aXN0aW5nIG9uIHRoaXMgY2hhbmdlPw0KPg0KPi0tDQo+V2l0aCBCZXN0IFJlZ2FyZHMsDQo+QW5k
eSBTaGV2Y2hlbmtvDQo=
