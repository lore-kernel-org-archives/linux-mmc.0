Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C26C43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0CC82145D
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qtUW6oW6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgJHKgf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:36:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgJHKge (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 06:36:34 -0400
IronPort-SDR: zFzYIzfFDlnQK5UUE2ev5MjM6fMzlmE5kJbsTur5H6u4dP2VRl3CrdvdVW4+HKphS9o1+mppwq
 Dz41zriqM70w==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="164526035"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="164526035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 03:36:33 -0700
IronPort-SDR: BEwM7PJv2mmtvGW0Av2HBIjNMKGbIo5YmeE13BodBvqBNzkpu2HHmSa3VOwLLFEo2bWtwipP5J
 TjCDIbRJ7tYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="316642064"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga006.jf.intel.com with ESMTP; 08 Oct 2020 03:36:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 03:36:32 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 03:36:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 03:36:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 03:36:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BI4/VqhXRBsYfbkaoxObovAJDY+afzuCgKR1YmMDflX7jBl7bD/V7rEPLQHbcVt8Jwr3o80WY8Jq/uSchvQlHMlU+s3l56VUPxTZpjZwcNipCyCMztdwHd0i5KMCao/grVk4EEfouSsZeP/7a4QpHxtCvm8g6/5eK4CEK4Cx/NiL/9QjAIvkVf7f4khU99hsEkDSFe49sifIKyKoP22M6N322c7ERmZzsnVpRQ+2v7+Qk252Fttesm2bw9qcU31EbfKpEIOPGXJXorwLejwKkq2koY9AbulcqCVMsHLMnqjyWQD+7zl4ZTtWwPWnqYUYJE1FAsyLEMIxx2gQA/veqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LKhftlCueVhGm2XKOZLsU60gCaft4osNRXAnd9gqx8=;
 b=fxJBGYd7DEhcs2g7PSKV1Oy12uj8AkvkYSZPtOylNPrfirhhkwAKHSrz52YVL59ktxcsZlRT4cAuitQW5o3Vg4vrLqiUDCDsakUCaSMcrk8SUynb4Kzuvo6DCJrDmMpes7zGNHfyM/1Tl7uxJC498l4OuTY8r9G4YRBxuXuDz4AlWxuwDeqc/Gd8mPE/VostuaON3xD5tN8/VJzbKbj+TxD+lCEDnYvGxhQ79oAE+j8rfGN0T07suZ6IAfVkJba6moDBDX38SVAOVJ891SnyMlhqc5aLujS/gOw8htFB76lBFyO5t8eDKEBIxXlJrva7GcIGBTBOf0n9xW/W2QuzqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6LKhftlCueVhGm2XKOZLsU60gCaft4osNRXAnd9gqx8=;
 b=qtUW6oW6awaTtnTCRHiTuy8Is1clnTqOEjnd0bll5SsjWcMNa8uJELBZCBRV7E7v4fzxWEioFQcr0X+qSDyPfFhST9CSrn8exmN2In1m0UUQZ8ijlY+SJuks6LSJy5hS/Aj7Yr9F6iY68roTiE5IVtN6pPOprDfqmC3jHB661Zw=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR11MB1707.namprd11.prod.outlook.com (2603:10b6:3:14::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Thu, 8 Oct 2020 10:36:29 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 10:36:29 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v4 3/4] mmc: sdhci-of-arasan: Add structure device pointer
 in probe
Thread-Topic: [PATCH v4 3/4] mmc: sdhci-of-arasan: Add structure device
 pointer in probe
Thread-Index: AQHWnRiPbku3aVgU2E2wlArLCHzxX6mNUMSAgAAyTGA=
Date:   Thu, 8 Oct 2020 10:36:29 +0000
Message-ID: <DM6PR11MB28769233CEC9023E3D9720F9B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-4-muhammad.husaini.zulkifli@intel.com>
 <9deff9d8-b8da-7cc2-19f3-e5baab010d92@xilinx.com>
In-Reply-To: <9deff9d8-b8da-7cc2-19f3-e5baab010d92@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: andy.shevchenko@gmail.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ede0878-4c68-45f0-8f37-08d86b760483
x-ms-traffictypediagnostic: DM5PR11MB1707:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB17078565C2978B7CA45F8C42B80B0@DM5PR11MB1707.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dp07Kof3wA7qte7vlLgxM9vtwNLEAqxqtYJzLCltU9fe30ntMKHfiufCLyM7XL3MtE6bN/ukuC83qShmz7Y88IVR5dY28sy5xF8KJnIwlgT3chIh3jFdJX3cU1Vj+NoFxxjDqvaNndyTbKglN9JpjnSR3zUgvJoZoGVmzXI12aLFDI1oAUHCFpjKjMkjDA5jZ0h0d2POhGWzNYuKspe7490ivLly10zV+u5mMzcG/ESoqNw9LQwwwZ9vzCIelHtprO9Xs+uT+46UQ3dRyA1Gs8iJnhXftzL/yGzyJt4Mts/cF2RZH0YAAzsiq6SfgEEaEchmo8DAzVjjbkfz0mLSB5VRWeHf0XSMmd7M4Mm70Joof6ToCEk9No2jtJp8giwi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(7696005)(6506007)(54906003)(110136005)(33656002)(5660300002)(66476007)(52536014)(66446008)(64756008)(66556008)(9686003)(66946007)(76116006)(26005)(186003)(55016002)(4326008)(71200400001)(8676002)(316002)(8936002)(478600001)(83380400001)(86362001)(2906002)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OG7/ITYWKgdKT7L9DwtURaNCZNqqmnp2/mcHAUNYahrw8cG/d+VjryjnM0jQohkiCHnOMUC7xLD0+mCd9i9KhP1LCGxcGh25qXbgghLjWll7irhxyAHKNZ4zOoCliBIhhwd+u1wWHg28S+UFAYz0yw9cam1DoNlN+Q0aRZklQINHnqGVfUwme8/qmyuqtk/3GmTka7Wu23c1Z0RgOWxxXG3BGt6MVS43dpgy/r+yVSjqwnJMxN+gvDcsvw5B8Y4rbanhDYZJ0vRY3U9lBTAKoVG4oQwqFL2J7JWZcoUUTSbnPp0/5jB0rMT73qq6H13pZWljl1AJypgULhHIfDKOlH/na8Vzg4kCjZxwWdx4odXLSsrVApXV/xXqw2CCN0DzeMhULVLcYeGSByLyiceC0AmTJ1rgYWUApImBGv7f+tmQ4oemM8WeO4HkUfho62Y13oSmk5E80Q5GVcyfdJRIpM2xt4APfNIPeBQgZJqa2/JKQqiPsAAXspXWMWrLFGoe4xklCRHK/5+yYBsJCkeLESqy9KTvuOIBqQWFFUwioliaEyl2MTfUKpSjKJTOdnohl4ioRSSMki4BpYZAt4qLdntAkmLENFxQb+uNE0Cdjekro+OyPovFkt8XFFrNdvNCJe98YZWVq+cuSV+4yg8McA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ede0878-4c68-45f0-8f37-08d86b760483
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 10:36:29.7339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 48O1KP33rwUuM1INTYFXDgRj9/V/9jl18UzczsOHI1/ChIDi9VALp88f3it5vbDEcQtwpqhNTkmdeuNxEI96Ndt4s0BVGxgLSiAmgd+IioAOYjGEGpBBgx7cgUD0K5WQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWljaGFsLA0KDQpUaGFua3MgZm9yIHRoZSBjb21tZW50LiBJIHJlcGxpZWQgaW5saW5lDQoN
Cj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1pY2hhbCBTaW1layA8bWljaGFs
LnNpbWVrQHhpbGlueC5jb20+DQo+U2VudDogVGh1cnNkYXksIE9jdG9iZXIgOCwgMjAyMCAzOjM1
IFBNDQo+VG86IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5odXNhaW5pLnp1
bGtpZmxpQGludGVsLmNvbT47DQo+SHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwu
Y29tPjsgbWljaGFsLnNpbWVrQHhpbGlueC5jb207DQo+U2hldmNoZW5rbywgQW5kcml5IDxhbmRy
aXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPmxpbnV4
LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
ZzsgbGludXgtDQo+a2VybmVsQHZnZXIua2VybmVsLm9yZw0KPkNjOiBSYWphIFN1YnJhbWFuaWFu
LCBMYWtzaG1pIEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+Ow0K
PldhbiBNb2hhbWFkLCBXYW4gQWhtYWQgWmFpbmllDQo+PHdhbi5haG1hZC56YWluaWUud2FuLm1v
aGFtYWRAaW50ZWwuY29tPjsgYXJuZEBhcm5kYi5kZQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQg
My80XSBtbWM6IHNkaGNpLW9mLWFyYXNhbjogQWRkIHN0cnVjdHVyZSBkZXZpY2UgcG9pbnRlcg0K
PmluIHByb2JlDQo+DQo+DQo+DQo+T24gMDguIDEwLiAyMCA0OjA5LCBtdWhhbW1hZC5odXNhaW5p
Lnp1bGtpZmxpQGludGVsLmNvbSB3cm90ZToNCj4+IEZyb206IE11aGFtbWFkIEh1c2FpbmkgWnVs
a2lmbGkgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4NCj4+IEFkZCBz
dHJ1Y3QgZGV2aWNlICpkZXYgaW4gcHJvYmUgZnVuYygpIHNvIHRoYXQgaXQgY2FuIHdpZGVseSB1
c2UgaW4NCj4+IHByb2JlIHRvIG1ha2UgY29kZSBtb3JlIHJlYWRhYmxlLg0KPj4NCj4+IFNpZ25l
ZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+IDxtdWhhbW1hZC5odXNhaW5p
Lnp1bGtpZmxpQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
b2YtYXJhc2FuLmMgfCAxICsNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYw0KPj4g
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5jDQo+PiBpbmRleCBmMTg2ZmJkMDE2
YjEuLjQ2YWVhNjUxNjEzMyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
b2YtYXJhc2FuLmMNCj4+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMN
Cj4+IEBAIC0xNTIxLDYgKzE1MjEsNyBAQCBzdGF0aWMgaW50IHNkaGNpX2FyYXNhbl9wcm9iZShz
dHJ1Y3QNCj5wbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+PiAgCXN0cnVjdCBzZGhjaV9wbHRmbV9o
b3N0ICpwbHRmbV9ob3N0Ow0KPj4gIAlzdHJ1Y3Qgc2RoY2lfYXJhc2FuX2RhdGEgKnNkaGNpX2Fy
YXNhbjsNCj4+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYtPmRldi5vZl9ub2RlOw0K
Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPj4gIAljb25zdCBzdHJ1Y3Qg
c2RoY2lfYXJhc2FuX29mX2RhdGEgKmRhdGE7DQo+Pg0KPj4gIAltYXRjaCA9IG9mX21hdGNoX25v
ZGUoc2RoY2lfYXJhc2FuX29mX21hdGNoLCBwZGV2LT5kZXYub2Zfbm9kZSk7DQo+Pg0KPg0KPlRo
aXMgaXMgbm90IHdoYXQgd2UgZGlzY3Vzc2VkLiBZb3UgY3JlYXRlIG5ldyB2YXJpYWJsZSBhbmQg
eW91IHNob3VsZCBqdXN0IHVzZSBpdA0KPmluIHRoYXQgZnVuY3Rpb24uDQo+DQo+cy9wZGV2LT5k
ZXZcLi9kZXYtPi9nDQoNCkZvciB3aWRlbHkgdXNlZCBpbiBmdXR1cmUsIHdlIHBsYW4gdG8gcHV0
IGl0IGhlcmUgYW5kIG5vdCBzcGVjaWZpYyB0byBLZWVtYmF5IGZ1bmN0aW9uIG9ubHkuDQpBbnkg
Y29tbWVudCBvbiB0aGlzIEBBbmR5IFNoZXZjaGVua28/DQpUaGFua3MNCj4NCj5UaGFua3MsDQo+
TWljaGFsDQo=
