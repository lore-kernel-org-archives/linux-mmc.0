Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B617C4363A
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB6C20853
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 18:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Zspce4Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgJESyq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 14:54:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:54840 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgJESyp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 5 Oct 2020 14:54:45 -0400
IronPort-SDR: 8xZJwIUdAidONk86Yfw07FTi1s8KQAyJolbYblkvkJMs0n7JiCXK0TmUNTc0knopKlENXZPBzL
 7h0TpWFGsJXQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="227980024"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="227980024"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 11:54:21 -0700
IronPort-SDR: LZw9gjrr745dxkbXVYuVHe5iZ9Cm7Ryq8rLT1O2y4gl2tSdglcXjKMpZhdYPQGcTwRSTC4/ajT
 sDRCJhha0c+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; 
   d="scan'208";a="295951429"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga007.fm.intel.com with ESMTP; 05 Oct 2020 11:54:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 10:04:15 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 5 Oct 2020 10:04:15 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 5 Oct 2020 10:04:12 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.56) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 5 Oct 2020 10:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VhgGe3fQ9TtXIh4cp60JtohS4w4s+00ztSMqzokjYklIaDr2lFfkbtcmO8vjowCWfa+MclKZpPbEqUqAr0khSaDJvP48xIfgk7JPVhmVreex1pMrmsAj9Kwdo7Tb51SfTK0+uYJdMzicxqYFGvl8Wt9dRGerLz4MNGm5LdFg2C7/5keM6dokAkTCoL35xj2HxQDOOlsn/2hIzJ1xmyt4dnqTZbOW+BWw1CfRKtj02XZUc7V4WNGGlSmn+86DZy69efVKsjBufGmNGEvFOm4KO+X0HEMm5uLsWlvsMht/qHwfPRQ3kVLOZffUdMiSyCWohlsx9UrVE3h3jOwlZAYkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0Mwi2WcvK20TiqOC0grKX+TpP3NhH+WGi/nwvkDWNo=;
 b=RGSo20S0gvBx3yYeQ7Nfm4Q8y6PsFSgrhYevZnw1qfg06JyaqTyQLVFOoiOWNJ8a9mpgqURlSdNbHqpkbOPBE2Nf1wcJ8zff0LL9lBqqipeihpDyo76lrEkIvnMBozMHq0DQJOQioXiJx9yh++4+rldGKWHtSobRHuYkdMUIZF12BD4p+3DlCX6vQxwh8Pdj8MatxcuwOgrUSBX8YDqTB1mhr100SWVdMoaGNLtOg7bpmUDEpPYu6ZGXC/SSYGWyq7Ft4Uhspdvp3sLFYiygxAmlMSm0zi/bAD54mgyrMBCH6vr7uVeqLV7l7PIbXNfb2KQOpTwOPywKmWwgNiJuig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0Mwi2WcvK20TiqOC0grKX+TpP3NhH+WGi/nwvkDWNo=;
 b=Zspce4Uo6Ouolkk4l0OncC8E3Ll1f31TSJbIRzMsES9V9DYFOkvp5TJZU9rhpnTH5x/iF2FCChZqVRvYnVkjKUXiyog/RT1WhO9+AteJtPfx+7BDkwpzfeiKDGHkowk2kAMMkA+VL9JqVloKmE/mfsv/QN6IQ+GArFziC2jWy8I=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by SJ0PR11MB5086.namprd11.prod.outlook.com (2603:10b6:a03:2d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34; Mon, 5 Oct
 2020 17:04:10 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.043; Mon, 5 Oct 2020
 17:04:10 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Subject: RE: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAACt8AIAAMNyAgAAQH4CABEzPQIAAA8WAgACDndA=
Date:   Mon, 5 Oct 2020 17:04:10 +0000
Message-ID: <BYAPR11MB3015F4E8FDF3CB1273A35EFAB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
 <20201002105840.GE906@bogus>
 <1b714566-d6dd-ead1-322e-f92847b923f3@xilinx.com>
 <20201002145115.GA6520@bogus>
 <BYAPR11MB30151480E71BBA232E9B0ADEB80C0@BYAPR11MB3015.namprd11.prod.outlook.com>
 <20201005084441.znou7licvvtomva4@bogus>
In-Reply-To: <20201005084441.znou7licvvtomva4@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d66f5317-6b3f-4255-cdf1-08d86950ad8e
x-ms-traffictypediagnostic: SJ0PR11MB5086:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5086002A6DC2A2CF34B3BF8CB80C0@SJ0PR11MB5086.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v8b30d1caZI0eW++LNYSl5PrKKxa9BI3zEz7FFJg89xmZm60y+X3Ru3CTKzGpN4T8OO61oWvfpECUdR50R9Ratf4b/1Wpxj/JxjQ9ObIe2kwoKi2yXK/MMlBYm3dTCkkHXfZLv2uZyxdjWS25v/r0AcwqucL1NwxAN05S3RztjYeIhARs77m7SrkMRbQQLuiv5gB11typlaCjtDReg7cnIhsASVr78H9DuqKG1NuUhG+2hf3eHKMryaB6x433MH2tbJu9h3Les2Lge969KjnMznFRFBiFsfX3guEeLPo+ZgXudEi78rUxy3pQGBwGGMB0zpr5mbVI5QP7aQbxrv0Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(64756008)(66446008)(26005)(2906002)(7696005)(66556008)(6506007)(66476007)(33656002)(5660300002)(66946007)(52536014)(6916009)(186003)(71200400001)(76116006)(55016002)(8936002)(107886003)(316002)(9686003)(478600001)(8676002)(86362001)(83380400001)(54906003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VbOU30v38VxFdZexj3OYgXcpQz2Ms5O/suYc2x0fxRw4bACIzicBdS3abd/qaaKDZfyfxv9H38SCmWaoAUqWUuxa6ygjgIju8yv5VlbHksrd87rxmbz+dOqtDUtCOVKS9ixTiGhLQiqZUAJnFIeQSPaM5hxd77Px5LpwcOAnmC/dNDvyTSILt88bCnnO1WTAgJK3EI7vlkhgNO18OQlxPqmOnkLOYLSRUPISnAQshmWgDDzedAebXUXWKFA9GItnUMAAH/JD161kJchYmwzMd9icf9TXSRvyvafCZqBkabicn2MZnjtKlo584tiUJA2Xgut2b5qh8O1P2kbtPMn0k3l7yYlE2kdSMptRX+8jrxz2FCazyuUcG5s/L35Lec+hOr4jEbNvJT/Ec7Qj95ZdAGbnBwwm+lFygpPfHmd3WA1/psmP4Abid8Kc8/1fkjdIeoxDvL4kEkdRG8YVSFxKRekFTYVHyKYbwK9dZ00XDO5gx9ZDvPQtUb/yTIUFhRD6cuB4x2Ey5WMMpbSyjNOD28UoFVBTsI9CGYM1f4xMtVRtQE1O7/iSLH/gdVGRlf1w8k9W/H7METkEBruAAxuX2akVNkyKc1QduuYQqatZNO//ichMbBdtw4FSAZ7UHBfjqdAylTbk+IYaatOcBaEqmA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d66f5317-6b3f-4255-cdf1-08d86950ad8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2020 17:04:10.1453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rDrpXcigLUJJ4De3HA+EZUjOC5NqE66ehRm/mLlTiephbadSVE4T14xqeIU1/B6VUVDPQf+QC6YYRAs+U6OFy3Q2x9FJqBx1qUU1LASXayX9oc+msDv0ZEkI6u3BneEd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5086
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFN1ZGVlcCBIb2xsYSA8c3Vk
ZWVwLmhvbGxhQGFybS5jb20+DQo+U2VudDogTW9uZGF5LCBPY3RvYmVyIDUsIDIwMjAgNDo0NSBQ
TQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQuaHVzYWluaS56dWxr
aWZsaUBpbnRlbC5jb20+DQo+Q2M6IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVrQHhpbGlueC5j
b20+OyBIdW50ZXIsIEFkcmlhbg0KPjxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IHVsZi5oYW5z
c29uQGxpbmFyby5vcmc7IGxpbnV4LQ0KPm1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj48bGFrc2htaS5iYWkucmFqYS5zdWJy
YW1hbmlhbkBpbnRlbC5jb20+OyBhcm5kQGFybmRiLmRlOyBXYW4gTW9oYW1hZCwNCj5XYW4gQWht
YWQgWmFpbmllIDx3YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT4NCj5TdWJq
ZWN0OiBSZTogW1BBVENIIHYyIDIvM10gZmlybXdhcmU6IEtlZW0gQmF5OiBBZGQgc3VwcG9ydCBm
b3IgQXJtIFRydXN0ZWQNCj5GaXJtd2FyZSBTZXJ2aWNlIGNhbGwNCj4NCj5PbiBNb24sIE9jdCAw
NSwgMjAyMCBhdCAwODozNzoxM0FNICswMDAwLCBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSB3
cm90ZToNCj4+IEhpIFN1ZGVlcCwNCj4+DQo+PiBJIGFtIGZhY2luZyBhbiBlcnJvciBkdXJpbmcg
c2VuZGluZyB5ZXN0ZXJkYXkuDQo+PiBJIHJlc3BvbnNlIGFnYWluIHRvIHlvdXIgZmVlZGJhY2sg
YXMgYmVsb3cNCj4+DQo+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID5Gcm9tOiBT
dWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPj4gPlNlbnQ6IEZyaWRheSwgT2N0
b2JlciAyLCAyMDIwIDEwOjUxIFBNDQo+PiA+VG86IE1pY2hhbCBTaW1layA8bWljaGFsLnNpbWVr
QHhpbGlueC5jb20+DQo+PiA+Q2M6IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1h
ZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT47DQo+PiA+SHVudGVyLCBBZHJpYW4gPGFkcmlh
bi5odW50ZXJAaW50ZWwuY29tPjsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4+ID5saW51eC0g
bW1jQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPj4gPmxpbnV4LSBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBSYWphIFN1YnJhbWFuaWFuLCBM
YWtzaG1pIEJhaQ0KPj4gPjxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVsLmNvbT47
IGFybmRAYXJuZGIuZGU7IFN1ZGVlcCBIb2xsYQ0KPj4gPjxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
IFdhbiBNb2hhbWFkLCBXYW4gQWhtYWQgWmFpbmllDQo+PiA+PHdhbi5haG1hZC56YWluaWUud2Fu
Lm1vaGFtYWRAaW50ZWwuY29tPg0KPj4gPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIgMi8zXSBmaXJt
d2FyZTogS2VlbSBCYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0NCj4+ID5UcnVzdGVkIEZpcm13YXJl
IFNlcnZpY2UgY2FsbA0KPj4gPg0KPj4gPkhpIE1pY2hhbCwNCj4+ID4NCj4+ID5PbiBGcmksIE9j
dCAwMiwgMjAyMCBhdCAwMzo1MzozM1BNICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6DQo+PiA+
PiBIaSBTdWRlZXAsDQo+PiA+Pg0KPj4gPj4gT24gMDIuIDEwLiAyMCAxMjo1OCwgU3VkZWVwIEhv
bGxhIHdyb3RlOg0KPj4gPj4gPiBIaSBNaWNoYWwsDQo+PiA+PiA+DQo+PiA+PiA+IE9uIEZyaSwg
T2N0IDAyLCAyMDIwIGF0IDEwOjIzOjAyQU0gKzAyMDAsIE1pY2hhbCBTaW1layB3cm90ZToNCj4+
ID4+ID4+IEhpIFN1ZGVlcCwNCj4+ID4+ID4+DQo+PiA+PiA+PiBPbiAwMS4gMTAuIDIwIDE3OjM1
LCBTdWRlZXAgSG9sbGEgd3JvdGU6DQo+PiA+PiA+DQo+PiA+PiA+IFsuLi5dDQo+PiA+PiA+DQo+
PiA+PiA+Pj4NCj4+ID4+ID4+PiBXaGF0IGFyZSB0aGUgb3RoZXIgdXNlcyBvZiB0aGlzIEtFRU1C
QVlfU0lQXyogPw0KPj4gPj4gPj4+IEZvciBub3cgSSB0ZW5kIHRvIG1vdmUgdGhpcyB0byB0aGUg
ZHJpdmVyIG1ha2luZyB1c2Ugb2YgaXQNCj4+ID4+ID4+PiB1c2luZyBhcm1fc21jY2NfMV8xX2lu
dm9rZSBkaXJlY3RseSBpZiBwb3NzaWJsZS4gSSBkb24ndCBzZWUNCj4+ID4+ID4+PiB0aGUgbmVl
ZCBmb3IgdGhpcyB0byBiZSBzZXBhcmF0ZSBkcml2ZXIuIEJ1dCBkbyBsZXQgdXMga25vdyB0aGUN
Cj4+ID4+ID4+PiBmZWF0dXJlcyBpbXBsZW1lbnRlZCBpbiB0aGUgZmlybXdhcmUuIElmIGl0IGlz
IG5vdCB2MS4xKywNCj4+ID4+ID4+PiByZWFzb25zIGZvciBub3QgdXBncmFkaW5nIGFzIHlvdSBu
ZWVkIHYxLjEgZm9yIHNvbWUgQ1BVIGVycmF0YQ0KPmltcGxlbWVudGF0aW9uLg0KPj4gPj4gPj4N
Cj4+ID4+ID4+IFRoaXMgZHJpdmVyIGhhcyBiZWVuIGNyZWF0ZWQgYmFzZWQgb24gbXkgcmVxdWVz
dCB0byBtb3ZlIGl0IG91dA0KPj4gPj4gPj4gdGhlIG1tYyBkcml2ZXIuIEl0IGxvb2tzIHF1aXRl
IGhhY2t5IHRvIGhhdmUgYXJtX3NtY2NjX3JlcyBhbmQNCj4+ID4+ID4+IGNhbGwNCj4+ID4+ID4+
IGFybV9zbWNjY19zbWMoKSBhbHNvIHdpdGggc29tZSBJRHMgd2hlcmUgaXQgaXMgdmlzaWJsZSB0
aGF0IHRoZQ0KPj4gPj4gPj4gcGFydCBvZiBJRCBpcyBqdXN0IGJhc2VkIG9uIGFueSBzcGVjLg0K
Pj4gPj4gPg0KPj4gPj4gPiBPSywgZHJpdmVyIGlzIGZpbmUgYnV0IG5vIGR0LWJpbmRpbmdzIGFz
IGl0IGlzIGRpc2NvdmVyYWJsZS4gSXQNCj4+ID4+ID4gY2FuIGFsc28gYmUganVzdCBhIHdyYXBw
ZXIgbGlicmFyeSBpbnN0ZWFkIGFzIGl0IG5lZWRzIG5vDQo+PiA+PiA+IGV4cGxpY2l0IGluaXRp
YWxpc2F0aW9uIGxpa2UgZHJpdmVycyB0byBzZXR1cC4NCj4+ID4+DQo+PiA+PiBJIGFtIGZpbmUg
d2l0aCBpdC4gRG8gd2UgaGF2ZSBhbnkgZXhhbXBsZSB3aGljaCB3ZSBjYW4gcG9pbnQgaGltIHRv
Pw0KPj4gPj4NCj4+ID4NCj4+ID5Zb3Ugc2VlbSB0byBoYXZlIGZpZ3VyZWQgdGhhdCBvdXQgYWxy
ZWFkeSB3aXRoIFNPQ19JRCBleGFtcGxlLg0KPj4gPlRoYXQgd2FzIHF1aWNrIEkgbXVzdCBzYXkg
8J+YhC4NCj4+ID4NCj4+ID4+DQo+PiA+PiA+DQo+PiA+PiA+PiBBbHNvIGluIHYxIGhlIGlzIGp1
c3QgY2FsbGluZyBTTUMuIEJ1dCBtYXliZSB0aGVyZSBpcyBnb2luZyBhDQo+PiA+PiA+PiBuZWVk
IHRvIGNhbGwgSFZDIGluc3RlYWQgd2hpY2ggaXMgc29tZXRoaW5nIHdoYXQgZGV2aWNlIGRyaXZl
cg0KPj4gPj4gPj4gc2hvdWxkbid0IGRlY2lkZSB0aGF0J3Mgd2h5IElNSE8gZG9pbmcgc3RlcCB2
aWEgZmlybXdhcmUgZHJpdmVyDQo+PiA+PiA+PiBpcyBtdWNoIGJldHRlcg0KPj4gPmFwcHJvYWNo
Lg0KPj4gPj4gPg0KPj4gPj4gPiBBZ3JlZWQgYW5kIG9uZSBtdXN0IHVzZSBhcm1fc21jY2NfZ2V0
X2NvbmR1aXQgb3Igc29tZXRoaW5nIHNpbWlsYXIuDQo+PiA+PiA+IE5vIGFkZGl0aW9uYWwgYmlu
ZGluZ3MgZm9yIGVhY2ggYW5kIGV2ZXIgcGxhdGZvcm0gYW5kIGRyaXZlciB0aGF0DQo+PiA+PiA+
IHVzZXMgU01DQ0MgcGxlYXNlLg0KPj4gPj4gPg0KPj4gPj4gPj4gT2YgY291cnNlIGlmIHRoZXJl
IGlzIGEgYmV0dGVyL2NsZWFuZXIgd2F5IGhvdyB0aGlzIHNob3VsZCBiZQ0KPj4gPj4gPj4gZG9u
ZSBJIGFtIGhhcHB5IHRvIGdldCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IGl0Lg0KPj4gPj4gPj4N
Cj4+ID4+ID4NCj4+ID4+ID4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsgYWJvdXQgbXkgdGhv
dWdodHMgc3RhdGVkIGFib3ZlLg0KPj4gPj4NCj4+ID4+DQo+PiA+PiBJIGFtIGZpbmUgd2l0aCBp
dC4gVGhlIGtleSBwb2ludCBpcyB0byBoYXZlIHRoZXNlIHNvcnQgaXQgb3V0DQo+PiA+PiBiZWNh
dXNlIEkgc2VlIHRoYXQgYSBsb3Qgb2YgZHJpdmVycyBqdXN0IHNpbXBseSBjYWxsIHRoYXQgU01D
cyBmcm9tDQo+PiA+PiBkcml2ZXJzIHdoaWNoIGlzIElNSE8gd3JvbmcuDQo+PiA+Pg0KPj4gPg0K
Pj4gPlN1cmUsIHNvcnJ5IEkgZGlkbid0IGV4cHJlc3MgbXkgY29uY2VybiBwcm9wZXJseS4gSSB3
YW50IHRvIGF2b2lkIGR0DQo+PiA+YmluZGluZ3MgZm9yIHRoZXNlIGFuZCB1c2UgdGhlIFNNQ0ND
IGRpc2NvdmVyeSB3ZSBoYXZlIGluIHBsYWNlIGFscmVhZHkgaWYNCj5wb3NzaWJsZS4NCj4+ID4N
Cj4+ID5JZiB0aGlzIGRyaXZlciBoYWQgY29uc3VtZXJzIGluIHRoZSBEVCBhbmQgaXQgbmVlZHMg
dG8gYmUgcmVwcmVzZW50ZWQNCj4+ID5pbiBEVCwgaXQgaXMgYSBkaWZmZXJlbnQgc3RvcnkgYW5k
IEkgYWdyZWUgZm9yIG5lZWQgZm9yIGEgZHJpdmVyIHRoZXJlLg0KPj4gPkJ1dCBJIGRvbid0IHNl
ZSBvbmUgaW4gdGhpcyB1c2VjYXNlLg0KPj4NCj4+DQo+PiBEb2VzIGl0IG9rIGlmIEkgZG8gc29t
ZSBjaGVja2luZyBpbiBhcmFzYW4gY29udHJvbGxlciBkcml2ZXIgYXMgYmVsb3cgYW5kDQo+cmVw
cmVzZW50ZWQgaXQgaW4gdGhlIERUIG9mIGFyYXNhbixzZGhjaS55YW1sOg0KPj4gVGhpcyBpcyB0
byBlbnN1cmUgdGhhdCBmb3IgS2VlbSBCYXkgU09DIHNwZWNpZmljLCB0aGUgZmlybXdhcmUgZHJp
dmVyIG11c3QgYmUNCj5jb25zdW1lLg0KPj4NCj4+IAlpZiAob2ZfZGV2aWNlX2lzX2NvbXBhdGli
bGUobnAsICJpbnRlbCxrZWVtYmF5LXNkaGNpLTUuMS1zZCIpKSB7DQo+PiAJCXN0cnVjdCBkZXZp
Y2Vfbm9kZSAqZG47DQo+PiAJCXN0cnVjdCBncGlvX2Rlc2MgKnVoczsNCj4+DQo+PiAJCWRuID0g
b2ZfZmluZF9ub2RlX2J5X25hbWUoTlVMTCwgImtlZW1iYXlfZmlybXdhcmUiKTsNCj4NCj5Zb3Ug
aGF2ZSBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uIGZ1bmN0aW9uIGFzIE1pY2hhbCBwcmVm
ZXJzLCBJIGhhdmUgbm8NCj5vYmplY3Rpb25zIGZvciB0aGF0LiBCdXQgcGxlYXNlIG5vIGtlZW1i
YXlfZmlybXdhcmUgbm9kZSBpbiBEVC4NCj5Zb3UgY2FuIGltcGxlbWVudCB0aGlzIGFzIGEgZHJp
dmVyIG9yIHNpbXBsZSBzbWNjYyBiYXNlZCBmdW5jdGlvbiBsaWJyYXJ5DQo+d2l0aG91dCBEVCBu
b2RlIHVzaW5nIFNNQ0NDIGdldF92ZXJzaW9uLiBJIGhvcGUgdGhlIGZpcm13YXJlIGdpdmVzIGVy
cm9yIGZvcg0KPnVuaW1wbGVtZW50ZWQgRklEcywgdGhlcmVieSBlbGltaW5hdGluZyB0aGUgbmVl
ZCBmb3IgYW55IERUIG5vZGUgb3IgY29uZmlnDQo+b3B0aW9uLg0KVG8gYmUgY2xhcmlmeSBrZWVt
YmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uIGZ1bmN0aW9uIGFzIE1pY2hhbCdzIHByZWZlcnMgaXMg
YWN0dWFsbHkgdXNpbmcgdGhlIGZpcm13YXJlIGRyaXZlci4gVGhpcyBmdW5jdGlvbiBsb2NhdGVk
IGluIGZpcm13YXJlIGRyaXZlci4gDQpJIHdpbGwgY2FsbCB0aGlzIGZ1bmMgZHVyaW5nIHZvbHRh
Z2Ugc3dpdGNoaW5nIGZyb20gYXJhc2FuIGNvbnRyb2xsZXIuIEkgYmVsaWV2ZSB0aGlzIGltcGxl
bWVudGF0aW9uIHJlcXVpcmUgRFQgdG8gc3BlY2lmeSB0aGUgY29tcGF0aWJsZSBuYW1lIGFuZCBt
ZXRob2QgdXNlIGVpdGhlciBzbWMvaHZjLg0KDQpBcmUgeW91IHNheWluZyB0aGF0IGJ5IHVzaW5n
IHNpbXBsZSBzbWNjIGJhc2VkIGZ1bmN0aW9uIGxpYnJhcnkgSSBzaG91bGQgY2FsbCBiZWxvdyBm
dW5jKCkgaW4gYXJhc2FuIGNvbnRyb2xsZXIuIEZvciBleGFtcGxlDQoxKSBhcm1fc21jY2NfZ2V0
X3ZlcnNpb24odm9pZCkNCjIpIGFybV9zbWNjY192ZXJzaW9uX2luaXQoYXJtX3NtY2NjX2dldF92
ZXJzaW9uKCksIFNNQ0NDX0NPTkRVSVRfU01DKTsNCjMpIGFybV9zbWNjY18xXzFfaW52b2tlKEtF
RU1CQVlfU0VUX1NEX1ZPTFRBR0VfRlVOQ19JRCwgdm9sdGFnZV92YWx1ZSAsICAmcmVzKTsNCg0K
UGxlYXNlIGFkdmljZXMuDQpUaGFua3MNCg0KPg0KPi0tDQo+UmVnYXJkcywNCj5TdWRlZXANCg==
