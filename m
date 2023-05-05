Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A1FC77B7F
	for <linux-mmc@archiver.kernel.org>; Fri,  5 May 2023 10:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjEEKEr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 May 2023 06:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbjEEKEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2023 06:04:35 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A4199D;
        Fri,  5 May 2023 03:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htG8JwEFgzAzFYagI9fw1BdCOoP5RXr5uTcH6WvAjMNDYwy18Wh3Lri6Nkbfv6YiynF7HmIRdpfbojilL/hAkrvdbRQiQBGgxqEtPH2qs5B8lFZH6UAX6CQO5Y4VRsGB0bizW2oWt2NuB04h43rM3VGeXYQ9hBuXrMcouhiKvbatZHTxvWm4fXg1yn7Di4Wn+4NyPMhj38quZGNysURcs+n15v1/tjzv7T2FBXg5qhYv73aMtqipW67xkllR8pmTRbTMEjMswaIoapyLkLmxZU+KijGXR1kYVhNrYvOsyeV3fMPGT5XkDEYjDboNvCJ96R8G25zSF4GGLqc4xWOE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHiKv8dfNqaCCl+AwSHKBQrZeidcYr9ma4w9DdZoHWQ=;
 b=QVQnQ4NL3K+wXitnqckBHFV6c9dEWrwJqjMe4cq7QRnoqZmmjcVB07HFR3tlDI4ON3PB9bdGn8b356lc9T2Xb8rRyjD4bmqtTCtQQda4Bt0nKnDThbEjgi2udom+5E8JXD7udHjdAggXHmgaHEaCi35oxXnY4mKitSuD9jGxuPtzybvEEhIWmGXjY/8Vm6sB99tnq+d6eV+926snsishBxxCQTKnYwoNhrrfZqiAYV2rqxjkoCNg3hkyP52RcmdmApGi4SK3tfVcgerfIF6J0HV1ikB93/Jtb4FScVls8MgmQeU/NVA88p3SdbWWMlF1D+Gi+D+bHFMZkAsqEBH1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHiKv8dfNqaCCl+AwSHKBQrZeidcYr9ma4w9DdZoHWQ=;
 b=c432p0YW71qA+wLKxz6AzbTVKH86eUWZ+cF6gl8PIDewsERDWl+qd3d/4+V5Ct/e9S+l2J5doshxuyluU2k+eCtKINDx5JUm7lWLH9f+8PpTHVznxu2PoJcLfpspgnCPn4QHmHHc5KBuUiJwKQf53Kuav9w8Ii9+cxqWkc/c34M=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8814.eurprd04.prod.outlook.com (2603:10a6:102:20d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 10:04:28 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::9d1e:facb:ae5a:25b6%3]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 10:04:28 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "kernel@dh-electronics.com" <kernel@dh-electronics.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Thread-Topic: [PATCH 3/4] dt-bindings: mmc: fsl-imx-esdhc: remove property
 "fsl,wp-controller"
Thread-Index: AQHZfy45fOkH9hgeGUK6IfCi+o9gWK9LatGAgAAISuA=
Date:   Fri, 5 May 2023 10:04:28 +0000
Message-ID: <DB7PR04MB40103C96EEEABC89A711867E90729@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20230505084955.238940-1-haibo.chen@nxp.com>
 <20230505084955.238940-3-haibo.chen@nxp.com>
 <168327918323.1945739.8862496839976686617.robh@kernel.org>
In-Reply-To: <168327918323.1945739.8862496839976686617.robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8814:EE_
x-ms-office365-filtering-correlation-id: ec708e76-601f-4c57-eec1-08db4d501d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oJ09mfuaN9khoFO8wXJCbojygkHzVSUflBzvDh0enq08jwzLKUwT/lvmZcm39ufpKGSeY58TETNs2Ckw6TaPCn1M+HprAdtFbgVm2ThZ1lQ6f1/l7YHI5/ctKBR9DhA+ROJ8d1p9p50GKAu7Mu6/cpOTxCBDGkJ9z4MKUX1NK8sL0UHam93YGJ+81o8ryZrNUqb4Z/5WdqiSsHAT79KIDHKmsxjzeGxvH6bhs96YawGmsz7YP+yo2wZCsur356qC0SjxQoaMC3HKreByLr/VvEgTmNSMWbGmsHgU4ZIOkj1WGPX/gKEXaafeYVmJxH4Ki4lqmKdg8esoKu+DtbTDyQj1qbvZKgzYFM+fDvG+g4BF3aMp6OCD4SpBxLHOSQ2KNukppeAUrwNJaW4bSapMCHMetacIl3RHG0IUy8k7K58eZhS1gvyxHzfTpbSTbWzl49xAM//l14nI2ghc+J3I7zy569RLSAaQUFNMhuvK4w7u7Xr6PqOuVeQQMNr2S8ddOyj8z0JiqC5VuDLnrVFh1F6pZ5LK5B3nqNlueUFIruJJRBoZWAAD85A4HuOPc9euj1GczZL9iea8ECOwsw+6eYMHoLTiAmqbnHzdBHo40nUWzy1FyIezlIE6Sy18vlMY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199021)(53546011)(26005)(478600001)(6506007)(9686003)(83380400001)(186003)(7696005)(966005)(71200400001)(5660300002)(33656002)(8676002)(8936002)(316002)(122000001)(86362001)(38100700002)(38070700005)(41300700001)(52536014)(55016003)(45080400002)(66476007)(6916009)(66446008)(66946007)(4326008)(76116006)(2906002)(64756008)(66556008)(7416002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Z1NwZFozZkFtMjRMa1NxQWx5a3JqeWZ6TTZDSkV3dEtoMXhrUUtnWXc4cFQ5?=
 =?gb2312?B?MVlLTlhySmZtSHA3UXQrN0hMTGdzaGpaVEwyYjlNTVZTcUtCMW1oeDNJUFJt?=
 =?gb2312?B?ZUVqMXlvRE5UTFIvbGpBV0ZiSEhtWmpEa21JRWVvYVJSd21GMi9QelJYSVZ3?=
 =?gb2312?B?VE5Ia3pXZlc3a1hsWnhXZHIzakQybTdQWithOHU4bVZwN004RWRlVTQxU2l2?=
 =?gb2312?B?aURiR1kwWFlVYUo1VFlLZDJnN1Vzc1dDb1YxcjhOY1NvRDV0OHdqV0dBOGpS?=
 =?gb2312?B?SUlUU3BucHBsYW53NDN5WWNIcURXNlhBL3RYVFU2OGt5eEplaERVWk81cFFn?=
 =?gb2312?B?cUVwdFVhM2lVQ2NDOHR5OWRHYTB5MXJmd1plMUxjMmtSYlBIT1pjalNuTnBy?=
 =?gb2312?B?clBiSEk3a1I4MEs0T0loNnYxRDg4Z1FHQitYNlBXUXQvOW5GYktxL1VzbEJh?=
 =?gb2312?B?c0tGOW9SOWNaSW9tdFRFSWtka1I3Y0dMeW5XbDU0a3JMVDNNVEZTRzlmbFE1?=
 =?gb2312?B?ZDN3OEFFTER3QUJ4WE9QN284Z053UkxlMkNySUxQeVZmUHZWVjlzSFF2Mmd2?=
 =?gb2312?B?eGxPTi80SlJXWjN2RjhPLzF2bUpVVFhQa1lpZ3VvSE9IUk5KQm5xQUo2d1Y5?=
 =?gb2312?B?S2V3b052MHF5bjJkOFB3N1owbGF3eVAzTUF1Z2c3RlFYTDBEcGthUnFoZkZZ?=
 =?gb2312?B?dm9iNmFWV0h6VmNCaWs5SWcvbXBkZzcvNmd1UjdjNzdGOUpxa0dsdS9lY1dD?=
 =?gb2312?B?c1Z0c3FGL3FvRzkzVUx5Sy9SbjIyWE9FS0gyWjlWeHFGTDRqeFNJcTR3ZW9W?=
 =?gb2312?B?b2R6SzZzdnJMc3MyWkxGeURkaTdIL1VsTmhZaHN1Sy9WVXRFRDA4M2tibEFj?=
 =?gb2312?B?VFhaVUZEOGpac3lKVkYxTVZ2UmNaUzlJMlE1RDdEWGpvWkM4R3E5aWJNT05X?=
 =?gb2312?B?QS8xOUFiTDd0T1oyc1VSSTNJNndhdnBsWXFCditEVldZWU1QM1FnT3ZyZEpT?=
 =?gb2312?B?UTVYTjloaUxCV2pCdjRISHZHTVZtd3VlcDl4Y2MvNks5WFJJSG1YYTJQWTNL?=
 =?gb2312?B?TzlEb3Nia0pOTFVKSEtob1dpMHhJWEJtQ2R1Z0Z0aVRaVmlMSEw3bnE1NnNF?=
 =?gb2312?B?Qmp6VWNnVmU4V1J1cndyM0QveEpRTytvNHdQQ3JQRHNzdU9yZCtIak0xOThX?=
 =?gb2312?B?Z1dRNWMvbW9NQVVLTjFSY0liUW5GTDN3V2g1MFVUTlR3aGMxZnBUOXFwbW9i?=
 =?gb2312?B?N0p6U1dsS3VZMGtrMEkwKzZqN01maFNGQ1lrcFAxZ2dIa2dPcUNZS3U5bzBq?=
 =?gb2312?B?M3hGZFN3K0ltbUROUmpyN1Y0UVhtVzdzYXpKN3NjMURnNFd5blo1SmNTSWVG?=
 =?gb2312?B?MGJxSnZOc09JMFJnWnN2VFp0Sm13YS9PKzVLTFplRmVXUEZyLzZsK1ZIRFk5?=
 =?gb2312?B?WjVwbTk2c0laT2gxRkhBNXZpd1AyQTFzOUdSRlJhN3RNL29zTklaMDJxdE11?=
 =?gb2312?B?bWlzeUl6dTVxQUdnNHVSRkxqWHh4MnF2bFNwRjVleHVwYUJORCtCNW1kWVZQ?=
 =?gb2312?B?eXBqS2NJMXRMamY5MlR5RXIyZDhrOGsxOHNlam1GaGhDUWlhWDNIWnZMWGQv?=
 =?gb2312?B?MUVGdktDaUhIaEgxcDlnM2hOTHdCN0ZST3hDMis0MnplNkQvMmVtZ0dGckFp?=
 =?gb2312?B?blB4STRpeUV0MmszRVZBMU5rSXR4V3ZycFpHNEVuYU9Ud3RKWFl2WG9jSEVG?=
 =?gb2312?B?VVdndWhJcEpGNCtYNDdJS25yVy85YUQ2b2ttVkNXcklrZXpUcjkzUmpsWFVl?=
 =?gb2312?B?a0Z1bWlDTTFoaUZwdE1ZU1N4V3JqQjAzRzBkeTI4ZFdKZmRNZmg1SjR6dEtN?=
 =?gb2312?B?cmFTNE1ndnczQzQxdUV1eG4rQXdDRXNPZEhBaGFYUTVEVTBTbkVlbm4xejlE?=
 =?gb2312?B?SndJUmIyYncxV3pPeDVQRGRQdXNxaDBucFdRd0cvZGp4eGpZVXB1MXN2emJ5?=
 =?gb2312?B?anVjQzIvUWdiTkY4MHVZeEZNUFFCNkp2eDY5MW9QVENwcnFrbHk3MGpycDVN?=
 =?gb2312?B?TnB5bGh1M1lFZEgvZG8zWVQ2eFBnbjBKcmNSK1U5OFZyRml0U2dLSitJVEZJ?=
 =?gb2312?Q?AmFY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec708e76-601f-4c57-eec1-08db4d501d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 10:04:28.4835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qjCHpJPNGRTsVwrCPtPKH9w2nJsdHIlGdi5EZZvAml4VtYNbimEMQtN+PAyGlD0MTpPchPZ3SFYG68UPD7PFJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8814
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmluZyA8cm9iaEBr
ZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOo11MI1yNUgMTc6MzMNCj4gVG86IEJvdWdoIENoZW4g
PGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5j
b20+OyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOw0KPiBjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25p
Y3MuY29tOyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGtlcm5lbEBwZW5n
dXRyb25peC5kZTsga2VybmVsQGRoLWVsZWN0cm9uaWNzLmNvbTsgYWRyaWFuLmh1bnRlckBpbnRl
bC5jb207DQo+IGZlc3RldmFtQGdtYWlsLmNvbTsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1
ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IHJvYmgrZHRAa2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIDMvNF0gZHQtYmluZGluZ3M6IG1tYzogZnNsLWlteC1lc2RoYzogcmVtb3ZlIHByb3Bl
cnR5DQo+ICJmc2wsd3AtY29udHJvbGxlciINCj4gDQo+IA0KPiBPbiBGcmksIDA1IE1heSAyMDIz
IDE2OjQ5OjU0ICswODAwLCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogSGFp
Ym8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+DQo+ID4gRHJpdmVyIGRvIG5vdCB1c2Ug
dGhpcyBwcm9wZXJ0eSwgc28gcmVtb3ZlIGl0IGhlcmUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sIHwgNSAtLS0t
LQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiANCj4gTXkgYm90
IGZvdW5kIGVycm9ycyBydW5uaW5nICdtYWtlIERUX0NIRUNLRVJfRkxBR1M9LW0gZHRfYmluZGlu
Z19jaGVjaycNCj4gb24geW91ciBwYXRjaCAoRFRfQ0hFQ0tFUl9GTEFHUyBpcyBuZXcgaW4gdjUu
MTMpOg0KPiANCj4geWFtbGxpbnQgd2FybmluZ3MvZXJyb3JzOg0KPiANCj4gZHRzY2hlbWEvZHRj
IHdhcm5pbmdzL2Vycm9yczoNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2R0LXJldmlldy1jaS9saW51
eC9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jDQo+IC9mc2wtaW14LWVzZGhj
LmV4YW1wbGUuZHRiOiBtbWNANzAwMDQwMDA6IFVuZXZhbHVhdGVkIHByb3BlcnRpZXMgYXJlIG5v
dA0KPiBhbGxvd2VkICgnZnNsLHdwLWNvbnRyb2xsZXInIHdhcyB1bmV4cGVjdGVkKQ0KPiAJRnJv
bSBzY2hlbWE6DQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1yZXZpZXctY2kvbGludXgvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYw0KPiAvZnNsLWlteC1lc2RoYy55YW1sDQoN
ClNvcnJ5LCBteSBiYWQsIEkgZm9yZ2V0IHRvIHJ1biBkdF9iaW5kaW5nX2NoZWNrIGFuZCBkdGJz
X2NoZWNrLCB3aWxsIHNlbmQgdjIgcGF0Y2ggd2hpY2ggcGFzcyB0aGVzZSBjaGVja3MuDQoNCkJl
c3QgUmVnYXJkcw0KSGFpYm8gQ2hlbg0KPiANCj4gZG9jIHJlZmVyZW5jZSBlcnJvcnMgKG1ha2Ug
cmVmY2hlY2tkb2NzKToNCj4gDQo+IFNlZQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90
ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwYXRjaHdvcg0KPiBrLm96bGFi
cy5vcmclMkZwcm9qZWN0JTJGZGV2aWNldHJlZS1iaW5kaW5ncyUyRnBhdGNoJTJGMjAyMzA1MDUw
ODQ5NTUuDQo+IDIzODk0MC0zLWhhaWJvLmNoZW4lNDBueHAuY29tJmRhdGE9MDUlN0MwMSU3Q2hh
aWJvLmNoZW4lNDBueHAuY29tDQo+ICU3QzMwNTYwMjdiMTQzNTQ0NjQ5ODE0MDhkYjRkNGJiYmJl
JTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMNCj4gMzAxNjM1JTdDMCU3QzAlN0M2MzgxODg3
NTk4ODY2ODA4NzQlN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4DQo+IGV5SldJam9pTUM0d0xqQXdN
REFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUzRCUNCj4gN0Mz
MDAwJTdDJTdDJTdDJnNkYXRhPUdjdW9XQjhwRGVpYSUyRnY3UnA3JTJGQTVnc2EwbHU5QTNxYVVj
aW4NCj4gSzk1cXolMkIwJTNEJnJlc2VydmVkPTANCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2Vy
aWVzIGlzIGdlbmVyYWxseSB0aGUgbGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeSBz
aG91bGQNCj4gYmUgbm90ZWQgaW4gKnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkg
cmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZSBlcnJv
cihzKSwNCj4gdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNj
aGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0tdXBn
cmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQgYWZ0ZXIgcnVubmluZyB0aGUg
YWJvdmUgY29tbWFuZCB5b3Vyc2VsZi4gTm90ZQ0KPiB0aGF0IERUX1NDSEVNQV9GSUxFUyBjYW4g
YmUgc2V0IHRvIHlvdXIgc2NoZW1hIGZpbGUgdG8gc3BlZWQgdXAgY2hlY2tpbmcNCj4geW91ciBz
Y2hlbWEuIEhvd2V2ZXIsIGl0IG11c3QgYmUgdW5zZXQgdG8gdGVzdCBhbGwgZXhhbXBsZXMgd2l0
aCB5b3VyIHNjaGVtYS4NCg0K
