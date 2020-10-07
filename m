Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF61C41604
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B12D6208C7
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 13:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NNHcSOaT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgJGNVW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:21:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:28801 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728403AbgJGNVV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 7 Oct 2020 09:21:21 -0400
IronPort-SDR: nFlWpRWzz9pMatG1B9G6axuXBDwIRKp/mFuCRqHi7c+fik9lsEQC6rDao86Mn6DMFUHQxh/gDR
 1+X4HCtNfaqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="165004997"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="165004997"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 06:21:21 -0700
IronPort-SDR: EovMco706+aHjmZizh+gpBipFVtlqNnQbmQ8BJUlhbCZAdgfFv7wpu0L8/fG4sNcbuQ8Jz1cL1
 bmmFtzFDrtRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="311743433"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2020 06:21:20 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:21:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 7 Oct 2020 06:21:19 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 7 Oct 2020 06:21:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 7 Oct 2020 06:21:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OF+VIYFVkF+TcHU+k+YFjU+PLCSpApYlHbV+HBTyRPR/8/xXCRPiPx2lH3Y3d1ZzeNvinGoD6/+dTSB0DdlxqoHoHQWX7ujLJ1qXDTpkNtHMYsz9LW8Z1SEAJvcDSrVUydaJCyKjTzupqo7a9vxeTZRYtvJdtsURt5KJAvJFWRQYPq4vjgwrljmUqJut7dVJIsdtcKDvKYrl4cpJY34YtWEoJjBArHMVYGaXV8R2pTR8O9WJ8O9yq6cTKCaYCBkRKH92Ykfd+iRsV04d54aRvNrdebo198hxYt2kzM4+aiZvdlhN36vh1MoNwtKh2Eoi4DVT74spchibJcNoybCH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6UDQpZ0cmFXfO/YtEJVqpgi2Y04GOIBwp6Gish9Yyo=;
 b=dPwZWapYoRa6JvXbTnFOl+h5gjYyWliqYnlM61AxXXDKLaqX3YbibbMnm+O0X7N+qeBu5VvRmGE4LFJ74QvEweRCSPh8kl0uzAcDDf+tlrTq1Qbys9BsIIgqiGq2RWyQF8wushtvMxqcxgYbdUvxRXHLrKQxokW6e6vOoPy7xv6t1iOAM4ACpOX2sEARp2lB/ffNut6t391biTiLoE7ZbzdXiPzbKlIa1zU07ZDVEqgPT3yRfFIdzF+Dw6ULIL3DY90thy9Ov2QTZaOf1eWq2ocDcjeSK56yhwle393OkWIPURWVj8Go3FPb+gmStz89J+I9MscGsSQr3Din6UjLwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6UDQpZ0cmFXfO/YtEJVqpgi2Y04GOIBwp6Gish9Yyo=;
 b=NNHcSOaTGsmrn6hv+Bo0dwjHPwt1tKyMkt+BIDchrZcnCfBqW1eRFtfI9R3W4WxZ/dzTdoYcmVg9mdli7vDbYphM+bEjdAax1c0p1dMZUoBTqB9R2pU6pxhh1gvxMF2y2EKZ6GhN/tbGGWefSFjiA2Dc9szUQqWTvlkjqC7Egjc=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2620.namprd11.prod.outlook.com (2603:10b6:5:c8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Wed, 7 Oct 2020 13:21:14 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Wed, 7 Oct 2020
 13:21:14 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v3 2/2] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWm/mmQ68E6v02PEeQu9XSxqgGOqmLzXGAgABTRsA=
Date:   Wed, 7 Oct 2020 13:21:14 +0000
Message-ID: <DM6PR11MB2876F93077CA6705EFAB2E4EB80A0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-3-muhammad.husaini.zulkifli@intel.com>
 <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
In-Reply-To: <4677c614-ac00-fb69-d22c-54f9015249f4@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d198e0d9-09ae-4aff-c52a-08d86ac3ddb6
x-ms-traffictypediagnostic: DM6PR11MB2620:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2620AE2094EB87F7AF4321E8B80A0@DM6PR11MB2620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dCIBFN58X8Iyvcx8qACIryn372eOwzGS/L2DSjOMh5Pp/yevXSFoW8WBW2qwuEpnEVp2YFK27G7A4GFrTAktq1Bw3zlDAMDLYVzwK9dodwSOOAhJUm/hqM5igfcC58RGve/r8zv/2d5Wsra8TGH3NftBf3yyXkdrbtvsTxlPZ4X1m6/EAzYuEv5QLqsrTNzHNahfJ0N3W1tCjqcu5usbxzev4gv4P1LwERDfBZGmXQe2NE1lBxYy2K7LgdCbBP3PEm16sca6bgQQCKxilUFNEbVQiDrEQLV2tU7FE4oHUifG1kQBHfWSi1eiDqQ3qiMERfik9OjOi416j0b1QsQwdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(6506007)(86362001)(8676002)(55016002)(8936002)(7696005)(316002)(110136005)(54906003)(26005)(33656002)(186003)(478600001)(2906002)(9686003)(66556008)(66946007)(64756008)(66476007)(83380400001)(76116006)(66446008)(5660300002)(71200400001)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ByZXlx1mf8488su2IcDTFD53BCjn/CtEsDpURn+Ws6CYoHKgIdS3saW4A5MaurFPuYzd3m3fMp/rqJ2zpUev4hWRBOs7xVQVg0MjSBABQWE0Vgh4BNKZ5C3cpKp8GIAd1Q3iJYkc4Fmoj6Beprdn+kauNfj8bkchMHW6GJKqhtafROk7IE0JdTLk8mMFAlREoxHuhSdA+dbNewW1XKng3oyIWUPvrYEnRpqQbQzkMowwbDRa9H4KGTe1cHjrUANohfAjcVl/pK3KESwsQEEfm20+q3U3rTS+3muMA4Z5dhAkCCNaTvLFwqtNUNELGKKKD0yI1yVBbb2RcPhVnj0r4zl7iWlY382lACmBTv36fjW12JLEt68o5XRW9MXgmsuprBtWoN60nNj8BWxPbAE4k692IMBkNTDh+ajQjZHmTWqUnuy+s/lm/M43250jdmpIrviNHqvRqxwtVPRPaneV/7yjtKF/2orWuiuP+70SGDpWD4UKI5yZZiRKuwoaq+m0dNHQeF22KhYqeObgVRHloU8B3S+tZSc97VJ+LXHVFnQr/jFIMJ0OMTHcS280cVjnXgxzGU2Qr00qbeO7oOxSkfU1RJ3bHXxyY+mth9xZdzOUMBYEMjBoJ26Ahz3oQPoin2qf//z+SxIOPnYFnAluwA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d198e0d9-09ae-4aff-c52a-08d86ac3ddb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2020 13:21:14.3475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckw45h5jWB6xmwAEZikPsCp7nKjAvNKnlXVivy0TYeL/2HWwCNViZl99k14vN35xqvKyYPMHeBk6R2BYiVZKGU6Xf8pIUWDCQs7VL0oT4ZxHumpQvMdC/ym5qgr8BP0C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2620
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTWljaGFsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4gSSByZXBsaWVkIGlubGluZQ0K
DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNaWNoYWwgU2ltZWsgPG1pY2hh
bC5zaW1la0B4aWxpbnguY29tPg0KPlNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciA3LCAyMDIwIDQ6
MjAgUE0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1c2Fpbmku
enVsa2lmbGlAaW50ZWwuY29tPjsNCj5IdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+OyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsNCj5zdWRlZXAuaG9sbGFAYXJtLmNvbTsg
dWxmLmhhbnNzb25AbGluYXJvLm9yZzsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsNCj5saW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj5DYzogUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJh
amEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsNCj5XYW4gTW9oYW1hZCwgV2FuIEFobWFkIFphaW5p
ZQ0KPjx3YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IGFybmRAYXJuZGIu
ZGUNCj5TdWJqZWN0OiBSZTogW1BBVENIIHYzIDIvMl0gZmlybXdhcmU6IEtlZW0gQmF5OiBBZGQg
c3VwcG9ydCBmb3IgQXJtIFRydXN0ZWQNCj5GaXJtd2FyZSBTZXJ2aWNlIGNhbGwNCj4NCj5IaSwN
Cj4NCj4xLiBLZWVtIEJheTogaW4gc3ViamVjdCBpcyB3cm9uZy4gVG9vbHMgYXJlIHdvcmtpbmcg
d2l0aCBpdCBhbmQgeW91IHNob3VsZCBqdXN0DQo+dXNlIGtlZW1iYXk6IGluc3RlYWQuDQpBcmUg
eW91IHNheWluZyBsaWtlIHRoaXMgPyANCktlZW0gQmF5OiBBZGQgc3VwcG9ydCBmb3IgQXJtIFRy
dXN0ZWQgRmlybXdhcmUgU2VydmljZSBjYWxsDQoNCj4NCj4yLiBUaGlzIHNob3VsZCBjb21lIGZp
cnN0IGJlZm9yZSBhY3R1YWwgY2hhbmdlIHRvIGtlZXAgdGhlIHRyZWUgYmlzZWN0YWJsZS4NCk5v
dGVkLiBEb25lIHRoZSBjaGFuZ2VzDQo+DQo+T24gMDYuIDEwLiAyMCAxNzo1NSwgbXVoYW1tYWQu
aHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20gd3JvdGU6DQo+PiBGcm9tOiBNdWhhbW1hZCBIdXNh
aW5pIFp1bGtpZmxpIDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+DQo+
PiBBZGQgaGVhZGVyIGZpbGUgdG8gaGFuZGxlIEFQSSBmdW5jdGlvbiBmb3IgZGV2aWNlIGRyaXZl
ciB0bw0KPj4gY29tbXVuaWNhdGUgd2l0aCBBcm0gVHJ1c3RlZCBGaXJtd2FyZS4NCj4+DQo+PiBT
aWduZWQtb2ZmLWJ5OiBNdWhhbW1hZCBIdXNhaW5pIFp1bGtpZmxpDQo+PiA8bXVoYW1tYWQuaHVz
YWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAuLi4vbGludXgvZmlybXdhcmUv
aW50ZWwva2VlbWJheV9maXJtd2FyZS5oICAgfCA0NiArKysrKysrKysrKysrKysrKysrDQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJlLmgNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJl
LmgNCj4+IGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X2Zpcm13YXJlLmgN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjlhZGI4Yzg3
Yjc4OA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvaW5jbHVkZS9saW51eC9maXJtd2FyZS9p
bnRlbC9rZWVtYmF5X2Zpcm13YXJlLmgNCj4+IEBAIC0wLDAgKzEsNDYgQEANCj4+ICsvKiBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KPj4gKy8qDQo+PiArICogIEludGVsIEtl
ZW1iYXkgU09DIEZpcm13YXJlIEFQSSBMYXllcg0KPj4gKyAqDQo+PiArICogIENvcHlyaWdodCAo
QykgMjAyMC0yMDIxLCBJbnRlbCBDb3Jwb3JhdGlvbg0KPj4gKyAqDQo+PiArICogIE11aGFtbWFk
IEh1c2FpbmkgWnVsa2lmbGkgPE11aGFtbWFkLkh1c2FpbmkuWnVsa2lmbGlAaW50ZWwuY29tPg0K
Pj4gKyAqLw0KPj4gKw0KPj4gKyNpZm5kZWYgX19GSVJNV0FSRV9LRUVNQkFZX1NNQ19IX18NCj4+
ICsjZGVmaW5lIF9fRklSTVdBUkVfS0VFTUJBWV9TTUNfSF9fDQo+PiArDQo+PiArI2luY2x1ZGUg
PGxpbnV4L2FybS1zbWNjYy5oPg0KPj4gKw0KPj4gKy8qKg0KPg0KPlRoaXMgaXMgbm90IGEga2Vy
bmVsIGRvYyBjb21tZW50LiBKdXN0IHVzZSAvKg0KPg0KPj4gKyAqIFRoaXMgZmlsZSBkZWZpbmVz
IEFQSSBmdW5jdGlvbiB0aGF0IGNhbiBiZSBjYWxsZWQgYnkgZGV2aWNlIGRyaXZlcg0KPj4gKyBp
biBvcmRlciB0bw0KPj4gKyAqIGNvbW11bmljYXRlIHdpdGggQXJtIFRydXN0ZWQgRmlybXdhcmUu
DQo+PiArICovDQo+PiArDQo+PiArLyogU2V0dGluZyBmb3IgS2VlbSBCYXkgSU8gUGFkIExpbmUg
Vm9sdGFnZSBTZWxlY3Rpb24gKi8NCj4+ICsjZGVmaW5lIEtFRU1CQVlfU0VUX1NEX1ZPTFRBR0Vf
RlVOQ19JRAkweDgyMDBmZjI2DQo+DQo+U3VkZWVwOiBEb24ndCB3ZSBoYXZlIGFueSBtYWNyb3Mg
Zm9yIGNvbXBvc2luZyB0aGVzZSBJRHM/DQo+bml0OiBJTUhPIGNvbXBvc2luZyB0aGVzZSBJRHMg
ZnJvbSBtYWNyb3Mgd291bGQgbWFrZSBtb3JlIHNlbnNlIHRvIG1lLg0KPg0KPg0KPj4gKyNkZWZp
bmUgS0VFTUJBWV9TRVRfMVY4X1ZPTFQJCTB4MDENCj4NCj4weDAxIGlzIGp1c3QgMQ0KTm90ZWQu
IERvbmUgdGhlIGNoYW5nZXMNCj4NCj4+ICsjZGVmaW5lIEtFRU1CQVlfU0VUXzNWM19WT0xUCQkw
eDAwDQo+DQo+MHgwMCBpcyBqdXN0IDANCk5vdGVkLiBEb25lIHRoZSBjaGFuZ2VzDQo+DQo+PiAr
DQo+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0hBVkVfQVJNX1NNQ0NDX0RJU0NPVkVSWSkNCj4+
ICtzdGF0aWMgaW50IGRvX2Z3X2ludm9rZSh1NjQgZnVuY19pZCwgdTY0IGFyZzAsIHU2NCBhcmcx
KSB7DQo+PiArCXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlczsNCj4+ICsNCj4+ICsJYXJtX3NtY2Nj
XzFfMV9pbnZva2UoZnVuY19pZCwgYXJnMCwgYXJnMSwgJnJlcyk7DQo+PiArDQo+PiArCXJldHVy
biByZXMuYTA7DQo+DQo+SSBhbSBub3QgYmlnIGZhbiBvZiB0aGlzIGVycm9yIHByb3BhZ2F0aW9u
IGluIGNhc2Ugb2YgZmFpbHVyZS4NCj4NCj5JZiBzbWMgZmFpbHMgeW91IGdldCB2aWEgcmVzLmEw
IFNNQ0NDX1JFVF9OT1RfU1VQUE9SVEVEIHdoaWNoIGlzIGRlZmluZWQgYXMNCj4tMSB3aGljaCBp
cyBiYXNlZCBvbiBlcnJuby1iYXNlLmggZGVmaW5lZCBhcyBFUEVSTS4NCj4NCj5UaGF0IGRyaXZl
ciB3aGljaCBTdWRlZXAgcG9pbnRlZCB5b3UgdG8gaXMgdXNpbmcgRUlOVkFMIGluc3RlYWQuDQo+
DQo+SXQgbWVhbnMgSSB3b3VsZCBhZGQgYSBjb2RlIHRvIGNoZWNrIGl0Lg0KDQpZZWFoIEkgY2hh
bmdlZCB0byBiZWxvdyBsaW5lIG9mIGNvZGVzLiBJcyB0aGlzIE9rPyBUZXN0ZWQgd29ya2luZy4N
CmludCBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKGludCB2b2x0KQ0Kew0KCXN0cnVjdCBh
cm1fc21jY2NfcmVzIHJlczsNCg0KCWFybV9zbWNjY18xXzFfaW52b2tlKEFSTV9TTUNDQ19TSVBf
S0VFTUJBWV9TRVRfU0RfVk9MVEFHRSwgdm9sdCwgJnJlcyk7DQoJaWYgKChpbnQpcmVzLmEwIDwg
MCkNCgkJcmV0dXJuIC1FSU5WQUw7DQoNCglyZXR1cm4gMDsNCn0NCg0KPg0KPg0KPj4gK30NCj4+
ICsNCj4+ICtpbnQga2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlvbihpbnQgdm9sdCkNCj4NCj5h
cyB3YXMgcmVwb3J0ZWQgYnkgcm9ib3QNCkFkZGVkIHRoZSBmdW5jIHByb3RvdHlwZS4gDQppbnQg
a2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlvbihpbnQgdm9sdCk7DQpObyBlcnJvciBvYnNlcnZl
ZCBhZnRlciB0aGF0Lg0KPg0KPj4gK3sNCj4+ICsJcmV0dXJuIGRvX2Z3X2ludm9rZShLRUVNQkFZ
X1NFVF9TRF9WT0xUQUdFX0ZVTkNfSUQsIHZvbHQsIDApOyB9DQo+PiArI2Vsc2Ugc3RhdGljIGlu
bGluZSBpbnQga2VlbWJheV9zZF92b2x0YWdlX3NlbGVjdGlvbihpbnQgdm9sdCkgew0KPj4gKwly
ZXR1cm4gLUVOT0RFVjsNCj4+ICt9DQo+PiArI2VuZGlmDQo+PiArDQo+PiArI2VuZGlmIC8qIF9f
RklSTVdBUkVfS0VFTUJBWV9TTUNfSF9fICovDQo+Pg0KPg0KPk0NCg==
