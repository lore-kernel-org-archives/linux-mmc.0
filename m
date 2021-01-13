Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1C7C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96FA523370
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbhAMNxO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:53:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:19806 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbhAMNxN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 13 Jan 2021 08:53:13 -0500
IronPort-SDR: N+5/8KxpUm9Z399jo8GQtJFn+At826AVUcQao2AJvdqtnn5ublRZYsnJ/g9VBHtW1afmxWUZbD
 M6PLYXJ65F5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157979307"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="157979307"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 05:52:30 -0800
IronPort-SDR: YobXfEPWNobtyYcsMOd2D5LGqY7PboGvLORkS8/RMWtXGTBYBA08SsyYV2bjA6lE4605E29qzr
 e4huvN1wL3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="567857722"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga005.jf.intel.com with ESMTP; 13 Jan 2021 05:52:30 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 05:52:29 -0800
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 Jan 2021 05:52:29 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 13 Jan 2021 05:52:29 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 13 Jan 2021 05:52:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWoQKklwm3wCPHkteLlXQfFXdL3huNtiT0rtyWVuCn5cjjDuIr9KkRSe2uu5vSpttXnIBkZso/rD2wz9ER6Ly7S6k1q1fUIPkFpKTuWG8dhGA3mpSnMkDTf4FK741ipJLhsKNvQbv6DfT9o5ZGE+PCfLEn+WIBl9+f5i8Exxa4fypfH/ReddW5bidljGpi8XQb06J8ScSokiR/Yla6d5/XXk2yT3tnwrle+qiPo1xP3POlKhdZJwfdysEjaUSwepMcIWZ0qabocE61Ljy/jNudiy+IHkaWsKVwKuvmykoAycnz1vKhulTQnZHZIK1C0uhdN6qjFiBu0X9E+UB+Q0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF20lZWW/WbdgcpLXX/2rArgzCTHHQGtWo0JV4JZHZY=;
 b=SZcAJtrYFfdEpQOAvhONCQ4QtnSSxYWC9g3XO06YWr1Ld/+xQOhn30SOjcVGZqQH+AQ2lVKKJLtKj94pe/1yARLukWzGQbhQdkXfSTPknTbtJYoRzmrXOVR9B7eYqTTfp1Hr82WCpT3GJxY+uD1MQwsmQRYmQQSfwKEODK556xBKHuGQR28gVQxd1WK93piKz2gdByMyisYauZQGsn2h5P1YDKC2ZKsWsjyG+7U9TEfGv7mWSC+GQaxxeo+l8HWbnsA97s7cYdjIKBml0YjChl7taC1Ue1Kmx+DNKUb77v8nAQr1H3V3wS+rcdkcvICivrAn2w6bVEFS4mXSsdw9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cF20lZWW/WbdgcpLXX/2rArgzCTHHQGtWo0JV4JZHZY=;
 b=qvRWYBd9/7N2qTpYQu+Og+Xb4GaVhKgKkY5Wqc609gBGRz0WAtH2vAdhcqdjp2DTEetSOGAQglaZcR+tDGW2+m+Y/A6nwZSyd5UQHM2iUX670F6++1HXvs4XPkVoJ6bQR5T6gtd4z8sWyUkC5gXAEPntHlqxbUj/eHT1KZUymx4=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR1101MB2204.namprd11.prod.outlook.com (2603:10b6:4:58::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.9; Wed, 13 Jan 2021 13:52:26 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::9504:fbb9:b745:7839%3]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 13:52:26 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: RE: [PATCH v1 0/2] mmc: sdhci-of-arasan: Fixed kernel-doc format
 warning
Thread-Topic: [PATCH v1 0/2] mmc: sdhci-of-arasan: Fixed kernel-doc format
 warning
Thread-Index: AQHW6DGrGQwaQMHmRkuz5DwAhx0gQaolbTUAgAAo6bA=
Date:   Wed, 13 Jan 2021 13:52:26 +0000
Message-ID: <DM6PR11MB2876648A09956A0BA2E254C7B8A90@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20210111155001.12307-1-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrx3ZhHk_k7OOEUWVuW-+wwq-x47-ZCteEB1gDJEFDoWQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrx3ZhHk_k7OOEUWVuW-+wwq-x47-ZCteEB1gDJEFDoWQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.165.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8353315b-b23b-4864-5155-08d8b7ca75ff
x-ms-traffictypediagnostic: DM5PR1101MB2204:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB22046D8EFC15382B4CA65FD4B8A90@DM5PR1101MB2204.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:323;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HUroI9YOAzP0+J1EKcIinEeMTninSc3oNIhYcI9fzCljP113WNwkXV6i116kp+wFu37eVgEJvYznaN6S+Kx82Vbdd5ZcE/MsB8IkfmKnMPi0+h0g5u6y9TvWsFxSYOcrMHhqByBLgyYLGcmrWfeiw2aDJ5tboEZuj/S8Oj+3WqV4g0Y56dfGz4K+XnYTZcrH3+qgEWVNO1LuHCS96zOTtWFrhcF/PejAGVBfAoAEMur969XYYwmDMYB0Mo/ALf770ZKvROahIMjKbQMDW15bLxVVX7s6WB4rELtYclo5uDcOvYaFotbjnK+MdeIieWAyVlLa07gzF/SXg7sq/J4lsDloeQ+4gJ1bP9eBGAGYSdbIajf7E1lh4mzPPq03j50PiW63ULYKPmMIPL+F5x8cMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(76116006)(6506007)(107886003)(52536014)(6916009)(9686003)(33656002)(316002)(7696005)(26005)(66476007)(66446008)(66946007)(71200400001)(55016002)(186003)(4326008)(8676002)(478600001)(83380400001)(86362001)(8936002)(64756008)(66556008)(5660300002)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?am5ueXdUcDVYWEEzNnJXb1N0dklGMnJvTCtHMmd0SEdtRkhBbXpLK1VOZENW?=
 =?utf-8?B?aEJZSXRKdDYvRkJCS29UejBsamlvUDZudXRSQkpsSnpIOVYxTU1HcXBOd2E2?=
 =?utf-8?B?UEFzUktBdjNMSHdaRDFZQlN5RElLclZSTG5jZlV1ZElYbzdrMHdtcjRhQ3ha?=
 =?utf-8?B?MlVHS3NxdXpDbzBRL0l4QURpamVlSUgwUEh1RkFsVGZGN3ZsTCt2cnZwUXU0?=
 =?utf-8?B?RmNVODdUV1FBQytycGgyKzNlWlFhYU9PVWxuNlVvTnpoZ1JmYlhUZ0YvQmdq?=
 =?utf-8?B?ZmJNVGMrMEJxRCs5N1RIMElDbWpYQjcrY3R1NDBtYzJaWUJNUGVDMDl1WGtq?=
 =?utf-8?B?ZzNRVnFHYkpkajBWVWVTNHNEVHIzMFR0RTZMRjZuN2RqdlNKUU50TXlBWkR2?=
 =?utf-8?B?dFZZenN0U1k0aVpOSUx2OENxQ3l5WTdBcmszckZGNjNUU2E0dWRQaXFna3Na?=
 =?utf-8?B?L3UyVFdLZmQ2VEErNldYQjVCT2xlQnZwa1UrelhkMVRLWWVyQi9Zc2F2YWFi?=
 =?utf-8?B?NXMramtQbnI3RjFWTzhkVHFIVmNlYW5lM3V3bWtjWWU5OCtQbkFuMWJ1Um5E?=
 =?utf-8?B?R3VndDdEei9LZ2J0VFYxL2x2NGJlTEw0RUVPODU3MVZRcUV3WnhES1h1NC8r?=
 =?utf-8?B?bXQ3S3k2dm96RVRCRWkyNm9PeTE1OG1xTlJMZlp6UTZ6c2E5UDg1R3g3Q0xD?=
 =?utf-8?B?enBERS9qU01CQ0dFMWJjYmxEUnhzcU9kRFd6V3Y0NmhZeFp4amtka2V3WTU1?=
 =?utf-8?B?dGN2T3YrZzZBa3F2ekNtTFcrUXFnQmIxYm1SQXRCR3RNUlBoeXZHcjgydmF5?=
 =?utf-8?B?OFVpcktZQW0vUGhFU2lQTWV5QzhiYTU1b3lObGx4eFM2S0VabVdhNU5QWFBW?=
 =?utf-8?B?U1BLWWhaU29yMXNyMkt2Y2hKYWkrYU9VV05jMk5rQmR0NmE1LytVT1IvbFM5?=
 =?utf-8?B?Z1VlK2gzMkluMXlXQ3N4SytPaGZIaXhyUDhjOGpJTXNiTTZubHBSR1YvRkN1?=
 =?utf-8?B?VlNiQWZrM2NTWEVyQWJXbzlucDR5eXJFbHYzUlZiNmdZOXNucklvME1xVUgv?=
 =?utf-8?B?QVZKdXBrM3B6emkvQUxiTkpudU1vbW5OZ01ma2ZvQ1dkWER6bXlkVjJGSFkr?=
 =?utf-8?B?QVVST1hFVEpXdkxvNm5uSy9Sb2Q3YzY4Y1ptcHFnWjY3aDFjYThkWVZsUkc1?=
 =?utf-8?B?V1RYckZvZ0s0dmJidVpVLzB2ZVZmTTE5TmZuV0p1YUNNdlFQNWZpeWdxVWdL?=
 =?utf-8?B?TmoxcEJEZ0Y4Q0R3UmFtSGRnVmZrNGtMelFBOGlFUWEwRWNXYTYvRWoySjJT?=
 =?utf-8?Q?kJepHyTn5mSv4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8353315b-b23b-4864-5155-08d8b7ca75ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 13:52:26.2729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ero+zG1YMN5oG0dwbu8fcn+dlHlDAX0SbsMEnQjps9N1RzvD4/Uokn4iojlhuyP4UMUtbdSklYbhfBRrK9tnbE8HBOM+nRX/8XFppK0wwesbngepKKXcePeSpMtC68qf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2204
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQpUaGFua3MuIA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9t
OiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj5TZW50OiBXZWRuZXNkYXks
IEphbnVhcnkgMTMsIDIwMjEgNzoyNiBQTQ0KPlRvOiBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWlu
aSA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Q2M6IE1pY2hhbCBTaW1l
ayA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOw0K
PkxpbnV4IEFSTSA8bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXgg
S2VybmVsIE1haWxpbmcgTGlzdA0KPjxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgSHVu
dGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsNCj5TaGV2Y2hlbmtvLCBBbmRy
aXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYx
IDAvMl0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IEZpeGVkIGtlcm5lbC1kb2MgZm9ybWF0DQo+d2Fy
bmluZw0KPg0KPk9uIE1vbiwgMTEgSmFuIDIwMjEgYXQgMTY6NTEsIE11aGFtbWFkIEh1c2Fpbmkg
WnVsa2lmbGkNCj48bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+IHdyb3RlOg0K
Pj4NCj4+IEhpLA0KPj4NCj4+IFRoaXMgcGF0Y2ggc2VyaWVzIGFyZSB0byBmaXggdGhlIGtlcm5l
bC1kb2MgZm9ybWF0IHdhcm5pbmcgd2hlbiB1c2luZw0KPj4ga2VybmVsLWRvYyBzY3JpcHQgdG9v
bCBhbmQgdG8gY2hhbmdlIGNvZGUgc3R5bGUgb2YgbWFwcGluZyB0aGUgc3lzY29uDQo+PiBmaWVs
ZCBmb3IgcmVhZGFiaWxpdHkgYW5kIGNvbnNpc3RlbmN5Lg0KPj4NCj4+IEtpbmRseSBoZWxwIHRv
IHJldmlldyB0aGlzIHBhdGNoIHNldC4NCj4+DQo+PiBUaGFua3MuDQo+Pg0KPj4gTXVoYW1tYWQg
SHVzYWluaSBadWxraWZsaSAoMik6DQo+PiAgIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBGaXhlZCBr
ZXJuZWwtZG9jIGZvcm1hdCB3YXJuaW5nDQo+PiAgIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBDaGFu
Z2UgY29kZSBzdHlsZSBvZiBtYXBwaW5nIHRoZSBzeXNjb24gZmllbGQNCj4+DQo+PiAgZHJpdmVy
cy9tbWMvaG9zdC9zZGhjaS1vZi1hcmFzYW4uYyB8IDE1ICsrKysrKystLS0tLS0tLQ0KPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pg0KPj4gLS0N
Cj4+IDIuMTcuMQ0KPj4NCj4NCj5BcHBsaWVkIGZvciBuZXh0LCB0aGFua3MhDQo+DQo+S2luZCBy
ZWdhcmRzDQo+VWZmZQ0K
