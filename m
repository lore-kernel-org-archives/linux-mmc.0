Return-Path: <SRS0=muZ+=IE=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B5C433DB
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Mar 2021 04:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F83F65011
	for <linux-mmc@archiver.kernel.org>; Sat,  6 Mar 2021 04:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbhCFExm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 23:53:42 -0500
Received: from mail-vi1eur05on2064.outbound.protection.outlook.com ([40.107.21.64]:15072
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229642AbhCFExR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Mar 2021 23:53:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9uqh5rQsWENmvw+gi6wXKd7engZxLRS4SxiacnNmZFg8Pm4ZSo9Nje43ycwew51i/+g+oup5kyNr+FX31c7VdjGaEy7MCsnBPrY/+gW6mWfjEgLjQXC0/ZaqVu5L8oYluhlDt89ev/bQS2wIuwU6zjWVy3rHyXV6Rw477vvahrKZe6JYlWtFcwNQp41yXPVxPyKGD+/C9LBzaS24+OI3T/ISf9D41YySEpXEU4+TNE0mWI4iBCuX6etJ8BMHE+eaMCM0Er2b3Whm/GIDpXWFAj6A9vfr6txx6ss/RzkxC4E93A+0L6lLwgj63VTu40BWj4Hijw6ITqy0bn+N+pUYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuUA2QU9qloxqt+QSTxvE5d8mec/UpK0jqS2KrHLuE0=;
 b=MRX8SlcYq5n2nI9r6AfsrjuvcOamV2gWiajKM8hWWrzbvNGV59KBvDHhvFfU4OxHGHuYqdggFMBPaBDAkl9rB9hCU4fsASH9HwEyaKYeE8UYiKGcBzzmsqSyPGMRiWk7dyP6wWC5dAoqGWidylOmdHncYPjVjrrC7/rckVJJFlF/J94Pswl4zFQpPZRdATQpDvNu+AvYpLQtCZ8lg5PaGghYbkUXomirBFDzqbbYdTwHkCLwAiwYZJb+PCvCocz6Lv42TfUYRYkE+4VFLXbTzGz7yNKKIRa7Ks7WdvOVZaYGCMOm6gLymYgMu/YyTvGWjtVhQsiAK/+HR0hqSL/fAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuUA2QU9qloxqt+QSTxvE5d8mec/UpK0jqS2KrHLuE0=;
 b=n1EMcUtctKTiDFMiZ2G4yV55sTPgRsIswfjezlLqztx/DSmApjDuiNP+Pvsen3jy1OyuCioWAJu9OowwVWoLTXipE4AUx5lcyw1deEdgpXegqKQqD5abdMw5prB+7mjDF8z65e6KYqIBIUdq5/HptcoHEfYgpPtuDfVoVG6FGmk=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM6PR0402MB3445.eurprd04.prod.outlook.com (2603:10a6:209:7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Sat, 6 Mar
 2021 04:53:14 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359%7]) with mapi id 15.20.3890.033; Sat, 6 Mar 2021
 04:53:14 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Topic: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Index: AQHXCyWCn3zgwsr8UUWODcXlM3pVO6p1ejBQgAADM4CAAOgnIA==
Date:   Sat, 6 Mar 2021 04:53:13 +0000
Message-ID: <AM6PR04MB4966E330D7E51E3403050E1D80959@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
 <AM6PR04MB4966041BFFDDAF1EF00BE1AD80969@AM6PR04MB4966.eurprd04.prod.outlook.com>
 <CAL_JsqKK8t6XUqTuOKPzOviJbysqWqga_mdxWE0P0N4ejTgG=A@mail.gmail.com>
In-Reply-To: <CAL_JsqKK8t6XUqTuOKPzOviJbysqWqga_mdxWE0P0N4ejTgG=A@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1329d46b-a96d-464a-f8d8-08d8e05bc013
x-ms-traffictypediagnostic: AM6PR0402MB3445:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB344549455A1D1A1B4FAEA0E080959@AM6PR0402MB3445.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hDvPYohOOSAsfujOoEIyajSgH9Jd3495oE1UvM3IUtusdhMqZHgfZX0uJ211yiNdNtkzJEmFexTI+xjsUr8oh2z2q1gD7T/XWgtJlPs5aYI3eA+MQTZvBQ7npvGRXJkdrUuiW15FaFWZGxaG3xZxhttZtXalrws2DnaIZy5RXRWwaAn03/WyxmeQzZS+uFSot9df3lUYtdFn7dhL4clwKbpb5r8HZ56+bA5qlhDEzI0JLo44i4/ltBfWily55mM8gtH0Liu4MLx2a/cQMRr0HEnBVv+eSRiv0UCQ6qY+VZqfFKAUTZ5nX6BhE5frZAqsUV/hhtzksnZ8FCplHE8oh1xsLm2PxRxrKgIb1UvWbxkyDSYnT4ac9xApPodgkYnzDZNwI6wASUCu6gGQhJiczFTsWG/zwnlnpesHodR7IKTfY0gJ+UbXE9hLoWxqyi2KjIHh3PWrxlYPHwFjUjxIGXPl0VJHslDE3t0as6FIJ7zNtuo/oaypxsMpfWE5swbru20kJjgrJDNge9LaNvv8EyN5tR7pMWfLHzjZ27yYKTVAeTHgWB/CYWTQXEM0fMAs+4tVQan5NYfWU7JkNrBZFF+vbBLPtUkYaGqhB2nF1b0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(366004)(346002)(376002)(396003)(136003)(966005)(71200400001)(26005)(55016002)(2906002)(33656002)(44832011)(478600001)(83380400001)(86362001)(52536014)(7696005)(186003)(66946007)(5660300002)(9686003)(316002)(8936002)(7416002)(4326008)(53546011)(66446008)(64756008)(8676002)(54906003)(76116006)(66476007)(6506007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aUIxdEZWU2RPRExxNGJ0WXFFQTFtQ0xrNkZUeDI4R3BkRnhPRWkxckNLZmNx?=
 =?utf-8?B?QzVpVHFYOGRMR1hubVRBdFRuQ0hxQnJQclRLd3Fpc0RISnRZZUpwdDlsbHln?=
 =?utf-8?B?T3E2L0NHZXVMeEhTY0NlWis3eXkzNHBXM08rUzdJNFE0bEgzNWF3NCtJdERU?=
 =?utf-8?B?eDJ0SlNVSm8ydUI2S3dRMzRuamlSOWR1cERhb0Q3eDJuWnNxWGpjMkxWSExW?=
 =?utf-8?B?NXIrQU5HVXpaZThPRElYSVBLelgwMittY3BIY3o3VGs2aVFXRXJSM3BIbTNq?=
 =?utf-8?B?WS9JN2JwNnpYREk5S3Fsb1A2RXdKczMyVTBnaW9KcUhzV0F0K1BVSUEvYkZ5?=
 =?utf-8?B?bkFWYzNSM2NscDJJYmZCamlTRHhaRDFxZGF3TER6VlNjcU1LU2MrSGJwdHBn?=
 =?utf-8?B?aklLNXljeVJ2ZS9EdUhqSTQyblZpSWE4VmVUbm9wMTY5VVBQbC9ZSkFOTEtl?=
 =?utf-8?B?T1Voc2VKeC81Tk85Wi83K2ZVSW5VdWlIdDNxRHIxcm1vYStmR1loMFdRNlhX?=
 =?utf-8?B?a3cvRUkybWVjVzkrclB0T0JlSnE1VGMyczZDL1pMOG1FU3RpVDlxc3ZnUXk4?=
 =?utf-8?B?VEcycUFXcXlKNWJnTnVaTEdOV0NDV3VXR09tSVlITVc4UWJVekgyWCsyMk1X?=
 =?utf-8?B?TVZ4ZlpxcUE1WllLbjRBS3V1RDdsQmlESWZIL2dvekRQV0U5VjBLc1h2VWh3?=
 =?utf-8?B?TmZ0ODdwVjZITlV2NW1VQi94ZlBNd2gwYVhaL0wzRjZqNXRic3RtTStteHRj?=
 =?utf-8?B?UWltaHptMEZNT1JiVWpiUldLL2dKY2Jta3doa1U1UE42V0dCM3JFN0w3cjlG?=
 =?utf-8?B?MmZxelQ2cEpKM0gwUkJ3WjhEeXhlKy9tQnJ5TVlRWnlEeUVVMmwwTlJaUnV1?=
 =?utf-8?B?L3REVjhCK01ETnQrMXhHS0NpdmE4TFJvUVk4UFNhbStyblBDWTdBQUh2aHdD?=
 =?utf-8?B?RFVMWVIyOEFOQzBYZ0NZcWZmMHhhVDVFTm1QV0c5NWMyU2RLWEo4QWJqV01F?=
 =?utf-8?B?UGMyMmdUeTVjay8rdVR1TTI2dkZQNkdER2FtakFreStwKzExdkg3Q3VweVhZ?=
 =?utf-8?B?Y1NGTmhDaWFOa1RNTCs2MkpDWEVicTZlN0htTXhoMGJmYWRVT2hESU5EWVJN?=
 =?utf-8?B?Y0tJZW1sQ2xBVXl1SUtQSzRnRWFLcjNCMHkyMGlGMThNbmdHZXlybG5vUENF?=
 =?utf-8?B?SzgwbHdzejVwOEVHNnh0a0RBTzdxNEhHYXF6dWNmWkdocENZYXkxbHRmOU9F?=
 =?utf-8?B?bG8wWU9LcSs3VlQ3NzJHTjlrMll2V3h4elMvTy9rL2gwNXAxaTV2OUV0V2Yr?=
 =?utf-8?B?bWp3dTlRMGhybk5kNTdJOGJjUUt4L0s0bGlIYmRKb3BRblVxRTNXSWx0S01i?=
 =?utf-8?B?VTA1eDJtZ1VKem9Mc1JROTdDRzlobkUzL1kyY01UNDBaUDVYQi8rV0k5Z1BH?=
 =?utf-8?B?UXZBTXJaZHByL3VRSHVKeEFOWGpXbGZiVnZKV3lDcTloNG9ubGN6aGZhQW5T?=
 =?utf-8?B?M01GUVhSaEhZTFl1c01ZWWhxaXcwVFFLTUxTVzZORFhOUlNvZGw4SktTYmds?=
 =?utf-8?B?bTNJUDZndjI3cGsrOWFVQTZSOVgxWDlMZmFVSkh2emVISk9iamYydmI0VTY0?=
 =?utf-8?B?TkxsazJwa0NqRWVwelorRUlDeGloZUxiS3c4RWNDRnJpRXM2TEh1ZFBPbFRX?=
 =?utf-8?B?YnNCd0hDd1hMZ0dDNDJXbDRUUlVab3ArR1lOZUkxWWovN3NrdHR6Y3B5M1Rl?=
 =?utf-8?Q?EwOyL47DScPHaSPZhuvbI35f55UJSKRtPocq97M?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1329d46b-a96d-464a-f8d8-08d8e05bc013
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2021 04:53:14.1067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: onk02K2sJgIjNUpRzvFeE1u4790OQqD2z6hUgW7jDibUgHZLNGo83+fLdAS+3ZBb1H7/GcsIkSH7E0f1ID+v9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3445
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPg0KPiBTZW50OiBGcmlkYXks
IE1hcmNoIDUsIDIwMjEgMTA6MTQgUE0NCj4gDQo+IE9uIEZyaSwgTWFyIDUsIDIwMjEgYXQgODow
OSBBTSBBaXNoZW5nIERvbmcgPGFpc2hlbmcuZG9uZ0BueHAuY29tPg0KPiB3cm90ZToNCj4gPg0K
PiA+IEhpIFJvYiwNCj4gPg0KPiA+ID4gRnJvbTogUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9z
cy5ueHAuY29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI1LCAyMDIxIDExOjEw
IEFNDQo+ID4gPg0KPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4g
Pg0KPiA+ID4gQWRkIGNsb2NrIGJpbmRpbmdzIGZvciBmc2wtaW14LWVzZGhjIHlhbWwNCj4gPiA+
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlh
bWwgICAgICAgIHwgMTENCj4gKysrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwNCj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwN
Cj4gPiA+IGluZGV4IGE3ZmJkOGNjMWUzOC4uMzY5NDcxODE0NDk2IDEwMDY0NA0KPiA+ID4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlh
bWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNs
LWlteC1lc2RoYy55YW1sDQo+ID4gPiBAQCAtMTAzLDYgKzEwMywxNyBAQCBwcm9wZXJ0aWVzOg0K
PiA+ID4gICAgICAgIE9ubHkgZU1NQyBIUzQwMCBtb2RlIG5lZWQgdG8gdGFrZSBjYXJlIG9mIHRo
aXMgcHJvcGVydHkuDQo+ID4gPiAgICAgIGRlZmF1bHQ6IDANCj4gPiA+DQo+ID4gPiArICBjbG9j
a3M6DQo+ID4gPiArICAgIG1heEl0ZW1zOiAzDQo+ID4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+
ID4gKyAgICAgIEhhbmRsZSBjbG9ja3MgZm9yIHRoZSBzZGhjIGNvbnRyb2xsZXIuDQo+ID4gPiAr
DQo+ID4gPiArICBjbG9jay1uYW1lczoNCj4gPiA+ICsgICAgaXRlbXM6DQo+ID4gPiArICAgICAg
LSBjb25zdDogaXBnDQo+ID4gPiArICAgICAgLSBjb25zdDogYWhiDQo+ID4gPiArICAgICAgLSBj
b25zdDogcGVyDQo+ID4NCj4gPiBPbmUgcXVlc3Rpb246DQo+ID4gVGhlIHNpZGUgZWZmZWN0IG9m
IHRoaXMgcGF0Y2ggaXMgdGhhdCBpdCBpbXBvc2VzIGEgZm9yY2VkIG9yZGVyIG9mIGNsaw0KPiA+
IG5hbWVzIEluIERUIHdoaWNoIGFjdHVhbGx5IHdhcyBub3QgbmVlZGVkLg0KPiA+DQo+ID4gRG8g
d2UgcmVhbGx5IGhhdmUgdG8gZG8gdGhhdD8NCj4gDQo+IFllcy4NCj4gDQo+ID4gT3IgYW55IG90
aGVyIGJldHRlciBhcHByb2FjaCB0byBhbGxvdyBhIHJhbmRvbSBvcmRlciB0byBtYXRjaCB0aGUg
RFQNCj4gPiB1c2FnZSBiZXR0ZXI/DQo+IA0KPiBXaHkgZG8geW91IG5lZWQgcmFuZG9tIG9yZGVy
Pw0KPiANCg0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suDQpJIHRob3VnaHQgdGhlIERUIGl0c2Vs
ZiBzdXBwb3J0cyB0aGUgcmFuZG9tIG9yZGVyIG9mIHN0cmluZ3MvbmFtZXMgaW4NCmEgcHJvcGVy
dHkgYW5kIHRoZSBPRiBBUEkgaW4ga2VybmVsIGNhbiBhbHNvIGhhbmRsZSB0aGUgcmFuZG9tIG5h
bWUgb3JkZXIgcHJvcGVybHkuDQpUaGF0IG1lYW5zIERUIGJpbmRpbmcgZG9uJ3QgZW5mb3JjZSB0
aGUgb3JkZXIgb2YgbmFtZXMgd2hlbiBwZW9wbGUgd3JpdGluZyBEVFMuDQplLmcuDQpPcmRlcjE6
IGNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiLCAiYWhiIg0KY2FuIGZ1bmN0aW9uIHRoZSBzYW1l
IGFzOg0KT3JkZXIyOiBjbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIiwgInBlciI7DQoNCkhvd2V2
ZXIsIHRoZSBzY2hlbWEgaW4gdGhpcyBwYXRjaCBlbmZvcmNlZCB0aGUgbmFtZSBvcmRlciB3aGlj
aCBjYXVzZWQgZHQgYmluZGluZyBjaGVjayBmYWlsLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYXJtLWtlcm5lbC9DQUxfSnNxS0FPVUtuVkx2dS1WTmVEVmcwU2hYUHk1Nnd4aENRdjM4
K3JPMms5NjF2K2dAbWFpbC5nbWFpbC5jb20vI3QNCg0KQW5kIHRoaXMgc2VlbXMgbGlrZSBhIGNv
bW1vbiBpc3N1ZSBpbiBrZXJuZWwgRFQgYmVjYXVzZSBEVCBzdXBwb3J0cyByYW5kb20gbmFtZSBv
cmRlciBiZWZvcmUuDQpJZiB3ZSBoYXZlIHRvIGZpeCBpdCwgc2hvdWxkIHdlIG5lZWQgZml4IHRo
ZW0gYWxsIGluIGtlcm5lbD8NCg0KQW5kIGZpbmFsbHksIElmIGFsbCB0aGUgbmFtZXMgcHJvcGVy
dHkgYXJlIGZpeGVkIGJ5IGR0IHNjaGVtYSBkZWZpbml0aW9uLCB0aGUgZHJpdmVyDQptYXkgYWxz
byB3b3JrIHdpdGhvdXQgaXQgYnkgdXNpbmcgaW5kZXguDQoNCj4gV2UgY2FuIG5vdCBlbmZvcmNl
IHRoZSBvcmRlciwgYnV0IHdlIG9ubHkgZG8gdGhhdCB3aGVuIHRoZXJlJ3MgbXVsdGlwbGUNCj4g
b3B0aW9uYWwgZW50cmllcy4NCg0KVW5kZXJzdG9vZCwgcHJvYmFibHkgdGhpcyBpcyB0aGUgc2lt
cGxlc3Qgd2F5IHRvIGRvIGEgYWNjdXJhdGUgRFQgc2NoZW1hIGNoZWNraW5nLg0KDQpSZWdhcmRz
DQpBaXNoZW5nDQoNCj4gDQo+IFJvYg0K
