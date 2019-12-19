Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A8BC43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 10:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F21924650
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Moxa.onmicrosoft.com header.i=@Moxa.onmicrosoft.com header.b="nQvadA+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfLSK5v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:57:51 -0500
Received: from mail-eopbgr1300079.outbound.protection.outlook.com ([40.107.130.79]:58592
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726636AbfLSK5v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Dec 2019 05:57:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/qu+WHp8rQHtIlqu9KRT7z2feJdzSpubDgsxZkDO4MgunaBr3revqAsOMC4Z/5GRFsaBCcuCooZn/2Vo8nwO7YDh5RQWDzSl+svOY3KgXNFH9S2xZyDGVAAcusrFy0UBREbdTPrtSmyCU3oXSVdi8WUfBjhxAcodxZzoynk8F/2AzVdbZyHFZqt2/Xo3UeqlEg9RPbsNPWevPFC4byotOV6wh5aR1iUP1VKmt80klGxp6CNXCfvxX3WFA0xa9rxATtAhRUat2Wa1LtCUObMRKiPuv7LRn3Ncqx1A2X9J+tl/ExytBLohp5xGsDlXmYN/xV+Ng01Xi48zzrzcsBppg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMf3Tux6mdKFcNlQ/+qha0EKuFL/9O7JEAL/65lz0N8=;
 b=nsAuwdNWhv0FbVII5fcTVGALzahT2OuVwEcCzby4++oyqHMfNCgZ6qsC2DIbwoA7/s6bLn7DE8wugVLGtfMkkw3ryfWTo/ohg2k2zg+ejUD2gaQPyxR/9HacA4c+9nl3Mt9rko9Kvy7AoPQLcbHuVhcBUvGDJGDGJYIA2RXR2jCWp6ZCKC900GjdcYT5EYC0yldOuT2OENLT0kSXgUOdQ4Jc6OVn+25vZgXs+XS3xpGNDidFNT7OfDKwPSgzJba7X5jtycQY69BIgNktn10x1JdPscCjuoP8SLwIihqV3ETqgVABXTB0ZB1qofJ5tqBuOcOZEMDm4e/FlSbJf2ubOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Moxa.onmicrosoft.com;
 s=selector2-Moxa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OMf3Tux6mdKFcNlQ/+qha0EKuFL/9O7JEAL/65lz0N8=;
 b=nQvadA+QUYIYTwgwkKz9e/t2XdVHJzyfokGZ/COYwfUF7E8G85Dw29MV7EPYCu28Mblkk8SSEsCiDG6OnmWnJ+qA5f4JRvgn9MlC7Ne7QizFLxPI+CInlMgix5lxMNede4kbcz4LyHOFyvp24+PXIv5rrVboii2wUcEbunGJfpc=
Received: from HK0PR01MB3521.apcprd01.prod.exchangelabs.com (52.132.237.22) by
 HK0PR01MB2212.apcprd01.prod.exchangelabs.com (20.177.31.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 10:57:47 +0000
Received: from HK0PR01MB3521.apcprd01.prod.exchangelabs.com
 ([fe80::1c05:3356:2d9:76f0]) by HK0PR01MB3521.apcprd01.prod.exchangelabs.com
 ([fe80::1c05:3356:2d9:76f0%7]) with mapi id 15.20.2538.019; Thu, 19 Dec 2019
 10:57:46 +0000
From:   =?utf-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= 
        <JohnsonCH.Chen@moxa.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
CC:     "lkundrak@v3.sk" <lkundrak@v3.sk>,
        "dianders@chromium.org" <dianders@chromium.org>,
        =?utf-8?B?VmljdG9yIFl1ICjmuLjli53nvqkp?= <victor.yu@moxa.com>
Subject: Please review the patch "mmc: core: try to use an id from the
 devicetree " again
Thread-Topic: Please review the patch "mmc: core: try to use an id from the
 devicetree " again
Thread-Index: AdW2WoaTK+k0T3+LQYeyq9klC5j/Cg==
Date:   Thu, 19 Dec 2019 10:57:46 +0000
Message-ID: <HK0PR01MB3521E416A9562724AC4A14EDFA520@HK0PR01MB3521.apcprd01.prod.exchangelabs.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=JohnsonCH.Chen@moxa.com; 
x-originating-ip: [122.146.92.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9753f1b8-3d7d-426e-e82e-08d784724837
x-ms-traffictypediagnostic: HK0PR01MB2212:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0PR01MB2212011B2EE05AE07C14A28AFA520@HK0PR01MB2212.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39850400004)(366004)(136003)(376002)(346002)(199004)(189003)(55016002)(81166006)(81156014)(66476007)(66446008)(8676002)(66556008)(316002)(64756008)(54906003)(5660300002)(9686003)(107886003)(4326008)(52536014)(966005)(85182001)(86362001)(110136005)(33656002)(76116006)(66946007)(2906002)(7696005)(8936002)(478600001)(186003)(26005)(71200400001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:HK0PR01MB2212;H:HK0PR01MB3521.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: moxa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KSV11vdmFLG0qxTgQdkbr6e+w/sdE9nwVrRBIHAQy1tst7vAVUuOFZiNkxB04asigFhAQ8pAUGR1n93msOH/x/9wHVfgh9BH/QCMqWeFMdNTzp0MIcRaUDa5Pr+H1oVtZfYkxXOYdRIhkbZw55lK1gYvCC9Cfw9ETuUS2L71hhA1nvlNo9MHPADNGSejlLttFdRryr04Is8KFiIubRHL8TiFBZ3SYHXT0QCvVNpH70Bo28J2cRUiQXtY417rpVtfkVBWOAHjoG7aoJk2OHP3U+o52cTFY6fBt5dljm/lwheENDFRVDKxS/knnQu6PGzZnnovXhqXFQZxDMnUyM3El5EmPh5+QU5l+oP7Y0GNDmolE8nyLHGaf1O9jUFo505H4ZWL4ZrqMy15T5agWyikVc/yBgBWztNqxgJvar9RF7d3Thlm00RpjEl3jhEqvbgB4pZtMIGVP0ofjhQ5xHSd2HrD3TH7v3ajeyMzP+ogHKg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9753f1b8-3d7d-426e-e82e-08d784724837
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 10:57:46.6777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hShZBnJt7WQ6S4NWfirp0hxeoWlDSF+wYMgOSZYoSpe9QKCQU8dhfIeOeKp1HLA8Voq59ZeURxpmSNj1VdwHUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR01MB2212
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

RGVhciBVbGYsDQoNCldlIGhhdmUgYSByZXF1aXJlbWVudCB0byBzZXQgYSBzcGVjaWZpYyBtbWMn
cyBkaXNrIHNsb3QgZm9yIGEgcm9vdCBwYXRoIHdoZW4gYm9vdGluZy4gSSB0aGluayBhIHNwZWNp
ZmljICJzbG90IiBpcyBkaWZmZXJlbnQgZnJvbSBhIHNwZWNpZmljICJkZXZpY2UiLiBGb3IgZXhh
bXBsZSwgV2hlbiBhIHBsYXRmb3JtIGhhcyBmb3VyIG1tYy9zZCBzbG90cywgYW5kIHdlIGhhdmUg
dGVuIG1tYy9zZCBjYXJkcy4gV2UgbmVlZCB0byB0ZXN0IHNvbWUgY2FyZHMgZm9yIGJvb3Rpbmcg
aW4gb25lIHNsb3QsIGFuZCBvdGhlciBzbG90cyBjYW4gYmUgZmlsbGVkIHdpdGggb25lIGNhcmQg
ZWFjaCBmb3IgYW5vdGhlciB1c2UuIEFjdHVhbGx5IHRoZSBvcmRlciBvZiB0aGVzZSBmb3VyIHNs
b3RzIGlzIG5vdCBjb25zdGFudCBiZWNhdXNlIGl0IGRlcGVuZHMgb24gdGhlIG9yZGVyIG9mIHJl
Z2lzdGVyaW5nIG1tYy9zZCBkcml2ZXJzLCBhbmQgZGlmZmVyZW50IHBsYXRmb3JtcyBtYXkgaGF2
ZSBkaWZmZXJlbnQgc2l0dWF0aW9ucy4gU2xvdCBpZCBjYW4gYmUgcmVsYXRlZCB3aXRoIGJsb2Nr
IGlkLCBzbyBpdCBjYW4gYmUgcmVsYXRlZCB3aXRoIG1tYyBpZCBmb3IgY3VycmVudCBsaW51eCBr
ZXJuZWwsIHRvby4gV2UgbmVlZCB0byBzZXQgYSBzcGVjaWZpYyBzbG90IGlkIHRvIHNhdGlzZnkg
b3VyIHJlcXVpcmVtZW50Lg0KDQpJIGZpbmQgdGhlIGZvbGxvd2luZyBwYXRjaDogaHR0cHM6Ly9s
a21sLm9yZy9sa21sLzIwMTkvNi8yMC82MzgNClRoaXMgaXMgTHVib21pciBwcm92aWRlcyBoYXMg
YSBmdW5jdGlvbiB3ZSBuZWVkLiBBY3R1YWxseSBJIGhhdmUgYSBwYXRjaCB3aXRoIHNpbWlsYXIg
ZnVuY3Rpb24gd2l0aG91dCBtbWMgYWxpYXMgYW5kIGp1c3Qgc2V0ICJtbWMtaWQiIGluIGRldmlj
ZSB0cmVlLCBidXQgSSB0aGluayBMdWJvbWlyJ3MgaXMgYmV0dGVyIHRoYW4gbXlzZWxmLg0KDQpT
b21lb25lIHRoaW5rIHdoeSBub3QgdXNlICJMQUJFTCIgb3IgIlVVSUQiIGZvciBpbml0cmFtZnMs
IG9yIHVzZSAiUEFSVExBQkVMIiBvciAiUEFSVFVVSUQiIGZvciB1LWJvb3Q/IEkgdGhpbmsgdGhl
eSBhc3NpZ24gYSBzcGVjaWZpYyBudW1iZXJzL2NoYXJhY3RlcnMgZm9yIG1tYy9zZCBjYXJkcywg
bm90IGZvciBtbWMvc2Qgc2xvdHMuIEJlc2lkZXMsIGlmIEkgc2V0IHRoZSBzYW1lICJMQUJFTCIg
b3IgIlBBUlRMQUJFTCIgaW4gc29tZSBtbWMvc2QgY2FyZCwgSSB0aGluayBrZXJuZWwgd2lsbCBi
ZSBjb25mdXNlZCBob3cgdG8gZmluZCBhIGRlc2lyZWQgbW1jL3NkIGNhcmQuDQoNClNvIGtpbmRs
eSByZXZpZXcgdGhlIHBhdGNoICJtbWM6IGNvcmU6IHRyeSB0byB1c2UgYW4gaWQgZnJvbSB0aGUg
ZGV2aWNldHJlZSAiIGlmIHlvdSBhcmUgZnJlZSwgdGhhbmtzIQ0KDQpCZXN0IHJlZ2FyZHMsDQpK
b2huc29uDQoNCk1veGEgSW5jLg0KRmwuIDQsIE5vLiAxMzUsIExhbmUgMjM1LCBCYW9xaWFvIFJk
Lg0KWGluZGlhbiBEaXN0LiwgTmV3IFRhaXBlaSBDaXR5LCBUYWl3YW4sIFIuTy5DLg0KVGVsIDog
Kzg4Ni0yLTg5MTktMTIzMCBleHQuMTA3NQ0KSm9obnNvbkNILkNoZW5AbW94YS5jb20gDQoNCg==
