Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A81C433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB57229C6
	for <linux-mmc@archiver.kernel.org>; Mon, 25 Jan 2021 12:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbhAYMRQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 Jan 2021 07:17:16 -0500
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:25654
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727903AbhAYMQE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 25 Jan 2021 07:16:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQjUEOmYkc4LtLEWVFglguCTQzqJgjfIT7SXd9JQTR6PULDURF7Gdtof+nO5UDjYeMAJ07abBOFyUcU6GatecGz7v4pEgNUMb/NJNDnV28SuLwc7hoUJmFkt2oZ43T+QMStL4Hs6aFDg4zivQCIzhqYd8lNp3qQnldutcQGJAb7F4jhemQRDCUywnzUuuG46Uu2ziPKEf+06E46rXd+nJ4NVrQKYxmFhJdlBolZAwkXNACueEeWenIvJWUmQ8/OQ7ijqS48A2rR7q0DHcS0pXAvXdvixZ+OZL9j/+d5+GjtwxZR2+IEPTjZXhSGYM3t9Pj9RSNKl4iCAxQs3wQIowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQzeqL0OaecpJdzhWh+dvCt260XVUuxum/XvhdxCM6c=;
 b=jnKPCFg+KkeM8X+dgeRxzL4vtDxeD8OO9mV+PriMhylUSn8nbXIbdaNylSf+zjN3vPpmFXzkDgTj0LJXS6xaere0eai5XcjbN59pn0mRngt+H6yWW0piZ/V6slNrtmxEZ237NHcp+zJtHyn9SBn+syDp7kcGRh5VlJ5J/N2qexZPu5Q85zXMkmUgEhWKF+d20RkEXk67TIQRbzTqNTbnu706NLnGiclkwH8rnCxpe0X9qZxtXZU1I42NQ/qy9oQRM0nWb3Xk3NAogXnkhpo5i5uh9vf981uXhTAfLYc3nXXwF7DBUI/SwfyIoigMTjmH8r+DRQDhXVls84NrJOt8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQzeqL0OaecpJdzhWh+dvCt260XVUuxum/XvhdxCM6c=;
 b=SuC7V0Oyqlh8YZvjvyjyr3NRRUkOsn2+ugNm27Mqw0AeM40Ft2U8Q6FRmnAJFYGrY+bOqYp3aihhsUV1X9nCRMmJp9gyPb6n63kR0LfEuox1iXi2hldV11loUGfCc0XU9Sts0tCs/RoBnXa/1BS7JB0a2IuBkILAIAdz6vWqezA=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3406.eurprd04.prod.outlook.com (2603:10a6:803:c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Mon, 25 Jan
 2021 11:34:45 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::9118:46d6:d36e:27b6]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::9118:46d6:d36e:27b6%5]) with mapi id 15.20.3784.015; Mon, 25 Jan 2021
 11:34:45 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "Wang, Xiaolei" <Xiaolei.Wang@windriver.com>,
        =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Topic: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Thread-Index: AQHW7VKKjN2CkSEiwk6wXCAUqn5gWaowiQqAgAFTA4CAADstgIAGHPGAgAAMynA=
Date:   Mon, 25 Jan 2021 11:34:45 +0000
Message-ID: <VI1PR04MB52946B4A7CCB0651230633AB90BD0@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
 <CAPDyKFq+qyuHGbduGp30AeLefN1ie9ZL2Bvm9PrPZUwmdfQeYg@mail.gmail.com>
 <PH0PR11MB507708B2E5662DC2F6E649B195A19@PH0PR11MB5077.namprd11.prod.outlook.com>
 <CAPDyKFq1TcV-GCknCFVKjVgtqQZ3vZJc3PgSzb=UrzDdKnCvZw@mail.gmail.com>
 <CAOMZO5CFMT-OPX-3p5n6BEanPbyitz7Ng4s5PFN=k+cnsgpg7A@mail.gmail.com>
In-Reply-To: <CAOMZO5CFMT-OPX-3p5n6BEanPbyitz7Ng4s5PFN=k+cnsgpg7A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fe1468fa-d697-4718-140e-08d8c1253720
x-ms-traffictypediagnostic: VI1PR0402MB3406:
x-microsoft-antispam-prvs: <VI1PR0402MB34068647DF03343AFEDCA32790BD0@VI1PR0402MB3406.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fdFtRemSF9NZYvZrRLVBObpw+WDfqcIvHBmLF5jQ784KYiK9V195hom4rKHiyQlYpY3OQdfllqHs4LH0t8nqjZTvPeICSl6q6D8tnqaLRI/uVV2vFx5AT7UxaFgh/aTKwH/YuKiMsP4kSo+tAF4P8X3ax+rehFPIWnhFX9PcZJsogHzTdD48xb1MiWbMyHWuOpbE8bcf9wOf+0/rFBVLDlu206d/N6VrBL3RC0XL4WIM+zCN1sa/5/4K42oSqR6gq1xTmAHXZp7YJM3iKydfUVfDoT0Uasrff251mC6loeInP/umAFK2naWjzq4rg0EqMNbE6SdBrLpoOEdO5QYOAClG/Uq1KJBFzDGGB/Z1FuVZUVpA7wr3IwsWG0WnPPphosRJF6qZyOHIyBgbPZ/xfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(66574015)(33656002)(186003)(71200400001)(66446008)(66556008)(6506007)(110136005)(4326008)(54906003)(2906002)(316002)(64756008)(5660300002)(53546011)(478600001)(7696005)(8676002)(83380400001)(26005)(9686003)(66946007)(86362001)(55016002)(66476007)(76116006)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SS8rSEo1em5LYkVGZEVqV1BueUNHZ1dQUDZac1NDNUFFUnBRU3VvK0RjK0Jp?=
 =?utf-8?B?cVBIeTNyLzNzUkZ5ampHNU8zUzYvVkp2YTBlbEhSdGljd3JNN2x6QlZiUlJV?=
 =?utf-8?B?VVRIMkZOZmU0OXE4alc2Rm5zanhrSFJGbDR5WEorWWJmSlpTSnpsbTJuZEU2?=
 =?utf-8?B?d01Pbk0xdVJaWHByTHM4WEZFb3BKcXZ3bXovc2VwMkQvUVVtdDBha01WbGVp?=
 =?utf-8?B?S1NxbU14bUgrekkyUmNZcDl1SldNSnY0Ums5WjhNMkVRcXZlR3M5N2d4ZzNa?=
 =?utf-8?B?RFQ4M1NhY1hNUnJoR3AwYXRWTzVaVDA0alNIM1lsSm03NGpmWlJLVVd5SUlJ?=
 =?utf-8?B?K0FJbEMwbit2V3MwaDBONk91eHdGYlhXbG93a3p6cC9WY0xlSFdCYWZOdkNq?=
 =?utf-8?B?cnpQQ04zY3A0cTFPeWlSQk0yMnNqMFVsTXhlb2xIQUJSYmxXV0QyVUt3eVBj?=
 =?utf-8?B?OTNCeGx0UlNyekZWVHpvNHJrbUJuMGxXL0U3RXZrZ0VjaHdkZXhJZVJyZDNI?=
 =?utf-8?B?SUFpV2liaHVPRGRXZkY4dnQ2dytOc3EzVWdMWXlQSklRWXh0WjRUMWNRbEw3?=
 =?utf-8?B?Nk03Y29LTi81TVVZRmJ2MWozNSt5UHBGZVlVZTVpQnErMEh4dGRmdGhacFoy?=
 =?utf-8?B?UzNJRmV2dnJnK3poVWpSY1VVVG5mdWJtWXJITEZwRW9xS2ppV3g0bGVUMWRY?=
 =?utf-8?B?SGJlc1MzOGl3RkNVUzl3YXU1RWtKRVhWeVlKM09zYW5SeTVrM0h4ZW5GV0Ju?=
 =?utf-8?B?Q0hCdXAvMzVNNjZUUmF3TEdDaGVWSXdzdUxTUXlBd1FOaTRuSG5BNGZMSkdK?=
 =?utf-8?B?N3U5Vk5ZQjlPdTFnaDlwanN1MGE5Z29PQURWOElUN1hIVlE2NW14THJibWFa?=
 =?utf-8?B?Mm1hMFE1NzhUQVlKNzBTVEdsdU1IK2JJb1pOWDcyTDRBdVBiUFRPek1ZSzZj?=
 =?utf-8?B?WDBwUlFPcDRYeTJyQXBhSmt0djNaZmNoakwvK00zK1V2YW5lS2l2cU1NWU83?=
 =?utf-8?B?cmFLSlg5L3FrWURnbm9nNTd6a1dEWXlKL0JIMVZxNGN5di85MzA3d0FqTElN?=
 =?utf-8?B?b1dzbVFhdTUyeVE4aWFjcXpPejZZTWt0eS93cWQ2TU5JZTg4dElzSzNlL1ZX?=
 =?utf-8?B?SVJ5YjZNaG1WZ05FamFsRWp0T2R2aUxMNk41K3dNVGJHQVBlaW9YK09sTmxh?=
 =?utf-8?B?OThORG8rd0hROE16K1pIdU1tSnVhZzRPcGtNRnowbGVxRUlSU1BSRUhmZGoz?=
 =?utf-8?B?UkNOWGNtaHJlYzl0ZGUvckVCWVdqNzRYQTFtY3dNNjlScWRaSjhGMExJNEpj?=
 =?utf-8?B?dStNQWNoaTZCdWI3cjdCUGZONEIwRkUzQmMzOWNjK2txSjU5UEZZSlluQ25F?=
 =?utf-8?B?L1E2SkpIVkhBUG5peXFhc1U5ZldTN044MWx1cURuMlBJWnk3WmxXY0VCdzlx?=
 =?utf-8?Q?dA5y30vP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1468fa-d697-4718-140e-08d8c1253720
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2021 11:34:45.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vA0fvXTq9rBXr1USK0CgHsJgiA2uhup1r3aU0dNiXcoVC/Z7U9dXgsC+Vo6ZVMxvFQSC4doWGQbs/duPnB1/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3406
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIFttYWls
dG86ZmVzdGV2YW1AZ21haWwuY29tXQ0KPiBTZW50OiAyMDIx5bm0MeaciDI15pelIDE4OjQ3DQo+
IFRvOiBVbGYgSGFuc3NvbiA8dWxmLmhhbnNzb25AbGluYXJvLm9yZz4NCj4gQ2M6IFdhbmcsIFhp
YW9sZWkgPFhpYW9sZWkuV2FuZ0B3aW5kcml2ZXIuY29tPjsgQm91Z2ggQ2hlbg0KPiA8aGFpYm8u
Y2hlbkBueHAuY29tPjsgUGFsaSBSb2jDoXIgPHBhbGlAa2VybmVsLm9yZz47IExlZSBKb25lcw0K
PiA8bGVlLmpvbmVzQGxpbmFyby5vcmc+OyBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBMaW51
eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6IGNvcmU6IEFwcGx5IHRyaW0gYnJva2VuIHF1aXJr
IHRvIFIxSjU3TA0KPiANCj4gSGkgSGFpYm8sDQo+IA0KPiBDb3VsZCB5b3UgcGxlYXNlIHRha2Ug
YSBsb29rPw0KDQpJIHdpbGwgbG9vayBpbnRvIHRoaXMgaXNzdWUgdGhpcyB3ZWVrLg0KDQpIYWli
byBDaGVuDQo+IA0KPiBUaGFua3MNCj4gDQo+IE9uIFRodSwgSmFuIDIxLCAyMDIxIGF0IDEwOjI2
IEFNIFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gPg0K
PiA+ICsgRmFiaW8sIEhhaWJvDQo+ID4NCj4gPiBPbiBUaHUsIDIxIEphbiAyMDIxIGF0IDEwOjU0
LCBXYW5nLCBYaWFvbGVpIDxYaWFvbGVpLldhbmdAd2luZHJpdmVyLmNvbT4NCj4gd3JvdGU6DQo+
ID4gPg0KPiA+ID4gSGkNCj4gPiA+DQo+ID4gPiA+QXJlIHlvdSBzdXJlIHRoaXMgaXMgYW4gZU1N
QyBwcm9ibGVtIGFuZCBub3QgYSBtbWMgaG9zdCBkcml2ZXIgaXNzdWU/DQo+ID4gPg0KPiA+ID4g
PkNhbiB5b3UgZWxhYm9yYXRlIG1vcmUgd2hhdCBoYXBwZW5zPw0KPiA+ID4NCj4gPiA+IFdoZW4g
SSB1c2UgdGhlIG1rZnMuZjJmcyB0b29sIHRvIGZvcm1hdCB0aGUgZU1NQyBmaWxlIHN5c3RlbSBv
biB0aGUNCj4gPiA+IGlteDhxeHAgYm9hcmQsIGJlY2F1c2UgbWtmcy5mMmZzIHdpbGwgdXNlIHNl
Y2Rpc2NhcmQgZmlyc3QsIHdoZW4NCj4gPiA+IGVudGVyaW5nIG1tY19ibGtfaXNzdWVfc2VjZGlz
Y2FyZF9ycSBlcmFzZSwgb25jZSB0aGUgcGFyYW1ldGVycyBhcmUNCj4gcGFzc2VkIGludG8gTU1D
X1NFQ1VSRV9UUklNMV9BUkcsIHRoaXMgZnVuY3Rpb24gd2lsbCB0YWtlIGEgbG9uZyB0aW1lIHRv
DQo+IHJldHVybiAuDQo+ID4gPiBUaGUgcHJvZ3JhbSBoYXMgbm90IGVuZGVkLCBoYXMgYmVlbiBp
biBUQVNLX1VOSU5URVJSVVBUSUJMRSBzdGF0ZS4NCj4gPiA+DQo+ID4gPiBJIGNvbXBhcmVkIHRo
ZSBta2ZzLmV4dDQgdG9vbCB0byBmb3JtYXQgdGhlIGZpbGUgc3lzdGVtLiBCZWNhdXNlIGl0DQo+
ID4gPiBkaXJlY3RseSB1c2VzIG1tY19ibGtfaXNzdWVfZGlzY2FyZF9ycSwgdGhpcyBpcyBhIG5v
cm1hbCBmb3JtYXR0aW5nDQo+IHBoZW5vbWVub24uDQo+ID4gPg0KPiA+ID4gbW1jX2Jsa19pc3N1
ZV9zZWNkaXNjYXJkX3JxIGFuZCBtbWNfYmxrX2lzc3VlX2Rpc2NhcmRfcnEgYXJlIGp1c3QNCj4g
ZGlmZmVyZW50IGNvbW1hbmRzIGFuZCBwYXJhbWV0ZXJzIHNlbnQgYnkgdGhlIGhvc3QgYXMgYSBi
dXMuDQo+ID4gPiAgSSBkaWQgbm90IHNlZSB0aGUgZGVzY3JpcHRpb24gb2YgdHJpbSBpbiB0aGUg
ZGF0YSBzaGVldC4gQ291bGQgdGhlIGhvc3QNCj4gZHJpdmVyIGNhdXNlIHRoaXMgcHJvYmxlbT8N
Cj4gPg0KPiA+IFllcywgaXQgY2FuIC0gYW5kIHdlIGhhdmUgaGFkIGlzc3VlcyBsaWtlIHRoZXNl
IGJlZm9yZS4gU28gYmVmb3JlDQo+ID4gYWRkaW5nIGEgY2FyZCBxdWlyaywgSSB0aGluayB3ZSBu
ZWVkIHRvIG1ha2Ugc3VyZSB0aGlzIGlzbid0IHRoZSBjYXNlLg0KPiA+DQo+ID4gV2hlbiB1c2lu
ZyBNTUNfU0VDVVJFX1RSSU0xX0FSRywgaXQncyB2ZXJ5IGxpa2VseSB0aGF0IHRoZSByZXF1ZXN0
DQo+ID4gdGFrZXMgbG9uZ2VyIHRvIGNvbXBsZXRlLg0KPiA+DQo+ID4gVGhlIG1tYyBob3N0IGlz
IHJlc3BvbnNpYmxlIGZvciBlaXRoZXIgZGVhbGluZyB3aXRoIGJ1c3kgZGV0ZWN0aW9uDQo+ID4g
d2l0aCB0aGUgaGVscCBvZiBpdHMgSFcvY29udHJvbGxlciAtIG9yIGlmIHRoYXQgY2FuJ3QgYmUg
c3VwcG9ydGVkLA0KPiA+IHRoZSBtbWMgY29yZSBmYWxscyBiYWNrIHRvIHBvbGxpbmcgdGhlIGNh
cmQgZm9yIGJ1c3kgd2l0aCBhIENNRDEzLg0KPiA+DQo+ID4gU2VlIG1tY19kb19lcmFzZSgpIGlu
IC9kcml2ZXJzL21tYy9jb3JlL2NvcmUuYw0KPiA+DQo+ID4gPg0KPiA+ID4gTm90ZToNCj4gPiA+
IFRoZSBob3N0IGRyaXZlciBJIHVzZSBpcyBzZGhjaS1lc2RoYy1pbXguYw0KPiA+DQo+ID4gQWxy
aWdodCwgSSBoYXZlIGxvb3BlZCBpbiBGYWJpbyBhbmQgSGFpYm8gdGhhdCBrbm93cyB0aGlzIGRy
aXZlciwNCj4gPiBsZXQncyBzZWUgaWYgdGhleSBjYW4gaGVscC4NCj4gPg0KPiA+ID4NCj4gPiA+
IFRoYW5rcw0KPiA+ID4gWGlhb2xlaQ0KPiA+DQo+ID4gS2luZCByZWdhcmRzDQo+ID4gVWZmZQ0K
PiA+DQo+ID4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206
IFVsZiBIYW5zc29uIDx1bGYuaGFuc3NvbkBsaW5hcm8ub3JnPg0KPiA+ID4gU2VudDogV2VkbmVz
ZGF5LCBKYW51YXJ5IDIwLCAyMDIxIDk6NDEgUE0NCj4gPiA+IFRvOiBXYW5nLCBYaWFvbGVpIDxY
aWFvbGVpLldhbmdAd2luZHJpdmVyLmNvbT4NCj4gPiA+IENjOiBQYWxpIFJvaMOhciA8cGFsaUBr
ZXJuZWwub3JnPjsgTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz47DQo+ID4gPiBsaW51
eC1tbWNAdmdlci5rZXJuZWwub3JnOyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0DQo+ID4gPiA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IG1tYzogY29yZTogQXBwbHkgdHJpbSBicm9rZW4gcXVpcmsgdG8gUjFKNTdMDQo+ID4gPg0KPiA+
ID4gW1BsZWFzZSBub3RlIHRoaXMgZS1tYWlsIGlzIGZyb20gYW4gRVhURVJOQUwgZS1tYWlsIGFk
ZHJlc3NdDQo+ID4gPg0KPiA+ID4gT24gTW9uLCAxOCBKYW4gMjAyMSBhdCAwNToyNywgWGlhb2xl
aSBXYW5nIDx4aWFvbGVpLndhbmdAd2luZHJpdmVyLmNvbT4NCj4gd3JvdGU6DQo+ID4gPiA+DQo+
ID4gPiA+IFIxSjU3TCBtbWMgY2hpcCBodyBjYXBpYmlsaXR5IGluZGljYXRlcyB0aGF0IGl0IHN1
cHBvcnRzIHRyaW0NCj4gPiA+ID4gZnVuY3Rpb24sIGJ1dCB0aGlzIGZ1bmN0aW9uIGRvZXMgbm90
IHdvcmsgcHJvcGVybHksIHRoZSBTRElPIGJ1cw0KPiA+ID4gPiBkb2VzIG5vdCByZXNwb25kLCBh
bmQgdGhlIElPIGhhcyBiZWVuIHdhaXRpbmcgc28gc2V0IHF1aXJrcyB0bw0KPiA+ID4gPiBza2lw
IHRyaW0NCj4gPiA+DQo+ID4gPiBBcmUgeW91IHN1cmUgdGhpcyBpcyBhbiBlTU1DIHByb2JsZW0g
YW5kIG5vdCBhIG1tYyBob3N0IGRyaXZlciBpc3N1ZT8NCj4gPiA+DQo+ID4gPiBDYW4geW91IGVs
YWJvcmF0ZSBtb3JlIHdoYXQgaGFwcGVucz8NCj4gPiA+DQo+ID4gPiBLaW5kIHJlZ2FyZHMNCj4g
PiA+IFVmZmUNCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW9sZWkg
V2FuZyA8eGlhb2xlaS53YW5nQHdpbmRyaXZlci5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAg
ZHJpdmVycy9tbWMvY29yZS9xdWlya3MuaCB8IDQgKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5n
ZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvY29yZS9xdWlya3MuaCBiL2RyaXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiA+ID4g
aW5kZXggZDY4ZTZlNTEzYTRmLi42M2UwMjM5MWMxMzMgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvcXVpcmtzLmgNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9x
dWlya3MuaA0KPiA+ID4gPiBAQCAtODksNiArODksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1t
Y19maXh1cCBfX21heWJlX3VudXNlZA0KPiBtbWNfYmxrX2ZpeHVwc1tdID0gew0KPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICBNTUNfUVVJUktfU0VDX0VSQVNFX1RSSU1fQlJPS0VOKSwNCj4gPiA+
ID4gICAgICAgICBNTUNfRklYVVAoIlZaTDAwTSIsIENJRF9NQU5GSURfU0FNU1VORywNCj4gQ0lE
X09FTUlEX0FOWSwgYWRkX3F1aXJrX21tYywNCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgTU1D
X1FVSVJLX1NFQ19FUkFTRV9UUklNX0JST0tFTiksDQo+ID4gPiA+ICsgICAgICAgTU1DX0ZJWFVQ
KCJSMUo1N0wiLCBDSURfTUFORklEX01JQ1JPTiwNCj4gQ0lEX09FTUlEX0FOWSwgYWRkX3F1aXJr
X21tYywNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgTU1DX1FVSVJLX1NFQ19FUkFTRV9UUklN
X0JST0tFTiksDQo+ID4gPiA+DQo+ID4gPiA+ICAgICAgICAgLyoNCj4gPiA+ID4gICAgICAgICAg
KiAgT24gU29tZSBLaW5nc3RvbiBlTU1DcywgcGVyZm9ybWluZyB0cmltIGNhbiByZXN1bHQgaW4N
Cj4gPiA+ID4gQEANCj4gPiA+ID4gLTk4LDYgKzEwMCw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
bW1jX2ZpeHVwIF9fbWF5YmVfdW51c2VkDQo+IG1tY19ibGtfZml4dXBzW10gPSB7DQo+ID4gPiA+
ICAgICAgICAgICAgICAgICAgIE1NQ19RVUlSS19UUklNX0JST0tFTiksDQo+ID4gPiA+ICAgICAg
ICAgTU1DX0ZJWFVQKCJWMTAwMTYiLCBDSURfTUFORklEX0tJTkdTVE9OLA0KPiBDSURfT0VNSURf
QU5ZLCBhZGRfcXVpcmtfbW1jLA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgICBNTUNfUVVJUktf
VFJJTV9CUk9LRU4pLA0KPiA+ID4gPiArICAgICAgIE1NQ19GSVhVUCgiUjFKNTdMIiwgQ0lEX01B
TkZJRF9NSUNST04sDQo+IENJRF9PRU1JRF9BTlksIGFkZF9xdWlya19tbWMsDQo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgIE1NQ19RVUlSS19UUklNX0JST0tFTiksDQo+ID4gPiA+DQo+ID4gPiA+
ICAgICAgICAgRU5EX0ZJWFVQDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjI1
LjENCj4gPiA+ID4NCg==
