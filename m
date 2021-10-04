Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76134C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 06:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56FE461373
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 06:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbhJDGGC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Oct 2021 02:06:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:21148 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231935AbhJDGGC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Oct 2021 02:06:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="248551248"
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="248551248"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2021 23:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="566844635"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2021 23:04:13 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 3 Oct 2021 23:04:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Sun, 3 Oct 2021 23:04:13 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Sun, 3 Oct 2021 23:04:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJPjccv6fqPSg6pUXb0mhLst+0CmhAzd3c3M9qrFvMN4PzfHGll3Y5XbkwgyLEFvJ0ZZfU94fU2ZwoBev08pTfyACKtRTAjW2uYDju015urG+Jm6wLvS+YHTy03JhbLSa+dtm66HMHln+bdH93yJsVIlupkXb0zBldd76R5YpzWoqFoPDWLxUqTfS2hlq6NLvY8L8+R0urHc3US+CFid0CzDqXHIHs0ndTnFV3+CoiyC1GJC5r3ux3piqVUhgbCZiIk0dqofvRRQ2itKz9iun50IIwDlIkVWh59K4ijxAolfGNyNFuMkJkrCfFsNLcc9xNv7TBkUum/UEdaSNHO/Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k98BCOztg1Vy0/Zw8E7rW9ZZ4mUThqjcGgamn+I2RgU=;
 b=lpt0q0Qv3ajWLV46XHHH53HfD9gD+7rL1jxKFInD0mTAMNGLlVmXnGn4w7xIGJ6nhXIxI+yGppf3Q5zp9JyAQV2GMH5XuGFx2Medig82W5K4HXtN+a3zLcTWKPa+i89pJB9Rgv9oh6ClgxI7+IvMZqNyWFEDxjZa483jshGT2Sg+lxlFTDbgPXySL9dn9n0Xzdhf9vywbyA37iOU7CglWzP1nvHJYwa6E64BzNBafr1IIH4wANljs/kUC1jTGotpykepp4kkpKHV76VuAO2M5kRGpMaRK2xT+dqok2dKLQR+aBN4z74hgZZInWhBcftlY+HRQnGqkGitDotb83llxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k98BCOztg1Vy0/Zw8E7rW9ZZ4mUThqjcGgamn+I2RgU=;
 b=AFly2obdtU/wEfrzrwFuR9y8litBhv9yhrxm4YJr8WVQvtZkx+rI7N6HzB8vVuJ4li1J9vWrX1+vWWRJndjd0nuG4GqFRR2Gs98sxehwfSVsd3EhvDIOpVroPROhN0H24kY51dbyh3mDoBnS6t4JqHjHNuStnjK/7HWo2aLP4Hc=
Received: from DM6PR11MB3065.namprd11.prod.outlook.com (2603:10b6:5:72::15) by
 DM5PR11MB0026.namprd11.prod.outlook.com (2603:10b6:4:62::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.14; Mon, 4 Oct 2021 06:04:09 +0000
Received: from DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::ace2:ed94:516:31a7]) by DM6PR11MB3065.namprd11.prod.outlook.com
 ([fe80::ace2:ed94:516:31a7%4]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 06:04:09 +0000
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
        "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Subject: RE: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Thread-Topic: [PATCH v2 0/4] Add support of eMMC PHY for Intel Thunder Bay
Thread-Index: AQHXnQMuYeQydCD7LECFRtxjQUnwfKuje/GAgB8UJTA=
Date:   Mon, 4 Oct 2021 06:04:09 +0000
Message-ID: <DM6PR11MB306560AE06F83FC56B9F89988CAE9@DM6PR11MB3065.namprd11.prod.outlook.com>
References: <20210829182443.30802-1-rashmi.a@intel.com>
 <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
In-Reply-To: <CAPDyKFq2VQ=khYnmfsQGPPcpRnxyATVSpwKSZ4MTbKn64rthVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8f0f17a-b51d-4e07-59ec-08d986fcc7ea
x-ms-traffictypediagnostic: DM5PR11MB0026:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB00260BEE528010E20A05EBD98CAE9@DM5PR11MB0026.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QuBGKFr/WKIgpjMLhV4np9wqMpRaXuMVdsZf5bwoZx8ZJP7WseWfStSwJDG5m8zUbuu42y++CM/bRrsacr1jMflv5CyhI7oneXceoCwYwqHGjrYx9+bcnlvkNY+NQUOMlW06dfvKTBp3OYZSPgE0DCQ0oAPx8P5e3t5M33ovyvazO/HzvrYZxmQLIDletytQBI0wUJ/dpjirtwTxsN+Y7cdTfufzdBdgU683NKpKIr5y2JoRmtzgKpW6y8op27M+errdutSf91xyw3gEc7u5EbWizFiHxC8TwxXcj4lnK2/rMRc2PKmywm7qGzKMGOyUxj5/WnSaYifK9tVNraSBhQjyHXhQPUDQYLBdK0K72ZR4aMsp29sXbUQ5NXCNbCYaQ8T3AB2Wu1yZpoVkSh4Wd2FhqAlU0KLtjYMZl8ySgKNhH71jhne9ovv9GU9ykNfo9VuvTSqF3LyLss+a1MK1/rarSvliOdtvJOaPyICmfdqF+222JqPK5+tmtXG2VL82SYPA9Hkk6t8yyDTZAv5vZJEP7L1pXLbDkEgbUhlsVQAxAqwEygxISWWByGV0ToFhey0MSWztqELhN7QHj/tt/Y/jKYavo+2bklWJFeJn7vL71lGfGTQmTif+YOeIbzbvDNxxNLGkI0Ai2kXoXRMoOAPUwFdhe0WEDZN47B2JFkzfwaH++KeFMtvIN4+9ReAR6Zy7omHx3xJce5c0GF1dmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3065.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66446008)(33656002)(64756008)(53546011)(38100700002)(6506007)(52536014)(83380400001)(186003)(7416002)(71200400001)(316002)(5660300002)(4326008)(2906002)(8936002)(8676002)(38070700005)(7696005)(55016002)(26005)(76116006)(6916009)(66556008)(66476007)(9686003)(66946007)(508600001)(122000001)(54906003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q05PTEpQT3NtdUd1Z0lsUlJFUmdLWW51WVpsM3FqSFkrenpsSTZjNTJ4RkNW?=
 =?utf-8?B?aDJuTHJsckVlMlllVnJDeUk1NDl5NzdFZ0w5elZiRWkxSFRoY1RCRHp2RWZt?=
 =?utf-8?B?S29KdkhuSWNpTm9VaTZGRENkOEhFbVhvQ0FnNXpkanBuUE1KNFlMZks1dWZT?=
 =?utf-8?B?QjNqdVAvSEZkVXZrV20wdmQ5NGYrazhjSkdlTDNHOWRrZFdNbmVHNXdVWTVy?=
 =?utf-8?B?aVVNbkRGZ0lqa0VITzRXNXArMXJocXBZTHZZNitGRTNFZ3poOWw4WVQzMUx3?=
 =?utf-8?B?ME9uZzlZK0NGQ3M5MkJqTm5iOVVQSnB5YlFkams0ckU3MU9nU0tMRWIzQUZ1?=
 =?utf-8?B?MDFQR3dkRTdzbHR6cGxONllrRmU4Y2UxOHBSZzV5aXdRTzAzL2dDWWZHT1Z5?=
 =?utf-8?B?N0VDd2llMWo0bWwydEZQRE5vSTY2OTVxVGRGT29Ob0pndjZXa3Y3bkl4bmpi?=
 =?utf-8?B?NTFpeFlNdC9yT3lFU0VFUjZjaW9JSno1RlllczhoTlVGci9LRUV4NTVOMWVl?=
 =?utf-8?B?eFJqRXhEUkZvbnhRUmhCMlRwZjJDMEc1SnBITEZ1bmRSa1pIRWpkRmVZaEJy?=
 =?utf-8?B?WUNnZUxXZ0R5Y0s0Zmk2Y0xuVkJENTZNRU5mNCtXdWRXZERhVzNCditYd1B6?=
 =?utf-8?B?Ri90bHZScStuZXQ4am02ZWhOV0o0QURZY2IrSG9NOG1FN1dQZm1EWjFQY1U2?=
 =?utf-8?B?N1BWUEw5QmIxT0E1Rk5nVHJlQVJUeHhSSFg1MkdRTkxLYklKYTlJOXRXWmE0?=
 =?utf-8?B?S0tHcktKY0thYmVMeWM2MEwybzAwWnQxbUcvSWhTNENmWDRWaDhUSHU4dFZk?=
 =?utf-8?B?Y0lia1BQcDd6aEJQNzk0NjNmNFJlTkFPeTlkdHZYcVp0TTUreUY5RDNKRE04?=
 =?utf-8?B?NTVXbjBvMXhVa3hkRWREdEZrNXRHWVkramEySzRjTjYwZU1pMHZoWjl1VnZj?=
 =?utf-8?B?VHY2M1FSTHFkQUFhTW5nZ3V0SmZUb3VJeVBja0xFZkpqaEp3Rk5YQyszSUJZ?=
 =?utf-8?B?dDltZVczUzFwbE5FMkp0L1lURW00RDJjRk1MVFdHaVV6YUdxRVF4MmtHejRC?=
 =?utf-8?B?bFVESm1CUmd0bDlUM0UvWStHa0VlUE5XNXZGb1VTZmVpRHV1VFhua3lPUE9H?=
 =?utf-8?B?S01ENXMzaC9rd1IvSTgwZTVTbWVRemJ2bGNaeGwwNmhSRjdsNFVBVDVUUS9h?=
 =?utf-8?B?MGYrbmxlejgxK1BwWVdjRWlmUCsxeWp4MVorSHlQS045bEd5UHlmSi93Zk5X?=
 =?utf-8?B?WXpTYUtsRitkT3Q0VUduSm1xS1U0cVZRMXFZQzY1VlNzd0hSU2pzeW1VQzJV?=
 =?utf-8?B?RGtUR2UrSnE2SlBJc0g5WlhkTDNYVWowRTJuTXdVU1Z0QVlPS0hJekdvblQ3?=
 =?utf-8?B?MUl1VXc1cWMwdkNDQmZmOFBiclBUMTVIQWgvbEhENUM5YnYrTmtKeE1MY0d1?=
 =?utf-8?B?STR1cDJZUjJpMW81dVA3UENXcGtVSzlTdTBhdEtncVc1ZWQ1MHdlNUI5TXRw?=
 =?utf-8?B?aTBIeGlpVHoyVHhDNFFrTFZhTVNjenJGcjJadHBUUmZRZERKaDVLamIwcUFw?=
 =?utf-8?B?cFF1YVpTSWRSaStRWUpFS0ttVnh6RXlGb1Q3NnpUaVBpMmtLdTNYLzhLdnYx?=
 =?utf-8?B?MS9wNGYyTHJ4QjVuV2xuVG1vVHArWGlJZEpaNHZKQVQxYTlON28xUjNtajFw?=
 =?utf-8?B?RjUyNlB0UEFEN3BKRVRWRlNFOExvME1rOWNxZExKaVNVcktkdkNETGxLZDdK?=
 =?utf-8?Q?oJBBadC+V9V+y9YNIcOXT5JlAhOox3EywOECm+1?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3065.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f0f17a-b51d-4e07-59ec-08d986fcc7ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 06:04:09.2592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M2MqCtJ1GI/w1FtmQuuJ6P3s41EewrpRRB8Gt8wIBAXpZAcrpRmN8PM9Et2pmlQveGTXOG3Zop4V3KEBUidOFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB0026
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4gDQpTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTQsIDIwMjEgNDo1
NCBQTQ0KVG86IEEsIFJhc2htaSA8cmFzaG1pLmFAaW50ZWwuY29tPg0KQ2M6IE1pY2hhbCBTaW1l
ayA8bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBsaW51eC1tbWMgPGxpbnV4LW1tY0B2Z2VyLmtl
cm5lbC5vcmc+OyBMaW51eCBBUk0gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBLaXNob24gPGtpc2hvbkB0aS5jb20+OyBWaW5vZCBLb3VsIDx2a291bEBrZXJuZWwub3Jn
PjsgQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+OyBs
aW51eC1waHlAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTWFyayBHcm9zcyA8bWdyb3NzQGxpbnV4Lmlu
dGVsLmNvbT47IGtyaXMucGFuQGxpbnV4LmludGVsLmNvbTsgWmhvdSwgRnVyb25nIDxmdXJvbmcu
emhvdUBpbnRlbC5jb20+OyBTYW5nYW5uYXZhciwgTWFsbGlrYXJqdW5hcHBhIDxtYWxsaWthcmp1
bmFwcGEuc2FuZ2FubmF2YXJAaW50ZWwuY29tPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tPjsgVmFpZHlhLCBNYWhlc2ggUiA8bWFoZXNoLnIudmFpZHlhQGludGVsLmNv
bT47IFNyaWthbmRhbiwgTmFuZGhpbmkgPG5hbmRoaW5pLnNyaWthbmRhbkBpbnRlbC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDAvNF0gQWRkIHN1cHBvcnQgb2YgZU1NQyBQSFkgZm9yIElu
dGVsIFRodW5kZXIgQmF5DQoNCk9uIFN1biwgMjkgQXVnIDIwMjEgYXQgMjA6MjQsIDxyYXNobWku
YUBpbnRlbC5jb20+IHdyb3RlOg0KPg0KPiBGcm9tOiBSYXNobWkgQSA8cmFzaG1pLmFAaW50ZWwu
Y29tPg0KPg0KPiBUaGlzIHBhdGNoIHNldCBlbmFibGVzIHRoZSBzdXBwb3J0IGZvciBlTU1DIFBI
WSBvbiB0aGUgSW50ZWwgVGh1bmRlciANCj4gQmF5IFNvQy4gZU1NQyBQSFkgaXMgYmFzZWQgb24g
YXJhc2FuIHBoeS4NCj4NCj4gUGF0Y2ggMSBBZGRzIGFyYXNhbiBzZGhjaSBzdXBwb3J0IGZvciBl
TU1DIGluIEludGVsIFRodW5kZXIgQmF5Lg0KPiBQYXRjaCAyIEFkZHMgYXJhc2FuIHNkaGNpIGR0
IGJpbmRpbmdzLg0KPiBQYXRjaCAzIEhvbGRzIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5nIGRvY3Vt
ZW50YXRpb24gZm9yIGVNTUMgUEhZDQo+ICAgICAgICAgYW5kIGxpc3RpbmdzIG9mIG5ldyBmaWxl
cyBpbiBNQUlOVEFJTkVSUyBmaWxlLg0KPiBQYXRjaCA0IEhvbGRzIHRoZSBlTU1DIFBIWSBkcml2
ZXIuDQo+DQo+DQo+IFJhc2htaSBBICg0KToNCj4gICBtbWM6IHNkaGNpLW9mLWFyYXNhbjogQWRk
IGludGVsIFRodW5kZXIgQmF5IFNPQyBzdXBwb3J0IHRvIHRoZSBhcmFzYW4NCj4gICAgIGVNTUMg
ZHJpdmVyDQo+ICAgZHQtYmluZGluZ3M6IG1tYzogQWRkIGJpbmRpbmdzIGZvciBJbnRlbCBUaHVu
ZGVyIEJheSBTb0MNCj4gICBkdC1iaW5kaW5nczogcGh5OiBpbnRlbDogQWRkIFRodW5kZXIgQmF5
IGVNTUMgUEhZIGJpbmRpbmdzDQo+ICAgcGh5OiBpbnRlbDogQWRkIFRodW5kZXIgQmF5IGVNTUMg
UEhZIHN1cHBvcnQNCj4NCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9hcmFzYW4sc2Ro
Y2kueWFtbCB8ICAyNSArDQo+ICAuLi4vcGh5L2ludGVsLHBoeS10aHVuZGVyYmF5LWVtbWMueWFt
bCAgICAgICAgfCAgNDYgKysNCj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgNyArDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWFyYXNhbi5j
ICAgICAgICAgICAgfCAgMjkgKy0NCj4gIGRyaXZlcnMvcGh5L2ludGVsL0tjb25maWcgICAgICAg
ICAgICAgICAgICAgICB8ICAxMCArDQo+ICBkcml2ZXJzL3BoeS9pbnRlbC9NYWtlZmlsZSAgICAg
ICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgZHJpdmVycy9waHkvaW50ZWwvcGh5LWludGVsLXRo
dW5kZXJiYXktZW1tYy5jIHwgNTEyIA0KPiArKysrKysrKysrKysrKysrKysNCj4gIDcgZmlsZXMg
Y2hhbmdlZCwgNjI5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkgIGNyZWF0ZSBtb2RlIDEw
MDY0NCANCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9pbnRlbCxwaHkt
dGh1bmRlcmJheS1lbW1jLnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL3BoeS9p
bnRlbC9waHktaW50ZWwtdGh1bmRlcmJheS1lbW1jLmMNCj4NCg0KQXBwbGllZCBwYXRjaDEgYW5k
IHBhdGNoMiBmb3IgbmV4dCwgdGh1cyBsZWF2aW5nIHRoZSBwaHkgY2hhbmdlcyBpbg0KcGF0Y2gz
IGFuZCBwYXRjaCA0IGZvciBLaXNob24vVmlub2QgdG8gcGljayB1cC4NCg0KVGhhbmtzIGFuZCBr
aW5kIHJlZ2FyZHMNClVmZmUNCg0KDQpUaGFua3MgVWZmZSwgDQpIaSBLaXNob24vVmlub2QsICAN
CglQbGVhc2UgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbW1lbnRzDQoNClJlZ2FyZHMN
ClJhc2htaQ0KDQo=
