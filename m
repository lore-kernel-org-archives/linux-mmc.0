Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E2DC64E7B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 14:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BBA421D7F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Dec 2020 14:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgLBOir (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Dec 2020 09:38:47 -0500
Received: from mga17.intel.com ([192.55.52.151]:34567 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726071AbgLBOiq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 2 Dec 2020 09:38:46 -0500
IronPort-SDR: 0a1diGOeO5rH45rkDhITB3lRfOLL0zIFxtAdZuFOQYTEy9rW9ejyGOgnUm8GGKDPQclcNf9dVq
 mhqOQAiR0vJw==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="152850617"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="152850617"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 06:38:06 -0800
IronPort-SDR: Q1BJeAJQjjfTRLU8grO/33N/UDH6PtV0h95FNyQ4Z3UhKpnLQN1h5vD8v/yqx4dlzeT0aaR0et
 /5mUmXFbXzAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="316115340"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga007.fm.intel.com with ESMTP; 02 Dec 2020 06:38:06 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 06:38:05 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 06:38:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 06:38:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 06:38:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+L73LiGU0Y90Bpx8r3ostiC/huSVONCcU5tu5mokT6UrlxZEYrPZtgPNpoWAhhwjGNuP5ZAiI/zhFAvOrRBhC396nry3aS8IHEHjUHQOAORvC+EwWVinqpNqRGa1hNxAZXgPJxqDAWyk4OKJBCFL/us7sftyMzl49Pj05vP9phAahb+8NBUTSpFHqIDMDs80+PyRhGybAINWcx9OuYYbQczKwfaViyvLf/Nn5MQ1//vqtGnSeMiEbGqFfu/dkIeHauOy70Kc62uQrir3gUnRhnZ/hmTXYv/I94KVPIqDrlqWVcFkIEOqTdGJXactm2B5OkImNJZOV9tqfFRNMIqvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T33cP8XSfbTvB226zbKucw+1sWtJBqgnCfPwbtXmuCY=;
 b=dpP7Q6WScfxrCaJXk5vFBIt/OTpfkwUrdSbeK0EMDlxq6sJ3JQgc0jtY3ZvVtAL8tRcJF9L2VDcBcJ/7xoXJbP58ZLojUWnPeL2XWVLHjKr3PIFU/sWXsO1JgVltJ+M9ZjM4MbRlsFIb3gSxksStdi1VE9o6eAabMNlwhhlrqWIK1OSzSTK+e00fDzBWGQn6KPrxC0SfqoH4b3q80+90jaKiaIVvVDJhkbb7t+nNfnl9j0V1Mcj+atECCwnReVzJpDOlKxBfxYP+zVXsTiPPhRN/T2dFhz2gUDaygBZBBoQz2Q+JPYW1BBYzp4t3wndbZFJwEUM1O61f/lKQ5f09Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T33cP8XSfbTvB226zbKucw+1sWtJBqgnCfPwbtXmuCY=;
 b=dq5o92F2VK2KUqfJsJlidlQs/mDS63+cCc+EXK7uJWPe4SJ1CHNFm3sXe+iuOA1zsQVTYczsUtt2QBDkx6r/wuZ6e+Ye6Mzmk4Fr4D/V8K9bms439z6Vy13aMfZROmLlThkLr0EBWLD4jlpxk3x/rZWuBgB3mil53/fuw9m1SFc=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR11MB1499.namprd11.prod.outlook.com (2603:10b6:4:8::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Wed, 2 Dec 2020 14:38:02 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::a875:dbdd:a42f:a08f]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::a875:dbdd:a42f:a08f%7]) with mapi id 15.20.3632.018; Wed, 2 Dec 2020
 14:38:02 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Mark Gross <mgross@linux.intel.com>
Subject: RE: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Topic: [PATCH v6 0/4] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
Thread-Index: AQHWyHkhC/MOvuJycUGxjS0kNM5cWKnjodkAgAAZmgCAAARvAIAACBKAgAAQwgCAAAblAP////mQ
Date:   Wed, 2 Dec 2020 14:38:02 +0000
Message-ID: <DM6PR11MB28763C6CF533EE9779BB3528B8F30@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrg5ur3iTp-dAoVqV5fiFgcmt01j9R7z3_i=tqhWW3WNg@mail.gmail.com>
 <20201202122520.GD4077@smile.fi.intel.com>
 <CAPDyKFra1+HPGYjG30LkuPxPyN8mQaZan4+AFLKf7_gvd979PA@mail.gmail.com>
 <CAHp75VeXxPoNqJVQojDC1G3gzJUJEiJs2UOm6kob71Aqa_7v2w@mail.gmail.com>
 <CAPDyKFpfadG2-JPA1PC5Sx1_eM39AQUQTVj=m26Gu_=GQmjicA@mail.gmail.com>
 <CAHp75Vf66eWnJFom66oZZnZ4Rcw0VF0QkGWgM5Mm40mTVt6i4A@mail.gmail.com>
In-Reply-To: <CAHp75Vf66eWnJFom66oZZnZ4Rcw0VF0QkGWgM5Mm40mTVt6i4A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.180.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 659e4034-487c-4d1b-6ee5-08d896cfdf8b
x-ms-traffictypediagnostic: DM5PR11MB1499:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB14996356C33ADCCDACFBC3E1B8F30@DM5PR11MB1499.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3z8jHYUWPVGLg3JZW4UKCLEhF9KRAmheQvIoRCckwacLy4DuOqIDU8Nd6Ca5livjznaUcESi6fT8lkUunZM4N3B8B3efHXA7YH9zzYwYAfCXn0PqTKmqZUG9j1hjX8er5uNY4ofIcDZDgV17NGTiWgmaF1FkbZGNoZhGzmeVhnbV+Qbnakw0Qedez8lo42bxn5flfpN/r81bnEJGEdlTVSsMsHSf35LjXAsnLU34liiXtRafxiex/5RIhKOowxZ2xL7VFuzT/RwwXyNhMF9DgEeaP+71yOdRpg9/T9zEGq4ma0g04cXG95L9Bj4nDW9F
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(7696005)(64756008)(55016002)(66556008)(66446008)(76116006)(9686003)(66476007)(66946007)(4326008)(33656002)(478600001)(52536014)(71200400001)(6506007)(83380400001)(86362001)(5660300002)(186003)(2906002)(26005)(8676002)(316002)(54906003)(8936002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?blFjWGFtczZpMndMUjNYQkxQWFJDSjlzUlRVcjllT2t6SkxtM1djdlA3QzFo?=
 =?utf-8?B?K1RHVXR3L3dwZEppMlpydHMraUM2bGlsd3FzZDEvUkNURzFKQ2ZNa3Y3VHF0?=
 =?utf-8?B?YTRyTWN3TkNHOHFoK0hpS3hHTzREYlAvL0RoUmNOSHRoQk1vdmYzU0tPQUJC?=
 =?utf-8?B?cWxJU09xejh1aHJvN0Flbms5TDBFeVpsQVcxOHkyTDhJL3FaOEE2SWVHUE91?=
 =?utf-8?B?Ui8wSmlyVm8zcDhzOFU5ay9wK0VtS0dua0lmQmpTQVVzYmQxcjFFNzQ3eVlk?=
 =?utf-8?B?UWJ6ME0vYUx5aW8zRHpDS0xQZnRHZ3Fva29TVGFjOEdHTDhrc2ZUeiszbndE?=
 =?utf-8?B?VllNOFhPTXZmTlBpbW0vTzFLSkQ2S0pEK0tSN2h2dnZCRnZqeUxzY2ZzWG9i?=
 =?utf-8?B?NlQvT0RaU0trOWhyQWkrSEVlVk1GbHR6alorTTJlSWlkQTZ0ZWJlN1hmMGZZ?=
 =?utf-8?B?RFBuOTBlYThqbGQxdUdEbWdMeWRTVU94Vk4zbTgvZDFpOE1UVkdEbWJnNnFm?=
 =?utf-8?B?MlNtT3FicDhhWldIQTlYd3Bkdm9za2NJYnR4aC9DbVo0QlpHcXpYVzdEWUFN?=
 =?utf-8?B?bHZpQytYVDNxb3g3MVdYM1lnZmhON2RYNG5ERXhyRjNudXMzTFBMbDZseko2?=
 =?utf-8?B?VkdoZTdJdTNUV0k0THVURjRGN2xjcm1VK3lQZVhlTlc1WUxMcDk0ZVp1WkZ2?=
 =?utf-8?B?UjdOZ1NsRkNKSHBwWWxrVG1nSUxVbUtGNW5FWTNnaHhnakYyZzNETE5NOG1R?=
 =?utf-8?B?ckU1V05iSDRwL000SE4wa2pTbDZsQnN0aUU3TTZseXpxcVhzYm9ETkJOSkdL?=
 =?utf-8?B?bnRmY0RtK082QkFnM3drWHBmVXF1aW1sNVZKTTlmMGljM2lEcU1lMlkxbEli?=
 =?utf-8?B?dlZxL09GbCtqRmVFeXBMNnl5Um05eHo4ckdNdjYrYmhVMFU5Um1XaXE2WnNE?=
 =?utf-8?B?d2ZkVXRLT0VHTEJkRW5Ob29qZi81VTBvRlVMYmp4UUUrVWcvczNHbkxQZHVH?=
 =?utf-8?B?MVliMm1zQnlyRHpsSExCUUNHZXduQy85cVQxc0hSNWl0WGZNV0pVZTFOc2Jv?=
 =?utf-8?B?UG1UcUljZU9NbHZCK3hYcXNxNXBjZDlBQ25jbHF2YlNjVFRxWm9xSnpoUTRF?=
 =?utf-8?B?UGpkaGxlcDVjZEpnK2RMcnFIVTRkUWcvS3h5UzVKZUZMMGM5dlBiN1VvRHl6?=
 =?utf-8?B?UG02Zjl5RGJiZ1J4RG9EVHVJaExubm5UcnlTWFFnNDV0OWhPSTJNcE5CSkx3?=
 =?utf-8?B?YmFPZWl1QysweTRuYTZseHNlaEcvbmZOc1lzV3JhWXE3U052WmZYV2NybDUw?=
 =?utf-8?Q?/g05/eYacW+Z0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 659e4034-487c-4d1b-6ee5-08d896cfdf8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 14:38:02.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AM2wRglIdvgp97cKI+JsrrpwFqXxwfk+bbQy/SEXiIZxSl66dpMTvL2ZcqfeaVC/bphtrJgwTsctSo6KmwNur8ptfNGTRzj7vODWXmA7V6fEeb2yuAf1SjstPqhDYHo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1499
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8
YW5keS5zaGV2Y2hlbmtvQGdtYWlsLmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIERlY2VtYmVyIDIs
IDIwMjAgMTA6MzUgUE0NCj5UbzogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
DQo+Q2M6IFNoZXZjaGVua28sIEFuZHJpeSA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsg
TGludXMgV2FsbGVpag0KPjxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+OyBadWxraWZsaSwgTXVo
YW1tYWQgSHVzYWluaQ0KPjxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT47IEh1
bnRlciwgQWRyaWFuDQo+PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgTWljaGFsIFNpbWVrIDxt
aWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IGxpbnV4LQ0KPm1tY0B2Z2VyLmtlcm5lbC5vcmc7IExp
bnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsNCj5MaW51eCBL
ZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgUmFqYSBT
dWJyYW1hbmlhbiwNCj5MYWtzaG1pIEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBp
bnRlbC5jb20+OyBXYW4gTW9oYW1hZCwNCj5XYW4gQWhtYWQgWmFpbmllIDx3YW4uYWhtYWQuemFp
bmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IE1hcmsNCj5Hcm9zcyA8bWdyb3NzQGxpbnV4Lmlu
dGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY2IDAvNF0gbW1jOiBzZGhjaS1vZi1hcmFz
YW46IEVuYWJsZSBVSFMtMSBzdXBwb3J0IGZvcg0KPktlZW0gQmF5IFNPQw0KPg0KPk9uIFdlZCwg
RGVjIDIsIDIwMjAgYXQgNDoxMCBQTSBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9y
Zz4NCj53cm90ZToNCj4+IE9uIFdlZCwgMiBEZWMgMjAyMCBhdCAxNDowOSwgQW5keSBTaGV2Y2hl
bmtvDQo+PGFuZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPj4gPiBPbiBXZWQsIERl
YyAyLCAyMDIwIGF0IDI6NDQgUE0gVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+
DQo+d3JvdGU6DQo+DQo+Li4uDQo+DQo+PiA+IE15IHBvaW50IGlzIHRoYXQgaXQgbWF5IGJlICpu
b3QqIGEgcGluIGNvbnRyb2wgYXQgYWxsLg0KPj4NCj4+IFNvcnJ5LCBidXQgSSBkb24ndCBxdWl0
ZSBmb2xsb3csIHdoYXQgaXMgKm5vdCogYSBwaW5jdHJsPw0KPj4NCj4+IEFjY29yZGluZyB0byB0
aGUgaW5mb3JtYXRpb24gSSBoYXZlIHJlY2VpdmVkIGZyb20gdGhlIHByZXZpb3VzDQo+PiBkaXNj
dXNzaW9ucyBbMV0sIGl0J3MgY2xlYXIgdG8gbWUgdGhhdCB0aGUgQVJNIFNNQyBjYWxsIGVuZHMg
dXANCj4+IGNoYW5naW5nIHNldHRpbmdzIGZvciB0aGUgSS9PLXBhZHMuIE9yIGRpZCBJIGdldCB0
aGF0IHdyb25nPw0KPg0KPkknbSBkaXNjdXNzaW5nIHRoZSBwb3NzaWJsZSBpbXBsaWNhdGlvbiBv
ZiB0aGUgc29sdXRpb24gKGZha2luZyBwaW4NCj5jb250cm9sKSB5b3UgYXJlIHByb3Bvc2luZy4N
Cj5JbiB0aGlzIGNhc2Ugd2Uga25vdyB0aGF0IGl0J3MgYSBwaW4gY29udHJvbCAqdW5kZXIgdGhl
IGhvb2Qgb2YgSVBDKg0KPighKSBidXQgaW4gYW5vdGhlciBoYXJkd2FyZSBnZW5lcmF0aW9uIGl0
IG1heSBiZSwgZm9yIGV4YW1wbGUsY3VzdG9tIHZvbHRhZ2UNCj5yZWd1bGF0b3IuDQo+DQo+V2hh
dCB5b3UgYXJlIHByb3Bvc2luZyBzZWVtcyB0byBtZSBzdWJvcHRpbWFsIGFuZCBhY3R1YWxseSBs
eWluZyBhYm91dA0KPmhhcmR3YXJlLiBCZWNhdXNlIHdlIGRvIG5vdCBoYXZlIGRpcmVjdCBhY2Nl
c3MgdG8gY29udHJvbCB0aGlzIHBhZC4NCj5XaGF0IHdlIGhhdmUgaXMgYW4gSVBDIHRvIGZpcm13
YXJlLiBBbmQgaXQncyBub3Qgb3VyIGJ1c2luZXNzIHdoYXQgaXMgdW5kZXINCj50aGUgaG9vZC4N
Cj4NCj5JdCBzZWVtcyBpdCB3YXMgYSBtaXN0YWtlIHRvIHRhbGsgYWJvdXQgdGhlc2UgZGV0YWls
cyBpbiB0aGUgZmlyc3QgcGxhY2UgYmVjYXVzZQ0KPml0IGJyaW5ncyBtb3JlIGNvbmZ1c2lvbiBh
Ym91dCBoYXJkd2FyZS4gU28sIGNvbnNpZGVyIHRoYXQgaXQncyBub3QgYSBwaW4NCj5jb250cm9s
IGZyb20gT1MgcGVyc3BlY3RpdmUsIGJ1dCBhIGZpcm13YXJlIG1hZ2ljLg0KDQpNYXliZSB0aGVy
ZSBpcyBzb21lIG1pc3VuZGVyc3RhbmRpbmcgcmVnYXJkaW5nIG15IHN0YXRlbWVudCBpbiBwcmV2
aW91cyBkaXNjdXNzaW9uLg0KSSBxdW90ZWQgIklPIFBhZCIgYmFzZWQgb24gdGhlIHN0YXRlbWVu
dCBpbiBEYXRhYm9vayBDRkdbMV1bMTA6N10gZm9yIEFPTiByZWdpc3Rlci4NCkZyb20gdGhlIERh
dGFib29rIGl0c2VsZiB3aXRoIGFkZGl0aW9uYWwgY29uZmlybWF0aW9uIGZyb20gS2VlbSBCYXkg
SFcgU09DIERlc2lnbiBBcmNoaXRlY3QsDQp0aGVyZSBpcyBubyBkaXJlY3QgY29udHJvbCBvZiB0
aGVzZSBBT04gcmVnaXN0ZXIgYml0cyBmcm9tIEdQSU8gcGFkcy4gDQoNCj4NCj4tLQ0KPldpdGgg
QmVzdCBSZWdhcmRzLA0KPkFuZHkgU2hldmNoZW5rbw0K
