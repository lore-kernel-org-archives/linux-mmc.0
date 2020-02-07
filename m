Return-Path: <SRS0=5kc2=33=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09601C35247
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D158A21D7D
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Feb 2020 02:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="erVY62rR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGCL4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:11:56 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:47182
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727003AbgBGCL4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 6 Feb 2020 21:11:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJnLJjqKzqQ8EuYFK5W31CqJ/7MFiqRTP/GsIAhrHxvVBJreDT8wX4GxfUH3pIZExz8Lww9rPFRY8Hjh1yaExg3nEDrwgqQ8RM7PGmQjtkbevoBSpuwltEBDnpc/pbwW2/6Dfx07n9vKMOgY6tyYXclFEYQCYbodPiuEbUjaS2BqMcrE8Sz5SSSFT1LDkWT+YyJBXlwXTGrdqBRi0CggDV57a5qZAIGDIppqPpgdrLnCJ92OvZFzu0gVsWbxAJClN/CJKbCejov479oXz4bMrRKppgNSMWK2ygoXgkP+Q5mBtNv3+ttZ+lY3XAnxYOM3K4kC7cN21j+gl5K3r+s7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRoQKM+zQwx2T1DZ4pK/ep9GQ8HoWsrvb/VqDL8g3z0=;
 b=G8PTpaXmW9yM6o5cgNPEus5pVxmQvydUr/PQd9Q2oSTSiiRvJB+T6cnuCxBDT7yVvBE2YbNzHR67cBpQq5QB1zN46uvpEfwAsr19uZfAcynllXBAiLTvFx/MqZ1PK0qru8XnaJKafpspQHWTHi0wsPDtjbsLHThLsjKKpYkPgZA4/k6JTpDa7JOou3d3s0PvKQ+yKGc9wKVIog4mnzuIXOlBgKG+pNgGG5vCwopRPAOLXw7Yk8IsQwd6HAACLAOhN+6mFCDlhG7eBK85cgm6aHsczsOFIOWDW13NtXiq1L183muzQnWq1jJwuHy89mW2UgiFVzFZx6j/9cx68ApJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRoQKM+zQwx2T1DZ4pK/ep9GQ8HoWsrvb/VqDL8g3z0=;
 b=erVY62rRESvDzHPjCEOzpMoyLiLPP547D5eiY6ohCABuumvlT1X32uvv+Z050u07h8jWMnwrZ8IX+dyaBBQLjrFjOYKkLqiJBYi73rDPMVwCCamU1QLWY1Vnnc1eYj8/ZtMgAfCp9X3cyhrziiHzzN8h2aflfj7MwEEmHAw+Klo=
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com (20.177.52.24) by
 VI1PR04MB6256.eurprd04.prod.outlook.com (20.179.25.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 02:11:51 +0000
Received: from VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682]) by VI1PR04MB5040.eurprd04.prod.outlook.com
 ([fe80::d0c7:37d1:d835:a682%7]) with mapi id 15.20.2707.020; Fri, 7 Feb 2020
 02:11:51 +0000
From:   BOUGH CHEN <haibo.chen@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>,
        =?utf-8?B?R3VpZG8gR8O8bnRoZXI=?= <agx@sigxcpu.org>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: sdhci timeout on imx8mq
Thread-Topic: sdhci timeout on imx8mq
Thread-Index: AQHV2sbvCEHvj/D/X0ygL9UYOXYdc6gMVz+AgABAnwCAAmog4A==
Date:   Fri, 7 Feb 2020 02:11:51 +0000
Message-ID: <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org>
 <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
In-Reply-To: <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haibo.chen@nxp.com; 
x-originating-ip: [223.106.9.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a6564e8-1533-4941-289d-08d7ab731896
x-ms-traffictypediagnostic: VI1PR04MB6256:|VI1PR04MB6256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB6256B601B307F708A825C29A901C0@VI1PR04MB6256.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(199004)(189003)(52536014)(9686003)(55016002)(33656002)(7696005)(5660300002)(53546011)(4744005)(66574012)(6506007)(478600001)(66556008)(86362001)(76116006)(66446008)(66946007)(64756008)(66476007)(316002)(54906003)(110136005)(81156014)(8676002)(26005)(81166006)(186003)(71200400001)(4326008)(2906002)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6256;H:VI1PR04MB5040.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kEuNNA0QqiQuOT18bwF9baKgDf1Vxp236AtP7kx41qgx3ZjbqIb9Xors6TMnQU83OodIOXyVqcAu3RbP3GHHzpzEdaSixOk639Zet8OW0EHnxQbfAi9KjKZVT35LJ+9FQA1oHqcQ4fMu5xxUDWhbfPB16f5f4A0I7DpaGLNCJ7UofBzoCyVSeNK9neZczoRecN6dD7s5k7t94/NDVKSxcdwHG4RUR9VAnqjCbyToo3lpqNdBv/eeqpdNM/j0gFWFyWsCbLGaMmKeMNbEAcDklbPJCT0qYs5rOQt7wX5SMCmksG6z1QMTR1Vlr42Y7Y6uOpk40M8Z1dgMfWc3ogCddHQgdgbKJKgxm8w+uqNM/SHL2fmZ+knTBFM2nd2Y1VTajhF8mfbCbyZ8erF38aLjiPYh8IzCXCrQgL10bZKzeTOq6eU1vP8+t8XoN2WpStkSf7at9OL0c+zx/2xGjXcCulRn/lLZTKSei/+QcpeTDY0WmLLIvltjf40rIMG1TMvw
x-ms-exchange-antispam-messagedata: pv1hOqXAW3xy3WQMy14UUvok9sYwhrTmqvv8p23fZXL9QasfXkjdOTFk+rUsjTVYPO5d1gUm4J/GfpKCmxNEA/Tm7ulwo4oKGUcwGHUKSej/3IUpf0xTMAbqgGighI49K3BiyUmFJ3sRorrJqGNtww==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a6564e8-1533-4941-289d-08d7ab731896
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 02:11:51.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 379HVqkz8Mr0mKaU06x8CR/MwVCQ1dka79IrWn+7e/cfrl9RACYlhitlX3W2ONrCfCMsKhuAM1nJ7+1nK7ANHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6256
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyMOW5tDLmnIg15pelIDIxOjE4DQo+IFRvOiBH
dWlkbyBHw7xudGhlciA8YWd4QHNpZ3hjcHUub3JnPg0KPiBDYzogVWxmIEhhbnNzb24gPHVsZi5o
YW5zc29uQGxpbmFyby5vcmc+OyBBZHJpYW4gSHVudGVyDQo+IDxhZHJpYW4uaHVudGVyQGludGVs
LmNvbT47IGxpbnV4LW1tYyA8bGludXgtbW1jQHZnZXIua2VybmVsLm9yZz47DQo+IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+OyBTYXNjaGEgSGF1ZXIgPGtlcm5lbEBwZW5ndXRyb25p
eC5kZT47DQo+IG1vZGVyYXRlZCBsaXN0OkFSTS9GUkVFU0NBTEUgSU1YIC8gTVhDIEFSTSBBUkNI
SVRFQ1RVUkUNCj4gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz4NCj4gU3Vi
amVjdDogUmU6IHNkaGNpIHRpbWVvdXQgb24gaW14OG1xDQo+IA0KPiBIaSBHdWlkbywNCj4gDQo+
IE9uIFdlZCwgRmViIDUsIDIwMjAgYXQgNjoyNiBBTSBHdWlkbyBHw7xudGhlciA8YWd4QHNpZ3hj
cHUub3JnPiB3cm90ZToNCj4gDQo+ID4gSSd2ZSBzZWVuIHRoZSBzYW1lIG9jY2FzaW9uYWxseSBv
biB0aGUgbGlicmVtIDUgd2l0aCBvbGRlciBsaW51eC1uZXh0DQo+ID4gYXMgd2VsbC4gRG8geW91
IGhhdmUgYSBnb29kIHJlcHJvZHVjZXI/DQo+IA0KPiBZZXMsIHdpdGggbGludXgtbmV4dCBJIGFs
d2F5cyBnZXQgdGhpcyB0aW1lb3V0IGJ5IGp1c3QgYm9vdGluZyB0aGUga2VybmVsIGFuZA0KPiB3
YWl0aW5nIDEgb3IgMiBtaW51dGVzIHdpdGhvdXQgYW55IGFjdGl2aXR5Lg0KDQpJIHdpbGwgcmVz
ZXJ2ZSBzb21lIHRpbWUgbmV4dCB3ZWVrIHRvIGNoZWNrIHRoaXMgaXNzdWUuDQoNCkJvdWdoIENo
ZW4NCj4gDQo+IFJlZ2FyZHMsDQo+IA0KPiBGYWJpbyBFc3RldmFtDQo=
