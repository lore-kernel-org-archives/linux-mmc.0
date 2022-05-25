Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC8C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 25 May 2022 10:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241558AbiEYKVZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 May 2022 06:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241401AbiEYKVY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2022 06:21:24 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47848A056
        for <linux-mmc@vger.kernel.org>; Wed, 25 May 2022 03:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYtBq3oKUk5f6PGriR5BDuzKIHAMQlHKaIE9qaOVdCIJZsj6TIsvicI7F9grw5M5PyxDKzcQKGS5mPzvPKYeidIOmp7F4qaYWwoLm0ReixRKgNqys0TjgpVitc3mXuXAte4EWBKBH696z49fPTNfoTTLgqGOXBT+uwHF7aK/7Jx2EgvoguTPyQF2rZlr0fJemADlT/t1nDjD/d+i2WcHYaS6Cw0CKuTns1JEYdzGLRh+nEVWYEgso7dFni/JYLyuc5BoIRxmJSaTfSTurnWtsBQ2/bO0toTemM1eD+dkcYqDVh/C0s/dPv4DY83ZRn/4Wh4+tjHqR/aBoGfGYgatZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWHHETBqt0zVVqgQyiwK74gi8aEtcuw9nfXaOGYzTAA=;
 b=WyQkkqpQR93GZfKY4p2IPITr2lDhUHiH9g2uxaYbPpbXl/0RAkkPIJnRkwSno9wojPMm/b5mXeFV8pTasNH4LCbTGU/GLgkaAFpGqQ2mizixFu15mWocaTGiv5u1R7mT83+yN5ktQW+W+tYKKOTVxFJKwTwOXS/U2L4+WhW3vycW9lmAub2y5rJEb8+BlTtBrBf3rKT6A1hiekzPqCu/7CJjqWmckRK+BFDnqbPgaokhbkQ1lNRvJ7rEOK4CzKQTQOJGtDiFMrT6hqkiGwEP5CvCZI3uzRSv//CnqnWyiwlfPgBLwUIjc2Tk9M6Gg3yh90Nlq0JODysp3/RWMpidvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWHHETBqt0zVVqgQyiwK74gi8aEtcuw9nfXaOGYzTAA=;
 b=JtAJUYDvIhg1ImzsY2IJ8fZSisq8KWssTXJUAeRLRjI0IbwuV6zRSPtipAmvn1vnG3wGi9MsN4FzdazcVaOAa+ZU4jufsdKfB3LYnU6XlynYcdbkJVp5IWnscxYnLPObdeQj3rPgcHyQqWxMf9bU6inF3AxQznLxLvJ9erdLSjc=
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com (2603:10a6:803:4a::27)
 by VI1PR04MB5856.eurprd04.prod.outlook.com (2603:10a6:803:eb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Wed, 25 May
 2022 10:21:20 +0000
Received: from VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b4b9:987b:257e:30fd]) by VI1PR04MB4016.eurprd04.prod.outlook.com
 ([fe80::b4b9:987b:257e:30fd%7]) with mapi id 15.20.5273.023; Wed, 25 May 2022
 10:21:20 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Martin Fuzzey <martin.fuzzey@flowbird.group>
Subject: RE: imx7d: Timeout waiting for hardware interrupt.
Thread-Topic: imx7d: Timeout waiting for hardware interrupt.
Thread-Index: AQHYb3KKHoAc9X39aUeZYJ5mNEqnn60vYhyQ
Date:   Wed, 25 May 2022 10:21:20 +0000
Message-ID: <VI1PR04MB40163FEB8AEC32F55E51931890D69@VI1PR04MB4016.eurprd04.prod.outlook.com>
References: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DCbC6MK=O1t20nLNKf2Oipf-Ar1TkHU+o9Bvpr0JRtxQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76869702-300f-4f3a-feac-08da3e384fce
x-ms-traffictypediagnostic: VI1PR04MB5856:EE_
x-microsoft-antispam-prvs: <VI1PR04MB5856DD89EE4A24FB004E5BA790D69@VI1PR04MB5856.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LrYbabTy9tZKBvUnKGRG37gIwBdRh1OuTEEvzbufmMl2KpZ94YrSO8sQGzoZFeLeMnwaiRuaeYqDSxpKGV/ImQ3Z1+3Ov93kM4WgrAahzuLjSNs6SIxc9/LviB1S4pff5F2nylvJ0Zjeq4kJXJOfItFseBqKON+/GpxHaa/6fTQQBjJHMBHdzhwFmmOwqE2q0ei/k/0F0wdZfazjhlsmvodLJSYCVuF4rL4hhOjKorUsvBuaRvA0at3vv9O3Czc+sAmLQPnoyhIb6qDWATahXji3nB5Naec0Yp6Uc7EIAuORbssKv3werr/+sPpUSCT/hy23BF0Vv+3IpCrezrsry42jTJtwRTQOKSs/MQJfNy49+TjeCA3lfGW3QbcK00NBCVTh9/KX5ROCReNlFNkIGYc0xPzzW0vxq+vnn5KZBIQak4LWCZIDKbSKe7on3Hwm3m3g9d5u0tiIDCSu0ca49oD8ilCfOWU5hEJm3mWocod60c0h964xk1AMH4VdCrTYVe/vvD8VBTH4EU4myRT0Ev9sydXKhmtZ9dqCjP/SnRjfjGXFplT4AOoqn3ogxPmxwSfXrpN2rA+9qmKl523JcA0o0W8rd50na32nUyU0k/aeWTCWThEiVOAk6oS5+uRwyf769nM3amHGkuBo+/sABXW9cgNJPGHicxOboPolIs59j5nfKUrLEPs66XPGeUgIePF57xkdWeuFG6WZfN33tg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(53546011)(2906002)(54906003)(71200400001)(83380400001)(86362001)(508600001)(33656002)(6916009)(316002)(52536014)(55016003)(122000001)(5660300002)(7696005)(6506007)(26005)(9686003)(8676002)(4326008)(38070700005)(38100700002)(66946007)(64756008)(66556008)(66476007)(76116006)(66446008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bTA5VHYxYStxaWVhMVg5TjdFdHJFZXdpQUk2RE00S1pkcWErRFdjekZsKzJF?=
 =?utf-8?B?Y3hKZVlESGxoZm81T1h5N3RnRkRCYTBFWCtZSkxJUEkrSFhYOFJjZ0o5eHN6?=
 =?utf-8?B?dVFtalk4ZE5RTjAyT1RneENTeUZCb2VYb21JVGxocEZMMlBWSTFJbVFmSkFE?=
 =?utf-8?B?Q0VJS3c4eFVTMjRqSktORUp2VTRsZmhPREh1NW9PdldLR0h0MEVpaERTdDVy?=
 =?utf-8?B?ajNHUVlBVDQ1NXJnZmtmeTJmZXdJcHpDRVNnUGRMaUpnZU1JVldaNStCR21Z?=
 =?utf-8?B?YWpMVkZuODFuZEJKVTYrUnhEdWxuZ05rQ0l6bTN2UXBFa0dVSHRQTS9sYlpj?=
 =?utf-8?B?T3ByZ1dFU3g3bGFPZXYrNTFaV2F4d1BMTGxkZytWK2NhVGJGSnQvZHZGdWx6?=
 =?utf-8?B?b040SDF1TVhlVjljaFFxeXVWTUtablhXUDByYTJZNlRMdzY2SWV3OERpZ2ZE?=
 =?utf-8?B?VUFQNTFtMDVYdlkrd1BKbjRxckNqdXRTcW5TbkZHM2hvR3djdThraHdXTmZU?=
 =?utf-8?B?dmRuWUgvTDAzZktjeHo3Vm9nR3pWUzlpWU1WVzRKeE1pcnBxeVp3U2FaU2tq?=
 =?utf-8?B?RkYwck5ydDdJUzNqNlVTeGsvV2FJNTJSL20ySDZFVExmeWdWK242YmYzR2VS?=
 =?utf-8?B?RUNOTVNVamM0OW9seWVsZVNyRHhjS3JqVWZOeEJGWmV6ZjZoYU42bkNiRnor?=
 =?utf-8?B?WXgwRGdwTUtxQjV1VVErMnFhWEFBRWxrZFpOY08zc1A2U2tnR2ZVWjVEakFB?=
 =?utf-8?B?dkRWT0ZsOUNvL3dJcjBUZG81SzN3bktuSDhRUHRNbm5aMFY0eVRFbDdpTUZm?=
 =?utf-8?B?MG4xSEFEVzlOVnBVRjhwelYwaXdDV1ZZODRjajhtb3NoblJoQnNPVWF0Zmp1?=
 =?utf-8?B?bGkzTUM3eVpjZ3paK2dmYWVIdjhmRHFtcmR2ZUVlb0ZId2Z3TFZVdmJPUDdj?=
 =?utf-8?B?VXlZcVBqSlEzd1IyV2VmNDRoR053U2k2UmY5Q3lmdWdTRWtqYitjbVFoUW9n?=
 =?utf-8?B?K2o0dndZK1ZkcTJ3OWdBU3FwdVNXcU4zZUgyNmh4ekdJVGsvRFQ4UHhhUk9n?=
 =?utf-8?B?SVhmV0hRdmsvcWFpcTlSYmp4bkVUb0NyKzV4V2JkVHVSdEtBQ0oySG91cTJQ?=
 =?utf-8?B?SkM4V1lwTEZXSFF3OTZNUGpZVndTbHdyNlV2THQ4amcyOC9jV2JQcXFNc01V?=
 =?utf-8?B?dkg4WVIreSttbHczTnNlWnU4Q1NZTk5tN0xrU2doc0xHOE85a2xieEpEMVdD?=
 =?utf-8?B?Y053dUgyLzFDRHQ5TWYvcnNhbnFzdFk3bVFGTHJWTDRwTG5wNHl4dVlOb3lX?=
 =?utf-8?B?YjBUWCtPMnczVDNmcGk2M3FuSXRyWU5EbHM4Nk5NaU5CMHhmN003aHV2Qk9Q?=
 =?utf-8?B?bUhDWFNjN0QzeUcyZmowS215SUdtZlFHNUJaZkhOS1hITkoxY3JWMVdzamc2?=
 =?utf-8?B?RUwxRE84T2FCS2hneUQxNUFlbUpPUDI2MGpHaVB3UXlFblRBcTdJVWQ4ZWxD?=
 =?utf-8?B?TzJhYy9BdnNZdldEYi9WMURiR0ZFYTNZSG1mT3huQ3E3VVRhbkpzcGljRWZk?=
 =?utf-8?B?R0lleHU4VklxdWpuK3d0aC9seWRNZW14TlpSMllBSEU0VElmUnJ1czVYcXhE?=
 =?utf-8?B?RWhFUXpHVXEranFqWWhXR0hkS3UxZ0lpZ3FPU2Ztb3Vpc3dZdXcwcVFCRXky?=
 =?utf-8?B?Y0VKVndPS1BCYjI3a3plQ1FsRDlNbkloekFUVWFlcGxwOFNjRXg4VjBUYVpv?=
 =?utf-8?B?dXg1dnIrK1l4K1RHOStBdm41WHZxSUtCZHFtMUZSVWRhVGtBN3Y5MExmNTAx?=
 =?utf-8?B?VVUwQUxaQktQR001NmlUdUtLeHg3eFlINUNzYk80cklyRkhMUStnU1JBM0p1?=
 =?utf-8?B?L2p0WnR6WkgzN3pUdnlHNHdRcUVjbW1RYlgwV2pVQUhPd3ZsWjcrdnNGSHF6?=
 =?utf-8?B?c3h1MEdJeHdQWUFFdVlEdUpmamFtWUJRQ2pGSDA5T1pMUno3bUt3MkdTQVhC?=
 =?utf-8?B?RmNuL1QrRkxSd1pUUGNDdDZSU0JMSXlwMGNJdHhUbjhQdDdFQk1iNzBmVHNW?=
 =?utf-8?B?YXc4dVdzNk4ycDBUVzRHb2pScmVQTkFoNHVwOEN4N2VHK1ZBVFJ5WnhTWDVx?=
 =?utf-8?B?S21zYk1UUTdoajZQWllWL3VKVzN5cXZvMFYwc1h0bkNwcGpVVjk5TkplbzBX?=
 =?utf-8?B?OEFnSkk5bWNjMFZJNEV0WWF6N05CK3c0SGVXZGxGckJBS0RibDF3MFRJWEdi?=
 =?utf-8?B?MGppVkdMS2xJM0ZOclJhcjdId2Mzem1PL2o1ck1ZdC9Wb2ZSdFZtODIvdmlX?=
 =?utf-8?B?c3Z4VVdFUTlFOTNhd2hVcXZBanZCbFlIQnNYbjZQd2V2bjc2RS9pQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76869702-300f-4f3a-feac-08da3e384fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 10:21:20.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 93LeHGyq6iH66ZbMgGDljlJOsej1K5/tLUPrl2wUlqK8WiO/1yJgPdNbEc8brj/XbAAiHcjNqrVWQaH0dL++sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5856
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMuW5tDXmnIgyNOaXpSAyMTozMQ0KPiBUbzog
Qm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiBDYzogbGludXgtbW1jIDxsaW51eC1t
bWNAdmdlci5rZXJuZWwub3JnPjsgQWRyaWFuIEh1bnRlcg0KPiA8YWRyaWFuLmh1bnRlckBpbnRl
bC5jb20+OyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgU2ViYXN0aWFuDQo+IFJl
aWNoZWwgPHNlYmFzdGlhbi5yZWljaGVsQGNvbGxhYm9yYS5jb20+OyBNYXJ0aW4gRnV6emV5DQo+
IDxtYXJ0aW4uZnV6emV5QGZsb3diaXJkLmdyb3VwPg0KPiBTdWJqZWN0OiBpbXg3ZDogVGltZW91
dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRlcnJ1cHQuDQo+IA0KPiBIaSwNCj4gDQo+IE9uIGFu
IGlteDdkIGJvYXJkIHJ1bm5pbmcgNS4xMC55IHRoZSBmb2xsb3dpbmcgbW1jMiB0aW1lb3V0IGlz
IG9ic2VydmVkOg0KPiANCj4gbW1jMjogVGltZW91dCB3YWl0aW5nIGZvciBoYXJkd2FyZSBpbnRl
cnJ1cHQuDQo+IG1tYzI6IHNkaGNpOiA9PT09PT09PT09PT0gU0RIQ0kgUkVHSVNURVIgRFVNUCA9
PT09PT09PT09PQ0KPiBtbWMyOiBzZGhjaTogU3lzIGFkZHI6ICAweDgyZjk0MjVjIHwgVmVyc2lv
bjogIDB4MDAwMDAwMDINCj4gbW1jMjogc2RoY2k6IEJsayBzaXplOiAgMHgwMDAwMDAyYyB8IEJs
ayBjbnQ6ICAweDAwMDAwMDAxDQo+IG1tYzI6IHNkaGNpOiBBcmd1bWVudDogIDB4MTQxMDAwMmMg
fCBUcm4gbW9kZTogMHgwMDAwMDAxMw0KPiBtbWMyOiBzZGhjaTogUHJlc2VudDogICAweDAxZDg4
YTBhIHwgSG9zdCBjdGw6IDB4MDAwMDAwMTMNCj4gbW1jMjogc2RoY2k6IFBvd2VyOiAgICAgMHgw
MDAwMDAwMiB8IEJsayBnYXA6ICAweDAwMDAwMDgwDQo+IG1tYzI6IHNkaGNpOiBXYWtlLXVwOiAg
IDB4MDAwMDAwMDggfCBDbG9jazogICAgMHgwMDAwMDAzZg0KPiBtbWMyOiBzZGhjaTogVGltZW91
dDogICAweDAwMDAwMDhmIHwgSW50IHN0YXQ6IDB4MDAwMDAwMDANCj4gbW1jMjogc2RoY2k6IElu
dCBlbmFiOiAgMHgxMDdmMTAwYiB8IFNpZyBlbmFiOiAweDEwN2YxMDBiDQo+IG1tYzI6IHNkaGNp
OiBBQ21kIHN0YXQ6IDB4MDAwMDAwMDAgfCBTbG90IGludDogMHgwMDAwMDMwMg0KPiBtbWMyOiBz
ZGhjaTogQ2FwczogICAgICAweDA3ZWIwMDAwIHwgQ2Fwc18xOiAgIDB4MDAwMGI0MDANCj4gbW1j
Mjogc2RoY2k6IENtZDogICAgICAgMHgwMDAwMzUzYSB8IE1heCBjdXJyOiAweDAwZmZmZmZmDQo+
IG1tYzI6IHNkaGNpOiBSZXNwWzBdOiAgIDB4MDAwMDEwMDAgfCBSZXNwWzFdOiAgMHgwMDAwMDAw
MA0KPiBtbWMyOiBzZGhjaTogUmVzcFsyXTogICAweDAwMDAwMDAwIHwgUmVzcFszXTogIDB4MDAw
MDAwMDANCj4gbW1jMjogc2RoY2k6IEhvc3QgY3RsMjogMHgwMDAwMDAwMA0KPiBtbWMyOiBzZGhj
aTogQURNQSBFcnI6ICAweDAwMDAwMDA3IHwgQURNQSBQdHI6IDB4OWMwNDIyMDANCj4gbW1jMjog
c2RoY2ktZXNkaGMtaW14OiA9PT09PT09PT0gRVNESEMgSU1YIERFQlVHIFNUQVRVUyBEVU1QDQo+
ID09PT09PT09PQ0KPiBtbWMyOiBzZGhjaS1lc2RoYy1pbXg6IGNtZCBkZWJ1ZyBzdGF0dXM6ICAw
eDIxMDANCj4gbW1jMjogc2RoY2ktZXNkaGMtaW14OiBkYXRhIGRlYnVnIHN0YXR1czogIDB4MjIw
MA0KPiBtbWMyOiBzZGhjaS1lc2RoYy1pbXg6IHRyYW5zIGRlYnVnIHN0YXR1czogIDB4MjMwMA0K
PiBtbWMyOiBzZGhjaS1lc2RoYy1pbXg6IGRtYSBkZWJ1ZyBzdGF0dXM6ICAweDI0MDINCj4gbW1j
Mjogc2RoY2ktZXNkaGMtaW14OiBhZG1hIGRlYnVnIHN0YXR1czogIDB4MjViNA0KPiBtbWMyOiBz
ZGhjaS1lc2RoYy1pbXg6IGZpZm8gZGVidWcgc3RhdHVzOiAgMHgyNjEwDQo+IG1tYzI6IHNkaGNp
LWVzZGhjLWlteDogYXN5bmMgZmlmbyBkZWJ1ZyBzdGF0dXM6ICAweDI3NTENCj4gbW1jMjogc2Ro
Y2k6ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IA0KPiBU
aGUgbW1jMiBpbnRlcmZhY2UgaXMgY29ubmVjdGVkIHRvIGFuIFNESU8gV2lmaSBjaGlwLg0KPiAN
Cj4gVGhpcyBpcnEgdGltZW91dCBvY2N1cnMgdmVyeSByYXJlbHkuDQo+IA0KPiBBbnkgc3VnZ2Vz
dGlvbnMgb24gaG93IHRvIGRlYnVnIHRoaXM/DQoNCkhpIEZhYmlvLA0KDQpBY2NvcmRpbmcgdG8g
dGhlIGxvZywgQURNQSBFcnI6ICAweDAwMDAwMDA3LCBzZWVtcyBtZWV0IEFETUEgbGVuZ3RoIG1p
c3MgbWF0Y2ggaXNzdWUsIHBsZWFzZSBkb3VibGUgY2hlY2sgd2hldGhlciB0aGUgZm9sbG93aW5n
IHBhdGNoIGlzIG9uIHlvdXIgc2lkZToNCmNvbW1pdCBlMzBiZTA2M2Q2ZGJjYzBmMThiMWViMjVm
YTcwOWZkZWY4OTIwMWZiIG1tYzogc2RoY2ktZXNkaGMtaW14OiBjb3JyZWN0IHRoZSBmaXggb2Yg
RVJSMDA0NTM2DQoNCmFsc28gcGxlYXNlIGFkZCB0aGUgZm9sbG93aW5nIHBhdGNoIGZvciBzdXNw
ZW5kL3Jlc3VtZSBjYXNlDQpjb21taXQgYTI2YTRmMWJhY2E1NWEwNWFlY2Q4ZDcxODE4MDI5Nzlh
OTNlM2Q0NiBtbWM6IHNkaGNpLWVzZGhjaS1pbXg6IHJldHVuZSBuZWVkZWQgZm9yIE1lZ2EvTWl4
IGVuYWJsZWQgU29Dcw0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCg0KPiANCj4gVGhhbmtz
LA0KPiANCj4gRmFiaW8gRXN0ZXZhbQ0K
