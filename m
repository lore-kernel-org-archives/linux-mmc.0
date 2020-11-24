Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7B4C63798
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 04:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FBE22068D
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 04:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="D5r5riXQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKXEDF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 23:03:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:11876 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgKXEDE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Nov 2020 23:03:04 -0500
IronPort-SDR: 1+mtHPNOiJb8WJNHi2iQvzPxa0+K4Swghp5Nd0HMJOr2gnJdfQwRFDZ9Eb2eWLWCzI+MOG8Ugq
 ycHUkz43IiFA==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="256596764"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="256596764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 20:03:01 -0800
IronPort-SDR: g14j+297gFy29bFZYbWAbsTwsxtlLsuHVO11wHPxQB1aY9lV4bjyfTM2rC/XCy5jhbZon9ebr4
 l3Fd9k02b1Aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="370243795"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2020 20:03:00 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 20:02:59 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 23 Nov 2020 20:02:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 23 Nov 2020 20:02:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 23 Nov 2020 20:02:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F87C+FSM3mJ8T4iigCIyGOPSBzNT/dH7XAq/L4SYEEGA9UDFSN3nt1f/zOPcIhNOQAcmLD/LIFaoEndVr54y+agDpAS1Z1DY24GknCBhMw1XwVYA/7qEW/f0ubDiHsT6sMydvc/RB+IrLDyoqTGv8NNUCTbwCngsWUmCcRx7QfpK+621FNJvulG+dFDKBQ7gjiIRz7IWIs5LixvWVWIWCMXZpu3uhhbNKiYIqhnACyQbWWtvFd7IeoioRZT0GzfyupDUv9Em2ftBGCElkq1AKbhJ10o9dmYJBRHigUP/bcudqT9lJ/Uw4p8Kx0YiiH+G5WGV4RcSWKmKtsAmx1skvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKabOxyvtCk+Hhotyolg8iSUzxdQYtju7l2Z9mY0Hhk=;
 b=hk6nvSGOUBATNoCm00/zE9U8CdMQw52rFIOb5BxNspQm4wDQLRYONbDhP72yOWU/VVqZmRAKY/6jlaAfNvPoRGCOfNFo5fYC7ZytlYvTden9qiCnTuXmY17irClOPrtwfq+gX91iSZ2SiRWmUVKreD2QHLbe1yGi5dzOjrwMQUZuZ/pse9xX0pk5WqeCcMCEpM9L/os+xP74buqpksgUu9EeZPj3Y0WHxwS+GfjO89TVafwtVTzi574JhK/eIUKaU5HL8n5VRPObOHeIDCVUZis1bQZamzHM1mWasf3a+k62sJUfTQI6VhAi++Ja4cx46kJTkv8ma9oQHvv8SykDaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKabOxyvtCk+Hhotyolg8iSUzxdQYtju7l2Z9mY0Hhk=;
 b=D5r5riXQo/SDHk5MjGh37eTVwJZxB3k/MMgEIL6zMwOXqeRUukxO22S3EHQaMSPyuZlQpNFK7gDVylxNmrO6WTegL1/iNnT4EEzJGww2LXRGQtrtt7EQMtAcFLs1TiuSa8UU7E/MXIZWDd20vJOxvNkcSt6xV8T+Vx026nLcqEs=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB3610.namprd11.prod.outlook.com (2603:10b6:5:139::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.20; Tue, 24 Nov 2020 04:02:55 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3589.024; Tue, 24 Nov 2020
 04:02:55 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: RE: [PATCH v2 1/1] mmc: sdhci-of-arasan: Fix clock registration fail
 for Keem Bay SOC
Thread-Topic: [PATCH v2 1/1] mmc: sdhci-of-arasan: Fix clock registration fail
 for Keem Bay SOC
Thread-Index: AQHWvV+PGTJLKE88dEapd+bY6xUPPqnV6puAgADH6nA=
Date:   Tue, 24 Nov 2020 04:02:55 +0000
Message-ID: <DM6PR11MB2876BBA44910A0145EB625E9B8FB0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201118120120.24908-1-muhammad.husaini.zulkifli@intel.com>
 <20201118120120.24908-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFp6ws4SKwBXF36CQ2-PiaJtETXupqRsPMCLyUvc9Ho7Kg@mail.gmail.com>
In-Reply-To: <CAPDyKFp6ws4SKwBXF36CQ2-PiaJtETXupqRsPMCLyUvc9Ho7Kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8783e66-ae64-4317-53d7-08d8902dd2e8
x-ms-traffictypediagnostic: DM6PR11MB3610:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3610A30CDD52816B00913CE8B8FB0@DM6PR11MB3610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taIE9hSebEDsSWMSHdpJ/diwovexHKXC/vYd5FrpHz8B++Hw06rvj+oZmpePWFrLpVtTqz3L/vOLyxymwCwrPVU45khoZUjVWjmx4UpzjsIszHUYqk5rUZU5S53OQWK6A1Dz3tvHeVohaMBHirc0XNnzjGMCAcKQJY6NkMqbdMjhIZbB4dtcppDSwRwNXKCLuXy5qNfxmEDAsKsfnNkqYtKm/au/rUS6pEIh64BxvMDP4KxLDS+gHOGFnb6+LI5CgBtgfMfyKE7maKQdxtVrl4TlhD0WQvLeXZSm5RsDt5Y4UgKrjd3dzCnA/VxMBfJX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(33656002)(76116006)(8676002)(6506007)(83380400001)(55016002)(71200400001)(86362001)(9686003)(54906003)(7696005)(4326008)(64756008)(478600001)(66946007)(66556008)(6916009)(2906002)(5660300002)(66446008)(66476007)(26005)(52536014)(8936002)(186003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: gYE2M5gbfcSuBKkqluHTwN/HNa3f0yRLpkTzko4BgytO+Oi1xkV7hiSLcEXk80o6RIY6R3u9krfJDI2L4rMP0p41W4Ih58DSMIKqLSWTDwc5G8Aszqw/nkgQAssy2871bf8Rh7isrR/vJJqR2SWelFHJtAjua9FvvHksVfj+UAuJt3a6RauWXTDUd9X0OQ783gS6ayJNIj3Zxg/qejaBDefeIC8FbKUArFmDtPB+eXSBJXyt7OGwS9r5VB/GossbTRaTEibFuJPiw7N/lYfnvIxiUE1qUZ872Vuq5EM5Qr8hk0iv6JwJaOPZHzYZmBOQzt1I3OY/BAsYIqcWZP1IzKNoOVvhYYgCOUgKzpFXlWUPOSz4dnRlrOB+d+9WEev42RS5jRXovt+whs0e3f56hNXjb/o8p9tjgglyEp+iKTrvG3iZ4NAupbkOURwzZ6i5pw2uJblsjyOkAdaMkZx/ZQxR2+5iFaODUN32Iyb/Wj0oH9J+w3azTpwtDldymoNuLKGE37sdsybvbhslWdtg8KfE/tgZTv34wlUc4O9K4Rw37k0+UMG79/M6Z+GJEzf4Js0Ja4Zd3r6J8PiB1HVy0PHc5BUk8tepLBmOjBVzwOGKrk1SMwP2gUqo0zlqiam/jfhY2xZGqpfmikmHZ6SEGkbscOpI8ymSf6krKh3qDYTzjBhbqZw+wTsj/fhzE9uIr2p4YYbTVJ21HgTrjp0EhiYC+21bONLguBalfa0WRohAI9diVM/tm54ZLvRQGK8wFh4ZwFnv3pUykeMDSDNglmoSSrPfl52ZwIFSo2ARwzptkg7yZbJeNas/Kj6V9dvUNMrggducqiW9MuznPvf31Mpyggxu9PFTSKx9e4CMEnmQeXpVMxFMMaJqGrt1nEG3R/WunHT3ugsiWgwLuwhtOA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8783e66-ae64-4317-53d7-08d8902dd2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 04:02:55.7905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B9NCvUujTWHO4pRTZs3/6w64ybJ2ELyY3u7LZmFY5znsiPzmOcw2tFb9fOOmG13L3WNThCQfDd3D5BYaCeaocYArARPp0cVipKSWjhgjohF5eylcDuAz+AeYZwt6k8me
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3610
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQpUaGFua3MNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTog
VWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+U2VudDogVHVlc2RheSwgTm92
ZW1iZXIgMjQsIDIwMjAgMTI6MDcgQU0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2Fpbmkg
PG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBsaW51eC1tbWNAdmdl
ci5rZXJuZWwub3JnOyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj5rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPmtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBS
YWphDQo+U3VicmFtYW5pYW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFu
aWFuQGludGVsLmNvbT47IFdhbg0KPk1vaGFtYWQsIFdhbiBBaG1hZCBaYWluaWUNCj48d2FuLmFo
bWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBEYXZpZCBFLiBCb3gNCj48ZGF2aWQu
ZS5ib3hAbGludXguaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMS8xXSBtbWM6
IHNkaGNpLW9mLWFyYXNhbjogRml4IGNsb2NrIHJlZ2lzdHJhdGlvbiBmYWlsDQo+Zm9yIEtlZW0g
QmF5IFNPQw0KPg0KPk9uIFdlZCwgMTggTm92IDIwMjAgYXQgMDU6MDEsIDxtdWhhbW1hZC5odXNh
aW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj53cm90ZToNCj4+DQo+PiBGcm9tOiBNdWhhbW1hZCBI
dXNhaW5pIFp1bGtpZmxpIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+
DQo+PiBDb21taXQgMTZhZGE3MzBhNzU5ICgibW1jOiBzZGhjaS1vZi1hcmFzYW46IE1vZGlmeSBj
bG9jayBvcGVyYXRpb25zDQo+PiBoYW5kbGluZyIpIGludHJvZHVjZXMgcGxhdGZvcm0gc3BlY2lm
aWMgU0RIQ0kgY2xvY2sgb3BlcmF0aW9uLiBFYWNoDQo+PiBwbGF0Zm9ybSBzaG91bGQgc3BlY2lm
eSBjbG9jayBvcGVyYXRpb25zIGhhbmRsZXJzLg0KPj4NCj4+IENvbW1pdCAxNmFkYTczMGE3NTkg
KCJtbWM6IHNkaGNpLW9mLWFyYXNhbjogTW9kaWZ5IGNsb2NrIG9wZXJhdGlvbnMNCj4+IGhhbmRs
aW5nIikgYW5kIENvbW1pdCAzNmM2YWFkYWFlODYgKCJtbWM6IHNkaGNpLW9mLWFyYXNhbjogQWRk
IHN1cHBvcnQNCj4+IGZvciBJbnRlbCBLZWVtIEJheSIpIGFyZSBtZXJnZWQgYWJvdXQgdGhlIHNh
bWUgdGltZS4gV2hlbiBkb2luZw0KPj4gcmViYXNpbmcgZHVyaW5nIHRoZSB1cHN0cmVhbSBwcm9j
ZXNzLCBDb21taXQgMTZhZGE3MzBhNzU5ICgibW1jOg0KPj4gc2RoY2ktb2YtYXJhc2FuOiBNb2Rp
ZnkgY2xvY2sgb3BlcmF0aW9ucyBoYW5kbGluZyIpIHdhcyBub3QgaW5jbHVkZWQuDQo+PiBUaGlz
IHdpbGwgcmVzdWx0IGluIHNkIGNsb2NrIHJlZ2lzdHJhdGlvbiBmYWlsdXJlIGZvciBLZWVtIEJh
eSBTT0MgRGV2aWNlcyBhcw0KPmNsb2NrIG9wZXJhdGlvbnMgaGFuZGxlcnMgYXJlIG5vdCBkZWZp
bmVkLg0KPj4NCj4+IFRoaXMgcGF0Y2ggZGVjbGFyZXMgdGhlIGNsb2NrIG9wZXJhdGlvbiBmb3Ig
S2VlbSBCYXkgU09DIERldmljZXMuDQo+PiBBZGQgY2xrX29wcyBmb3IgU0QsIEVNTUMgYW5kIFNE
SU8gb3BlcmF0aW9ucy4NCj4+DQo+PiBGaXhlczogMzZjNmFhZGFhZTg2ICgibW1jOiBzZGhjaS1v
Zi1hcmFzYW46IEFkZCBzdXBwb3J0IGZvciBJbnRlbCBLZWVtDQo+PiBCYXkiKQ0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+IDxtdWhhbW1hZC5odXNh
aW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxh
ZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4NCj5BcHBsaWVkIGZvciBmaXhlcyBhbmQgYnkgYWRk
aW5nIGEgc3RhYmxlIHRhZywgdGhhbmtzIQ0KPg0KPktpbmQgcmVnYXJkcw0KPlVmZmUNCj4NCj4N
Cj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgfCAzICsrKw0K
Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPj4gYi9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLW9mLWFyYXNhbi5jDQo+PiBpbmRleCA4MjljY2VmODc0MjYuLjAxMmQ1MmUxYWJlZSAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4+IEBAIC0xMTk5LDE2ICsx
MTk5LDE5IEBAIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX29mX2RhdGENCj4+IHNkaGNpX2Fy
YXNhbl92ZXJzYWxfZGF0YSA9IHsgIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX29mX2RhdGEN
Cj5pbnRlbF9rZWVtYmF5X2VtbWNfZGF0YSA9IHsNCj4+ICAgICAgICAgLnNvY19jdGxfbWFwID0g
JmludGVsX2tlZW1iYXlfc29jX2N0bF9tYXAsDQo+PiAgICAgICAgIC5wZGF0YSA9ICZzZGhjaV9r
ZWVtYmF5X2VtbWNfcGRhdGEsDQo+PiArICAgICAgIC5jbGtfb3BzID0gJmFyYXNhbl9jbGtfb3Bz
LA0KPj4gIH07DQo+Pg0KPj4gIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX29mX2RhdGEgaW50
ZWxfa2VlbWJheV9zZF9kYXRhID0gew0KPj4gICAgICAgICAuc29jX2N0bF9tYXAgPSAmaW50ZWxf
a2VlbWJheV9zb2NfY3RsX21hcCwNCj4+ICAgICAgICAgLnBkYXRhID0gJnNkaGNpX2tlZW1iYXlf
c2RfcGRhdGEsDQo+PiArICAgICAgIC5jbGtfb3BzID0gJmFyYXNhbl9jbGtfb3BzLA0KPj4gIH07
DQo+Pg0KPj4gIHN0YXRpYyBzdHJ1Y3Qgc2RoY2lfYXJhc2FuX29mX2RhdGEgaW50ZWxfa2VlbWJh
eV9zZGlvX2RhdGEgPSB7DQo+PiAgICAgICAgIC5zb2NfY3RsX21hcCA9ICZpbnRlbF9rZWVtYmF5
X3NvY19jdGxfbWFwLA0KPj4gICAgICAgICAucGRhdGEgPSAmc2RoY2lfa2VlbWJheV9zZGlvX3Bk
YXRhLA0KPj4gKyAgICAgICAuY2xrX29wcyA9ICZhcmFzYW5fY2xrX29wcywNCj4+ICB9Ow0KPj4N
Cj4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBzZGhjaV9hcmFzYW5fb2ZfbWF0
Y2hbXSA9IHsNCj4+IC0tDQo+PiAyLjE3LjENCj4+DQo=
