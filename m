Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F10C4338F
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 05:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB3361052
	for <linux-mmc@archiver.kernel.org>; Mon,  9 Aug 2021 05:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhHIFQq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 9 Aug 2021 01:16:46 -0400
Received: from mga04.intel.com ([192.55.52.120]:4405 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhHIFQp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 9 Aug 2021 01:16:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="212765318"
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="212765318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2021 22:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,305,1620716400"; 
   d="scan'208";a="674087102"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2021 22:16:25 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Sun, 8 Aug 2021 22:16:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Sun, 8 Aug 2021 22:16:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Sun, 8 Aug 2021 22:16:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/cVbQkJKGnjFeDBvgFckxxnTJDh5z6vHZU+6AQqp77nM4IOSrNYM5N1n6OpvHNKJao4aW9vOZf2NVXYNULP1E+HAY/1ScZRiuXzxVzpBDjjdoRZKwAw7cf/ZZaaxoE+DVIsOhWb+ryCTNnGvtx8FfZful701hWFI7O9LzhPijs2eYczr/7JxQsLc2A+lV9LDJqiwZD16+CVtRa0fCanLr5T4yeeWLi3iR19C4O3/z4qfRLny3DOu+pCSuwBamz6FZSS0RfW0NAi9oKnvdvlNAc8uVb6uJ7wfi3Op3Wqe4XEiStprUcsPKjFCtzsZ7DVbzRit0RSa+JJh6pzQ2Vhmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnbDlFmoi0S4zw5lFsnZzBAvgRnEDQMbMG0XrCSnEd8=;
 b=Ovd7yZ0KFKdjBYlwtQuFJFucML5SkcQLqNmUbh4AcvxDS0pacXpVl6VErbhkcxtWwUnKhuYgRToBuAjRZi4bwEITy5C7xfQ2dNlprDSNh00AFOJrjdCpasxhZupIq7RgHupkIjbDg+jSsd6NSB6LWQhg0B8te+1n/wnEbK/q/m5A0CFrepyxnlt6v2IndbrbVbZPh0nIMCOg9d1s3aXQSwnNlhGITki5LctAV4l/xDnpQMnHGkG0+lSTk70KzdHB451nyhd8WRnG3JQXHiNYf52+LtLjUNB+JSjrp5JQIWVo3rY/YGw8gMSmeDGjp92g2Rw8yms5gHZug5oUjkNzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnbDlFmoi0S4zw5lFsnZzBAvgRnEDQMbMG0XrCSnEd8=;
 b=oSRyfyNdA7f+d85uRmRPlbydjBdi6197IuMSJqsXczR7D+wr3nPJ3Q174CFp0/YhU+jCT4GvRF2iiNLbca7vCLQP3DmTrCWTTxHxKr0ksdygctWrhaUnH+ozBnAL73EOR2NjgtdENSe7ECVJ0ggUhrc94OnKcMugNOmwd/YiZJY=
Received: from MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.22; Mon, 9 Aug
 2021 05:16:15 +0000
Received: from MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3]) by MWHPR11MB1789.namprd11.prod.outlook.com
 ([fe80::b81c:ee06:fc82:5fc3%7]) with mapi id 15.20.4394.023; Mon, 9 Aug 2021
 05:16:13 +0000
From:   "A, Rashmi" <rashmi.a@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon <kishon@ti.com>, Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "kris.pan@linux.intel.com" <kris.pan@linux.intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-arasan: Add intel Thunder Bay SOC
 support to the arasan eMMC driver
Thread-Index: AQHXhQzRAwmHks3vwkaXAOpN1lCV0KtmfYEAgAQx92A=
Date:   Mon, 9 Aug 2021 05:16:09 +0000
Message-ID: <MWHPR11MB17891909766F5295AF34B0578CF69@MWHPR11MB1789.namprd11.prod.outlook.com>
References: <20210730063309.8194-1-rashmi.a@intel.com>
 <20210730063309.8194-3-rashmi.a@intel.com>
 <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
In-Reply-To: <CAPDyKFqZ-H3+OnYyyY7y611YrRAAMFq+W65DMfM4wSNvY_fzjA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d49de5f1-ba71-435d-7dca-08d95af4cebb
x-ms-traffictypediagnostic: MW3PR11MB4554:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45546FB10F4B4F22297C3BD28CF69@MW3PR11MB4554.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9AvX5MHqifXGr78x7Ty/7DaWt1LcGwNAzFHvUQH5HPjyMsTScViBttxRYqZRaqLdL42V1bWIZmUOKjZxuiu/FuX5uH/ZtkU2LHPKwmWmvjfriu8LYtYDPWIDx41WWuOXc5UTtX5OuXZ3CKaRuoPs8grd1mWP0cy2lyvCbHE2XiUgcNCbUDYUB+eZAgdTKY5fdJlGvoGY6KLWJL0Rcf9uawzi/7QAOx7xPB3WKF6KjTI00vWvd+T2vv+xXI/+yC0LIMxL9Z0D4a3bv7HHlJvBSFuQtw506cm5hM2mnbpiGMGcEtOtlIbGc/+L6DQMAMZpJyQFnBEvT4YeQCfikkyO/HHWqeY90ia1h9oq26VFubihSOKsslNwzfznySvEvVH1YmOPu0mzwwEB6XG+WezPp78jRxI3ahvyURLJRXJVYvrC34WUBG8zfCrstcB5pWHKnURg2ZD5f6oVav6Z80D6vB+BuZFt4eP3at4xEOV3MG4aQZ5BUB994QfWftzT4+M/jlwU3p0j75+xC2zFXa8FYmFhjQR8KWJaTFt9ndjr9gT4gr+caIVR8jXPmCwN97khNzotp13fapUPfIC5GL8IfuQxA3ge4Dwyvo9iO+RjcqjGBsBDB3gybPOvLgxn4QVzCZHjSN3lCU7xDowvxAQZmz2CjbaAKe8RdCL0+9Y5mq/HYICjfsrTcYMdbyWs1SmjyBwrtD6QaJBIAhRSlQCuNQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(2906002)(55016002)(26005)(8676002)(9686003)(186003)(86362001)(6506007)(53546011)(52536014)(478600001)(83380400001)(76116006)(66946007)(4326008)(66446008)(64756008)(66476007)(66556008)(7696005)(6916009)(316002)(6666004)(71200400001)(38100700002)(122000001)(38070700005)(33656002)(54906003)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bDcrKzliVnlLUTVlZHNoMmowOWc3L2VYUkU0REFoZ2ZYODRxZEwwLzBES3Jw?=
 =?utf-8?B?d2k0M0RMNEdNOTJJSTU4T2pXKytRQzlldXdsM1ZpVGEvN3o4Q3JEd3NqTTB0?=
 =?utf-8?B?QlpycXVKa3NDSDNLOXB5dXM1NEpMWlpLUWE3dytKWmJDWGdPZnpFQzdJcGds?=
 =?utf-8?B?cTAwYklVRHh4citmWXpXZzJaSlVPQTRhNDkrMVVLTURDN2JCd1lrdkJ1VUIy?=
 =?utf-8?B?L3NFS3J4NWFLVzQ5Y2U2V0pXUTZ2SjE5ZVB0NVEydTZTMFcxaGpxdVdnWU9a?=
 =?utf-8?B?S1VCVU0vYmxmaGE1YmtrMTEzaTRHdjJTc0hVQWtPN05vTEQ4SlZNbVVld2l2?=
 =?utf-8?B?T3RVYTNpdDRab0JvZ3pzZ2F3ckhtVjJzWkhSZHZ2elV5TW5LRDd6QmVLL0pT?=
 =?utf-8?B?UURnMU5HSDNSZm9kTmFINUs3TlBUY29wYUJUTERwcGd5UUFiUEdRNnFvSE84?=
 =?utf-8?B?c1R5Vittbm1ocWdzT216eDJmdTE2YTlrb2gxZm9HRjlHa2Y0SER3MDdFd09q?=
 =?utf-8?B?MmlZVXovS1luN01GUXFKNjE1U01wcldoa3ZFSlh4WVNWMEo0Y0ZBWTlmeW40?=
 =?utf-8?B?eXhxZkFNQmJJMUU5dzRNTWk2N3ZvMWx2UjJIZmhUbW9IR3lHVXMybFBZZjgx?=
 =?utf-8?B?Z2ZxZVFXeHBPdVY1VEJITmRKT1krN0hPbHF4dklPRkRCZzhKaDVJYVBZYlBB?=
 =?utf-8?B?eTBDYzY3UzZ0bmcwcVE1eDduVzhuVGxqcW5vbFZYbFJrUndwOHI4ZFFaWDdC?=
 =?utf-8?B?Z3YzWmp6OGRTVXFtSE1uNkEvNWk4R1lINmcwbE9HOFNpdzcyWXpkMW1ybTZ2?=
 =?utf-8?B?dnhwMnlQNUtrWkhKV1o4dXRONTRZUER5NlVMKzVveFdLU0hJRDRoOVRHTVY5?=
 =?utf-8?B?TlEydkxvSDdtQzgxTzlpSmcreDM5Sjg0NTNBTUYyUGlQaktGY1UrOC9LNXVM?=
 =?utf-8?B?YzI5UmZwODlodTdleFlVTitDOTliQWt1QzRONEE2RlMyN3gvM0lKK3g5UWtU?=
 =?utf-8?B?dnZpMDM1MXJhL29Nd0VYSHFwdHdLdUJXbWdnQTZKTk90VDJXUkNUU2N6dGp2?=
 =?utf-8?B?MEk3MnZDZHROTnJTRlFrWktQQ21Ud3p6U0xWZlV6NU1GY2QveEtETkdOcFl2?=
 =?utf-8?B?WnpTbFVXenZsZjBnbmJJVGtrOW5QcElyeTlkc1BnRDlVZUhWbkh6OUxTTzN0?=
 =?utf-8?B?Wkg1dTdJbDNERHBUYy9hZHVNSHBwUWxielBzaURvRFY2SE1FVDZJSXhBTUtL?=
 =?utf-8?B?VnZrMzlnWDZ5eG5EOEw1ODJQaEZ4dlZmUEhVeFlwN0FVeHZ6RGh0M25kUk1C?=
 =?utf-8?B?clNoOTAwYW55S0lnRGFiT1ByVmdmL05iTG5Wem5lYjZqc2puSFFYaEVKMTRX?=
 =?utf-8?B?NC9EZjFyekZtcVQ1Z1VneXoxVVdyWi9FVEkyK2MzU0tDNm9DM281Wklsdmph?=
 =?utf-8?B?NmhDMm0xbWJTVmJUVVlPSHN0azVyUVZ1c1hSL0VhV0NJK1Y4L3NSZFRtb3dW?=
 =?utf-8?B?NytaNU5GT2ExL0RnL3VPNzdmRjVPV0J5bEx0MzZhSm03dit0cWRnR0M2M2hr?=
 =?utf-8?B?T1JHeFdGNVFobE82NlJkQWtLOTBqelZMeEYyRU5MODZpSTJZMEtvV2xteUdM?=
 =?utf-8?B?ajNySXEvTEZ2K01WWEdjTkR6d2ZsTTVkSGNzbkZSaTR4UjlwUDNub2RjYlFV?=
 =?utf-8?B?YzVKbGR6ZzNvbXNhZ0U4b3QzYmNyZVlRYTNhM0F3aUowL0FCdk1VdWVDVklU?=
 =?utf-8?Q?tWsnA0GsY0N74bBj8j/gImVujaNZKsglWBIv7Yb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49de5f1-ba71-435d-7dca-08d95af4cebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 05:16:09.2849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOzZlVuWA/f42oqXTYw5tuqaIBH2Qzc5cvq1ZdK6J53QQ9grM6whICCMrcB/rP4l4OCv7rM5F2VhdP3Wfe2JIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgQXVndXN0IDYsIDIwMjEgNjoz
NiBQTQ0KPiBUbzogQSwgUmFzaG1pIDxyYXNobWkuYUBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1k
cml2ZXJzLXJldmlldy1yZXF1ZXN0QGVjbGlzdHMuaW50ZWwuY29tOyBNaWNoYWwgU2ltZWsNCj4g
PG1pY2hhbC5zaW1la0B4aWxpbnguY29tPjsgbGludXgtbW1jIDxsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnPjsgTGludXgNCj4gQVJNIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZz47IEtpc2hvbiA8a2lzaG9uQHRpLmNvbT47IFZpbm9kIEtvdWwNCj4gPHZrb3VsQGtl
cm5lbC5vcmc+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4Lmlu
dGVsLmNvbT47IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBNYXJrDQo+IEdyb3NzIDxt
Z3Jvc3NAbGludXguaW50ZWwuY29tPjsga3Jpcy5wYW5AbGludXguaW50ZWwuY29tOyBaaG91LCBG
dXJvbmcNCj4gPGZ1cm9uZy56aG91QGludGVsLmNvbT47IFNhbmdhbm5hdmFyLCBNYWxsaWthcmp1
bmFwcGENCj4gPG1hbGxpa2FyanVuYXBwYS5zYW5nYW5uYXZhckBpbnRlbC5jb20+OyBIdW50ZXIs
IEFkcmlhbg0KPiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBWYWlkeWEsIE1haGVzaCBSDQo+
IDxtYWhlc2guci52YWlkeWFAaW50ZWwuY29tPjsgU3Jpa2FuZGFuLCBOYW5kaGluaQ0KPiA8bmFu
ZGhpbmkuc3Jpa2FuZGFuQGludGVsLmNvbT47IERlbWFra2FuYXZhciwgS2VuY2hhcHBhDQo+IDxr
ZW5jaGFwcGEuZGVtYWtrYW5hdmFyQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzNdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBBZGQgaW50ZWwgVGh1bmRlciBCYXkgU09DDQo+IHN1
cHBvcnQgdG8gdGhlIGFyYXNhbiBlTU1DIGRyaXZlcg0KPiANCj4gT24gRnJpLCAzMCBKdWwgMjAy
MSBhdCAwODozMywgPHJhc2htaS5hQGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBS
YXNobWkgQSA8cmFzaG1pLmFAaW50ZWwuY29tPg0KPiA+DQo+ID4gSW50ZWwgVGh1bmRlciBCYXkg
U29DIGVNTUMgY29udHJvbGxlciBpcyBiYXNlZCBvbiBBcmFzYW4gZU1NQyA1LjEgaG9zdA0KPiA+
IGNvbnRyb2xsZXIgSVANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFJhc2htaSBBIDxyYXNobWku
YUBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tPg0KPiANCj4gUmFzaG1pLCBpcyBpdCBzYWZlIHRvIGFwcGx5IHRoaXMgc2Vw
YXJhdGVseSBmcm9tIHRoZSBwaHkgZHJpdmVyL2R0IGNoYW5nZXM/DQo+IFRoZW4gSSBjYW4gcXVl
dWUgdGhpcyB2aWEgbXkgbW1jIHRyZWUsIGlmIHlvdSBsaWtlLg0KTm8sIHRoZSBwaHkgZHJpdmVy
L2R0IGNoYW5nZXMgbXVzdCBnbyB0b2dldGhlciB3aXRoICJtbWM6IHNkaGNpLW9mLWFyYXNhbjog
QWRkIGludGVsIFRodW5kZXIgQmF5IFNPQyBzdXBwb3J0IHRvIHRoZSBhcmFzYW4gZU1NQyBkcml2
ZXIiIHBhdGNoLg0KDQpSZWdhcmRzDQpSYXNobWkNCj4gDQo+IEtpbmQgcmVnYXJkcw0KPiBVZmZl
DQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jIHwg
MjkNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDI4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4gYi9kcml2ZXJzL21tYy9ob3N0
L3NkaGNpLW9mLWFyYXNhbi5jDQo+ID4gaW5kZXggODM5OTY1ZjdjNzE3Li42ZjIwMmZiN2E1NDYg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMNCj4gPiBAQCAtMTg1LDYg
KzE4NSwxMyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNpX2FyYXNhbl9zb2NfY3RsX21hcA0K
PiBpbnRlbF9sZ21fc2R4Y19zb2NfY3RsX21hcCA9IHsNCj4gPiAgICAgICAgIC5oaXdvcmRfdXBk
YXRlID0gZmFsc2UsDQo+ID4gIH07DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBzZGhj
aV9hcmFzYW5fc29jX2N0bF9tYXAgdGh1bmRlcmJheV9zb2NfY3RsX21hcCA9IHsNCj4gPiArICAg
ICAgIC5iYXNlY2xrZnJlcSA9IHsgLnJlZyA9IDB4MCwgLndpZHRoID0gOCwgLnNoaWZ0ID0gMTQg
fSwNCj4gPiArICAgICAgIC5jbG9ja211bHRpcGxpZXIgPSB7IC5yZWcgPSAweDQsIC53aWR0aCA9
IDgsIC5zaGlmdCA9IDE0IH0sDQo+ID4gKyAgICAgICAuc3VwcG9ydDY0YiA9IHsgLnJlZyA9IDB4
NCwgLndpZHRoID0gMSwgLnNoaWZ0ID0gMjQgfSwNCj4gPiArICAgICAgIC5oaXdvcmRfdXBkYXRl
ID0gZmFsc2UsDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHNkaGNp
X2FyYXNhbl9zb2NfY3RsX21hcCBpbnRlbF9rZWVtYmF5X3NvY19jdGxfbWFwDQo+ID0gew0KPiA+
ICAgICAgICAgLmJhc2VjbGtmcmVxID0geyAucmVnID0gMHgwLCAud2lkdGggPSA4LCAuc2hpZnQg
PSAxNCB9LA0KPiA+ICAgICAgICAgLmNsb2NrbXVsdGlwbGllciA9IHsgLnJlZyA9IDB4NCwgLndp
ZHRoID0gOCwgLnNoaWZ0ID0gMTQgfSwgQEANCj4gPiAtNDMwLDYgKzQzNywxNSBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IHNkaGNpX3BsdGZtX2RhdGENCj4gc2RoY2lfYXJhc2FuX2NxZV9wZGF0YSA9
IHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICBTREhDSV9RVUlSSzJfQ0xPQ0tfRElWX1pF
Uk9fQlJPS0VOLA0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lf
cGx0Zm1fZGF0YSBzZGhjaV9hcmFzYW5fdGh1bmRlcmJheV9wZGF0YSA9IHsNCj4gPiArICAgICAg
IC5vcHMgPSAmc2RoY2lfYXJhc2FuX2NxZV9vcHMsDQo+ID4gKyAgICAgICAucXVpcmtzID0gU0RI
Q0lfUVVJUktfQ0FQX0NMT0NLX0JBU0VfQlJPS0VOIHwNCj4gU0RIQ0lfUVVJUktfTk9fRU5EQVRU
Ul9JTl9OT1BERVNDLA0KPiA+ICsgICAgICAgLnF1aXJrczIgPSBTREhDSV9RVUlSSzJfUFJFU0VU
X1ZBTFVFX0JST0tFTiB8DQo+ID4gKyAgICAgICAgICAgICAgIFNESENJX1FVSVJLMl9DTE9DS19E
SVZfWkVST19CUk9LRU4gfA0KPiA+ICsgICAgICAgICAgICAgICBTREhDSV9RVUlSSzJfU1RPUF9X
SVRIX1RDIHwNCj4gPiArICAgICAgICAgICAgICAgU0RIQ0lfUVVJUksyX0NBUFNfQklUNjNfRk9S
X0hTNDAwLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiAgI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KPiA+
ICAvKioNCj4gPiAgICogc2RoY2lfYXJhc2FuX3N1c3BlbmQgLSBTdXNwZW5kIG1ldGhvZCBmb3Ig
dGhlIGRyaXZlciBAQCAtMTA5OCw2DQo+ID4gKzExMTQsMTIgQEAgc3RhdGljIHN0cnVjdCBzZGhj
aV9hcmFzYW5fb2ZfZGF0YQ0KPiBzZGhjaV9hcmFzYW5fZ2VuZXJpY19kYXRhID0gew0KPiA+ICAg
ICAgICAgLmNsa19vcHMgPSAmYXJhc2FuX2Nsa19vcHMsDQo+ID4gIH07DQo+ID4NCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBzZGhjaV9hcmFzYW5fb2ZfZGF0YSBzZGhjaV9hcmFzYW5fdGh1bmRl
cmJheV9kYXRhID0NCj4gew0KPiA+ICsgICAgICAgLnNvY19jdGxfbWFwID0gJnRodW5kZXJiYXlf
c29jX2N0bF9tYXAsDQo+ID4gKyAgICAgICAucGRhdGEgPSAmc2RoY2lfYXJhc2FuX3RodW5kZXJi
YXlfcGRhdGEsDQo+ID4gKyAgICAgICAuY2xrX29wcyA9ICZhcmFzYW5fY2xrX29wcywNCj4gPiAr
fTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc2RoY2lfcGx0Zm1fZGF0YSBzZGhj
aV9rZWVtYmF5X2VtbWNfcGRhdGEgPSB7DQo+ID4gICAgICAgICAub3BzID0gJnNkaGNpX2FyYXNh
bl9jcWVfb3BzLA0KPiA+ICAgICAgICAgLnF1aXJrcyA9IFNESENJX1FVSVJLX0NBUF9DTE9DS19C
QVNFX0JST0tFTiB8IEBAIC0xMjMxLDYNCj4gPiArMTI1MywxMCBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBzZGhjaV9hcmFzYW5fb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgICAgICAg
ICAgICAgICAgLmNvbXBhdGlibGUgPSAiaW50ZWwsa2VlbWJheS1zZGhjaS01LjEtc2RpbyIsDQo+
ID4gICAgICAgICAgICAgICAgIC5kYXRhID0gJmludGVsX2tlZW1iYXlfc2Rpb19kYXRhLA0KPiA+
ICAgICAgICAgfSwNCj4gPiArICAgICAgIHsNCj4gPiArICAgICAgICAgICAgICAgLmNvbXBhdGli
bGUgPSAiaW50ZWwsdGh1bmRlcmJheS1zZGhjaS01LjEiLA0KPiA+ICsgICAgICAgICAgICAgICAu
ZGF0YSA9ICZzZGhjaV9hcmFzYW5fdGh1bmRlcmJheV9kYXRhLA0KPiA+ICsgICAgICAgfSwNCj4g
PiAgICAgICAgIC8qIEdlbmVyaWMgY29tcGF0aWJsZSBiZWxvdyBoZXJlICovDQo+ID4gICAgICAg
ICB7DQo+ID4gICAgICAgICAgICAgICAgIC5jb21wYXRpYmxlID0gImFyYXNhbixzZGhjaS04Ljlh
IiwgQEAgLTE1ODIsNyArMTYwOCw4DQo+ID4gQEAgc3RhdGljIGludCBzZGhjaV9hcmFzYW5fcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPg0KPiA+ICAgICAgICAgaWYgKG9m
X2RldmljZV9pc19jb21wYXRpYmxlKG5wLCAiaW50ZWwsa2VlbWJheS1zZGhjaS01LjEtZW1tYyIp
IHx8DQo+ID4gICAgICAgICAgICAgb2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUobnAsICJpbnRlbCxr
ZWVtYmF5LXNkaGNpLTUuMS1zZCIpIHx8DQo+ID4gLSAgICAgICAgICAgb2ZfZGV2aWNlX2lzX2Nv
bXBhdGlibGUobnAsICJpbnRlbCxrZWVtYmF5LXNkaGNpLTUuMS1zZGlvIikpIHsNCj4gPiArICAg
ICAgICAgICBvZl9kZXZpY2VfaXNfY29tcGF0aWJsZShucCwgImludGVsLGtlZW1iYXktc2RoY2kt
NS4xLXNkaW8iKSB8fA0KPiA+ICsgICAgICAgICAgIG9mX2RldmljZV9pc19jb21wYXRpYmxlKG5w
LCAiaW50ZWwsdGh1bmRlcmJheS1zZGhjaS01LjEiKSkNCj4gPiArIHsNCj4gPiAgICAgICAgICAg
ICAgICAgc2RoY2lfYXJhc2FuX3VwZGF0ZV9jbG9ja211bHRpcGxpZXIoaG9zdCwgMHgwKTsNCj4g
PiAgICAgICAgICAgICAgICAgc2RoY2lfYXJhc2FuX3VwZGF0ZV9zdXBwb3J0NjRiKGhvc3QsIDB4
MCk7DQo+ID4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
