Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FBAC43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 12:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C63592083B
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 12:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="bcwmm04E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgJHMe2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 08:34:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:4131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729769AbgJHMe2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 08:34:28 -0400
IronPort-SDR: z9GsF1S6aFz7eMQTfaoIGR0Gz3ERsMzL8FwT60ifkiy0W19A+e6wRm5HrBoxjKuUPyFsLfav9t
 kULoN5dXtIzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="164537479"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="164537479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 05:34:26 -0700
IronPort-SDR: ligmpwV0BagK40ry99Rukkx3+OCh81c9ggIhT5hjGxlacp4ZBVk36gowXOhWlNu0R4dOCwfdcp
 9cEz7hie/pZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="312196464"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2020 05:34:26 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 05:34:25 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 05:34:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 05:34:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aWmQO8HVOb9gmzj1nyWi0BhVbWizOwCwbCwsycj7BrzJC7llQV4zopp9iEEif2EnZxdoFnhfHY6HGtknykt1d5STtbJ1KH3FRPCtREnU+HCNjTQz1mHigjMhCdvlloEm0yyIIhKUcQ9enAhTCEPtSs6CswQCH4zmQwDZSc5lreQONdOCogudSb/e3ndUbQVJnU6WGnFZtglIAC+Z9jTBvDDVFGE9FAP9rkz6JYb15meUJmOksb408f1xOCVvglHo9ETjp9ib1gGyfwGEfF2R/pcaSJhJtTwS/77s9W7ft8BYUjHGOPSEidgQy2ZaVJq3in03vDD2gbvgrxX3/Hg8Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8OKo4aUkwDGwvB0WequMufuwUOlqEjhyjGP2Wt3Pk=;
 b=XqpGHPFxa4+HZa8EOYuwIQLQSg5LAwKw7AEs8TDn8Ao0PUtmDmDqTvIYqwc7Ye4k+f9W/ICAtgNPmuweyW9NqUw/8o+959WfpKjgKaedDxNY1HgqYUPsAdzZ8Mw07F0jkRjavam/QtqJQLFRa9mqRSEiT2L7s+HSPCFxzFfdcFf8LRf8U6Tiqu+Q1A4sw8QO987I6EQXciRpg9AfkH2e9h7xhT57y9oVDKtWbMmAVwh+eAyxuMZo04Z29AoYgbiNOri8M+hFDrchKSPXojh+2NqGv8+vXW7Z81Z/WHnPqsOqNGwvBl5IOvl2bhVbGwgMmV7QwDE1R42SPY6VJoqjlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8OKo4aUkwDGwvB0WequMufuwUOlqEjhyjGP2Wt3Pk=;
 b=bcwmm04EitiwjAs+QkSj2dVoKZjmGkR23fkgoAMHg3yEzemiMBA2YToH2SL98IV4OCMesZFT9K8JMCCbOK17EVoTJVJ2dgIILCR8wPleFjqFyKguEi7hPtpMDdVWx1l+AQeoIkkFqGBtJojoafckjoSa+aM1DKUTUHgqGwIVV5E=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2970.namprd11.prod.outlook.com (2603:10b6:5:65::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21; Thu, 8 Oct 2020 12:34:23 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 12:34:23 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
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
Subject: RE: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWnRiLN25HboG/ekeLrjyiLBrMxamNdTCAgAAvMnA=
Date:   Thu, 8 Oct 2020 12:34:23 +0000
Message-ID: <DM6PR11MB287670AD449A9B8B12EF9219B80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
 <20201008094501.ix2sdxorwhxchy5w@bogus>
In-Reply-To: <20201008094501.ix2sdxorwhxchy5w@bogus>
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
x-ms-office365-filtering-correlation-id: cf48d2dc-edff-4c49-fe97-08d86b867cc7
x-ms-traffictypediagnostic: DM6PR11MB2970:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2970FA2A9DC6E1C2863BAFACB80B0@DM6PR11MB2970.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnLc1jy8mFJRtFJIKrdhoQjeiy9bQ2J9UO0foJ4yj5eEZRn3MTVYhqGjdYQlMnkazgYgNMiRXg0ro63pYvl3uiNBKgHgcKPdwtrwJK+X9Ccg9ZwOAvAZaXVDykZYcmuEhqEc95wiz48NZwHev/DuiphwXiEHpoq8SioVS/xDcA+M+djXxLt/4Xwga8gGpcOuK1tC1bx4Y0yFjGix5BPtpyxxFcQjdubPv662zIMt8y/vcOTr5/Lvfog+HgUslPFFg+Msr2pKv9Wimcgw2gabIe5PSDyDjkX6UT15MS6pHEOVRfAOL5e1DYYx867rYqp6o+e01gULJ32/fal/AImxmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(136003)(396003)(66556008)(66446008)(54906003)(186003)(6506007)(26005)(107886003)(64756008)(52536014)(8676002)(7696005)(4326008)(86362001)(9686003)(66476007)(66946007)(83380400001)(316002)(8936002)(5660300002)(478600001)(33656002)(6916009)(55016002)(76116006)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CYP4pWh+2EYmNYHK+UXUM70uB1VmlQb2kA0qOkrJebNxIsSNSq8/vaMAl139UAVFVOy25ovdFWlnIZfgmy5phEzcdzE3ifF590zUi9+L6hDhIeQyM3dS6PC764ZgnMb1pdJ7VjT9IL/K03Qao/D/yQuQ+0YdJOZj8b9Z+uDLVXav1zDWz1ChA55VXfeHHbsmrG+vGVtkXIsw5mRWRMCvoQBwNxLvsAAFrKa2/OwsczzmVqqzECXrYCHTUUqx9FaM0xf6hX9Xcz5TACXXq2zTrfws1DrAI4RZfYoVZBjK8wNoaSumXEn1B2HWe9OIrTOjI7NnXSXwCvMSAUDKlQXGVHShv3W4uduPNhdiNBj5aPpYzNTKpd/7Ev7QoVAqE/JwjJwTrFeNgQc/HzZMvZmih1PtOPFQsIC2i06GZAqnWqmAB4/gk/RM7ZURvB0g65RMc8oyPw2uzdaNVgIoBtP5Ac9b4d13QQJoXlnuOjfbKtMs2taVP96U8/0Y/CIsFXzyoIsMm2n6O/FhU53kQ2B/5hMbj8kGiGLHJDd8DmbJe2PLgqeme3A3C9PHoJY2I1TjWqMqOX+3Y4NnEvVi60+Vn0bPq99pLdCZLBHrtWa7d5l+ksKb2dCQqparauvSK2NHefKiZpwTvBFGm8HsucdZiQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf48d2dc-edff-4c49-fe97-08d86b867cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 12:34:23.5566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mEdCRsPTcip+t+JvhB4awcjbMFjQRgDoGvfUjl5WmivmKGtNoXasD461JLqsK+gEpxuvirhxZZfL3QAbHGczcw4PhqMkw/RnQ1SdngR8foXxvdUwfOSvpvegWxBu9y2s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2970
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBTdWRlZXAg
SG9sbGEgPHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDgs
IDIwMjAgNTo0NSBQTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaSA8bXVoYW1tYWQu
aHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Q2M6IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4u
aHVudGVyQGludGVsLmNvbT47IG1pY2hhbC5zaW1la0B4aWxpbnguY29tOw0KPlNoZXZjaGVua28s
IEFuZHJpeSA8YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgdWxmLmhhbnNzb25AbGluYXJv
Lm9yZzsNCj5saW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhamEgU3Vi
cmFtYW5pYW4sIExha3NobWkgQmFpDQo+PGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50
ZWwuY29tPjsgYXJuZEBhcm5kYi5kZTsgV2FuIE1vaGFtYWQsDQo+V2FuIEFobWFkIFphaW5pZSA8
d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQ
QVRDSCB2NCAxLzRdIGZpcm13YXJlOiBrZWVtYmF5OiBBZGQgc3VwcG9ydCBmb3IgQXJtIFRydXN0
ZWQNCj5GaXJtd2FyZSBTZXJ2aWNlIGNhbGwNCj4NCj5PbiBUaHUsIE9jdCAwOCwgMjAyMCBhdCAx
MDowOTozM0FNICswODAwLA0KPm11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tIHdy
b3RlOg0KPj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaSA8bXVoYW1tYWQuaHVzYWlu
aS56dWxraWZsaUBpbnRlbC5jb20+DQo+Pg0KPj4gQWRkIGhlYWRlciBmaWxlIHRvIGhhbmRsZSBB
UEkgZnVuY3Rpb24gZm9yIGRldmljZSBkcml2ZXIgdG8NCj4+IGNvbW11bmljYXRlIHdpdGggQXJt
IFRydXN0ZWQgRmlybXdhcmUuDQo+DQo+W25pdF0gU2luY2UgaXQgbW92ZWQgdG8gdHJ1c3RlZC1m
aXJtd2FyZS5vcmcsIGl0IGlzIG5vIGxvbmdlciAiQXJtIg0KPlRydXN0ZWQgRmlybXdhcmUuIEl0
IGlzIG5vdyBjYWxsZWQgVHJ1c3RlZCBGaXJtd2FyZSAtIEEgcHJvZmlsZShURi1BKSBvcg0KPlRy
dXN0ZWQgRmlybXdhcmUgLSBNIHByb2ZpbGUgKFRGLU0pLiBQbGVhc2UgdXBkYXRlIHRoZSBzdWJq
ZWN0IGFuZCB0aGUgdGV4dA0KPmFib3ZlLiBJIGtub3cgaXQgaXMgc2lsbHkgYnV0IEkgYW0gYmVp
bmcgYXNrZWQgdG8gZ2V0IHRoaXMgZml4ZWQgYXMgaXQgbWF5IGNyZWF0ZQ0KPiJjb25mdXNpb24i
KEkgZG9uJ3Qga25vdyBkZXRhaWxzLCBwbGVhc2UgZG9uJ3QgYXNrIPCfmIEpDQo+DQo+QXBhcnQg
ZnJvbSB2YXJpb3VzIG1pbm9yIHRoaW5ncyBBbmR5IGFscmVhZHkgcG9pbnRlZCBvdXQsIHRoaXMg
bG9va3MgZ29vZC4NCj5Zb3UgY2FuIGFkZCBieSBBY2sgb25jZSB0aGUgYWJvdmUgbmFtaW5nIGFu
ZCBhbGwgdGhpbmdzIHBvaW50ZWQgYnkgQW5keSBhcmUNCj5maXhlZC4NCg0KTm90ZWQuIFRoYW5r
cyBTdWRlZXAg8J+Yig0KPg0KPi0tDQo+UmVnYXJkcywNCj5TdWRlZXANCg==
