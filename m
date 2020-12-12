Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1BBC433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 14:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1F42247F
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 14:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgLLOHS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 12 Dec 2020 09:07:18 -0500
Received: from mga09.intel.com ([134.134.136.24]:25904 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439162AbgLLOHS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 12 Dec 2020 09:07:18 -0500
IronPort-SDR: IgzB9bClQ+C9eLdNNGDPFYWCHNiGyLyaZ8bFhMJn3kyBAO+X73t85M2HDhWDEyEgHmHV8TB9wd
 oh33Gkz+zDyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9832"; a="174693024"
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="174693024"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2020 06:06:36 -0800
IronPort-SDR: Zs66rGBPki8JsW4YHYs5aRbzVvVuO63UQqIGBvN7LbPYX+pCGoPPXh3mAMkPBkyb6vgVINuswc
 9/rKqDjqU3QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,414,1599548400"; 
   d="scan'208";a="376998735"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga007.jf.intel.com with ESMTP; 12 Dec 2020 06:06:35 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 12 Dec 2020 06:06:35 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 12 Dec 2020 06:06:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 12 Dec 2020 06:06:34 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 12 Dec 2020 06:06:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RjKvwL/6aBzrjvfvyettEZwZWST2wubgdV4paPa/rIPH0TJOWMG26O6xtg7zvj9oM9jZnUjP7LOZUKFIpcTp++LqR7xtQtRRJEk1EvsYTQ0GYQJjeCMIpd46VfCAUhOYhj+GbhigNZRS9YvLUahZ9VOas49PZISk/e/6DUvjqLuZDaGncWdiKbVNqwmTvu4nCqmPz5U+Sr/3eRSfJ7EnENhZCcSBYwroncijPfcY6+Eq6PJAai8b7nujdk0PtwUKo43L+shbT9xq0GxfnB8N3CGcqTVHgiGrxP4DNzHx07ECSUFlf1DkB1oA/CPk6r8/a8AcMc2LwtTkeml56Rrz6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIVTrMcIqNlLV1G4BR7tcoXq/2Q9qi/jwWkK6o5AXp8=;
 b=J0lLqCyugdGrD427PhC1UA2NX6a3+08DmZGARHzYbDzZDgIohimoHXc3RvLSK/nxDXeVnzq+K4tvh//9nl26awqJrGmr5LxoiF3Tm92eCayaSvfk4/RZCViV6CIgzcT0i8ea7Uz4Bq5EhvFIf92viipYAi2bEcf57mRzmFo5WNKu275XZCbl7C3k1UTxZ0B/sMmXdsS5Qv79XIbcD83XPalmierfRpveJtkznHF55EKQmyEJqcRmJJRuLkqkBHFJbddMioc1BLa6oqx+86qss7n1zddavWbvNnJFYP1TXk6frjXdsKxM8WawaDaAn0bM0FXu+GJvBfHzyNIFsmTP8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIVTrMcIqNlLV1G4BR7tcoXq/2Q9qi/jwWkK6o5AXp8=;
 b=o6iEM/sqMGUWs2F5Lrar/VuH8bswsITGMblz64U1rNgvNj6Wpum9vnES/0JhtABCPPa7VVCTn5Tz6n5lPF5aY+v7FIwzMAw7dtqrAmkpu1wNbVXDrZmR4FHQrpsVmi+Yo7zhfN2Nkrx6yX6vFSppXqoqs9leljandSSHDAeNPM0=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR11MB1595.namprd11.prod.outlook.com (2603:10b6:4:c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.15; Sat, 12 Dec 2020 14:06:07 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839%3]) with mapi id 15.20.3654.017; Sat, 12 Dec 2020
 14:06:07 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: RE: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v6 4/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWyHkojjbNbOhNAE2Psph8K+UZvqnkKEyAgADGsfCABDU1AIAKaYNg
Date:   Sat, 12 Dec 2020 14:06:07 +0000
Message-ID: <DM6PR11MB2876D9A7836F6C677D20EBB3B8C90@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
 <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com>
 <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CACRpkda9TfKnKSJ+yBEn6uqvAEoTFXy-g-6GqJaUQ0FYHLP3iw@mail.gmail.com>
In-Reply-To: <CACRpkda9TfKnKSJ+yBEn6uqvAEoTFXy-g-6GqJaUQ0FYHLP3iw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.172.237]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9cf4e2ff-f1d3-4d0b-b310-08d89ea7126e
x-ms-traffictypediagnostic: DM5PR11MB1595:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1595673B36CDD88FEB0EB8C6B8C90@DM5PR11MB1595.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suaW1KJpyV6SbIPnkjb9y461Uq6I+UJMw4t3IUoBNRGXHZ18inOnWNf4gfxCb5Kuh2mYlpyNexG1RyCvel/qlWaD8vvx5zMH2MvHq6hYVOj3KHiL6ZgHr/a6RcqzI/RDgShWBBJaMpbMngEBvNI8GkMmxtO6BW/duvigTMM6Ep5o0WgmX4WNW3/adCkEPkkggsy9d1V1t9r6p13u+ZCpE+GrHyZMbKkAqeJEauEK2M7eHr/UPluZc5KjdNwknBZuJuGu2I2wvlqGKPVpirDp1H/oywYOi+82dO+hIWt8T+mxjvInXt94Ab3L67vOnQJs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(2906002)(508600001)(83380400001)(66946007)(66556008)(66446008)(66476007)(64756008)(186003)(26005)(5660300002)(86362001)(6506007)(7696005)(52536014)(8676002)(8936002)(71200400001)(4326008)(33656002)(54906003)(76116006)(9686003)(6916009)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?eitIWG95TFQvU0RHM3dXZ3BpWWZ4b2QyQ1ltUDArNjBwRml0V1lGb01xTE54?=
 =?utf-8?B?VWFJNmFoME5rVmFqWlRITmUyVEIvZXBuTHVqbU8wSXdiSzVjL2RmK0pxcFV5?=
 =?utf-8?B?YTFWUU5MRllNTU41alNhK2RKZ2xKT3g5VEE3dlNWeWdodzB0RzhoZUV6LzNy?=
 =?utf-8?B?OXRNUjR1TkNBUDFWZkYrZ2FyWHA1SEkySWFCRUVaMTE5MDd4YS93aFhHbG01?=
 =?utf-8?B?ZFVQazBUU3pTUEtQY3lYK0N1MTNYNjZVcXpSL2srMjRvcUp0emJvVXlJSkVm?=
 =?utf-8?B?ZjRwZm1Nc2hSUHlkNE4xcmdYSm83RUVPSTRZMDhIekFyalRONXBBNno2OEpH?=
 =?utf-8?B?UkVBSFkwR2p1Y0c3SUxrZ2syK2w2NGhnUjZhbjl6dDRKdzhpdE01ZzVUOUEv?=
 =?utf-8?B?KzU0d1RlczRtTE1VVUxSdzhGU2dITXI0aUd2ZjFrelZ1U3JOc0x2T0IwOElU?=
 =?utf-8?B?R3VIY1plUXRyYVViUVYrT0tyZ2dISUUwTkJUQytYVkg2NmVtTHlsZGxlNmZF?=
 =?utf-8?B?VTc5eUJ1dlE3YjZGRXJINmxSNSsxdXhLMFhHb0Q2U1AvNzllNWczTUdkeE9p?=
 =?utf-8?B?MmZuY21jelRNZEtBZm9kcktaOU9aNDdJelNlN1p6emIyVFJHTkkrbTRCV1k4?=
 =?utf-8?B?bU56YSthM0Z4ZUdpb3JCQXVVRVlVY1E1UDdRdXo1a2hHWkhIUU9UMi8vNkI3?=
 =?utf-8?B?cTBxTjE1b1NWajd3UzIxdmhRSGZaRjB3Z1BaUVNMWFZhampxTGV1dmcrNG9k?=
 =?utf-8?B?Tk01d2JRblNZWlh1cGo0QXh4QkFQUlk4Sy9rTTlkNjJwL2R3N2RMQllSQ3Np?=
 =?utf-8?B?VWJ1aVA5VGhTVUFzRUFFOXNLL2tFbDJVMlNTTWZYSkdNc3NMUERxbDVSKzZ3?=
 =?utf-8?B?S2R6QjlaNlZHSEJINE1wZU1qYW0vYllpNjBRS3Z6dkVZdjltVTlaVkprYzFK?=
 =?utf-8?B?bE16SHdMZW5sUUw3d21qWFRvcEpFVFRveEpKVFdqb2hlWFA3MjhENW1UWkZB?=
 =?utf-8?B?dTlxSWJZYTJ1WmRQY2ZTS3dhb3RFdFlhSllPQVc5ZXVnODFtRnErQnFqZGdp?=
 =?utf-8?B?S1RPNWpyK0ltOVNMekR2TGxwdjArVHFMNDRmaExHQkZuem5OenNIaElGaC9m?=
 =?utf-8?B?UmlSU2krMVRTOWthTG0yZzk1NHhkOUdzem9jTUZBMFY0UGlCV2ZtbVhlTDZX?=
 =?utf-8?B?SUUzWGpEV1BkNktkSUNRSzRkRklnOE4yYU41S1FmM0cwUXBkWTF6UjFDTkY3?=
 =?utf-8?B?R1h5ZnNPTHYyeTR2OXF0TCtWSDVWckZmMmhtRVdZWGFrdGhybStsTERaMGFl?=
 =?utf-8?Q?x4w3tOGim/J3o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf4e2ff-f1d3-4d0b-b310-08d89ea7126e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2020 14:06:07.7627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CxYUGMU6noEl6QM9DlPngyynwJNFBov7LJQ+emUOG0gOFRvAHZT6Nz7wbL/m2Nu9t8GwyaSaci002Rb9wYeVdPdl5+eRpS8YY5O2w1dbhYaFUWfat/Q84LBw2d1GirwA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1595
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTGludXMsDQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpbnVzIFdh
bGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj5TZW50OiBTdW5kYXksIERlY2VtYmVy
IDYsIDIwMjAgNzowMiBBTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1t
YWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Q2M6IFVsZiBIYW5zc29uIDx1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnPjsgSHVudGVyLCBBZHJpYW4NCj48YWRyaWFuLmh1bnRlckBpbnRlbC5j
b20+OyBNaWNoYWwgU2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgbGludXgtDQo+bW1j
IDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgTGludXggQVJNIDxsaW51eC1hcm0tDQo+a2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBT
aGV2Y2hlbmtvLA0KPkFuZHJpeSA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgUmFqYSBT
dWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj48bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBp
bnRlbC5jb20+OyBXYW4gTW9oYW1hZCwgV2FuIEFobWFkDQo+WmFpbmllIDx3YW4uYWhtYWQuemFp
bmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IE1hcmsgR3Jvc3MNCj48bWdyb3NzQGxpbnV4Lmlu
dGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDQvNF0gbW1jOiBzZGhjaS1vZi1hcmFz
YW46IEVuYWJsZSBVSFMtMSBzdXBwb3J0IGZvcg0KPktlZW0gQmF5IFNPQw0KPg0KPk9uIFRodSwg
RGVjIDMsIDIwMjAgYXQgODoxMCBBTSBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaQ0KPjxtdWhh
bW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4gd3JvdGU6DQo+DQo+PiA+WWVhaCBpdCBo
YXMgdG8gYmUgY2FsbGVkIGZyb20gc29tZXdoZXJlLCBpZiB5b3Ugd2FudCBhbiBhYnN0cmFjdGlv
bg0KPj4gPnRvIG1ha2UgdGhlIGRyaXZlciBuZXV0cmFsIHRvIGFueSBtYWNoaW5lLCB0aGVuIHVz
ZSBhIHNlbGVjdG9yDQo+PiA+cmVndWxhdG9yLiBJdCBjYW4gYmUgcGxhY2VkIGFueXdoZXJlIGlu
IHRoZSBrZXJuZWwgYXMgbG9uZyBhcyB5b3UgY2FuDQo+cmVmZXJlbmNlIGl0Lg0KPj4NCj4+IFNv
cnJ5LiBJIGFtIG5vdCByZWFsbHkgYXdhcmUgb2Ygc2VsZWN0b3IgcmVndWxhdG9yLiBDYW4geW91
IHBvaW50IG1lDQo+PiB0byBhbnkgcmVmZXJlbmNlcyBmb3IgdGhpcz8NCj4NCj5JdCBpcyBwYXJ0
IG9mIHRoZSByZWd1bGF0b3Igc3Vic3lzdGVtIGFuZCB0aGUgc3RhbmRhcmQgZnJhbWV3b3JrIHRo
ZXJlIHRvDQo+aGFuZGxlIHJlZ3VsYXRvcnMgd2l0aCBhbiBlbnVtZXJhYmxlIG51bWJlciBvZiBz
cGVjaWZpYyB2b2x0YWdlIGxldmVscy4NCj4NCj4+IElNSE8sIHdlIGRvIG5vdCBuZWVkIHRvIG92
ZXJlbmdpbmVlcmVkIGl0IHRvIGFkZCBjdXN0b20gc2VsZWN0b3INCj4+IHJlZ3VsYXRvciBqdXN0
IHRvIHN1aXQgdGhpcyBLZWVtIEJheSBIVyBkZXNpZ24uDQo+DQo+VGhhdCBjYW4gYmUgc2FpZCBh
Ym91dCBhIGxvdCBvZiB0aGluZ3Mgd2UgbW9kZWwgd2l0aCB2cW1tYy4NCj5Vc2luZyBzdGFuZGFy
ZCBhYnN0cmFjdGlvbnMgbWFrZXMgdGhpbmdzIGVhc2llciBmb3IgbWFpbnRhaW5lcnMuDQo+V2Ug
bW9zdGx5IGRlc2lnbiBhYnN0cmFjdGlvbnMgZm9yIG1haW50ZW5hbmNlIG5vdCBmb3IgdGhlIHNp
bXBsZXN0IHdheSB0bw0KPnNldCBiaXRzIGluIHJlZ2lzdGVycy4NCg0KVGhhbmtzIGZvciB5b3Vy
IGlucHV0LiBJIHdpbGwgdHJ5IG1vZGVsIGl0IHNpbWlsYXIgdG8gY3VycmVudCByZWd1bGF0b3Ig
aW1wbGVtZW50YXRpb24NCnNwZWNpZmljIGZvciBrZWVtIGJheSBTb0Mgd2hlcmUgdGhpcyBrZWVt
IGJheSByZWd1bGF0b3Igd2lsbCBlbmNhcHN1bGF0ZWQgdGhlIA0KU2VjdXJlIE1vbml0b3IgQ2Fs
bGluZyBDb252ZW50aW9uIChTTUNDQykgZHVyaW5nIHZvbHRhZ2Ugb3BlcmF0aW9ucy4NCg0KPg0K
PllvdXJzLA0KPkxpbnVzIFdhbGxlaWoNCg==
