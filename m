Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F17C4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiLBDiq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiLBDi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:38:26 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BACD9B23
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:36:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtEBmqXud/G0Fuobm8FF8utRn2UUOVKLYd1Gxd974Sp+ZBQ7IfvLm5wpuu3oX60UVLIZfVGo089VPSrsN2nXBC1kw+aPAK9BhGULD00k+GlJPf3LjaEWPbcQpPKXa1uDvDJ/0ViW2hEx49x3rYDFqkhCXp04lcybuhCpoNZr2MwOygz6qJ3v19ZI4lsCoEpgBqV3MK0eRSZM6H16cpqJZvyySPaTnkEgz2vbTIncNWxA/BnC9mbqJzJWDVcCJLZvnB3XYiyeHkRl1vxpnYhATdnTvY3vhOPQ1Oc6dyDwdf06KVQ23VdObS31c9MNAl4XjGlMFpj10HDiTwKHxAXakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=laT9TwyUHB8jpy4KjRpXafr2vmq74MGLaR5Y3E5QWhI=;
 b=MeCSfHEmQWzwKjjT4hJ2lqFtjy8KCFfcc05FVV2cN8flKIYxlqnGcF4ZcUOoLO4O7ieucA+XOxwAn5og/kPUu9cdj0tj5AvE4fT8p4+89dfkRwArAXBK+v5YP826rzpNXipXxv5iKJ5loywJqy+l8seCtL9U1yLNR8Vmxhfpn4/al1WVGNEexXrLacuKwkEfYM3szYtOZ9KZ+DDLzO8gZt1bslOV1bMl1xNijmmNZUGDxnZC/gCEd5uIOexAgaQvGWa2OCn6dhrpIOS9eh8jMHuQ42IGjUk8dGDWdMIy2OvM/yPdY6OTM/4m+gfQm5SeQLDrGKkJyusUlAIwYGbYoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=laT9TwyUHB8jpy4KjRpXafr2vmq74MGLaR5Y3E5QWhI=;
 b=Tge51ozlJnQ1e7Bds5UVzjEHD6QTxqK4if/S8RfD0g1wQuXIqh0/QJrrA+KLJ8txlGkFYHDD/dYXy1ppajrcJnzoR3Wjz8QykavSlXDEz8VYq58hz1qVbLZ34SDAVpf5QEuxlqfWIK9oktu9oxQdZRo5RNe775bqab/6GxaxjD0=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 03:35:21 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::3cee:dfa4:ad62:235a%7]) with mapi id 15.20.5857.025; Fri, 2 Dec 2022
 03:35:21 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix the mask for tuning start
 point
Thread-Topic: [PATCH 1/2] mmc: sdhci-esdhc-imx: fix the mask for tuning start
 point
Thread-Index: AQHWM0jxD/LOP4ZZ4kad7KYFFwLbU65e77uAgACmHOA=
Date:   Fri, 2 Dec 2022 03:35:21 +0000
Message-ID: <DB7PR04MB4010BBDABCFBDB5487292B9D90179@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <1590488522-9292-1-git-send-email-haibo.chen@nxp.com>
 <4425d932-186c-1d14-e728-0c45d1bd8081@lenbrook.com>
In-Reply-To: <4425d932-186c-1d14-e728-0c45d1bd8081@lenbrook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|PAXPR04MB8781:EE_
x-ms-office365-filtering-correlation-id: d1feed0d-08c4-4e5b-23ca-08dad4163d68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0U1Odgthw5cVSalhpxENzjJXf7/afo0kLE/5FHazLKVH5eB7345HnRSrax0rdUJerMVoPq90fL+qqD0cCXk64rNmjdUa2vMu1E8X9iwakOTmWywNMCeMyfo+SowPBI/jRAKIDExQmJUR25eByg5ovU3mtqtQkHG35quDM4HtrGI1sxqs2uPZHv8cldj2Fztd22Y36Bq3yk6ljcVSxiFtRWxLMg6UMRT7zVdnz5Jb9M1Qpne7RKgZttrRddlY0taJ+eO6Xr78/9BIjPWlpqqTsM3ct3cn14TTbG3nMDLGieEyV4AVzxwNiFauK3djNhvF0UhxxCmTVEFJUGH/HOhwiouxGAzUk68wMJdP5yWTdRoIveIbVqWa7+5xOiOXHEVthEsja2qwxmsHmIc4ltqBWjrczL1wUr2hb63fHIW04676zSZ/9T+emXkrnvu4fwcXUsR0qkLOo0YZ/5n8GLquCZojXgnqoleuhU7MG+pyAWZ/5COURohZE46coMJvnwUD5AtqBLtYsckScfFMRqLUAezb/G9kVsJSbvyyDZ0Eo7d4riy4hQXvewECtmhKIcgMRhgCzw+g8/fR7bSQW0S3QrotCJ4jfCeKT1nWknp7GMfEb3ijaheEuQRB2wL4pcwjAX3tmCP1AURIU5wkA5fYonPHXdmVl8pMuZgB9eHkK8c7EHMt9tOhVwQtE9S0aTVqWStLVjBthl85QUtk2L+a7hssFI0fpn1zxPHJQQgjYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(53546011)(7696005)(6506007)(966005)(26005)(186003)(316002)(9686003)(478600001)(110136005)(54906003)(64756008)(66446008)(76116006)(4326008)(8676002)(71200400001)(66476007)(66556008)(66946007)(41300700001)(8936002)(52536014)(5660300002)(83380400001)(2906002)(55016003)(86362001)(122000001)(33656002)(38100700002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eStQK3FqZTZwQkYzWklQQVpibmNDTnQ1SkhiZzJleGN3VVVGWllIWGZBN0Vo?=
 =?utf-8?B?VDlGL3lHSEg4dEx3L0FEZzY0Z1VVRmJnUzNxRXNBam9pYXU4WXZmOVhRbDh1?=
 =?utf-8?B?ZWc1QlI3SXpTS0d2ZUNXN2w4VnozSng3Zi9zUzB3SkJCeVExamxsSG5JaU1G?=
 =?utf-8?B?QXFYUkFEZGlMQ0ZucWdmZ2dFWFRQenJPM1p3c25CcFRKak02K0pOY2NnKytw?=
 =?utf-8?B?Z2xBQ1RvRlNhVEVMK1ZCbEdBc1V4RU9NRDNWNmxFczVkR0dLT21hQVVSMnZa?=
 =?utf-8?B?SWp1SDlnSlBFV0Y3eEFzaWppTHRFVGtUcCtLWHdlUEFYb29tUVFnMDRjOE9S?=
 =?utf-8?B?WmxMNWpSekN0eGx0VWdTbjRYNjZmNFVkVm5EeEhGTGR1anloQWt1WUl1ZW9k?=
 =?utf-8?B?dHBuNGtKendoSTQxZ0U3b0gyT21GbG1JZExaSCs5MXk5ZTJvanV3TDNldnBX?=
 =?utf-8?B?MWlOYnc2K3R5YmF2amR6OFJPVGVqWjVHeWNxQkhHdDVEQ1lNelRRWUhlSHp3?=
 =?utf-8?B?alU5UnpiaHFiUnZDVHhSNUZDcTFxSUF6VDZvc1hMMWN3QWRSUVB3YWJGd3hy?=
 =?utf-8?B?MmF5S0dkdExLZURSUnVuM25NTzFyUGZ6dHJsSFVvMVVUdmVUR28rSnJ0MU94?=
 =?utf-8?B?cURWcW05TkxlL3VtWi9IbTA1a2VGS0wzS0czNWFMVGRVZFkvTllBY1ZnT2pG?=
 =?utf-8?B?RTEycE9Sd3Jxa2JUMmRKcWJxVkZYcmU4QUNjQzlPMnk3dFFNWUgwQXhLK2lG?=
 =?utf-8?B?SU1oVGdTbk5pT2p5L0ZCckZaS1ZsYkppU2hjVDRRVzBHZlU0d3h4ci81YUM4?=
 =?utf-8?B?K3VQbG8xWjBTUEJrOVIrbU1YbUVNTHoyWGJYelFlcTN4L0xxMDBqaUZiNFpD?=
 =?utf-8?B?U2hpRVBWbXc4V3BURWdsQUR4NlJMaElxMVhob2pLT0JKREgwcFV2KzhrUDZS?=
 =?utf-8?B?VUpvWUV2Nmx5YWF2cytYc0kvUkpYelB3a3JyZWNrd2wzZjc3TWkvWDZENUNU?=
 =?utf-8?B?L0lpSVhkc2dlcVI0UExpcDBiQkxCdFVxcDB3NFhoUG9qdjJJbjdvY0c1Q3R5?=
 =?utf-8?B?OGpJYkNmbDdTZGZKQlhrMDgvMCtSMVN5YmxDdU5kY0lPeFpvVzFnb0RTMngr?=
 =?utf-8?B?RUY1dzZhZy9jc0JlNXNocUhJY08rTE1mb1pEK0NZOGlLK2RQKzJrLytRSXRC?=
 =?utf-8?B?amhSaUE2SFNLcnhDdndpQkliQ3kvYjIyOVVYeSt0ZFBkRWFmUG90V2gwUzdJ?=
 =?utf-8?B?cXN3aCtSc2Yxb0tjVnRkL09WSkJMWGtvTW4rN2hBTzRSRkVlZHBsSDR0eDVn?=
 =?utf-8?B?c0RIWXZUQW01Qk9nWDQwalF4eFBjV0x6S29aak9GbVRJNENGUktQY2JjTmxp?=
 =?utf-8?B?aG0xMFRHMTAyNHVsSms5YWEyR2VLQXdjWkpzeUlxVTF6dVRnOEVWUmxZUWJq?=
 =?utf-8?B?YUttcUZtUGZON3hsNVVVcElBVWt1TloybFllMUFINFpaQnhFR3ByR2hoT3ZU?=
 =?utf-8?B?b1BrdElqWll0WUtsd2RvbG5TUVVOdnBuL2FzRDFrY3h6eURsa0duaU4rNzJv?=
 =?utf-8?B?cTBBV0p0TnYyY2xBZzFhQlZFVlkvL0NrMkIrWlVCTXhsbDlRZ1pqUklRZVFa?=
 =?utf-8?B?K3ZxYVdUVjNNVytrcGIya0VBa2E1Ty9VTXd2US9KblgwekdUOG5aSExrVE91?=
 =?utf-8?B?NXh3UFlpdXBXaDNvbm5lcDNZMnNTMEU3eVNYM3hLNis4c1hYajBJeElKS2s1?=
 =?utf-8?B?ZlpyZ25qcU1mckFCekJlbHZMd3pLTGFsVmxkWDU0bXRlR1UzSnBPdXVjQnlG?=
 =?utf-8?B?NWdwTHlURUcyMVUyRmJTeHpERVhNZ1Jsbmpka3RwdlpFUnYydGR2ZFRrNTRx?=
 =?utf-8?B?Si8zZUsxUVpINGFrOEhxM09Za29Vc2ZwanAzU1pHQi95ano2YVV0N0MycGlx?=
 =?utf-8?B?KzBSTEZXZ3RlS2tCQkhlV21SSlBZVUlrNUUzZ092RXFqUHUvRXdubnJSZkp6?=
 =?utf-8?B?OTBjMzRJeVZlYzVYUUJHQm0vSmo0UE5kSHl3KzFHTXZ3dTFCQVhqc1N2WFpm?=
 =?utf-8?B?YjNQSzFtZzlhMW84RWpIdmMveTBSTlMrcGU3MSttOEIxQUliNGF4VlJPeHJX?=
 =?utf-8?Q?JBmTy0pgNfzhu7BeyEtc6pQJF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1feed0d-08c4-4e5b-23ca-08dad4163d68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2022 03:35:21.0325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AoYUYPAdDmVZlCPVKMgHlKj5G8pJK8hIKExv4acFc+JDssB/OOwbxb6xh3xWOPjeQMN48FV+MsLBgZWP6yqjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8781
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZXZpbiBHcm9lbmV2ZWxkIDxr
Z3JvZW5ldmVsZEBsZW5icm9vay5jb20+DQo+IFNlbnQ6IDIwMjLlubQxMuaciDLml6UgMTozNA0K
PiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPjsgYWRyaWFuLmh1bnRlckBpbnRl
bC5jb207DQo+IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+OyBzaGF3bmd1b0BrZXJu
ZWwub3JnOw0KPiBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7
IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4gQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNv
bT47IFkuQi4gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEv
Ml0gbW1jOiBzZGhjaS1lc2RoYy1pbXg6IGZpeCB0aGUgbWFzayBmb3IgdHVuaW5nIHN0YXJ0DQo+
IHBvaW50DQo+IA0KPiBPbiAyMDIwLTA1LTI2IDA2OjIyLCBoYWliby5jaGVuQG54cC5jb20gd3Jv
dGU6DQo+ID4gQWNjb3JkaW5nIHRoZSBSTSwgdGhlIGJpdFs2fjBdIG9mIHJlZ2lzdGVyIEVTREhD
X1RVTklOR19DVFJMIGlzDQo+ID4gVFVOSU5HX1NUQVJUX1RBUCwgYml0WzddIG9mIHRoaXMgcmVn
aXN0ZXIgaXMgdG8gZGlzYWJsZSB0aGUgY29tbWFuZA0KPiA+IENSQyBjaGVjayBmb3Igc3RhbmRh
cmQgdHVuaW5nLiBTbyBmaXggaXQgaGVyZS4NCj4gDQo+IFdoaWNoIFJNPyBJIGp1c3QgY2hlY2tl
ZCBpbXg2c2wsIGlteDdzIGFuZCBpbXg4bW0gcmVmZXJlbmNlIG1hbnVhbHMgYW5kDQo+IHRoZXkg
YWxsIHNob3cgYml0cyA3fjAgaXMgZm9yIFRVTklOR19TVEFSVF9UQVAuDQoNClBsZWFzZSByZWZl
ciB0byB0aGUgbGF0ZXN0IGlteDkzIFJNLCBJIGp1c3QgY29uZmlybSB0aGF0IHRoaXMgUk0gYWxy
ZWFkeSBjb3JyZWN0IHRoaXMgaW5mby4NCg0KPiANCj4gSSBoYXZlIGJlZW4gZXhwZXJpZW5jaW5n
IHNvbWUgaW5mcmVxdWVudCBoYXJkIHRvIHJlcHJvZHVjZSBjb21tdW5pY2F0aW9uDQo+IGVycm9y
cyB3aXRoIGFuIFNESU8gV2lGaSBtb2R1bGUgb24gaW14OG1tIGFuZCB3b25kZXJlZCBpZiB0aGlz
IGNvdWxkIGJlDQo+IHJlbGF0ZWQuDQoNClRoaXMgc2hvdWxkIHJlbGF0ZWQgdG8gdGhlIGF1dG8g
dHVuaW5nIGJpdCBzZXR0aW5nLCB1c2RoYyBoYXMgYW4gSUMgYnVnIG9mIHRoZSBhdXRvIHR1bmlu
ZyBtZXRob2QgZm9yIFNESU8gZGV2aWNlIHdoaWNoIGhhcyBhIGludGVycnVwdCBpbnB1dC4NClBs
ZWFzZSByZWZlciB0byBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
bW1jL3BhdGNoLzE2MjkyODU0MTUtNzQ5NS00LWdpdC1zZW5kLWVtYWlsLWhhaWJvLmNoZW5Abnhw
LmNvbS8NCkkgd2lsbCBjb250aW51ZSB0byB1cHN0cmVhbSB0aGlzIHRoZXNlIHdlZWtzLg0KDQpC
ZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IEZvciBleGFtcGxlOg0KPiBhdGgxMGtfc2Rp
byBtbWMyOjAwMDE6MTogZmFpbGVkIHRvIHdyaXRlIHRvIGFkZHJlc3MgMHgxMjllYzogLTg0DQo+
IA0KPiANCj4gS2V2aW4NCg0K
