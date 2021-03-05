Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA5C433E6
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 00:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CF86500A
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 00:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCEAi0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 19:38:26 -0500
Received: from mail-db8eur05on2044.outbound.protection.outlook.com ([40.107.20.44]:55782
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229465AbhCEAiZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 4 Mar 2021 19:38:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDFT2KIIBicX6wbOZ/DmTx/C+dBl8XqaLbr5kTEUkzVMjF/mWWcV27NDns9I3Tdt0WkReT2dCv1bQ62eb4gROwdCe8/j1hYPUDo95+5IyfaHvyKoRKAhGrT/cfstyiDkGrzNjC+3opwAtmhXlnazc5lvOnSUE0uVzRq+s0J66AaiQHXw4Q3DjOBluZgy7FPntk4SWLc4RIy384skccnm3lHb+LTcrY7fuhabCzi44BrP4qdlJa5tq23vtV68BZd955iCp1xZJGtcCbBTx5+yoO9gc2s12wWE+fAP5ppVnGBvqSHIfjFrC69BLxADvdavlNglCIhRx71acEusXv864A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjko22WxTYdpl0dj2jlAfbiHkL9/jc9/UQXpSUcIenw=;
 b=YwkDMnMTsdnGhobcVjZ+KWnCuvjrQr/PYu76vL/8vEnwqyIQijkwsNMfrPC8CQpVW4lB+HYoCF2r/653xGIaAQV7Xy/FYnN2hhtCQUs0iBSiVLHZfQCJ5youU2uBsCcH4QC3tXrgFX4pMhUplFKi5jRULXGw/sVS0jt25YF0XvgP46adFsweWOBtc/5tjZ7LII3x1zKTjvaI9L43jYtb+jBC+V4b0/zEkcNonYwkyLugXugMR0HZSc5hteHtvzCll9BJ+CF9BoLoFLLY8Y2UNczcDg80/EpcggSDcI47YkpHs+P6+KgwLWd7FTKN1C4EPnrYhYF/Gx9P4oFqDEJu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjko22WxTYdpl0dj2jlAfbiHkL9/jc9/UQXpSUcIenw=;
 b=N93cWXrdhcsFaJvzWtzxsm6vyA8bnn2+UftNgaA+ox3pskIwk/2NBvLzAdaz2VDU1r0DETtgQfNNoD3fE8v2ARDnqVkfyuhQh14VIcs36CNpdrK4yleHqX0xIdMCcsEILCiMWDjjjR2UEW0Cl+ywlWkPS6kKR52mREkRrE4iZKg=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5243.eurprd04.prod.outlook.com (2603:10a6:10:17::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Fri, 5 Mar
 2021 00:38:22 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::d58c:d479:d094:43d0%9]) with mapi id 15.20.3846.049; Fri, 5 Mar 2021
 00:38:21 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Topic: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Index: AQHXCyWBw7rdwKHv8EyTisodgYlu9qp0er8AgAAeXgA=
Date:   Fri, 5 Mar 2021 00:38:21 +0000
Message-ID: <DB6PR0402MB2760DE61170314280DE56F6388969@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
 <CAL_JsqKAOUKnVLvu-VNeDVg0ShXPy56wxhCQv38+rO2k961v+g@mail.gmail.com>
In-Reply-To: <CAL_JsqKAOUKnVLvu-VNeDVg0ShXPy56wxhCQv38+rO2k961v+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [58.208.155.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e6e8f75-48a6-4c4a-4fae-08d8df6efaca
x-ms-traffictypediagnostic: DB7PR04MB5243:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB52434ED51428F82EF85C879988969@DB7PR04MB5243.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rWhWaBooUhvr7xSRRXJ8PVdnX60x/rcKNVEUE2IG3r/Gk8ednWXHfLM4KoQkm41fFLWpv8mSW+5L+G5uFFhAGuA8yytDxuZoKib400W9GOgRbNgj3G7f6U/UgTt9R+lEf8aSr9Kql/CyvWWoFMXSXj3G4Rpej4zYqwZTGKXN69zVfj3beHSWpIMWCWOYNeFYcSJSVsBgT/Mo+MQ9fXlcmwTgiODPxZpHfuJOz36h3NRAy0HIHgwfoDVwYPDraR8cwwxx9osQMkAIFUBgnXb9Rgk7O1nN5C/QhLtj8hxQD48Ldo5442klDeqi+urYSpQU6XljWpr7esUVXh+zDRpsEkolRlKNhcgt47lN5A2aPWFjyBABOJvhc0ujwE59LPEO0QEGq0zPkGUmbqAU6+ChQLgh1Os2ICBYk+PgXCiANPC3PsT2FCMImkKO1AkxalSgRIAQMLzJ/WjASjPnR8/CfvAOrBT5pVYN06EjpGuwupxlhJmiVLRQHFEZXdv0Fx0fGt0kTj5wBZ8CCcF5oGEQ5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(55016002)(7696005)(186003)(9686003)(4326008)(26005)(8676002)(66476007)(76116006)(52536014)(71200400001)(7416002)(2906002)(33656002)(66556008)(64756008)(6506007)(53546011)(110136005)(478600001)(66446008)(66946007)(54906003)(44832011)(5660300002)(86362001)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WklkdjBUdkE1ZWNBV0pNWGFVUWJhWXUrNEx5Umx3dW5Jd083M0tGL2tKeE5q?=
 =?utf-8?B?OGlldjNjeVVVTmYvWDRSNFljc1FOSjA3eUVOSDRtVk1tUkNTajZGNGhNMjNL?=
 =?utf-8?B?ZFFXbEd0a0VVSUljUHFENU8wRFE3c0VXV2JRVnpRMmo4VWtZQmRXbHVlTkd0?=
 =?utf-8?B?UEJEQ0VzSE1DdEFCajgzMUFSdE85dkxTbEtVZndoMzBnRGRmRkhOZ3YwYTJQ?=
 =?utf-8?B?cm13YVF6T1BNWE1kSUQzRGVRcVg2eGY2Q2xzMWVid1JGVlZZbmtxUldzSHpF?=
 =?utf-8?B?Mk04RC8vUzJMYXViZkxjQjZzWk5XclRUMzZLc0JNMlhWUHNBelVkRTYzUGU2?=
 =?utf-8?B?b2ZxcnNGMUVQTzlYNm9UWHJsUDNOZXJQNHdHelBITkV2K3V1VE4wOFcwMU12?=
 =?utf-8?B?U1F5Z3oyUXpab21GRDhuRk5reDZoSUpCZHdPbHBLRzNta1pFYjhSRjBtQ1pF?=
 =?utf-8?B?cnRZalZVOUg5U1hJSTNTcjBYMnZZRmdKWk44bDZTTzRGREhWdHBkYkYwZW9T?=
 =?utf-8?B?SWxYck9Pay9ieUxJaTZNRXNCdmNlWjA2SUF1a2VWUUpETEZELytqVDlUdzlK?=
 =?utf-8?B?RzR3WmRQSFUzU081QnVXSk9GYmpaU2IzeklRZzhaTWFVV29NMlIyQmQrNkx6?=
 =?utf-8?B?anRwb2tOdDc3SWN1V1dmN1V2dEg3eERWeFRoMlhlYTREaHZCMGdJRjR2Y2VP?=
 =?utf-8?B?dTlsMkVuS1AzN2tGeVpDbFpja0ROUXlQdlVScUdNcUkzUWlka2JxUFBDTldp?=
 =?utf-8?B?YVpvaVkyQlNKUWlZdXhFV2todWJZYkNMR2UyL2lBZ2FHMmtBMWhvVjExekYz?=
 =?utf-8?B?dkI5ZkJrYVBmV0FzaXpzTHlBWWY0NjBhNFp1SENERTJVaVN6K0Q2eGpHckgw?=
 =?utf-8?B?SHZvVDhCWS9TQk1seG5ZSW9aM2dRZHgrTUNveXpxZ3BjZHVRUGtyTlU4SGc1?=
 =?utf-8?B?ZHg1b2VUZExJbnhZTzlETUxpK29sbDhpSFFpbDYzT1MxUjY4QkIxSENyWW5t?=
 =?utf-8?B?eVR4VlVXaktaTVZHVld2dVZWa2U4bEtKdU1NRlRWUU50UDZoR250U0ZjQ3dk?=
 =?utf-8?B?SzJJRWtmcE00YTNCT3VuL1hqZG9vM2RhNG9ZeTZjcnVUS21zU25nVHYzS0R2?=
 =?utf-8?B?djhEN1pKOW82dTZBa2NweStXUlJGcjNneFAzZkdQd1pZUVhCWWRXelcrdXV0?=
 =?utf-8?B?OVc4OUxNTXV4bDNPY2RFTmJtZyt4ZVNMZHhkalU3U3ZxaGJQYTZLVUZDYld0?=
 =?utf-8?B?bkZ3b3NIaCtCY1IrK3l5a3h1RnF4VXAvY3o3eFo1Z3djVXVrT1pVSnVYYjlV?=
 =?utf-8?B?RHJ4eDB1OWF0bHJsbkwxaE92c0ZJdWQvc3A5Wnc2bGFHL0dtNFJpKzRxS2NN?=
 =?utf-8?B?WFM3VTFJZUJYYXR0eEJtM0w5dEpJUVRFK1lOUjRHWHB6R1NRUWdPVmowTGdS?=
 =?utf-8?B?RjNpZThvdHhiWEpWQVB2WkR0S242a0lrOTF5Q2JaZnZhWENWODBQOGMwMzRu?=
 =?utf-8?B?ZGxQT2Zpbytxb215WmdFTnlaZmdmZER4VWpoL2Q1OUJQYmRNRDFMZWx6QWJy?=
 =?utf-8?B?QjVnSzdpcXFKOUdreCtGeTRNWHpER3dWbG1oNUhQZ1lIaEVSOFc4aVFhK2Zo?=
 =?utf-8?B?bnZQWm9XYTdZZGlGM3ZmY2dibE9lUlVFS1RNcnRKUmxCaGpweDJxaE9VcEVj?=
 =?utf-8?B?ekRYSGtId29aQjY3Qk1GeVBpTERlSjNlRlVoWFMvbk14T2FSMGt6YVYrYWxy?=
 =?utf-8?Q?3f1THkbLKYSfU6v/Y8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e6e8f75-48a6-4c4a-4fae-08d8df6efaca
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 00:38:21.8974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mkOMlldYBBHr7Djree05V2kvmpiNBYQejojOmVT5La92XmuOHjrg86sSpHBHNTGluXmi8fdnUDtc3rUkBCGzzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5243
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUm9iLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgNC81XSBkdC1iaW5kaW5nczogbW1j
OiBmc2wtaW14LWVzZGhjOiBhZGQgY2xvY2sNCj4gYmluZGluZ3MNCj4gDQo+IE9uIFdlZCwgRmVi
IDI0LCAyMDIxIGF0IDk6MjMgUE0gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gQWRkIGNsb2Nr
IGJpbmRpbmdzIGZvciBmc2wtaW14LWVzZGhjIHlhbWwNCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sICAgICAgICB8IDExDQo+ICsrKysrKysr
KysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBMb29rcyBs
aWtlIHRoaXMgbGFuZGVkIGluIGxpbnV4LW5leHQgYW5kIGludHJvZHVjZXMgd2FybmluZ3M6DQoN
ClBhdGNoIDIsMyBoYXMgbm90IGJlZW4gcGlja2VkIGJ5IFNoYXduLiBBZnRlciBwYXRjaCAyLCAz
IHBpY2tlZCB1cCwNCnRoZXJlIHdpbGwgYmUgbm8gd2FybmluZ3MuDQoNClRoYW5rcywNClBlbmcu
DQoNCj4gDQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1iaW5kaW5ncy9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY2xvDQo+IGNrL2lteDhxeHAtbHBjZy5leGFtcGxlLmR0
LnlhbWw6DQo+IG1tY0A1YjAxMDAwMDogY2xvY2stbmFtZXM6MTogJ2FoYicgd2FzIGV4cGVjdGVk
ICBGcm9tIHNjaGVtYToNCj4gL2J1aWxkcy9yb2JoZXJyaW5nL2xpbnV4LWR0LWJpbmRpbmdzL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tDQo+IG1jL2ZzbC1pbXgtZXNkaGMueWFt
bA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtYmluZGluZ3MvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2Nsbw0KPiBjay9pbXg4cXhwLWxwY2cuZXhhbXBsZS5kdC55YW1s
Og0KPiBtbWNANWIwMTAwMDA6IGNsb2NrLW5hbWVzOjI6ICdwZXInIHdhcyBleHBlY3RlZCAgRnJv
bSBzY2hlbWE6DQo+IC9idWlsZHMvcm9iaGVycmluZy9saW51eC1kdC1iaW5kaW5ncy9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbQ0KPiBtYy9mc2wtaW14LWVzZGhjLnlhbWwNCg==
