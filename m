Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B556C432BE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 06:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5C60FDA
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Aug 2021 06:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhHQG6d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Aug 2021 02:58:33 -0400
Received: from mail-am6eur05on2043.outbound.protection.outlook.com ([40.107.22.43]:63904
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230094AbhHQG6c (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Aug 2021 02:58:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idjcsungUPh8baqK/0qD2DrNG0DxHoIpzG1Z0FgYngWfqmxQ045GNoDJvSLVsIwE03qQNNiItJeFt7FMN+PLJ5INxYF6auFLlPmmj6Zs9leFzvbsmVqH8wqmXQcC4hcnxDUcEF92eH6hBsHjZT8y8BwYm9UpPV68MmkcJ5dXTKBvliiC4Q2eMCnqWXYfW+WZ7jddhviYSY2SXnbhhBbuxGmuDjxEThWMMVs5latdqOE5ytPaNGTP3FZxn+nJBi1wMp2uoUOEnXKvX3OGjvQth/7awvhb/kgsUVui3YdCi4Zf7+R2/nWdsZ8AvbrXtpwDISL59HDZffxCq6FiIyesvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP/YoOHHlDn3wz3I2v1GqCQHcb9l43+OW9Kd6pc6v2s=;
 b=kpteriTBYiiEA4qg8n2m7Cngl/LKKrYCHZOH2boxx37UEnJWecjHqZdKOORx2ENWARpp4ae99B+tFOrtVD6zLVRRQsG5e0O+5t6fmd/lIdI1sR1lgkDPMyinZymNwLZ3qs//NNhrIS9pHGe/hLgZNr39DUDNIXoyLNk8UWZAgX3vK6Cb04WlpDU++uuNlbjxQET1IesTx7hDPg586jrURdfY5Mc0Bvg0Oz7AgHUXbOrJp90s5Lj1znf/pcykFTxgRmScrKgtd1gUTXzU9pOxyPmzxce4roaJgAeA/RJTxiu3U5GQ/YIIn9SEpNrFGo38pvzlNYM3HagW94/mUgP2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP/YoOHHlDn3wz3I2v1GqCQHcb9l43+OW9Kd6pc6v2s=;
 b=VT3lLishacqp6RQ4dHQk9ho/f9PzM1XYuEPn7UE/wpfdhbT1HghoD3wLR7Q0thSzd7iOE0RVsz8+lG4sz9AOwaG1+U1cwS7FOMH20MmGDoPc1/GbMKhOhEbPBMAxDqIZMMTH3IAY098pBRG8t0gWdixQ89j+4cRM5b5R3DIWbHQ=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VI1PR0402MB3838.eurprd04.prod.outlook.com (2603:10a6:803:20::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.20; Tue, 17 Aug
 2021 06:57:57 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::c59c:3e45:7b94:e5b7%7]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 06:57:57 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the auto-tuning
 setting for sdio device
Thread-Topic: [PATCH 4/6] mmc: host: sdhci-esdhc-imx.c: correct the
 auto-tuning setting for sdio device
Thread-Index: AQHXkp6uvB2rKL05R0+WHD27Jc/Wc6t2JtyAgAEZ60A=
Date:   Tue, 17 Aug 2021 06:57:56 +0000
Message-ID: <VI1PR04MB52948F36F428AA3476A1F9D590FE9@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com>
 <1629117508-4886-4-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFpqTdKxFytQWo+TLJf+D=JYJo6B2aZDqOQc4+9_mbH40Q@mail.gmail.com>
In-Reply-To: <CAPDyKFpqTdKxFytQWo+TLJf+D=JYJo6B2aZDqOQc4+9_mbH40Q@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5c76d12-3354-4f82-d749-08d9614c5801
x-ms-traffictypediagnostic: VI1PR0402MB3838:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB383812270A723FF0BBD6549690FE9@VI1PR0402MB3838.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zaTYxK4K8aqiuJKlZSjlQueWE0CQVK5fubCVjPFLboHHLql4cKf3VvTvqBNexmJ35kNx9lqgTuaMurunDiRFDbB0qkvfJNuiIKw4MtXxHOWQrXbCG3Y/Qx1Aqg9jE1tHK4p1W+FeOX+9X7UVOsxBJ20NbzBocr206uKF1JOoP29ZuM7CRFiU8nxRP08uOGE3MD7gcjj6P2LECq+pafb8TPAnjFlA8iHXseR70Gy/JDPxocCTtZQ3LzY2Y0FfGLtKGHWmi5sTjrR4AuyHBB5b8kgUkDn0XT/XWdOH+gh3B8PB7U5ce94WWLg0t5YhuoxDP0cQUjvSpU51Kk9wsEB/TLRAFmj8oay4qX/vWrhmjbZ/n2R+jVfwO12GsP6nDbou4x/SAOvD4oFrg4xCfimrInmyDtkQd8EGIIHd1QAfvRJOaaE9PZy+/pXzltYjHfz8DmqbHsAR0m4XSYgykyIgAkO1gkDoBlY9+fxbqbkTFdi+M4KuNASFK06Y3WlfcnaP2cIu4VqpRM0kQqiVuvhGjqzIw9NEUSO0xlX81DqqRX4C4Gqn4hTLZbhtRWaR+jMPMv9+wIu262qodGa3nQp5VnvpwFlodH+/00dPsUIzP0iHmDHnOY9R0R+POch5TGfTYNw5fWTOelHCk51CYCCURTgg/iTMWlD9Px32bJHHkkEi6wg7f+3srxH55j0rEbcVdSus2IaTfFhIkk60d/W/rg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(136003)(346002)(39850400004)(6506007)(66946007)(52536014)(8676002)(86362001)(316002)(7696005)(5660300002)(83380400001)(66446008)(66476007)(64756008)(9686003)(55016002)(4326008)(53546011)(76116006)(38070700005)(66556008)(7416002)(38100700002)(8936002)(122000001)(26005)(186003)(478600001)(2906002)(6916009)(71200400001)(33656002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVVVTzBXR3VpR3pTa2lYdUpwYThuLzY0Nlh4RGZoLyswRklUc3lkanhwTXhP?=
 =?utf-8?B?cm94RVpFSFI2MkxZZVd1L255SEZVbnFGSkhiQ3ZGSFFLUHdid3JEWVdtbGxh?=
 =?utf-8?B?eEJLWnBMdWUrZ2t3Nko3VXVpdDhXblN6cm9oWmZFamZpV1ZVVUIzQStNK25Y?=
 =?utf-8?B?eFFic1FLNllDbHZwdHhkaHdkcWpzYWIwVm1yWFFUZW5Nb3EzQjF1VlVES3Fm?=
 =?utf-8?B?eXkxZ0pJQmRTRmN2RWFGS1BNVXhReDhCWGd1YTMzazVZZjlLZzd4Ukhvakxr?=
 =?utf-8?B?c3c1d2gyU1lVV3FYZnoyazFjQXpoTmZZT2Vqc1B5cjNFOU12NEt0NHBlcDZQ?=
 =?utf-8?B?ZnlsZ0k3RzhJdmpXZ0gwYzNPYlZ4d2IzWjFNN3ZrWXpobHBTQ2ZLZzFiM3J0?=
 =?utf-8?B?VXVXVnZsT2JkYUM3em1RWTRMMld2OHkvNkEydzQ4SmZtVytOQm1Tc2NaOXFM?=
 =?utf-8?B?MTZkS1lONm9wVjByNFRpZzJ2WEpKMUEzQ3pLZGprcnpHMDRpUlVHb3lENFRr?=
 =?utf-8?B?WndEZzZ0NlhMMHNwTlZaU0RHMEZZWmpnc2hrYXAzUFdadktpWllmUGY2bWVU?=
 =?utf-8?B?N1RaWkZteU1pZlhjcUM5WSt6b3NMSHVkTS9kN0hiVWg0bStyU09ma2k4WFVC?=
 =?utf-8?B?UnhkSm5YTmVMR3VIQkp6dUk1Ym9BczdPRlpLV1RiSytSd1pZblVCRlZxMWJI?=
 =?utf-8?B?U0wzK1lEQmtxaDRtN3lxc1BobS9vY0pUWXhyb3BIUS93U0w2b0JwYlZyVEl0?=
 =?utf-8?B?SlhrZ2YyUk9oSXFYUFlJd3pFc0tCbGlhV3Z3YjlKYUlOQ2dUMTAxZGJ4d1lJ?=
 =?utf-8?B?b1FYOVdaT0lJbUYwcVlkRVRYL1pqa2w3WU9sMzVnNE4wdzE0VldpR2VBdDZ5?=
 =?utf-8?B?dHYvUHZJdVdxZUd2V0dJc1ZLLy9MaWVZaXRoWml2UmR4bU0zZFpRWkp3OG55?=
 =?utf-8?B?d3ErVml6c3lQMjFLM0tGWTRzcE9TNUVDOEs2ZWRiVWhEYWVYNHhFWVNiQjBB?=
 =?utf-8?B?ZzRmc2dXK0I0RVo1WDNtYUg4WmxDQlFvNE9GaEdpc041bEdsSWRqUkZNOVNl?=
 =?utf-8?B?Nm53RTMwVDhmTVBrYmd6S05jdEdBeGZ6dmsvR081QUFocTFIUCtKbytXTXRj?=
 =?utf-8?B?a2ZremEycUsvSmpsUHJRQnpMNk1UZEt5TjYzd1JoWDQ1MjNpN1Vrd05DVmtv?=
 =?utf-8?B?Wm5RRExNVWVPQmtuMzdiQWh3ZjlNUWYzcU1rZXpTT3ovQTBCZExnWnljWmgz?=
 =?utf-8?B?OHFURjN2Ym4vNXpsbEFqb3hXQ0w2Z3ArVzh2QWszUzJZZXQyZWF3ZkI5dHZY?=
 =?utf-8?B?d3R1WmNVUzNocHNiV3FuR1AxZ2QzTXozRlFrVlAzUThCcG5NdTgvbFVlWFBB?=
 =?utf-8?B?Q3k0UnRTQjhGTVNHZVh2bXY2Y0hxR1ZQam5rb1VnNkVzUVB5MFR1dkVTVjRv?=
 =?utf-8?B?alZ3bVF0Y1dwamhLelVoeVhIajVZMDF6MDMyL3F5dzlySjVqSWp4V1huWnF3?=
 =?utf-8?B?Z2JnVzJiSmRkU1MycTdUelBTc2xKUlNHa2tRRE5CS3plYkFFREc5cFN4Y0dh?=
 =?utf-8?B?OFJGM1FBSG9DSHR2TitLR09wNWMrZnlKSjQwZlRHWUkvN0hSRVVDbCtmam0z?=
 =?utf-8?B?R3VtVFFJRTZkdDdwVEUwckxxSzZ4Vmw4dnkrK3g4S3EzcFBtWWZHYjFjWld2?=
 =?utf-8?B?RFJMN05IZ2VIOVY0VEJCSjBRdW1sUDVpUXZPL25kMkFnSU9Wa0ZJL3Y0dUZt?=
 =?utf-8?Q?ZhbAUPCKe73+IlPUTyfgOjPyya0loIqdsCd/59X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c76d12-3354-4f82-d749-08d9614c5801
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 06:57:57.0021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0621etJTZWGaKTfrai+Gph2e5Uygc3sdaZd+A3oImgsjoa9+y3fs3qiNGOsII8QaAcYyshctdIF1CfR8SrAqRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3838
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBVbGYgSGFuc3NvbiBbbWFpbHRv
OnVsZi5oYW5zc29uQGxpbmFyby5vcmddDQo+IFNlbnQ6IDIwMjHlubQ45pyIMTbml6UgMjE6NTMN
Cj4gVG86IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEFkcmlhbiBIdW50
ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgU2hhd24gR3VvDQo+IDxzaGF3bmd1b0BrZXJu
ZWwub3JnPjsgUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IFNhc2NoYSBIYXVlcg0K
PiA8cy5oYXVlckBwZW5ndXRyb25peC5kZT47IFNhc2NoYSBIYXVlciA8a2VybmVsQHBlbmd1dHJv
bml4LmRlPjsgRmFiaW8NCj4gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsgbGludXgtbW1j
IDxsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnPjsNCj4gZGwtbGludXgtaW14IDxsaW51eC1pbXhA
bnhwLmNvbT47IERUTUwgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPjsgTGludXgNCj4gQVJN
IDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggNC82XSBtbWM6IGhvc3Q6IHNkaGNpLWVzZGhjLWlteC5jOiBjb3JyZWN0IHRoZSBhdXRv
LXR1bmluZw0KPiBzZXR0aW5nIGZvciBzZGlvIGRldmljZQ0KPiANCj4gT24gTW9uLCAxNiBBdWcg
MjAyMSBhdCAxNTowMCwgPGhhaWJvLmNoZW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4NCj4gPiBVU0RIQyBjb250YWlu
IGF1dG8gdHVuaW5nIGNpcmN1aXQsIHRoaXMgY2lyY3VpdCB3aWxsIHdvcmsNCj4gPiBhdXRvbWF0
aWNhbGx5IGFmdGVyIHRoZSB0dW5pbmcgcHJvY2VkdXJhZSwgaXQgY2FuIGluY3JlYXNlL2RlY3Jl
YXNlDQo+ID4gdGhlIGRlbGF5IGNlbGwgYWNjb3JkaW5nIHRvIHRoZSBvdXRzaWRlIGVudmlyb25t
ZW50IGNoYW5nZSAobGlrZQ0KPiB0ZW1wZXJhdHVyZSkuDQo+ID4NCj4gPiBVbmZvcnR1bmF0ZWx5
LCB0aGlzIGF1dG8gdHVuaW5nIGNpcmN1aXQgY2FuIG5vdCBoYW5kbGUgdGhlIGFzeW5jIHNkaW8N
Cj4gPiBkZXZpY2UgaW50ZXJydXB0IGNvcnJlY3RseS4gV2hlbiBzZGlvIGRldmljZSB1c2UgNCBk
YXRhIGxpbmUsIGFzeW5jDQo+ID4gc2RpbyBpbnRlcnJ1cHQgd2lsbCB1c2UgREFUWzFdLCBpZiB3
ZSBlbmFibGUgYXV0byB0dW5pbmcgY2lyY3VpdCBjaGVjaw0KPiA+IDQgZGF0YSBsaW5lcywgaW5j
bHVkZSB0aGUgREFUWzFdLCB0aGlzIGNpcmN1aXQgd2lsbCBkZXRlY3QgdGhpcw0KPiA+IGludGVy
cnVwdCwgdGFrZSB0aGlzIGFzIGEgZGF0YSBvbiBEQVRbMV0sIGFuZCBhZGp1c3QgdGhlIGRlbGF5
IGNlbGwgd3JvbmdseS4NCj4gPg0KPiA+IFRoaXMgaXMgdGhlIGhhcmR3YXJlIGRlc2lnbiBsaW1p
dGF0aW9uLCB0byBhdm9pZCB0aGlzLCB3aGVuIHNkaW8NCj4gPiBkZXZpY2UgZW5hYmxlIGFzeW5j
IGludGVycnVwdCwgYXV0byB0dW5pbmcgY2lyY3VpdCBvbmx5IGNoZWNrIERBVFswXSBhbmQgQ01E
DQo+IGxpbmVzLg0KPiANCj4gU0RJTyBpcnFzIGFyZSBiZWluZyBlbmFibGVkL2Rpc2FibGVkIGR5
bmFtaWNhbGx5IGluIHJ1bnRpbWUgYnkgdGhlIG1tYyBjb3JlDQo+IHZpYSB0aGUgaG9zdCBvcHMg
LT5lbmFibGVfc2Rpb19pcnEoKS4NCj4gDQo+IFJhdGhlciB0aGFuIGZvcmNpbmcgdGhlIGF1dG90
dW5pbmcgY2lyY3VpdCB0byBzdGF5IHVudXNlZCBzdGF0aWNhbGx5LCBwZXJoYXBzIGFuDQo+IG9w
dGlvbiB3b3VsZCBiZSB0byBkaXNhYmxlIGl0IHdoZW4gdGhlIFNESU8gaXJxcyBiZWNvbWVzIGVu
YWJsZWQ/IE9yIG1heWJlDQo+IHRoYXQgYmVjb21lcyB0b28gY29tcGxpY2F0ZWQ/DQoNCkZvciBp
bnRlcnJ1cHQgaW4gNC1iaXQgbW9kZSwgdGhlcmUgaXMgYSBkZWZpbml0aW9uIG9mIGludGVycnVw
dCBwZXJpb2QsIG9ubHkgaW4gdGhpcyBwZXJpb2QgY2FuIHRoZSBpbnRlcnJ1cHQgYmUNCmRldGVj
dCBhbmQgcmVjb2duaXplLiBUaGUgaW50ZXJydXB0IHBlcmlvZCBjYW4gZXhpc3QgZHVyaW5nIGRh
dGEgdHJhbnNmZXIuDQoNClNvIHRvIGZpeCB0aGlzIGlzc3VlLCBvbmUgbWV0aG9kIGlzIHRvIGRp
c2FibGUgYXV0byB0dW5pbmcgY2lyY3VpdC4gQW5vdGhlciBpcyBteSBjdXJyZW50IG1ldGhvZCwg
anVzdCBkZXRlY3QgQ01EDQphbmQgREFUMCwgYnV0IGF0IGxlYXN0IGF1dG8gdHVuaW5nIHN0aWxs
IGNhbiB3b3JrICh0aGlzIG1ldGhvZCBuZWVkIGJvYXJkIGRlc2lnbiBrZWVwIGFsaWduIGFsbCBk
YXRhIGxpbmVzKS4NCiANCg0KQmVzdCBSZWdhcmRzDQpIYWlibyBjaGVuDQoNCj4gDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBIYWlibyBDaGVuIDxoYWliby5jaGVuQG54cC5jb20+DQo+ID4gLS0t
DQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMgfCAxOCArKysrKysrKysr
KysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gYi9k
cml2ZXJzL21tYy9ob3N0L3NkaGNpLWVzZGhjLWlteC5jDQo+ID4gaW5kZXggZjE4ZDE2OWJjOGZm
Li5hYjg0YzI5Nzc3ZTUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1l
c2RoYy1pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktZXNkaGMtaW14LmMN
Cj4gPiBAQCAtMjI2LDYgKzIyNiw3IEBAIHN0cnVjdCBlc2RoY19wbGF0Zm9ybV9kYXRhIHsNCj4g
PiAgICAgICAgIHVuc2lnbmVkIGludCB0dW5pbmdfc3RlcDsgICAgICAgLyogVGhlIGRlbGF5IGNl
bGwgc3RlcHMgaW4gdHVuaW5nDQo+IHByb2NlZHVyZSAqLw0KPiA+ICAgICAgICAgdW5zaWduZWQg
aW50IHR1bmluZ19zdGFydF90YXA7ICAvKiBUaGUgc3RhcnQgZGVsYXkgY2VsbCBwb2ludCBpbg0K
PiB0dW5pbmcgcHJvY2VkdXJlICovDQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgc3Ryb2JlX2Rs
bF9kZWxheV90YXJnZXQ7ICAgLyogVGhlIGRlbGF5IGNlbGwgZm9yDQo+IHN0cm9iZSBwYWQgKHJl
YWQgY2xvY2spICovDQo+ID4gKyAgICAgICBib29sIHNkaW9fYXN5bmNfaW50ZXJydXB0X2VuYWJs
ZWQ7ICAgICAgLyogc2RpbyBkZXZpY2UgZW5hYmxlDQo+IHRoZSBhc3luYyBpbnRlcnJ1cHQgKi8N
Cj4gPiAgfTsNCj4gPg0KPiA+ICBzdHJ1Y3QgZXNkaGNfc29jX2RhdGEgew0KPiA+IEBAIC00MTYs
NiArNDE3LDggQEAgc3RhdGljIGlubGluZSB2b2lkDQo+ID4gZXNkaGNfd2FpdF9mb3JfY2FyZF9j
bG9ja19nYXRlX29mZihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkNCj4gPiAgLyogRW5hYmxlIHRo
ZSBhdXRvIHR1bmluZyBjaXJjdWl0IHRvIGNoZWNrIHRoZSBDTUQgbGluZSBhbmQgQlVTIGxpbmUN
Cj4gPiAqLyAgc3RhdGljIGlubGluZSB2b2lkIHVzZGhjX2F1dG9fdHVuaW5nX21vZGVfc2VsKHN0
cnVjdCBzZGhjaV9ob3N0DQo+ID4gKmhvc3QpICB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc2RoY2lf
cGx0Zm1faG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7DQo+ID4gKyAgICAgICBz
dHJ1Y3QgcGx0Zm1faW14X2RhdGEgKmlteF9kYXRhID0NCj4gPiArIHNkaGNpX3BsdGZtX3ByaXYo
cGx0Zm1faG9zdCk7DQo+ID4gICAgICAgICB1MzIgYnVzd2lkdGgsIGF1dG9fdHVuZV9idXN3aWR0
aDsNCj4gPg0KPiA+ICAgICAgICAgYnVzd2lkdGggPSBVU0RIQ19HRVRfQlVTV0lEVEgocmVhZGwo
aG9zdC0+aW9hZGRyICsNCj4gPiBTREhDSV9IT1NUX0NPTlRST0wpKTsgQEAgLTQzMiw2ICs0MzUs
MTggQEAgc3RhdGljIGlubGluZSB2b2lkDQo+IHVzZGhjX2F1dG9fdHVuaW5nX21vZGVfc2VsKHN0
cnVjdCBzZGhjaV9ob3N0ICpob3N0KQ0KPiA+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gPiAg
ICAgICAgIH0NCj4gPg0KPiA+ICsgICAgICAgLyoNCj4gPiArICAgICAgICAqIElmIHNkaW8gZGV2
aWNlIHVzZSBhc3luYyBpbnRlcnJ1cHQsIGl0IHdpbGwgdXNlIERBVFsxXSB0byBzaWduYWwNCj4g
PiArICAgICAgICAqIHRoZSBkZXZpY2UncyBpbnRlcnJ1cHQgYXN5bmNocm9ub3VzIHdoZW4gdXNl
IDQgZGF0YSBsaW5lcy4NCj4gPiArICAgICAgICAqIFRoZW4gaGFyZHdhcmUgYXV0byB0dW5pbmcg
Y2lyY3VpdCBNVVNUIE5PVCBjaGVjayB0aGUgREFUWzFdDQo+IGxpbmUsDQo+ID4gKyAgICAgICAg
KiBvdGhlcndpc2UgYXV0byB0dW5pbmcgd2lsbCBiZSBpbXBhY3RlZCBieSB0aGlzIGFzeW5jIGlu
dGVycnVwdCwNCj4gPiArICAgICAgICAqIGFuZCBjaGFuZ2UgdGhlIGRlbGF5IGNlbGwgaW5jb3Jy
ZWN0bHksIHdoaWNoIHRoZW4gY2F1c2UNCj4gZGF0YS9jbWQNCj4gPiArICAgICAgICAqIGVycm9y
cy4NCj4gPiArICAgICAgICAqIFRoaXMgaXMgdGhlIGhhcmR3YXJlIGF1dG8gdHVuaW5nIGNpcmN1
aXQgbGltaXRhdGlvbi4NCj4gPiArICAgICAgICAqLw0KPiA+ICsgICAgICAgaWYgKGlteF9kYXRh
LT5ib2FyZGRhdGEuc2Rpb19hc3luY19pbnRlcnJ1cHRfZW5hYmxlZCkNCj4gPiArICAgICAgICAg
ICAgICAgYXV0b190dW5lX2J1c3dpZHRoID0NCj4gPiArIEVTREhDX1ZFTkRfU1BFQzJfQVVUT19U
VU5FXzFCSVRfRU47DQo+ID4gKw0KPiA+ICAgICAgICAgZXNkaGNfY2xyc2V0X2xlKGhvc3QsDQo+
IEVTREhDX1ZFTkRfU1BFQzJfQVVUT19UVU5FX01PREVfTUFTSywNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICBhdXRvX3R1bmVfYnVzd2lkdGggfA0KPiBFU0RIQ19WRU5EX1NQRUMyX0FVVE9f
VFVORV9DTURfRU4sDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgRVNESENfVkVORF9TUEVD
Mik7IEBAIC0xNTMxLDYgKzE1NDYsOQ0KPiBAQA0KPiA+IHNkaGNpX2VzZGhjX2lteF9wcm9iZV9k
dChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICAgICAgICAgaWYgKG9mX3Byb3Bl
cnR5X3JlYWRfdTMyKG5wLCAiZnNsLGRlbGF5LWxpbmUiLA0KPiAmYm9hcmRkYXRhLT5kZWxheV9s
aW5lKSkNCj4gPiAgICAgICAgICAgICAgICAgYm9hcmRkYXRhLT5kZWxheV9saW5lID0gMDsNCj4g
Pg0KPiA+ICsgICAgICAgaWYgKG9mX3Byb3BlcnR5X3JlYWRfYm9vbChucCwNCj4gPiArICJmc2ws
c2Rpby1hc3luYy1pbnRlcnJ1cHQtZW5hYmxlZCIpKQ0KPiANCj4gQXMgc3RhdGVkIG9uIHRoZSBE
VCBwYXRjaCwgSSB0aGluayB5b3UgY2FuIHVzZSB0aGUgImNhcC1zZGlvLWlycSIgaW5zdGVhZC4N
Cj4gDQo+ID4gKyAgICAgICAgICAgICAgIGJvYXJkZGF0YS0+c2Rpb19hc3luY19pbnRlcnJ1cHRf
ZW5hYmxlZCA9IHRydWU7DQo+ID4gKw0KPiA+ICAgICAgICAgbW1jX29mX3BhcnNlX3ZvbHRhZ2Uo
aG9zdC0+bW1jLCAmaG9zdC0+b2NyX21hc2spOw0KPiA+DQo+ID4gICAgICAgICBpZiAoZXNkaGNf
aXNfdXNkaGMoaW14X2RhdGEpICYmICFJU19FUlIoaW14X2RhdGEtPnBpbmN0cmwpKSB7DQo+ID4g
LS0NCj4gPiAyLjE3LjENCj4gPg0KPiANCj4gS2luZCByZWdhcmRzDQo+IFVmZmUNCg==
