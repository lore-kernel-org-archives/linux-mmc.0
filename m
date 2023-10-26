Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA2C25B6B
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Oct 2023 11:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjJZL6q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Oct 2023 07:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjJZL6o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Oct 2023 07:58:44 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC001A6
        for <linux-mmc@vger.kernel.org>; Thu, 26 Oct 2023 04:58:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhPYvM8Z7NQmUYV7MgYNIv3WfMGNrwF7oL/KuN3Lr98P1G1Smxvm81MnCxKHaiIw4jQ3/BwDV1GT9jPMpdzNHH2yGdnSKHAXMOOA7gBODdish0Qqi5+1K/hMfryi2jeoouaTNpA1d1w+sAA+/3IF3v8nB/zHLIswdSCM/uUhHQ5euE2KxwHdIiDjK45b5gbPO+7Jf4T3u4Ma0uRO3PVriRJE5cXWFMKvZMNfDpBV/d5z0NlNSOa0V3VkRKyEk79QN5M6QaqN1FlqHCoPTHxjiAwxV4IWEEbxNSLHjiiOsVqLkB0Yfq/xDz1SU6dND6IuFKCqTU9i4cbCEIrKxFlsqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXqCTdCPJax9FUccqifvX31P7Vq5X240nCTnYKWqRYM=;
 b=h3bScvEOyPuE7mtofeJriDBDkaguILpuSvtiw+xOrtSzf7DtQSr8cBFOZLwzFHNEaL8MzR035wWVJUcXWE2MaUi50/hNeq+dyowGzhXdcqO83T32+7WLMq+KuL8dRrIN8WtZRJnWQW8g1S6jRgh1h/zulFBEYNt65RibpX71wkWTrFlFj92pw0Q5AxxXQogqqrB1jA4iA59EPT1/WZAuYBa7q//NN/RFujy84HQqlb16rvOuxXGja9Juuj9PEOIoFycZkCJxcgP8IQVuRzMncPdugv468xfamNOUXMQHyvwjWruPn1ND1uo9tuJ0RNiEnmymKk5N3lOlvKjCn8I+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXqCTdCPJax9FUccqifvX31P7Vq5X240nCTnYKWqRYM=;
 b=kneM7XI6x2JUj1BymH9T+z1LDspOSbgAqV5/bbGjSCJDeeu1KIkXXVSGybU0khQkHUiIapl7gtZrErxXZfgB8FHth8AZphP2nNU4Uuj0GG7oZMKEGVvleU1cuAS7vtvbJoJD/5LCDu3hsHZsaH6trHgvCuTey77Gp9gOsPTt/RM=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM9PR04MB8922.eurprd04.prod.outlook.com (2603:10a6:20b:409::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Thu, 26 Oct
 2023 11:58:36 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::2952:7c98:bd3d:ef6b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::2952:7c98:bd3d:ef6b%6]) with mapi id 15.20.6933.016; Thu, 26 Oct 2023
 11:58:36 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>
Subject: RE: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Thread-Topic: [PATCH] mmc: core: sdio: hold retuning if sdio in 1-bit mode
Thread-Index: AQHZ2yVAPHzNo/yXokSwCK3W0R3Ss7AaYTmAgEHncTA=
Date:   Thu, 26 Oct 2023 11:58:36 +0000
Message-ID: <DB7PR04MB4010F86F40CA1E8E0B900D9390DDA@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230830093922.3095850-1-haibo.chen@nxp.com>
 <CAPDyKFpTP-r-eg2L1BoAG5ia2N2640VR2s2Vtbemyyu4MuKS=w@mail.gmail.com>
In-Reply-To: <CAPDyKFpTP-r-eg2L1BoAG5ia2N2640VR2s2Vtbemyyu4MuKS=w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AM9PR04MB8922:EE_
x-ms-office365-filtering-correlation-id: 592d10b1-35bb-410c-842a-08dbd61ae2b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5JqvQx0To4XTpl0ogQGpDReUrmyKXY07ETSkIr3i9o+cxULpZ4SLbIEPeeiosaYZdlC6jxcesm2cpkqr+K9PepaCh8/kL9qUqO8FOTaXaWOODSKoCpBznIbcgO7kcjnnA0gBb+XvktZyIsX6AtoxxUCzoCaxGSTKsK+8hQ1iLn0TwDQZJ68vVQnwUbP2cEJ6adVwBgdfdCnvtCtX0GnT7BgNWFBbRXo68KFp4fN57nY+iZBpIvuNk2TmIxNS1g//xCviUFCjHXTb9WikkdhbG3J422Woym8K3sbbx2eknjh+/vVbynmzXq12VYx/5UQRRY6bZteyD1OkP7jUqN21p5TLQYkOcJp9WYCyMf7/o1KuglPeOOi/2qLkJMRM07aALVA5u3t8UJikddPRibooRKS/or3thx7stu/NXrKFpEOeZXe4DnTZ0G2SIrxBR5BZxTlmf/SeW2AyXBLOjSd5w+vXROaFACUlVsX/ZJn/1FmV9h6Ot078RaSH8yCpWDKU7QqJnPtC5NUSJO+JBLWJ/zOzijHXypsCC/wB664zG95fLVekKxtJJplSoE0iwn+O4kaxDV7Hb3f0OZDBY0JqwH2NCHRW/N1CsZ+jJrTYYkunl8g3uHKkUf7fmiCcunof
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(38070700009)(122000001)(38100700002)(6506007)(478600001)(7696005)(9686003)(53546011)(66946007)(4326008)(54906003)(64756008)(66446008)(66556008)(316002)(76116006)(66476007)(8676002)(8936002)(6916009)(52536014)(5660300002)(2906002)(41300700001)(83380400001)(71200400001)(26005)(55016003)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2NSMXJ4bStVQnltK0greDl0WUwzYitxQ0Vld24xQlBKWUg0ZS9WRE1SUDln?=
 =?utf-8?B?Tk94eGhnUFArWFZsd0JIcUNaeitVTXdmcFlQbUlQK2tXRnZiZDdSdUxxZmFN?=
 =?utf-8?B?bXM3UXNxTWdIOWNTRVQvT3BRK1lGTE9yOU9TamhBeWhva0NjWmpaRDRIamF3?=
 =?utf-8?B?VVllSnV4L1dPYTRhL2UvVnFsWG1acmlwbmZsL0Ntd3VtM0R6R01KUkVSRm8x?=
 =?utf-8?B?ZEVJMDR0NFJDSEVJZXM1ZC9nSDdRSjhTQzYrbHl4bEpCMGFvdG5KbHdWNHJq?=
 =?utf-8?B?VjdrTnpIK1dCblJsZzZ3Q1dxTGhIc2hjNDlzYXBGOUdPSHprdUFpR3V1cmZD?=
 =?utf-8?B?dXZHQ3labStkYzZ6UnVzeEp0T0Vaa3N3UkFFcHFUcFJScVZpd056cnJJMVVK?=
 =?utf-8?B?V2JyVExzRWlNdzhBemdLSDZEeVljNHl1b29sdE1vZ2hsclN0bCtTdWY4dDhE?=
 =?utf-8?B?dFljNldoWW1zNVREN1d6WnhjTDJySW1DNzIvblArLzRmMHV5ZU1iZFhQNXU5?=
 =?utf-8?B?YWJzZFB2UCtZWGhhb2lab3Z1QzRDekY2SnZUenRVdVdjbWNiRjhMN3ZVQm1R?=
 =?utf-8?B?UHZEZWtZMDlLOFgvclI0aWJIRWFRR0JqMnZzVFg1UzRxb0V6YVJtelNWT0JO?=
 =?utf-8?B?TEdOS2FNd1J1QmtXb2hmbVVkbUFVajhoaVJTYXV1dnVpODZFbFdwOHZHdTJM?=
 =?utf-8?B?QXQ2YytrNTZIY1d2cFVJZDVnaEhkQlV4T1c0TmlWaXRWT2ZGT1NLVnJ3U3Uy?=
 =?utf-8?B?a240ZDA3enAvVGtHTXo5eTdxSGh4TUo2ajdqV0NuSGgvOWd3ZUxrNnhNRmZ1?=
 =?utf-8?B?ZjAwVUp4Y2lNUzJQZHpNOExjWTNMRGsrVWxKdnpSeFl6c1doNDQrQTJWMnZP?=
 =?utf-8?B?OFVQN1dQMTlMRkRVUkJGbnZ4NVlTd3QyMHNqSkg1a0Z5Wk1qN2g2Z00vOFoz?=
 =?utf-8?B?U0Yvdm5aRHA2ODkrWG1Kc1dFMTlRMU9waVVLNFJUeDFrSmYxM1EvZ05OdGpt?=
 =?utf-8?B?ck5SWStaenY1bjN6VUhxejNTMXE5ZkFldWl5cHd1T041dnozMGFCczV2emtT?=
 =?utf-8?B?MFA4dGJQSGdKbmVnNFUyS29QaDl0eVdsK3RJZUpVZHIvOE43c1FkdnVsM3l2?=
 =?utf-8?B?WCs2ZDlQOExpZDNYV1VyZDhXeWtPVU5ES2xQSENrNVJVeUJhdnhOcTBXa09v?=
 =?utf-8?B?RkJ1NDVEMVBORXQxTy8rNDVzQnN6WENOU0ZUM2NPZHFiQ1MremVCRzhEMXI2?=
 =?utf-8?B?d0c3STk0aVk2Yjd6aHc0dU9yUytTYTBIL3NWNDhEVGZia2IwUUI1MVZ2am5G?=
 =?utf-8?B?M1g1OWpNZjd4MzdWZlVsQ3dBdGtaOEJaVWVjVzBZKzgrRWhFZlJwYWJIcXB2?=
 =?utf-8?B?V3BqN3JvRjl1cDR1YktuWlZVUmxPb1pWT2hkN2dmRmlZOTZXUjBVMUdIZG1C?=
 =?utf-8?B?S3d2clVaOWFFSjlCbFNITS9qMEtyYkIxY3FQbHNheGNmeFJCaGdoTVIyQXBN?=
 =?utf-8?B?ZFh3b1B1dlZkeG50ZUtHcjlOYWl6OVZyNnBXSnNmejV1bDAwa05pV0ZHMnFD?=
 =?utf-8?B?L0syT2NDWllybjRONmQ2N0NhMGlMaFdIYTFObDVxeUNHMDRMTUtuQk5OcW1Q?=
 =?utf-8?B?cHBLalowY25MS2U0ZzFMU1AzS29EcG1GZjQzRXlBMTRjcm1PSEQzUVdxMGJ1?=
 =?utf-8?B?dVlVOGJrK0NEMjN4TmdDdTltc0tXSXNsdGZra29zcjFsWkhrUE1yNFRvMG4w?=
 =?utf-8?B?L2I1K0hTNkNlN1dxUnNLQ2t6cXV2Ukk2RjlsM1VDcFVUVGlaMlBnYnZwNE9E?=
 =?utf-8?B?aTlaVW50M0VNOFdsbUVHZ0g5YzhLRm9RdVA2MlczaHdDd21udmtnTzIxaWFm?=
 =?utf-8?B?ZGRhOERBbTBDMHNteTNiL0cwK1hjYnowY2YyVVFScVRvNEZGdUQ3aU1WdFdX?=
 =?utf-8?B?c0MrRmNYdkkrUmUySFpPMDU0ek1ncWM3TUNFT3dpd1h1S0NWUDd0cVE0eEN2?=
 =?utf-8?B?ejBFc2NpOTNqUm01VkRTOVh4cjlzbFdudXp2SGhSN3UydnRjNHpmc1kyb0Yr?=
 =?utf-8?B?aUhVTmpHU1hTekQzc1c0eDJkQnhGUm12NHJMYU5TUVdIVldsS1N3QVVGS2VP?=
 =?utf-8?Q?cWKY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 592d10b1-35bb-410c-842a-08dbd61ae2b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 11:58:36.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZohh6tL8Q3U+diyiYMSx6rN4+jA96p/BMliGElQueBkmoDtp6IKwaoUAw1hnM/ZKREC1k4ZPNZ0OPcmmiuIpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8922
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiA8dWxmLmhh
bnNzb25AbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5tDnmnIgxNOaXpSAyMTowMw0KPiBUbzog
Qm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogYWRyaWFuLmh1bnRlckBpbnRl
bC5jb207IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGRsLWxpbnV4LWlteA0KPiA8bGludXgt
aW14QG54cC5jb20+OyBoa2FsbHdlaXQxQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBtbWM6IGNvcmU6IHNkaW86IGhvbGQgcmV0dW5pbmcgaWYgc2RpbyBpbiAxLWJpdCBtb2RlDQo+
IA0KPiBPbiBXZWQsIDMwIEF1ZyAyMDIzIGF0IDExOjM1LCA8aGFpYm8uY2hlbkBueHAuY29tPiB3
cm90ZToNCj4gPg0KPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4g
Pg0KPiA+IHR1bmluZyBvbmx5IHN1cHBvcnQgaW4gNC1iaXQgbW9kZSBvciA4IGJpdCBtb2RlLCBz
byBpbiAxLWJpdCBtb2RlLA0KPiA+IG5lZWQgdG8gaG9sZCByZXR1bmluZy4NCj4gPg0KPiA+IEZp
bmQgdGhpcyBpc3N1ZSB3aGVuIHVzZSBtYW51YWwgdHVuaW5nIG1ldGhvZCBvbiBpbXg5My4gV2hl
biBzeXN0ZW0NCj4gPiByZXN1bWUgYmFjaywgU0RJTyBXSUZJIHRyeSB0byBzd2l0Y2ggYmFjayB0
byA0IGJpdCBtb2RlLCBmaXJzdCB3aWxsDQo+ID4gdHJpZ2dlciByZXR1bmluZywgYW5kIGFsbCB0
dW5pbmcgY29tbWFuZCBmYWlsZWQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVu
IDxoYWliby5jaGVuQG54cC5jb20+DQo+IA0KPiBBcHBsaWVkIGZvciBmaXhlcyBhbmQgYnkgYWRk
aW5nIGEgZml4ZXMgdGFnIChGaXhlczogZGZhMTNlYmJlMzM0DQo+ICgibW1jOiBob3N0OiBBZGQg
ZmFjaWxpdHkgdG8gc3VwcG9ydCByZS10dW5pbmciKSkgYW5kIGEgc3RhYmxlIHRhZywgdGhhbmtz
IQ0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCj4gDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2
ZXJzL21tYy9jb3JlL3NkaW8uYyB8IDggKysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbW1jL2NvcmUvc2Rpby5jIGIvZHJpdmVycy9tbWMvY29yZS9zZGlvLmMgaW5kZXgNCj4gPiBm
NjRiOWFjNzZhNWMuLjU5MTQ1MTZkZjJmNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21tYy9j
b3JlL3NkaW8uYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvc2Rpby5jDQo+ID4gQEAgLTEw
ODksOCArMTA4OSwxNCBAQCBzdGF0aWMgaW50IG1tY19zZGlvX3Jlc3VtZShzdHJ1Y3QgbW1jX2hv
c3QNCj4gKmhvc3QpDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgICAgICAgICAg
ZXJyID0gbW1jX3NkaW9fcmVpbml0X2NhcmQoaG9zdCk7DQo+ID4gICAgICAgICB9IGVsc2UgaWYg
KG1tY19jYXJkX3dha2Vfc2Rpb19pcnEoaG9zdCkpIHsNCj4gPiAtICAgICAgICAgICAgICAgLyog
V2UgbWF5IGhhdmUgc3dpdGNoZWQgdG8gMS1iaXQgbW9kZSBkdXJpbmcgc3VzcGVuZCAqLw0KPiA+
ICsgICAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICAgKiBXZSBtYXkgaGF2ZSBz
d2l0Y2hlZCB0byAxLWJpdCBtb2RlIGR1cmluZyBzdXNwZW5kLA0KPiA+ICsgICAgICAgICAgICAg
ICAgKiBuZWVkIHRvIGhvbGQgcmV0dW5pbmcsIGJlY2F1c2UgdHVuaW5nIG9ubHkgc3VwcHJ0DQo+
ID4gKyAgICAgICAgICAgICAgICAqIDQtYml0IG1vZGUgb3IgOCBiaXQgbW9kZS4NCj4gPiArICAg
ICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgIG1tY19yZXR1bmVfaG9sZF9ub3co
aG9zdCk7DQo+ID4gICAgICAgICAgICAgICAgIGVyciA9IHNkaW9fZW5hYmxlXzRiaXRfYnVzKGhv
c3QtPmNhcmQpOw0KDQpIaSBVbGYsDQoNCkhlcmUgc3RpbGwgY29udGFpbiBvbmUgYnVnLCBpZiBu
b3cgaW4gVUhTLUkgbW9kZSwgY2FyZCBjbG9jayBtYXliZSBpcyAyMDBNSHosIHdpdGhvdXQgdHVu
aW5nLCBzZGlvX2VuYWJsZV80Yml0X2J1cygpIG1heSByZXR1cm4gZXJyb3IgaWYgaG9zdCBjYW4n
dCBzYW1wbGUgdGhlIGNtZCByZXNwb25zZSBjb3JyZWN0bHkuDQoNClNvIGhlcmUsIGluIHN1c3Bl
bmQgYmV0dGVyIHRvIHN3aXRjaCBvdXQgdGhlIFVIUy1JIG1vZGUgZmlyc3QsIGFuZCBkb3duZ3Jh
ZGUgdGhlIGNhcmQgY2xvY2sgcmF0ZSg8NTBNSHopLCB0aGVuIHN3aXRjaCBmcm9tIDRiaXQgdG8g
MSBiaXQgbW9kZS4NClRoZW4gaW4gcmVzdW1lLCBzZW5kIGNvbW1hbmQgdG8gc3dpdGNoIGJhY2sg
dG8gNCBiaXQgbW9kZSBjYW4gZXhlY3V0ZSBzYWZlbHkgd2l0aG91dCB0dW5pbmcuDQoNCkkganVz
dCBtZWV0IHRoaXMgaXNzdWUgd2hlbiBkbyBzeXN0ZW0gUE0gb24gaS5NWDZVTEwuICB1c2RoYyBp
biBpLk1YNlVMTCB3aWxsIHRvdGFsbHkgbG9zdCBwb3dlciBhZnRlciBzeXN0ZW0gc3VzcGVuZCwg
d2hpY2ggbWVhbnMgdGhlIHByZXZpb3VzIHR1bmluZyBzdGF0dXMgd2lsbCBsb3N0IHdoZW4gcmVz
dW1lIGJhY2suDQpXaGVuIHNlbmQgY21kIHRvIHN3aXRjaCBiYWNrIHRvIDQgYml0IG1vZGUgZHVy
aW5nIHN5c3RlbSByZXN1bWUsIHdpdGhvdXQgdHVuaW5nLCB1c2RoYyBjYW4ndCBzYW1wbGUgdGhl
IGNtZCByZXNwb25zZSBjb3JyZWN0bHkgdW5kZXIgMjAwTUh6LCB3aWxsIHRyaWdnZXIgY21kIGVy
cm9yLCBjYXVzZSB0aGUgc2RpbyByZXN1bWUgZmFpbC4NCg0KSnVzdCBhcyBBZHJpYW4gbWVudGlv
bmVkIGJlZm9yZSwgaGVyZSBhZGQgdGhlIG1vZGUgc3dpdGNoIG1heWJlIHJpc2t5LiBBbnkgY29u
Y2Vybj8gT3IgYW55IHdheSB0byBwcmUtc2V0IHRoZSB0dW5pbmcgY29uZmlnIGluIGhvc3QgY29u
dHJvbGxlciByZXN1bWU/DQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KDQo+ID4gKyAgICAg
ICAgICAgICAgIG1tY19yZXR1bmVfcmVsZWFzZShob3N0KTsNCj4gPiAgICAgICAgIH0NCj4gPg0K
PiA+ICAgICAgICAgaWYgKGVycikNCj4gPiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo=
