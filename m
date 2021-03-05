Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD057C433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 14:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B076501A
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 14:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhCEOKV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 5 Mar 2021 09:10:21 -0500
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:9225
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231144AbhCEOJ6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 5 Mar 2021 09:09:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhYszah1uYHwRsp9VOtE7jaKJTEJtDVAl99IzSL0rg+mBhegkEmxMGmYSaCGlWYp6u7e2qbhOLAOPzTb3GM4PeQJt/jiEWQOj+7d+sN0wQylhJY6rA5THkV6a+UE3mXkiK2dWuvjILXLtqdxJWRsK6AiG5ClxBTWPOyGhk7NZiF+btuET3YpsRQpckukPFd1GFArtpBAgRTUa4ZmwclEFpvc1QGpBdq8JrrJp9bvrifhWVRY0UpEp0Gan/pGeXSXPKlMzvy0sCDNHNKl0siQEB+FcguBvZQ+BeQNQLHSOSnxW+JxYVjFEyhGdAJnKXZilpeDkXbTZGIxDnk5voSUIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kvObgiNFpmJmbqQe6X4rCzvOiO6WUXxaosM0bddpns=;
 b=nGmcVg0imI1A6I4x6UVJRnqAVa4FzjM/ZRYQnf+1l/0/a3LJinrik7n63u5EsTZmb7jLzUSEmSqN7ow2hYPHI2T2SBjIHJ0iyYQ2zPh972/MYHH84NTQY+9kFe1DgqMVm+i7b03AWNYxFW1Z8ERB5Ra8vYk+rvM2wuiTHBEQOXpB7HIvN53nDX0tQJaarImOb6iU8Fd5SKhFJXdX4pZH5MCf1FkXJxRclXaRXlOo73FIqrJ1QONEmFcs9vHt0LEap87wynodAi5e+Wh4ZKoBBmXnkFlCHjtLzCqJtoh5lpfuNSEryvzFGUIvk2u2mxp84AKY+2zAdPEQwfrCM85w3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kvObgiNFpmJmbqQe6X4rCzvOiO6WUXxaosM0bddpns=;
 b=eT65rXGLfOcT7MtpkkQdugIBIasKMUFB7Y/kOzPorxZBvW9V8c17azKlI0lFkBPEMd4v+NLknSi2ECF0L9XvfFNMbFwKD87Y1UR98Lsr1QDJcu0gOtOjYmngCKiWlT9xcsnDt5CatEvV/NXeDXHrPMjmpESP37xQJtwo12suhBE=
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com (2603:10a6:20b:2::14)
 by AM7PR04MB6823.eurprd04.prod.outlook.com (2603:10a6:20b:102::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.26; Fri, 5 Mar
 2021 14:09:55 +0000
Received: from AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359]) by AM6PR04MB4966.eurprd04.prod.outlook.com
 ([fe80::ecad:ebb8:8eb0:d359%7]) with mapi id 15.20.3890.033; Fri, 5 Mar 2021
 14:09:55 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Topic: [PATCH V3 4/5] dt-bindings: mmc: fsl-imx-esdhc: add clock
 bindings
Thread-Index: AQHXCyWCn3zgwsr8UUWODcXlM3pVO6p1ejBQ
Date:   Fri, 5 Mar 2021 14:09:55 +0000
Message-ID: <AM6PR04MB4966041BFFDDAF1EF00BE1AD80969@AM6PR04MB4966.eurprd04.prod.outlook.com>
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
 <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1614222604-27066-5-git-send-email-peng.fan@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oss.nxp.com; dkim=none (message not signed)
 header.d=none;oss.nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3b79fd02-1754-401c-31f1-08d8dfe05a48
x-ms-traffictypediagnostic: AM7PR04MB6823:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6823EDF6E8F2DE425E07F24F80969@AM7PR04MB6823.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+0uz4OjTRXvDLWtxTJMzDKyCd4VspiDU48Djdb8F+PY4ZjQ7dsgYnRI+d7XmiL/4kluiV2FYERkYusS3xo4DOqGqIr3fAMT+SxH8K0jdPlh97eX1QyiuR8UsDtnerhnTo1BE/QecyacgZm5OihzVLz/sYXHk7yJX8Yf5NFM+yvK2T8KdSQDcQbd09l0ROZxF0whxRq+RPk+3zkOEMoSzyHPOTL5T/JIhouaLZKf2WKJxr1mSdaoKL4rEtQ2Ti1Ttet8bwQw0yh9HIdqI8f4BDeG+uxwvMANjS+5TLVVbWOc4CWeWNZ9gp/RSPFTUqEdu5hC8nJ5dXmwvyzyFOA3K0B8hAisCuSp9l0vSzlY2xayNGOegWWn7ZquTasDH2r64NcoS7TuGzD84eMdRWhpyhTmB8bUYIbt3E0rmtnHFZy1Xjj3b222sWZ+5eTLvhKIHm5/7mkWFF5ep9Y9+6FT2ItOYpIArTMMpoLk9XI1nEyIbu0dYuOCgpGkJv5gmsrSOvFCGUm3dadZF7Tb9qx/nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4966.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(186003)(66556008)(64756008)(76116006)(66476007)(52536014)(8936002)(66946007)(8676002)(26005)(4326008)(7416002)(66446008)(9686003)(55016002)(5660300002)(44832011)(33656002)(54906003)(478600001)(110136005)(6506007)(86362001)(83380400001)(7696005)(2906002)(316002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dVo1LzE2VU1ZM0pwSTQyQTZxSjd3azJlR3BmV2VOSkFMT0xnNFlZYVVkUVdQ?=
 =?utf-8?B?T1BpejU5WWlkWGVCbVB5OTdUMnIvTHg4cTA5eExZY2I2RUZ1d3lMcHpnSEkr?=
 =?utf-8?B?TVdsait5NHBBSkVKd0FSL0JIenJEWG83RnVGdFhvb0RWc2JoNUl1MzU0ZzRC?=
 =?utf-8?B?MEgybk1OM3VJUjBjc1hDUlNsNDVzV3hELzFnUE83YUxBY1h2R2pNZi9sSXN4?=
 =?utf-8?B?OXcwTGN2T044Q1N3TlJPVVVGay9EeUZOYitvMkt6aVVZNXNpUVZKSnpoVkR1?=
 =?utf-8?B?SGJ6dEFoRFZWOGk1MUdlVGdQK0d1ajVXTXAzQjBCc1hBaTVUQ1VmanNpRy9B?=
 =?utf-8?B?VEcxcGdtblVvVldmUWZLQjJlSUlkMnljV21jYlhWRTFtSEhXbzZwbjd5dTQx?=
 =?utf-8?B?QmwzMDZIdTA1NWFaaGZlV3BWNnpqbXprTUNBTjN2N0ljQ2lJWHpzNWVLT3Mz?=
 =?utf-8?B?SHhCTGZRU3dVajFkWUZITHZLVDRYVnhCOUpoNHJ1d3RROEF2ODNwQ3F5Sk1k?=
 =?utf-8?B?UnZjSVF6b0lIQ3crYk5uV0Z2eXFHdlB5NktOT3dnMzJMZVV4R1BOcThXelU1?=
 =?utf-8?B?V3FmckNsNHNuaXlQMFRTUFh1VStHbnhPZE5ERzBlVXdZbVBzRkd4M1JPUXQ0?=
 =?utf-8?B?ekE4dGhXV2hOdEhIbEZxTW5rVWQwMUEzTWpqSFdnSWV2bkkrVVhLQ0dTU1ky?=
 =?utf-8?B?ZG02YTFSa2JRRlpZZHAxVkZ6ZzJFTWdEUzh2OVh3T3RQZkhEb2Y1cmhmVWI0?=
 =?utf-8?B?RE9RQzRKTitNSVdLSDdLWklOVEdCNXhOR2Q3SThhM21WYnBBcHZSVXUrQ1pr?=
 =?utf-8?B?Q2g1ZFoyc1ZrdEJ1Y0M2RXdoWXpqK01LU0ZpUGl6dmQ0ZXZSMS9BQ05nckZE?=
 =?utf-8?B?RmVMQnpJbUViZ21VcFVOdHRLZm43T0NvNVhlVkx0RldQaTNDc3lTSjdmaEJr?=
 =?utf-8?B?QjIwWCtscFBRelBZOVNoMFFoNkZUOFJ2M1JJYkU4Q1lNN1BzLzl2bUx3SFVF?=
 =?utf-8?B?RndtcDVlaDhJWDRBd2hQUGlCVmZnM1dzM2twdllCeExUUXNuVFQ2cHhlSWps?=
 =?utf-8?B?cXpJRDhoUHNVVkovcFo1OFBGTG5IWmx6SVc4SWJiY3ArbVVJSkxpSkhyQ0ZY?=
 =?utf-8?B?cFFORGVUSFp0MHZlcDY1VFhFMm1YUVdjZjVxNTQ1TEU4S1RMNmJ0WXpsUmRa?=
 =?utf-8?B?SVcvT0V3NW5QR2xoU2lSeHkreEFOdEZTMUZUaXFvU2o0N0hwMWN3YVdSdzM0?=
 =?utf-8?B?Ryt1Um9ncnlJaUlPVDZCRTM5d3Myd3FPUWJpRjJYZXdhVTFIRkNERHExU0sv?=
 =?utf-8?B?d0ROOTBzampEQkFQM3o5QjRER0JRbTQxR2oyNVprMjdEQ2h4WDMwMEZuT0hr?=
 =?utf-8?B?VTFtVVp5R2k2NDg5V2pnaHJTSUorOFdsZWRtWnlwMHhNSjBhUDR1Y2Z2MWs4?=
 =?utf-8?B?WTZOeHVVWjlWUk9xQmFCQldLTzJVTzhFSGNuT1ljNzdYcFhsQUZoY2Z3MFhX?=
 =?utf-8?B?Rk1XLzYxOFAwNTBkRFFCbjArUWFGWDRUYVFnenVsQy9yOWY1c2l6OXhUVHBV?=
 =?utf-8?B?THp2SUprdnlSZjBsOHA4TkxEQTQ4R2xOcEtoYVc3U0k2SGxMV2h1UE5Rc0tZ?=
 =?utf-8?B?Z2wzTFBobEtZNVpoUWJ6NlN0dHhpOWtpakd6NC9IVVVUY3JPUWRXV3hibDBj?=
 =?utf-8?B?MElvVHhzYmNMc3lmaGpMa2w1SjZQdFVIL3BESDdoWmViZEd2bW9mcTB4VmxU?=
 =?utf-8?Q?j732HC73znQb/hJrVUlxsyRqwwAId2cmW9ywwvG?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4966.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b79fd02-1754-401c-31f1-08d8dfe05a48
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 14:09:55.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eDxTswo/12R++P138R0DfHYDWzs9sxmI+0jVOwA3Mpgk1DopkswFojayDLoDAL4DQR5kAbMXDdVrJFlNLIk5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6823
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUm9iLA0KDQo+IEZyb206IFBlbmcgRmFuIChPU1MpIDxwZW5nLmZhbkBvc3MubnhwLmNvbT4N
Cj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDI1LCAyMDIxIDExOjEwIEFNDQo+IA0KPiBGcm9t
OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gDQo+IEFkZCBjbG9jayBiaW5kaW5ncyBm
b3IgZnNsLWlteC1lc2RoYyB5YW1sDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVu
Zy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNs
LWlteC1lc2RoYy55YW1sICAgICAgICB8IDExICsrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMTEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sDQo+IGIvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9mc2wtaW14LWVzZGhjLnlhbWwNCj4gaW5kZXggYTdm
YmQ4Y2MxZTM4Li4zNjk0NzE4MTQ0OTYgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sDQo+ICsrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvZnNsLWlteC1lc2RoYy55YW1sDQo+IEBAIC0x
MDMsNiArMTAzLDE3IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICBPbmx5IGVNTUMgSFM0MDAgbW9k
ZSBuZWVkIHRvIHRha2UgY2FyZSBvZiB0aGlzIHByb3BlcnR5Lg0KPiAgICAgIGRlZmF1bHQ6IDAN
Cj4gDQo+ICsgIGNsb2NrczoNCj4gKyAgICBtYXhJdGVtczogMw0KPiArICAgIGRlc2NyaXB0aW9u
Og0KPiArICAgICAgSGFuZGxlIGNsb2NrcyBmb3IgdGhlIHNkaGMgY29udHJvbGxlci4NCj4gKw0K
PiArICBjbG9jay1uYW1lczoNCj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IGlwZw0K
PiArICAgICAgLSBjb25zdDogYWhiDQo+ICsgICAgICAtIGNvbnN0OiBwZXINCg0KT25lIHF1ZXN0
aW9uOg0KVGhlIHNpZGUgZWZmZWN0IG9mIHRoaXMgcGF0Y2ggaXMgdGhhdCBpdCBpbXBvc2VzIGEg
Zm9yY2VkIG9yZGVyIG9mIGNsayBuYW1lcw0KSW4gRFQgd2hpY2ggYWN0dWFsbHkgd2FzIG5vdCBu
ZWVkZWQuDQoNCkRvIHdlIHJlYWxseSBoYXZlIHRvIGRvIHRoYXQ/DQoNCk9yIGFueSBvdGhlciBi
ZXR0ZXIgYXBwcm9hY2ggdG8gYWxsb3cgYSByYW5kb20gb3JkZXIgdG8gbWF0Y2ggdGhlIERUDQp1
c2FnZSBiZXR0ZXI/DQoNClJlZ2FyZHMNCkFpc2hlbmcNCg0KPiArDQo+ICAgIHBpbmN0cmwtbmFt
ZXM6DQo+ICAgICAgbWluSXRlbXM6IDENCj4gICAgICBtYXhJdGVtczogNA0KPiAtLQ0KPiAyLjMw
LjANCg0K
