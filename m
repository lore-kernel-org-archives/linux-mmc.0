Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0477ECAAA1
	for <linux-mmc@archiver.kernel.org>; Fri, 28 Oct 2022 11:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJ1LFz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 28 Oct 2022 07:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJ1LFn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2022 07:05:43 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821AE167F1
        for <linux-mmc@vger.kernel.org>; Fri, 28 Oct 2022 04:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTjbAnCsFFk7CMWds2GoKh7Oanfv0ZkrHnmAoEP8QNUc0f+l5X1DMn04jA+ZUQAq964vXXQVvE8trJgEs38eoUS4wU4xFidegEHQn4RP3tXxvMF/3oFiFSdwf2loPi5cDd0fHyCWXq0fhcCZoS9kwCZhYgxNFhQFGfchiQJaOWhgllK5VjI5FdzldwPgqKIQ6im0XCok/rIgYu+beW3hW9Uf7EwLCSZFNRXJE2bAMET0P3lnxFUG5VK2SlGbwbeU11QAaTAxToyfj1KyMS+O5WK0ndTR6xb/zIFPwODAesfz8v9bQpXPMrjCqmITKUd0R303+7GPTo6kCbWFqkzrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StRxl+pvJoduthcuucL8ViIorBTqSkImrygx0j56+fQ=;
 b=iw2EE9BlFM53OQWAjiJp/VzQJCUpaWxrwEsIr13RBBT+8npb4XJnQGH6JTxPkt9RPB0Fh9p+GO5vS0vU1Icw7cHFkNvVD9+PqEeiZ/APZguCAf4mkCut4yvdYnogY950sXBJ9F4fSpbWgtTl2Hxz5mJ+xexsMEuj0eP5ssUm6shL0VtOLEsrNKv+x885hOSdpw3dIUdsUF3E1zYmodcFhnY/w3WdZYuZ9dw7kYeAMNvSKYNFHEbFEHO3VmoDPasUPYTxC+zgrpAQ/WXeIniOX3ehxXwziWuh3+H5oBgGxjde6mDkY9ZjNQ8xCk56gCAhw/ixlvzWdjNKUCWkM/VrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StRxl+pvJoduthcuucL8ViIorBTqSkImrygx0j56+fQ=;
 b=fHwKs6CEE7jaKM08qT7ogjJOrEt9BfXUGrPKQGTuMjYehRPxNAwNQyS7NU7yOGKjnmLMZY4Ipds1QGFe9PIatmrMOrYB02CSPBqaT/AeZ2cr2CpmcD4W6FekHXKsabvuHMbjMPg0MG1MDAX4uqbrwbOhBgPrRsoYU2FhtpXhMN0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AS8PR04MB8690.eurprd04.prod.outlook.com (2603:10a6:20b:429::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Fri, 28 Oct
 2022 11:05:39 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5746.028; Fri, 28 Oct 2022
 11:05:39 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before
 execute tuning
Thread-Topic: [PATCH] mmc: sdhci-esdhc-imx: reset the tuning logic before
 execute tuning
Thread-Index: AQHY6q8xQsQAYGIN2E6BEgyVO5zjKa4jl7sAgAAJuJA=
Date:   Fri, 28 Oct 2022 11:05:39 +0000
Message-ID: <DB7PR04MB4010601305D7D5A2042A741390329@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <1666947869-7904-1-git-send-email-haibo.chen@nxp.com>
 <CAOMZO5AVcnvSwwKhnnbBKVJiJPOd1fTTt_PSNsZY4539c-oZ2g@mail.gmail.com>
In-Reply-To: <CAOMZO5AVcnvSwwKhnnbBKVJiJPOd1fTTt_PSNsZY4539c-oZ2g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|AS8PR04MB8690:EE_
x-ms-office365-filtering-correlation-id: 02d572f8-8499-41aa-6e0f-08dab8d458f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1OARJkxWGwQS3u74EvTiDiFsrWnYCpUDCmGXCVIiyiVTPggpLYXi1ID+L75hZsoc4IYpuZOIRX3hBZDTrc1h2BS4D4u5DAiJTnmgdgZjYojCxMSm++RkqQmoE+dwOiNuZoQYo7GOyI2nfXIvJcl2ROcwxl0HqflErQw35ot3ZQVN6DPy8tUphSAejl2Q/0uAJTa761+jB+fxTlV24AlPZhGqU6a5IJrkxLMfF5uckAP051qMvlzkMF+TfiZiU2ljZ3OT4Xd3oG3B5mxgY7J9avkr/Hu1LjwwHVggrpedkC0CI0SocHsLGPkrahq82Asu+Gd5qz2gbdkfCE+5kOn50tAOdZgwcb55BYMLa7WiOdanvbQrjElUeZDCI2KuQZ6VBNoWnfr95miyc0R8lk3sEEZyWRZ8DLCe/XEvocMjizA6b9eoqtDIggZKmPN8+l7puHnexkPyzsG6pxEAJs6HMIyOQLXkXxczyISflZLrX9wTbOVoJE68Op91juh2pz33Mb9rieS5ZPZt+VZahPMD96RlyO9Dkrin2aXIh2tMidlfsXCFbSxpUYWOafY5gFr1mbDLrPKnk/ayiNqo2+lG6PYHHoZK0T0lF+0ReSCrsi/1mqZ3uaZgv/sT8urtx+7e/8/5NXSowBHAL6h+fLan3Yi2M0PzbEoham7trVS4z+lX/lPD7jtNFoCiwpoc33TGFMnK15wkkS5X7H/04WIBDtARd2ULZUzppnGsxeELbL8J7o4z7kfs2mcGHusKEJJG+H2/LK02RT53TkACPsxRvQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(396003)(346002)(451199015)(71200400001)(41300700001)(8676002)(52536014)(38100700002)(64756008)(4326008)(76116006)(478600001)(5660300002)(54906003)(33656002)(38070700005)(66946007)(66476007)(83380400001)(55016003)(53546011)(316002)(6506007)(6916009)(66446008)(8936002)(7696005)(2906002)(86362001)(26005)(186003)(9686003)(122000001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWRLSDJ4SXF5aE9XR0xQdko4TG9oZklYaENOcUwxWnBERlhTUXlDK0kySlJl?=
 =?utf-8?B?clo1VGtxSDRYWDQvMlMza09jdThkdE9VM1FJOFliTUp1dFl2WlRtM0RXZU1r?=
 =?utf-8?B?dVNlZHAycUF0ekNLYSs0UjZRR1J1cmlmT1M2UDhtZjI5KzZjVlA5Tkc3VFB5?=
 =?utf-8?B?b2x0WDUxNy91Vndac3NMMk5UMUhGaExmeUVTTTMrQkxJMmFjR21ab3h2cFhi?=
 =?utf-8?B?YlNISE9oL0ZuMCtkY1BxZHBMYjh4b0ZYZHl1U2IxcFMwaS9ZUDJ4K0M0WEMy?=
 =?utf-8?B?ZWozNXYxNEF2eTZYaW9aT25WQmUzVVlNaUhKMXdkV29BV2pSNUdyb2x5cU9r?=
 =?utf-8?B?Y2JnNmRDYjU2eGxIWUZxSklicVBuOFhaWG16RTNqamJJZnRvQmIxV2YrWE9L?=
 =?utf-8?B?K1U4TDhhS3NMQmFnU3JoelQzYy9hOUlLYjg4dUJCUzlNczg0WUVCck5qSXFR?=
 =?utf-8?B?UFIvTVFpeDI4SFpBR25LL0VHbUU3V05oOXdwcDZoZTBKcWNGK0NvRVh1ZlNR?=
 =?utf-8?B?cVJJbFR0YzlHSVBmaCtZSW81TGwxaGJDblZHYytRbFhrNkk4NHVkNG1PNzJh?=
 =?utf-8?B?QXNTcmtid2YvT0N3S0N2UGFrMnI3OXBON0E1MVQxNnJLMlBCZ2FDQ2JNV29y?=
 =?utf-8?B?MXJsNEFEVDJFMzV3YlVuc0pubWx4TktySWU0R29wcXAvQzltYk52aWZtUHhj?=
 =?utf-8?B?RFZxdys5QWl5YVJGREV3bGZmL2lUNExWVmtpdFlva3JaOVZqZ21tQ25UU1Zm?=
 =?utf-8?B?Y0NaMTNpd2JtaExLakJkTVZuK0VmSE85WXJnRlF0ZTRrZWtmeWJXQXpjOUhR?=
 =?utf-8?B?UVVrcDdRVXYzdHBsSWtoUVhUTnFjY1BEWWdoYmM4T3FYVUEvLzBucnArbG80?=
 =?utf-8?B?SW5jcHZRdkw5RXJkMk90MVBOWTBaaUxpWXhudk95dmZ4UnRJbGxkbzhNamVk?=
 =?utf-8?B?bVNMQjZvb3FQTndPUzg1bGdSYUJ5ZFNOdFlOQlZLQi94UElqYkdTQ2FvQ2tN?=
 =?utf-8?B?cjFrb3NJaWFlcTBvNUVCb3NKYnVZck9tTDRBdHlhREpBLzYxa0wzL3hqUkJ5?=
 =?utf-8?B?OU1NSnQ5V0U4OWUxMlZrREYvV29YWFJpZThkdWNaREFSRC8ycndFSnROcktT?=
 =?utf-8?B?d3JtcmhpY29vU1dHaFMzWUlKMWhjV0U5VzVic1M1L2hpVTk5ZU9hWUJtL0tC?=
 =?utf-8?B?ZnRSVW9Xb1N1TDM5VzZXT3FqZDJua0hzbGJ5TE9CcGZpbG54MUo2STk3cEdB?=
 =?utf-8?B?MWJHUXRJY2NlV21jUkJVOGMrVnQ1VUplQ0dreHlUbnh4Z3hiS0M5aU5VL0VZ?=
 =?utf-8?B?WEtXTGcwRUdySHZjSkRvbUVIOE9vSmtMTXhCRWFCWHNEejdPRjRuQzR3OElR?=
 =?utf-8?B?TDRiVmp2aVNxNU92ZzdFa0V5L1k1M1NBWlY1eHROU09qTG9TeUVITVdYZEtW?=
 =?utf-8?B?akNIWVhHY2p6Q08zMjFVcGhNZE9acVlNMTIzSmxnekhKcExqQ3F2WnNpVXF1?=
 =?utf-8?B?QUF1WUp3aWJnOW5xVVNRODFMakJJSkZ6NzFKTDlBNEVYblIya0hBRjJtMlRu?=
 =?utf-8?B?WW9MT1hia21lRndJU2RNeWpsT3NWR241VnZyeitDNURYQnNtdlBlNVdUUlMy?=
 =?utf-8?B?WTN6Z0FiSnhJMVRBN2tYUTlta1JFVUhyQVdvcHBrbys4dkIrUjBoMzN0YVR4?=
 =?utf-8?B?TUo1OVBiOVc2NHJRcHpXNnE0NG1uR0lmK3dJS0luTEZkUmVLb25kVktGTXZP?=
 =?utf-8?B?NmtLaFV1Q3FQcld0WnFPQ2NNYnlQUXBvVlVjYXdnZ2syaFNMOVRBU3l4cmVH?=
 =?utf-8?B?Y2VmK2dDeDVRRHR2cG5aYXJ1RnRmcGpWNXlzc2NWTS9ZZFFqeHpiWnBTSlBp?=
 =?utf-8?B?WHpBQXJXVmcrclVoT1YzSnhscW9KT1FkeFN1dzdpMzhmWExUZlBzczdHMkpG?=
 =?utf-8?B?YUtBbFpxTmhFTmhYK1kxNEx6OGl1Q3VNYi9NUkpyTHB6RlV1RGZ2Y25iaEJr?=
 =?utf-8?B?V3BJbWRhQS8zanRYekdDZUlUQUhXN0poQWhURVUxb2hVblp4QTlrU0krQWNB?=
 =?utf-8?B?Uy83Mk53ZmUyR1lDYnhtc3hsWC8rQWdyRk81dVUzWkFYYnBhVjZpVDR3cVFu?=
 =?utf-8?Q?a0HbllpgsUMHj/gbZlzIFzD3G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d572f8-8499-41aa-6e0f-08dab8d458f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2022 11:05:39.1050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5WtXQYx7JTH/rX3Dd/aOaMorlyJV+lg+8Mfg9/fl7c98Pm5Sqpd3xSzI8L3j0xB8JRO9GHiBNRVZpsnj5g7tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8690
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IDIwMjLlubQxMOaciDI45pelIDE4OjE4DQo+IFRvOiBC
b3VnaCBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+IENjOiBhZHJpYW4uaHVudGVyQGludGVs
LmNvbTsgdWxmLmhhbnNzb25AbGluYXJvLm9yZzsNCj4gbGludXgtbW1jQHZnZXIua2VybmVsLm9y
ZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47IFNoZXJyeSBTdW4NCj4gPHNoZXJy
eS5zdW5AbnhwLmNvbT47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXgu
ZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBtbWM6
IHNkaGNpLWVzZGhjLWlteDogcmVzZXQgdGhlIHR1bmluZyBsb2dpYyBiZWZvcmUNCj4gZXhlY3V0
ZSB0dW5pbmcNCj4gDQo+IEhpIEhhaWJvLA0KPiANCj4gT24gRnJpLCBPY3QgMjgsIDIwMjIgYXQg
NjoyNSBBTSA8aGFpYm8uY2hlbkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEhhaWJv
IENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gPg0KPiA+IEZvciBzdGFuZGFyZCB0dW5pbmcg
bWV0aG9kIG9uIHVzZGhjLCB0aGUgcHJldmlvdXMgdHVuaW5nIHJlc3VsdCBjYW4NCj4gPiBpbXBh
Y3QgY3VycmVudCB0dW5pbmcgcmVzdWx0LCBsZXQgY3VycmVudCB0dW5pbmcgY2FuJ3Qgc2V0IHRo
ZSBjb3JyZWN0DQo+ID4gZGVsYXkgY2VsbC4gQW5kIGZyb20gdGhlIGxvZ2ljLCB0aGlzIGlzIGFs
c28gcmVhc29uYWJsZSBmb3IgbWFudWFsDQo+ID4gdHVuaW5nIG1ldGhvZC4gU28gcmVzZXQgdGhl
IHR1bmluZyBsb2dpYyBiZWZvcmUgZXhlY3V0ZSB0dW5pbmcuDQo+ID4gVG8gYXZvaWQgY29tcGls
ZSBpc3N1ZSwgdGhpcyBwYXRjaCBhbHNvIG1vdmUgdGhlIGVzZGhjX3Jlc2V0X3R1bmluZygpDQo+
ID4gdXBwZXIuDQo+ID4NCj4gPiBGaW5kIHRoaXMgaXNzdWUgd2hlbiBzdXBwb3J0IFNESU8gV2lG
aSBpbiBiYW5kIHdha2V1cCBmZWF0dXJlLiBBZnRlcg0KPiA+IHN5c3RlbSByZXN1bWUgYmFjaywg
d2lsbCBkbyByZS10dW5pbmcsIGJ1dCB0aGVuIG1lZXQgZGF0YSBDUkMgZXJyb3IuDQo+ID4NCj4g
PiBEbyBub3QgbWVldCB0aGlzIGlzc3VlIG9uIFNEL2VNTUMsIGJlY2F1c2Ugd2UgYWxyZWFkeSBj
YWxsDQo+ID4gZXNkaGNfcmVzZXRfdHVuaW5nKCkgd2hlbiBjb25maWcgdGhlIGxlZ2VuY3kgaW9z
LCBhbmQgU0QvZU1NQyBuZWVkIHRvDQo+ID4gcmUtaW5pdCB3aGVuIHN5c3RlbSByZXN1bWUgYmFj
aywgYnV0IFNESU8gZGV2aWNlIGRvbid0IGRvIHJlLWluaXQgaWYNCj4gPiBpdCBoYXMgTU1DX1BN
X0tFRVBfUE9XRVIgcG1fZmxhZ3MuDQo+IA0KPiBGaXhlcyB0YWcgbWlzc2luZz8NCg0KSGkgRmFi
aW8sDQoNClRoaXMgaXMgYSBidWcgZml4IHBhdGNoLCBidXQgaGFyZCB0byBmaW5kIGEgZml4IHRh
Zy4NCg0KSW4gdGhpcyBwYXRjaCwgSSBqdXN0IGFkZCB0aGUgdHVuaW5nIHJlc2V0IGluIGZ1bmN0
aW9uIHVzZGhjX2V4ZWN1dGVfdHVuaW5nKCksIGJ1dCBmb3IgdGhpcyB1c2RoY19leGVjdXRlX3R1
bmluZygpLA0KaXQgaXMgaW52b2x2ZSBpbiB0aGUgY29tbWl0IGRlM2UxZGQwOWI3MiAoIm1tYzog
c2RoY2k6IHVzZGhjOiBkbyBub3QgZG8gdHVuaW5nIGZvciBERFI1MCBtb2RlLiIpLiANCmlmIGZp
eCB0YWcgcG9pbnQgdG8gdGhpcyBjb21taXQgbnVtYmVyLCBsb2dpY2FsbHksIHNlZW0gaW5jb3Jy
ZWN0LiBCdXQgaWYgcG9pbnQgdG8gYW4gb2xkZXIgY29tbWl0LCBsaWtlIA0KZDkzNzA0MjRjOTQ4
ICgibW1jOiBzZGhjaS1lc2RoYy1pbXg6IHJlc2V0IHR1bmluZyBjaXJjdWl0IHdoZW4gcG93ZXIg
b24gbW1jIGNhcmQiKSwgaXQncyBoYXJkIHRvIHBvcnQNCmN1cnJlbnQgcGF0Y2ggdG8gdGhlIGxp
bnV4IHZlcnNpb24gYmV0d2VlbiB0aGVzZSB0d28gY29tbWl0IG51bWJlciwgYmVjYXVzZSBubyB1
c2RoY19leGVjdXRlX3R1bmluZygpIHRoZXJlLg0KDQpTbyBJIGp1c3Qgbm90IGFkZCB0aGUgZml4
IHRhZyBoZXJlLg0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0K
