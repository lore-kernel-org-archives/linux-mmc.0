Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831DBC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Oct 2022 11:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJSL4a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Oct 2022 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiJSLzp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Oct 2022 07:55:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on20617.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::617])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF47F20BE3
        for <linux-mmc@vger.kernel.org>; Wed, 19 Oct 2022 04:34:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhnjgUdnRqp/WsUnK2wtHfiuJrE1OrzvmxC1tL9ftI7lDauUFCN82q3MbaZx6bC7WRbt4BlXnDDhc/8DI4dvVo1x9rxvckHywVo3aRI+UbhIiMNfnIcWdqFeUCC3RQiEotUEEtG6pO/IkeLBiDImgtZ3lPZN76iBfWTDhxdv4JEPBKM5kr2BBEE6nGf/DFahdJgDTfa9Y/aqN8OAX7UGO6Wg+doyXjCU3W7fNvNoEp9SQ78dPNouewkBLTm5U2b9qzEXVgLT2Vek4h1WZ9Pjf1SkTgCa/H6ncTar2PdbGIPY4b0DbQwRrbaNvhooLtjgQKPUPBTBB3bFTNn3NWwjXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5ebwUfa/rfaahrXJt45jL/EHrq+S3+Ky4dgqQGZPds=;
 b=l7hnNyE6LiLct/E7158nksYj4emWRtew2C1Mdc1XmhN9OXqMETI8aWRy15az46bpspQrNGV4CGtAkG5PAck7alKZqlZl3pXvUvQg0kGudtPhXJhT8TNnO0CX7ai5WEdKhvs0h1ZKlqRqo2tsftjqwljAlCF2ZC9OUvTdar47c8BZS9ymxU+Uf9dQM4FCF7kqLTzf7F/FJo2/U44LE6x8HHRSiVkQh6uoaUZaTtu9itQcFZ09VKM5k3bbwvyRv3HUTx0CwWdtThd+eDeMYLnAv2ZLCXvPSYvBs5wLg/yC+mTAqrn67iJUQukQ/yCJ8vyd63v5CGJiGK3omzqZdXYsww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5ebwUfa/rfaahrXJt45jL/EHrq+S3+Ky4dgqQGZPds=;
 b=fn560WrenrQvXi+hTegirSpQjyu+yoq9oDD5WeBKsSWPN83Yrt2cwij2kLFvS4e7l2+qX3Wcj+BlW8qt0KnzQM2+64jhP9jIzqvIdlWnBtYQ/8Ixc5qQuKOSrQb8O8u1OXTaLHKNbwQc1hxf7gkV4L51jg11elxsworHwTxfO0M=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8551.eurprd04.prod.outlook.com (2603:10a6:10:2d6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.21; Wed, 19 Oct 2022 10:48:52 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::4cee:c7ba:1bbf:1c27%3]) with mapi id 15.20.5723.034; Wed, 19 Oct 2022
 10:48:52 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: RE: imx7d: Timeout waiting for hardware interrupt.
Thread-Topic: imx7d: Timeout waiting for hardware interrupt.
Thread-Index: AQHYb3KKHoAc9X39aUeZYJ5mNEqnn60vYhyQgAImrQCA43LagIAAUS2AgAEkSGA=
Date:   Wed, 19 Oct 2022 10:48:52 +0000
Message-ID: <DB7PR04MB4010FBDF45A7BDD40D02004E902B9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
 <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <CAOMZO5Dmk_OWTZGEafTZO451Zo6W8UMUJAZguW85y0b2BmCpWA@mail.gmail.com>
 <CAOMZO5CYvbd3uTKxq6suyn5H0yNU1R7tsgbawNdwjEbKgdt6bg@mail.gmail.com>
 <CAOMZO5C-5M8y=V1L6Qdqymhb-1oOpBszFwuWCxedUJ1oO7=ADw@mail.gmail.com>
In-Reply-To: <CAOMZO5C-5M8y=V1L6Qdqymhb-1oOpBszFwuWCxedUJ1oO7=ADw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8551:EE_
x-ms-office365-filtering-correlation-id: 76e05f32-6f3c-43eb-88aa-08dab1bf833a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R3vGXmulsUaP2DDw+1JiP4I1w3V3ff83p/7VpRsd5bZlc3x9HnKmMZFq0jNqF3Mg9CR5c1A3DHrMJsxUQYziF16HjVMLcLb44/R5dEI5kzN8ATM7XmyON/MQ4V8AQ8rENWXi6XsCC1lIG9Myt7u/2olEQqfW8f/AqDaLuSUW4gOVIshN1wL6KFOlvP1gLJw7Hk7WSuDv6MAFCqMDxySuHXl/jymQbwBZcrg+vkCqCqodlnKLKPMQ7bYiua0Wd3j06ggI5PCoPIsdStQVFeL7mIJJm0E10WXVhmmZnmGQ8yzBck1IQ7VbcBDSKXLINrTaXBeCjEYN7sWCiOdmL0hNbw6Pa4wOEulFn2b9JQbykP3o+q1glcBrMTDP1kAG+to26CsmCyP/1ci0HlS1S/V1bUXkbK5pVcmXghJ1JrIglD3TvhHOWqwIfrC7uOLiC8UXIeBLY0KELtq5kLx7zur2btfF6XdBJt4L0PzrLOftL7w0CQYX/uKC0Lu8FLZWb4ylX7kpgZHwGireEkEjMQ9kOVquFn2Z3TjnfHBEIa5srDI7tGHyDMZGbzfVzZcIrG/UAMgBN2Ml3SKenmN2FRJJDtHxn3HoH7rOZWtmXhLuD+h19OYC8lUjOtf5NdKPloxTfxTI+3Ke8NRDyjb0zO0wD/J4kD+zGdX4gedtc5hNehqyYhubTX4tdXu73EHw5g8qee36PaRg8x3VtxJcBPvMiMdjrWYtFEuB9bLZWo61n03+xGJfoPswwcA+mw0tD7iptbIfGC7V5UrprPJFQbCShpNWhdWRCBKIu4YQ5nnFHeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199015)(55016003)(6506007)(7696005)(33656002)(41300700001)(9686003)(76116006)(26005)(66556008)(478600001)(66476007)(8676002)(64756008)(38070700005)(66946007)(4326008)(38100700002)(2906002)(71200400001)(86362001)(966005)(53546011)(66446008)(316002)(5660300002)(52536014)(83380400001)(54906003)(122000001)(45080400002)(8936002)(186003)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?V1FobHBpWTBMcVhCbzFGWXU4YmREbUtTcFNrdHgvLzRTM0drYlV6NE9Mc1Nk?=
 =?gb2312?B?anYzRjNkMXYyVHZ3bENLR2NXK2ZSa1NGdkNJT21WY3lCNWtnS0djYzQ0SjJk?=
 =?gb2312?B?Ym1iaDlNdVBDT0wrNW44MTJrMDhTOS95dnJ0Mkg0K3g0aEU4dGtBSm1RY3B2?=
 =?gb2312?B?UkpCbzhpdDVzZ3pBTXBXdmpoeWhqNWpTT2d6UStXMVcxVTNZa0VEK3ZhTVBx?=
 =?gb2312?B?OFhQdkJrY1ZNSDRLQS80OEZWK3Q0V0trbmtER1A4NmNiTmtVTkh1S0JIQ2xk?=
 =?gb2312?B?bVJIM20rMWQwRmNGL2lIWldQNE1odzI0bDdLRnR6MzZteXplL0lzVHZBbEVi?=
 =?gb2312?B?aGVweG1wT2pSZlVhVlJwSFN5UHg2Q1I4YkZEU0lpeG15enpwZlNhd3Q3Kzhu?=
 =?gb2312?B?NUFVcWtvTDZ2ZnEzM1l5c1lsdFFGQmgwbDBYSFhEbk5OdUZQa29rZmw4VzBI?=
 =?gb2312?B?MVRQdDY2aCtXQXhuam81amdxenY0ZGprZE1lSE95THl5aVRPQ3FlU0JtNkY5?=
 =?gb2312?B?Qm5PVkdHeUV0WVRZQSt2T3Y2N2U5VFpmdzZkbmpha3FPSm4xOUorbExBSVhD?=
 =?gb2312?B?OWhjWlpaTDI3amhJd1lNam1sOXdSd0lQN2hsdW5VMW9rV2RlbkRNcE1hazlP?=
 =?gb2312?B?MlptQ214SENWdktucHdIbVlDaHlBYW9VdFUwdG1XcHVLRHFZYnpVWUVub3JG?=
 =?gb2312?B?TzdPTzErU2JxYlVMdDczdVpwQW9qLzNrd1locXVQUEc5R1BiU0ZlTDV1Zk9q?=
 =?gb2312?B?MXB4SEVZR2laWDI1NW10ZFpsL0E3SThGZi8wVDNTNDViNTFkZjF1bklod0ZI?=
 =?gb2312?B?MlBzcEVydHZMQXNQNDJvcjg5RzVXWURSZzBlRjJHamxWY1VIK1hNVjdPdFVo?=
 =?gb2312?B?T0krR2FUQk9tZ29IdFBmVmFkUG1NZTFMdEUxUElJQXZrbC9JZ2JSMW8vM3Bv?=
 =?gb2312?B?RWt2cm1XMjBLdSs0ZjZHa3JIM0F0bVpYMWtQRlFHbVA0WmFoWSthaC9USndX?=
 =?gb2312?B?bnFtVGdwSlBxT2lNSWkzVTN3M2J3RWdoNGlxeVpaM2RSaW5peFZKZ2pyOFNM?=
 =?gb2312?B?c0hxcVpJWmU0bHgrTy9yUGlXeUR3V0htZ1cvcXNSelVNMzZlMUNybUlDL0tG?=
 =?gb2312?B?ZElESzl1bHZWMHNYUkhmZzRodGJwakpjTzRDRzU2T1VqV0o5Vk9xSUQ5T2l0?=
 =?gb2312?B?cXhYK2FuNFkwMmw0SWliVktBVCtlNEdZY291YVBUdUo3V29USmNqY0ZuSWN6?=
 =?gb2312?B?dm5ieGpKc1IyTXVlRTVaZ3Y1RW5WOUFiNm5SbFJaT0hvcFVqWXh1ellSWTBF?=
 =?gb2312?B?THJ3T2ltMmVUT1ZLdHIwcU5WQkVDcnNXdjV0VHAyRnRmVFY0MGNtUDlIN3FP?=
 =?gb2312?B?cHBLV0dyQkhHZVZHZG1CdU1ZbVBDSE5TUnArNEJZTEtCYkVvUEEyUlFTOU1t?=
 =?gb2312?B?dEJOekVsMGQ4VktiYXBJTEhxNk0rZU1Rd0pxSU9JT29EcVNOMFl2S3llMkhD?=
 =?gb2312?B?MjEyWnFwN1NXbERFMjNkMUdnR0E4L3lKUDNZc25XMHBDRTA3dkNxbmpLVVhw?=
 =?gb2312?B?QjNMeENmcFRISGhkOFFyYTd1dnFWZE81KzlJS0hsdi8wQ0orVTlqV3VUUmFZ?=
 =?gb2312?B?ZHRwbC9naHo0OXIxbDJLSmJ3alpaQ2lySWpnSWVja0RuMTJDN1I2MEY2bzZQ?=
 =?gb2312?B?MlhaZzVCeGZUY3RUdzVUTXFUU2I1bDZZMmsrTTJzN21PdWtSdkF6aHJFUHR3?=
 =?gb2312?B?djVPK096WGU2SW9DVGJOaDNWOUpaK0lVb2tHa0VmRWk4MVJrNWtjTDlYUEp4?=
 =?gb2312?B?U0JSYnhEbURsdklzM05sUFY5MUJEVnR3a21PcUo4MlVUQUlldFFFczh6amcv?=
 =?gb2312?B?UDE5V1g4UjZmN212SkhzbkcxNlU3Nmp4WS8yU3Y2QlpqZWtPMTg2UmRyOU1x?=
 =?gb2312?B?bnNpSUpVRWZNYXRuS0FZbTFmU2hBZWFMRUdZVjNJcXpjTmlFRWpMcGV2SE1G?=
 =?gb2312?B?U3BlWE5Fb1YwVDJQZEIrdVFxbVBVV05SR1BWbnFXSi9vTDFZbUNzalFYZ0tP?=
 =?gb2312?B?dGJmakVFQ0FaZFZHZ04xYVhaR3JFNkFBYXRVbXJGQUFoZ1JOcjRuZk15Y0RI?=
 =?gb2312?Q?VbO4OlbUDjWFOXoSv9pGsUyAl?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e05f32-6f3c-43eb-88aa-08dab1bf833a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2022 10:48:52.4399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPkwp5X9IBujYYv+fNCotAFY3k5C3fSyMhVMdVYY2pWXlHK++NUf7ZoK2ueKa62DRHiKVITRBz3SVXTgAXljdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8551
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjLE6jEw1MIxOcjVIDE6MjANCj4gVG86IEJvdWdo
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LW1tYyA8bGludXgtbW1jQHZn
ZXIua2VybmVsLm9yZz47IEFkcmlhbiBIdW50ZXINCj4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29t
PjsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFNlYmFzdGlhbg0KPiBSZWljaGVs
IDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPjsgTWFydGluIEZ1enpleQ0KPiA8bWFy
dGluLmZ1enpleUBmbG93YmlyZC5ncm91cD4NCj4gU3ViamVjdDogUmU6IGlteDdkOiBUaW1lb3V0
IHdhaXRpbmcgZm9yIGhhcmR3YXJlIGludGVycnVwdC4NCj4gDQo+IEhpIEJvdWdoLA0KPiANCj4g
T24gVHVlLCBPY3QgMTgsIDIwMjIgYXQgOToyOSBBTSBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+IHdyb3RlOg0KPiANCj4gPiBXb3VsZCB5b3UgaGF2ZSBhbnkgb3RoZXIgc3VnZ2Vz
dGlvbnMgYXMgdG8gd2h5IHRoaXMgdGltZW91dCBoYXBwZW5zPw0KPiANCj4gRG8geW91IGtub3cg
aWYgdGhlIGZvbGxvd2luZyBpLk1YOE0gZXJyYXR1bSBhcHBsaWVzIHRvIHRoZSBpbXg3ZCBhcyB3
ZWxsPw0KDQpIaSBGYWJpbywgDQoNClllcywgSSB0aGluayBpbXg3ZCBhbHNvIGhhcyB0aGlzIGxp
bWl0YXRpb24uIENhbiB5b3UgY2hlY2sgd2hldGhlciB0aGUgaXBnIGFuZCBhaGIgY2xvY2sgc291
cmNlIGZyb20gcGxsX2RybV81MzNfY2xrIG9uIDUuMTAgc3RhYmxlIHRyZWU/DQoNCg0KIDY3c3Rh
dGljIGNvbnN0IGNoYXIgKm5hbmRfdXNkaGNfYnVzX3NlbFtdID0geyAib3NjIiwgInBsbF9zeXNf
cGZkMl8yNzBtX2NsayIsDQogNjggICAgICAgICAicGxsX2RyYW1fNTMzbV9jbGsiLCAicGxsX3N5
c19tYWluXzI0MG1fY2xrIiwNCiA2OSAgICAgICAgICJwbGxfc3lzX3BmZDJfMTM1bV9jbGsiLCAi
cGxsX3N5c19wZmQ2X2NsayIsICJwbGxfZW5ldF8yNTBtX2NsayIsDQogNzAgICAgICAgICAicGxs
X2F1ZGlvX3Bvc3RfZGl2IiwgfTsNCiA3MQ0KIDcyIHN0YXRpYyBjb25zdCBjaGFyICphaGJfY2hh
bm5lbF9zZWxbXSA9IHsgIm9zYyIsICJwbGxfc3lzX3BmZDJfMjcwbV9jbGsiLA0KIDczICAgICAg
ICAgInBsbF9kcmFtXzUzM21fY2xrIiwgInBsbF9zeXNfcGZkMF8zOTJtX2NsayIsDQogNzQgICAg
ICAgICAicGxsX2VuZXRfMjUwbV9jbGsiLCAicGxsX3VzYl9tYWluX2NsayIsICJwbGxfYXVkaW9f
cG9zdF9kaXYiLA0KIDc1ICAgICAgICAgInBsbF92aWRlb19wb3N0X2RpdiIsIH07DQoNCkJlc3Qg
UmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gZTExMjMyOiBVU0RIQzogdVNESEMgc2V0dGluZyBy
ZXF1aXJlbWVudCBmb3IgSVBHX0NMSyBhbmQgQUhCX0JVUyBjbG9ja3MNCj4gaHR0cHM6Ly9ldXIw
MS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3d3
Lm54cA0KPiAuY29tJTJGZG9jcyUyRmVuJTJGZXJyYXRhJTJGSU1YOE1EUUxRXzFOMTRXLnBkZiZh
bXA7ZGF0YT0wNSU3DQo+IEMwMSU3Q2hhaWJvLmNoZW4lNDBueHAuY29tJTdDMjM5MzI2NTA3ODJk
NGMxYzY4ZWUwOGRhYjEyZDAzYzclN0MNCj4gNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMSU3QzYzODAxNzEwNDEzNzgwMDc2NiU3DQo+IENVbmtub3duJTdDVFdGcGJHWnNi
M2Q4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSQ0KPiA2SWsxaGFX
d2lMQ0pYVkNJNk1uMCUzRCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPUclMkZtcm1INQ0KPiBW
NjU5am9rNzgyJTJCWDRFOE5yNjdhTnVJU3BmZXlnOHE0amV0WSUzRCZhbXA7cmVzZXJ2ZWQ9MA0K
PiANCj4gVGhhbmtzDQo=
