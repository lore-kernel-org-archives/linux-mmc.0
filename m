Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0179AC433ED
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 07:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B069961445
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Apr 2021 07:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhDWHDA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Apr 2021 03:03:00 -0400
Received: from de-smtp-1.mimecast.com ([62.140.10.21]:49125 "EHLO
        de-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWHDA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Apr 2021 03:03:00 -0400
X-Greylist: delayed 63440 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Apr 2021 03:02:59 EDT
Received: from GBR01-CWL-obe.outbound.protection.outlook.com
 (mail-cwlgbr01lp2052.outbound.protection.outlook.com [104.47.20.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-CNr2JSzWMFO53KZdK8lLYg-1;
 Fri, 23 Apr 2021 09:02:21 +0200
X-MC-Unique: CNr2JSzWMFO53KZdK8lLYg-1
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:89::10)
 by CWLP265MB2244.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:61::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Fri, 23 Apr
 2021 07:02:20 +0000
Received: from CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958]) by CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a91f:361d:5554:3958%5]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 07:02:20 +0000
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Shawn Lin <shawn.lin@rock-chips.com>
CC:     "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Subject: =?utf-8?B?UmU6IFtQQVRDSF0gbW1jOiBlbmFibGUgVUhTIHZvbHRhZ2Ugc3dpdGNoIGZv?=
 =?utf-8?B?ciBTRFNDIGlmIHN1cHBvcnRlZOOAkOivt+azqOaEj++8jOmCruS7tueUsWxp?=
 =?utf-8?B?bnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmfku6Plj5HjgJE=?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBtbWM6IGVuYWJsZSBVSFMgdm9sdGFnZSBzd2l0Y2ggZm9yIFNE?=
 =?utf-8?B?U0MgaWYgc3VwcG9ydGVk44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgt?=
 =?utf-8?B?bW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7o+WPkeOAkQ==?=
Thread-Index: AQHXN+FTXUcmKL1cg0aJQqpoaGswk6rBpbamgAAEsACAAADN5w==
Date:   Fri, 23 Apr 2021 07:02:20 +0000
Message-ID: <CWXP265MB26807BB4A57D0CD3B2CAC4D2C4459@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <35677467-4ccd-9eae-3800-2bc7597cfa0f@rock-chips.com>
 <CWXP265MB2680E0D998AF13C041D18859C4459@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<61bea021-2fe7-4f1e-6eef-4a5a9a0233c9@rock-chips.com>
In-Reply-To: <61bea021-2fe7-4f1e-6eef-4a5a9a0233c9@rock-chips.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [185.80.168.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ac32431-0e0e-43e8-d3df-08d90625bd4c
x-ms-traffictypediagnostic: CWLP265MB2244:
x-microsoft-antispam-prvs: <CWLP265MB224469E9342A3947B8E2A126C4459@CWLP265MB2244.GBRP265.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:5236
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: scewZrhENHNDyUhThJVXsaVFueXaAnZxKZciOTDvnobWd6eqZWFGaTW46aRioLxbouIgH9W+3LWAyUNtrhx1Fk+CqcmdgSs/POpoloT7/z1Z3PLjZZ1yvfASRLih14mBVB8yZ+volat3Btf1U1idi79u82djvoaBpVcM41oSWJmmsQURNBxBid4VpetRM/YL+4vPqsxqobS8rAd6TEvB+frQUCdldXzNrVrc/oTPaUqxYgad/vsWzTovSgxk95nGqsmCgyaZL/2XtsEm+J2WA39KpD7gsEeOVZCvpWxTUvmoAvATzTtrgqgY0wQy+4FmsedPpXHXTflS0k/RCZVRoAEa+ggZTPTVDYXmtqJX90O9nje3dalzr8VISda5WhIyXMEl+eDrRW+XoryT3x/jlDm/gd8yL/LtbEGTHGpwyh7sGjbyUo1AiVRdsnA+ENIvTSUjRDiLLGoxwUYKoie5vBJ71pUc6XEfv9mz20/vIBs3dvhM9CsgyOUKjM90dWjK7xUctzBwNzWaXc2WfU3DfjDlhXKi0unTlNQtWPynC+WqGmzTqTNCZb8eT/PeJw6f7fEoMjRSVKjKgXSyFh7llHbHM3hJqcf/0yxakJZWhY3mFbCKXkSugD3wfSW2Qv713djvybASCsSEhdo/vSXo2O83VwjMBno4sB5+Xl8okxT0nprkGtCJi5B3kA+OFczd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(366004)(346002)(376002)(85202003)(54906003)(6916009)(316002)(85182001)(6506007)(83380400001)(2906002)(224303003)(71200400001)(55016002)(86362001)(53546011)(33656002)(9686003)(7696005)(66574015)(38100700002)(122000001)(52536014)(4326008)(26005)(186003)(66446008)(5660300002)(478600001)(64756008)(8936002)(66946007)(66556008)(76116006)(91956017)(66476007)(966005);DIR:OUT;SFP:1101
x-ms-exchange-antispam-messagedata: =?utf-8?B?QTg2akFXbXNQUzFhbTAxQURUUjV2ekwwaDJsYUpVM3dZVTJITSt4NkxYVWNJ?=
 =?utf-8?B?NEpEcWlkTXdnNnUxNnZYVG40L3ZzTjI3VHB2NmZxbk5sR2F4TDFWcFdpL25l?=
 =?utf-8?B?WHFBVW83dU5YZlB1bVNSMjdVTURQRTd0V0dLNG1BaHlnczZ1ZXVjM0d2cHJh?=
 =?utf-8?B?U1hpSE5HK3BuVEZsRjZaRmFQWExHYUN5UEhrQjFyUk9JSTZKdU0vTEo4VG1D?=
 =?utf-8?B?ZStzMGxIOVhmSC9pd2dJRHNSL2R4VjZpbXpxbmNZN21kS05idkhNeWY5RE5D?=
 =?utf-8?B?SDJXc3dtUVB5U0VsejZQdW4xcTBwTURCcFVEd3g1dzBrQnZMdy8yQ2lwcm9C?=
 =?utf-8?B?c2NzeG0yU3p5VWVuUGUraElrQVMvaERab093VkxhdWpEbXpXU3Jjd3d3bTFN?=
 =?utf-8?B?YlJ3cmhOd0Z1VXgrVjNYNGVwUk03RVVtb2lneGViMEE5VlFlYUhqK21qWTVu?=
 =?utf-8?B?YzdheUFnKzNxZU0vNHJ6eG1sUlJwYW1QMHU2bGZ2eHhYZ3JNVE1XRXU1UFlw?=
 =?utf-8?B?NGMvR0VVSHN3NXJOZGZ0OEx3ME0rTDVEdkNnbW00SjQvak1UZGk5dVhWaTJI?=
 =?utf-8?B?cXNwTWxxMDRRTEY3Q2FVMVBRbXhZOGVwVURGNWphNHd4Ulk0c0dUS1F6UW90?=
 =?utf-8?B?bWVFV2NnNlBmcWF1REd3SEk5L2x4VTR1aHdGMHNqd1ZVdHBEa0JwY2plNzZ0?=
 =?utf-8?B?ek1hdFNqN3dONXVaSE1VMFQ5MDZndWcwTUhBbjVEUk1lU2xvTlRBVUJKUEZD?=
 =?utf-8?B?bDQ4YUoxWU00SU1TczRiRUs4UVplYnk4bmpDRVJEVXJYU3drMUlTNnlLMFhl?=
 =?utf-8?B?WTVBdnZycnh4aUU5dlgxSWRqa3FvUjhEMnZuWFp3Sm9jeUhNajU4cHVYQzB0?=
 =?utf-8?B?UnZhN3VQYkdYT1Y3blJmaE5kNVhBaS82QUJFdnVGMExkUjF5TzZ2WnpZbDFo?=
 =?utf-8?B?Zk1IK0FEZ21TdlJEakt5UFd1TGN6c1JDM3dvczFoYWV0azlWYmFhZk4rY3Fx?=
 =?utf-8?B?d3E5aG5WSHJ6SmFFcUh2anhHcnlBd0pNS3gyRnFZNm5hK1NGdURENTNlalND?=
 =?utf-8?B?YlJFUk5FZU10RWc3YUZac1Y1WmxjKzg2U1VPTThQQ3pUMm9ZaUIyUE9DSjln?=
 =?utf-8?B?cmNVMVhTMU55WmpJY0F2eUtuMjVuZFlHajNUcVdYaENRUEpFNm5qYVArbmY0?=
 =?utf-8?B?aWMrd3lVdXhINFJJTVkvMnl0WWplS3VDNlhXSEhrenVHaGxhZ1B3ak1sd28w?=
 =?utf-8?B?RyttK3RkczVLVzd4dnBQMllZY082emhOQWlXbGtoclN5QjErdUpxd3dsWG1k?=
 =?utf-8?B?SVFqcWJmV2RMNWJhSmM0dFVjUVc4TXRKdGthcmdCOW53ZVJkbjJxM05hNG1l?=
 =?utf-8?B?UWZRcmxWcHFIM2RJWjlhK01FQnhvRTUrYWJBSFFlaGVHd2dpVmlEckRaNEZV?=
 =?utf-8?B?L0FtNFNHWlRtTkhoVXJTNjdLU1dNaWJaYmJiNVk5M3lzQmFJQ3Z1bk1KZXdu?=
 =?utf-8?B?RWdPOVlLKy9ZcHRBeE41b3pBZVZmaHIvb3VENlY5YzhHZm5WZnJMVFNmaVN3?=
 =?utf-8?B?ZEw1REhzb20yaC9JVm1Zd0dXR3RBMjFSTXUrMTlxVllnL0xFU2E2UVNmS1BM?=
 =?utf-8?B?d2g2eHd0Z2FnbHBIRmtHeXQ0Y3BlTTJ1S0FWY3F5Vm5xbEZLekp5Q29udWZz?=
 =?utf-8?B?OWpmUnF2dXJvZTdGWVlUb05SUW8vV3lIT1ZydVNrS3JCYUZpcVdjYVRtWitK?=
 =?utf-8?Q?XnPkDAh2UyjV5HaUGQ=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: hyperstone.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ac32431-0e0e-43e8-d3df-08d90625bd4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 07:02:20.8523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86f203eb-e878-4188-b297-34c118c18b11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cLRIjgcWoVCacg//+1kCecY+K1iv/yuGuaMUM3aDGMVhW58rGg8GZUkBg441gyBLH+MBtpZ4KyqB5LDxLf3mDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2244
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CDE5A68 smtp.mailfrom=cloehle@hyperstone.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hyperstone.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QXMgSSBzYWlkIEkgZG8gbm90IG93biB0aGlzIHBhcnRpY3VsYXIgR29vZHJhbSAyR0IgcFNMQyBk
ZXZpY2UsCmJ1dCB0aGUgcHJvZHVjdCBpbmZvcm1hdGlvbiBzaGVldCBwZXJmZWN0bHkgaWxsdXN0
cmF0ZXMgbXkgcG9pbnQ6Cmh0dHBzOi8vd3d3LnRtZS5ldS9Eb2N1bWVudC83M2RiYzEyMjE2MTlj
NjI3YzUyYmY4ZGQzNTg1OWU1NS9wU0xDJTIwU0QlMjBpbmR1c3RyaWFsJTIwR29sZC1EaWFtb25k
LkVOLnBkZgooUGFnZSAxMCkKVGhleSBjbGFpbSB1cCB0byA5ME1CL3MgZm9yIGV2ZXJ5dGhpbmcg
U0RIQywgYnV0IGZvciAyR0IgdGhleSBvbmx5CmNsYWltIDIwTUIvcyBhbmQgTm9uLVVIUyBtb2Rl
LgpTbyBpZiB0aGUgZmlybXdhcmUgd2FzIG5vdCBzcGVjaWZpY2FsbHkgYnVpbHQgd2l0aG91dCBy
ZXBvcnRpbmcgYW55IFVIUwpzdXBwb3J0LCBqdXN0IGZvciB0aGUgMkdCIHZlcnNpb24uCkJ1dCB0
aGVyZSBhcmUgcXVpdGUgc29tZSBTTEMgZGV2aWNlcyB3aXRoIDJHQiB0aGF0IGNsYWltIG92ZXIg
MjVNQi9zLAp3aXRob3V0IG1lbnRpb25pbmcgVUhTLUkgc3BlY2lmaWNhbGx5LiBCdXQgY2xlYXJs
eSwgZWl0aGVyIHRoZXkgYXJlIGx5aW5nLApvciBoYXZlIHRoaXMgbm9uLXN0YW5kYXJkIFNEU0Mg
VUhTIHN1cHBvcnQuCgpGcm9tOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT4K
U2VudDogRnJpZGF5LCBBcHJpbCAyMywgMjAyMSA4OjUxIEFNClRvOiBDaHJpc3RpYW4gTMO2aGxl
IDxDTG9laGxlQGh5cGVyc3RvbmUuY29tPgpDYzogc2hhd24ubGluQHJvY2stY2hpcHMuY29tIDxz
aGF3bi5saW5Acm9jay1jaGlwcy5jb20+OyBwYWxpQGtlcm5lbC5vcmcgPHBhbGlAa2VybmVsLm9y
Zz47IGh1eXVlMkB5dWxvbmcuY29tIDxodXl1ZTJAeXVsb25nLmNvbT47IHRpYW50YW82QGhpc2ls
aWNvbi5jb20gPHRpYW50YW82QGhpc2lsaWNvbi5jb20+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnIDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IHVsZi5oYW5zc29uQGxpbmFyby5v
cmcgPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1tYzogZW5h
YmxlIFVIUyB2b2x0YWdlIHN3aXRjaCBmb3IgU0RTQyBpZiBzdXBwb3J0ZWTjgJDor7fms6jmhI/v
vIzpgq7ku7bnlLFsaW51eC1tbWMtb3duZXJAdmdlci5rZXJuZWwub3Jn5Luj5Y+R44CRIArCoApP
biAyMDIxLzQvMjMgMTQ6MzgsIENocmlzdGlhbiBMw7ZobGUgd3JvdGU6Cj4gQ2xhaW1pbmcgVUhT
LUkgc3VwcG9ydCB3aXRoIFNEU0MgaXMgcHJldHR5IHJhcmUsIGZvciBvYnZpb3VzIHJlYXNvbnMg
KG5hbWVseSB0aGV5IGFyZSBub24tc3RhbmRhcmQsIHNvIGl0J3MgYSBnYW1ibGUgaWYgYSBob3N0
IG1ha2VzIHVzZSBvZiBpdCksIGJ1dCBoZXJlIHlvdSBnbzoKPiBodHRwczovL2RlLnJzLW9ubGlu
ZS5jb20vd2ViL3AvbWljcm8tc2Qta2FydGVuLzg3NDM5MTAvCj4gKHNvcnJ5IGZvciB0aGUgZ2Vy
bWFuLCB0aGUgc2l0ZSBoYXMgYSBlbi4gc3VicGFnZSwgYnV0IGl0J3MgY2VydGlmaWNhdGUgc2Vl
bSB1bnRydXN0ZWQuKQo+IFRoZSBtb3JlIGxpa2VseSBjYXNlIGlzIHRoYXQgdGhleSBkbyBub3Qg
YWR2ZXJ0aXNlIFVIUy1JIHRvIGN1c3RvbWVycywKPiBidXQgdGhlIGNhcmQgd2lsbCBzaG93IHN1
cHBvcnQgdG8gdGhlIGhvc3QuCj4gTGV0J3MgbG9vayBhdCB0aGlzIHByb2R1Y3QsIGp1c3QgYXMg
YW4gZXhhbXBsZS4KPiBodHRwczovL3d3dy50bWUuZXUvaHRtbC9FTi9nb29kcmFtLWluZHVzdHJp
YWwtaW5kdXN0cmlhbC1zZC1zZC1taWNyby1tZW1vcnktY2FyZHMvcmFta2FfMTUyNDJfRU5fcGVs
bnkuaHRtbAo+IFRoZXkgcHJvdmlkZSBhbiBNTEMgYW5kIHBTTEMgdmVyc2lvbiBvZiBlYWNoIGRl
dmljZSwgd2l0aCBoYWxmIHRoZSBjYXBhY2l0eSBuYXR1cmFsbHkuCj4gVGhlIDRHQiBNTEMgY2xh
aW1zIFVIUy1JIHN1cHBvcnQsIHRoZSAyR0IgcFNMQyBpcyB2ZXJ5IGxpa2VseSB0byBiZSB0aGUg
c2FtZSBjb250cm9sbGVyLAo+IGl0IG9ubHkgY2xhaW1zIENsYXNzIDYuCj4gU28gZWl0aGVyIHRo
ZXkgc3BlY2lmaWNhbGx5IGNoYW5nZWQgdGhlIGZpcm13YXJlIHRvIHJlbW92ZSBhbnkgVUhTIHN1
cHBvcnQgaW5kaWNhdGlvbiwKPiBvciwgbW9yZSBsaWtlbHkgSU1PLCB0aGUgY2FyZCBzdGlsbCBy
ZXBvcnRzIFVIUyBzdXBwb3J0IHRvIHRoZSBob3N0Lgo+IFN1Y2ggYSBjYXJkIHdvdWxkIGJlbmVm
aXQgZnJvbSB0aGlzIHBhdGNoLgo+IAo+IERpc2NsYWltZXI6IEkgZG8gbm90IG93biB0aGUgcHJv
ZHVjdCBhbmQgaGF2ZSBub3QgY29uZmlybWVkIHRoaXMgZGV2aWNlIGluIGFueSB3YXksCj4gYnV0
IEkgaGF2ZSBzZWVuIFVIUyBzdXBwb3J0IG9uIG90aGVyIGRldmljZXMgdGhhdCBkbyBub3QgYWR2
ZXJ0aXNlIGl0IGZvciB0aGVpcgo+IFNEU0MgdmVyc2lvbnMuCj4gSWYgdGhlIG1haWxpbmcgbGlz
dCB3b3VsZCBiZSBpbnRlcmVzdGVkLCBJIGNhbiB0cnkgdG8gYWNxdWlyZSBzdWNoIGRldmljZXMs
IGxpc3RlZCBpbgo+IHB1YmxpYyBvcGVuIHN0b3Jlcy4gTW9kZXJuLCBwb3RlbnRpYWxseSBVSFMg
c3VwcG9ydGluZyBjYXJkcy4gYXJlLAo+IGFzIG1lbnRpb25lZCBpbiB0aGUgaW5pdGlhbCBNYWls
LCBvZnRlbiBTTEMgb3IgcFNMQyBhbmQgb2Z0ZW4gYXJlIG1hZGUgb24KPiBhIGN1c3RvbWVycyBy
ZXF1ZXN0Lgo+IAo+IAoKVGhhbmtzIGZvciBzaGFyaW5nIHRoZXNlLCBidXQgZnJvbSB0aGUgZGF0
YXNoZWV0cywgdGhlc2UgU0RTQyBjYXJkcwpjbGFpbXMgdGhlaXIgdGhyb3VnaHQgdXAgdG8gMjBN
Qi9zLiBTbywgSSBndWVzcyBoaWdocHNlZWQgbW9kZSBpcyBlbm91Z2gKZm9yIHRoZW0/IHdoYXQg
ZG8geW91IHRoaW5rPwoNCkh5cGVyc3RvbmUgR21iSCB8IExpbmUtRWlkLVN0cmFzc2UgMyB8IDc4
NDY3IEtvbnN0YW56DQpNYW5hZ2luZyBEaXJlY3RvcnM6IERyLiBKYW4gUGV0ZXIgQmVybnMuDQpD
b21tZXJjaWFsIHJlZ2lzdGVyIG9mIGxvY2FsIGNvdXJ0czogRnJlaWJ1cmcgSFJCMzgxNzgyDQo=

