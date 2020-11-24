Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9497C2D0E4
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 07:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405392080A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 07:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y06FOM6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbgKXHCP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 02:02:15 -0500
Received: from mail-db8eur05on2085.outbound.protection.outlook.com ([40.107.20.85]:50177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729881AbgKXHCN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Nov 2020 02:02:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0D0Io+Iudiic3vCmen87rU08VzdkDT7iGFJRZ+Cjwx5fsHKUo2+PMg4mFzHZYiwOQEb2CpUlhrmEYrMMQZFu8jDseMmMz6HUZ/9q37B+XqnubCUdpUaCaWk+FlhAh4gZA7zQ1+47+ktFecxXDEFv7CujafeYxGPSwf3PZXXWLZrIqXm6rz4g2PtCiJbnA/NhaRmqpFDwEmXUMFhGmgNsoh09WVvH2QecAeGj+0ZaXpKxlaaNfgL7Cjq3KDJeL23g8DdHXKjzTdvSS+Q2PMp4NYT9SS+o6Q0/HbupEYIp/oA7y4rFwlA6Ge2LV3+3uqyIC6eaJ0P1RJ9dJGXXj9otw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxPkG+eCYeC97H/F7/CG4e9YLb5kHMF3qWQZ8OV6Law=;
 b=LcJtF5Y++6+Wi9KKz3+UHu+3TifSk4JvAwGdjXBb2AlTKCQ0hwwNBEN7QtG0WdwRB78ztOFx1uhpXMbjhkn7+OkWd09CfEFb7GK8r+0hjR/siaJOBzuYfgcpRsxEQdVHmPPX8WWRce4Oy/zF0RHnu66iBRFYxWIKlB+XXcTQLORxlEko3sItx6y54PpFrn9Axny9EoQUrs+wLNAUM/RkWATG3O0n/rYt3rQrVv+DWS8Glm8eqZoCPz/NzcpjTfpppMEoz+jdzh6srwnN8kNKH4M+aVjbjTxhcXaUoKLaHbIWCSIOW2+9aHSmrOeia/PtXPW+aGvKsSsAYaLde33SGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxPkG+eCYeC97H/F7/CG4e9YLb5kHMF3qWQZ8OV6Law=;
 b=Y06FOM6FwtlU/6RtRvlCid3oL0CR7fEMYCfnzQWIdgQ5MZi6ftLp01ZzSKEV3inhibPfS1DsZSvZjIxfAaKwJKOPS9royOajlx/+JaFYH8bwyorA/vPM6TgDzqCqVbRDjhRcZPpzK3wjXz5pO4QpnGkb3m8Y2EmE0PjEoquXH2k=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR04MB5720.eurprd04.prod.outlook.com (2603:10a6:20b:a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Tue, 24 Nov
 2020 07:02:08 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::3cfc:a92e:75ad:ce4a%3]) with mapi id 15.20.3564.029; Tue, 24 Nov 2020
 07:02:08 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped imx8qm
 compatible string
Thread-Topic: [PATCH 1/3] dt-bindings: mmc: imx: fix the wrongly dropped
 imx8qm compatible string
Thread-Index: AQHWvnVQV1Aj3wHjWke7zj9d0oe5panPb7MAgAAikqCAAAFEgIAGF8eAgAE27CA=
Date:   Tue, 24 Nov 2020 07:02:08 +0000
Message-ID: <AM6PR04MB4966C95A3F7ADE1CC047B66A80FB0@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <20201119125304.1279-1-aisheng.dong@nxp.com>
 <20201119131720.GA348129@kozik-lap>
 <AM6PR04MB49666B9100F4CE87E1AE23D680E00@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <20201119152535.GA386850@kozik-lap>
 <CAPDyKFojf65BA40Ju3s8voOwHT0NU2wpcrnHuCfGrjPQMFwMKw@mail.gmail.com>
In-Reply-To: <CAPDyKFojf65BA40Ju3s8voOwHT0NU2wpcrnHuCfGrjPQMFwMKw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c36c8e66-2e00-441d-cc88-08d89046dbf7
x-ms-traffictypediagnostic: AM6PR04MB5720:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB5720D66F8E1767060634FFFC80FB0@AM6PR04MB5720.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nwEg8HjyReX4RB9r+FemqjWgMUOX7z3jHc3gGhq1UfFDG51zYoY/ukfBR1D+rGwy3rAw0fLWEMtN9RetFyP4Hyfr6jD1SkCe3tE3OGnnot/dTihoGg4K+QHeJnvNiKKY+7sKVCg5RoF95rvqIL+urJFD+zxS/jgI+v638ZHEI6uKhJvhq8iEw8ht5HbAtnE2Xup/z7homC21O1LoSbCIHtbNB8K5nD1mga0Qb7VPN3D1TfUPzv93xJrc6vaq5bYFgIm/ijn0dvV9dy85q83IlrsWMy9rBFNT/hp8UT+/XQA0LzMQCtOe/y/JWRtiRM9BskVrbnDfSplWhGA+jl+th8/VktenyaHPeLvL+r+HRVC+4pMYi3hjukasi12wZOlJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(76116006)(66946007)(52536014)(5660300002)(64756008)(8936002)(71200400001)(2906002)(26005)(7696005)(66556008)(33656002)(8676002)(6506007)(478600001)(86362001)(66446008)(186003)(9686003)(66476007)(4326008)(55016002)(54906003)(110136005)(316002)(83380400001)(44832011)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: VwPZbZD3zaejN9d6zoASR3n3UQT1WwgJ4RgCkvFE12xWrxx076k6xtkW0WymUrhrXHbNTRwYL1yzDafvsA6t6ZTxV+V0z8qgjgc/Uxdc36Xm5SmWiZelOPsb23bqUUgS0HJ40ocSNlNtujUIwTQf0bPcwyTqNZ7TlBddLlt09mf4+k02sYQes6ESo69Lfp7PHREQ9iLLegLV84UC7Fjqbi3sLMZLHaS1SUTAtwLgc1nxxpt4SJI12Uknx4PFsPfDCBvJXF4FbuMW3DlurzgPTQakCZ9t+kJyxv2Izuc8c171OgVHTsVOonalbRyJSP6D2Byx2bWCSw8MjogQj78QlxWMI0W+gtQRhRmVIGcuViSajphtQSgyiS4GBCEslC5tBcHuAW7YNRJLcjHZZ5pJBxDAyPd/Y4WiSO0617628y07qUdIzIm6tIJZP4lx/25rEapsOFFEhRidR4HGDbAPjZRgiOR6LrP+4Xi+ZNSet5UGpD4jvhCKfhaOTwHXGXRz1JkNoB/CxPDsEF3Y49V+/RX/BCaEmFdxqbP+5jHmmK7QoqK5o0w0YfjIYRxsled/WpO0v+wIjberFbxMBuFGmpI2cYID93ib5Py7qsClV0Kc+jkRoJvuEyU2GuRQqMMq2A2QAyf8c7UsOOAoq2U56rylhLMl3qxBjzmIVG7EJB+KhVD01OpYu/odfNqapP+iGkiCE5F/7IIvXnw5cwqE7xqhqV7NE/33mkmlfdKgFmlHxv/PfCcR55AHBVX5fI2KLb9hBuUxa+5LJA6V++bYe9L7y8YlK5LN5m0AsT3PsmecA5O8Ymtubzj0tpJ5xGskErOIFP5s7zUuYtew4cI14rRu3Fmp5N+PUChu83edA5eA+l5gbVbMZeIb2BL3kuvUbUjeT4uOkrkYndt7hkxVZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c8e66-2e00-441d-cc88-08d89046dbf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 07:02:08.4276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eS0D1MHJfUknEDQDtV/FqM6T/Rlmk6MIlNtphqw5sQ0ZXUYToNh9h76k07fsSf4zGpnjIlndLRjTVVTGJc71qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5720
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogTW9u
ZGF5LCBOb3ZlbWJlciAyMywgMjAyMCA4OjI4IFBNDQo+IA0KPiBPbiBUaHUsIDE5IE5vdiAyMDIw
IGF0IDE2OjI1LCBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+IHdyb3RlOg0K
PiA+DQo+ID4gT24gVGh1LCBOb3YgMTksIDIwMjAgYXQgMDM6MjE6NTlQTSArMDAwMCwgQWlzaGVu
ZyBEb25nIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtl
cm5lbC5vcmc+DQo+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAxOSwgMjAyMCA5OjE3
IFBNDQo+ID4gPiA+DQo+ID4gPiA+IE9uIFRodSwgTm92IDE5LCAyMDIwIGF0IDA4OjUzOjAyUE0g
KzA4MDAsIERvbmcgQWlzaGVuZyB3cm90ZToNCj4gPiA+ID4gPiBUaGUgY29tcGF0aWJsZSBzdHJp
bmcgImZzbCxpbXg4cW0tdXNkaGMiIHdhcyB3cm9uZ2x5IGRyb3BwZWQgaW4NCj4gcGF0Y2g6DQo+
ID4gPiA+ID4gODBmZDM1MGI5NTkwICgiZHQtYmluZGluZ3M6IG1tYzogZnNsLWlteC1lc2RoYzog
Rml4IGkuTVggOA0KPiA+ID4gPiA+IGNvbXBhdGlibGUNCj4gPiA+ID4gPiBtYXRjaGluZyIpIEFk
ZCBpdCBiYWNrLg0KPiA+ID4gPg0KPiA+ID4gPiBBbHRob3VnaCB0aGUgY29tcGF0aWJsZSB3YXMg
ZHJvcHBlZCwgYnkgd2h5IHdyb25nbHk/IFBsZWFzZSBkZXNjcmliZSBpdC4NCj4gPiA+ID4gVGhl
IGNvbXBhdGlibGUgaXMgbm93aGVyZSB0byBiZSBmb3VuZCwgaXQgaXMgbm90IHVzZWQuDQo+ID4g
Pg0KPiA+ID4gVGhlIERUIHBhdGNoIHVzaW5nIGl0IGlzIHN0aWxsIHVuZGVyIHJldmlldy4gU28g
d2UgbmVlZCBpdC4NCj4gDQo+IFdoZXJlPyBJcyB0aGVyZSBhIGNvcnJlc3BvbmRpbmcgdXBkYXRl
IHRvIHRoZSBtbWMgZHJpdmVyPw0KPiANCj4gPg0KPiA+IEl0IGxvb2tzIGxpa2Ugb3RoZXIgcGF0
Y2hlcyBoZXJlIGZvbGxvdyBzaW1pbGFyIHByb2Nlc3Mgb2Ygc2VuZGluZyBhbmQNCj4gPiBhcHBs
eWluZyBkdC1iaW5kaW5ncyBzZXBhcmF0ZWx5IGZyb20gcGF0Y2hlcyB3aXRoIHVzZXJzIG9mIHRo
ZXNlDQo+ID4gYmluZGluZ3MuIFBsZWFzZSBkb24ndCBkbyBpdCBsaWtlIHRoaXMuIFNlbmQgdGhl
IGJpbmRpbmdzIGFzIHRoZSBmaXJzdA0KPiA+IHBhdGNoIGluIHRoZSBzZXJpZXMgaW1wbGVtZW50
aW5nIHRoZSB1c2VycyAoc28gdXN1YWxseSB0aGUgc2VyaWVzIHdpdGgNCj4gPiBkcml2ZXIgYW5k
IERUUyBjaGFuZ2VzKS4gVGhlIG5ldyBiaW5kaW5ncyB0aGVuIGFyZSBhcHBsaWVkIGJ5IHRoZQ0K
PiA+IGRyaXZlciBzdWJzeXN0ZW0gbWFpbnRhaW5lci4NCj4gDQo+IFllcCwgSSBmdWxseSBhZ3Jl
ZSwgdGhhdCdzIHRoZSBwcmVmZXJyZWQgYXBwcm9hY2guDQo+IA0KPiBQZXJoYXBzIGl0J3Mgc2lt
cGx5IGJldHRlciBpZiB0aGUgc2VyaWVzIGlzIHJlcG9zdGVkIHRvIGxpbnV4LW1tYyAoaW5jbHVk
aW5nIHRoZSBEVA0KPiBkb2MpLg0KDQpJJ20gZ29pbmcgdG8gcmVzZW5kIHRoZSBzZXJpZXMgd2l0
aCBkdC1iaW5kaW5nIHBhdGNoZXMgZmlyc3QuDQpUaGFua3MgZm9yIHRoZSBhZHZpY2UuDQoNClJl
Z2FyZHMNCkFpc2hlbmcNCg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
