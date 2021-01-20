Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4FDC433E6
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 04:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE57323131
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 04:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbhATE0n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 23:26:43 -0500
Received: from mga12.intel.com ([192.55.52.136]:45420 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731660AbhATEZu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 19 Jan 2021 23:25:50 -0500
IronPort-SDR: rOB0zpBof6fdpMP41gKAm3H2e6o68pYweknQDo6ZyD8ZPN7q+H8AfW2mITo5j1KLk46Ez4C73Y
 TgcYVHtvUlSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="158222728"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="158222728"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 20:25:09 -0800
IronPort-SDR: tlBU/d8jC9GykSA6NvxMBYXDHuqg4LfWqJJ/aMz7AZPCqvk95R8TtuXlxWlkBCiwxohCFAlkxO
 x/0C1vZBHwvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="426765828"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 19 Jan 2021 20:25:08 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 19 Jan 2021 20:25:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 19 Jan 2021 20:25:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 19 Jan 2021 20:25:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+NIB7iMfCPZ8+jQyvG+Nuc+zS/3zDt5TJNl99GNuCBDrveMYzRTXbTK2auV7CnQ8zUGLSW6LjN3WZo5+FJNpz0pg6//VV0g9sHbV/1gzCn1nA7bUxeEkQ3DX+/wa+rHAE2cyIWMYE5OefvG2F5Erh5uQ5MGbhHMulIfmkuV/hXQc2IMbgsGqIQn9LN7GstBQsyYAHU5PLRdbl2jM972vd5ui+nUDyUWfSVwUKBH4J54nho2tQTsGE7+lPLcVFp+FFXu9vH7waO48Gj9RpPrdeoNBXzOtPvEZjq7DbiGeaasX2ssff5kt2UigRcQK4xUDv2kZhG7+7MCgmlCU6EmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wZCCe4wWw+Krl6MvXAObP0zZHFuw27tFGi/JMzAfGQ=;
 b=gbepUUd6ue4oq8CzDN3HOD8FO/r0B9rzjuQaq/Sx6Yp72H19TnVpzXqrXzMyO68XCAUIBW8ZJ9mEMk1LcsxdDcQp5KKiCqUcLlyE3TUnWEI/8wFWMfp7zfhQdcUis9yJ0EWH9o5U3hYxLABj4kHndJeajXk0OuH+NwUGplvmfP54ZlWA+0hnwLB0yCMaMOL2dmJ/BiGVHL6YF4ZojdS2keOl0Kd7IXU+BKKhuaeNNq4OGY9fOj49nQ4K1ZDAl53wBJjlJcqE36lN5eWubZ9XodB6v3CXKVXGIyvae9SEPfMMY5MXU/9+jX8v7hrwvMhttuY2CpQ8r+QPvZa/U+7IJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wZCCe4wWw+Krl6MvXAObP0zZHFuw27tFGi/JMzAfGQ=;
 b=Jn1uJH1vG5uQMeyB78m8uXwAPzalNFuryyb+AT4h6W8EeSjMMK7azY8kqi2qiIEEiflV4QVrnU3Y4490AlRTxCik4mQ9M7DgzdC4DDrLfHpmKLJV2wX+NT+GE/d28DdwTjNMatYyUYauRgcrdluWPguZn+WbV9/GVlnc5GWlWj4=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.13; Wed, 20 Jan 2021 04:24:58 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839%3]) with mapi id 15.20.3784.011; Wed, 20 Jan 2021
 04:24:58 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>
Subject: RE: [PATCH v1 0/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem
 Bay SOC
Thread-Topic: [PATCH v1 0/9] mmc: sdhci-of-arasan: Add UHS-1 support for Keem
 Bay SOC
Thread-Index: AQHW6onuUkkEuy8l00erpFnFLgBdlKou/OMAgAD1rjA=
Date:   Wed, 20 Jan 2021 04:24:58 +0000
Message-ID: <DM6PR11MB2876D6E1D507D7C72FDC8BB6B8A29@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20210114152700.21916-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrzg-mXTEQUd2oZiiSvbn29O+AGDC0VVDjbSQo6YOji8A@mail.gmail.com>
In-Reply-To: <CAPDyKFrzg-mXTEQUd2oZiiSvbn29O+AGDC0VVDjbSQo6YOji8A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d56ddbda-ba87-4e93-57ec-08d8bcfb58fe
x-ms-traffictypediagnostic: DM6PR11MB4345:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4345486A1DD67A07DFDB74DCB8A20@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHG2r5I8DkIsj+tIX8tuBENAApfNuMNS95NVp7Uo0Z3LUXFByXqu11qaCuhWqKMNVZyreM0OepEe6XXxdoLnyFKIoHB9OBrxJuQ+JppN6XWPzZy/Z5vKMqPQIcMt9Pr1VpKXXxM+j5B69DwMFBQK6xxE64mT2lzZ+u3y9Kl3n1pL8FGi4pB2cnLmJ1AIsT3pG72XVJ+FrsTErvh/SN3Y+282TyQgnaq6p8VQrJCAjHUmnPlyViiERdZKijsanMcGQyEt/0msr+nY8NOyM70A++MgI1sBLkNajhase6ncg2a7xnJfNt430OzIimFa0Oe3FP83P1Ya/cMIzCdirrEg405N50PbetgYFTsWx6VGvSszBLuUIihYa/vN+ZY4zgET
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(76116006)(86362001)(9686003)(186003)(2906002)(52536014)(478600001)(5660300002)(7696005)(107886003)(54906003)(55016002)(33656002)(66446008)(6916009)(4326008)(316002)(6506007)(26005)(71200400001)(66556008)(8676002)(66476007)(8936002)(83380400001)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U1RYMG4yMnJJSmY4SFdVeG5JcFI5RlBNdXlPa1BRQnVLVDU1c2dIVTMvQSty?=
 =?utf-8?B?aGJjNENnSnFqc2Zqd3dGUWI5K0NmU1p4WjBKZjhMM2dpa1BSRlpyc2hnTi9x?=
 =?utf-8?B?WFo3T2VranEwOEtxU0dRMGcxSWcrZVhEaTI5dktmTm4yMzYzc3ZhY0s3NmhS?=
 =?utf-8?B?bldma2QzamZVblNCb3daR3RLNzdKZHU4emNLZ0RhT2JaelpGSThaanBUSmI0?=
 =?utf-8?B?S3FERXFPc29Rck5OMVp6STlMaERFVDYyOWlIRGZwQWIyTVhjWDN1R21qcThM?=
 =?utf-8?B?SmJhTmxseUhnYnFZbytVZjVTblRuTFFsOTg4bUM1NlBHMVFvNzRSbmZrcjVr?=
 =?utf-8?B?Z21ESnFUYks0YlFYTmdkYzlBUm5qcjhlYThZbVZsNG96NU5PdnM1N2hoUXhU?=
 =?utf-8?B?Uk5DSlVhejhzTFlpcEdxZzFZTU52OXE3cEZiaFlvTm5MOEI4SkozaW9RTElW?=
 =?utf-8?B?bGhrbDEybUs4NnV3dnFyQmRwak5GaExwQS91b1ROMDNQSDRtZjhtMWlSUGZP?=
 =?utf-8?B?cGdrTnVMcHVTL0JKK2lvZ1ZiVXZTZTNoQmh2TmozN3JPVUlNaC9RZVpYMGlI?=
 =?utf-8?B?djJMZWdCSGN3b3Y1M25Fc3hTcDVvbFhYUzJ2a3V2ZzVDOGFEZC8xT2JoZ2RZ?=
 =?utf-8?B?ckp1SFBROE1ycjZXY3VodG9yYXkwM2pvcEsyNG9LcllKR1NMbncwVVhGbDJj?=
 =?utf-8?B?VEozbWd6czBRcHpaVzZsMDU2RnVwR2wyYy9XWmU3RmxUQThIOGJidW52aDAz?=
 =?utf-8?B?MGZXOU1nSW9mVmVIQjFzelh2eklVdVdrekFubThEQWFwZCtUZnR2dTRWNGov?=
 =?utf-8?B?Sk9zTWQwRENTdFlLMWdLUmUzOEkvNUsvVWsvRGhpbk1TMkJvRzFGbXdtbVZi?=
 =?utf-8?B?RGZraTlXenhFSk0wWHB2aTR5WVpWb2FuSTljdEFISVBRZFo5U29XYkI5Um9u?=
 =?utf-8?B?ODZlcWNlOWxvcFN2U1g4aktGV1AxQnRLQkRXR3JHTGhzbGoyYkFxajBlN0E4?=
 =?utf-8?B?RWhiNzhzdUkzQllGaC9uTGVMNGJUUUplaWx0dStFcVJRRFM2M2hySTNLNWRF?=
 =?utf-8?B?eTNGTDBvUEpGSVVxdDRVajRnZ1lMelZvcXltTlV1YUJUNG1RTzJZdFpGWUtU?=
 =?utf-8?B?QkNLZjVRWGhDL1NuakJrMVJNQ1JBdmNJblBOQzkwTG53MWFIbzl3aEtDd3d4?=
 =?utf-8?B?Ky9HbWcxcGNGMEM5SnJMbUw2M3Y2dnd6Vks4ZkZnRHE4QTZINVdZdUg3OUZw?=
 =?utf-8?B?aTNtNCs2YldSOWw4Vm1IQURqb3Y2Mks5dGZnUVExUzN0QXEvNlloTXV0WkNt?=
 =?utf-8?Q?kqwgzK5Vv7xGqAefs5ASZceGa288Ao0zUl?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d56ddbda-ba87-4e93-57ec-08d8bcfb58fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 04:24:58.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cx98/CdAjRn29epPefXW17djYVCl9QxwhDIrOUNf/Jv4INDdhmb7Ch9DsttWTl31rg4ftI9EB0o6mYIUcskC017BOCeSoyf3XmurMLvryyr/3oBPPUK8Gt0ce136AQtH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE5LCAy
MDIxIDk6NDMgUE0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1
c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5l
bC5vcmc+OyBMaWFtIEdpcmR3b29kDQo+PGxnaXJkd29vZEBnbWFpbC5jb20+OyBSb2IgSGVycmlu
ZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgRFRNTA0KPjxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
Zz47IEh1bnRlciwgQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+TWljaGFsIFNp
bWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7
IExpbnV4DQo+S2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz47IFNoZXZjaGVua28sIEFuZHJpeQ0KPjxhbmRyaXkuc2hldmNoZW5rb0BpbnRlbC5jb20+OyBB
LCBSYXNobWkgPHJhc2htaS5hQGludGVsLmNvbT47IFZhaWR5YSwNCj5NYWhlc2ggUiA8bWFoZXNo
LnIudmFpZHlhQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDAvOV0gbW1jOiBz
ZGhjaS1vZi1hcmFzYW46IEFkZCBVSFMtMSBzdXBwb3J0IGZvcg0KPktlZW0gQmF5IFNPQw0KPg0K
Pk9uIFRodSwgMTQgSmFuIDIwMjEgYXQgMTY6MjgsIE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkN
Cj48bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEhp
LA0KPj4NCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFkZHMgVWx0cmEgSGlnaCBTcGVlZChVSFMtMSkg
QnVzIFNwZWVkIE1vZGUgU3VwcG9ydA0KPmZvciBLZWVtIEJheSBTb0MgU0QgQ2FyZC4NCj4+IFN1
bW1hcnkgb2YgZWFjaCBwYXRjaGVzIGFzIHBlciBiZWxvdzoNCj4+DQo+PiBQYXRjaCAxOiBVc2Ug
b2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgaGVscGVyIHRvIGdldCB0aGUgbWF0Y2gtZGF0YS4N
Cj4+IFBhdGNoIDI6IENvbnZlcnQgdG8gdXNlIG5wIHBvaW50ZXIgaW5zdGVhZCBvZiB1c2luZyBw
ZGV2LT5kZXYub2Zfbm9kZS4NCj4+IFBhdGNoIDM6IEFkZCBzdHJ1Y3QgZGV2aWNlICpkZXYgaW4g
cHJvYmUgZnVuYygpLCBzbyB0aGF0IGRldiBwb2ludGVyIGNhbiBiZQ0KPndpZGVseSB1c2UgaW4g
cHJvYmUgdG8gbWFrZSBjb2RlIG1vcmUgcmVhZGFibGUuDQo+PiBQYXRjaCA0OiBDaGFuZ2UgZnJv
bSBkZXZfZXJyIHRvIGRldl9lcnJfcHJvYmUoKSB0byBhdm9pZCBzcGFtbWluZyBsb2dzDQo+d2hl
biBwcm9iZSBpcyBkZWZlcnJlZC4NCj4+IFBhdGNoIDU6IEV4cG9ydCBmdW5jdGlvbiB0byBiZSB1
c2UgYnkgZGV2aWNlIGRyaXZlciB0byBjb25maWd1cmUgaS9vIHZvbHRhZ2UNCj5yYWlsIG91dHB1
dCB3aGljaCBjb21tdW5pY2F0ZSB3aXRoIFRydXN0ZWQgRmlybXdhcmUuDQo+PiBQYXRjaCA2OiBV
cGRhdGUgcGh5IGFuZCByZWd1bGF0b3Igc3VwcGx5IGZvciBLZWVtIEJheSBTb0MuDQo+PiBQYXRj
aCA3OiBBZGQgRFQgQmluZGluZyBmb3IgS2VlbSBCYXkgU29DIFNEIFJlZ3VsYXRvci4NCj4+IFBh
dGNoIDg6IEFkZCBTRCBSZWd1bGF0b3IgZHJpdmVyIHRvIHN1cHBvcnQgS2VlbSBCYXkgU29DLiBU
aGlzIGlzIHRvDQo+PiBtb2RlbCB1c2luZyBzdGFuZGFyZCByZWd1bGF0b3IgYWJzdHJhY3Rpb24g
ZHVyaW5nIHZvbHRhZ2Ugb3BlcmF0aW9uIGFzIGZvcg0KPktlZW0gQmF5IFNvQywgaS9vIHZvbHRh
Z2UgcmFpbCBuZWVkIHRvIGJlIGNvbmZpZ3VyZSBieSBzZXR0aW5nIHNwZWNpZmljIGJpdCBpbg0K
PnRoZSBBT05fQ0ZHMSBSZWdpc3Rlci4NCj4+IEFPTl9DRkcxIFJlZ2lzdGVyIGlzIGEgc2VjdXJl
IHJlZ2lzdGVyLiBEaXJlY3QgYWNjZXNzIHRvIEFPTl9DRkcxIHJlZ2lzdGVyDQo+d2lsbCBjYXVz
ZSBmaXJld2FsbCB2aW9sYXRpb24gaW4gc2VjdXJlIHN5c3RlbS4NCj4+IFBhdGNoIDk6IEFkZCBV
bHRyYSBIaWdoIFNwZWVkIChVSFMtMSkgU3VwcG9ydCBmb3IgS2VlbSBCYXkgU09DLiBGb3INCj5L
ZWVtIEJheSBoYXJkd2FyZSwgdHdvIHJlZ3VsYXRvcnMgYXJlIGJlZW4gdXNlZCB0byBjaGFuZ2Ug
dGhlIEkvTyBidXMgbGluZQ0KPnZvbHRhZ2Ugd2hpY2ggYXJlICJ2cW1tYy1zdXBwbHkiIGFuZCAi
c2R2cmFpbC1zdXBwbHkiLg0KPj4NCj4+IEFsbCBvZiB0aGVzZSBwYXRjaGVzIHdhcyB0ZXN0ZWQg
d2l0aCBLZWVtIEJheSBldmFsdWF0aW9uIG1vZHVsZSBib2FyZC4NCj4+DQo+PiBLaW5kbHkgaGVs
cCB0byByZXZpZXcgdGhpcyBwYXRjaCBzZXQuDQo+Pg0KPj4gTXVoYW1tYWQgSHVzYWluaSBadWxr
aWZsaSAoOSk6DQo+PiAgIG1tYzogc2RoY2ktb2YtYXJhc2FuOiB1c2Ugb2ZfZGV2aWNlX2dldF9t
YXRjaF9kYXRhKCkNCj4+ICAgbW1jOiBzZGhjaS1vZi1hcmFzYW46IENvbnZlcnQgdG8gdXNlIG5w
IGluc3RlYWQgb2YgcGRldi0+ZGV2Lm9mX25vZGUNCj4+ICAgbW1jOiBzZGhjaS1vZi1hcmFzYW46
IEFkZCBzdHJ1Y3R1cmUgZGV2aWNlIHBvaW50ZXIgaW4gcHJvYmUgZnVuY3Rpb24NCj4+ICAgbW1j
OiBzZGhjaS1vZi1hcmFzYW46IFVzZSBkZXZfZXJyX3Byb2JlKCkgdG8gYXZvaWQgc3BhbW1pbmcg
bG9ncw0KPj4gICBmaXJtd2FyZToga2VlbWJheTogQWRkIHN1cHBvcnQgZm9yIFRydXN0ZWQgRmly
bXdhcmUgU2VydmljZSBjYWxsDQo+PiAgIGR0LWJpbmRpbmdzOiBtbWM6IFVwZGF0ZSBwaHkgYW5k
IHJlZ3VsYXRvciBzdXBwbHkgZm9yIEtlZW0gQmF5IFNPQw0KPj4gICBkdC1iaW5kaW5nczogcmVn
dWxhdG9yOiBrZWVtYmF5OiBBZGQgRFQgYmluZGluZyBkb2N1bWVudGF0aW9uDQo+PiAgIHJlZ3Vs
YXRvcjoga2VlbWJheTogQWRkIHJlZ3VsYXRvciBmb3IgS2VlbSBCYXkgU29DDQo+PiAgIG1tYzog
c2RoY2ktb2YtYXJhc2FuOiBBZGQgVUhTLTEgc3VwcG9ydCBmb3IgS2VlbSBCYXkgU09DDQo+Pg0K
Pj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2RoY2kueWFtbCB8ICAgNyAr
LQ0KPj4gIC4uLi9iaW5kaW5ncy9yZWd1bGF0b3Iva2VlbWJheS1yZWd1bGF0b3IueWFtbCB8ICAz
NiArKw0KPj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtYXJhc2FuLmMgICAgICAgICAgICB8
IDMxMyArKysrKysrKysrKysrKysrLS0NCj4+ICBkcml2ZXJzL3JlZ3VsYXRvci9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgfCAgMTAgKw0KPj4gIGRyaXZlcnMvcmVndWxhdG9yL01ha2VmaWxl
ICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+PiAgZHJpdmVycy9yZWd1bGF0b3Iva2VlbWJh
eS1zZC1yZWd1bGF0b3IuYyAgICAgIHwgMTEyICsrKysrKysNCj4+ICBpbmNsdWRlL2xpbnV4L2Zp
cm13YXJlL2ludGVsL2tlZW1iYXkuaCAgICAgICAgfCAgODIgKysrKysNCj4+ICA3IGZpbGVzIGNo
YW5nZWQsIDUzMiBpbnNlcnRpb25zKCspLCAyOSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlDQo+
PiAxMDA2NDQNCj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZWd1bGF0b3Iv
a2VlbWJheS1yZWd1bGF0b3IueWFtbA0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3Jl
Z3VsYXRvci9rZWVtYmF5LXNkLXJlZ3VsYXRvci5jDQo+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGlu
Y2x1ZGUvbGludXgvZmlybXdhcmUvaW50ZWwva2VlbWJheS5oDQo+Pg0KPj4gLS0NCj4+IDIuMTcu
MQ0KPj4NCj4NCj5BcHBsaWVkIHBhdGNoIDEgdG8gcGF0Y2ggNC4gSSBhc3N1bWUgeW91IHdpbGwg
YmUgcmVzcGlubmluZyB0aGUgcmVzdD8NCg0KVGhhbmtzISEgIFllYWguIFNlZW1zIGxpa2UgSSBu
ZWVkIHRvIHJlcXVlc3QgdG8gQVRGIFRlYW0gdG8gaW1wbGVtZW50IFNDTUkgdm9sdGFnZSBkb21h
aW4gDQpjb250cm9sIGZpcnN0IGluIEFSTSB0cnVzdGVkIGZpcm13YXJlLg0KDQo+DQo+VGhhbmtz
IGFuZCBraW5kIHJlZ2FyZHMNCj5VZmZlDQo=
