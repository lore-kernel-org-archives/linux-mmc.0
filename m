Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF242C43603
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 03:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2132465E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 03:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gz7pgryn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfLPDXy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 15 Dec 2019 22:23:54 -0500
Received: from mail-eopbgr40043.outbound.protection.outlook.com ([40.107.4.43]:27726
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726437AbfLPDXy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 15 Dec 2019 22:23:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdhcrPAIqxjQf67y0++rwRoFOU3bKpMPTDqKA7yDrbtRi3BwEBqrvwS1tZnTkrjqyBOzCvjYCR0u1zrtBPaYiu3eU+SHaVEpsHbpB1KDgeuv5Y6lpuw+nnDJ8eHWjwbHEZ1v+9cH5q01NfvKVz9qo7a1q02hio02k4kDnQiYpdtoAPRVuc3VurgnwMWE1O4Di1NibLeOAQMx0Pwa0E7vqzjpKJHcP9aQG3CFnfiV37A+Ij8ZKndivyRZtR1NcB4vcidxmXSUk0lkQPbpaM1rLjUGBGxTj1znnAqrLXzvSL8DauF8Xbnk2qW+eD+zDgk2oMDDjx57RFubWY4WqKOSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzPBEOYcE+m2q19wRsoWLU229reRDh71xDLg/RPW6lA=;
 b=b7OYDxHtQuprYrGAuSHYx0c89enRDh+Z36tXx9fwTJ7YMqH0qr0aDjPq4Zh2T8O32EfCuQCdZzMW5G1dh17lKRUgFb/Egc6HfSh8eqj3IE5Bu07FWt2VW+p6vDq2u34rwIoz3/EtlFuV01j6q5mbU+VgtyKlcdMcWQJ+cNQ9NNEoPCUgEtCBQ/CEP98SjLn2/QZmAJwgHvv7sT9cATYV6a0t4a27AUk22WvpJx7Cu0uTUqFeK2cEARlsAAcIrW4QlGv8FFOK6qsi1OuuG7zHqPOfpRWrIj1up/wa4CGQrxfhYQDtLS/2AQ+kVBWdhrQf84yrvgDjTY5kgkpioOH9Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzPBEOYcE+m2q19wRsoWLU229reRDh71xDLg/RPW6lA=;
 b=Gz7pgrynu89/MzG0eDDqBAiBx/qNIJg2AUp6mAx0D1xSXjExB5bLyR/MCRAHB28HUZKXHwK/OTCnyIJmnnhVFruCBWImBOk9WWhkGjyZZ1Xdi9pD3fBHhSeKTOzTQbIUun7Fxln3+Xz986EyPZ4RX4EMdWYKC+O1rQGgHC1qa7s=
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com (10.169.132.138) by
 VI1PR0401MB2687.eurprd04.prod.outlook.com (10.168.65.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Mon, 16 Dec 2019 03:23:51 +0000
Received: from VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::b9ca:8e9c:39e6:8d5f]) by VI1PR0401MB2237.eurprd04.prod.outlook.com
 ([fe80::b9ca:8e9c:39e6:8d5f%7]) with mapi id 15.20.2538.019; Mon, 16 Dec 2019
 03:23:51 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: RE: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use
 esdhc_tuning_window_ptr()
Thread-Topic: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use
 esdhc_tuning_window_ptr()
Thread-Index: AQHVsMEyESrXRf8tQECe732cGmkZYae3/dUAgAQgd9A=
Date:   Mon, 16 Dec 2019 03:23:51 +0000
Message-ID: <VI1PR0401MB22375DD0CBB5F5A608E44349F8510@VI1PR0401MB2237.eurprd04.prod.outlook.com>
References: <20191212075219.48625-1-yangbo.lu@nxp.com>
 <3047c4ee-ad2f-f16f-a4d7-48a7bcd88ab9@intel.com>
In-Reply-To: <3047c4ee-ad2f-f16f-a4d7-48a7bcd88ab9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5fb70b15-ee85-4638-f85d-08d781d75f7c
x-ms-traffictypediagnostic: VI1PR0401MB2687:|VI1PR0401MB2687:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2687E2DA7936D284E8B0901CF8510@VI1PR0401MB2687.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 02530BD3AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(13464003)(199004)(189003)(76116006)(52536014)(186003)(66946007)(6506007)(966005)(33656002)(478600001)(4744005)(4326008)(8676002)(9686003)(8936002)(71200400001)(81166006)(81156014)(7696005)(53546011)(55016002)(86362001)(110136005)(54906003)(316002)(6636002)(5660300002)(64756008)(26005)(66446008)(66556008)(66476007)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0401MB2687;H:VI1PR0401MB2237.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StU7Suhk+r+kOJYtasz3SkaU4NBY1xEknI0SN5rZ8yf7eWby7Lzdypop4DAkMMMIJWVlMykc1t9kmeX0imBW2yo2tK1WNn3iPfSq1OJI9lnEZWgdO6bdAl19xuDLaXgkXElUIAj8IO3ywgwoxyBwuRcUMe1gnF3uUvyMbAxpZydL9hIaDNhg12yu1VBQ6DS1WAMsp0x7VKuoAGeTVYNlEE/dj5qPKZqCwRz5nSW3JrHBBJhtbukXFPV8B/SDYatkxdYbGGxTfOJ3A62ZiI1hS8uWOhr5Lg7PI1Cba+GVloLOYz1CEGK98sUfo2jBh5N6O8zx0Llq6djGvi6MhB7Kj/bEWQXxOhxYVPgZLEeRqvQ2WDNJL/8pPJ3qea1OeyWxSgQQv5idbhyb0QnFrs3g0eRUAlPZyYNOsA7UnjAvetVu2HPioyGKU+h+kFe9EQyCE/1BjuIJXpi5yZ84ZQiLKQn8ap/352ire9XORYFgHqSnxIFHWGc6ASrAWav6djz/zI4TDGADi7jmk1ObhMS1q4C17CIetmvFHPHE1vcSvrg=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb70b15-ee85-4638-f85d-08d781d75f7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2019 03:23:51.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea9P6KhivYLfP4o2zytVM/KBqFKmzA0X3m98I8JdGq7+qCgqL60Z+ATOa8URAXmRvHbwQK893xYv17mDm/32lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2687
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

U29ycnkgQWRyaWFuLiBJIG1pc3NlZCB0aGF0IGVtYWlsLiBJIHNlbnQgb3V0IGEgZml4IHVwIHBh
dGNoIGZvciByZXZpZXdpbmcuDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzEx
MjkzMzM3Lw0KDQpUaGFua3MhDQoNCkJlc3QgcmVnYXJkcywNCllhbmdibyBMdQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5l
bC5vcmcgPGxpbnV4LW1tYy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+DQo+IE9uIEJlaGFsZiBPZiBB
ZHJpYW4gSHVudGVyDQo+IFNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgMTMsIDIwMTkgODoyMCBQTQ0K
PiBUbzogWS5iLiBMdSA8eWFuZ2JvLmx1QG54cC5jb20+OyBZaW5ibyBaaHUgPHlpbmJvLnpodUBu
eHAuY29tPg0KPiBDYzogbGludXgtbW1jQHZnZXIua2VybmVsLm9yZzsgVWxmIEhhbnNzb24gPHVs
Zi5oYW5zc29uQGxpbmFyby5vcmc+Ow0KPiBSYXNtdXMgVmlsbGVtb2VzIDxsaW51eEByYXNtdXN2
aWxsZW1vZXMuZGs+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBtbWM6IHNkaGNpLW9mLWVz
ZGhjOiBjb252ZXJ0IHRvIHVzZQ0KPiBlc2RoY190dW5pbmdfd2luZG93X3B0cigpDQo+IA0KPiBJ
cyB0aGVyZSBhIGZpeCBmb3IgYmVsb3cgY29taW5nPw0KPiANCj4gCWh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvOGFmZDBmNTMtZWJhOC1lMDAwLWQ4Y2MtYjQ2NGU2NTg1MGMzQHJhc211c3Zp
bGxlbW9lcy5kay8NCg==
