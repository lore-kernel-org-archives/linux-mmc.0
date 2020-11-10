Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D49C388F7
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 07:15:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC43D20731
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 07:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qtrpHA70"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgKJHPY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 02:15:24 -0500
Received: from mail-am6eur05on2046.outbound.protection.outlook.com ([40.107.22.46]:9787
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726690AbgKJHPX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Nov 2020 02:15:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wct3E32SizmPDtHDVuFkM3YakUXysvMoFHkeIL9TPDp60x4JHPSmz/wzZQAMX3xvZbIt+eWQ+phiF07HkTuy6CyAWtZMwkAb4eAa/5sJdMIlw/WsUOB3K6fNiynv3sHO3hfkLQLfCzGg25JYeMPAUvvHpR6xTVTrMCtACTjosGtYnWW+S6zw0YHMUSuUEu8wu6kRe9WuCRxLKo1+VyWsl8CLxN6RHHoVfuPDsh+OQxKat1fISvn0eluhF+8a/nRcWU0rq8eH4q+NDeBxeRZy4/78/tbDSZplDW2uCaIZRB+XmAHRXwVdaeG1Nbd7PJCvD/gUL/1kLxmht86z1pwqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vLvupRGxmSiC21HiUP2cvlwh0MaamTjcH3SC1NzGE8=;
 b=fQxvlGma4xkKDoAEiFY4bdpXNkNhpYQrRqm7WfX0HriKayunL5QtDeFRfXx+ZVuMFUiW4dS88riMrp6c1uZ0y8ktrw+l75EMD7UGo56O8/2SNIq7eBjBTlbiHsj4tDcZ0ijyMUQlt6cy4rvrAbKqjxFigf3DzGNlkW9G1rix6uVpU+tJqkmoaM6Ns0iJwjoYq6FdxX47CsGiBc9UgyQ4ythMWatQA2IdIeYCPgURMK4DX6s+3rxuBZI98NPvuAT4ycKgyFgeCu8wdU31EbB9pNfc+faRlojPmh/0JAHYc8nb3ibpaTSv8CjwHhIJ+z/n3c6hbph7WQkeS05Htteuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vLvupRGxmSiC21HiUP2cvlwh0MaamTjcH3SC1NzGE8=;
 b=qtrpHA70DTZgmb3pCDI2dwKekC/AnuEHQmG4N6/+Bi5K/YjWBeqE1P/5a00HnWbovYSeCFTH5LTOjqfFpEVLVPEu5F6A7h0/n/QaZg7jSZnue/Aw+6zR03rpYH2hJQbiJq5zTGn6GeER+gSB4wJjPkIeEUGV/A2FA+E7BNYXfSE=
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com (2603:10a6:803:5a::22)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 07:15:18 +0000
Received: from VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93]) by VI1PR04MB5294.eurprd04.prod.outlook.com
 ([fe80::55e4:aa36:fd88:3b93%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 07:15:18 +0000
From:   Bough Chen <haibo.chen@nxp.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ben.chuang@genesyslogic.com.tw" <ben.chuang@genesyslogic.com.tw>,
        "greg.tu@genesyslogic.com.tw" <greg.tu@genesyslogic.com.tw>
Subject: RE: [RFC PATCH v3.1 03/27] mmc: core: UHS-II support, skip
 set_chip_select()
Thread-Topic: [RFC PATCH v3.1 03/27] mmc: core: UHS-II support, skip
 set_chip_select()
Thread-Index: AQHWs+R4+Bnq1jR/7kGYSK6Kirgr8KnA+iKQ
Date:   Tue, 10 Nov 2020 07:15:18 +0000
Message-ID: <VI1PR04MB5294A41442194AC8DCC82A6690E90@VI1PR04MB5294.eurprd04.prod.outlook.com>
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-4-takahiro.akashi@linaro.org>
In-Reply-To: <20201106022726.19831-4-takahiro.akashi@linaro.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaac11c8-d9aa-44e2-3d18-08d885486153
x-ms-traffictypediagnostic: VE1PR04MB7408:
x-microsoft-antispam-prvs: <VE1PR04MB7408ECE12D29D32F8FA01CE290E90@VE1PR04MB7408.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XXDWN3NP9Mytnxyv4BUeC7c7FpknHzYXIJ61X5q96Uwt6US1T5UxnO3h4CzQWd3cPmqOEhTmre7NBRNKUliDHuzOBR9yYAzW9EkryZva/f0GUmSj7G1aWZzeFpsoIeMK2C+w25Uyxc/+KGIR+gvGyFPApNc9XH0EUdDFeNTF4BY2800KPgUkVuVy5BVdG++EtcrH3HKVaOvoPuIu73Hszld9g1aKqszTXO5BgUchKRwxBGeZl/bV40o4PHGR8a/bV4H3QBnpe0ERjjHs3qcxgHFD10SuarZB99Dg9C/ont5q0qPdKpFryF5yHvs0FrD2pOpzUgS+VHgoWkMPe+zHWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5294.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(76116006)(66476007)(5660300002)(9686003)(55016002)(478600001)(64756008)(52536014)(186003)(66946007)(66556008)(66446008)(26005)(33656002)(53546011)(71200400001)(83380400001)(7696005)(6506007)(2906002)(8936002)(86362001)(8676002)(316002)(54906003)(4326008)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: lIidtZKgVARINotFWR/ZVWPogx7tnjTmy6XZRvECUTQGPvmH47Ls7lCw0M6FPtggGc6qSsSr4lQjBQ5YaiaO4mGFnszNs6JN0EGfLuFWLkR28U3bsj5xmb0Nqhn9zSYODHXTdS8OCpoTcB6GN+/wVzVeaXCrY1t+oLVpJEEdLMvcWtxPtXnMexyJjTqWn0+fh1Zv06BUp10Z5pkFRMX2yG5Ta45txJLur0WVr9YlIZM/KvwXrVnK4jEwr/2Y18Mg1gYaV1BfhOaRejO+AyKg+nylRVJQlpcd7w55JyrYnub3CYcjVcpclp8EnVziC1SgSz0T1TEbRH4yrI/WFW1N7mynd7WyppHSDQb4lG5kD2JzXXBXOhx5oEq7R4PEAWXAn26Pkp2VlzsdCs56F9Nuuw03vL7+zdr/sAeKjoikhmfSLSf7HSs6S2EepmY4MMvfNqgCcxfZk8LPKbwc4MFm4sBqeL9xJKqVNazZSBDlb+6REub0ECC/7I2yAubMauP91DHtO9mCrNf116GmXo6zDz70u0KcrXfojp3ErwNJcSCfLVKJHQ/JVG0hab9ddUiwgFb2DpUrVOmUqboaI0W+Fh4j5PgaoGfd/8BKlKrfBrAnYJaMq8dlfkw4hdO4sZJmODcG5ab+fukH7yaQh0bKOw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5294.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaac11c8-d9aa-44e2-3d18-08d885486153
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 07:15:18.9410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqrnX8VRg50vhvAiJvCIzBGDa57TJGvONnw/Z7cpRUb6+d8uDOlQ7ukTC7CRuH1kRfynTUDLhBhLbmQ9ZWrRwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBS0FTSEkgVGFrYWhpcm8gW21h
aWx0bzp0YWthaGlyby5ha2FzaGlAbGluYXJvLm9yZ10NCj4gU2VudDogMjAyMMTqMTHUwjbI1SAx
MDoyNw0KPiBUbzogdWxmLmhhbnNzb25AbGluYXJvLm9yZzsgYWRyaWFuLmh1bnRlckBpbnRlbC5j
b20NCj4gQ2M6IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7DQo+IGJlbi5jaHVhbmdAZ2VuZXN5c2xvZ2ljLmNvbS50dzsgZ3JlZy50dUBnZW5l
c3lzbG9naWMuY29tLnR3OyBBS0FTSEkNCj4gVGFrYWhpcm8gPHRha2FoaXJvLmFrYXNoaUBsaW5h
cm8ub3JnPg0KPiBTdWJqZWN0OiBbUkZDIFBBVENIIHYzLjEgMDMvMjddIG1tYzogY29yZTogVUhT
LUlJIHN1cHBvcnQsIHNraXANCj4gc2V0X2NoaXBfc2VsZWN0KCkNCj4gDQo+IG1tY19zZXRfY2hp
cF9zZWxlY3QoKSBzaG91bGQgYmUgY2FsbGVkIG9ubHkgaW4gVUhTLUlJIG1vZGUsIGFuZCBub3Qg
Zm9yIFVIUy1JSQ0KPiBtb2RlLg0KDQpUeXBvLCBvbmx5IGluIFVIUy1JIG1vZGUuDQoNClJlZ2Fy
ZHMNCkhhaWJvIENoZW4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJlbiBDaHVhbmcgPGJlbi5jaHVh
bmdAZ2VuZXN5c2xvZ2ljLmNvbS50dz4NCj4gU2lnbmVkLW9mZi1ieTogQUtBU0hJIFRha2FoaXJv
IDx0YWthaGlyby5ha2FzaGlAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL21tYy9jb3Jl
L2NvcmUuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5j
IGIvZHJpdmVycy9tbWMvY29yZS9jb3JlLmMgaW5kZXgNCj4gNTU0MWVkOTU2YzRkLi40ZTEyYmQ5
OGZjMDggMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+ICsrKyBiL2Ry
aXZlcnMvbW1jL2NvcmUvY29yZS5jDQo+IEBAIC04OTgsOCArODk4LDEwIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBtbWNfc2V0X2lvcyhzdHJ1Y3QgbW1jX2hvc3QNCj4gKmhvc3QpDQo+ICAgKi8NCj4g
IHZvaWQgbW1jX3NldF9jaGlwX3NlbGVjdChzdHJ1Y3QgbW1jX2hvc3QgKmhvc3QsIGludCBtb2Rl
KSAgew0KPiAtCWhvc3QtPmlvcy5jaGlwX3NlbGVjdCA9IG1vZGU7DQo+IC0JbW1jX3NldF9pb3Mo
aG9zdCk7DQo+ICsJaWYgKCEoaG9zdC0+ZmxhZ3MgJiBNTUNfVUhTMl9JTklUSUFMSVpFRCkpIHsN
Cj4gKwkJaG9zdC0+aW9zLmNoaXBfc2VsZWN0ID0gbW9kZTsNCj4gKwkJbW1jX3NldF9pb3MoaG9z
dCk7DQo+ICsJfQ0KPiAgfQ0KPiANCj4gIC8qDQo+IC0tDQo+IDIuMjguMA0KDQo=
