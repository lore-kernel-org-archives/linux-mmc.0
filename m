Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE26AC2D0E4
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 01:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551862222A
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 01:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yjwFTv3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbgKRBFA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 20:05:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:7252 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727214AbgKRBFA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 20:05:00 -0500
IronPort-SDR: lCjVqjkbcUy+VUABH/g7AbfjxdIJQXjmoZQo+LnGKuM5luAMdroHipBIzCP3Qf275Y8I4r8w4h
 h9N/VxfwUnRg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150313601"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150313601"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 17:04:58 -0800
IronPort-SDR: Ow6wib94yB60t/jBt5NFI60RRf1cfTExwD1/DIT+R+tb1rl176iDNbYr/eBFP6pgePNQfOUFLG
 qvnHiLD4zNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="368284817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 17 Nov 2020 17:04:58 -0800
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 17:04:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 17:04:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 17:04:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pp12etKToqAkHiimG9h4QMDjy7SfbpSyiKAmoHYDg+hhpS5ycyB93ufdB+bC7Vtt3IiNZ2YbHRO/7np1r0o5MyOJfXDmlgJV4daq7zj/Ybih0wSuKVnOew+pUHv9YxzyIgctmWqQo25vUWT2hYlP1kudsSxenYIZ7UHUc+F6wKhQA65CkbttTjtWmUR/HgWHtZ5H81HUXqgTbPYzLVo1Se439pkgdatHO3byzmxS9YdGNynVscm7NAiALEcAdM29RtmgkCb4OPP8yV2qs4ZHh5cdGg2Iv2ZvbPw1dpdtPht97BkvhJpnzaFyOFX39MNg94pC7/+GPE6k1FGYtmfS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng1kYJ9iCg3JOKrhW6p35QwMevsA7DDcTf7aMjBPnT8=;
 b=NfXh+QgEHQmtOXm6rMUAqxURSyG+0EBvPdWQmAxWiO6L03sNAUnQBB8eY2hIm9N3B6qYqlP13KJ00zJWGsUQnGnZnauyokqiqIp8Guu5MZfq9Ago8BzwLlAhLQf2PEMQdPtLmzmXXuFhydvciEGTjqRwmj0nFwzRqfPvc/nG18Qtl9S4klDasgUL7BhOGOq6xZGqr1kExMscbCc0kFi0ti9PyW+lZlRzFvEE+JFTMr14KjgVY18afaIWoEcVxBPjKc5LeLJhue48JMiR/wdpENQxAaBaVS8qyHCCXByry7B4/lS2v+VY2nEz49zY3RWuifu1jD0oyKd71vFyf/ipUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ng1kYJ9iCg3JOKrhW6p35QwMevsA7DDcTf7aMjBPnT8=;
 b=yjwFTv3IxyON9zOpNIBFgXPsfDDwwYMWbE0D7lgvV1pXhIAnnp7JNUcdx7/Xqhh3pbnNzg/3TbZmGgn134C02+M0aEzTjihlTNBXzoX+PDHnX6RiIS5OTekCuKb7fYbJYIpPPPO9xhULa5e0bQvijfu0SiGQMkz9ZhMSBvsYEkE=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3564.25; Wed, 18 Nov 2020 01:04:52 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3564.028; Wed, 18 Nov 2020
 01:04:52 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "David E. Box" <david.e.box@linux.intel.com>
Subject: RE: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Topic: [PATCH v1 1/1] mmc: sdhci-of-arasan: Specify .clk_ops for Keem
 Bay SOC
Thread-Index: AQHWs/Kyv+f0bf2SO0CVLGdSxsJGq6nKstkAgAApWoCAAWUIAIAAJgbggAA7EICAAH+aoA==
Date:   Wed, 18 Nov 2020 01:04:52 +0000
Message-ID: <DM6PR11MB2876E25D0685E32FC18BB5FBB8E10@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
 <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com>
 <DM6PR11MB2876A043535B8EDE5286FBB0B8E20@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFp1nR_Qx5p+ou1cZns9MvLVWD5bTuFCkMpu_EbHxh1Opw@mail.gmail.com>
In-Reply-To: <CAPDyKFp1nR_Qx5p+ou1cZns9MvLVWD5bTuFCkMpu_EbHxh1Opw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.188.113]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2bb5eb-064f-4798-025c-08d88b5df48b
x-ms-traffictypediagnostic: DM6PR11MB4610:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4610394F795CA6D7D116C5D2B8E10@DM6PR11MB4610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vc+ysYuWTCfeI3yYd/EfwdpaZ8vY4d6EYCdgvShZwVJ1mxXYNHN6+oaAFB8ifGdqK8nW1n4hMvSFuXPbhyO9TDHQNK3gZPHOsr0QSauPY+BXBN1Z3ZRRvCGSmqU5AFGpj0ssywNJLi0xlLovL+797pjhJ/rqLQntcEuqiI3ezkFwdGBDE9CuL0vomiM5iDn30+PRYHRvLrlNuRO57XdO/72W4r9cgITZksEEx9WPDavYCAfURN8w3pDXOlI7NjIlZrpsq9ywuzwvx0dAkdJk7oJXexKUmovXpww2+SvKLTPrKrU5j5Ao0VKsN7vABnGucUDNOxmfmTV4601uwFjhxDFroloLM4gPT0vv3HM/D4JGOy8PzSTJOqGnYS3MPuZF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(4326008)(71200400001)(2906002)(66556008)(6916009)(64756008)(66446008)(66946007)(54906003)(52536014)(8936002)(6506007)(66476007)(5660300002)(76116006)(86362001)(7696005)(8676002)(26005)(83380400001)(9686003)(55016002)(186003)(498600001)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7Umj8nT0yj0YUiGhZMKm35Ut8Lv/TuMH3NhOPqvsJCM8Qd+4RUGIgdm/nlITuJi9/0ZAh43AmSNHss7qGf1eXPrwKhKrskWg86GYRHp2kadSM+IEQVARoe7A2bW1asXork1yhAObPlzlrKx/gAGjCvKczIakVfwO5zzGi80wr6UEJM1Ofa+0bBUSeUl8q9FuIZMt5eVYVDf8TkNF9JENrYD6XggUp1gXe1QGYu9YshoFgThbT+eco8qCz3j2BfL5bz6pvBlAvu/kBXXQaE6NfUhQjJrtRPG6zX/VIQxGshUrNRFcrErb0ud8gsda4Cg20nqvg4O891YsWq3w+pm1akb6jRdJK1wCoRwsHUrzm25Mdh7Ji7ZFJYtjTzVUf8Ra9rwmcPsmnrs1o0CPZaLLMC2Ac1kLdoMMJJ3CFFBlzxGZ6Pk82QJkgsMpK0o+U25kYXLIxbYAJwYPJRVSVZuIdbaYyDaPLuk+Up4G56kCZ1vi3Wm6LWEJP8+Z0ncOvkvcAc6gLWPF4s0IbFi5DTQ4QCZz/z9IB946FCh1PNw6RAFoVNG1r4pRdaZK74J/hQKa5ILeMS2B6RxRoA6iMMs4DjBnlXzwB/v15m2LplrmsNHEgpSrFfvqll+/RI/r3VTylo0eZSbQFOExq6aNVdYh6c0Un94W4onh9EO90hNKu30K/ZtWPITq+qD8UV7u/3R1y2hiw6Y7elb8salHedEvc6DnvfGdaz3PfxcS/sHaHe3m7T7xQgL0REcZilqvEjIbFM+uFG65i5iTh8V25GXiuWOk4iUKN/ft5W1lip+Wje6rK4mugIJDfDironxZDav+3sGRXh0XWTaoNZ2GfRpjEugW77LdaCvyFBiEGAcodAtxMs4ZE0ArK/Fd+xBMUrh3U5BMfKK0ljI8hKa8HCTDNA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2bb5eb-064f-4798-025c-08d88b5df48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2020 01:04:52.3245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jRtNgAxDGOMBs+0i1MZiSW3IiU9j7JcfpmdhKrFHhnwjL3UHCalLTHRYuHvo3xfxw8QWw+zhzGpw4KdJ9Okkb5DE35AL0xrEpL+D0t3F/fbBL/MA/UJ4QMhgBmQ4AWN6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDE4
LCAyMDIwIDE6MTQgQU0NCj5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFk
Lmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPkNjOiBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj5rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47
IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBSYWphDQo+U3Vi
cmFtYW5pYW4sIExha3NobWkgQmFpIDxsYWtzaG1pLmJhaS5yYWphLnN1YnJhbWFuaWFuQGludGVs
LmNvbT47IFdhbg0KPk1vaGFtYWQsIFdhbiBBaG1hZCBaYWluaWUNCj48d2FuLmFobWFkLnphaW5p
ZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBEYXZpZCBFLiBCb3gNCj48ZGF2aWQuZS5ib3hAbGlu
dXguaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS8xXSBtbWM6IHNkaGNpLW9m
LWFyYXNhbjogU3BlY2lmeSAuY2xrX29wcyBmb3IgS2VlbSBCYXkNCj5TT0MNCj4NCj5PbiBUdWUs
IDE3IE5vdiAyMDIwIGF0IDE0OjQ2LCBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaQ0KPjxtdWhh
bW1hZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGkgVWxmLA0K
Pj4NCj4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4gPkZyb206IFVsZiBIYW5zc29u
IDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPj4gPlNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE3
LCAyMDIwIDc6MjcgUE0NCj4+ID5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFt
bWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4gPkNjOiBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBMaW51eCBBUk0gPGxpbnV4LWFybS0NCj4+ID5rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LQ0KPj4gPmtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+OyBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
Ow0KPj4gPlJhamEgU3VicmFtYW5pYW4sIExha3NobWkgQmFpDQo+PiA+PGxha3NobWkuYmFpLnJh
amEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsgV2FuIE1vaGFtYWQsIFdhbiBBaG1hZA0KPj4gPlph
aW5pZSA8d2FuLmFobWFkLnphaW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+OyBEYXZpZCBFLiBC
b3gNCj4+ID48ZGF2aWQuZS5ib3hAbGludXguaW50ZWwuY29tPg0KPj4gPlN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjEgMS8xXSBtbWM6IHNkaGNpLW9mLWFyYXNhbjogU3BlY2lmeSAuY2xrX29wcw0KPj4g
PmZvciBLZWVtIEJheSBTT0MNCj4+ID4NCj4+ID5PbiBNb24sIDE2IE5vdiAyMDIwIGF0IDE1OjIy
LCBadWxraWZsaSwgTXVoYW1tYWQgSHVzYWluaQ0KPj4gPjxtdWhhbW1hZC5odXNhaW5pLnp1bGtp
ZmxpQGludGVsLmNvbT4gd3JvdGU6DQo+PiA+Pg0KPj4gPj4gSGkgVWxmLA0KPj4gPj4NCj4+ID4+
IFRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29tbWVudHMuIEkgcmVwbGllZCBpbmxpbmUNCj4+ID4+
DQo+PiA+PiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4+ID5Gcm9tOiBVbGYgSGFu
c3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4+ID4+ID5TZW50OiBNb25kYXksIE5vdmVt
YmVyIDE2LCAyMDIwIDc6NDEgUE0NCj4+ID4+ID5UbzogWnVsa2lmbGksIE11aGFtbWFkIEh1c2Fp
bmkNCj4+ID4+ID48bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+PiA+PiA+
Q2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IExpbnV4IEFSTSA8bGludXgtYXJtLQ0KPj4g
Pj4gPmtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlz
dCA8bGludXgtDQo+PiA+PiA+a2VybmVsQHZnZXIua2VybmVsLm9yZz47IEh1bnRlciwgQWRyaWFu
IDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47DQo+PiA+PiA+UmFqYSBTdWJyYW1hbmlhbiwgTGFr
c2htaSBCYWkNCj4+ID4+ID48bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+
OyBXYW4gTW9oYW1hZCwgV2FuDQo+QWhtYWQNCj4+ID4+ID5aYWluaWUgPHdhbi5haG1hZC56YWlu
aWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPjsgRGF2aWQgRS4gQm94DQo+PiA+PiA+PGRhdmlkLmUu
Ym94QGxpbnV4LmludGVsLmNvbT4NCj4+ID4+ID5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0g
bW1jOiBzZGhjaS1vZi1hcmFzYW46IFNwZWNpZnkgLmNsa19vcHMNCj4+ID4+ID5mb3IgS2VlbSBC
YXkgU09DDQo+PiA+PiA+DQo+PiA+PiA+T24gRnJpLCA2IE5vdiAyMDIwIGF0IDA1OjEwLCA8bXVo
YW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+d3JvdGU6DQo+PiA+PiA+Pg0KPj4g
Pj4gPj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaQ0KPj4gPj4gPj4gPG11aGFtbWFk
Lmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4gPj4gPj4NCj4+ID4+ID4+IENvbW1pdCAx
NmFkYTczMGE3NTkgKCJtbWM6IHNkaGNpLW9mLWFyYXNhbjogTW9kaWZ5IGNsb2NrDQo+PiA+PiA+
PiBvcGVyYXRpb25zDQo+PiA+PiA+PiBoYW5kbGluZyIpIGludHJvZHVjZXMgcGxhdGZvcm0gc3Bl
Y2lmaWMgU0RIQ0kgY2xvY2sgb3BlcmF0aW9uLg0KPj4gPj4gPj4NCj4+ID4+ID4+IFRoaXMgcGF0
Y2ggZGVjbGFyZXMgdGhlIGNsb2NrIG9wZXJhdGlvbiBmb3IgS2VlbSBCYXkuDQo+PiA+PiA+PiBB
ZGQgY2xrX29wcyBmb3IgU0QsIEVNTUMgYW5kIFNESU8gb3BlcmF0aW9ucy4NCj4+ID4+ID4NCj4+
ID4+ID5UaGUgYWJvdmUgY29tbWl0IG1lc3NhZ2UgZG9lc24ndCByZWFsbHkgdGVsbCB3aHkgb3Ig
d2hhdCBnb2VzIG9uIGhlcmUuDQo+PiA+PiA+Q2FuIHBsZWFzZSB0cnkgdG8gY2xhcmlmeSB0aGF0
Lg0KPj4gPj4NCj4+ID4+IFdlIG1pc3NlZCBvdXQgdGhlIGNsb2NrIG9wZXJhdGlvbiBoYW5kbGlu
ZyBwYXRjaCAoQ29tbWl0DQo+PiA+PiAxNmFkYTczMGE3NTkpIGFuZCBkaWQgbm90IGhhbmRsZSB0
aGUgY2xrX29wcyAgZm9yIEtlZW0gQmF5IFNPQyBkZXZpY2VzLg0KPj4gPj4gVGhlc2UgMiBwYXRj
aGVzIChDb21taXQgMTZhZGE3MzBhNzU5KSBhbmQgKENvbW1pdCAzNmM2YWFkYWFlODYpDQo+PiA+
PiBhcmUNCj4+ID5tZXJnZWQgYXQgYXJvdW5kIHRoZSBzYW1lIHRpbWUuDQo+PiA+PiBXZSBjYXRj
aCB0aGUgaXNzdWUgbGF0ZXIgd2hlbiB0cnlpbmcgdG8gYm9vdCBpbnRvIHY1LjEwLXJjMSB3aXRo
DQo+PiA+PiBLZWVtIEJheQ0KPj4gPkVWTS4NCj4+ID4+IFRoYXQgaXMgd2h5IEkgY3JlYXRlZCB0
aGlzIHBhdGNoIHRvIGhhbmRsZSB0aGUgY2xrX29wcyBmb3IgS2VlbSBCYXkNCj5kZXZpY2VzLg0K
Pj4gPg0KPj4gPkFscmlnaHQsIHNvIHRoZSBwcmV2aW91cyBjaGFuZ2VzIHdlcmUgc2ltcGx5IG5v
dCBzdWZmaWNpZW50IHRvDQo+PiA+Y29tcGxldGUgdGhlIHN1cHBvcnQuDQo+PiA+DQo+PiA+Pg0K
Pj4gPj4gPg0KPj4gPj4gPj4NCj4+ID4+ID4+IEZpeGVzOiAzNmM2YWFkYWFlODYgKCJtbWM6IHNk
aGNpLW9mLWFyYXNhbjogQWRkIHN1cHBvcnQgZm9yDQo+PiA+PiA+PiBJbnRlbCBLZWVtDQo+PiA+
PiA+PiBCYXkiKQ0KPj4gPj4gPg0KPj4gPj4gPklzICRzdWJqZWN0IHBhdGNoIGZpeGluZyBhIGJ1
Zy9yZWdyZXNzaW9uPw0KPj4gPj4NCj4+ID4+IFRoaXMgaXMgdG8gZml4IGlzc3VlIG9uIHByZXZp
b3VzIGNvbW1pdC4gSXQgaXMgYSBidWcgZml4Lg0KPj4gPg0KPj4gPkhhcyBpdCBldmVyIHdvcmtl
ZD8NCj4+DQo+PiBZZXMgaXQgaXMgd29ya2luZy4gVGVzdGVkIHdpdGggS2VlbSBCYXkgRVZNLg0K
Pj4gU0QvRU1NQy9TRElPIGRldmljZXMgcmVnaXN0ZXJlZCBzdWNjZXNzZnVsbHkgd2l0aCB0aGlz
IGZpeC4NCj4NCj5JIGFtIG5vdCBhc2tpbmcgaWYgJHN1YmplY3QgcGF0Y2ggbWFrZXMgaXQgd29y
aywgSSB1bmRlcnN0YW5kIHRoYXQgaXQgZG9lcy4NCj4NCj4+DQo+PiA+DQo+PiA+RGlkIHRoZSBj
b21taXQgeW91IHBvaW50IHRvIHdpdGggdGhlIGZpeGVzIHRhZywgYnJlYWsgc29tZSBvdGhlcg0K
Pj4gPmV4aXN0aW5nIGZ1bmN0aW9uYWxpdHk/DQo+Pg0KPj4gSXQgc2hvdWxkIG5vdCBicmVhayBv
dGhlciBleGlzdGluZyBmdW5jdGlvbmFsaXR5Lg0KPj4gVGhpcyBpcyBzcGVjaWZpYyBmb3IgS2Vl
bSBCYXkgU09DIG9ubHkuDQo+DQo+U28sIHlvdSBhcmUgc2F5aW5nIHRoYXQgaXQgaGFzIG5ldmVy
IHdvcmtlZCBmb3IgS2VlbSBCYXk/IEJ1dCAkc3ViamVjdCBwYXRjaA0KPm1ha2VzIGl0IHdvcms/
DQoNCkl0IGlzIHdvcmtpbmcgZm9yIEtlZW0gQmF5IGJlZm9yZSB1bnRpbCB0aGUgQ29tbWl0IDE2
YWRhNzMwYTc1OSAoIm1tYzogc2RoY2ktb2YtYXJhc2FuOiBNb2RpZnkgY2xvY2sgb3BlcmF0aW9u
cyBoYW5kbGluZyIpIA0KY2FtZSBpbnRvIHRoZSBwaWN0dXJlLiBCb3RoIENvbW1pdCAxNmFkYTcz
MGE3NTkgKCJtbWM6IHNkaGNpLW9mLWFyYXNhbjogTW9kaWZ5IGNsb2NrIG9wZXJhdGlvbnMgaGFu
ZGxpbmciKSBhbmQgDQpDb21taXQgMzZjNmFhZGFhZTg2ICgibW1jOiBzZGhjaS1vZi1hcmFzYW46
IEFkZCBzdXBwb3J0IGZvciBJbnRlbCBLZWVtIikgYXJlIG1lcmdlZCBhYm91dCB0aGUgc2FtZSB0
aW1lLiANCldlIGRpZCBub3QgaGF2ZSAiTW9kaWZ5IGNsb2NrIG9wZXJhdGlvbnMgaGFuZGxpbmci
IHBhdGNoIHdoZW4gcmViYXNpbmcgYW5kIHRlc3RpbmcgZHVyaW5nIHVwc3RyZWFtaW5nIHByb2Nl
c3MuDQoNCkkgbm90aWNlZCBvZiB0aGlzIGlzc3VlIHdoZW4gdXNpbmcgbGF0ZXN0IG1haW5saW5l
IHY1LjEwLXJjeCByZWNlbnRseS4NCg0KPg0KPkNhbiB5b3UgcGxlYXNlIHJlLXNwaW4gYW5kIHVw
ZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gYmV0dGVyIHJlZmxlY3Qgd2hhdA0KPmdvZXMgb24s
IHRoZW4gSSBjYW4gYXBwbHkuDQoNCk5vdGVkLiBJIHdpbGwgdXBkYXRlIHRoZSBjb21taXQgbWVz
c2FnZSBhbmQgcmUtc2VuZCBhZ2Fpbi4NClRoYW5rcw0KDQo+DQo+S2luZCByZWdhcmRzDQo+VWZm
ZQ0K
