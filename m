Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916B2C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Jan 2021 07:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E0CD20663
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Jan 2021 07:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbhA0Hl0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Jan 2021 02:41:26 -0500
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:48009
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234306AbhA0HhJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 Jan 2021 02:37:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGUt+BkvAdt0MZnxDXch3rlHw451CwTKgWfcDmCkTBdlSWPyvlkrR2HjcwqUUtz8Dn4LuMQ/MDmtX/VWSqD4UrByIwAI/O0LQcq4Wexk0imyGrkNxId/CJgDlHFBhkwjO+DjB2MteCbGwHCtCiqXIaLd79hTkddfh8NpLPl7lgCz04arFAFZkQbJU12UXyJYcN2IqNTNsNUmQC2ekcezi9TrrA5330HT4mPc+wCzy85eGT4ES79Gg9NIBdkwJHCoyvxM9Y/CRa+cy3FEaCIdqThTCt3k+bIURF6PMcPEsTx5YdpE7vtxMjdhZr/xQZteCRhZVwjoe/j0e+dyEBq59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgjHEFVqigcfaUh5a0vrkDRqsqfyPUR6MYxW50EKOJM=;
 b=NScle7KpROpyZ5XokB+7AKHk1C2wICb9+S1uE91hpugXdkqf07xjc+05aNhFe1uetHpaalRPKeLLooTOrm6mGv9imaUcJKPtcW1EOgYbZUek+O+IrTrpX7q2TMA3C6+weiFl9zGJ4rBdrHisF+DXgp9c5F1ZMegMYz0O3w1hu8AvqQBRG53XdqoGKjw6w2U63LYgWXLp0NwCCXvli45fOhSqNYQF/4hSCeyoXvRsteylZ8U0b7P0rw+LvLMNu8Jf4DvXZEz68ec8+ttEKgWUkKsWoiDjMLGLSnYfVfC2OcrI3AEVhcqbioJdVpvpdBjzA6MMl+rHNDiazcB8+P0JFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgjHEFVqigcfaUh5a0vrkDRqsqfyPUR6MYxW50EKOJM=;
 b=EUQy82yVzgItre4NFhFV3AD8+NHhx/bsYh3x2hY4igxiZUs393AJb70iwoiROtLODldsnQRHRCapD3TRDbycJqgEe/1Teob9gx71K6Q+b/r2RalUNVxcbLiCtDcOEP9xIkccJNEahUKwxPNMlNDpA4ROXWgbl/f961vdr7KYwc0=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Wed, 27 Jan
 2021 07:36:17 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::9118:46d6:d36e:27b6]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::9118:46d6:d36e:27b6%5]) with mapi id 15.20.3784.019; Wed, 27 Jan 2021
 07:36:16 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        Fabio Estevam <festevam@gmail.com>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Topic: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Index: AQHW7VKKjN2CkSEiwk6wXCAUqn5gWaowiQqAgAFTA4CAADstgIAJBI8Q
Date:   Wed, 27 Jan 2021 07:36:16 +0000
Message-ID: <VI1PR04MB5294AB4D2C810A6278F1D83B90BB0@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
 <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
In-Reply-To: <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7987d8c9-c234-4d7e-d7a9-08d8c2963b4f
x-ms-traffictypediagnostic: VI1PR04MB6942:
x-microsoft-antispam-prvs: <VI1PR04MB69421606C191E4998D6DAA0D90BB0@VI1PR04MB6942.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lOGKPTZkOcKk8v9TGMl8aK+iTWhdZCAuj2fWevtajYEVRsoOU5LlMMq15dIiUwv92N/GtnqOnFsjg1rFmLGdbaxfLsB7BFdLOJm4DYDjl6/mC9gAmqMQfaWj7YQ6vKavtf5y4M5hEidvpmo9c1zuJx+M2pz2Oc5yTK/H/RDXO+ywLNmy9JT1Pq6Oz8pFSVHjXI5DcJFIa97nt90AKEQgOX6wRUPfTSgVAVqaOdyOl6QN9OpHvy3rR1PGVA24L8VD8fM5cGEV0VyrD8EK+ClvQds9RYep5DnYZyjxOYYynUV9pYcnT1LdvAxdKjZJBiYiwQ/hiiBAujq/w5MS64LP12Aigv+oTSYPGzDWieS9zc4gJ8okrqKe7tKFeEYhPzLgKF5kc9EZVNAWJN5n8rMUsRsZYq0zL1xJhfGWvLClKfexsC7P0NjOBWmpFvnKNXyV0SeFYeozshknc+JYX6VTYCHJ1HA2cn65wi1zD2u2HePfxp07TAtXPjrZZnOF8xOsualVzBaCe4E47RiOmzOd0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(26005)(64756008)(6506007)(316002)(53546011)(66446008)(66476007)(66556008)(66946007)(5660300002)(52536014)(54906003)(7696005)(83380400001)(186003)(76116006)(110136005)(9686003)(55016002)(71200400001)(478600001)(8936002)(86362001)(2906002)(33656002)(4326008)(66574015)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?VFpzRDR2U1QzdytkbnVrYWl6V0kzRDE5ZFZrMEhoV0V6QXROUURpTEJUSnVW?=
 =?utf-8?B?ZXNZbkFLR2tKTytKa0pjZXZsMnVWZy9KbW90MUN4cXd6RFpLalFQMHczNnBX?=
 =?utf-8?B?bFVJYzhvZFNJS1pNaDNKRlo0QnhSZ0VLcW1jMlljU3hodnAzekhLMHZXQThP?=
 =?utf-8?B?QUJvclJhUUxSTkwxM2xBc2FNSmFmb3hlV0ExWFA4NWxQY2xVQ0hEV05LOHBj?=
 =?utf-8?B?RGxyTzRyT2hKN3dwWDFHekNsZUVNTmdiY3hNZERWMnI0Q0xaZTBuZTRxZVQ0?=
 =?utf-8?B?VDhOcm9DRE5YL2QzS2lUbWRDQTdjTi9QNnRaNkQvVDlkS2ltUmhpdFlWRktD?=
 =?utf-8?B?VG1MLzVMUzZPTGZLRStlMFFKbnpzQTdzblNnTmRxVTFjUTY4aldDVWFhQjBz?=
 =?utf-8?B?amxubEorZ2dwVEdBVlp4TDRpREFFT0dwWWdBZnUwbHA4T0FzMG01NXhva04x?=
 =?utf-8?B?TnJzYXhqTmRSbzdVVldueXNteDJ6cnQ0Vkg0UWpWSWVHbnhsR3pmQnhvOUJV?=
 =?utf-8?B?bmtmOC9qcno4RjRhMW9PM0s1QWJpVUtUNks4YVByS2VNbVFsM3lBZ2tia3ox?=
 =?utf-8?B?b0dJTkNwT0dKU2JkbzlEVkVubEJHc1ZWK0NyaW9acVdmYWZoUWV5V0tycUxp?=
 =?utf-8?B?Lys2U1plYWJFZVJXdzRHNG1sdzFFZXM5RnFSOWVGNUxMay92VHBuMTNMZ0Rj?=
 =?utf-8?B?K0d2TFA0TVhNNVk1Rlg1TmdPNzJXd2RRUjM4Vkl4VkVyNHRtN2FIT2pzTE5R?=
 =?utf-8?B?MFlIajlZNDMvVm45dy9iUC9lc2xKNU42b1doVUZkeFlUMEZkckNnOHZld2V5?=
 =?utf-8?B?cVAwc0tRZERaa1dBaStBSkplcE00SWNOSUFoeE5Cem9iMmsvRllvQTNxMW9o?=
 =?utf-8?B?d0gwYi85V3l0R1ZyNHZvaTZuSkhnTG9yeWYvekwrMnRxQ0xIL0hnVlIzWCto?=
 =?utf-8?B?TGtleG41QnJ6NWxJUklBUDJjQnNZWmlhVXptSjRZcUZYemNCV042U285MlhE?=
 =?utf-8?B?N2l5aWhDRjVKL3hPcEk4N3JEeGpUU2I2dHVoYWt3clJhRDhaV0JvN3ZGMDMw?=
 =?utf-8?B?dllWdnZrYnY5WXR5b0pwVnQwNjREZUprSDRKYmdlRFl2TU1PRkRxZTZlcC9i?=
 =?utf-8?B?SUZUek9PT1hnYU95SGlvSVMrVU13aitmdC9PNlhmUGg3SVR6Mmc1Mk9NV2Ew?=
 =?utf-8?B?S2hLbHVHTVI4b3pDNlBobWRhaHRxeEh4OXIvdVFNK0hieHc0SFg2cDlPTi8x?=
 =?utf-8?B?N2t5OTNVWUdPNmd2RUJId1AxUnljQzBQVCt5dVBURzR2Rm1GRW8rbzI0TDBI?=
 =?utf-8?B?cnEzWEFGM3lyUkd5K01Hb05sQVZpZXRwK3YyUXZibHpWWmF0ZTc2S1pMdmNy?=
 =?utf-8?B?d2FYMFlkVHBPM3VoWGhIM3ZLWm1aMEQ3MkllNndFakxqUVZSWWM4MDdpRkdM?=
 =?utf-8?Q?3qAvkT3F?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7987d8c9-c234-4d7e-d7a9-08d8c2963b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 07:36:16.7327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60e5QvnTdkIqROx/agyAPNTfTWfEOGPHw5RYfo0tNtkeJo/uM7czsfvo0nBC3StlV3fcReDs2di1i/avCpgZlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IDIwMjHlubQx5pyIMjHml6UgMjE6MjYN
Cj4gVG86IFdhbmcsIFhpYW9sZWkgPFhpYW9sZWkuV2FuZ0B3aW5kcml2ZXIuY29tPjsgRmFiaW8g
RXN0ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPjsgQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBu
eHAuY29tPg0KPiBDYzogUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz47IExlZSBKb25lcyA8
bGVlLmpvbmVzQGxpbmFyby5vcmc+Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBMaW51
eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IGNvcmU6IEFwcGx5IHRyaW0gYnJva2VuIHF1aXJr
IHRvIFIxSjU3TA0KPiANCj4gKyBGYWJpbywgSGFpYm8NCj4gDQo+IE9uIFRodSwgMjEgSmFuIDIw
MjEgYXQgMTA6NTQsIFdhbmcsIFhpYW9sZWkgPFhpYW9sZWkuV2FuZ0B3aW5kcml2ZXIuY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IEhpDQo+ID4NCj4gPiA+QXJlIHlvdSBzdXJlIHRoaXMgaXMgYW4g
ZU1NQyBwcm9ibGVtIGFuZCBub3QgYSBtbWMgaG9zdCBkcml2ZXIgaXNzdWU/DQo+ID4NCj4gPiA+
Q2FuIHlvdSBlbGFib3JhdGUgbW9yZSB3aGF0IGhhcHBlbnM/DQo+ID4NCj4gPiBXaGVuIEkgdXNl
IHRoZSBta2ZzLmYyZnMgdG9vbCB0byBmb3JtYXQgdGhlIGVNTUMgZmlsZSBzeXN0ZW0gb24gdGhl
DQo+ID4gaW14OHF4cCBib2FyZCwgYmVjYXVzZSBta2ZzLmYyZnMgd2lsbCB1c2Ugc2VjZGlzY2Fy
ZCBmaXJzdCwgd2hlbg0KPiA+IGVudGVyaW5nIG1tY19ibGtfaXNzdWVfc2VjZGlzY2FyZF9ycSBl
cmFzZSwgb25jZSB0aGUgcGFyYW1ldGVycyBhcmUNCj4gcGFzc2VkIGludG8gTU1DX1NFQ1VSRV9U
UklNMV9BUkcsIHRoaXMgZnVuY3Rpb24gd2lsbCB0YWtlIGEgbG9uZyB0aW1lIHRvDQo+IHJldHVy
biAuDQo+ID4gVGhlIHByb2dyYW0gaGFzIG5vdCBlbmRlZCwgaGFzIGJlZW4gaW4gVEFTS19VTklO
VEVSUlVQVElCTEUgc3RhdGUuDQo+ID4NCj4gPiBJIGNvbXBhcmVkIHRoZSBta2ZzLmV4dDQgdG9v
bCB0byBmb3JtYXQgdGhlIGZpbGUgc3lzdGVtLiBCZWNhdXNlIGl0DQo+ID4gZGlyZWN0bHkgdXNl
cyBtbWNfYmxrX2lzc3VlX2Rpc2NhcmRfcnEsIHRoaXMgaXMgYSBub3JtYWwgZm9ybWF0dGluZw0K
PiBwaGVub21lbm9uLg0KPiA+DQo+ID4gbW1jX2Jsa19pc3N1ZV9zZWNkaXNjYXJkX3JxIGFuZCBt
bWNfYmxrX2lzc3VlX2Rpc2NhcmRfcnEgYXJlIGp1c3QNCj4gZGlmZmVyZW50IGNvbW1hbmRzIGFu
ZCBwYXJhbWV0ZXJzIHNlbnQgYnkgdGhlIGhvc3QgYXMgYSBidXMuDQo+ID4gIEkgZGlkIG5vdCBz
ZWUgdGhlIGRlc2NyaXB0aW9uIG9mIHRyaW0gaW4gdGhlIGRhdGEgc2hlZXQuIENvdWxkIHRoZSBo
b3N0IGRyaXZlcg0KPiBjYXVzZSB0aGlzIHByb2JsZW0/DQo+IA0KPiBZZXMsIGl0IGNhbiAtIGFu
ZCB3ZSBoYXZlIGhhZCBpc3N1ZXMgbGlrZSB0aGVzZSBiZWZvcmUuIFNvIGJlZm9yZSBhZGRpbmcg
YSBjYXJkDQo+IHF1aXJrLCBJIHRoaW5rIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRoaXMgaXNuJ3Qg
dGhlIGNhc2UuDQo+IA0KPiBXaGVuIHVzaW5nIE1NQ19TRUNVUkVfVFJJTTFfQVJHLCBpdCdzIHZl
cnkgbGlrZWx5IHRoYXQgdGhlIHJlcXVlc3QgdGFrZXMNCj4gbG9uZ2VyIHRvIGNvbXBsZXRlLg0K
PiANCj4gVGhlIG1tYyBob3N0IGlzIHJlc3BvbnNpYmxlIGZvciBlaXRoZXIgZGVhbGluZyB3aXRo
IGJ1c3kgZGV0ZWN0aW9uIHdpdGggdGhlDQo+IGhlbHAgb2YgaXRzIEhXL2NvbnRyb2xsZXIgLSBv
ciBpZiB0aGF0IGNhbid0IGJlIHN1cHBvcnRlZCwgdGhlIG1tYyBjb3JlIGZhbGxzIGJhY2sNCj4g
dG8gcG9sbGluZyB0aGUgY2FyZCBmb3IgYnVzeSB3aXRoIGEgQ01EMTMuDQo+IA0KPiBTZWUgbW1j
X2RvX2VyYXNlKCkgaW4gL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+IA0KPiA+DQo+ID4gTm90
ZToNCj4gPiBUaGUgaG9zdCBkcml2ZXIgSSB1c2UgaXMgc2RoY2ktZXNkaGMtaW14LmMNCj4gDQo+
IEFscmlnaHQsIEkgaGF2ZSBsb29wZWQgaW4gRmFiaW8gYW5kIEhhaWJvIHRoYXQga25vd3MgdGhp
cyBkcml2ZXIsIGxldCdzIHNlZSBpZiB0aGV5DQo+IGNhbiBoZWxwLg0KPiANCg0KSGkgVWxmIGFu
ZCBYaWFvbGVpLA0KDQpJIHVzZSB0aGUgbWtmcy5mMmZzIHRvb2wgZm9ybWF0IGEgcGFydGl0aW9u
IG9uIG9uZSBTYW5kaXNrIGVNTUMgY2hpcCBvbiBpbXg4IHBsYXRmb3JtLCBkbyBub3QgbWVldCBp
c3N1ZS4NCkkgYWRkIHNvbWUgbG9nLCBjb25maXJtIG1rZnMuZjJmcyBjYWxsIHRoZSBtbWNfYmxr
X2lzc3VlX3NlY2Rpc2NhcmRfcnEoKSwgYW5kIHRoZSBhcmcgaXMgTU1DX1NFQ1VSRV9UUklNMV9B
UkcuDQpGb3IgdGhlIGJ1c3kgZGV0ZWN0aW9uLCBpbXggdXNkaGMgaGFzIG9uZSByZWdpc3RlciBi
aXQgcmVwcmVzZW50IHRoZSBkYXQwIHNpZ25hbCBsZXZlbC4gU28gZm9yIHlvdXIgbW1jIGRldmlj
ZSwgaXQgc2hvdWxkIGJlIHRoZSBtbWMgZGV2aWNlIHRyaW0gZmVhdHVyZSBwcm9ibGVtLg0KDQpC
ZXN0IFJlZ2FyZHMNCkhhaWJvDQo+ID4NCj4gPiBUaGFua3MNCj4gPiBYaWFvbGVpDQo+IA0KPiBL
aW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCj4gPg0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+ID4gRnJvbTogVWxmIEhhbnNzb24gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+DQo+ID4g
U2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDIwLCAyMDIxIDk6NDEgUE0NCj4gPiBUbzogV2FuZywg
WGlhb2xlaSA8WGlhb2xlaS5XYW5nQHdpbmRyaXZlci5jb20+DQo+ID4gQ2M6IFBhbGkgUm9ow6Fy
IDxwYWxpQGtlcm5lbC5vcmc+OyBMZWUgSm9uZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPjsNCj4g
PiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+
ID4gPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+ID4gU3ViamVjdDogUmU6IFtQQVRD
SF0gbW1jOiBjb3JlOiBBcHBseSB0cmltIGJyb2tlbiBxdWlyayB0byBSMUo1N0wNCj4gPg0KPiA+
IFtQbGVhc2Ugbm90ZSB0aGlzIGUtbWFpbCBpcyBmcm9tIGFuIEVYVEVSTkFMIGUtbWFpbCBhZGRy
ZXNzXQ0KPiA+DQo+ID4gT24gTW9uLCAxOCBKYW4gMjAyMSBhdCAwNToyNywgWGlhb2xlaSBXYW5n
IDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gUjFK
NTdMIG1tYyBjaGlwIGh3IGNhcGliaWxpdHkgaW5kaWNhdGVzIHRoYXQgaXQgc3VwcG9ydHMgdHJp
bQ0KPiA+ID4gZnVuY3Rpb24sIGJ1dCB0aGlzIGZ1bmN0aW9uIGRvZXMgbm90IHdvcmsgcHJvcGVy
bHksIHRoZSBTRElPIGJ1cw0KPiA+ID4gZG9lcyBub3QgcmVzcG9uZCwgYW5kIHRoZSBJTyBoYXMg
YmVlbiB3YWl0aW5nIHNvIHNldCBxdWlya3MgdG8gc2tpcA0KPiA+ID4gdHJpbQ0KPiA+DQo+ID4g
QXJlIHlvdSBzdXJlIHRoaXMgaXMgYW4gZU1NQyBwcm9ibGVtIGFuZCBub3QgYSBtbWMgaG9zdCBk
cml2ZXIgaXNzdWU/DQo+ID4NCj4gPiBDYW4geW91IGVsYWJvcmF0ZSBtb3JlIHdoYXQgaGFwcGVu
cz8NCj4gPg0KPiA+IEtpbmQgcmVnYXJkcw0KPiA+IFVmZmUNCj4gPg0KPiA+ID4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFhpYW9sZWkgV2FuZyA8eGlhb2xlaS53YW5nQHdpbmRyaXZlci5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIHwgNCArKysrDQo+ID4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oIGIvZHJpdmVycy9tbWMvY29yZS9xdWlya3Mu
aA0KPiA+ID4gaW5kZXggZDY4ZTZlNTEzYTRmLi42M2UwMjM5MWMxMzMgMTAwNjQ0DQo+ID4gPiAt
LS0gYS9kcml2ZXJzL21tYy9jb3JlL3F1aXJrcy5oDQo+ID4gPiArKysgYi9kcml2ZXJzL21tYy9j
b3JlL3F1aXJrcy5oDQo+ID4gPiBAQCAtODksNiArODksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IG1tY19maXh1cCBfX21heWJlX3VudXNlZA0KPiBtbWNfYmxrX2ZpeHVwc1tdID0gew0KPiA+ID4g
ICAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1NFQ19FUkFTRV9UUklNX0JST0tFTiksDQo+ID4g
PiAgICAgICAgIE1NQ19GSVhVUCgiVlpMMDBNIiwgQ0lEX01BTkZJRF9TQU1TVU5HLA0KPiBDSURf
T0VNSURfQU5ZLCBhZGRfcXVpcmtfbW1jLA0KPiA+ID4gICAgICAgICAgICAgICAgICAgTU1DX1FV
SVJLX1NFQ19FUkFTRV9UUklNX0JST0tFTiksDQo+ID4gPiArICAgICAgIE1NQ19GSVhVUCgiUjFK
NTdMIiwgQ0lEX01BTkZJRF9NSUNST04sDQo+IENJRF9PRU1JRF9BTlksIGFkZF9xdWlya19tbWMs
DQo+ID4gPiArICAgICAgICAgICAgICAgICBNTUNfUVVJUktfU0VDX0VSQVNFX1RSSU1fQlJPS0VO
KSwNCj4gPiA+DQo+ID4gPiAgICAgICAgIC8qDQo+ID4gPiAgICAgICAgICAqICBPbiBTb21lIEtp
bmdzdG9uIGVNTUNzLCBwZXJmb3JtaW5nIHRyaW0gY2FuIHJlc3VsdCBpbg0KPiBAQA0KPiA+ID4g
LTk4LDYgKzEwMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbW1jX2ZpeHVwIF9fbWF5YmVfdW51
c2VkDQo+IG1tY19ibGtfZml4dXBzW10gPSB7DQo+ID4gPiAgICAgICAgICAgICAgICAgICBNTUNf
UVVJUktfVFJJTV9CUk9LRU4pLA0KPiA+ID4gICAgICAgICBNTUNfRklYVVAoIlYxMDAxNiIsIENJ
RF9NQU5GSURfS0lOR1NUT04sDQo+IENJRF9PRU1JRF9BTlksIGFkZF9xdWlya19tbWMsDQo+ID4g
PiAgICAgICAgICAgICAgICAgICBNTUNfUVVJUktfVFJJTV9CUk9LRU4pLA0KPiA+ID4gKyAgICAg
ICBNTUNfRklYVVAoIlIxSjU3TCIsIENJRF9NQU5GSURfTUlDUk9OLA0KPiBDSURfT0VNSURfQU5Z
LCBhZGRfcXVpcmtfbW1jLA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1RSSU1f
QlJPS0VOKSwNCj4gPiA+DQo+ID4gPiAgICAgICAgIEVORF9GSVhVUA0KPiA+ID4gIH07DQo+ID4g
PiAtLQ0KPiA+ID4gMi4yNS4xDQo+ID4gPg0K
