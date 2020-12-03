Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954BFC63777
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2385B2086A
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Dec 2020 07:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbgLCHLD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Dec 2020 02:11:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:19122 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgLCHLC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 3 Dec 2020 02:11:02 -0500
IronPort-SDR: 6QLFMoWG+PE1cnVcDui9n7cN0AUqdHhOHhSSY5oLDcaNdGnp0bbKh8jzVhYzpGPxkLWpUL3n8s
 DFh0goGswugg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="237267332"
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="237267332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 23:10:21 -0800
IronPort-SDR: QtG0/MJE4l0eyLGjyFwuHQXQ5kThhs7JtpIrzo1mkEn9UW0IAmc32A5gqyWJKlp7Jthn7jw+JE
 oLX36lZ+gPHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,388,1599548400"; 
   d="scan'208";a="373797998"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Dec 2020 23:10:21 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 2 Dec 2020 23:10:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 2 Dec 2020 23:10:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Wed, 2 Dec 2020 23:10:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6L92tHZyoyQ507nxVFc3d4yWupSPlThSa/xkqYxzgGngXrqw+TZy/E41HnH+lOkmjYvlM5hPMgRofrNVCn1axxX1RYd1R1LhXCUIO4C7+DUP74oAyd2YMadW+YaDdmw1rXSHvcXdKYRh/pnuG62QiPBuYo2hJGYWyfGG+xe8zETk49Ay1rXo1lDAaujLhFuqfKItvOHhQc7TRBSiK473/vZLs8VGpoXEFyqOPQKwnyBc9M+dREno82g9WinVhjOf4Pb3TqNCp7nRZPfBWkzI1GCYcOIQyGck09GxN5kKbpaYv2sHH/4Y2sMUuKeeHP/4969msKWguus4apLWeSPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYeiJlkKiBFEHt8H6Qn+A7jt3NotQbP9f2HTIH3T9sE=;
 b=iqe1LWRbnB/MtybbCgFzWW4J/kUK8pIlR8Ytb7TkrYTClAxf0bRw/xVWcs5rrijIWWfS/3+hUoXtGIn3cbT1cLbBnZAVU/BAWcJu+lO+SA/t59Ou4icHIHbbU/5ou9W1Zs4Q4wmByOWHPfDcKLyMfAZlBHcbXy1EiigOgpKjnnlXCj7BY+xyJ/vq8f8dylOC7irrMXiaiFxyZ1/hdgQOhecyqjzvWndjy4VzZAuRhXdCNBm8od34J9hGDeRdtNKoZAH2KzeaI+C4B7xQxx+3W3W6Kw40m5NFoO5XDCVRL1hAoiPhx+ByJCPAqJ03UWA99AZhq/5XWBGQg5e5oi+n8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYeiJlkKiBFEHt8H6Qn+A7jt3NotQbP9f2HTIH3T9sE=;
 b=ri0YO7J3vY4l6WkSdWunPCpV4LFv6A6g6scg/t/SGsx6V9JYNhIA4vpR5GwHOQyeurQiG+6jO6yxAH6MrTLfrxDcL464im2YwE1KiSFON761JBgKpKEiQYR5lMxnonJIPRmdOFxpVEBWgBYSvRmGPmkrLN+Llrtfnelc4zUrizs=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM5PR11MB1867.namprd11.prod.outlook.com (2603:10b6:3:10c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Thu, 3 Dec 2020 07:10:14 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::a875:dbdd:a42f:a08f]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::a875:dbdd:a42f:a08f%7]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 07:10:14 +0000
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
Thread-Index: AQHWyHkojjbNbOhNAE2Psph8K+UZvqnkKEyAgADGsfA=
Date:   Thu, 3 Dec 2020 07:10:14 +0000
Message-ID: <DM6PR11MB28767ED32E97BF93C5F3C7B4B8F20@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201202150205.20150-1-muhammad.husaini.zulkifli@intel.com>
 <20201202150205.20150-5-muhammad.husaini.zulkifli@intel.com>
 <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com>
In-Reply-To: <CACRpkdZznKd4NYk8whBtq1sUAj9uhasn3+ykrh50A2XKokp=Aw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.180.206]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: abbb11ef-d237-4eeb-e17e-08d8975a7b7d
x-ms-traffictypediagnostic: DM5PR11MB1867:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1867398766A7BCED7EEF249CB8F20@DM5PR11MB1867.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TH/cjcKL6fMo3jL5QtLfni5MpPQim01ESm0SXocDccq/JAYHc8QMSj3G8LPxRfviexCAJsO8SBLYBX4lzzMOwsI7k2t8wxeC5P5bR7I4V1k/aNhPcAU31NksND0PjPx6v7esRkQgrWyIue38hQBYuiK3lFM1Q1ff6+duMeWJapdnMqn5u4qgo+iAU5jXoHKfq8IFzvP/CEofVV/VSF/vSoZ5IKoklXIKvogPxLdcPKQOP3VoyqZkXhfrSs1cAqbZyz13/medKKnGZ0/3DIC24v0qow/CXzgaIMHDvG9T3yaGhbF9oDuA3UfVi6l+wAyB7L07XsIB7f40tpLJA40C4+d7rDzYNrrqNGBfHSmkgajIO2+zqp9+yPfmDEtrH2OqjOIZCh2wJGBnbip2N10ogw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(83380400001)(86362001)(54906003)(316002)(33656002)(71200400001)(5660300002)(8936002)(8676002)(26005)(478600001)(66946007)(966005)(66476007)(6506007)(7696005)(66446008)(4326008)(66556008)(186003)(6916009)(64756008)(52536014)(9686003)(55016002)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?R2ptbVZiM2pQamVxak4zR1RTKzdDS1Q1M0lrRVBadmFtZDBDQVlyU001bG52?=
 =?utf-8?B?Tjd4MkZwSjJJNjY3aU5QQ2JseU04WUtRNE5kRCt6cTZJc1hYOVpTekhYRVF6?=
 =?utf-8?B?S1RsYndSUHozd0E2Tm0wanF1ZlRaUmF4Qnp1c1ByV3E1NjUyOG9CY09iYWY0?=
 =?utf-8?B?TVYrNlpNQW80T245RHNuUnBlYUlMQ2w5VmJwVnFiZmVHa1JoMGZ6QVZid0xp?=
 =?utf-8?B?SG1HdnZWYkZXbWJtWHo5cE9Hb21nSXJxdWw0bHhwUWppNkIzUmJxbFBmVGJX?=
 =?utf-8?B?ei8wWVFVZno2b01FdnhZbUlGRUdKcG9XcUtCVklpTzFqSUd0ZFRtUmtsL21N?=
 =?utf-8?B?REZWV3VoZDA1V2dQN3lqNE16YnRqSTdBSW0zOGd2STBROE9nU1E0aVIrcVpj?=
 =?utf-8?B?dGYwY0FONzB5Q3FtZnR5SUt4U3kwOTQ3MDAxMUk4M29MbHRhdlFLZTJtcjFI?=
 =?utf-8?B?a2MyWVJPdWw2SW1HSkVxekFJeFYvMzM5eVNsMXczaDF3amNRUC9DTG5kTElJ?=
 =?utf-8?B?SVgvZFZjd0hsQ3FSNW5jdG53M2ZjNzBjaWZNUlRmdVRoaVFuVXJaeUY5d1dV?=
 =?utf-8?B?OTZtQXBsRlhIVThYZ3NOWjhwWUVKZVh2MFp0S0Y0cWp0V3gzd0VDclVuUUJD?=
 =?utf-8?B?RXVtNmlsQmZkTkhhNHNrZ29CdHlhNUZCTk8yVlZXS2NOQ0tJZjF1cEJVU0ZV?=
 =?utf-8?B?SDNQLzREczFIdEpMcjVxQjVldEVuTXZsUGplYUFoVnowd0ZLTDhDOHhUNEJ3?=
 =?utf-8?B?MlYzL0U0WnZHSXhxQWEvcWNiWFMvNVZLUUNZRERyVHZ1TXd1UDY4YkJHMlVY?=
 =?utf-8?B?T29Eekc0N0Mzc3praWhmUWFlVTVDd0VEYWN5ZENaUmVqY2hzRklIK25pOENS?=
 =?utf-8?B?Uk04ZUZRS2tVWG5TbFBzNk5FSkh3NVp4Nk10TER5dzZQdmZBSndhZVpCUmRL?=
 =?utf-8?B?TGQ5Sit4R0oreTgyZVZSVkhjVlNNN05IMDVCdGxicERNcjNYRVplb2Y4cDdX?=
 =?utf-8?B?QUwzUEp3ZWl6a05JbXU1YmpYV0F3Ry9ZWFllSTBHSzFkeTJvdFpIL1BzYWxG?=
 =?utf-8?B?WE1oejNBeXNqOHorZGF4VDBSZUx6a2g0SWZLSm9JZHlTYVUzalFFYkFRak5o?=
 =?utf-8?B?Um0wODc1THRKTWVncVc3bXVuM2pQbkZFQjVzdXNMT2pjYWFSdCsvZDBuVUxJ?=
 =?utf-8?B?Sko1S1U1enVZUVhTOXRxUmpTdXkvbW14QU5ncExGYTNHUkw2cmZ6Sms4YXMw?=
 =?utf-8?B?WWJPNytYY3pVZGZZNm43UWhKME1sYS83cWNDQ3dUMzRKdjh2cytBeVJUU01D?=
 =?utf-8?Q?5i1zb1WBg0OEw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abbb11ef-d237-4eeb-e17e-08d8975a7b7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 07:10:14.6643
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lKNhwdwjtHN2ounp1/TOWHgL/PNySAK9APO+odAncCFx6JJKXpYgEJEX88biezqYfFw7aVkFHGLcf+E0gr1yvhFiCINsQCL73a2iPouK9GBDdFazJuuhoMtUvSPCJGEj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1867
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTGludXMsDQoNClRoYW5rcyBmb3IgeW91ciBpbnB1dC4gSSByZXBsaWVkIGlubGluZS4NCg0K
Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGludXMgV2FsbGVpaiA8bGludXMu
d2FsbGVpakBsaW5hcm8ub3JnPg0KPlNlbnQ6IFRodXJzZGF5LCBEZWNlbWJlciAzLCAyMDIwIDI6
NTUgQU0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1c2Fpbmku
enVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJv
Lm9yZz47IEh1bnRlciwgQWRyaWFuDQo+PGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgTWljaGFs
IFNpbWVrIDxtaWNoYWwuc2ltZWtAeGlsaW54LmNvbT47IGxpbnV4LQ0KPm1tYyA8bGludXgtbW1j
QHZnZXIua2VybmVsLm9yZz47IExpbnV4IEFSTSA8bGludXgtYXJtLQ0KPmtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2hldmNoZW5rbywN
Cj5BbmRyaXkgPGFuZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT47IFJhamEgU3VicmFtYW5pYW4s
IExha3NobWkgQmFpDQo+PGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsg
V2FuIE1vaGFtYWQsIFdhbiBBaG1hZA0KPlphaW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9o
YW1hZEBpbnRlbC5jb20+OyBNYXJrIEdyb3NzDQo+PG1ncm9zc0BsaW51eC5pbnRlbC5jb20+DQo+
U3ViamVjdDogUmU6IFtQQVRDSCB2NiA0LzRdIG1tYzogc2RoY2ktb2YtYXJhc2FuOiBFbmFibGUg
VUhTLTEgc3VwcG9ydCBmb3INCj5LZWVtIEJheSBTT0MNCj4NCj5IaSBNdWhhbW1hZCwNCj4NCj50
aGFua3MgZm9yIHlvdXIgcGF0Y2ghDQo+DQo+T24gV2VkLCBEZWMgMiwgMjAyMCBhdCA4OjA0IEFN
IDxtdWhhbW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj53cm90ZToNCj4NCj4+IEtl
ZW0gQmF5IFNPQyBjYW4gc3VwcG9ydCBkdWFsIHZvbHRhZ2Ugb3BlcmF0aW9ucyBmb3IgR1BJTyBT
RCBQaW5zIHRvDQo+PiBlaXRoZXIgMS44ViBvciAzLjNWIGZvciBidXMgSU8gbGluZSBwb3dlci4g
SW4gb3JkZXIgdG8gb3BlcmF0ZSB0aGUNCj4+IEdQSU9zIGxpbmUgZm9yIENsayxDbWQgYW5kIERh
dGEgb24gS2VlbSBCYXkgSGFyZHdhcmUsIGl0IGlzIGltcG9ydGFudA0KPj4gdG8gY29uZmlndXJl
IHRoZSBzdXBwbGllZCB2b2x0YWdlIGFwcGxpZWQgdG8gdGhlaXIgSS9PIFJhaWwgYW5kIHRoZQ0K
Pj4gb3V0cHV0IG9mIHRoZSBpMmMgZXhwYW5kZXIgcGluLiBGaW5hbCBWb2x0YWdlIGFwcGxpZWQg
b24gdGhlIEdQSU9zDQo+PiBMaW5lIGFyZSBkZXBlbmRlbnQgYnkgYm90aCBzdXBwbGllZCB2b2x0
YWdlIHJhaWwgYW5kIGV4cGFuZGVyIHBpbg0KPj4gb3V0cHV0IGFzIGl0IGlzIGJlZW4gc2V0IGFm
dGVyIHBhc3NpbmcgdGhyb3VnaCB0aGUgdm9sdGFnZSBzZW5zZSByZXNpc3Rvci4NCj4NCj5JIHRo
aW5rIEkgdW5kZXJzdGFuZCB0aGlzIHBhcnQuDQo+DQo+PiBUaGUgS2VlbSBCYXkgSFcgaXMgc29t
ZXdoYXQgdW5pcXVlIGluIHRoZSB3YXkgb2YgaG93IElPIGJ1cyBsaW5lDQo+PiB2b2x0YWdlIGFy
ZSBiZWVuIGNvbnRyb2xsZWQuIE91dHB1dCBvZiB0aGUgRXhwYW5kZXIgcGlucyBpcyBiZWVuDQo+
PiBjb25maWd1cmVkIHVzaW5nIHJlZ3VsYXRvci4NCj4NCj5UaGF0IG11Y2ggaXMgY2xlYXIuDQo+
DQo+PiBWb2x0YWdlIHJhaWwgb3V0cHV0IGlzIGJlaW5nIGNvbmZpZ3VyZWQgdXNpbmcNCj4+IGtl
ZW1iYXlfaW9fcmFpbF9zdXBwbGllZF92b2x0YWdlKCkgQVBJIGluIHRoZSBzZGhjaSBkcml2ZXIg
ZGlyZWN0bHkuDQo+DQo+QW5kIHRoYXQgaXMgYW4gU01DIGNhbGwgbGlrZSB0aGF0Og0KPg0KPitz
dGF0aWMgaW5saW5lIGludCBrZWVtYmF5X2lvX3JhaWxfc3VwcGxpZWRfdm9sdGFnZShpbnQgdm9s
dCkgew0KPisgICAgICAgc3RydWN0IGFybV9zbWNjY19yZXMgcmVzOw0KPisNCj4rDQo+YXJtX3Nt
Y2NjXzFfMV9pbnZva2UoQVJNX1NNQ0NDX1NJUF9LRUVNQkFZX1NFVF9TRF9WT0xUQUdFLA0KPnZv
bHQsICZyZXMpOw0KPisgICAgICAgaWYgKChpbnQpcmVzLmEwIDwgMCkNCj4rICAgICAgICAgICAg
ICAgcmV0dXJuIC1FSU5WQUw7DQo+Kw0KPisgICAgICAgcmV0dXJuIDA7DQo+DQo+VGhhdCBjYW4g
c2V0IHRoZSB2b2x0YWdlIGJ5IGNhbGxpbmcgaW50byB0aGUgQXJtIHNlY3VyZSB3b3JsZCBJIGd1
ZXNzPw0KDQpZZXMgY2FsbGluZyB0aGUgQXJtIFNNQ0MgLiANClRoZSBzZWxlY3Rpb24gb2YgdGhl
IHN1cHBseSB2b2x0YWdlIGFwcGxpZWQgdG8gdGhlIHJhaWwgZGVwZW5kcyBvbiB0aGUgQU9OX0NG
RzFbOV0gLg0KU2V0dGluZyBCaXQ5ICB3aWxsIGNoYW5nZSB0aGUgdm9sdGFnZSByYWlsIHN1cHBs
eS4NClNldCBCaXQgOSA9IDEgLy8gT3BlcmF0aW9uIHZvbHRhZ2UgaXMgMS44ViANClNldCBCaXQg
OSA9IDAgLy8gT3BlcmF0aW9uIHZvbHRhZ2UgaXMgMy4zVg0KDQo+DQo+PiBQaW4gY29udHJvbCBi
YXNlZCBpbXBsZW1lbnRhdGlvbiBiZWNvbWVzIHByb2JsZW1hdGljIHRvIGNvbnRyb2wgdGhlDQo+
PiB2b2x0YWdlIHJhaWwgZHVlIHRvIHRoZSBiYXNlIGFkZHJlc3Mgb2YgQWx3YXlzIE9uIFJlZ2lz
dGVyIGlzDQo+PiBkaWZmZXJlbnQgZnJvbVRoZSBkcml2ZXIgZG9lcyBub3QgaGF2ZSB0byBiZSBp
biB0aGUgdGhlIGJhc2UgYWRkcmVzcw0KPj4gb2YgR1BJTyhQaW5jdHJsKS4gVGh1cywgdGhlcmUg
aXMgbm8gd2F5IHRvIGNvbnRyb2wgdGhlIEkvTyBSYWlsIHVzaW5nIEdQSU8NCj5QYWQgY29uZmln
dXJhdGlvbi4NCj4NCj5JIGRvbid0IHNlZSB3aHkgdGhpcyB3b3VsZCBiZSBwaW4gY29udHJvbCBy
ZWxhdGVkLCBhbmQgdGhhdCBpcyBhcyB5b3UgcG9pbnQgb3V0DQo+bGVhZGluZyB0byBzb21lIGNv
bmZ1c2VkIGRpc2N1c3Npb25zIGhlcmUuDQoNClRoaXMgaXMgbm90IHJlbGF0ZWQgdG8gYSBwaW4g
Y29udHJvbC4gSSBwb2ludGVkIG91dCB0aGlzIGluIHRoZSBjb21taXQgZGVzY3JpcHRpb24gdG8g
DQppbmRpY2F0ZSB0aGF0IGZvciBLZWVtIEJheSBIVyB0byBtb2RlbGxpbmcgYXMgcGluY3RybCB0
byBjYWxsIHRoZSBTTUNDIEFybSBpcyBub3QgDQphIGdvb2QgYXBwcm9hY2guDQoNCj4NCj5XZSBk
byBoYXZlIHNvbWV0aGluZyBsaWtlIHRoaXMgZ2VuZXJpYyBwaW4gY29uZmlnOg0KPg0KPiAqIEBQ
SU5fQ09ORklHX1BPV0VSX1NPVVJDRTogaWYgdGhlIHBpbiBjYW4gc2VsZWN0IGJldHdlZW4gZGlm
ZmVyZW50DQo+cG93ZXINCj4gKiAgICAgIHN1cHBsaWVzLCB0aGUgYXJndW1lbnQgdG8gdGhpcyBw
YXJhbWV0ZXIgKG9uIGEgY3VzdG9tIGZvcm1hdCkgdGVsbHMNCj4gKiAgICAgIHRoZSBkcml2ZXIg
d2hpY2ggYWx0ZXJuYXRpdmUgcG93ZXIgc291cmNlIHRvIHVzZS4NCj4NCj5CdXQgaXQncyAuLi4g
eWVhaC4gSXQgdXN1YWxseSBoYXMgYSB2ZXJ5IHNwZWNpZmljIHB1cnBvc2Ugb2Ygc2VsZWN0aW5n
IG9uZSBvZiB0d28NCj5hdmFpbGFibGUgdm9sdGFnZSByYWlscyBpbnNpZGUgdGhlIFNvQy4gQW5k
IGl0IG5lZWRzIHRvIGFwcGx5IHRvIG9uZSBwaW4gb3IgcGluDQo+Z3JvdXAuIEFsc28gaXQga2lu
ZCBvZiBpbXBsaWVzIHRoYXQgdGhvc2Ugdm9sdGFnZXMgYXJlIGFsd2F5cyBvbi4NCj4NCg0KRm9y
IEtlZW1iYXkgSFcsIHdlIGNvdWxkIG5vdCBhcHBseSBvbiBhbnkgcGlucyBiZWNhdXNlIHdlIGRv
IG5vdCBoYXZlIGEgDQpkaXJlY3QgYWNjZXNzIHRvIGNvbnRyb2wgdGhpcyBwYWQuIFRoYXQgaXMg
d2h5LCBjdXJyZW50bHkgSSBjb25maWd1cmUgdGhpcyB2b2x0YWdlIHJhaWwgDQpzdXBwbHkgdGhy
b3VnaCB0aGUgU01DQ3MgQXJtIHdyYXBwZXIuIA0KDQpVbmxlc3MgaWYgd2UgZmFrZSBzb21lIHBp
biBleGFtcGxlIEdQSU8zMi0zNyBmb3IgU0QsIHdoaWNoIHVzaW5nICIqcGluY29uZl9zZXQiIHBv
aW50ZWQNCnRvIGNvbmZpZyBwYXJhbSBvZiBQSU5fQ09ORklHX1BPV0VSX1NPVVJDRSwgdGhlbiBj
YWxsIHRoZSBrZWVtYmF5X2lvX3JhaWxfc3VwcGxpZWRfdm9sdGFnZSgpDQp0byBjaGFuZ2UgdGhl
IElPIHJhaWwgdm9sdGFnZSBmZWVkaW5nLg0KQnkgbWVhbnMgY2FsbGluZyBrZWVtYmF5X2lvX3Jh
aWxfc3VwcGxpZWRfdm9sdGFnZSgpLCB3ZSBjYWxsIEFSTSBTTUNDIGluIHRoaXMgY2FzZSBjb25k
aXRpb24gPw0KSSB3YXMgcmVmZXJyaW5nIHRvIHRoaXMgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5j
b20vbGludXgvdjUuMTAtcmM2L3NvdXJjZS9kcml2ZXJzL3BpbmN0cmwvcmVuZXNhcy9waW5jdHJs
LmMjTDcwNiANCg0KPkFzIHlvdSBzYXk6DQo+DQo+PiBGcm9tIHRoZSBEYXRhYm9vayBpdHNlbGYg
d2l0aCBhZGRpdGlvbmFsIGNvbmZpcm1hdGlvbiBmcm9tIEtlZW0gQmF5IEhXDQo+PiBTT0MgRGVz
aWduIEFyY2hpdGVjdCwgdGhlcmUgaXMgbm8gZGlyZWN0IGNvbnRyb2wgb2YgdGhlc2UgQU9OIHJl
Z2lzdGVyDQo+PiBiaXRzIGZyb20gR1BJTyBwYWRzLg0KPg0KPlRoZSBrZWVtYmF5X2lvX3JhaWxf
c3VwcGxpZWRfdm9sdGFnZSgpIG1vcmUgcmVzZW1ibGVzIGEgc2VsZWN0b3IgKGNob29zZQ0KPm9u
ZSBvbiBhIG1lbnUpIHZvbHRhZ2UgcmVndWxhdG9yIHRvIG1lIGlmIGFueXRoaW5nLg0KDQpLZWVt
IEJheSBIVyBTb0MgZG9lcyBub3QgaGF2ZSBpdHMgb3duIHZvbHRhZ2UgcmVndWxhdG9yIGZvciBz
ZCBjYXJkLg0KRmluYWwgSU8gbGluZSB2b2x0YWdlIGRlcGVuZHMgb24gc3VwcGxpZWQgdm9sdGFn
ZSBhcHBsaWVkIHRvIHRoZWlyIEkvTyANClJhaWwgYW5kIHRoZSBvdXRwdXQgb2YgdGhlIGkyYyBl
eHBhbmRlciBwaW4gd2hpY2ggZ28gaW50byBwb3dlciBtdXguDQoNCj4NCj4+IE9uIHRoZSBvdGhl
ciBoYW5kLCB1c2luZyBBUk0gU01DIChTZWN1cmUgTW9uaXRvciBDYWxsKSBkaXJlY3RseSBmcm9t
DQo+PiBwaW4gY29udHJvbCBkcml2ZXIgZm9yIHRoZSBzYWtlIG9mIGltcGxlbWVudCBpdCBhcyBw
aW4gY29udHJvbCBtb2RlbA0KPj4gaXMgbm90IGEgZ29vZCBhcHByb2FjaC4NCj4NCj5ZZWFoIGl0
IGhhcyB0byBiZSBjYWxsZWQgZnJvbSBzb21ld2hlcmUsIGlmIHlvdSB3YW50IGFuIGFic3RyYWN0
aW9uIHRvIG1ha2UNCj50aGUgZHJpdmVyIG5ldXRyYWwgdG8gYW55IG1hY2hpbmUsIHRoZW4gdXNl
IGEgc2VsZWN0b3IgcmVndWxhdG9yLiBJdCBjYW4gYmUNCj5wbGFjZWQgYW55d2hlcmUgaW4gdGhl
IGtlcm5lbCBhcyBsb25nIGFzIHlvdSBjYW4gcmVmZXJlbmNlIGl0Lg0KDQpTb3JyeS4gSSBhbSBu
b3QgcmVhbGx5IGF3YXJlIG9mIHNlbGVjdG9yIHJlZ3VsYXRvci4gQ2FuIHlvdSBwb2ludCBtZSB0
byBhbnkgcmVmZXJlbmNlcw0KZm9yIHRoaXM/IA0KDQo+DQo+VGhlIHJlZ2lzdGVyIGlzIGNhbGxl
ZCAoYWNjb3JkaW5nIHRvIHRoZSBjb2RlKSBBT05fQ0dGMSAocmVhbGx5PyBub3QNCj5BT05fQ0ZH
MT8pIGFuZCB0aGUgIk9OIiBwYXJ0IGluICJBT04iICBtYWtlcyBpdCBzb3VuZCBsaWtlICJhbmFs
b2cgT04iDQo+aW1wbHlpbmcgdGhpcyBpcyBzb21ldGhpbmcgdGhhdCBjYW4gYmUgdHVybmVkIG9u
L29mZiBhbmQgY29uZmlndXJlZCBpbnRvIHR3bw0KPnZvbHRhZ2VzIGFuZCBpdCBoYXMgYmVlbiB3
cmFwcGVkIGluIHRoZXNlIGN1c3RvbSBTTUNDcyBieSBhIHNlY3VyZSB3b3JsZA0KPmRldmVsb3Bl
cg0KPihyaWdodD8pDQoNCkl0IGlzIEFsd2F5cyBPbiBQb3dlciBEb21haW4gUmVnaXN0ZXIuIFll
cyBpdCdzIGJlZW4gd3JhcHBlZCB3aXRoIFNNQ0NDIGNhbGwgDQpkdWUgdG8gc2VjdXJlIHJlZ2lz
dGVyLiBCeSBkZWZhdWx0IHZvbHRhZ2UgcmFpbCBmZWVkIGlzIDMuM3YuDQoNCj4NCj5JZiBpdCBz
aG91bGQgdXNlIGFueSBhYnN0cmFjdGlvbiBpdCBzaG91bGQgYmUgYSBzZWxlY3RvciByZWd1bGF0
b3IgSU1PIGFuZA0KPndoaWxlIHRoYXQgbWF5IHNlZW0gb3ZlcmVuZ2luZWVyZWQgaXQgYWRkcyBz
b21ldGhpbmcgYmVjYXVzZSByZWd1bGF0b3JzDQo+YXJlIHVzZWQgaW4gIHRoZSBNTUMgc3Vic3lz
dGVtIGZvciB2ZGQgYW5kIHZxbW1jIGJlY2F1c2Ugd2UgYXJlIGhhbmRsaW5nDQo+dGhlIE9DUiBt
YXNrIHdpdGggdGhhdCBhbmQgaXQgY2FuIHN1cHBvcnQgYW55IGFtb3VudCBvZiBwcmVzZW50IGFu
ZCBmdXR1cmUNCj52b2x0YWdlcyBmb3Igc2lnbmFsIGxldmVscyB3aXRoIHRoYXQgYXMgd2VsbC4g
QW55IGZ1dHVyZSBjaGFuZ2VzIHRvIGhvdyB0aGUNCj5kaWZmZXJlbnQgc2lnbmFsIHZvbHRhZ2Vz
IGFyZSBzZXQgb3Igd2hpY2ggdm9sdGFnZXMgZXhpc3QgY2FuIHRoZW4gYmUgZG9uZSBpbg0KPnRo
YXQgcmVndWxhdG9yIGRyaXZlci4NCg0KVGhpcyBpcyBsaW1pdGF0aW9uIG9mIEtlZW0gQmF5IEhX
IGFuZCBJIHdvdWxkIHNheSBLZWVtIEJheSBIVyBpcyBzb21ld2hhdCANCnVuaXF1ZSBpbiB0aGUg
d2F5IG9mIGhhbmRsaW5nIHRoZSBJTyBidXMgbGluZSB2b2x0YWdlLg0KU0RjYXJkIGRvZXMgbm90
IGhhdmUgaXRzIG93biB2b2x0YWdlIHJlZ3VsYXRvci4NCkkgY3JlYXRlZCBvbmUgZnVuY3Rpb24g
c2RoY2lfYXJhc2FuX2tlZW1iYXlfaW9fbGluZV9zdXBwbHlfb3BlcmF0aW9uKCkgaW4gc2RoY2kt
b2YtYXJhc2FuLmMgIA0KdG8gaGFuZGxlIHRoZSB2cW1tYyhpbyBsaW5lIHN1cHBseSBvcGVyYXRp
b24pIHNwZWNpZmljIGZvciBLZWVtIEJheSBTb0MuDQoNCkZvciBLZWVtIEJheSwgdG8gYWN0dWFs
bHkgbW9kZWxsaW5nIHRoaXMgYXMgcmVndWxhdG9yICxmb3IgdnFtbWMsICwgd2UgbmVlZCB0byBo
YW5kbGUgMiB0aGluZ3M6DQoxKSBPdXRwdXQgZXhwYW5kZXIgcGlucyA6IHVzaW5nIGdwaW8gcmVn
dWxhdG9yDQoyKSB2b2x0YWdlIHJhaWwgOiBjYWxsIGtlZW1iYXlfaW9fcmFpbF9zdXBwbGllZF92
b2x0YWdlKCkgdG8gaGFuZGxlIHRoZSBTTUNDIEFybS4NCg0KT3RoZXIgaGFyZHdhcmUgbWlnaHQg
bm90IG5lZWQgdGhpcyBhcyB0aGV5IG1pZ2h0IGVhc2lseSBjb25maWd1cmUgdGhlIHZxbW1jIA0K
aG9va2VkIHVwIHRvIHJlZ3VsYXRvci4NCiANCklNSE8sIHdlIGRvIG5vdCBuZWVkIHRvIG92ZXJl
bmdpbmVlcmVkIGl0IHRvIGFkZCBjdXN0b20gc2VsZWN0b3IgDQpyZWd1bGF0b3IganVzdCB0byBz
dWl0IHRoaXMgS2VlbSBCYXkgSFcgZGVzaWduLg0KDQo+DQo+SnVzdCBteSDigqwwLjAxLi4uDQo+
DQo+WW91cnMsDQo+TGludXMgV2FsbGVpag0K
