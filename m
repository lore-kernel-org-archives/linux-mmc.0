Return-Path: <SRS0=iGfF=DP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C8DC43467
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A1C21734
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Oct 2020 10:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Dt2o/r5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgJHKjn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Oct 2020 06:39:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:25895 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgJHKjm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 8 Oct 2020 06:39:42 -0400
IronPort-SDR: uONqQCEem6G2pVh3azNspY+LJ5tNV+hzbgnEqi35dOlPuuTMyBQGiq18gtfbqpzFC3iqLg10zS
 3U7cCOI4U63A==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="182741419"
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="182741419"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2020 03:39:41 -0700
IronPort-SDR: R3v1qjzguYKaW8esviNDB6gj+vJFhvU7gYFJ4G1nmp+86mrhabHDWq8aOMEIvYpI0kc3LHw3Az
 Q0rHPGDQUFYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,350,1596524400"; 
   d="scan'208";a="312168414"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga003.jf.intel.com with ESMTP; 08 Oct 2020 03:39:40 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 03:39:40 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 8 Oct 2020 03:39:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 8 Oct 2020 03:39:40 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 8 Oct 2020 03:39:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgyzC5r+zVfrqWZRegBzYtpMoNBn1l1G7cUNdSROyE/yzIsg2/YIXdk+JqFOgtG4VhGpfpp+4PLW29xY4hheK3NVURv5bE7TfJOM3EGALDFZz2qIWgInvzBeG3QGYzorvxJPgeTbt1C6dwag7IZneDxxsCpUbNQbn4eKEcYTtTnjwyMEL78AdY/PExDpWCDUIqCU1ex/ypsq5nVbOPaJpK0yW6B5bFc4bVYuXRU6VW6pPtPhYPHUws9wVdurEW59yWOt+AnRVDGbRKxAlRhBVtVmRyQtZVp072T8ASSgmZGaH0OqC8IgG4HZkaibxYhzkvlbG5Yfv26Y48hy70/GlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv+cXW1R2ylUdaPZIEgCw1rlQKcQ2f44rsOuPIrRt9I=;
 b=hKzNI7SVXh73O0xxt0udw2XpWZ3dsL7lauHRVPSouuJHq5J6l7Yrszr7SaqTRfQO2BJH+Pjlobqhjd4/HfJ4SCnOlB1Gyvwy4lxKJDdBRBCQfuf1NzNvr84kb5/IunJVDhLrzZFRSYDCdm/TbSnjnY53zdlvUEiFC+yOqUrY/UZzkTFvlKSwsMauXrcdzqQssBM6e8IleK/432+/qYE5IUVBk4hoaOZF8rWQMWrhZRHQuz/1X8++nTtmUcOeypAMApTyrvBpJ5Nj/uu1NKoheRxLLru2shR2BQNJmIhj/b9s6qu+AZPxoOqORJOfX+zFEh4f5JKRiwhe0FI3FV3G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lv+cXW1R2ylUdaPZIEgCw1rlQKcQ2f44rsOuPIrRt9I=;
 b=Dt2o/r5ZahvSNcuFwxW9wMHxl2c/lyISTlwZPnOrHY8IgRvyWAaOCqfoQGdjlrpzLWXOzmvBNGh9HUEc+j+Xq7mv0VxYdE+b2sSmtvHmze64ClgB9PPE7SNXW3ikjtVHhiwDIQYKuFMJHzBMCklJC4JAqd/N8KGE8a5otqfw1f4=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB4610.namprd11.prod.outlook.com (2603:10b6:5:2ab::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22; Thu, 8 Oct 2020 10:39:37 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3433.045; Thu, 8 Oct 2020
 10:39:37 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v4 1/4] firmware: keembay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWnRiLN25HboG/ekeLrjyiLBrMxamNZMeAgAAe2PA=
Date:   Thu, 8 Oct 2020 10:39:37 +0000
Message-ID: <DM6PR11MB2876DAA8003FD42C814A16FBB80B0@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201008020936.19894-1-muhammad.husaini.zulkifli@intel.com>
 <20201008020936.19894-2-muhammad.husaini.zulkifli@intel.com>
 <CAHp75VeBTKc9HnqVV-RAoQVa=1dfTH68Mido=18JFaRxVtUZ2A@mail.gmail.com>
In-Reply-To: <CAHp75VeBTKc9HnqVV-RAoQVa=1dfTH68Mido=18JFaRxVtUZ2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [42.189.177.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef3739d5-2c35-46be-546f-08d86b767463
x-ms-traffictypediagnostic: DM6PR11MB4610:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4610FF268D318BF7FC953659B80B0@DM6PR11MB4610.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVkTEb6JvdClZAe4PGp6auJo2Ed54IWJafIkoJXoZqD0K6ERK3UT/kpDnm9GUe8gihcDSdpiq3Q4cEwrhFFFCwhu/brUkkpyp6QZc3lkMePIFeZ/l7RjtwqZeFEkV7NkkAPzRw2PWVb+Npxs2ICfK86lvb9WS2zjnFJwN7+yNbH/h7v25wS+2ZWk72FNY+Dt1FztOrd/nDXEc0Mkn2Qjywzv8apJYQ1t9k7/pSGni3ezkb+PvZDZOVa5X7dXBDgm8zh7IpDdOb498o0/5TzDKHexYxU7NLY8+pZFc0t1ROluX/IZZYKfErFOg3kHGqOVWFhnVtnVqbZ2ZYKxCwlKCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(366004)(6916009)(64756008)(66446008)(71200400001)(6506007)(66476007)(66556008)(26005)(186003)(76116006)(66946007)(55016002)(9686003)(478600001)(7696005)(54906003)(316002)(2906002)(83380400001)(52536014)(86362001)(4326008)(5660300002)(8676002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5HiU4Kb0B2XFOUuXEdA3gdG/fWZErIwQInjkWouty4SfS+CUPy2sgws666O/qXsL//lOe3AAZbrh3bzvu9QrxbBjiUJDKH+g2lTho7LZv32/sEyTbvZkHncMVtMsXeBAwoz0Ub5NnOjAaK8Tw3AvILuj1cSHuzBKh89ZnqlPMmdxSLNqAULiLqTMI//SwewRqbQTmlZV3cKIecLCtDNfV8b5HSW4XjD53EaXiOwwCXWT6ML9Fc/OWdW1CimGMuvJ5U/vPYLkRA6uAc5xwQoVHGaUuWqhR3evDL627jgoPvRZcQTYWLL2yBMv7EYqVMAHaUiw0G57WMj3tzi+IjPv2/PwnYmme/g1TrbArMqnMpV1pXGo0YzERLNYeqnrkhGOsVLkKi7eJJ8YIxHAdQCxjc/d0c2RCWj/gws7fqSlCM88bM9bOszBgeOnnREOMBjWD4n7FowEN3yrWDGdhmNr+vcS4HKKGa7duTk6Ten6c6Sxvp3Z3YQHpIoYwnZika1KJp1y0bhI0rsSK5331NuDHc7KkzSVRQzYEkDGR4dNW0sr8EGwHDiVms0kIMZXRjvAR8n5xb3HDy4rFdE1+MyXimG4SjT+/64QMQIBu3gvk3Nr+FX9PTAwvD+awpqFaIZ7xJe+ZXFQ9q2YXGgFQjhwkA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3739d5-2c35-46be-546f-08d86b767463
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2020 10:39:37.3536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bAZlycyIXkoNSdZT5HQ6nKeiFs4SwfYKOdikc4+CkHIOZxHVk3MprX4QD3uLBYzqYyC5fUvhZJ01MqDkk2TFrMEOzRU4xZX1kGUgk3rwtOKpUBvGQEK186XimdsFuluS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4610
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQoNCj4tLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPkZyb206IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hlbmtvQGdtYWls
LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgT2N0b2JlciA4LCAyMDIwIDQ6NDYgUE0NCj5UbzogWnVs
a2lmbGksIE11aGFtbWFkIEh1c2FpbmkgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwu
Y29tPg0KPkNjOiBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBNaWNo
YWwgU2ltZWsNCj48bWljaGFsLnNpbWVrQHhpbGlueC5jb20+OyBTaGV2Y2hlbmtvLCBBbmRyaXkN
Cj48YW5kcml5LnNoZXZjaGVua29AaW50ZWwuY29tPjsgVWxmIEhhbnNzb24gPHVsZi5oYW5zc29u
QGxpbmFyby5vcmc+OyBsaW51eC0NCj5tbWMgPGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+OyBs
aW51eC1hcm0gTWFpbGluZyBMaXN0IDxsaW51eC1hcm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj5rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgUmFqYSBTdWJyYW1hbmlhbiwgTGFrc2htaSBCYWkNCj48bGFrc2htaS5iYWku
cmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5jb20+OyBXYW4gTW9oYW1hZCwgV2FuIEFobWFkIFphaW5p
ZQ0KPjx3YW4uYWhtYWQuemFpbmllLndhbi5tb2hhbWFkQGludGVsLmNvbT47IEFybmQgQmVyZ21h
bm4NCj48YXJuZEBhcm5kYi5kZT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvNF0gZmlybXdh
cmU6IGtlZW1iYXk6IEFkZCBzdXBwb3J0IGZvciBBcm0gVHJ1c3RlZA0KPkZpcm13YXJlIFNlcnZp
Y2UgY2FsbA0KPg0KPk9uIFRodSwgT2N0IDgsIDIwMjAgYXQgNTo0OCBBTSA8bXVoYW1tYWQuaHVz
YWluaS56dWxraWZsaUBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEZyb206IE11aGFtbWFkIEh1
c2FpbmkgWnVsa2lmbGkgPG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlAaW50ZWwuY29tPg0KPj4N
Cj4+IEFkZCBoZWFkZXIgZmlsZSB0byBoYW5kbGUgQVBJIGZ1bmN0aW9uIGZvciBkZXZpY2UgZHJp
dmVyIHRvDQo+PiBjb21tdW5pY2F0ZSB3aXRoIEFybSBUcnVzdGVkIEZpcm13YXJlLg0KPg0KPkFy
bSAtPiBBUk0gPw0KSSB3aWxsIHJlbmFtZSBiYXNlZCBvbiBTdWRlZXAncyBtZW50aW9uZWQgaW4g
bGF0ZXN0IHRocmVhZA0KPg0KPi4uLg0KPg0KPj4gIC4uLi9saW51eC9maXJtd2FyZS9pbnRlbC9r
ZWVtYmF5X2Zpcm13YXJlLmggICB8IDQ3ICsrKysrKysrKysrKysrKysrKysNCj4NCj5QbGVhc2Us
IGRyb3AgZHVwIG9mICdmaXJtd2FyZScgaW4gdGhlIGZpbGVuYW1lLg0KTm90ZWQuIFdpbGwgY2hh
bmdlIHRvIGtlZW1iYXkuaA0KPg0KPi4uLg0KPg0KPj4gKy8qDQo+PiArICogIEludGVsIEtlZW1i
YXkgU09DIEZpcm13YXJlIEFQSSBMYXllcg0KPj4gKyAqDQo+DQo+PiArICogIENvcHlyaWdodCAo
QykgMjAyMC0yMDIxLCBJbnRlbCBDb3Jwb3JhdGlvbg0KPg0KPkhlbGxvIGZyb20gdGhlIGZ1dHVy
ZT8NCj4NCldpbGwgZWRpdCB0byBDb3B5cmlnaHQgKEMpIDIwMjAsIEludGVsIENvcnBvcmF0aW9u
DQo+PiArICoNCj4+ICsgKiAgTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaSA8TXVoYW1tYWQuSHVz
YWluaS5adWxraWZsaUBpbnRlbC5jb20+DQo+DQo+QXV0aG9yOiAuLi4NCj4NCj4+ICsgKi8NCj4N
Cj4uLi4NCj4NCj4+ICsvKg0KPj4gKyAqIFRoaXMgZmlsZSBkZWZpbmVzIEFQSSBmdW5jdGlvbiB0
aGF0IGNhbiBiZSBjYWxsZWQgYnkgZGV2aWNlIGRyaXZlcg0KPj4gK2luIG9yZGVyIHRvDQo+DQo+
YW4gQVBJDQo+YnkgYSBkZXZpY2UNCk5vdGVkIPCfmIoNCj4NCj4+ICsgKiBjb21tdW5pY2F0ZSB3
aXRoIEFybSBUcnVzdGVkIEZpcm13YXJlLg0KPg0KPkFybSAtPiBBUk0gPw0KSSB3aWxsIHJlbmFt
ZSBiYXNlZCBvbiBTdWRlZXAncyBtZW50aW9uZWQgaW4gbGF0ZXN0IHRocmVhZA0KPg0KPj4gKyAq
Lw0KPg0KPi0tDQo+V2l0aCBCZXN0IFJlZ2FyZHMsDQo+QW5keSBTaGV2Y2hlbmtvDQo=
