Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B89C63777
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 02:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B918E22202
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Nov 2020 02:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MoSjPQ8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392186AbgK0CLJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 21:11:09 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:57545
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392135AbgK0CLJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 21:11:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m214hIxOtvbQLPhMxDMMTTqLwyqCXqV2VQC2StdhPlNaYu1ivFTZewwKQ04hsmu98+IZ50PE8JgJT+VPhkY3lXE3BS/o2rWaa3uMkBrdqZ7PCA4EC4yQO5Tb82er1vSg5YGHMIsYLs42lx/6+QGXfD0oEUYSeieNm6eTLBx0YPVWblahXDXqWHizEw1ZhbHiwuBKFxIwD6fqftujE1vwpdvPzvTNoO0OKHF1uwQgKCgnBHaY8udFecihDkAydz1VAR01EeRNS3rjuqKoO4AXrYed0OFrl5FV0y5Fr2qn0DAYQP2ZdagtYYa9lKveyGbBofghKOu3uAEljdIDXtRAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXJtmwC2MvEArvofIyA0BB0N2obrFJz2wCiCnHv4Fco=;
 b=VZofBq6IdHj1VBUhZrjWr25lWUBfbHSczcrFM8wNIfX0trpbMQQpM9kQ7KuBdc6uPGBMBsh6LIUcv2Zjo9ItLuNQ1nNfkPH7WCgSkFlAiGX6THN6eqXyO0UOqBgSW3bHQWIMFnwoF9VSXdhB3pwnfsGmKim0Aj0FMfenrsgdlgE4krcq81Anizjr8fWNiHu5DdgGwVomUDQd6NbmYTfEp6tIpV2u+3S2IoB/96kNDS8p4bbdCoblegWoaKJeFDfJNNzm2I27PY00Q4E6LvkGgVL6HtBpbjhwlHQ0zqEbwkJah7m9Z/1fwN1bgYs2pBf0iEiJjAK7XoWevelcoDdegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXJtmwC2MvEArvofIyA0BB0N2obrFJz2wCiCnHv4Fco=;
 b=MoSjPQ8QC+2MPZu5e+GD8VRPBjfraRq9OBi2yRJhUczIeCdhwgqyJH8TzrwjD8OUmyOjQlken8Nc2aSUf3jeeIk6XvP26+29Vy02R35jw39XJ2PzMBXFYhRepRhLSJJuF5V9o28vbAn8ViVaLkWrgTHPxJNR6DdTKFoKO4ieB38=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR04MB4223.eurprd04.prod.outlook.com (2603:10a6:803:41::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 02:11:05 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93%7]) with mapi id 15.20.3611.023; Fri, 27 Nov 2020
 02:11:05 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: RE: [PATCH RESEND v4 13/18] arm64: dts: imx8qm: add conn ss support
Thread-Topic: [PATCH RESEND v4 13/18] arm64: dts: imx8qm: add conn ss support
Thread-Index: AQHWw+Wnu1PgcGPAb0umAxM0Ayu43anbPFKg
Date:   Fri, 27 Nov 2020 02:11:05 +0000
Message-ID: <VI1PR04MB529483B90AA4B8880CDA71C590F80@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <20201126105900.26658-14-aisheng.dong@nxp.com>
In-Reply-To: <20201126105900.26658-14-aisheng.dong@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1441d97d-af73-4791-3955-08d89279b267
x-ms-traffictypediagnostic: VI1PR04MB4223:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4223B352F87F536E0A34983590F80@VI1PR04MB4223.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8FAKP4Q8/inTq5yGH42Gl8PbGAkQoPQLEBF6f9oPObHGqgis29H20Mm4j9G1cxnzpIs+EJUBDd9o7EbByZGtmnWPYS7WxSIShS/hVgGmbxhdQSZ6sFdCfp6PueXZOByv/OVP0XNsAOgM9d70Q/f4eGhdE9dNmc8eqI8AHo8Y0JzC5kTFQ0MKv3VryOzpxUJKk7P21Dt/5x/E30TR4jpVGNh7dRm2xxDfSBH00LvGhUEt1qfWEQ6LDgq5THM7eUC5V9FG/20wdV/y0wyO7xhiJBY6FaeNsPbJVRAtNQjQrSLotDQS8+mVM6xI76Nnyp3HM946cdi0a6r+0NlYn3PwQ7BAyWITy34NHdKdW6WnpJ2Itx51jTDBJc7db/TMXpvh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(54906003)(9686003)(55016002)(110136005)(316002)(71200400001)(2906002)(83380400001)(86362001)(53546011)(66476007)(66446008)(66556008)(66946007)(76116006)(52536014)(5660300002)(478600001)(64756008)(33656002)(186003)(4326008)(26005)(7696005)(8936002)(8676002)(6506007)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?ZWY1djl2SWdsQnA1akhiOXZIYUN0YUJURy96TU9ZdHdmMEFjekRtQ09POGgy?=
 =?gb2312?B?SjcxL3lPYi9Kdjdrck1HblluZHQyZ2pkbE9wcHBaOFFodWdidEU0ZFJqdnpn?=
 =?gb2312?B?QzVIUmtmMEkrNU5ta2VwSUdRV3pGeUVSaU5ISG9ObDNOZ2haNHBNdi90QTF3?=
 =?gb2312?B?QVlIWkFOZm1hTmZZd1ljVTR4dVhZUEVNZGhPajNFRWcyc2NzYWVRdlIxM0Rq?=
 =?gb2312?B?UHVXNCtsQ3FRRWxoc3Biajk3MXBYbzVOYTlwbC81MnpnMGxYRjd3UUhYaFpp?=
 =?gb2312?B?cCtMVHJuU0lnMzdvdkwrYTVsWGQ0d0hYNkZtVGt0QTBrOFZmbUlQZktFMlRW?=
 =?gb2312?B?MGZCQkVzQVovaktXLzM1blFBellTMWRRREYzeEJDdDdMam5uWXYrK3dpbkRl?=
 =?gb2312?B?Mmg1RFNyS1pHOFhTYnQ2TmxZQmtxMUJJNUY5bXdIbHdDT3VxVVduVHJ2aGRr?=
 =?gb2312?B?ZnVjakVUVWdyaXNUV1NXR0t6c1AxdGVtaFZ0VnV5d1Q0SEx2OWFuNUxPWTNN?=
 =?gb2312?B?RTYyNHg1bEI1eFBvUTVxRzlwaWc4Tm9DUCs4ZFpDK0tlaEczRzhyMlB0WUZK?=
 =?gb2312?B?bGJVWkZ0ek10TFJCdkFlM0Jyck5nMnJ6c1VnMXFwUlI3UWZNa3Eyb1hodHNP?=
 =?gb2312?B?SDVGUHBsdTNjbUI2WVJmTjNwRXo5RDZQNzRPbkxMM2xkNmVJNVNiK2V0a3lx?=
 =?gb2312?B?Y0JMTDJZczBxcktZZEtVL3ZFQzE0bzZLTXlFeGN0U3RURm03K2ZYZXRtWXNF?=
 =?gb2312?B?SEVueXVCYmhXZy83OWcrYUZqVGJ2TVVtakYyQUcwVWpDNE51OUR6empCZy9S?=
 =?gb2312?B?RVVwK1Z6QUF3ckZ1cnVZQWNzZkhJMyszTjkzV0lDbW1iRE43V0VQYWErUFZy?=
 =?gb2312?B?V0MveGNFamVzQm5USUROMW1JWTB4V2RReTRSL21qUDJwaGtsdVByR250SnZx?=
 =?gb2312?B?dUsvWlZac05JRCtibGwyNkowdGk3ZDBMenhHb2UxNVFIaENkU205NUhxK2s2?=
 =?gb2312?B?ampmN2NSTm9sVVVOMDkvNFM0ZklxT1RSM1NpLzB5ZE9GV012dkNpNUdUWnEv?=
 =?gb2312?B?bFZCbVhUbUpsM2lYdFVQTnY4STNvdWMxTTgvSGJNanZBK1Bvc0R4T1JNb01y?=
 =?gb2312?B?Y0RYaTFDbXRWSlA3WWJaQ3FEcXZ6dElxNHdEZXdiSG96WDNwN1JlMWlVdnJQ?=
 =?gb2312?B?ZllXaCtpL1ZnclIwVTB3ZzVmbm41bmptL3p0TkNiVGdWZHE3Z0dlb015VW9r?=
 =?gb2312?B?Sk9SV2pIVW5SdHZ2VjB3TlFBcTNNTU1ZaVJDUEFDRTZNSGFSYWpnRFd5NHJH?=
 =?gb2312?Q?o0GqTA8FSytN8=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1441d97d-af73-4791-3955-08d89279b267
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2020 02:11:05.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HJbShOg/n9W+y7F1Fwi2blyeC64j6bztYbe0C3mdTuFfLwdnrYQ/qdzQcgH3pW/ytPYmCgtnSzpY0X+Xb8OKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4223
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBaXNoZW5nIERvbmcNCj4gU2Vu
dDogMjAyMMTqMTHUwjI2yNUgMTg6NTkNCj4gVG86IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
DQo+IENjOiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRsLWxpbnV4LWlt
eCA8bGludXgtaW14QG54cC5jb20+Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnOyBBaXNo
ZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPjsgUm9iDQo+IEhlcnJpbmcgPHJvYmgrZHRA
a2VybmVsLm9yZz47IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5jb20+Ow0KPiBTaGF3
biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+OyBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRy
b25peC5kZT47DQo+IEZhYmlvIEVzdGV2YW0gPGZhYmlvLmVzdGV2YW1AbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIIFJFU0VORCB2NCAxMy8xOF0gYXJtNjQ6IGR0czogaW14OHFtOiBhZGQgY29u
biBzcyBzdXBwb3J0DQo+IA0KPiBUaGUgQ09OTiBTUyBvZiBNWDhRTSBpcyBtb3N0bHkgdGhlIHNh
bWUgYXMgTVg4UVhQIGV4Y2VwdCBpdCBoYXMgb25lIG1vcmUNCj4gVVNCIEhTSUMgbW9kdWxlIHN1
cHBvcnQuIFNvIHdlIGNhbiBmdWxseSByZXVzZSB0aGUgZXhpc3QgQ09OTiBTUyBkdHNpLg0KPiBB
ZGQgPHNvYz4tc3MtY29ubi5kdHNpIHdpdGggY29tcGF0aWJsZSBzdHJpbmcgdXBkYXRlZCBhY2Nv
cmRpbmcgdG8NCj4gaW14OC1zcy1jb25uLmR0c2kuDQo+IA0KPiBDYzogUm9iIEhlcnJpbmcgPHJv
YmgrZHRAa2VybmVsLm9yZz4NCj4gQ2M6IE1hcmsgUnV0bGFuZCA8bWFyay5ydXRsYW5kQGFybS5j
b20+DQo+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZw0KPiBDYzogU2hhd24gR3VvIDxz
aGF3bmd1b0BrZXJuZWwub3JnPg0KPiBDYzogU2FzY2hhIEhhdWVyIDxrZXJuZWxAcGVuZ3V0cm9u
aXguZGU+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmYWJpby5lc3RldmFtQG54cC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IERvbmcgQWlzaGVuZyA8YWlzaGVuZy5kb25nQG54cC5jb20+DQo+IC0tLQ0K
PiBDaGFuZ2VMb2c6DQo+IHYyLT52MzoNCj4gICogbm8gY2hhbmdlcw0KPiB2MS0+djI6DQo+ICAq
IGNoYW5nZSB0byB0aGUgbmV3IHR3byBjZWxsIHNjdSBjbGsgYmluZGluZw0KPiAtLS0NCj4gIC4u
Li9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLWNvbm4uZHRzaSAgICB8IDIxICsrKysrKysr
KysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCspDQo+ICBjcmVh
dGUgbW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLWNv
bm4uZHRzaQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxbS1zcy1jb25uLmR0c2kNCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9p
bXg4cW0tc3MtY29ubi5kdHNpDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uZGM0N2M1YzgwZWFlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLWNvbm4uZHRzaQ0KPiBAQCAtMCwwICsxLDIx
IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsNCj4gKy8qDQo+ICsg
KiBDb3B5cmlnaHQgMjAxOS0yMDIwIE5YUA0KPiArICoJRG9uZyBBaXNoZW5nIDxhaXNoZW5nLmRv
bmdAbnhwLmNvbT4NCj4gKyAqLw0KPiArDQo+ICsmZmVjMSB7DQo+ICsJY29tcGF0aWJsZSA9ICJm
c2wsaW14OHFtLWZlYyIsICJmc2wsaW14NnN4LWZlYyI7IH07DQo+ICsNCj4gKyZmZWMyIHsNCj4g
Kwljb21wYXRpYmxlID0gImZzbCxpbXg4cW0tZmVjIiwgImZzbCxpbXg2c3gtZmVjIjsgfTsNCj4g
Kw0KPiArJnVzZGhjMSB7DQo+ICsJY29tcGF0aWJsZSA9ICJmc2wsaW14OHFtLXVzZGhjIiwgImZz
bCxpbXg3ZC11c2RoYyI7IH07DQo+ICsNCj4gKyZ1c2RoYzIgew0KPiArCWNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxbS11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMiOyB9Ow0KDQpIaSBBaXNoZW5nLA0K
DQpGb3IgdXNkaGMxIGFuZCB1c2RoYzIsIHRoZSBjb21wYXRpYmxlIHNldHRpbmcgc2hvdWxkIGJl
IGxpa2UgdGhpczoNCgljb21wYXRpYmxlID0gImZzbCxpbXg4cW0tdXNkaGMiLCAiZnNsLGlteDhx
eHAtdXNkaGMiOw0KDQpTaW5jZSBpbXg4cW0gYWxzbyBzdXBwb3J0IGhzNDAwZXMgYW5kIGNvbW1h
bmQgcXVldWUsIFRoZSB1c2RoYyBJUCBpcyB0aGUgc2FtZSB3aXRoIGlteDhxeHAuDQoNCkJlc3Qg
UmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiAtLQ0KPiAyLjIzLjANCg0K
