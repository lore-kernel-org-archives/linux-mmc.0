Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CC9C83F3F
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Sep 2023 08:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235070AbjIDI6b (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Sep 2023 04:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbjIDI6a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Sep 2023 04:58:30 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDBB10EB
        for <linux-mmc@vger.kernel.org>; Mon,  4 Sep 2023 01:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXFWiPz5IDHQ3PkJqmI/zCSH0pQLr8dCIrmHmB6fQxLsXGPPgsxdLLSQycJDgUNo8C2qE9pMR6+6uy2dv4X0glgdqkWrnnzVBZn8L6kk/0+dluQyxwkqEUzQWKWvm7nDegEYwaY4OylVF9Fp+b1XIg3GE/mILk8gmtyxbclIMOggEEG5mMMQMPQu+m83ufn1mi/2Li4mBRWc/uBJ9tqhirAkIMJCrWpcfdF51HkMxPMxLOu5FgGG9zcCc8tJADguywShoDPhATt7u+e4aI6a1u87+iW/ygXg7xr5XzEYVq/tY+CaVSZeIPsZdXvs1X4kg/EBY1Eyduqfl+TZBlkMzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYePVN1p1JyfFhO5cXT1ZZ1EbeV8bDXCk8C5Ryap+2Q=;
 b=U3UEBsN/VzCK7aB73QVlX7TAuEqClrt+hg80wxXLOha0Z2pwB9avmfidYLALuZW8OluwCuF8Dl+DzrVnqWxlf9UPjKoeaimF9NdoC/Szkxq/N1E8Q0yGep9Ppf4fXfqPXgMpmihgEaB6558gQNXkZitMLxGqMnrDgHA3jO2GCMvn7PWjvJC341XxmoFMRpsVtPHXyaEmByjXgR3xA9rKCw438Wc9DKKSVD3N+P3/sdFuCEEuXTk+NrBWphacXueMf/FruOzV4h3+mZDCuFTLdNPG01ORBNl5yzgEcovKI7Bkn1NOm1vlj/F9I2441QfWtM7rS/a+W41GGo6D7rR/YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYePVN1p1JyfFhO5cXT1ZZ1EbeV8bDXCk8C5Ryap+2Q=;
 b=SJH1OqW1QpJOAQc0uACnfjDj5JfDqo8g6fModvnUnNGscngfp96uRHzsIGyKhI+PnXIEuJo+u/cdvcsL48JvlaHr+w0gTIeJQQWlZdFi/nfCvYpXnTdhdAZAyQkNIBp1yTXQiC+kiZH0VbDFVg/lzOKuvm5EObzE2XTe3VOOYRY=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8696.eurprd04.prod.outlook.com (2603:10a6:10:2df::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.30; Mon, 4 Sep 2023 08:58:00 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::d73c:e747:3911:dcc%5]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:57:59 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: RE: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Thread-Topic: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Thread-Index: AQHZ2yVAPHzNo/yXokSwCK3W0R3Ss7AKWJ2AgAAJi9A=
Date:   Mon, 4 Sep 2023 08:57:59 +0000
Message-ID: <DB7PR04MB40109C366E0C76C9E5758F6090E9A@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230830093922.3095850-1-haibo.chen@nxp.com>
 <24299751-8b13-fe39-07a0-a9e9111241c8@intel.com>
In-Reply-To: <24299751-8b13-fe39-07a0-a9e9111241c8@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8696:EE_
x-ms-office365-filtering-correlation-id: 3a6a1a11-7722-4c50-78cb-08dbad250a2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EMlta4VYdMfERzMzBp5LaBRGI0L8tTfyHefUuZqjC5OH2rAJU5SAXog0pMr3qoFIgK4mG7bSL47/Nhdc+lQhoxMQTMcru6/9hoXV8+npC9iU2HXKxFqQikn/lNYrfGG8Okzh8fkwbUc/e3qC1+MLfhbKHXeWd5vkNQwRhsqyNh3MekRZvOMVasd3oqMKjXHcHBcy/PlClFi8IlsR49wk2AG6dLbe+p2A4G5NHaoQQ96kR8vCBzW45AP0CWcQS3OrDMdxmpdizDWB+tA7YTjemdTCZjuNx+pQfygqf+NvS2pwsMFhmunJlBkjxSjLNbugXhoG+8A88VCtnYzxtHHdqWuMj/5js4DNCllombwTBM4I6vijkj1cD6hCvi1qLf8RSuTFB4B05iX7k6w2OrNYSYZ2pZvEaTFBUvS/u2/jkBlHKfKE1sQI3kb+LddUMHVrVGCvePwRW54mKnVqL8X0eHay+YmvnUm7RUEz/DA1BkzvN+uN1EAaXyT5ALvfmCNFzPc+nw1eeq0+dwLo7OL/b0kK0ZL2hBtR96497IrLWaJs6GOHeLX0Dmq8fWcArO557mOuDdm+4wvaozgsdNYhUq4dJYgNiBg6UWes6W4VxTTuUOtr6UTFCEa/2PaEcrmm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(8936002)(41300700001)(83380400001)(55016003)(478600001)(71200400001)(2906002)(76116006)(66946007)(5660300002)(8676002)(110136005)(52536014)(66476007)(66446008)(66556008)(54906003)(64756008)(4326008)(316002)(9686003)(53546011)(6506007)(7696005)(26005)(122000001)(38100700002)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck94Q3pOclprcVl0ZU0wSDI0Z3JrK3RpSE9nU2pqMXZPbkxnU0ZYTTROSEdC?=
 =?utf-8?B?dkRLZm9Gbk40QUREQWtRazV1WGZkUnVWVFAzamZZMGNxVStmVXljN3BlY2wv?=
 =?utf-8?B?N2c4N0FSbW4wdDRRdHhpVXRZSlNSNVpBeWJkY1c1N05iRHh6Q3hqR2p4TVhI?=
 =?utf-8?B?SHlsNE5TRzFJM1M0N2FNQUd2Q1lZWEJGK29XSG9lV3FYeWdLUUFhRmtNc005?=
 =?utf-8?B?M3ppanIxSEZ2UUhEeUsvSWdrVEpwa3dncWhIbGNvQjBQRFBqL05KTFB6UC9Q?=
 =?utf-8?B?MkxFaHVOeFlCYm5wNFo1UURlb3J1cUNpRWdpYjFGYkwvT3RkOEZ4ODRKb1ZW?=
 =?utf-8?B?Qk1iQnMvYlNabkY5T0htQWJPTzE0S1Q1SGVGTEdkbVMyaVZhbmFVMnF2S1hZ?=
 =?utf-8?B?ZWZIb3FOVW5LQnhqZkE5aGhJdk9xMHFaYWRwRkhlRDhKSkp0VkZsN1gwMFY5?=
 =?utf-8?B?bHBhVmYyR29ZQWdvUEVKaEdJcUZwWnBvQkJnSUdQSzEwZU9tTklWUUVqVXlI?=
 =?utf-8?B?VzFoMVZzeCtRK1dRNHJxamIzaXY0bllrQjB0alN4NkhFeHhTaHd6djE3Q3NM?=
 =?utf-8?B?UXZoaTBRUHFJeHRWTmNLWHFtaVN5eGZVdEJXVzY1LzNad256RnNGaUJLNDJZ?=
 =?utf-8?B?MWhjNjNqZjc3NG9jSTVWR1lVbHJkbzA2ZW5DY3hPSnNoQ3FuMFdKM3ZZc25T?=
 =?utf-8?B?YlRVZXhMQ3ljSVFmNjYzcnpDd0FhWkZ4NmpvTmx3VnlVcm1DVUNnWFEzWXpx?=
 =?utf-8?B?K3lTZUpVRnZRZmRtajhCVlpEZ25KZ3k0NGhtSG5ONHNIcC91TlovWFhOQVln?=
 =?utf-8?B?ZVAzOHZvbU82ZTd2cVRwem9jVzZ4RWFZejNEWW5rRnVjU05wUFNWU2JNQXMz?=
 =?utf-8?B?MVVUK3F5a0s5Mjh5VHRxMkVnSjRVU3pEUFlzNXNlQmJJOTUzNGV4WGswMGk4?=
 =?utf-8?B?KzVheTZHY1lNczNjOEZKT1VIRlhHeFk1MDFiK0NVNzNuVVNaY1R0OU9yb0NE?=
 =?utf-8?B?ZVlLbElqSXY4V211NnVsZ09tZkNhbEx1UWZZSmFkY3kxQ01mU3NGVkRYUjFY?=
 =?utf-8?B?YThMTHg3R0p1STdSZmt3TkY5M1kwdW5OS0VMVDc2R2JhQStPdmgvcjF2Smov?=
 =?utf-8?B?UXNGaGdHWFVPK09mZ05kQnYvc1FjVzlNeGRzcU1KZ3BnY1pCOTJXSHZwLzdR?=
 =?utf-8?B?SkRWSjNMYjY5Ulp4RUh0NVhja3d0ZzNuV3oreEtLbmN5Mmx1QVlPT0JkM2ND?=
 =?utf-8?B?YjdMMytxUGhhZi9VS2QrWFBoWUwzWEJUZ24zRTVFYWNUMHcrZGN5QmcrVjRh?=
 =?utf-8?B?OTRYeklLc053ZFAzREZnVUVGLzhhL2FtYk5WbkJrZHdJVStUUmtCVk9sRFpF?=
 =?utf-8?B?djc1Z3ljaWdvMUlSQVNPTyt1UURKaGxxeWZTeWdFcS82NFFaZjRBZTVSMDJq?=
 =?utf-8?B?K0NzNTFTQ1lIR1FnZWlKUGtUZW55c0RRNVQ4SlY2ckxZZ3p1UE9icG1FM2pz?=
 =?utf-8?B?RmxMSW9qb1hZWTFERExmY1cxNHYycHAyN1NZTjd5VEJtVXNpaDJtcE9sS1dz?=
 =?utf-8?B?c1FySFlwd0ZXeXZ5TExLcjM3Ym8rck5uVDNHY1UxaTA0SDFaSmF0RzY0V1o3?=
 =?utf-8?B?L24vblBSbHBsVkdoWWxxZUxES1hjUUpIRHdsUnE5YlFuQjNuMDZaSmZlcWNF?=
 =?utf-8?B?Skl5UUk3Nk0wQ2d5MXQ0ZThZQ29tWmx4bVlwejNlK1pDbkdRVzZZdlk0MVdR?=
 =?utf-8?B?Qi9sMkk3R3lGYmM4MnlNdWpvWkZ3eHV1UVVzdEFEVDl3NWRvNkpRU3AvL3Iz?=
 =?utf-8?B?dW9zNGxhRzcxdkdGZDMyZTQvTVhkNVNFcjRlY2gva1NwbkpualBuaVVHUGlU?=
 =?utf-8?B?YUtvN3NSZ1lpTHI3UmhYNXVLZ1BRK1lndVZ4dURzS21WTS8xUDBsd2NXM3Fh?=
 =?utf-8?B?bTViZU5iSVdoU2R3SjF5bnZVaExaZ0FFNlZXWTlqT2dkeWwvR29wc1BpVzFr?=
 =?utf-8?B?NnRtQkVNMGFnanJHTVNNK3gyTE1XUjFGaGJ5ZjI5OFhWVkdPZ3RXQzNZaHpr?=
 =?utf-8?B?Vi8rUFJCTFU4SERNSmp5WFd2NVJScm5WRCsxVHJtd0ZuSnc0Zy9mWlhPVXBD?=
 =?utf-8?Q?l9iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a1a11-7722-4c50-78cb-08dbad250a2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 08:57:59.9062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kO9FSfvciPiYuBkeQM0KuVVL3y4DEVjsC2kAZhFGOAjQV2mIJehPsVN+Dh4/gu58qC/liGkgblem7LJttoxYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8696
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBZHJpYW4gSHVudGVyIDxhZHJp
YW4uaHVudGVyQGludGVsLmNvbT4NCj4gU2VudDogMjAyM+W5tDnmnIg05pelIDE2OjEyDQo+IFRv
OiBCb3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3Jn
Ow0KPiBsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4
LWlteEBueHAuY29tPjsgaGthbGx3ZWl0MUBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gbW1jOiBjb3JlOiBzZGlvOiBob2xkIHJldHVuaW5nIGlmIHNkaW8gaW4gMS1iaXQgbW9kZQ0K
PiANCj4gT24gMzAvMDgvMjMgMTI6MzksIGhhaWJvLmNoZW5AbnhwLmNvbSB3cm90ZToNCj4gPiBG
cm9tOiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiB0dW5pbmcgb25s
eSBzdXBwb3J0IGluIDQtYml0IG1vZGUgb3IgOCBiaXQgbW9kZSwgc28gaW4gMS1iaXQgbW9kZSwN
Cj4gPiBuZWVkIHRvIGhvbGQgcmV0dW5pbmcuDQo+ID4NCj4gPiBGaW5kIHRoaXMgaXNzdWUgd2hl
biB1c2UgbWFudWFsIHR1bmluZyBtZXRob2Qgb24gaW14OTMuIFdoZW4gc3lzdGVtDQo+ID4gcmVz
dW1lIGJhY2ssIFNESU8gV0lGSSB0cnkgdG8gc3dpdGNoIGJhY2sgdG8gNCBiaXQgbW9kZSwgZmly
c3Qgd2lsbA0KPiA+IHRyaWdnZXIgcmV0dW5pbmcsIGFuZCBhbGwgdHVuaW5nIGNvbW1hbmQgZmFp
bGVkLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAu
Y29tPg0KPiANCj4gVUhTLUkgaXMgYWxzbyBub3QgbWVhbnQgZm9yIDEtYml0IG1vZGUsIGJ1dCBJ
IGd1ZXNzIHN3aXRjaGluZyBtb2RlcyBpbiB0aGlzIGNhc2UNCj4gaXMgYWxzbyByaXNreS4NCj4g
DQo+IEFja2VkLWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4g
DQo+IEZpeGVzIHRhZz8NCg0KRml4ZXM6IDZiNWVkYTM2OWFjMyAoInNkaW86IHB1dCBhY3RpdmUg
ZGV2aWNlcyBpbnRvIDEtYml0IG1vZGUgZHVyaW5nIHN1c3BlbmQiKQ0KDQpOb3Qgc3VyZSB3aGV0
aGVyIHRoaXMgaXMgdGhlIGNvcnJlY3QgZml4IHRhZywgc2luY2UgdGhpcyBjb21taXQgY29tZSBm
cm9tIHllYXIgMjAxMCwgYXQgdGhhdCB0aW1lLCByZS10dW5pbmcgZG8gbm90IGV4aXN0Lg0KDQpt
bWNfcmV0dW5lX2hvbGRfbm93KCkgaW52b2x2ZSBpbiAyMDE3LCBmcm9tIHRoaXMgY29tbWl0OiBi
ZjUxN2Q2ZmVjNzEgKCJtbWM6IGNvcmU6IEFkZCBtbWNfcmV0dW5lX2hvbGRfbm93KCkpLA0KbW1j
X3JldHVuZSBsb2dpYyBpbnZvbHZlIGluIDIwMTUsIGZyb20gdGhpcyBjb21taXQ6IGRmYTEzZWJi
ZTMzNCAoIm1tYzogaG9zdDogQWRkIGZhY2lsaXR5IHRvIHN1cHBvcnQgcmUtdHVuaW5nIikNCg0K
bWF5YmUgdXNlIHRoaXM6IEZpeGVzOiBkZmExM2ViYmUzMzQgKCJtbWM6IGhvc3Q6IEFkZCBmYWNp
bGl0eSB0byBzdXBwb3J0IHJlLXR1bmluZyIpID8NCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBDaGVu
DQoNCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2NvcmUvc2Rpby5jIHwgOCArKysrKysr
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgYi9kcml2ZXJzL21t
Yy9jb3JlL3NkaW8uYyBpbmRleA0KPiA+IGY2NGI5YWM3NmE1Yy4uNTkxNDUxNmRmMmY3IDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gKysrIGIvZHJpdmVycy9t
bWMvY29yZS9zZGlvLmMNCj4gPiBAQCAtMTA4OSw4ICsxMDg5LDE0IEBAIHN0YXRpYyBpbnQgbW1j
X3NkaW9fcmVzdW1lKHN0cnVjdCBtbWNfaG9zdA0KPiAqaG9zdCkNCj4gPiAgCQl9DQo+ID4gIAkJ
ZXJyID0gbW1jX3NkaW9fcmVpbml0X2NhcmQoaG9zdCk7DQo+ID4gIAl9IGVsc2UgaWYgKG1tY19j
YXJkX3dha2Vfc2Rpb19pcnEoaG9zdCkpIHsNCj4gPiAtCQkvKiBXZSBtYXkgaGF2ZSBzd2l0Y2hl
ZCB0byAxLWJpdCBtb2RlIGR1cmluZyBzdXNwZW5kICovDQo+ID4gKwkJLyoNCj4gPiArCQkgKiBX
ZSBtYXkgaGF2ZSBzd2l0Y2hlZCB0byAxLWJpdCBtb2RlIGR1cmluZyBzdXNwZW5kLA0KPiA+ICsJ
CSAqIG5lZWQgdG8gaG9sZCByZXR1bmluZywgYmVjYXVzZSB0dW5pbmcgb25seSBzdXBwcnQNCj4g
PiArCQkgKiA0LWJpdCBtb2RlIG9yIDggYml0IG1vZGUuDQo+ID4gKwkJICovDQo+ID4gKwkJbW1j
X3JldHVuZV9ob2xkX25vdyhob3N0KTsNCj4gPiAgCQllcnIgPSBzZGlvX2VuYWJsZV80Yml0X2J1
cyhob3N0LT5jYXJkKTsNCj4gPiArCQltbWNfcmV0dW5lX3JlbGVhc2UoaG9zdCk7DQo+ID4gIAl9
DQo+ID4NCj4gPiAgCWlmIChlcnIpDQoNCg==
