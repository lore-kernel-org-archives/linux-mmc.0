Return-Path: <SRS0=YnZp=DJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2A8C47423
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 10:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A8512072E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Oct 2020 10:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="GlBgUfp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387724AbgJBKWz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Oct 2020 06:22:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:11556 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387713AbgJBKWx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Oct 2020 06:22:53 -0400
IronPort-SDR: IxLzrOj5pWiBx3SwSrXRfi5fGwZklYIgf9f28IqfvsHbLJn/SPlTdAYE5pghQVX6iWGZZjWiSu
 cDzjWTg4etNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160289724"
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="160289724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 03:22:49 -0700
IronPort-SDR: 01R//bSwrpT8AWXKJgbupPOu4wjn/yB7QVuKW8OCAyuWqF97bwSyXF9Wcz8ZDmuTCICn4v6JL5
 fQP6/rlU1V0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,327,1596524400"; 
   d="scan'208";a="515862195"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2020 03:22:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 2 Oct 2020 03:22:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 2 Oct 2020 03:22:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 2 Oct 2020 03:22:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsNf0qq3kffi4zb9L0qw5VBEQsBqv202KvecLrsOxdSSUgrPrxeQu3IPmUQPxklReH2ZDy6TpbuiIH7DeosCT4JKdzSIrxZwpt+K2GBxEpSUh1M3a94kLR7OMzXtj105RyQJbtEzKJ0M8Fe75eMHDPFdZ9q99XDkA7rMHmEMlsaNDjy5+M65m6tQSaQ7UEbi+NJ+u/nbNcwCJZgp5SKet/9oHbE2tl0dcATfV+ufbziN57iebUaog3INyceYz2eF13KeFtW/8vQRaOT2wJGi03C77oZ3/iakv1DbUTZY4GR5QzIFdaXczhQ5puEeG4fszWOzWGvc0abjyQ86qISIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmkKP1MtLc5+Bd3kvxJBTbfBZHIl7yuC7/u3qfJrdf8=;
 b=Gd64ozPHwkWPfmOPD6tDPfsdAGvyGTEHhSLWAZeYKZoCPsF2Rq8Aaev0AaAWDmHOKWgcNXCMdl1h0QK3vvB0owyLw3yJm94nWWtCjVwNn5it3199RjJyOOjjjBCWJcvCvMfzLhhxf9Qa1egjeNW7rlkeFE44oaLK5EPPo8CUEO7CXRNLJ5cixIjn1d8GYGFwf+eu2If+4NQSRxGbx4tA6wKYkG7E9xlm04cjsgxtmCuttPB3+mBaW32U4ugT1W210zJmqsLyD6KY84GhVpOI9Cj7Fc7kbyifIS2JaqRhocM/ohMX/GDnLcyy+NJQ6MFuUcbipgiE12dSXQoab+Uhrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmkKP1MtLc5+Bd3kvxJBTbfBZHIl7yuC7/u3qfJrdf8=;
 b=GlBgUfp9EikaIoQX5MpOc4B26XlREDSxZ2tbRloOeEp60VqUafWL7AgAfGDTVNbNCyAfP3TS/3TTjn6ZYDvbzAELfCqKlImp6HU0IyxkybcYfiXGg7Qq4mc78PRwT1jT5NiWBcbo37TQfuJzbDe1S9KPuX7ycegUabou9cWusdo=
Received: from BYAPR11MB3015.namprd11.prod.outlook.com (2603:10b6:a03:86::14)
 by BYAPR11MB3206.namprd11.prod.outlook.com (2603:10b6:a03:78::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Fri, 2 Oct
 2020 10:22:46 +0000
Received: from BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c]) by BYAPR11MB3015.namprd11.prod.outlook.com
 ([fe80::e1af:b9b8:7e60:e77c%4]) with mapi id 15.20.3433.032; Fri, 2 Oct 2020
 10:22:46 +0000
From:   "Zulkifli, Muhammad Husaini" <muhammad.husaini.zulkifli@intel.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "Hunter, Adrian" <adrian.hunter@intel.com>,
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
Subject: RE: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Topic: [PATCH v2 2/3] firmware: Keem Bay: Add support for Arm Trusted
 Firmware Service call
Thread-Index: AQHWl/61fFIKn6YDxkK/M5PRzKZE1amC4PoAgAEZhQCAAB6wAA==
Date:   Fri, 2 Oct 2020 10:22:46 +0000
Message-ID: <BYAPR11MB301522E94B9516558A23F758B8310@BYAPR11MB3015.namprd11.prod.outlook.com>
References: <20201001142149.23445-1-muhammad.husaini.zulkifli@intel.com>
 <20201001142149.23445-3-muhammad.husaini.zulkifli@intel.com>
 <20201001153526.GD906@bogus>
 <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
In-Reply-To: <ce2bcac9-8341-d7c1-0652-309ca4e9413c@xilinx.com>
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
x-ms-office365-filtering-correlation-id: 7fe7ba70-56d3-4a27-4452-08d866bd1b6e
x-ms-traffictypediagnostic: BYAPR11MB3206:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB320652937DCA4B74AB7D1BD1B8310@BYAPR11MB3206.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GmGhdk8w4VYdcPbN0eCqgWmYu++9/2B3aCPDJ8K/+kYpc7yVp/qTRc14or5nH4OKR3O8W2CK9/HaZMA6MeMA/5xwjgUDdHTgOnwDYaRhE1tUrOQZyLDnoBxmzU+p7mh2hMbaY9z3hjHRASI6idB4fbFg/lk4MOr/fQOhfVwFQS08BSPwg4yFEVsBIETnxmLc1gkK2hkCfCsFRPnNqis75cUp1xr9Rdr/b8kFh4GMzTFniZYiaxkLQwHwoII71507y9eBxm2OHFus/3jtRZ2ZfEr3avzJuiscpT6gnNW7DquO7fHXIzWHRDQGEYeJvB24A0Rqa3Ww/cWGztGoD4SG9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3015.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(346002)(376002)(396003)(7696005)(55016002)(9686003)(83380400001)(71200400001)(8936002)(6506007)(86362001)(2906002)(4326008)(107886003)(5660300002)(110136005)(66556008)(52536014)(8676002)(66446008)(26005)(64756008)(66946007)(54906003)(186003)(66476007)(33656002)(76116006)(316002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 0InjAz7K3BDPDErwVvI8qErvyoIo+kfkdeHMpNv85sX01bEiTqL4yOiM/EiBgb5KgjPFCNJ2QKj4hR74u/t/fDXWQ1/PSiDWscTQvVQ1zEH74OiGn2COajhJgD1+jFWCQppxNoxXIY7ss8J4FMTPmSmYj2fbmhKnedSIPWVj8pBtcOyMwSTcoLcYiQuyVVAiGFhKFNJL4NpsRc95zPJFrfOC6YGl8sTk+9731lM+pcZh8Qs2idkH4GEJgCsUlihK6pGC4YcfVL9LDGd32PYmuqf6hB4bvUYVKzkOlKaSJ6K1BoiClpM+cNPWCLevdhjh2/SKcI5KdRARK7bg+0D5VdFf5hoImrYfgaqFKwkXMS3s6fyF9QxuekNGevJrYu4RXyP+jJGCZXs37OSq4gDYQurgcRSqET22uIzKLd+JCsZRJHRPfaXeOtuMq3/vHzYUJzwWVle7i7PAPOvr4j43qa+r0McKS/afhm5vGnqYKvpVBy5SnI02JDETRDqLvwnQuWJPwUPmisZUHyRpQVmWVInc2fCBcPWQIOC+DM4QrkXHMWMG8TkYAtSwq8V/9ryN0lgP9mzugsNppbH5Sl9RSItTqVETFy6EWn++x8/FNvSDg2sQa4RibKSt4fx1R60Sz/Jl3TJnu1y4Y+YUmNBj1w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3015.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe7ba70-56d3-4a27-4452-08d866bd1b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 10:22:46.6909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/E7dT82tGu9d8MblTQEbxTAwdyJCERLTX/3+A3xezfXMwCAXl4/ZsKBcGf5ge2ntO5xpUJ/j4ENABQYX2AV1oBjtJIgXv+Wmo4HYZ6wizLTmBbPVo63oEMlKS4Nz9C9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3206
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgU3VkZWVwLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0B4aWxpbnguY29tPg0KPlNlbnQ6IEZyaWRheSwgT2N0b2JlciAy
LCAyMDIwIDQ6MjMgUE0NCj5UbzogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT47
IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pDQo+PG11aGFtbWFkLmh1c2FpbmkuenVsa2lmbGlA
aW50ZWwuY29tPg0KPkNjOiBIdW50ZXIsIEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+
OyBtaWNoYWwuc2ltZWtAeGlsaW54LmNvbTsNCj51bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBsaW51
eC1tbWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFJhamEgU3VicmFtYW5pYW4sDQo+
TGFrc2htaSBCYWkgPGxha3NobWkuYmFpLnJhamEuc3VicmFtYW5pYW5AaW50ZWwuY29tPjsgYXJu
ZEBhcm5kYi5kZTsgV2FuDQo+TW9oYW1hZCwgV2FuIEFobWFkIFphaW5pZSA8d2FuLmFobWFkLnph
aW5pZS53YW4ubW9oYW1hZEBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNd
IGZpcm13YXJlOiBLZWVtIEJheTogQWRkIHN1cHBvcnQgZm9yIEFybSBUcnVzdGVkDQo+RmlybXdh
cmUgU2VydmljZSBjYWxsDQo+DQo+SGkgU3VkZWVwLA0KPg0KPk9uIDAxLiAxMC4gMjAgMTc6MzUs
IFN1ZGVlcCBIb2xsYSB3cm90ZToNCj4+IE9uIFRodSwgT2N0IDAxLCAyMDIwIGF0IDEwOjIxOjQ4
UE0gKzA4MDAsDQo+bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20gd3JvdGU6DQo+
Pj4gRnJvbTogTXVoYW1tYWQgSHVzYWluaSBadWxraWZsaSA8bXVoYW1tYWQuaHVzYWluaS56dWxr
aWZsaUBpbnRlbC5jb20+DQo+Pj4NCj4+PiBBZGQgZ2VuZXJpYyBmaXJtd2FyZSBkcml2ZXIgZm9y
IEtlZW0gQmF5IFNPQyB0byBzdXBwb3J0IEFybSBUcnVzdGVkDQo+Pj4gRmlybXdhcmUgU2Vydmlj
ZXMgY2FsbC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lm
bGkNCj4+PiA8bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+DQo+Pj4gLS0tDQo+
Pj4gIGRyaXZlcnMvZmlybXdhcmUvS2NvbmZpZyAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
Pj4gIGRyaXZlcnMvZmlybXdhcmUvTWFrZWZpbGUgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+
Pj4gIGRyaXZlcnMvZmlybXdhcmUvaW50ZWwvS2NvbmZpZyAgICAgICAgICAgICB8ICAxNCArKysN
Cj4+PiAgZHJpdmVycy9maXJtd2FyZS9pbnRlbC9NYWtlZmlsZSAgICAgICAgICAgIHwgICA0ICsN
Cj4+PiAgZHJpdmVycy9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X3NtYy5jICAgICAgIHwgMTE5ICsr
KysrKysrKysrKysrKysrKysrKw0KPj4+ICBpbmNsdWRlL2xpbnV4L2Zpcm13YXJlL2ludGVsL2tl
ZW1iYXlfc21jLmggfCAgMjcgKysrKysNCj4+PiAgNiBmaWxlcyBjaGFuZ2VkLCAxNjYgaW5zZXJ0
aW9ucygrKQ0KPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9maXJtd2FyZS9pbnRlbC9L
Y29uZmlnICBjcmVhdGUgbW9kZQ0KPj4+IDEwMDY0NCBkcml2ZXJzL2Zpcm13YXJlL2ludGVsL01h
a2VmaWxlICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4+PiBkcml2ZXJzL2Zpcm13YXJlL2ludGVsL2tl
ZW1iYXlfc21jLmMNCj4+PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvZmlybXdh
cmUvaW50ZWwva2VlbWJheV9zbWMuaA0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmly
bXdhcmUvS2NvbmZpZyBiL2RyaXZlcnMvZmlybXdhcmUvS2NvbmZpZw0KPj4+IGluZGV4IGZiZDc4
NWRkMDUxMy4uNDFkZTc3ZDI3MjBlIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUv
S2NvbmZpZw0KPj4+ICsrKyBiL2RyaXZlcnMvZmlybXdhcmUvS2NvbmZpZw0KPj4+IEBAIC0zMDUs
NSArMzA1LDYgQEAgc291cmNlICJkcml2ZXJzL2Zpcm13YXJlL3BzY2kvS2NvbmZpZyINCj4+PiAg
c291cmNlICJkcml2ZXJzL2Zpcm13YXJlL3NtY2NjL0tjb25maWciDQo+Pj4gIHNvdXJjZSAiZHJp
dmVycy9maXJtd2FyZS90ZWdyYS9LY29uZmlnIg0KPj4+ICBzb3VyY2UgImRyaXZlcnMvZmlybXdh
cmUveGlsaW54L0tjb25maWciDQo+Pj4gK3NvdXJjZSAiZHJpdmVycy9maXJtd2FyZS9pbnRlbC9L
Y29uZmlnIg0KPj4+DQo+Pj4gIGVuZG1lbnUNCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJt
d2FyZS9NYWtlZmlsZSBiL2RyaXZlcnMvZmlybXdhcmUvTWFrZWZpbGUNCj4+PiBpbmRleCA5OTUx
MGJlOWY1ZWQuLjAwZjI5NWFiOTg2MCAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJl
L01ha2VmaWxlDQo+Pj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9NYWtlZmlsZQ0KPj4+IEBAIC0z
MywzICszMyw0IEBAIG9iai15CQkJCSs9IHBzY2kvDQo+Pj4gIG9iai15CQkJCSs9IHNtY2NjLw0K
Pj4+ICBvYmoteQkJCQkrPSB0ZWdyYS8NCj4+PiAgb2JqLXkJCQkJKz0geGlsaW54Lw0KPj4+ICtv
YmoteQkJCQkrPSBpbnRlbC8NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJtd2FyZS9pbnRl
bC9LY29uZmlnDQo+Pj4gYi9kcml2ZXJzL2Zpcm13YXJlL2ludGVsL0tjb25maWcgbmV3IGZpbGUg
bW9kZSAxMDA2NDQgaW5kZXgNCj4+PiAwMDAwMDAwMDAwMDAuLmIyYjdhNGU1NDEwYg0KPj4+IC0t
LSAvZGV2L251bGwNCj4+PiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2ludGVsL0tjb25maWcNCj4+
PiBAQCAtMCwwICsxLDE0IEBADQo+Pj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAtb25seSBtZW51ICJJbnRlbCBGaXJtd2FyZQ0KPj4+ICtEcml2ZXJzIg0KPj4+ICsNCj4+PiAr
Y29uZmlnIEtFRU1CQVlfRklSTVdBUkUNCj4+PiArCWJvb2wgIkVuYWJsZSBLZWVtIEJheSBmaXJt
d2FyZSBpbnRlcmZhY2Ugc3VwcG9ydCINCj4+PiArCWRlcGVuZHMgb24gSEFWRV9BUk1fU01DQ0MN
Cj4+DQo+PiBXaGF0IGlzIHRoZSB2ZXJzaW9uIG9mIFNNQ0NDIGltcGxlbWVudGVkID8NCk91ciBj
dXJyZW50IEFybSBUcnVzdGVkIEZpcm13YXJlIGZyYW1ld29yayBzdXBwb3J0cyB2MS4xLg0KRG9l
cyBpdCBtZWFuIEkgc2hvdWxkIHVzZSBIQVZFX0FSTV9TTUNDQ19ESVNDT1ZFUlk/DQpOb3QgcmVh
bGx5IGNsZWFyIGFib3V0IHRoaXMuIEFzIGZvciBIQVZFX0FSTV9TTUNDQyB3aWxsIGluY2x1ZGUg
DQpzdXBwb3J0IGZvciB0aGUgU01DIGFuZCBIVkMuDQoNCj4+IElmIFNNQ0NDIHYxLjErLCB1c2Ug
SEFWRV9BUk1fU01DQ0NfRElTQ09WRVJZDQo+Pg0KPj4+ICsJZGVmYXVsdCBuDQo+Pj4gKwloZWxw
DQo+Pj4gKwkgIEZpcm13YXJlIGludGVyZmFjZSBkcml2ZXIgaXMgdXNlZCBieSBkZXZpY2UgZHJp
dmVycw0KPj4+ICsJICB0byBjb21tdW5pY2F0ZSB3aXRoIHRoZSBhcm0tdHJ1c3RlZC1maXJtd2Fy
ZQ0KPj4+ICsJICBmb3IgcGxhdGZvcm0gbWFuYWdlbWVudCBzZXJ2aWNlcy4NCj4+PiArCSAgSWYg
aW4gZG91YnQsIHNheSAiTiIuDQo+Pj4gKw0KPj4+ICtlbmRtZW51DQo+Pj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZmlybXdhcmUvaW50ZWwvTWFrZWZpbGUNCj4+PiBiL2RyaXZlcnMvZmlybXdhcmUv
aW50ZWwvTWFrZWZpbGUgbmV3IGZpbGUgbW9kZSAxMDA2NDQgaW5kZXgNCj4+PiAwMDAwMDAwMDAw
MDAuLmU2ZDJlMWVhNjlhNw0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9kcml2ZXJzL2Zp
cm13YXJlL2ludGVsL01ha2VmaWxlDQo+Pj4gQEAgLTAsMCArMSw0IEBADQo+Pj4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjANCj4+PiArIyBNYWtlZmlsZSBmb3IgSW50ZWwgZmly
bXdhcmVzDQo+Pj4gKw0KPj4+ICtvYmotJChDT05GSUdfS0VFTUJBWV9GSVJNV0FSRSkgPSBrZWVt
YmF5X3NtYy5vDQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmlybXdhcmUvaW50ZWwva2VlbWJh
eV9zbWMuYw0KPj4+IGIvZHJpdmVycy9maXJtd2FyZS9pbnRlbC9rZWVtYmF5X3NtYy5jDQo+Pj4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+PiBpbmRleCAwMDAwMDAwMDAwMDAuLjI0MDEzY2QxZjVk
YQ0KPj4+IC0tLSAvZGV2L251bGwNCj4+PiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2ludGVsL2tl
ZW1iYXlfc21jLmMNCj4+PiBAQCAtMCwwICsxLDExOSBAQA0KPj4+ICsvLyBTUERYLUxpY2Vuc2Ut
SWRlbnRpZmllcjogR1BMLTIuMA0KPj4+ICsvKg0KPj4+ICsgKiAgQ29weXJpZ2h0IChDKSAyMDIw
LTIwMjEsIEludGVsIENvcnBvcmF0aW9uICAqLw0KPj4+ICsNCj4+PiArI2luY2x1ZGUgPGxpbnV4
L2FybS1zbWNjYy5oPg0KPj4+ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPj4+ICsjaW5jbHVk
ZSA8bGludXgvbW9kdWxlLmg+DQo+Pj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0K
Pj4+ICsNCj4+PiArI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlL2ludGVsL2tlZW1iYXlfc21jLmg+
DQo+Pj4gKw0KPj4+ICtzdGF0aWMgbm9pbmxpbmUgaW50IGRvX2Z3X2NhbGxfZmFpbCh1NjQgYXJn
MCwgdTY0IGFyZzEpIHsNCj4+PiArCXJldHVybiAtRU5PREVWOw0KPj4+ICt9DQo+Pj4gKw0KPj4+
ICsvKioNCj4+PiArICogU2ltcGxlIHdyYXBwZXIgZnVuY3Rpb25zIHRvIGJlIGFibGUgdG8gdXNl
IGEgZnVuY3Rpb24gcG9pbnRlcg0KPj4+ICsgKiBJbnZva2UgZG9fZndfY2FsbF9zbWMgb3Igb3Ro
ZXJzIGluIGZ1dHVyZSwgZGVwZW5kaW5nIG9uIHRoZQ0KPj4+ICtjb25maWd1cmF0aW9uICAqLyBz
dGF0aWMgaW50ICgqZG9fZndfY2FsbCkodTY0LCB1NjQpID0NCj4+PiArZG9fZndfY2FsbF9mYWls
Ow0KPj4+ICsNCj4+PiArLyoqDQo+Pj4gKyAqIGRvX2Z3X2NhbGxfc21jKCkgLSBDYWxsIHN5c3Rl
bS1sZXZlbCBwbGF0Zm9ybSBtYW5hZ2VtZW50IGxheWVyIChTTUMpDQo+Pj4gKyAqIEBhcmcwOgkJ
QXJndW1lbnQgMCB0byBTTUMgY2FsbA0KPj4+ICsgKiBAYXJnMToJCUFyZ3VtZW50IDEgdG8gU01D
IGNhbGwNCj4+PiArICoNCj4+PiArICogSW52b2tlIHBsYXRmb3JtIG1hbmFnZW1lbnQgZnVuY3Rp
b24gdmlhIFNNQyBjYWxsLg0KPj4+ICsgKg0KPj4+ICsgKiBSZXR1cm46IFJldHVybnMgc3RhdHVz
LCBlaXRoZXIgc3VjY2VzcyBvciBlcnJvciAgKi8gc3RhdGljDQo+Pj4gK25vaW5saW5lIGludCBk
b19md19jYWxsX3NtYyh1NjQgYXJnMCwgdTY0IGFyZzEpIHsNCj4+PiArCXN0cnVjdCBhcm1fc21j
Y2NfcmVzIHJlczsNCj4+PiArDQo+Pj4gKwlhcm1fc21jY2Nfc21jKGFyZzAsIGFyZzEsIDAsIDAs
IDAsIDAsIDAsIDAsICZyZXMpOw0KPj4+ICsNCj4+PiArCXJldHVybiByZXMuYTA7DQo+Pj4gK30N
Cj4+PiArDQo+Pj4gKy8qKg0KPj4+ICsgKiBrZWVtYmF5X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKCkg
LSBTZXQgdGhlIElPIFBhZCB2b2x0YWdlDQo+Pj4gKyAqIEB2b2x0OiB2b2x0YWdlIHNlbGVjdGlv
biBlaXRoZXIgMS44ViBvciAzLjNWDQo+Pj4gKyAqDQo+Pj4gKyAqIFRoaXMgZnVuY3Rpb24gaXMg
dXNlZCB0byBzZXQgdGhlIElPIExpbmUgVm9sdGFnZQ0KPj4+ICsgKg0KPj4+ICsgKiBSZXR1cm46
IDAgZm9yIHN1Y2Nlc3MsIEludmFsaWQgZm9yIGZhaWx1cmUgICovIGludA0KPj4+ICtrZWVtYmF5
X3NkX3ZvbHRhZ2Vfc2VsZWN0aW9uKGludCB2b2x0KSB7DQo+Pj4gKwlyZXR1cm4gZG9fZndfY2Fs
bChLRUVNQkFZX1NJUF9GVU5DX0lELCB2b2x0KTsNCj4+DQo+Pg0KPj4gV2hhdCBhcmUgdGhlIG90
aGVyIHVzZXMgb2YgdGhpcyBLRUVNQkFZX1NJUF8qID8NCj4+IEZvciBub3cgSSB0ZW5kIHRvIG1v
dmUgdGhpcyB0byB0aGUgZHJpdmVyIG1ha2luZyB1c2Ugb2YgaXQgdXNpbmcNCj4+IGFybV9zbWNj
Y18xXzFfaW52b2tlIGRpcmVjdGx5IGlmIHBvc3NpYmxlLiBJIGRvbid0IHNlZSB0aGUgbmVlZCBm
b3INCj4+IHRoaXMgdG8gYmUgc2VwYXJhdGUgZHJpdmVyLiBCdXQgZG8gbGV0IHVzIGtub3cgdGhl
IGZlYXR1cmVzDQo+PiBpbXBsZW1lbnRlZCBpbiB0aGUgZmlybXdhcmUuIElmIGl0IGlzIG5vdCB2
MS4xKywgcmVhc29ucyBmb3Igbm90DQo+PiB1cGdyYWRpbmcgYXMgeW91IG5lZWQgdjEuMSBmb3Ig
c29tZSBDUFUgZXJyYXRhIGltcGxlbWVudGF0aW9uLg0KPg0KPlRoaXMgZHJpdmVyIGhhcyBiZWVu
IGNyZWF0ZWQgYmFzZWQgb24gbXkgcmVxdWVzdCB0byBtb3ZlIGl0IG91dCB0aGUgbW1jDQo+ZHJp
dmVyLiBJdCBsb29rcyBxdWl0ZSBoYWNreSB0byBoYXZlIGFybV9zbWNjY19yZXMgYW5kIGNhbGwN
Cj5hcm1fc21jY2Nfc21jKCkgYWxzbyB3aXRoIHNvbWUgSURzIHdoZXJlIGl0IGlzIHZpc2libGUg
dGhhdCB0aGUgcGFydCBvZiBJRCBpcyBqdXN0DQo+YmFzZWQgb24gYW55IHNwZWMuDQo+QWxzbyBp
biB2MSBoZSBpcyBqdXN0IGNhbGxpbmcgU01DLiBCdXQgbWF5YmUgdGhlcmUgaXMgZ29pbmcgYSBu
ZWVkIHRvIGNhbGwgSFZDDQo+aW5zdGVhZCB3aGljaCBpcyBzb21ldGhpbmcgd2hhdCBkZXZpY2Ug
ZHJpdmVyIHNob3VsZG4ndCBkZWNpZGUgdGhhdCdzIHdoeQ0KPklNSE8gZG9pbmcgc3RlcCB2aWEg
ZmlybXdhcmUgZHJpdmVyIGlzIG11Y2ggYmV0dGVyIGFwcHJvYWNoLg0KPk9mIGNvdXJzZSBpZiB0
aGVyZSBpcyBhIGJldHRlci9jbGVhbmVyIHdheSBob3cgdGhpcyBzaG91bGQgYmUgZG9uZSBJIGFt
IGhhcHB5DQo+dG8gZ2V0IG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgaXQuDQo+DQo+VGhhbmtzLA0K
Pk1pY2hhbA0KPg0KPg0KDQo=
