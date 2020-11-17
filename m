Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B36C5519F
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 13:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E13221F8
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Nov 2020 13:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xwPFPxvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbgKQNsb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Nov 2020 08:48:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:26718 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387658AbgKQNqt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Nov 2020 08:46:49 -0500
IronPort-SDR: TK1M+gjX5lDp+GTn0ilOSHwVMCSl/gmwyTEtE6TAsCLBXC4Mkghh4vKDqYg7NQnPExI5y/M1uX
 jZ2BoLdhkLPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="255636343"
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="255636343"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 05:46:48 -0800
IronPort-SDR: PPgppw46BkNdpfthgF2OHoTVeatOUtzPm1CzRTpm4Cj0sH+sgiR8Oq+9XGyu2FYPHtRWqK37E1
 cSvRjRBNFUjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,485,1596524400"; 
   d="scan'208";a="325159984"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 17 Nov 2020 05:46:48 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Nov 2020 05:46:48 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Nov 2020 05:46:48 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 17 Nov 2020 05:46:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVO49z+PiRNLDyRn+AAtv4pPAmRL2O0702got/0spkmMZif8Ao2G0RD8L875dT2uZBlnpZ3+8cCxNVLStpnKIsbnme6m9FWsw+mnCTpjuHEIJa2AYS7s7vJFyDgvuexCfJHSQBm0tqCopUfhqh9r+2HJAS72zi5XF/LzlFD4i3hV8iYuCZIPOoWo/edK2YD1/4z3oTVXOCQ5QPUeJjKTyW4JP5GFE6JNH4/YxlfvIBA0wzHUxrmHM8nvgr2UZKdXcpX9qzjfG2Btjnmd0fsRmXKhGSgG/yL5yiihAcVRFohHudRJ5lAc/QDCXQQsL8GDLNUAYzmdFKcCmbiQ3uzOFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNRnQPnyVR1loYHZEiljYq61WpNgneDSrVQ/iCJDbQw=;
 b=a2H3RQAEMJxelDymSIwYc5FvbhvcLk7IkFX04QMstC3cxh0v13PT03NxJzwYJ9gOBlCqXNeA6Ebwbb0u35/A88pIccpKKoPlV7mTbeOt9z8gV8fTHgp7ZhLeE3+J3+x9C/Trgq69wU2R5udYmXv4Up+vYIJkNGtQJ1gqCrLU/Ik/h5pvkrt7C97tRrSDqjXWGHkLAOHUPXvBS4gW420uHmXxAV0+aX4c+aluPCcFRB1oRxUbjQ7YxS1uviKPLIB+2Tl75vfNbpZL6gRQsSp/WLbkkw9og5V5IcHXt8uR/TiZRJsGq/FB4b7jgzPEFUiYnyjbmVkm40JcMge0WhC5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNRnQPnyVR1loYHZEiljYq61WpNgneDSrVQ/iCJDbQw=;
 b=xwPFPxvtWAdgeygrvJcQ0nDMJbN84JKgjvAHO5UN9f9e3OajtOwzAIh6Bs3WdiUYfR2kOX8RrqeYWEWsoWk9gv+523dwLic2UaBHzdeWs9QmyCvu0umcb2Wx5RFZA8RWT6YgAbG6IGydwV9q3qWzuvR9zXsCD4h5jFu31UqONQE=
Received: from DM6PR11MB2876.namprd11.prod.outlook.com (2603:10b6:5:c1::16) by
 DM6PR11MB2938.namprd11.prod.outlook.com (2603:10b6:5:64::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.32; Tue, 17 Nov 2020 13:46:42 +0000
Received: from DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c]) by DM6PR11MB2876.namprd11.prod.outlook.com
 ([fe80::c85a:d98e:fbf3:9f8c%5]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 13:46:42 +0000
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
Thread-Index: AQHWs/Kyv+f0bf2SO0CVLGdSxsJGq6nKstkAgAApWoCAAWUIAIAAJgbg
Date:   Tue, 17 Nov 2020 13:46:42 +0000
Message-ID: <DM6PR11MB2876A043535B8EDE5286FBB0B8E20@DM6PR11MB2876.namprd11.prod.outlook.com>
References: <20201106120933.7190-1-muhammad.husaini.zulkifli@intel.com>
 <20201106120933.7190-2-muhammad.husaini.zulkifli@intel.com>
 <CAPDyKFrq0Wsc7bNS0QPMitNqpkzK87VAuTnjDqrqTrVDGCwxgg@mail.gmail.com>
 <DM6PR11MB2876BB714DF701E81866B13EB8E30@DM6PR11MB2876.namprd11.prod.outlook.com>
 <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com>
In-Reply-To: <CAPDyKFpVJ0jGkqa2j9W-Z-su3vT2eSKHkObYj1Z0C3MvRQrKwg@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 8cd817b5-12ce-4d25-7339-08d88aff376d
x-ms-traffictypediagnostic: DM6PR11MB2938:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2938CC33BF09AA33B7842075B8E20@DM6PR11MB2938.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ec+HTRoSg9IQ3fHzDcO+twMezeoudnjJR4QCDb5hDctk+r0NwSq6XJl9PadN4Lw+gFRWkR3ML1PtEq1WaZ4E6OoP4sQsNbZhLCcL1QfF4pGFTGgY9e8iC74ZdyFfS7Gr4mZ8smMbb1op6clBCPGdEVqc2dJPEGrXt7C0MFYjIbnwJTrQCWdUm6JRbVqAxhrp+UBZu7WPN615stcMyARy0ooLWcNjsGNryvdUBZ5ert5ex+lTbBH2bl7GaKyKejaFi8kpfH1Z0BmeKJsQhLsluxYKiwPwmhPF5nMFR4DbXrhVHxos73V0fKJz1hbkdgrN7x3kjY0qQtfCJflQek0/iaAJSeoAsl1lfyul8GBWLiLTd6nXO7kZeqf4bX6EG4kr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2876.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(83380400001)(8936002)(8676002)(52536014)(33656002)(7696005)(478600001)(316002)(5660300002)(55016002)(9686003)(2906002)(76116006)(186003)(6506007)(86362001)(6916009)(66946007)(71200400001)(66476007)(66556008)(26005)(64756008)(66446008)(54906003)(4326008)(142923001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: R9ow3X+cDIPz6hODMHpe3Pp/iECL21zp07DErx4OR90wFRGdTPEK8eB68FlSFjMqNefiREk7Qm8tgPTMM5bJcasXgWKQuwV+H4aXkqptbQd53Nm49F0UpejOH1f4v+QhUHVO0EvJXj3jT+5g/iDADPRqo7uBzeVOAbNq7YzPGpOzm5Ie4Vj9VQj7znpdi3DmO/XFw7sgIUUSKfNFdS4HNzJ3HNCMpRMpdzymEO9Y58dXNFQKH8UNw9ORizfSJahIQ20x2x1/8VVhwQ9cRB1y1v6bei5Jo0Ia9TypNzx6KtDcPDDgZXd/0CStn3lSdZQe+B+R1wh2Qi0cpveKGTVwLlImpyUPNj6HIehpWteqfbG+VYOcGp/3eN1KhVJjugIK84nJf7hE5gbB+FbVxB689jCXPMvvLh7w3fcrH0TOl22cj9zz7QQEwyup/Ly1C9pAZhflNtLLsXm14beuSUl8Ap0QD3yVOZcus3xTbwUHtP9tHaJCEMnDBJEPcpEJZqPYJN1OD7EWA0RAs6mMuOrbX8Ll8jrpRmPCPAKYXiEedbGKhmtYcwhxbnI9sZVlmCORQ8Kk/ve/V6EDeK0AXs2yz2jtia+VR2pQxPsKOc1eeEvbBkOPnJ3vtyN1Bb5zkb2xSiH9A/KVzqLxLLDugwKGmsoKdXwkp++4/UqvQDMRz6TF4Utn1+HdzoWZDLfgqydy80QSencQsgDeQ+4fWzyX9XGKyHpHUfQlUBiWWap1DGPrpca1o7bHsEzhJVNi6iMd12a7J+WdiuZOzKMSVAX+bzp2Ao6Qv5CXyEbuLOdzNT9AiMZybUrYnpePvJCv7JnvPu99br+YmmCTxIAWKGh7hG57/gWC0SbyhbFy1pkJpdq9J9tE1zGCH4i8VmLQj1vPENRCIE0qEQXVzZYgj0ZmUQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2876.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd817b5-12ce-4d25-7339-08d88aff376d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2020 13:46:42.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qszRH4RoEiWLMiTLpf9skA+ujWMmaUNnalh0uJLGcSMLUkdWL1U8Zkg9PdaV4gyuSjip6il5GWjazGr9/DPYnwOUwOmk7ZXf6otR27cqC4nl2mHNBAA/FIaDkqM/s46j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2938
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgVWxmLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBVbGYgSGFuc3Nv
biA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxNywg
MjAyMCA3OjI3IFBNDQo+VG86IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1hZC5o
dXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj5DYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9y
ZzsgTGludXggQVJNIDxsaW51eC1hcm0tDQo+a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBM
aW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3Jn
PjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgUmFqYQ0KPlN1YnJh
bWFuaWFuLCBMYWtzaG1pIEJhaSA8bGFrc2htaS5iYWkucmFqYS5zdWJyYW1hbmlhbkBpbnRlbC5j
b20+OyBXYW4NCj5Nb2hhbWFkLCBXYW4gQWhtYWQgWmFpbmllDQo+PHdhbi5haG1hZC56YWluaWUu
d2FuLm1vaGFtYWRAaW50ZWwuY29tPjsgRGF2aWQgRS4gQm94DQo+PGRhdmlkLmUuYm94QGxpbnV4
LmludGVsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDEvMV0gbW1jOiBzZGhjaS1vZi1h
cmFzYW46IFNwZWNpZnkgLmNsa19vcHMgZm9yIEtlZW0gQmF5DQo+U09DDQo+DQo+T24gTW9uLCAx
NiBOb3YgMjAyMCBhdCAxNToyMiwgWnVsa2lmbGksIE11aGFtbWFkIEh1c2FpbmkNCj48bXVoYW1t
YWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEhpIFVsZiwNCj4+
DQo+PiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3IGNvbW1lbnRzLiBJIHJlcGxpZWQgaW5saW5lDQo+
Pg0KPj4gPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+PiA+RnJvbTogVWxmIEhhbnNzb24g
PHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+PiA+U2VudDogTW9uZGF5LCBOb3ZlbWJlciAxNiwg
MjAyMCA3OjQxIFBNDQo+PiA+VG86IFp1bGtpZmxpLCBNdWhhbW1hZCBIdXNhaW5pIDxtdWhhbW1h
ZC5odXNhaW5pLnp1bGtpZmxpQGludGVsLmNvbT4NCj4+ID5DYzogbGludXgtbW1jQHZnZXIua2Vy
bmVsLm9yZzsgTGludXggQVJNIDxsaW51eC1hcm0tDQo+PiA+a2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC0NCj4+ID5rZXJuZWxAdmdl
ci5rZXJuZWwub3JnPjsgSHVudGVyLCBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsN
Cj4+ID5SYWphIFN1YnJhbWFuaWFuLCBMYWtzaG1pIEJhaQ0KPj4gPjxsYWtzaG1pLmJhaS5yYWph
LnN1YnJhbWFuaWFuQGludGVsLmNvbT47IFdhbiBNb2hhbWFkLCBXYW4gQWhtYWQNCj4+ID5aYWlu
aWUgPHdhbi5haG1hZC56YWluaWUud2FuLm1vaGFtYWRAaW50ZWwuY29tPjsgRGF2aWQgRS4gQm94
DQo+PiA+PGRhdmlkLmUuYm94QGxpbnV4LmludGVsLmNvbT4NCj4+ID5TdWJqZWN0OiBSZTogW1BB
VENIIHYxIDEvMV0gbW1jOiBzZGhjaS1vZi1hcmFzYW46IFNwZWNpZnkgLmNsa19vcHMNCj4+ID5m
b3IgS2VlbSBCYXkgU09DDQo+PiA+DQo+PiA+T24gRnJpLCA2IE5vdiAyMDIwIGF0IDA1OjEwLCA8
bXVoYW1tYWQuaHVzYWluaS56dWxraWZsaUBpbnRlbC5jb20+IHdyb3RlOg0KPj4gPj4NCj4+ID4+
IEZyb206IE11aGFtbWFkIEh1c2FpbmkgWnVsa2lmbGkNCj4+ID4+IDxtdWhhbW1hZC5odXNhaW5p
Lnp1bGtpZmxpQGludGVsLmNvbT4NCj4+ID4+DQo+PiA+PiBDb21taXQgMTZhZGE3MzBhNzU5ICgi
bW1jOiBzZGhjaS1vZi1hcmFzYW46IE1vZGlmeSBjbG9jayBvcGVyYXRpb25zDQo+PiA+PiBoYW5k
bGluZyIpIGludHJvZHVjZXMgcGxhdGZvcm0gc3BlY2lmaWMgU0RIQ0kgY2xvY2sgb3BlcmF0aW9u
Lg0KPj4gPj4NCj4+ID4+IFRoaXMgcGF0Y2ggZGVjbGFyZXMgdGhlIGNsb2NrIG9wZXJhdGlvbiBm
b3IgS2VlbSBCYXkuDQo+PiA+PiBBZGQgY2xrX29wcyBmb3IgU0QsIEVNTUMgYW5kIFNESU8gb3Bl
cmF0aW9ucy4NCj4+ID4NCj4+ID5UaGUgYWJvdmUgY29tbWl0IG1lc3NhZ2UgZG9lc24ndCByZWFs
bHkgdGVsbCB3aHkgb3Igd2hhdCBnb2VzIG9uIGhlcmUuDQo+PiA+Q2FuIHBsZWFzZSB0cnkgdG8g
Y2xhcmlmeSB0aGF0Lg0KPj4NCj4+IFdlIG1pc3NlZCBvdXQgdGhlIGNsb2NrIG9wZXJhdGlvbiBo
YW5kbGluZyBwYXRjaCAoQ29tbWl0IDE2YWRhNzMwYTc1OSkNCj4+IGFuZCBkaWQgbm90IGhhbmRs
ZSB0aGUgY2xrX29wcyAgZm9yIEtlZW0gQmF5IFNPQyBkZXZpY2VzLg0KPj4gVGhlc2UgMiBwYXRj
aGVzIChDb21taXQgMTZhZGE3MzBhNzU5KSBhbmQgKENvbW1pdCAzNmM2YWFkYWFlODYpICBhcmUN
Cj5tZXJnZWQgYXQgYXJvdW5kIHRoZSBzYW1lIHRpbWUuDQo+PiBXZSBjYXRjaCB0aGUgaXNzdWUg
bGF0ZXIgd2hlbiB0cnlpbmcgdG8gYm9vdCBpbnRvIHY1LjEwLXJjMSB3aXRoIEtlZW0gQmF5DQo+
RVZNLg0KPj4gVGhhdCBpcyB3aHkgSSBjcmVhdGVkIHRoaXMgcGF0Y2ggdG8gaGFuZGxlIHRoZSBj
bGtfb3BzIGZvciBLZWVtIEJheSBkZXZpY2VzLg0KPg0KPkFscmlnaHQsIHNvIHRoZSBwcmV2aW91
cyBjaGFuZ2VzIHdlcmUgc2ltcGx5IG5vdCBzdWZmaWNpZW50IHRvIGNvbXBsZXRlIHRoZQ0KPnN1
cHBvcnQuDQo+DQo+Pg0KPj4gPg0KPj4gPj4NCj4+ID4+IEZpeGVzOiAzNmM2YWFkYWFlODYgKCJt
bWM6IHNkaGNpLW9mLWFyYXNhbjogQWRkIHN1cHBvcnQgZm9yIEludGVsDQo+PiA+PiBLZWVtDQo+
PiA+PiBCYXkiKQ0KPj4gPg0KPj4gPklzICRzdWJqZWN0IHBhdGNoIGZpeGluZyBhIGJ1Zy9yZWdy
ZXNzaW9uPw0KPj4NCj4+IFRoaXMgaXMgdG8gZml4IGlzc3VlIG9uIHByZXZpb3VzIGNvbW1pdC4g
SXQgaXMgYSBidWcgZml4Lg0KPg0KPkhhcyBpdCBldmVyIHdvcmtlZD8NCg0KWWVzIGl0IGlzIHdv
cmtpbmcuIFRlc3RlZCB3aXRoIEtlZW0gQmF5IEVWTS4gDQpTRC9FTU1DL1NESU8gZGV2aWNlcyBy
ZWdpc3RlcmVkIHN1Y2Nlc3NmdWxseSB3aXRoIHRoaXMgZml4LiAgDQoNCj4NCj5EaWQgdGhlIGNv
bW1pdCB5b3UgcG9pbnQgdG8gd2l0aCB0aGUgZml4ZXMgdGFnLCBicmVhayBzb21lIG90aGVyIGV4
aXN0aW5nDQo+ZnVuY3Rpb25hbGl0eT8NCg0KSXQgc2hvdWxkIG5vdCBicmVhayBvdGhlciBleGlz
dGluZyBmdW5jdGlvbmFsaXR5LiANClRoaXMgaXMgc3BlY2lmaWMgZm9yIEtlZW0gQmF5IFNPQyBv
bmx5Lg0KDQo+DQo+Wy4uLl0NCj4NCj5LaW5kIHJlZ2FyZHMNCj5VZmZlDQo=
