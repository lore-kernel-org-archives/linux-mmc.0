Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8F4C61DA4
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Mar 2023 02:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjCFCWu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Mar 2023 21:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjCFCWt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Mar 2023 21:22:49 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2111.outbound.protection.outlook.com [40.107.96.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3BCCA2A;
        Sun,  5 Mar 2023 18:22:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGgRbYtk291XWgZoXBJDfKaWDWtJ1MF66ZqVEY+e6LdmhEZL+fGEdMT+8vfdWvuacp0xUYxMplcI1ymNOHlRYM5FkkFv2/NexzTLZdhHc4Tp3H3x/gWoD3VfFeu7HzaaJ9aAUGyIElFa4zrBFlp40igsJa43pXWiEAkcxAj/uVnEJMv0bt1Z5MDjAb67Jqp38TAU0QlgZGfbHZZz9+4G/O0TkwYckyDI2NhFd0OHGTKCICWhPMqtKSymNV+hx52P0sLnK4e1WUDZ80i9DVysNp7S9PkXW63pe495Cs0KkHkIq9AKiw0or3V4YcXb7Cp0M4eYsBieHiFkHKBoygnHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vy7u53y5ZjpyLVz6w5Li7fqvP31OadR2PGRAeqG62dc=;
 b=WDZwdaXvWU56zeMF5myRztVIvaXrI7sxoXhZDxqBbyT77DmddQSl1EbNCKfEp6RGTPbJ+vwMnPbQj/foNGhWNUaKEkSRWjh4e//gd3XnqwfJh5x59Bnyi4Veztlu6WNXp5beILWeQxbpIXZnGozbgHo5H62ZNvNe0Ic9+nSPKXBLlL24QR05/1a8keVTdjFd3dVB9pSlVDyJL7oZljv2d0ohjEf08Nu5hIKJSe5OS5oEGtzwmia7+RY8Rg8QriHGcGmriRmMc/THFQ81o31swEEwkx/bvvgyW82bD30S7E9GnwT15pLtOuf9uyOuBMP5VpyQxoycWdhFTG3HAJ3tnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bayhubtech.com; dmarc=pass action=none
 header.from=bayhubtech.com; dkim=pass header.d=bayhubtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=towerbridgetechnology.onmicrosoft.com;
 s=selector2-towerbridgetechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vy7u53y5ZjpyLVz6w5Li7fqvP31OadR2PGRAeqG62dc=;
 b=cLBsyYdr/yEv3lz0ZGAmKfcrmMPSQrcarxXNb7Ppz1dpAIVwVlhNPaIuW/P0yjIqwfAPZZDKOvcM98tnS26sMEnO/kmpEyvMcfFQZQCkdxQflAnUx6JdVMwM2sJPOQM/NO9UVwZSzGotl8zozUPxGb50sAllXtxmAsHEx5DSzNY=
Received: from BL3PR16MB4570.namprd16.prod.outlook.com (2603:10b6:208:349::24)
 by SJ2PR16MB5189.namprd16.prod.outlook.com (2603:10b6:a03:4f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Mon, 6 Mar
 2023 02:22:39 +0000
Received: from BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::3144:fd6e:c3f7:2b7b]) by BL3PR16MB4570.namprd16.prod.outlook.com
 ([fe80::3144:fd6e:c3f7:2b7b%8]) with mapi id 15.20.6156.028; Mon, 6 Mar 2023
 02:22:39 +0000
From:   "Fred Ai(WH)" <fred.ai@bayhubtech.com>
To:     "fredaibayhubtech@126.com" <fredaibayhubtech@126.com>,
        "adrian_hunter@intel.com" <adrian_hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux.kernel@vger.kernel.org" <linux.kernel@vger.kernel.org>
CC:     "Shaper Liu (WH)" <shaper.liu@bayhubtech.com>,
        "Chevron Li (WH)" <chevron.li@bayhubtech.com>,
        "XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>,
        "Shirley Her(SC)" <shirley.her@bayhubtech.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIFYxIDEvMV0gbW1jOnNkaGNpLXBjaS1vMm1pY3JvOiBG?=
 =?gb2312?Q?ix_SDR50_mode_timing_issue?=
Thread-Topic: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Fix SDR50 mode timing
 issue
Thread-Index: AQHZR38iMX+Vg+K6v0m1HeAMEHfTGK7tFFcw
Date:   Mon, 6 Mar 2023 02:22:38 +0000
Message-ID: <BL3PR16MB45705AE2FA2F8ABB2960C4A299B69@BL3PR16MB4570.namprd16.prod.outlook.com>
References: <20230223120450.16858-1-fredaibayhubtech@126.com>
In-Reply-To: <20230223120450.16858-1-fredaibayhubtech@126.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bayhubtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR16MB4570:EE_|SJ2PR16MB5189:EE_
x-ms-office365-filtering-correlation-id: de93b10e-18f8-4dda-0ebe-08db1de9a842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Vc1HojxdXxoX0HLTLq96HnPH/tk9Q2nvnlQghfj2h8cFyxrtKcDtOqQdCgfolzc91xhfSMte1FdOg8Y7gJcFcLpL+okE2q18SP8wed6Qvef5AMOs4aSZLq3aDtZy4bcq37P+G8fAlzhLeTMNKT5wKffaFWHspGHCnUX1pfgqU8cDl2cMBtN77KG7MHdwk7m2NQi2tufvPx5xGNu18ZoMIXloALPx4LUPNJC7dYr7eBf06kWTo23k2QTpuBSgEiUOG0CidXc4O365eIfyeQAiNjhe3gBvMCjmBVFoR/QitQcIpdOa0d/LCS5n4ttw5yLl2Y3rCB5uJ7mslwjFYp3thK3dtm+ibJkRdjLQDoJersHTpPp0jc9ioLcIpWB98ZH5uNT6pRd8UYZmGH47yl2i9WsPKBODDLfJTPwx77CO3x62P5PzhEB4fjG+TyoCT7YpnxxoMvxG/FgMKlXNVf9QTVWPnj7KUZODmnTPn5n6Yt8aa3bxPufIUjMJWK4ZU/IxY7nCgpQRfHbvg3pu+GzOY9UbqwmuVu68sjce2in/NYcjkLmyXsUH0B4W3sdD5qeIcUNTvSKmXtom6HahWZJ56GLCOczMJhcI2TgJybhCfwXnO8fU7NePgZtDkSRYjUF0q4owcfGXRRQuLXuFjm7FXC+0eOIVCK/BMM1L8lxMxGsZRbk0jNNrSe7Jdd9iX76M58G1MgPDXSeaYl3lVc5Ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR16MB4570.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(376002)(39830400003)(366004)(136003)(346002)(451199018)(5660300002)(107886003)(8936002)(52536014)(66446008)(66946007)(64756008)(4326008)(55016003)(66556008)(86362001)(66476007)(76116006)(83380400001)(478600001)(54906003)(110136005)(71200400001)(7696005)(224303003)(316002)(33656002)(41300700001)(2906002)(26005)(186003)(9686003)(122000001)(38100700002)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ck1TSCtJUTN0UXhVS0liaXFrd1JWdFZnNkhjd1hrWXA5T3BDbDZIa3p0K21N?=
 =?gb2312?B?Z1lLd0lBS0xXRkZIdXoyanUxTXlmRitTaFhBSDhVYlNqYTQ3UU8yZmh2WEYz?=
 =?gb2312?B?TWJxaTFhYkhKanprdnZISWtyay95QVJtalpTVTVnL2dTaUxqSjRCb1VIbkxx?=
 =?gb2312?B?aEwzeXFCck50UUM2MUZsYkl3R3JjRFRSSndDclFEa1BFTWVnOWxBNW56UzJy?=
 =?gb2312?B?WG1uTUtZdWJXSlZpN0ZkTWtxK1BPOFZhbUtuTWhRK29XbVRVNE04dDBhUU14?=
 =?gb2312?B?SUNBakFHM0RnMFB5MmJYNm9WWnFxYjE3RWJUTTdHTTBUOHFiMGMrTEJuZE8z?=
 =?gb2312?B?eDBkUFZpUlVocGFkbGZhZkJ1d21oc3l0dk5OZzRqTXVLWkV2Snh3VU5RNThq?=
 =?gb2312?B?NDd3YkJpSnk5c2dsbEFvY0NCU2pUaHltcXh0ejljeU9KNEFtVG1adDRIRHQ1?=
 =?gb2312?B?a1h1ckErRDlOL05YM0F5L0lnOTJtSytHWXFEK1dSazhXMmtZWU9DVThoZisx?=
 =?gb2312?B?UitMb3FhYkVNQytsb0RuU1pzRlVzeUdkRzZNZDJSbmttZC9EZVJ0TEtML0cv?=
 =?gb2312?B?OTFKNDQyazh1ZWNZN0IrMEN3ZityQ2JXeWlFN1dzUTZTRitNVENvUmFwTWlS?=
 =?gb2312?B?TDJIaDJoSHNkbDVCbGpaQkFCektBQ3dhemhyclF1WE9qd2lpaTFOYlpRZ2s5?=
 =?gb2312?B?N3J6ajhSNjNycHpMOHRraHIwZm84OExiSkc3elk1UlRwdFIzc052WVVlV3dI?=
 =?gb2312?B?OW9tejZEV3lCT25IeWs5T3k0NFlFajlybG1RS3RIQlZJUFkyeXBwb0g0QW9E?=
 =?gb2312?B?VnNST2JpZEVla0VoWWVHU3BqUlgvU2VnM1AyZUZESDI2Q2UvRHVpK3YyL2pR?=
 =?gb2312?B?ZDFRcnhzODUxQ3VhQ2Zubi92RU1wNjI5UVRya0FmQ0FhYytYRDhMSTdMTnIw?=
 =?gb2312?B?VkFxMitWMFp3NExIMjU4MGZWQWx5aTFEV21XYlkzNDJhb3R6Vm1acndvTWs2?=
 =?gb2312?B?ejhDSDV4aUowY0xsTlpUeTZqYmRKc0lYTndvVExycW91NGVTcldpemg1SGhJ?=
 =?gb2312?B?WGp3Z0Y4T09QR3RzWTRiM25INDJiN1ZVU29SaW9yUmNqNzcvY2l5Ni9XRlFp?=
 =?gb2312?B?SHJaVTBEck0zZG1yQ0JqaFdJOEg3YjZQNkhldmZHbEUvekpkUEZ0R3ZDeGZY?=
 =?gb2312?B?M2dKRDVkTzUxdE82MlVxK09kVi9jbEtEQmx0Q2pyYXplSXhGdXVPTm95cThm?=
 =?gb2312?B?SUVWSytZbk5zc0F3ZUxOUUNTekdQZnlpeDNEcDZuaWo4NG1EVEZyWlQxYVly?=
 =?gb2312?B?VkRNMHBIL3J0V2dmNFh5Q29wZmRBMlgwdHMyVkJ0NlRLT0VzbzNzZHJyWUFj?=
 =?gb2312?B?cllpMXE2cmpRaU9FclhhdmhoWFZZaW1NZTkwT0NMMW80bS9XY1Voeit5K1N5?=
 =?gb2312?B?Mi8yOGtPdWF0Ty9BNjI4RjZ5cEV0TDB6cVJhWTdlWlBFN00vQVFpcEYrMi9K?=
 =?gb2312?B?RWlRWGhRVzJNZlVnSzVEOEZCclZlckV3aDNoU1ZjTkF2WFVzczRLUlFFWXE0?=
 =?gb2312?B?TnV2MjFkUHhUR0FrSWV0UFhabWJEUTY4UkZteTNKZjk4UG9pT1VEdDVwb1Rl?=
 =?gb2312?B?Yk9yWm1wdjJFenFUS3ZkYnZ4OXIvaXdPQnBpeEx1NHlMYVFCUlpPZ3oyaTll?=
 =?gb2312?B?U2hucGNqbEdPR1Z0Qk5WSC9SRnNVbTlkWjlGNG1rcjdRU2t2QURvMGxsdVE1?=
 =?gb2312?B?ZHVJdjVoNUlSLzNjbEorYkdwOGk4b1Q2R0NVRGFGcDcwYlFZOGp5YWwvSnVI?=
 =?gb2312?B?Wlg0cVNSTys5bzFMK0VtVUhxZ2h6Qy9VZ3F1VFYzQXFQUWw5bHlNZFQxaE40?=
 =?gb2312?B?SVFOWmhrcEFFbHRUTEt1MGRsT2Yzekl3cXAwdzloVDRJSThSRzY3T1BqOHBC?=
 =?gb2312?B?eUpuMHJRMTUxR21ESldiTDA4WUtnKytYT1psN2NzeTFMZklVeENTRnhhU0sx?=
 =?gb2312?B?YmFCeW1UajRmRHJQclNNbVNjTXNSTVQ4ZmxEMFY1R08xUFZBdzZBUGhNVG1U?=
 =?gb2312?B?cGFoU3c5TjNucUdmWnpSM3pVYi95MUVsejE2cFU2UFVFenNwSkk0Z1owckhy?=
 =?gb2312?Q?llfqXrjMK8NBMosaUaCMaBxSl?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bayhubtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR16MB4570.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de93b10e-18f8-4dda-0ebe-08db1de9a842
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 02:22:38.9918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0a7aae2b-8f2e-44df-ba2f-42de7f93c642
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DzYIaP6uAihGdAQJJ+GkudFCtdoi0XaPWeJJTb0Nzz7XZpaRzo9ZW/oJxNfoOfbZQUQEHKF+Gnw0Ze1RVsDZBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR16MB5189
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

QmVzdCByZWdhcmRzIQ0KDQpJIGFtIHRoZSBzb2Z0d2FyZSBlbmdpbmVlciBvZiB0aGUgQmF5aHVi
IEVsZWN0cm9uaWMgVGVjaG5vbG9neSBDby4gSSBhbSB3cml0aW5nIHRvIHlvdSB0byBpbnF1aXJl
IGFib3V0IHRoZSBwcm9ncmVzcyBvZiB0aGlzIHBhdGNoLg0KDQpUaXRsZSChsFtQQVRDSCBWMSAx
LzFdIG1tYzpzZGhjaS1wY2ktbzJtaWNybzogRml4IFNEUjUwIG1vZGUgdGltaW5nIGlzc3VlobEg
DQpUaW1lIDpGZWJydWFyeSAzcmQsIDIwMjMuIA0KDQpMb29raW5nIGZvcndhcmQgdG8geW91ciBy
ZXBseSENCg0KQmVzdCByZWdhcmRzIQ0KRnJlZA0KDQo+IC0tLS0t08q8/tStvP4tLS0tLQ0KPiC3
orz+yMs6IGZyZWRhaWJheWh1YnRlY2hAMTI2LmNvbSA8ZnJlZGFpYmF5aHVidGVjaEAxMjYuY29t
Pg0KPiC3osvNyrG85DogMjAyM8TqMtTCMjPI1SAyMDowNQ0KPiDK1bz+yMs6IGFkcmlhbl9odW50
ZXJAaW50ZWwuY29tOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiBsaW51eC1tbWNAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC5rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+ILOty806IFNoYXBlciBM
aXUgKFdIKSA8c2hhcGVyLmxpdUBiYXlodWJ0ZWNoLmNvbT47IENoZXZyb24gTGkgKFdIKQ0KPiA8
Y2hldnJvbi5saUBiYXlodWJ0ZWNoLmNvbT47IFhpYW9HdWFuZyBZdSAoV0gpDQo+IDx4aWFvZ3Vh
bmcueXVAYmF5aHVidGVjaC5jb20+OyBTaGlybGV5IEhlcihTQykNCj4gPHNoaXJsZXkuaGVyQGJh
eWh1YnRlY2guY29tPjsgRnJlZCBBaShXSCkgPGZyZWQuYWlAYmF5aHVidGVjaC5jb20+DQo+INb3
zOI6IFtQQVRDSCBWMSAxLzFdIG1tYzpzZGhjaS1wY2ktbzJtaWNybzogRml4IFNEUjUwIG1vZGUg
dGltaW5nIGlzc3VlDQo+IA0KPiBGcm9tOiBGcmVkIDxmcmVkLmFpQGJheWh1YnRlY2guY29tPg0K
PiANCj4gQ2hhbmdlIFNEUjUwIG1vZGUgY2xvY2sgc291cmNlIGZyb20gRExMIG91dHB1dCBjbG9j
ayB0byBQTEwgb3BlbiBjbG9jaw0KPiAxLkhTMjAwIGFuZCBTRFIxMDQgbW9kZSBzZWxlY3QgRExM
IG91dHB1dCBjbG9jaw0KPiAyLlNEUjUwIG1vZGUgc2VsZWN0IFBMTCBvcGVuIGNsb2NrDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBGcmVkIDxmcmVkLmFpQGJheWh1YnRlY2guY29tPg0KPiAtLS0NCj4g
Q2hhbmdlIGluIFYxDQo+IFNEUjUwIG1vZGUgc2VsZWN0IFBMTCBvcGVuIGNsb2NrIGFzIGl0cyBj
bG9jayBzb3VyY2UuDQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNy
by5jIHwgMzAgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qv
c2RoY2ktcGNpLW8ybWljcm8uYw0KPiBpbmRleCA5OGNhZGZmNDdiMmIuLjYyMGY1MmFkOTY2NyAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1wY2ktbzJtaWNyby5jDQo+ICsr
KyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktcGNpLW8ybWljcm8uYw0KPiBAQCAtMzM5LDIyICsz
MzksMjQgQEAgc3RhdGljIGludCBzZGhjaV9vMl9leGVjdXRlX3R1bmluZyhzdHJ1Y3QgbW1jX2hv
c3QNCj4gKm1tYywgdTMyIG9wY29kZSkNCj4gIAlyZWdfdmFsICY9IH5TREhDSV9DTE9DS19DQVJE
X0VOOw0KPiAgCXNkaGNpX3dyaXRldyhob3N0LCByZWdfdmFsLCBTREhDSV9DTE9DS19DT05UUk9M
KTsNCj4gDQo+IC0JLyogVW5Mb2NrIFdQICovDQo+IC0JcGNpX3JlYWRfY29uZmlnX2J5dGUoY2hp
cC0+cGRldiwgTzJfU0RfTE9DS19XUCwgJnNjcmF0Y2hfOCk7DQo+IC0Jc2NyYXRjaF84ICY9IDB4
N2Y7DQo+IC0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tfV1As
IHNjcmF0Y2hfOCk7DQo+IC0NCj4gLQkvKiBTZXQgcGNyIDB4MzU0WzE2XSB0byBjaG9vc2UgZGxs
IGNsb2NrLCBhbmQgc2V0IHRoZSBkZWZhdWx0IHBoYXNlICovDQo+IC0JcGNpX3JlYWRfY29uZmln
X2R3b3JkKGNoaXAtPnBkZXYsDQo+IE8yX1NEX09VVFBVVF9DTEtfU09VUkNFX1NXSVRDSCwgJnJl
Z192YWwpOw0KPiAtCXJlZ192YWwgJj0gfihPMl9TRF9TRUxfRExMIHwgTzJfU0RfUEhBU0VfTUFT
Syk7DQo+IC0JcmVnX3ZhbCB8PSAoTzJfU0RfU0VMX0RMTCB8IE8yX1NEX0ZJWF9QSEFTRSk7DQo+
IC0JcGNpX3dyaXRlX2NvbmZpZ19kd29yZChjaGlwLT5wZGV2LA0KPiBPMl9TRF9PVVRQVVRfQ0xL
X1NPVVJDRV9TV0lUQ0gsIHJlZ192YWwpOw0KPiArCWlmICgoaG9zdC0+dGltaW5nID09IE1NQ19U
SU1JTkdfTU1DX0hTMjAwKSB8fA0KPiArCQkoaG9zdC0+dGltaW5nID09IE1NQ19USU1JTkdfVUhT
X1NEUjEwNCkpIHsNCj4gKwkJLyogVW5Mb2NrIFdQICovDQo+ICsJCXBjaV9yZWFkX2NvbmZpZ19i
eXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tfV1AsICZzY3JhdGNoXzgpOw0KPiArCQlzY3JhdGNo
XzggJj0gMHg3ZjsNCj4gKwkJcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NE
X0xPQ0tfV1AsIHNjcmF0Y2hfOCk7DQo+IA0KPiAtCS8qIExvY2sgV1AgKi8NCj4gLQlwY2lfcmVh
ZF9jb25maWdfYnl0ZShjaGlwLT5wZGV2LCBPMl9TRF9MT0NLX1dQLCAmc2NyYXRjaF84KTsNCj4g
LQlzY3JhdGNoXzggfD0gMHg4MDsNCj4gLQlwY2lfd3JpdGVfY29uZmlnX2J5dGUoY2hpcC0+cGRl
diwgTzJfU0RfTE9DS19XUCwgc2NyYXRjaF84KTsNCj4gKwkJLyogU2V0IHBjciAweDM1NFsxNl0g
dG8gY2hvb3NlIGRsbCBjbG9jaywgYW5kIHNldCB0aGUgZGVmYXVsdCBwaGFzZSAqLw0KPiArCQlw
Y2lfcmVhZF9jb25maWdfZHdvcmQoY2hpcC0+cGRldiwNCj4gTzJfU0RfT1VUUFVUX0NMS19TT1VS
Q0VfU1dJVENILCAmcmVnX3ZhbCk7DQo+ICsJCXJlZ192YWwgJj0gfihPMl9TRF9TRUxfRExMIHwg
TzJfU0RfUEhBU0VfTUFTSyk7DQo+ICsJCXJlZ192YWwgfD0gKE8yX1NEX1NFTF9ETEwgfCBPMl9T
RF9GSVhfUEhBU0UpOw0KPiArCQlwY2lfd3JpdGVfY29uZmlnX2R3b3JkKGNoaXAtPnBkZXYsDQo+
IE8yX1NEX09VVFBVVF9DTEtfU09VUkNFX1NXSVRDSCwgcmVnX3ZhbCk7DQo+IA0KPiArCQkvKiBM
b2NrIFdQICovDQo+ICsJCXBjaV9yZWFkX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xP
Q0tfV1AsICZzY3JhdGNoXzgpOw0KPiArCQlzY3JhdGNoXzggfD0gMHg4MDsNCj4gKwkJcGNpX3dy
aXRlX2NvbmZpZ19ieXRlKGNoaXAtPnBkZXYsIE8yX1NEX0xPQ0tfV1AsIHNjcmF0Y2hfOCk7DQo+
ICsJfQ0KPiAgCS8qIFN0YXJ0IGNsayAqLw0KPiAgCXJlZ192YWwgPSBzZGhjaV9yZWFkdyhob3N0
LCBTREhDSV9DTE9DS19DT05UUk9MKTsNCj4gIAlyZWdfdmFsIHw9IFNESENJX0NMT0NLX0NBUkRf
RU47DQo+IC0tDQo+IDIuMzcuMg0KDQo=
