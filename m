Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4221C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 02:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0307223DB
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 02:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbhASCiS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Jan 2021 21:38:18 -0500
Received: from mail-eopbgr30048.outbound.protection.outlook.com ([40.107.3.48]:20290
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388074AbhASCgH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 18 Jan 2021 21:36:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JocTLQkyBwkOxCR5fEPPVvf2Mt6lRpHYt3TBhNKMU9T4uwvm4pYRrYoZWZm0odk2QgJeBMMnPNuqWL6Pd1TbMAyO/vn5+MXZIXS71tvipSonfHguQHK+oL+f/A0MkDoaFpklLQWaIN/5RyLG5wHr1h+ylYHI/Y0rJJa4BYD6Ok4j8lVH++CdbKxLdXEhjRzJCUtuKkacwwZwzMmiau9Q1dprO1Gj1+KW0kRRxcnZZ/r3tYJ9Fr/4fLHY4IjxhrMG/yksSO/aIB7ClCj6LlaP0+FTOl5kzPQfrrFOXeFqckXf4HCd4A4HSax7drv+7GFZp5a7GZX9/mvqQt+nTKB9RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQv89x346qynGiJfNwFBp/T9qlovBu6TXnG9S+Ou2qY=;
 b=Fstgg93zOWAL5O5BARdWCJ2Nn/PbVy2rtRsCWHDlXdes215bFlr88KQDEaXb7u0LyZBNW5HiqE5nQSSj+ja4x8bVHdxOkDYu9vHTxQX8Ko148auE08S4SlDJSQcYv1FnLx03QPbAxVirpEMaj6QS6JYBb5z06zu10pazQL2zIPl+KdHAxHau2K3q6lBsIEjRVHwtsVHn2O5I2sOgStmxYZllhGFQ+GkyxyArnBEq9JIgSccVFdzbjK7ejxzZ0q7KpjlKNrz+C/zADEz2VsjoCGyM4Jv+uBwFEGGKdupyvbbVkUqjgTvvGWOWX1dez3kGsHqsyDdl7e4IS5nJ0gcbBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQv89x346qynGiJfNwFBp/T9qlovBu6TXnG9S+Ou2qY=;
 b=bJGxZ7qWtxc4V9gZQuddC9MUCCKEa8OQU8Nv+WqDKwooW16saIfy8BpHG4ONJgeNoBD5ysz84hkoWSRlGc4wR3pfoaMjoXquXmFlxJxl7FzXS0rzJRTHZlyvhtqGOBfgew56Yu7Go3UtNrnrCwZxJRF5dBn5FC3qQwTfLUhPX1g=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Tue, 19 Jan
 2021 02:35:16 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::c964:9:850a:fc5%10]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 02:35:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Bough Chen <haibo.chen@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Angus Ainslie <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: sdhci timeout on imx8mq
Thread-Topic: sdhci timeout on imx8mq
Thread-Index: AQHV2sbvD7YxbGrQaEafHvU1a573qqgMVz+AgABAnwCAAmp/gIAJdBoAgACLvoCA2XSGAIAKjH+AgADWhoCBHVl6gIAVLYJw
Date:   Tue, 19 Jan 2021 02:35:16 +0000
Message-ID: <DB6PR0402MB27606855A5FD66C3A66FA9E088A30@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
         <20200205092653.GB2737@bogon.m.sigxcpu.org>
         <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
         <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
         <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
         <5ad361195f2e191484c8a231be0f5a07@akkea.ca>
         <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
         <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
In-Reply-To: <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aff257c3-eafa-4a74-6a90-08d8bc22db52
x-ms-traffictypediagnostic: DBAPR04MB7285:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR04MB7285AB6437350B70192F3D1688A30@DBAPR04MB7285.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NExBo1ZQAcuv3j5UhOJmNVBoWdR1fUt9zz9QEaguUK2oURyhv1BEBEbXHj5Ajna7Bw1ILYp29juMu1eYbjNhH0SQclP8ob2YlUdd17Z+8ob9XyiZI8XFKXxym3xp6ovhCU8PXx/dH3uQqnQfLvnuXJPPWx/SX73FKjSWo0pHs/lUxpYyHz+TBJJZfe9SOEkZ1tjrNQk9NyDnxBdrz0o7BQ+77GEJvG1XqexfGXtMrzc5OU2xHZ9mHftv8DsVktVRWbERb2ohsdn0p3fcox9IFQYJKLx1k+3XOzd7faE3NVDVCnvyelYQY9p4HeUysqbMIxbhDXlp5/OfQiIZP/T+FeaQVudj2W/fdhyO6w1Abvq/Z0HCtUHai36GL1ZmWes+Pld7U8Pqm7ZjPEevTkmE4IzzhPdmbozn1lKkEzYQd3P+G2C/h3UI64p0nwTi3jmG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(44832011)(316002)(6506007)(64756008)(110136005)(4326008)(478600001)(53546011)(7696005)(66556008)(66476007)(26005)(76116006)(186003)(66946007)(54906003)(66446008)(8936002)(2906002)(5660300002)(55016002)(66574015)(52536014)(71200400001)(7416002)(86362001)(33656002)(83380400001)(9686003)(8676002)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WURIR3ZrUkF0YytxNUhEMlkvRDdwZjM3a0VTVGlyQWhyQ2VWUUpucmxJb09r?=
 =?utf-8?B?MUlyRDl2MXI3V1VINXRzREhWSUFxOFgxUmNWVWt1Mk4wbFBaY1VYVzlhSTh6?=
 =?utf-8?B?UitBMHJLL0xwa0VzUTBNVXRZb1p3QTVjRkt6R2p1VVM5alZ5YkJzdjFoQXd0?=
 =?utf-8?B?bldjNzlrTUtRVUMrQnRFc1UzdXAweTlCSEtiVTA5TENGMm83clo5KzNpc0Zr?=
 =?utf-8?B?ZjRtaFRyWE0xN3Q1STRMb29udWptcCtycDBWbnRWSUt5aDcvQWVTc1JuOXFJ?=
 =?utf-8?B?bkNQZkUxM1JKVXkzclFzRGxvNXJSTFk0K2RDa2VNbUtqNXp4RGZrNmgzQXpR?=
 =?utf-8?B?NmNPenlHNHdrY1VPU2lVT1JDRjRjQUxIbUZWcE14RExaOFV6TUppaGpkS2o5?=
 =?utf-8?B?NEFzL2ZSZ2NiejZTdCtZUEtCZmlZeUJ4L0t6MnVnYlhsWlVvVllDYXFzOXJ6?=
 =?utf-8?B?VTVoU09iSm5YSVI1SWtMeUpWcS81UXpGQ29QdHlaRmtYZW9UejNnMnpLZlpj?=
 =?utf-8?B?S1JYSTdzbzVhOCtjUTJhdDNVbUJCODBOWDRsdGw2R1J2TXlXaHpkdDVualA1?=
 =?utf-8?B?bFVlT1Robnp6U0NuTnhZZ2JvMlZ2NzBYbFlCNlJPUVNEdHpuSDhjbXlnZEZv?=
 =?utf-8?B?U3BGZ0w2MCtnMVJFTTl0cHZ6a3FxYWZIV3ZKSVJnUzdHTklLVnpEcFFITGo4?=
 =?utf-8?B?c1Z6dVZpL0hSd2J4TnBzRkxrV3B4L1F4RkxvUE9nalc3cHNDWlh4NHVtaVli?=
 =?utf-8?B?dGlaUFNtN1RkNkVXZGNqdXhrdzhkL2l0WThHU3QrMGtwb00vcGhVeXFsZkJI?=
 =?utf-8?B?VXdjenc2c2Vnd0xTQ0JDbXdRakFEdDBMSW9UbGRTdkFUdmhOZkcreStFZWty?=
 =?utf-8?B?R0xVVVRIc0RHRkx1R0QxQlMrSDlsM1JwSHQ3ci9kRkNmQ2dQZ0hkN3Bkdlhp?=
 =?utf-8?B?dnlPR3BtZmhIQkozZFlLTzM5VHkyaXl6ZlI0eUQyYlp2eWVXR0hPRWk5YkV6?=
 =?utf-8?B?Qmw2RWZseG05YThncE94Y1FnRHhLejd4QnQvNUhUNnhySVVoNDhGQWEwelRn?=
 =?utf-8?B?MGRncmcvOHhUcWNJQVRpa1diMi8xSkZ3ZjZFQmVoaFRabUI5Y0NyMENRbElZ?=
 =?utf-8?B?bnRrNGN5WFBQUUlleFRFTEpDQ3hIRk95Q1VGZ1NmVGoxZGVOWnBYa3l0d1FT?=
 =?utf-8?B?eHBsbGgxbFYrMmN6Zlg0NVg4S05Fc3JUVGcrcVJTUVZWUkpxWk1VbmxPNkFK?=
 =?utf-8?B?OVJOM1ZwRGtGc1hCVDdURVlrclBUOXBHUW5jT3ZqOWlaTDBmNHloaTA5K29I?=
 =?utf-8?Q?KQkWBjIO06Z/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aff257c3-eafa-4a74-6a90-08d8bc22db52
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 02:35:16.6527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cK0hK+lEoHisVOGMtuzm/VK0UcJlwLaDm79NEU3oJrtLsp2/6KDJKJ+RyTPXE0z/7VKp8xBTJ/ijPBiMfAi0SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgTHVjYXMsDQoNCj4gU3ViamVjdDogUmU6IHNkaGNpIHRpbWVvdXQgb24gaW14OG1xDQo+IA0K
PiBIaSBhbGwsDQo+IA0KPiBBbSBNaXR0d29jaCwgZGVtIDA4LjA3LjIwMjAgdW0gMDE6MzIgKzAw
MDAgc2NocmllYiBCT1VHSCBDSEVOOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IEZhYmlvIEVzdGV2YW0gW21haWx0bzpmZXN0ZXZhbUBnbWFpbC5jb21dDQo+
ID4gPiBTZW50OiAyMDIw5bm0N+aciDfml6UgMjA6NDUNCj4gPiA+IFRvOiBBbmd1cyBBaW5zbGll
IDxhbmd1c0Bha2tlYS5jYT4NCj4gPiA+IENjOiBCT1VHSCBDSEVOIDxoYWliby5jaGVuQG54cC5j
b20+OyBVbGYgSGFuc3Nvbg0KPiA+ID4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBHdWlkbyBH
w7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPjsgbGludXgtDQo+ID4gPiBtbWMgPGxpbnV4LW1tY0B2
Z2VyLmtlcm5lbC5vcmc+OyBBZHJpYW4gSHVudGVyDQo+ID4gPiA8YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgU2FzY2hhDQo+ID4gPiBI
YXVlciA8IGtlcm5lbEBwZW5ndXRyb25peC5kZT47IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NB
TEUgSU1YIC8NCj4gPiA+IE1YQyBBUk0gQVJDSElURUNUVVJFIDxsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc+DQo+ID4gPiBTdWJqZWN0OiBSZTogc2RoY2kgdGltZW91dCBvbiBp
bXg4bXENCj4gPiA+DQo+ID4gPiBIaSBBbmd1cywNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEp1biAz
MCwgMjAyMCBhdCA0OjM5IFBNIEFuZ3VzIEFpbnNsaWUgPGFuZ3VzQGFra2VhLmNhPg0KPiA+ID4g
d3JvdGU6DQo+ID4gPg0KPiA+ID4gPiBIYXMgdGhlcmUgYmVlbiBhbnkgcHJvZ3Jlc3Mgd2l0aCB0
aGlzLiBJJ20gZ2V0dGluZyB0aGlzIG9uIGFib3V0DQo+ID4gPiA+IDUwJSBvZg0KPiA+ID4NCj4g
PiA+IE5vdCBmcm9tIG15IHNpZGUsIHNvcnJ5Lg0KPiA+ID4NCj4gPiA+IEJvdWdoLA0KPiA+ID4N
Cj4gPiA+IERvIHlvdSBrbm93IHdoeSB0aGlzIHByb2JsZW0gYWZmZWN0cyB0aGUgaW14OG1xLWV2
ayB2ZXJzaW9ucyB0aGF0DQo+ID4gPiBhcmUgcG9wdWxhdGVkIHdpdGggdGhlIE1pY3JvbiBlTU1D
IGFuZCBub3QgdGhlIG9uZXMgd2l0aCBTYW5kaXNrDQo+ID4gPiBlTU1DPw0KPiA+DQo+ID4gSGkg
QW5ndXMsDQo+ID4NCj4gPiBDYW4geW91IHNob3cgbWUgdGhlIGZ1bGwgZmFpbCBsb2c/IEkgZG8g
bm90IG1lZXQgdGhpcyBpc3N1ZSBvbiBteQ0KPiA+IHNpZGUsIGJlc2lkZXMsIHdoaWNoIGtpbmQg
b2YgdWJvb3QgZG8geW91IHVzZT8NCj4gDQo+IEkgd2FzIGZpbmFsbHkgYWJsZSB0byBiaXNlY3Qg
dGhpcyBpc3N1ZSwgd2hpY2ggd2Fzbid0IHRoYXQgbXVjaCBmdW4gZHVlIHRvIHRoZQ0KPiBpc3N1
ZSBub3QgYmVpbmcgcmVwcm9kdWNpYmxlIDEwMCUuIDovIFR1cm5zIG91dCB0aGF0IHRoZSBpc3N1
ZSBpcyBldmVuIG1vcmUNCj4gaW50ZXJlc3RpbmcgdGhhbiBJIHRob3VnaHQgYW5kIGxpa2VseSBk
b2Vzbid0IGhhdmUgYW55dGhpbmcgdG8gZG8gd2l0aCBTREhDSSBvcg0KPiB1c2VkIGJvb3Rsb2Fk
ZXIgdmVyc2lvbnMuIEhlcmUncyBteSBjdXJyZW50IGRlYnVnZ2luZyBzdGF0ZToNCj4gDQo+IEkn
dmUgYmlzZWN0ZWQgdGhlIGlzc3VlIGRvd24gdG8gYjA0MzgzYjZhNTU4IChjbGs6IGlteDhtcTog
RGVmaW5lIGdhdGVzIGZvcg0KPiBwbGwxLzIgZml4ZWQgZGl2aWRlcnMpLiBUaGUgY2hhbmdlIGl0
c2VsZiBsb29rcyBmaW5lIHRvIG1lLCBzdGlsbCBDQydlZCBMZW9uYXJkIGZvcg0KPiBnb29kIG1l
YXN1cmUuDQo+IA0KPiBJbiBteSB0ZXN0aW5nIHRoZSBmb2xsb3dpbmcgcGFydGlhbCByZXZlcnQg
Zml4ZXMgdGhlIGlzc3VlOg0KPiANCj4gLS0tIGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg4bXEu
Yw0KPiArKysgYi9kcml2ZXJzL2Nsay9pbXgvY2xrLWlteDhtcS5jDQo+IEBAIC0zNjUsNyArMzY1
LDcgQEAgc3RhdGljIGludCBpbXg4bXFfY2xvY2tzX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQo+ICAgICAgICAgaHdzW0lNWDhNUV9TWVMxX1BMTF8xMzNNX0NHXSA9DQo+
IGlteF9jbGtfaHdfZ2F0ZSgic3lzMV9wbGxfMTMzbV9jZyIsICJzeXMxX3BsbF9vdXQiLCBiYXNl
ICsgMHgzMCwgMTUpOw0KPiAgICAgICAgIGh3c1tJTVg4TVFfU1lTMV9QTExfMTYwTV9DR10gPQ0K
PiBpbXhfY2xrX2h3X2dhdGUoInN5czFfcGxsXzE2MG1fY2ciLCAic3lzMV9wbGxfb3V0IiwgYmFz
ZSArIDB4MzAsIDE3KTsNCj4gICAgICAgICBod3NbSU1YOE1RX1NZUzFfUExMXzIwME1fQ0ddID0N
Cj4gaW14X2Nsa19od19nYXRlKCJzeXMxX3BsbF8yMDBtX2NnIiwgInN5czFfcGxsX291dCIsIGJh
c2UgKyAweDMwLCAxOSk7DQo+IC0gICAgICAgaHdzW0lNWDhNUV9TWVMxX1BMTF8yNjZNX0NHXSA9
DQo+IGlteF9jbGtfaHdfZ2F0ZSgic3lzMV9wbGxfMjY2bV9jZyIsICJzeXMxX3BsbF9vdXQiLCBi
YXNlICsgMHgzMCwgMjEpOw0KPiAgICAgICAgIGh3c1tJTVg4TVFfU1lTMV9QTExfNDAwTV9DR10g
PQ0KPiBpbXhfY2xrX2h3X2dhdGUoInN5czFfcGxsXzQwMG1fY2ciLCAic3lzMV9wbGxfb3V0Iiwg
YmFzZSArIDB4MzAsIDIzKTsNCj4gICAgICAgICBod3NbSU1YOE1RX1NZUzFfUExMXzgwME1fQ0dd
ID0NCj4gaW14X2Nsa19od19nYXRlKCJzeXMxX3BsbF84MDBtX2NnIiwgInN5czFfcGxsX291dCIs
IGJhc2UgKyAweDMwLCAyNSk7DQo+IA0KPiBAQCAtMzc1LDcgKzM3NSw3IEBAIHN0YXRpYyBpbnQg
aW14OG1xX2Nsb2Nrc19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAg
ICAgICAgIGh3c1tJTVg4TVFfU1lTMV9QTExfMTMzTV0gPQ0KPiBpbXhfY2xrX2h3X2ZpeGVkX2Zh
Y3Rvcigic3lzMV9wbGxfMTMzbSIsICJzeXMxX3BsbF8xMzNtX2NnIiwgMSwgNik7DQo+ICAgICAg
ICAgaHdzW0lNWDhNUV9TWVMxX1BMTF8xNjBNXSA9DQo+IGlteF9jbGtfaHdfZml4ZWRfZmFjdG9y
KCJzeXMxX3BsbF8xNjBtIiwgInN5czFfcGxsXzE2MG1fY2ciLCAxLCA1KTsNCj4gICAgICAgICBo
d3NbSU1YOE1RX1NZUzFfUExMXzIwME1dID0NCj4gaW14X2Nsa19od19maXhlZF9mYWN0b3IoInN5
czFfcGxsXzIwMG0iLCAic3lzMV9wbGxfMjAwbV9jZyIsIDEsIDQpOw0KPiAtICAgICAgIGh3c1tJ
TVg4TVFfU1lTMV9QTExfMjY2TV0gPQ0KPiBpbXhfY2xrX2h3X2ZpeGVkX2ZhY3Rvcigic3lzMV9w
bGxfMjY2bSIsICJzeXMxX3BsbF8yNjZtX2NnIiwgMSwgMyk7DQo+ICsgICAgICAgaHdzW0lNWDhN
UV9TWVMxX1BMTF8yNjZNXSA9DQo+ICsgaW14X2Nsa19od19maXhlZF9mYWN0b3IoInN5czFfcGxs
XzI2Nm0iLCAic3lzMV9wbGxfb3V0IiwgMSwgMyk7DQo+ICAgICAgICAgaHdzW0lNWDhNUV9TWVMx
X1BMTF80MDBNXSA9DQo+IGlteF9jbGtfaHdfZml4ZWRfZmFjdG9yKCJzeXMxX3BsbF80MDBtIiwg
InN5czFfcGxsXzQwMG1fY2ciLCAxLCAyKTsNCj4gICAgICAgICBod3NbSU1YOE1RX1NZUzFfUExM
XzgwME1dID0NCj4gaW14X2Nsa19od19maXhlZF9mYWN0b3IoInN5czFfcGxsXzgwMG0iLCAic3lz
MV9wbGxfODAwbV9jZyIsIDEsIDEpOw0KPiANCj4gVGhlIHN5czFfcGxsXzI2Nm0gaXMgdGhlIHBh
cmVudCBvZiBuYW5kX3VzZGhjX2J1cy4gSSd2ZSB2YWxpZGF0ZWQgdGhhdCB0aGUNCj4gU0RIQ0kg
ZHJpdmVyIHByb3Blcmx5IGVuYWJsZXMgdGhpcyBidXMgY2xvY2sgYWNyb3NzIHRoZSBwcm9ibGVt
YXRpYyBjYXJkDQo+IGFjY2Vzcy4gU28gd2hhdCBJIHRoaW5rIGlzIGhhcHBlbmluZyBoZXJlIGlz
IHRoYXQgYm90aCBuYW5kX3VzZGhjX2J1cyBhbmQNCj4gc3lzMV9wbGxfMjY2bSBhcmUgaW5pdGlh
bGx5IGVuYWJsZWQuIFNvbWV0aW1lIGR1cmluZyBib290IHN5czFfcGxsXzI2Nm0NCj4gZ2V0cyBk
aXNhYmxlZCBkdWUgdG8gcnVudGltZSBQTSBvbiB0aGUgZW5ldF9heGkgY2xvY2ssIHdoaWNoIGlz
IGEgZGlyZWN0IGNoaWxkDQo+IG9mIHN5czFfcGxsXzI2Nm0uIEF0IHRoaXMgcG9pbnQgbmFuZF91
c2RoY19idXMgaXMgc3RpbGwgZW5hYmxlZCwgYnV0IG5vDQo+IGNvbnN1bWVyIGhhcyBjbGFpbWVk
IHRoZSBjbG9jayB5ZXQsIHNvIHRoZSBwYXJlbnQgY2xvY2sgZ2V0cyBkaXNhYmxlZCB3aGlsZQ0K
PiB0aGlzIGJyYW5jaCBvZiB0aGUgY2xvY2sgdHJlZSBpcyBzdGlsbCBhY3RpdmUuDQo+IA0KPiBU
aGUgcmVmZXJlbmNlIG1hbnVhbCBzdGF0ZXMgYWJvdXQgdGhpcyBzaXR1YXRpb246ICJGb3IgYW55
IGNsb2NrLCBpdHMgc291cmNlDQo+IG11c3QgYmUgbGVmdCBvbiB3aGVuIGl0IGlzIGtlcHQgb24u
IEJlaGF2aW9yIGlzIHVuZGVmaW5lZCBpZiB0aGlzIHJ1bGUgaXMNCj4gdmlvbGF0ZWQuIg0KDQpJ
IHRoaW5rIHlvdSBhcmUgcmVmZXJyaW5nDQpDbG9jayBzb3VyY2UgY29udHJvbCwNCkZvciBQTExz
LCB3ZSBoYXZlIGNoYW5uZWwgb24gZXZlcnkgUExMLCBldmVyeSBQRkQgYW5kIGV2ZXJ5IGRpdmlk
ZXIuIFBMTCBpcyB0aGUNCnNvdXJjZSBvZiBQRkRzIGFuZCBkaXZpZGVycy4gRm9yIGFueSBjbG9j
aywgaXRzIHNvdXJjZSBtdXN0IGJlIGxlZnQgb24gd2hlbiBpdCBpcyBrZXB0IG9uLg0KQmVoYXZp
b3IgaXMgdW5kZWZpbmVkIGlmIHRoaXMgcnVsZSBpcyB2aW9sYXRlZC4NCg0KSSB0aGluayB0aGlz
IGlzIG5vdCBzYXlpbmcgY2xvY2sgcm9vdCBzbGljZS4NCg0KUmVnYXJkcywNClBlbmcuDQoNCj4g
QW5kIGl0IHNlZW1zIHRoaXMgaXMgZXhhY3RseSB3aGF0J3MgaGFwcGVuaW5nIGhlcmU6IHNvbWUg
a2luZCBvZiBnbGl0Y2ggaXMNCj4gaW50cm9kdWNlZCBpbiB0aGUgbmFuZF91c2RoY19idXMgY2xv
Y2ssIHdoaWNoIHByZXZlbnRzIHRoZSBTREhDSSBjb250cm9sbGVyDQo+IGZyb20gd29ya2luZywg
ZXZlbiB0aG91Z2ggdGhlIGNsb2NrIGJyYW5jaCBpcyBwcm9wZXJseSBlbmFibGVkIGxhdGVyIG9u
LiBPbg0KPiBteSBzeXN0ZW0gdGhlIFNESENJIHRpbWVvdXQgYW5kIGZvbGxvd2luZyBydW50aW1l
IHN1c3BlbmQvcmVzdW1lIGN5Y2xlDQo+IG9uIHRoZSBuYW5kX3VzZGhjX2J1cyBjbG9jayBzZWVt
IHRvIGdldCBpdCBiYWNrIGludG8gYSB3b3JraW5nIHN0YXRlLg0KPiANCj4gU28gSSB0aGluayB3
ZSBuZWVkIHNvbWUgc29sdXRpb24gYXQgdGhlIGNsb2NrIGRyaXZlci9mcmFtZXdvcmsgbGV2ZWwg
dG8NCj4gcHJldmVudCBzaHV0dGluZyBkb3duIHBhcmVudCBjbG9ja3MgdGhhdCBoYXZlIGFjdGl2
ZSBicmFuY2hlcywgZXZlbiBpZiB0aG9zZQ0KPiBicmFuY2hlcyBhcmVuJ3QgY2xhaW1lZCBieSBh
IGNvbnN1bWVyICh5ZXQpLg0KPiANCj4gUmVnYXJkcywNCj4gTHVjYXMNCg0K
