Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EE3C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Nov 2022 02:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiKUC4T (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Nov 2022 21:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiKUC4S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Nov 2022 21:56:18 -0500
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2062.outbound.protection.outlook.com [40.107.103.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C292F393
        for <linux-mmc@vger.kernel.org>; Sun, 20 Nov 2022 18:56:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwTUZCBZ/dQpshh+anr1FHOrRitVeyuhwJmjqa19GrwyB3mszDnnPxgqx5ayNPatzeb7Dk+yVDkM+Nn7d/MZeCPtI2E8t3wRQ3wOqSQPHk9WxeP+VqfxGeFU6ux6QAHcjXIze/swLnzuOaBx0T28g7HOnoDq2yatbN2ZJQkdhIrv6MqHFEYV0R8JBwYR+ake/umb6QiKZzfu//yq9gvLKwmqUJbX0OO49gOB1r+DBWDtG1Xq8WfU3llLCkpCB3qzgDoxPZN43U9S/3URJpkxKapVsByzP1IzlVIa3CrMtfCi8DWrHe2cNbRtwvFH7a2rl1X7La+CqQDXFtMtjuB3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aC88AGO5fRLtIvL4a4ikzlS2fj+UoE7MbTHxlcEP/Lo=;
 b=RemRkuVor0325yHPVA1xy1CbP1ZpsHlKc1W2iHaeYPlGTfc0eXu09ZfaKZXIC+OdmpJ7QRgFLgDlOuWtYkoQHuueHdB/rwFqwCWbYiqz0p2wmzbgVrczuSBhaA6lZMsPWMux4GZdNR52d2egq4lmNNlf9rhu9rxEpSV+OKXpIgLBqDFJZdeVIwjPuNVmLy9gdqGjWlI0Ji0Pq0v8EW5mtLyS+cGQWSU7oRJTj7BxOzWxAmaJI4qqdO0kXdqfPtEWwS57K30IjLXkX1K2ybh3l5YxFXf/uDbUmZQYraRRuFkK2VkjCQvHX76Khenc7J8xELhbk/pATSp9aFrC0detZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aC88AGO5fRLtIvL4a4ikzlS2fj+UoE7MbTHxlcEP/Lo=;
 b=CP07p2ULmQInmjOjr2/IxiL1WYTgAuX5x8gTrfZn2Do+6kPWphVJ0Wv+JnsIuG8wDW21x9+GPXDlwz6/chI5UKEk5hom8PSUMFmH9GTWzQ36PuimeMqMnaRehSRoDamEV45fRihbjK1wJjgnmsUSH2oK0q9WN4bjs+gMYZtk4Ag=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.9; Mon, 21 Nov 2022 02:56:13 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 02:56:13 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Sebastian Falbesoner <sebastian.falbesoner@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: correct CQHCI exit halt state
 check
Thread-Index: AQHY+8OhhplELoKopEe6dsWbTTAZ+65IsZdw
Date:   Mon, 21 Nov 2022 02:56:13 +0000
Message-ID: <DB7PR04MB4010BC0CBF94753397A8EB9A900A9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221119030400.1789919-1-sebastian.falbesoner@gmail.com>
In-Reply-To: <20221119030400.1789919-1-sebastian.falbesoner@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU0PR04MB9348:EE_
x-ms-office365-filtering-correlation-id: 3818bdd2-71c4-4b5e-686e-08dacb6bf36d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pybDUeYByLX1tEq5r+ZXh96lcdFr7aToJ8SLtOI+FwwyLt5JK0nvDpMG9DO6s6FDVKlIsGEhjnCEkC9ZIEAIhn6R5RdBC/5MoLy/eiB3jvMgfH4KTYqUxZtA7welysg6Acruqsy0csCaZQojVkG0MScngBqxopoBQQOdK6FFVJo99vdrLwEsmNht6YJG9KoOuWgK82wL4T/jW7oJAy2vRdzOdMQ9MMTJHctQrzCIV65JcvPF3deen+oNLjl9yrSdkKMVoeZBav0Oy8eYQ8tawBXj1lmj6VhmFzOdxI9n7wHGHlBr8emVJU6wornsdAQtDWcR5N11cKCRfThLP4oMXUM2KfXROYBMePjqBiP1rQsbBPSgzGVDCkUIzMVzgYGcKffIxGQhGIEd13QIrH63TdUPxCzODHXJmN/0beXHuhSdAZa9j877bg1XHuiO6bIZ0+NuisaYG1IRzICTn1Z51B8bSLdMkGW7p/SxJzUoFos0CUFj/Qk6hu1NmZMxkQWIhNHfTceHuT4Xou8f6H6DKRgBZo4cNs97ziZdBriRkCDTg9tK8xbgPQpI0s0NwtQIoy6SLy2Wf4s1K9PeoJ3BnxEzZeF+wgamci1K807EuMUnx79m9z5XsUpk6/MCM8NQCxZ4EZjGirWSaes6pSfwoU/+I0z/QqMK3Qjg8RzNfgNxdcs9Rd24mjlUNXgP/JvNI2vqleWFbpLSPcbCxMXNYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(38070700005)(83380400001)(86362001)(38100700002)(55016003)(122000001)(2906002)(478600001)(8676002)(4326008)(66446008)(316002)(66556008)(64756008)(110136005)(66946007)(76116006)(66476007)(8936002)(41300700001)(52536014)(5660300002)(186003)(53546011)(9686003)(33656002)(26005)(7696005)(6506007)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y1RZVDZTRVo4NmJaV1B6bU4xZlVNeG04ME1RM0lOVjBBK3RWQU1ka3VlLzY3?=
 =?gb2312?B?dWU2MjBoNWQ4R1NxUGJkNWRkR0lXTWR4TDlvWklpWTd0VU1sQVpJQU9MV2Rp?=
 =?gb2312?B?VGdPSnBJYmNoY0VVeWxFZHJzWFhyVmRHUmtxM1o4cHlNQ2UvdHBybHArVGZQ?=
 =?gb2312?B?NllBSW1kcm5wSFBxeTc2N0REUUMrUXVPRTJCcTlWWHh4NHl6dWIwb2M4Wk9J?=
 =?gb2312?B?QmRjdlpNbHN3bXhXbXNHSnA5RnhCakdTdG50SW5QN3hLM3hqbFVpdDA4VTJS?=
 =?gb2312?B?eG9GREFVMStXMU9JeWh4RUd1RDhMSmZzRCt2OW9OWTRlTWJzOTdNWDR1RDJQ?=
 =?gb2312?B?QUdhcXUvU043eTFrUjBySVF4cTRBV1p5aWlMRTNBVDRjVy9KUDhBYnY1NmNm?=
 =?gb2312?B?czZOUWZaem5PcVRWNWJ5anBQNllSL29MWDY4cHRJZEd0bHFZajU2REVjL3Vz?=
 =?gb2312?B?SUgvT0tmVzNTL01GOVprL3hnN0VlWUxDeitZbFdWYjBPZ2JsYlE0TkM1THNK?=
 =?gb2312?B?VkRMT1d2RldSNTk2TWRzNHZSNitDYVdpYWZyRmREaDUyU0Zvc1pyazZPOWRr?=
 =?gb2312?B?QzhiZGt0blpBSXlpcGFBRnV5TXRDMHM2eklSWDFKanA4aVo3cGN0T1g1MXRa?=
 =?gb2312?B?c1pjK0N5ZnVFWXhpdi9yLzB0MjYrcUJvUnlKM3gzVXlJbU1FZXpFZjhNV3JE?=
 =?gb2312?B?VEJYYXVGWjk3UVZaNEZpcHRoSkJPeTNXUmc1VU9yTi9oUWlHSGhicFNPRytO?=
 =?gb2312?B?MWFrU21nNHROK3Bxb3MrSkdFSGJsZ3grYjFncXlWVExKdWo4dnAxOGFqdDZ0?=
 =?gb2312?B?UDU0MG9GRTA1clpBTWNjYnFWYmV5SHVGelNxSmxMUlVDUjJORVA2Ym5GR2ZZ?=
 =?gb2312?B?M3hibW5hdHJNRHJzZGh1V1NNaWEvOXhXZ3h4RW4wTmpCcm1hM21BQnMyV2VZ?=
 =?gb2312?B?ODRMZE9RV3lsQktWUU9qL0NKODBjREN4aW5zYmhDb0J6Um15R1A5OXVjVWNz?=
 =?gb2312?B?OGNMQkJCVFU3NEtsREc2elVOVUFTRm95TXhyTkhNZjJtYUZQcDB6WTl1OUFq?=
 =?gb2312?B?dmZ6UUF5YmtCSW5vU2pVeFM2Q0JTQWpnVmxEcjdqTmVlZHBMYmJIVVFTUUdu?=
 =?gb2312?B?TUw4M2o5Q1diYVVUSmtYRVNhU0FQMWMvQldhLzhOQW04aEFIa1V6TWF6OStI?=
 =?gb2312?B?aE9FTlJFTDZDUkM4QzBDRXcyc1RNQjZPSkdNWE1xMSsyTXpIRTJFWlhuK0kz?=
 =?gb2312?B?aHB3UkF3VVRxSjlSWkdYakE3b0NmSE1EMHRCdmlwZmtyNGZCY3FvUlhzMTZP?=
 =?gb2312?B?UUU5d2JRVGkzVnJQQTF3eHFqbWhudzJRV0RrbXB4UGxCb290VWUzdDFVVFVz?=
 =?gb2312?B?Q0VCRzc0bGhCTXBkSWdNbDNsVm9Bcm1oS1dMYW5lRWJvbk1MN3NlMjJTTFZk?=
 =?gb2312?B?WnpWVkhPdWozam9ZSStSRFpYVDVmdGJHUXpDcnlabVk2Q0ZGdjV6ejFyYjlN?=
 =?gb2312?B?ZTdzYlJISzVBU0JlTloxTjVpajd1am1FVFczNVRKdW9QVWtZbFRhcGRXUS9q?=
 =?gb2312?B?bDF2U1pydFFZakJZVjc2TGVwTlA4VjVqMVhKL2YzeDFkM2U4eVpCRVRNOGZt?=
 =?gb2312?B?bXZXV0FwSmtrR1lja1l5WWJmRWpJN091WmRmcTI5Ymw1dC8wV1YxZEF2NE0w?=
 =?gb2312?B?bFR5UytoWmRTMndYOU5WNlF2SmdEMW43Tjc1V2xoaEtHRnFXM3ZTSFo1S1Mx?=
 =?gb2312?B?NjM4WHpkSUs3UHRBVTZtNnowb1RuMi9QL2RGYyt3UkwxVHBNYUd4M0lEeWR5?=
 =?gb2312?B?SVRSYzU1ZDJPMXUrQTlBQWp6L3lBalNSL0Q4MWVwcWcxL1htTFUySkdxYlVn?=
 =?gb2312?B?WjFBRGdlbCszdURVVDFtQ3ZGNWxpbTY4cFJhSXBLYVFHMVJBbGhDd3AyY1Zp?=
 =?gb2312?B?RDVmUUpsemFMbDVkNzBtdW1WMUlpT201dERSMk5IRVNYK3dDUHBIQWdjRkhS?=
 =?gb2312?B?SVhzQVRUbzYyUWR1TlArYWVkdW9oUkYvMFNoYmFpQ3N4b2JZb3c2bitHenFP?=
 =?gb2312?B?Q3VaNFZNR0lFUXdkUVJ5SnFTdmlpYVA1MGUvS2FHa2ZPNWc5M3pOUlhPY3hW?=
 =?gb2312?Q?VSYRdKJf3okJE8WAbboVL2j9M?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3818bdd2-71c4-4b5e-686e-08dacb6bf36d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2022 02:56:13.2163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: re0EgMWTvJwKiVLYisGByrAFVzGFWhpcJkfGSszJ6LOVlRAGxGJBVLEZCDHoe+4VInSM/iWktCzoXF0D0JnQoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTZWJhc3RpYW4gRmFsYmVzb25l
ciA8c2ViYXN0aWFuLmZhbGJlc29uZXJAZ21haWwuY29tPg0KPiBTZW50OiAyMDIyxOoxMdTCMTnI
1SAxMTowNA0KPiBUbzogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBC
b3VnaCBDaGVuDQo+IDxoYWliby5jaGVuQG54cC5jb20+OyBVbGYgSGFuc3NvbiA8dWxmLmhhbnNz
b25AbGluYXJvLm9yZz4NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IFNlYmFzdGlh
biBGYWxiZXNvbmVyDQo+IDxzZWJhc3RpYW4uZmFsYmVzb25lckBnbWFpbC5jb20+DQo+IFN1Ympl
Y3Q6IFtQQVRDSF0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGNvcnJlY3QgQ1FIQ0kgZXhpdCBoYWx0
IHN0YXRlIGNoZWNrDQo+IA0KPiBXaXRoIHRoZSBjdXJyZW50IGxvZ2ljIHRoZSAiZmFpbGVkIHRv
IGV4aXQgaGFsdCBzdGF0ZSIgZXJyb3Igd291bGQgYmUgc2hvd24gZXZlbg0KPiBpZiBhbnkgb3Ro
ZXIgYml0IHRoYW4gQ1FIQ0lfSEFMVCB3YXMgc2V0IGluIHRoZSBDUUhDSV9DVEwgcmVnaXN0ZXIs
IHNpbmNlIHRoZQ0KPiByaWdodCBoYW5kIHNpZGUgaXMgYWx3YXlzIHRydWUuIEZpeCB0aGlzIGJ5
IHVzaW5nIHRoZSBjb3JyZWN0IG9wZXJhdG9yIChiaXQtd2lzZQ0KPiBpbnN0ZWFkIG9mIGxvZ2lj
YWwgQU5EKSB0byBvbmx5IGNoZWNrIGZvciB0aGUgaGFsdCBiaXQgZmxhZywgd2hpY2ggd2FzIG9i
dmlvdXNseQ0KPiBpbnRlbmRlZCBoZXJlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFu
IEZhbGJlc29uZXIgPHNlYmFzdGlhbi5mYWxiZXNvbmVyQGdtYWlsLmNvbT4NCg0KVGhhbmtzIGZv
ciB0aGUgY2F0Y2guIFBsZWFzZSBhZGQgdGhlIGZpeCB0YWcgaW4gdGhlIGNvbW1pdCBsb2csIGFu
ZCB0aGVuIEkgY2FuIGdpdmUgbXkgYWNrLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIGNoZW4NCj4g
LS0tDQo+ICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBiL2RyaXZlcnMvbW1j
L2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4gaW5kZXggMzFlYTBhMmZjZTM1Li5mZmViNTc1OTgz
MGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMNCj4g
KysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1lc2RoYy1pbXguYw0KPiBAQCAtMTUxMiw3ICsx
NTEyLDcgQEAgc3RhdGljIHZvaWQgZXNkaGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3QNCj4g
Km1tYykNCj4gIAkgKiBzeXN0ZW0gcmVzdW1lIGJhY2suDQo+ICAJICovDQo+ICAJY3FoY2lfd3Jp
dGVsKGNxX2hvc3QsIDAsIENRSENJX0NUTCk7DQo+IC0JaWYgKGNxaGNpX3JlYWRsKGNxX2hvc3Qs
IENRSENJX0NUTCkgJiYgQ1FIQ0lfSEFMVCkNCj4gKwlpZiAoY3FoY2lfcmVhZGwoY3FfaG9zdCwg
Q1FIQ0lfQ1RMKSAmIENRSENJX0hBTFQpDQo+ICAJCWRldl9lcnIobW1jX2Rldihob3N0LT5tbWMp
LA0KPiAgCQkJImZhaWxlZCB0byBleGl0IGhhbHQgc3RhdGUgd2hlbiBlbmFibGUgQ1FFXG4iKTsN
Cj4gDQo+IC0tDQo+IDIuMzQuMQ0KDQo=
