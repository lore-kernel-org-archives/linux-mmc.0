Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20BDC04FDE
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Dec 2022 08:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiLIIno (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Dec 2022 03:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLIInm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Dec 2022 03:43:42 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155984FF83;
        Fri,  9 Dec 2022 00:43:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTDsoKPc8r2lG3lRe4x3umXxuL11w/Gr6/GqZ4OX7FOmd2HQNga3KfdHvkVliWmJxAwONPc1f4Ph/J4VMSWiiV9/WCAwjhBCuR4XyiWvup69ZOlk35xvSnkjG+AHa8MnAiURw74GIarQux+tm//FNK4ehutmNB3Vkze1UxuHzJFNNZpnl9nb7eV2dLgOS0w2NqeSEBWjFvzqjUdPPJrgRQ1x5p34IKv5qmsryBWobc4oyF3u9YjVWisCcPo2/aRN6opPLf/rOY86YKtlCZTY98cejG3iyX4sxcImJttrS4+ZdO65tpnM5Oi9jcfuE8P6b+hLnxWq6h9/iMbBvtv0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A3z5ITjZPrtiHwL10kBRT8l4T3jSOlkhAZufE7+xGw=;
 b=dC6DXrxvgkGZ8hhNTuEQnCR8ndTX3glCduimdyNDeXckW/x5wFZ5I/2H/ev+/J3CD6r/M6Hj/SA4lWWVf7GUuZazzKq0yBCDRu+EXZdTsAZXOSbg+76kv2McWDaetYmPcumZj2lG7ZiOPoxEawWkQEV/Ff16Vg0+iSTDTGaB/oEHDuxE5rfEJ2JExjYk6Wr+k5dTHt0wHYsipz0Sb9dTTVoxEGSISY09rAibABZL07//DBLB73CUvSA2AMJs3ZAfcXRsPgKDJG0v+G4yyJVVrp6Sis5bIdbX1xN83k3AssdkPsJMMsV4kYuKP4Inan/Emv3wrF5fliCKOsp/X+CIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A3z5ITjZPrtiHwL10kBRT8l4T3jSOlkhAZufE7+xGw=;
 b=Wa1GOssA1hBcYxn18+/q7qzpXIaaQEB8bqg+mp4MHG6jQgQu6PhubK8LCCGIuKWl1Sjiys3Hhe/rHlrmrizxUOo6H44tlJpTVsGxWdeQAbXLueQ+3o1dMgo9yXF9+H9N3hxuIle95BYwWhDgAfzsIBPy26+VxORZGMUAqwPGQEU=
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 DU2PR04MB8552.eurprd04.prod.outlook.com (2603:10a6:10:2d7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.10; Fri, 9 Dec 2022 08:43:37 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::7479:76ef:8e5:da0b%7]) with mapi id 15.20.5880.018; Fri, 9 Dec 2022
 08:43:37 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Kevin Groeneveld <kgroeneveld@lenbrook.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/6] mmc: host: sdhci-esdhc-imx.c: disable auto-tuning
 when necessary
Thread-Topic: [PATCH v2 4/6] mmc: host: sdhci-esdhc-imx.c: disable auto-tuning
 when necessary
Thread-Index: AQHXlCWcWiSpADV77Ey4O6C0ROTosK5iTA8AgAXe5JA=
Date:   Fri, 9 Dec 2022 08:43:37 +0000
Message-ID: <DB7PR04MB4010F57E5C0A6DC420FA01C5901C9@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
 <1629285415-7495-4-git-send-email-haibo.chen@nxp.com>
 <a429ea6c-f2d9-ddc8-15b8-23309b3a5051@lenbrook.com>
In-Reply-To: <a429ea6c-f2d9-ddc8-15b8-23309b3a5051@lenbrook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB7PR04MB4010:EE_|DU2PR04MB8552:EE_
x-ms-office365-filtering-correlation-id: 8890c04a-e02b-49ed-45f7-08dad9c17714
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g6XOm+9D18djElOOOL4y8UpcDnBluhKChGN2iYR48G8DGTFTKu3v2Hr9jjmyhBR7ib2+7PsB1X/v7jXyWO+DvP4HLUUVvqTAY74Lg/LdvXcwUzrwNiKLRBE4n8oc83U7C7nzfMrMoSjw4j230YYPTqBq9M6TOELMYp5FA83sd+oR5kdXXX3uki7CRlv5wxOjhs8TIkiz+ftVbAxTghrsrQUtUyoJ5urLzT665tXYJ9Hx2FCAwub1VFAp5KHVmWpwjqgrWVQ4cCFRiagnBTIDFTqlPGr1SXRVJPV+SVu2dcAMYoZWSkcMmj4KfIlE7XDssdmZ6LmC9h0r35SjsxEitNypT4wCABb0eM+mAonGw5r9ffPvxpy31k24yhRDwCDr+sgIOZzlV33AEkG56Pupr8eSQo3G9cdg8SNXFYWkK7o18i1v6g1ua7n26xci8Mqm+QuU8/Zr8c1WoxCb2w0XsKTMaf1UNOl982tnnu+kQEmq3bxmUaH9ErduHDD42jr9wWpDQzK1Sqoden+EGNlMb4TXC6tfjqkgyiHOrJlWBdxvEOnL+vS5CUlNtsFtAuJim6Gx5QDIBVAbfng5UCe3CayhP4rfLlFF25chWwSbcbSdkkub9EVJxnh6c1iJ+nat9ERzJ1I8VhpSlEyD61JhNglowR0NH9lMCM9DI0pVa0j1iLGfrurVdTK2w5dE6gj1FMO+JeXCrQJrJcu+4Ou3P5MEUCTE+oKlAJKhQnohiow=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199015)(33656002)(26005)(186003)(86362001)(71200400001)(55016003)(53546011)(9686003)(6506007)(7696005)(2906002)(41300700001)(122000001)(110136005)(5660300002)(54906003)(52536014)(38100700002)(316002)(7416002)(8936002)(478600001)(45080400002)(76116006)(38070700005)(8676002)(66556008)(83380400001)(66476007)(66446008)(66946007)(966005)(4326008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UW5NWkZncVBiQlhsWWVKK2xlNW1HdmN2bEtCMzQrcFhjUmxIM21OVFFjcStw?=
 =?gb2312?B?SkxaTE5PMW45UFhzcGNETHZMYno3SHFqOWIxSDJFZDg1ZUFJTFZFRmpGZnVp?=
 =?gb2312?B?akZSeWNFejJUMHJuZjB2QVpqZ1FCOE1jVGZ4ZDZoNFJRaHByMzFWYzJ3YkFU?=
 =?gb2312?B?NGgrdFJ1c3dHNWkyUkpreUxnRjlMK2h0d0o2RTIrK2VSM1FUU1krK2lwRDIx?=
 =?gb2312?B?cXpwZE4yU1E5YnRyclZyMlk5VHhWV2NabGUvb3BSckRaNDIrTEl1WHNFQUor?=
 =?gb2312?B?VXZCQ0t5eGJ4MThHMWYzUnB6OGs4SmJSbWRObTR4NXE5M3FMYTFVNC90UEJV?=
 =?gb2312?B?eUVweDZWdUJVcGFhWWtmVmc1RjJmeTJLK2cvME1TWVN4anFMUFgrWjQwaDhI?=
 =?gb2312?B?V0h6eENZUjl1Tk42VkFjMUQ3MmpkRTYrZ3pYVnFGQmVCNUhpUTN3VjM2MjN2?=
 =?gb2312?B?VWZZTTZlZWRvTzJZT2Y2bW5HS0ZVKzlUdzRjTC84Z1FDV1haMS93cmtOdnJn?=
 =?gb2312?B?Skw3SXZhRmhHQU8yNDJNNXNRQzVzaU45RDU2SWlXOWJoZ2ExZWJtK0RMekIx?=
 =?gb2312?B?T21MV3BSN1E0MWR2Y2IzT0RLVTJWbng0NWM1c1hqWnN4RGJYaklHZG42N0dZ?=
 =?gb2312?B?ZHJwbXVNeGxrSFRqODUxT3ZuL056aFF6UHFzM3ozeTVucFpDbGZnZjN4YTdz?=
 =?gb2312?B?b2srMEJ3ZHVhTEoxZ0d0alhqVktVdFY5ekIwa2dsSFlHZHFEOVFVWmlYc1Jl?=
 =?gb2312?B?aGxqUER2c0dSZVVrWUhyRDJqR01PNEJxNWh6NHZLRkFRVnhlYnFyUGt0Z3Ry?=
 =?gb2312?B?ZnpvTGdJQjJjTmtONEZIY1Bad1VhdE5NYlgyYVpJZ0p0YW1XZ0ZwejVuQ0FD?=
 =?gb2312?B?Z3ZITFdsSWtpbTRnSkNaS042dXlRY3FERG9OMWdPT2hEbFhzbjVTUHlTUVN6?=
 =?gb2312?B?QUJmSFptbkpBeW9DbjhrQ2p1ZVhlT1IzVG92WW14SExTL1E2eUdXc3RLMWlY?=
 =?gb2312?B?MHhiaEh1VjFydEdleitEVWllTEY0ZnJHbEwwcEQzcEVXTzBQV2hKVVhWcyt4?=
 =?gb2312?B?OE56Unh5SzVmdEtzSkVDby9NTVJmd0Zrd2RPNUlHaE5jMGJCdXhJbW54RSt2?=
 =?gb2312?B?UVBLdDR6RmdOV0FVZ2ZOYTlVSUlJVzFhU21qZEU4eHNjVW5IVGdtZzdhSkE1?=
 =?gb2312?B?K3crNHlkbHN2Ym9tdGtiQmt1QmtXWC84eXhiY1lUK3ZRKzhzQ01VaGtSS1Vh?=
 =?gb2312?B?b2w3SUZQb0RvMkt1MlZzeFJpRU9DZjhkaThZZHpwVmx2UnJmZ2hHSEZ0dytq?=
 =?gb2312?B?Qm5sMXVYZXpFV3FyZThSallMQUJ0Tkx4UDYvNlhGcHl3bnJ3OWNoa0VqdTFJ?=
 =?gb2312?B?R2w2aTIvSWJkQVNLeWY0RTlzMU5hWGZjeGFWeURqU1JIbytoN2Q1OEgySW1H?=
 =?gb2312?B?ZEtxU2xPQlptQWpPcG4rYzlJSzRidnNLUGp3T3NBY1F4ditFTHJvbmtraDRi?=
 =?gb2312?B?OTN0SXNqQnVCQ2xzTDJ6dXZTejl5SnFOUUlodzRlbTIxWTVtWWRDNVBqdzAr?=
 =?gb2312?B?Y2JKL3p6SlVoRjFwOTQ3WWNYMlJuQzAyNVNhczBHRnBySFpHQkZiTmoyeEor?=
 =?gb2312?B?L3oza1dnVC9YRUFCYVFSWm9EcXNIQm5PcnhIMU1VeTJmV3hWNjBWa2dpNFpC?=
 =?gb2312?B?RlNRdHo3VHRvaElsWTlSdkhsVXN3WVdvSGtzRHI3ZGxXdU92TEdQWnE4VnNU?=
 =?gb2312?B?ZlVtbmlyYnJJb3dGUzZickhyTHBTN3BKR2lkRHR3K0tTaFB1R3ZuQ3ZhU2FW?=
 =?gb2312?B?cTlnbDgvcjdaQmpMNjBaZjFCekluRWlNcG5iRTZYSXNkd1orVDZLdTlkbTZj?=
 =?gb2312?B?V3Z4Z0F5NUxVaVZiR1oyM1VSeWdqNnBPV0tINlR5eDgyUjQxTXFTK2FUZzdh?=
 =?gb2312?B?TkM0d0Y3YUFJc25vZTNSRmg3aEtGRnNkRUtWbFF3ejdQYkdYcmVqU3dOZmdi?=
 =?gb2312?B?R21Id2c3NEJOMm5JWlpBSGJJWmpVck9udE1NZ01FSHFHdDhSaW1RRVl0M0J5?=
 =?gb2312?B?dDVCMlRiSjZpUHdUOFJHTk90MEE3c3pQY3BMVzU3YmF4L0VxSDhvS2JObVJ0?=
 =?gb2312?Q?Dp3sRZeC4Ab372V0dDlThlSVz?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8890c04a-e02b-49ed-45f7-08dad9c17714
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2022 08:43:37.5454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EAa1UJugmLYmAdWapfQjcpP4CxOxSZmN+vx9eJ4VUZgmMB/ImMyWLUqfoNorFZFhoWCZaFlmSRvRsIBkKocLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8552
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLZXZpbiBHcm9lbmV2ZWxkIDxr
Z3JvZW5ldmVsZEBsZW5icm9vay5jb20+DQo+IFNlbnQ6IDIwMjLE6jEy1MI1yNUgMjM6MDANCj4g
VG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT47IGFkcmlhbi5odW50ZXJAaW50ZWwu
Y29tOw0KPiB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyByb2Jo
K2R0QGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGtlcm5lbEBw
ZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBsaW51eC1tbWNAdmdlci5rZXJuZWwu
b3JnOw0KPiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDQvNl0gbW1jOiBob3N0OiBzZGhjaS1lc2RoYy1pbXguYzog
ZGlzYWJsZSBhdXRvLXR1bmluZw0KPiB3aGVuIG5lY2Vzc2FyeQ0KPiANCj4gVGhhbmsgeW91IEhh
aWJvIGZvciBwb2ludGluZyBtZSBoZXJlIGZyb20NCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3Mu
cHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3d3LnNwaQ0KPiBuaWNz
Lm5ldCUyRmxpc3RzJTJGbGludXgtbW1jJTJGbXNnNzMyNzAuaHRtbCZhbXA7ZGF0YT0wNSU3QzAx
JTdDaGFpDQo+IGJvLmNoZW4lNDBueHAuY29tJTdDMmM1YjVmNGQ1M2QwNDA1MTQ3NTMwOGRhZDZk
MTY2NzMlN0M2ODZlYTFkM2INCj4gYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYz
ODA1ODQ5MjExNDgwMzkyMiU3Q1Vua25vd24NCj4gJTdDVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3
TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aQ0KPiBMQ0pYVkNJNk1uMCUz
RCU3QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXNDVjh1Nkd2N3glMkJxaTZrWVN2Wg0KPiB1WlVa
ZVFRMVRhS1B3aEtwaXp0NDlxcHMlM0QmYW1wO3Jlc2VydmVkPTAuDQo+IA0KPiBPbiAyMDIxLTA4
LTE4IDA3OjE2LCBoYWliby5jaGVuQG54cC5jb20gd3JvdGU6DQo+ID4gQWRkIGEgbWV0aG9kIHRv
IGVuYWJsZS9kaXNhYmxlIGF1dG8tdHVuaW5nIGZ1bmN0aW9uLiBhdXRvLXR1bmluZw0KPiA+IGZ1
bmN0aW9uIGlzIGNvbmZsaWN0IHdpdGggc2RpbyBpbnRlcnJ1cHQuIEZvciBzZGlvIGRldmljZSB3
aXRoIHNkaW8NCj4gPiBpbnRlcnJ1cHQsIG5lZWQgdG8gZGlzYWJsZSBhdXRvLXR1bmluZyBmdW5j
dGlvbi4NCj4gDQo+IEkgdGVzdGVkIHRoaXMgcGF0Y2ggb24gYW4gaW14OG1tIHN5c3RlbSBhbmQg
aXQgbWFkZSB0aGluZ3MgY29tcGxldGVseQ0KPiB1bnN0YWJsZS4gSSB3YXMgbmV2ZXIgcmVhbGx5
IGFibGUgdG8gbG9nIGludG8gdGhlIHN5c3RlbSBwcm9wZXJseSBhbmQganVzdCBnb3QgbG90cw0K
PiBvZiBtZXNzYWdlcyBzaW1pbGFyIHRvIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBbICAgMzEuOTQ2
NjQwXSByY3U6IElORk86IHJjdV9wcmVlbXB0IHNlbGYtZGV0ZWN0ZWQgc3RhbGwgb24gQ1BVDQo+
IFsgICAzMS45NTI0MjJdIHJjdTogICAgIDAtLi4uLjogKDIxMDYgdGlja3MgdGhpcyBHUCkNCj4g
aWRsZT04NDkvMS8weDQwMDAwMDAwMDAwMDAwMDAgc29mdGlycT05MDIvOTA0IGZxcz03NDMNCj4g
WyAgIDMxLjk2MTY2M10gICh0PTIxMDAgamlmZmllcyBnPTMzIHE9MTE1OCkNCj4gWyAgIDMxLjk2
NTY4Ml0gVGFzayBkdW1wIGZvciBDUFUgMDoNCj4gWyAgIDMxLjk2ODkxNV0gdGFzazprd29ya2Vy
LzA6MSAgICAgc3RhdGU6UiAgcnVubmluZyB0YXNrICAgICBzdGFjazoNCj4gMCBwaWQ6ICAgMzMg
cHBpZDogICAgIDIgZmxhZ3M6MHgwMDAwMDAwYQ0KPiBbICAgMzEuOTc4ODU5XSBXb3JrcXVldWU6
ICAweDAgKHBtKQ0KDQpUaGVzZSBwYXRjaCBhbHNvIGV4aXN0IG9uIG91ciBsb2NhbCB0cmVlLCBh
bmQgd2UgZG8gbm90IG1lZXQgdGhpcyBpc3N1ZS4gQ2FuIHlvdSBzaG93IG1lDQpUaGUgZGV0YWls
IGNoYW5nZSB5b3UgYWRkZWQ/DQoNCj4gDQo+IFdoaWxlIHdvcmtpbmcgb24gdGhpcyBJIGFsc28g
Y2FtZSBhY3Jvc3MNCj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGY29tbXVuaQ0KPiB0eS5ueHAuY29tJTJGdDUlMkZpLU1Y
LVByb2Nlc3NvcnMtS25vd2xlZGdlLUJhc2UlMkZ1U0RIQy1hdXRvLXR1bmluZy1hDQo+IG5kLXBv
c3NpYmxlLVNESU8tZmFpbHVyZXMlMkZ0YS1wJTJGMTM1Mjg1NSZhbXA7ZGF0YT0wNSU3QzAxJTdD
aGFpYm8uYw0KPiBoZW4lNDBueHAuY29tJTdDMmM1YjVmNGQ1M2QwNDA1MTQ3NTMwOGRhZDZkMTY2
NzMlN0M2ODZlYTFkM2JjMmINCj4gNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODA1
ODQ5MjExNDk2MDE1MyU3Q1Vua25vd24lN0MNCj4gVFdGcGJHWnNiM2Q4ZXlKV0lqb2lNQzR3TGpB
d01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazFoYVd3aUxDSlgNCj4gVkNJNk1uMCUzRCU3
QzMwMDAlN0MlN0MlN0MmYW1wO3NkYXRhPXczVkVqWGZRS1RJWHZJSWVmMUlOeVNuUUZVDQo+IHhX
MDl1YWZOUmRra3Y4ZTdNJTNEJmFtcDtyZXNlcnZlZD0wDQo+IHdoaWNoIHNlZW1zIHRvIGFkZHJl
c3MgdGhlIHNhbWUgaXNzdWUgYXMgeW91ciBwcm9wb3NlZCBwYXRjaC4NCj4gDQo+IFRoYXQgYXJ0
aWNsZSBzdWdnZXN0cyBvbmx5IGVuYWJsaW5nIGF1dG8gdHVuaW5nIGZvciBvbmUgZGF0YSBsaW5l
IGFzIGENCj4gd29ya2Fyb3VuZC4gSSB0cmllZCB0aGlzIG1ldGhvZCBhbmQgc28gZmFyIGl0IHNl
ZW1zIHRvIGhhdmUgYWRkcmVzc2VkIHRoZSAtODQNCj4gZXJyb3JzIEkgd2FzIHNlZWluZyB3aXRo
IFNESU8gY29tbXVuaWNhdGlvbiB0byBhIFdpRmkgbW9kdWxlLg0KPiANCj4gU29tZSB0aG91Z2h0
cyAvIHF1ZXN0aW9uczoNCj4gDQo+IFdoeSBkb2VzIHRoaXMgcHJvcG9zZWQgcGF0Y2ggbWFrZSBt
eSBzeXN0ZW0gdW5zdGFibGU/IChJIHdhcyB0ZXN0aW5nIHdpdGggYQ0KPiB2NS4xNiBtYWlubGlu
ZSBiYXNlZCBrZXJuZWwsIGJ1dCBJIGRpZCBub3Qgc2VlIGFueXRoaW5nIGluIGxhdGVyIHZlcnNp
b25zIG9mDQo+IHNkaGNpLWVzZGhjLWlteCB0aGF0IHNlZW1lZCBsaWtlIHRoaXMgc2hvdWxkIGJl
IGEgcHJvYmxlbS4pDQo+IA0KPiBXaHkgZG9lcyB0aGlzIHBhdGNoIHRyeSB0byBkaXNhYmxlIGF1
dG8gdHVuZSBlbnRpcmVseSB2cyBqdXN0IHNldHRpbmcgaXQgdXAgZm9yIG9uZQ0KPiBkYXRhIGJp
dCBhcyBzdWdnZXN0ZWQgaW4gdGhlIE5YUCBrbm93bGVkZ2UgYmFzZSBhcnRpY2xlPw0KPiANCj4g
QXMgc29tZSBvdGhlciBoYXZlIHN1Z2dlc3RlZCBpdCBzZWVtcyBsaWtlIGl0IHdvdWxkIGJlIG5p
Y2VyIGlmIHRoZSB3b3JrYXJvdW5kDQo+IGNvdWxkIGJlIGFwcGxpZWQgYXV0b21hdGljYWxseSBp
ZiB0aGUgZGV2aWNlIHVzaW5nIHRoZSBTRElPIGludGVyZmFjZSBlbmFibGVkDQo+IElSUXMuIEhh
dmluZyB0byBpbmNsdWRlIGEgbm9uIHN0YW5kYXJkIGVudHJ5IGluIHRoZSBEVCBmb3IgYSBoYXJk
d2FyZSBidWcgeW91DQo+IG1heSBub3Qga25vdyBhYm91dCBvciB1bmRlcnN0YW5kIHNlZW1zIGVy
cm9yIHByb25lLiBJIGd1ZXNzIG1heWJlIHNvbWUNCj4gZGV2aWNlIGNvdWxkIGdlbmVyYXRlIGFu
IElSUSBiZWZvcmUgdGhleSBhY3R1YWxseSBlbmFibGUgSVJRcz8gSW4gdGhhdCBjYXNlDQo+IG1h
eWJlIGEgRFQgZW50cnkgaXMgcmVxdWlyZWQsIGJ1dCBtYXliZSB0aGUgZHJpdmVyIGNvdWxkIGdl
bmVyYXRlIGEgd2FybmluZyBpZg0KPiBJUlFzIGFyZSBlbmFibGVkIHdpdGhvdXQgdGhlIERUIGVu
dHJ5Pw0KDQpZZXMsIHlvdXIgbWV0aG9kIHNlZW1zIGJldHRlciwgSSB3aWxsIHRyeSB0byBkbyBs
aWtlIHRoYXQuIFRoYW5rcw0KDQpCZXN0IFJlZ2FyZHMNCkhhaWJvIENoZW4NCj4gDQo+IA0KPiBU
aGFua3MsDQo+IEtldmluDQo=
