Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3BC07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 10:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EAF61C92
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 10:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbhGGKTZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:19:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:40734 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhGGKTY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 06:19:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1625653004; x=1657189004;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ufky/3jDzYOwvpOmTeQKOJRMjvMOgGuEdktqXHc5EBk=;
  b=GoFIkNVlAgT012IHCF2j7Sf5H9kEN27no3v59d2tQVuWqrEEtUiAjU+o
   TvYV7ULNkcOwf0ywNOWcW+t67x2xL6XYeVi0dU8O7GpAGfl4NwV6bIY4T
   reeN086On72FGskGnrD1xjynY0USvf1q4VlONSSoNUoCFkIz1ypaD3xCJ
   0i/4SloaqtSnAt8eOwZkFsjs0fQK2blR2xF8Ai/sW5IagyO5EokgX6TxV
   w/Lrmqj6VsMzY0jcGoh3afEGgAfrhsFG0lRO47WczfsiB21iz6SQON8Pz
   6mO0jMASt1IrzDNSNpKf9xgvQHdpWbxUdOglI7mYi+axvgNoW622sc+s5
   A==;
IronPort-SDR: PosUgqgWGT3SjAuQAfsDdO1IJdP0ax2rg/qVdwprA5QNmT+mCqYx/xy+ExOiIfFfRhOkBeJ0eI
 9KKMr6cTHRnrL7/PDDh+5b5jh58PsXe65evvkHJWxygHH3Z0IQmKeun7d56DU1v0w5UJ/uyPw+
 XmxoJSCCi3pnjcYBQbDzCVf0Mf1bKRSJdp7NX8kOC1dd+bbnXZX6z2w1bkSbZen+GzB7x6jQom
 YIwk1PntlMacBZDqEDNTD0klPqo5usJtQsDUO/QH8hVMTBCrR/LX83UBPDGk8veMzfrcv0dZRC
 ZAo=
X-IronPort-AV: E=Sophos;i="5.83,331,1616428800"; 
   d="scan'208";a="173163333"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2021 18:16:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9THgX/+WMHG103+JZbxebvBmzcXj5WVjSyNUpLB86aIbRpOL7DXdlH43wpT8ezKcVoKEsHmsztNr+ApwprpalVcxyWBGsuNymcrnlkOO7XVUpax7Fr78jv+AF1sbafWvegg2ZYK0jaBhugkXX2hl1wAMV93o0W0Rebi5Y4iFf5/mH6o33BsxsFZxSCnB+PlR0wuDBwzA/PBr6Rf8/DZ0fDZ/PHitipr7Mk6VF0nqvoV/W6Ut7rp4gUA1DnbMwT40YGzWXxeWpiv7Ms960pdIjI/w1v5510lArDbObXPlijtTkGRe5bg1CfxpFjhCKURWe7Ac6CBenIhniRNrIK+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufky/3jDzYOwvpOmTeQKOJRMjvMOgGuEdktqXHc5EBk=;
 b=le9TGhr1HC5VBFyEE191Ngb5/XXC7mOxVAo4CPtURSlq6KgSYbFLe4qUMg4q9ZgjD/1aR938gu6CjVxC6RSBfn/vOHrQh1Hb16ZkR1NjdXDVGq50nSeVMKjwvnCtZbTys5sBe4At6H1/PITcIK/iXd28K2eM19IcwBU5s2vjuf0OCRGMj3b1veaKGidcsNsqx+SqgCXvWAPrlGc2FVKG+fndYbCQy7IKdtP9K4RV2/OVxlz49W3a7oveoXt1zbW8wrbB9HzffJE45L0IxPB+2yNPsucfn3EDwnDO6BpwrApC8NMnWXIciY1nS4YJuLjiqUhTaVNAYnUgPsUs/0ObAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ufky/3jDzYOwvpOmTeQKOJRMjvMOgGuEdktqXHc5EBk=;
 b=HeWOnJpYBwzxel8CMbdIpCpObxjLz6vIShAq7EUKiCi5PF34qinPsQoZelW5nFJF8U0ubrK2t+pTcd1kwH4T6uUShgBbf7b/6W13pZD8en+ntfU3dWDkjUD5EtUQDctu12vULsLH8eRA982qj1lE1dPV6CSEh9r76EkxqVxhk48=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB7001.namprd04.prod.outlook.com (2603:10b6:5:24b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.27; Wed, 7 Jul 2021 10:16:41 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ccfd:eb59:ccfe:66e4%5]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 10:16:41 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Topic: [PATCH] mmc: block: Differentiate busy and non-TRAN state
Thread-Index: AQHXbl0Q77+Qfc7HWE6ez2HIF5qrJas1omGlgAAGD4CAAADv5IABbwLggAAg/s6AABt2cA==
Date:   Wed, 7 Jul 2021 10:16:41 +0000
Message-ID: <DM6PR04MB65751AF67891F655ABBAA7C6FC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CWXP265MB268049D9AB181062DA7F6DDBC4009@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26807AC3C130772D789D0AABC41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<CAPDyKFq44ZuXXUDQV34NSW-ixB9GAZfDx+dx-Kb8O7=LQ1TSHQ@mail.gmail.com>
 <CWXP265MB26803EFAC659676EC0914F97C41B9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>,<DM6PR04MB6575B0049B98254E77BA447EFC1A9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <CWXP265MB2680AE8D71546A5656B410DCC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680AE8D71546A5656B410DCC41A9@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hyperstone.com; dkim=none (message not signed)
 header.d=none;hyperstone.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5a1c3f5-2385-487f-02e5-08d941305079
x-ms-traffictypediagnostic: DM6PR04MB7001:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <DM6PR04MB7001BD7E03A1D8BEEDF306E1FC1A9@DM6PR04MB7001.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ga9YH4mbKEDeMI+Qie2WGNgDNNbWdBYVXcMqWHui662MnECBVu0wUzUe0QBJjxZZdFO0+kGzeR69caQXhHD8o0QTy/fQAILax36lUFgvo61LdFqTGbxbEzpOnsVCKxcPbgSsP6tZnUpvYxMe25zqIN5x6N3l+mafATckVjVN9nKulIfLtBDf4Z60AwOPaRQKKbtT0FIqPDKV7I9Y0rctH4YUdPTze7Vm+YReyNCupxqTEpB+1dep9b9+010w1/dnFap9SzvXb27qJWxvD2fnbLWQBPlb0dTO5eHHhI7jb1g/I5dHn5a5r7zoPFxov4cobhy3zdpff6zW+TBtmohI4Xl4AMo+UstGXUhFI7ZsD+j9QRyOXheqF1TWNUk8gMHrhCDT53PgRrBB7pHMdk1GnUquh4IZ25I8rCYvARvyN5gHCq+IS3o0Hw0NJnE05utIhiTzgTeIv0T2v+CfUEvTQ3MANSUj0S0x3jJTOtWPHhF0wBBKzeAknJO1pLRG8bwnQlmVnj+V5tdvl7rzZtEwBm5Oqwd4JPJb/voIfRj5I/XIDYIX67VfpAe/VBWLjhbUmULyHBgoItCBioviWhILY/xfcyVJtS3TkXjq+B4/zDXhawoJ+Sp9P2JVTyHoyk5Xf+3+xDAv7rNb0Fe6hCreeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(26005)(8936002)(64756008)(2906002)(6506007)(86362001)(76116006)(55016002)(38100700002)(66446008)(9686003)(33656002)(71200400001)(122000001)(110136005)(66946007)(478600001)(186003)(7696005)(316002)(5660300002)(4326008)(66556008)(8676002)(54906003)(66476007)(52536014)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFVSUys5WS93NFFEQ3RtS2lHWDVvc1JmMXg0OWpONWg2dnM2ci9qZFlhMmJW?=
 =?utf-8?B?RktmeXdLVHhyUXBodjZZTnNBWmFjUUZNZFdNeFMxVkJXR1ljTWxWZDBqR041?=
 =?utf-8?B?anRLRk9VWUIrN0VQVGE1R0VlclIybXJKdlgzWFlScnlGc2RHbUhLR2doazlN?=
 =?utf-8?B?elFwNHFieFo0MXhLR1BBMUwyRXU3Q01GbkhZYkVHb1U1Q3d0YmVBb09ENzBS?=
 =?utf-8?B?WVVmbTVBZkpLNXFnNDIwdXNUeEVuczdhdWtqNHVPRldBc1RIUDgybGFUaVRY?=
 =?utf-8?B?cUtIMmhzRy80Z2xybmNPbHRPRVdkeGZPQjI2VTdWY3Y0ZXFRcCtXZHdQbVNV?=
 =?utf-8?B?MXZYOXpZSzdjdUJUMzE0YlhDTjVGMUo0bGN3d0VFVTVxdTRzdmtBYnNyU012?=
 =?utf-8?B?OVduRVRqSmtzTlhoWmg1enRUVitWY3NnMTdMVGM2akEzMmhUeWdaSFpOM0gv?=
 =?utf-8?B?Z0RvMjRCTGZQVTQ2K1k5Ui9pWkY5cVEvekdiZWx6eE42K2xsWDNJNXErNlZN?=
 =?utf-8?B?akNoSUJEb1B1MDJIanV1SnFXaTFDMnljVk5zVTBoOC8vbC9BSExXSS82OXpy?=
 =?utf-8?B?K2FXZUNPNWhzQTdxbkJpM2FsdVZkWlFtKyt6NHpDVmxyWWVyeXRMSzIvWEZL?=
 =?utf-8?B?cDdGMSsyUDFsZFYvNExWMDNoWjFJZU5VTExLT01oWkQrSXNYbDlaRThwWUlY?=
 =?utf-8?B?YnQxZlpmeTJyMENna0kvdG9JbStUMEYrekMrdHF2aHp3M3RTNlQ2MkpHa3Vq?=
 =?utf-8?B?ZlJvU1NlazlDOWZ3Qlp5WWlFWlpINGFwMkJwVGx5VlYwTTF3YUVxWkdZc09H?=
 =?utf-8?B?UjNWMkVPRXhZK0RzV2F2bmFnaVpjUElZMG8wN3VwQUJDWEtqb0o0a1VEcnRt?=
 =?utf-8?B?ZFQ5dnYvMWYrMThtd2xpbEcvQjBtSHVmRzk1NWxCcStTTWtlUHJWcDJJVVg5?=
 =?utf-8?B?bjYxYkV0ZXdTb2hsYVpFV3BjT0xLV2lXREhWb1BkM055WFN6dzZiTXVrSWNs?=
 =?utf-8?B?bHpFNU51RThDZ0RnWUtjNUJ0SVBNUjMxMmdXUGE3M1VsRHAvZVRqdWllRExW?=
 =?utf-8?B?cmowckt6ODV0aXFBNHZYYnFOUG15ZGZkcXVJcTg3S2RtZjhXakI2MFJGNm05?=
 =?utf-8?B?UVVmQTRTTnRwSTRwVEt0OHAxSGxVWUR6eXJwYks1K1pTZkhJaDJ2VFVaMWl4?=
 =?utf-8?B?ZkowaEJKSW9vWTN4dng2VHMzZ0VReEg1UzMxdGUzTTZzQ1NVTU1ST2prWUov?=
 =?utf-8?B?NEVaNzdvK0ZzUmZZUnNCdW0xQlE3cE5uay85YVVaMk9iUWI3S21lMFpMeGl1?=
 =?utf-8?B?NmUzQklzV1Q0N0YzbE5uYTNZYTV3VlB6ckdMVVkvQlZISkVBTmZhN2s0V2lI?=
 =?utf-8?B?ZWRmUkNPWTdBKzQ5bG1RQkpqcHR5VFpLYkExd0JnN1MzdnR5YmNOMWNDQmts?=
 =?utf-8?B?SWdlSElSRzVGQWo3NkJFOHRGY0tpOGZ3dnk4dVBheURZbTZBZEJMQ0VyY0o3?=
 =?utf-8?B?Z09qcVNEdFl4a2VJU0FJWHgwR2UxNWFsQzZyeVZiU2hiU0FIOHNDZUcyek85?=
 =?utf-8?B?QUN1VndpUnJ2YTEyS0J3QUhib2x0VGtQOUdsaktXNXlocTJaYStHNjNHaW9Y?=
 =?utf-8?B?TW13cWZlMERuaVNHTWlnNFNxQ21mN1Bob0V1RVBicHdzZ3pYUGpUQm1SQSt2?=
 =?utf-8?B?VVdLVFZZUmJUSXdiMzZzbWlmNDFFMXhCa1VHSk56QVlpMTAxdFYvaGFlR01O?=
 =?utf-8?Q?JEC9zjnpseL6PtCJI/H6tiavsvy9cyjk+nseCrJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a1c3f5-2385-487f-02e5-08d941305079
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 10:16:41.3302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2c/ceWyCRp/qb1+4lpfvcKA5ZAXJ4Z2vbczgWpU5eUc7HyZ4Zg20OqzoTXgPvXLqBiKkGf13/MkXV7sfEwoIKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7001
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiBIZXkgQXZyaSwNCj4gDQo+ID5BcmUgeW91IHVzaW5nIG1tYy11dGlscz8NCj4gTm8sIEltIGFj
Y2Vzc2luZyB0aGUgaW9jdGwgaW50ZXJmYWNlIHdpdGggbXkgb3duIGFwcGxpY2F0aW9uLg0KPiAN
Cj4gPkNhbiB5b3Ugc2hhcmUgZXhhY3RseSB0aGUgc2VxdWVuY2Ugb2YgY29tbWFuZHMgeW91IGFy
ZSBzZW5kaW5nPw0KPiANCj4gVGhlIG9uZSBJIGluaXRpYWxseSBlbmNvdW50ZXJlZCB3YXMsIGFz
IHN0YXRlZCBlYXJsaWVyLCBhIFVubG9jay1Gb3JjZSBFcmFzZQ0KPiBpbnRvIGEgbmV3IExvY2sg
d2l0aCBzZXQgcGFzc3dvcmQuIEJhc2ljYWxseSBhbnkgUjEgKG5vIGIpIGNvbW1hbmQgdGhhdA0K
PiB0cmFuc2l0aW9ucyB0byBQUk9HLCBzbyBiZWhhdmVzIGxpa2UgYSB3cml0ZSBjb21tYW5kLCBj
b3VsZCB0cmlnZ2VyIHRoaXMuDQo+IEJ1dCBvYnZpb3VzbHkgVW5sb2NrIGZvcmNlIGVyYXNlIGlz
IHRoZSBiZXN0IGV4YW1wbGUsIGFzIGEgZnVsbCBlcmFzZSB3aWxsDQo+IHRha2UgcXVpdGUgc29t
ZSB0aW1lIGFuZCBtYW55IChhbGw/KSBjYXJkcyB3aWxsIG5vdCBhY2NlcHQgbmV3IGNvbW1hbmRz
DQo+IChpLmUuIHN0YXkgaW4gUFJPRykgdW50aWwgdGhlIGVyYXNlIGhhcyBhY3R1YWxseSBjb21w
bGV0ZWQuIFRoZSBjdXJyZW50DQo+IGNvZGUgd2lsbCBub3QgY2hlY2sgYW55dGhpbmcgZm9yIENN
RDQyIGFmdGVyIHRoZSByZXNwb25zZS4NCj4gSSBoYXZlIG5vdCBoaXQgdGhlIHJhY2UgY29uZGl0
aW9uIHdpdGggYW55dGhpbmcgYnV0IENNRDQyLg0KPiANCj4gU28gdG8gYmUgdmVyYm9zZToNCj4g
Q01EMTYgLSBDTUQ0MiBTZXQgUFcgLSAoQ01EMTYpKiAtIENNRDQyIFVubG9jayBGb3JjZSBFcmFz
ZSAtIChDTUQ0Mg0KPiBTZXQgUFcpKw0KPiAqIE1heSBiZSBvbWl0dGVkIGlmIHlvdSBjcmFmdCB0
aGUgQ01ENDIgY2FyZWZ1bGx5IChpLmUuIGVxdWFsIGRhdGEgc2l6ZSkNCj4gKyBpcyBwcmV0dHkg
bXVjaCBpcnJlbGV2YW50LCBjYW4gYmUgcmVwbGFjZWQgd2l0aCBhbnl0aGluZyB0aGF0IGlzIGls
bGVnYWwgaW4NCj4gUFJPRy4NCk9oLCBPSy4gIEludGVyZXN0aW5nLg0KVGhpcyBmdW5jdGlvbmFs
aXR5IGlzIG1pc3NpbmcgaW4gbW1jLXV0aWxzLg0KV2hpbGUgYXQgaXQsIEkgZW5jb3VyYWdlIHlv
dSB0byBjb25zaWRlciBhZGRpbmcgaXQuDQoNClRoYW5rcywNCkF2cmkNCg0KDQo+IA0KPiA+QWdh
aW4sIGNhbiB5b3Ugc2hhcmUgdGhlIHNlcXVlbmNlIG9mIHRoZSBjb21tYW5kcyB5b3UgYXJlIHVz
aW5nPw0KPiA+DQo+ID5UaGFua3MsDQo+ID5BdnJpDQo+IEh5cGVyc3RvbmUgR21iSCB8IExpbmUt
RWlkLVN0cmFzc2UgMyB8IDc4NDY3IEtvbnN0YW56DQo+IE1hbmFnaW5nIERpcmVjdG9yczogRHIu
IEphbiBQZXRlciBCZXJucy4NCj4gQ29tbWVyY2lhbCByZWdpc3RlciBvZiBsb2NhbCBjb3VydHM6
IEZyZWlidXJnIEhSQjM4MTc4Mg0KDQo=
