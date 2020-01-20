Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13617C2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA9C208E4
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 10:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rEYjRGwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgATKLK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:11:10 -0500
Received: from mail-eopbgr70054.outbound.protection.outlook.com ([40.107.7.54]:19147
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgATKLJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Jan 2020 05:11:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nI/pH5y4Bg6hHYnzhIk5gtZdt3u/5ersdM6zPkgvN21ld4z34KPpbq9+i1yKRpO2tMbDrE/0ep82+wCsSDzrBYcfWa+70/xSNVrk1Z4A+Jry5/SElzMQO+Ngg12eyYW8bK8PCr/rxldOvhLxD92HlqNoluR8q8dwe+7WrFdO6vuFcza3kKn15mnUw8m/u2UlxDC9B9wYy519iVPRsUNSLblto0Di8mkJDlIKB2fp1kNs97fHgwLV6z/CI4s0t7y60+wfxcqWkx9wze+oXlwUFIfv6wpgpHLg+MX6BQWwz7COGSTAcdBjvhZYaH2Kp4Fd2jiysy557Tu8TqcgO8GDuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FE0mHClDDXK/Edo90ffTC5XXWr//G2NHzq0wk7jljs=;
 b=hOBaOMB1X2vpP7qbilfm54g4uuXgoHSZwNBAuiecN4wyeuubAaHMBgEkSOMFcDmNTRIEM37OrjLNIcnOkk+mN25oIn7vzf1njlCF1mmE5VQ2q6UJh/NAyNC2zjPDbFRHH/91qW8KAWIN57Je47Puf2LQ666U3fh9TmQVyesIPUJ3tNLwVu+mZnPfDeNUmZAPFBMHymgnSCDe7tcRRcK9jgdPL3rK8tDhIotUzROcpvZrfocAOLe3bE4Cb6/xcG2Wcw62UxLiRJ37hZxSsXRX2L31AK/gboGVsGKfhOee/3vD7PWsJ0w0HMajWinMshdFpg+lpuBzCfR/OfBvXAd35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FE0mHClDDXK/Edo90ffTC5XXWr//G2NHzq0wk7jljs=;
 b=rEYjRGwChQxGL+nsjKKCVsLaC7UMpAkk76uD39ioQyc3LJpy5rvUrJJO7yu3jyO+d2oadYfZMNMILO7m6plUakQ/M6VLOThVCCIvaqK7D/EY+IhvvpS+RUAGW+vQAzwfKxZOGQCPstB1LWohnYGKu3yZ/uu+rjJaIyMB0wMium4=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (10.141.174.88) by
 AM7PR04MB7029.eurprd04.prod.outlook.com (52.135.57.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.24; Mon, 20 Jan 2020 10:09:01 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064%7]) with mapi id 15.20.2644.024; Mon, 20 Jan 2020
 10:09:01 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
CC:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Index: AQHVcTBOpWluYDvmwES2/jOGUAGSvaf0DJSw
Date:   Mon, 20 Jan 2020 10:09:00 +0000
Message-ID: <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7090e67f-77e9-43ba-158f-08d79d90c5a1
x-ms-traffictypediagnostic: AM7PR04MB7029:
x-microsoft-antispam-prvs: <AM7PR04MB7029BA427B5213A074E18EC8F8320@AM7PR04MB7029.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(39860400002)(136003)(376002)(189003)(199004)(316002)(26005)(54906003)(2906002)(478600001)(81166006)(81156014)(4326008)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(8936002)(8676002)(53546011)(86362001)(6506007)(71200400001)(52536014)(5660300002)(33656002)(186003)(7696005)(55016002)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB7029;H:AM7PR04MB6885.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35LIg5JDY+G4a9vJWSK5KmipqtoI09Z13doV5ddEnYIcfn6paCSMMFZu4GqYWfYauw2V+mnA7BOnuMHQ4VMOac0mYxOVLyBt/TYF8xFDRnIFx/qiEu0dGDUs5UjSottJM146vpmiV/ZE+LvJis3XXsHUfOiv0xC+Q/+me6GFNXy3b7ZsatIV6+HMtbCfAejbOxpsInHhnF/YcQH3FsL4pBSPSBtonly6X1shjvIB8z8VTnlWhNfAHkia8cezl5XHIE7b9W2GXSjwuao6BWI2ulxeOFyu4/hF2tCgFIHidoxiIFBQYxug2KkAHXBh7rZhh7d0hKCEY+PS8UuEpPsZBDJ6mnCUBVNBWyO2DGFi+zSGxCbA0CtVPhssLygL5fMytsXmiLqutieHVYg7dxfpEyYrC4DHipeA1l3ECEEpe0OuaKJBONV7Si9zJIlPhD8d
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7090e67f-77e9-43ba-158f-08d79d90c5a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 10:09:01.2206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b72xD+BJv8720U3YHXNgW2l4JLon5ue6427Db+VWRqI6QxQ4w0hHvc4l20gyyxJaJwJKsR2R+gsE/WTZzzzZvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7029
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KUmVjZW50bHkgSSBnb3QgZVNESEMgQURNQSBpc3N1ZSBvbiBQb3dlclBD
IFQyMDgwIHBsYXRmb3JtLiBBZnRlciBjaGVja2luZywgdGhlIGlzc3VlIGlzIHJlbGF0ZWQgdG8g
dGhpcyBwYXRjaC4NClRoaXMgcGF0Y2ggd2FzIHRvIG1ha2UgZVNESEMgRE1BIFNOT09QIGJpdCBz
ZXQgcGVyIGRtYS1jb2hlcmVudC4gVGhhdCByZXNvbHZlZCBpc3N1ZSBvbiBMWDIxNjBBIEFSTTY0
IHBsYXRmb3JtLg0KSG93ZXZlciBvbiBUMjA4MCwgd2UgYXJlIGZhY2luZyBzaW1pbGFyIGlzc3Vl
IGFnYWluLiBJdCBkaWRuJ3QgaGF2ZSBkbWEtY29oZXJlbnQgaW4gZHRzLg0KQWRkaW5nIGRtYS1j
b2hlcmVudCBpbiBkdHMsIG9yIHJldmVydGluZyB0aGUgcGF0Y2ggY291bGQgcmVzb2x2ZSB0aGUg
cHJvYmxlbS4NCg0KV291bGQgeW91IHBsZWFzZSBoZWxwIHRvIGhhdmUgYSBsb29rIGF0IGl0IHRv
bz8gVGhhbmtzOikNCg0KbW1jMDogQURNQSBlcnJvcjogMHgwMjAwMDAwMA0KbW1jMDogc2RoY2k6
ID09PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBEVU1QID09PT09PT09PT09DQptbWMwOiBzZGhj
aTogU3lzIGFkZHI6ICAweDAwMDAwMDAwIHwgVmVyc2lvbjogIDB4MDAwMDIwMDINCm1tYzA6IHNk
aGNpOiBCbGsgc2l6ZTogIDB4MDAwMDAwMDggfCBCbGsgY250OiAgMHgwMDAwMDAwMQ0KbW1jMDog
c2RoY2k6IEFyZ3VtZW50OiAgMHgwMDAwMDAwMCB8IFRybiBtb2RlOiAweDAwMDAwMDEzDQpORVQ6
IFJlZ2lzdGVyZWQgcHJvdG9jb2wgZmFtaWx5IDEwDQptbWMwOiBzZGhjaTogUHJlc2VudDogICAw
eDAxZmQwMjBhIHwgSG9zdCBjdGw6IDB4MDAwMDAwMzgNCm1tYzA6IHNkaGNpOiBQb3dlcjogICAg
IDB4MDAwMDAwMDMgfCBCbGsgZ2FwOiAgMHgwMDAwMDAwMA0KbW1jMDogc2RoY2k6IFdha2UtdXA6
ICAgMHgwMDAwMDAwMCB8IENsb2NrOiAgICAweDAwMDAyMGI4DQptbWMwOiBzZGhjaTogVGltZW91
dDogICAweDAwMDAwMDAzIHwgSW50IHN0YXQ6IDB4MDAwMDAwMDENCm1tYzA6IHNkaGNpOiBJbnQg
ZW5hYjogIDB4MDM3ZjEwMGYgfCBTaWcgZW5hYjogMHgwMzdmMTAwYg0KbW1jMDogc2RoY2k6IEFD
bWQgc3RhdDogMHgwMDAwMDAwMCB8IFNsb3QgaW50OiAweDAwMDAyMDAyDQptbWMwOiBzZGhjaTog
Q2FwczogICAgICAweDM0ZmEwMDAwIHwgQ2Fwc18xOiAgIDB4MDAwMGFmMDANCm1tYzA6IHNkaGNp
OiBDbWQ6ICAgICAgIDB4MDAwMDMzM2EgfCBNYXggY3VycjogMHgwMDAwMDAwMA0KbW1jMDogc2Ro
Y2k6IFJlc3BbMF06ICAgMHgwMDAwMDkyMCB8IFJlc3BbMV06ICAweDAwM2IzNzMzDQptbWMwOiBz
ZGhjaTogUmVzcFsyXTogICAweDMyNWI1OTAwIHwgUmVzcFszXTogIDB4M2Y0MDBlMDANCm1tYzA6
IHNkaGNpOiBIb3N0IGN0bDI6IDB4MDAwMDAwMDANCm1tYzA6IHNkaGNpOiBBRE1BIEVycjogIDB4
MDAwMDAwMGQgfCBBRE1BIFB0cjogMHgwMDAwMDAwMGYzNWFkMjBjDQptbWMwOiBzZGhjaTogPT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCm1tYzA6IHNkaGNpOiBm
MzVhZDIwMDogRE1BIDB4MDAwMDAwMDBmMzU4NzcxMCwgTEVOIDB4MDAwOCwgQXR0cj0weDIzDQpt
bWMwOiBlcnJvciAtNSB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQNCg0KQmVzdCByZWdhcmRz
LA0KWWFuZ2JvIEx1DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBS
dXNzZWxsIEtpbmcgPHJta0Bhcm1saW51eC5vcmcudWs+IE9uIEJlaGFsZiBPZiBSdXNzZWxsIEtp
bmcNCj4gU2VudDogU3VuZGF5LCBTZXB0ZW1iZXIgMjIsIDIwMTkgNjoyNyBQTQ0KPiBUbzogUm9i
aW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IGRhbm4gZnJhemllcg0KPiA8ZGFubi5m
cmF6aWVyQGNhbm9uaWNhbC5jb20+OyBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT47
IE5pY29saW4NCj4gQ2hlbiA8bmljb2xlb3RzdWthQGdtYWlsLmNvbT47IFkuYi4gTHUgPHlhbmdi
by5sdUBueHAuY29tPjsgQ2hyaXN0b3BoDQo+IEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IENjOiBB
ZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47IFVsZiBIYW5zc29uDQo+IDx1
bGYuaGFuc3NvbkBsaW5hcm8ub3JnPjsgbGludXgtbW1jQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBbUEFUQ0ggMi8zXSBtbWM6IHNkaGNpLW9mLWVzZGhjOiBzZXQgRE1BIHNub29waW5nIGJh
c2VkIG9uIERNQQ0KPiBjb2hlcmVuY2UNCj4gDQo+IFdlIG11c3Qgbm90IHVuY29uZGl0aW9uYWxs
eSBzZXQgdGhlIERNQSBzbm9vcCBiaXQ7IGlmIHRoZSBETUEgQVBJIGlzDQo+IGFzc3VtaW5nIHRo
YXQgdGhlIGRldmljZSBpcyBub3QgRE1BIGNvaGVyZW50LCBhbmQgdGhlIGRldmljZSBzbm9vcHMg
dGhlDQo+IENQVSBjYWNoZXMsIHRoZSBkZXZpY2UgY2FuIHNlZSBzdGFsZSBjYWNoZSBsaW5lcyBi
cm91Z2h0IGluIGJ5DQo+IHNwZWN1bGF0aXZlIHByZWZldGNoLg0KPiANCj4gVGhpcyBsZWFkcyB0
byB0aGUgZGV2aWNlIHNlZWluZyBzdGFsZSBkYXRhLCBwb3RlbnRpYWxseSByZXN1bHRpbmcgaW4N
Cj4gY29ycnVwdGVkIGRhdGEgdHJhbnNmZXJzLiAgQ29tbW9ubHksIHRoaXMgcmVzdWx0cyBpbiBh
IGRlc2NyaXB0b3IgZmV0Y2gNCj4gZXJyb3Igc3VjaCBhczoNCj4gDQo+IG1tYzA6IEFETUEgZXJy
b3INCj4gbW1jMDogc2RoY2k6ID09PT09PT09PT09PSBTREhDSSBSRUdJU1RFUiBEVU1QID09PT09
PT09PT09DQo+IG1tYzA6IHNkaGNpOiBTeXMgYWRkcjogIDB4MDAwMDAwMDAgfCBWZXJzaW9uOiAg
MHgwMDAwMjIwMg0KPiBtbWMwOiBzZGhjaTogQmxrIHNpemU6ICAweDAwMDAwMDA4IHwgQmxrIGNu
dDogIDB4MDAwMDAwMDENCj4gbW1jMDogc2RoY2k6IEFyZ3VtZW50OiAgMHgwMDAwMDAwMCB8IFRy
biBtb2RlOiAweDAwMDAwMDEzDQo+IG1tYzA6IHNkaGNpOiBQcmVzZW50OiAgIDB4MDFmNTAwMDgg
fCBIb3N0IGN0bDogMHgwMDAwMDAzOA0KPiBtbWMwOiBzZGhjaTogUG93ZXI6ICAgICAweDAwMDAw
MDAzIHwgQmxrIGdhcDogIDB4MDAwMDAwMDANCj4gbW1jMDogc2RoY2k6IFdha2UtdXA6ICAgMHgw
MDAwMDAwMCB8IENsb2NrOiAgICAweDAwMDA0MGQ4DQo+IG1tYzA6IHNkaGNpOiBUaW1lb3V0OiAg
IDB4MDAwMDAwMDMgfCBJbnQgc3RhdDogMHgwMDAwMDAwMQ0KPiBtbWMwOiBzZGhjaTogSW50IGVu
YWI6ICAweDAzN2YxMDhmIHwgU2lnIGVuYWI6IDB4MDM3ZjEwOGINCj4gbW1jMDogc2RoY2k6IEFD
bWQgc3RhdDogMHgwMDAwMDAwMCB8IFNsb3QgaW50OiAweDAwMDAyMjAyDQo+IG1tYzA6IHNkaGNp
OiBDYXBzOiAgICAgIDB4MzVmYTAwMDAgfCBDYXBzXzE6ICAgMHgwMDAwYWYwMA0KPiBtbWMwOiBz
ZGhjaTogQ21kOiAgICAgICAweDAwMDAzMzNhIHwgTWF4IGN1cnI6IDB4MDAwMDAwMDANCj4gbW1j
MDogc2RoY2k6IFJlc3BbMF06ICAgMHgwMDAwMDkyMCB8IFJlc3BbMV06ICAweDAwMWQ4YTMzDQo+
IG1tYzA6IHNkaGNpOiBSZXNwWzJdOiAgIDB4MzI1YjU5MDAgfCBSZXNwWzNdOiAgMHgzZjQwMGUw
MA0KPiBtbWMwOiBzZGhjaTogSG9zdCBjdGwyOiAweDAwMDAwMDAwDQo+IG1tYzA6IHNkaGNpOiBB
RE1BIEVycjogIDB4MDAwMDAwMDkgfCBBRE1BIFB0cjogMHgwMDAwMDAyMzZkNDM4MjBjDQo+IG1t
YzA6IHNkaGNpOiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0K
PiBtbWMwOiBlcnJvciAtNSB3aGlsc3QgaW5pdGlhbGlzaW5nIFNEIGNhcmQNCj4gDQo+IGJ1dCBj
YW4gbGVhZCB0byBvdGhlciBlcnJvcnMsIGFuZCBwb3RlbnRpYWxseSBkaXJlY3QgdGhlIFNESENJ
DQo+IGNvbnRyb2xsZXIgdG8gcmVhZC93cml0ZSBkYXRhIHRvIG90aGVyIG1lbW9yeSBsb2NhdGlv
bnMgKGUuZy4gaWYgYSB2YWxpZA0KPiBkZXNjcmlwdG9yIGlzIHZpc2libGUgdG8gdGhlIGRldmlj
ZSBpbiBhIHN0YWxlIGNhY2hlIGxpbmUuKQ0KPiANCj4gRml4IHRoaXMgYnkgZW5zdXJpbmcgdGhh
dCB0aGUgRE1BIHNub29wIGJpdCBjb3JyZXNwb25kcyB3aXRoIHRoZQ0KPiBiZWhhdmlvdXIgb2Yg
dGhlIERNQSBBUEkuICBTaW5jZSB0aGUgZHJpdmVyIGN1cnJlbnRseSBvbmx5IHN1cHBvcnRzIERU
LA0KPiB1c2Ugb2ZfZG1hX2lzX2NvaGVyZW50KCkuICBOb3RlIHRoYXQgZGV2aWNlX2dldF9kbWFf
YXR0cigpIGNhbiBub3QgYmUNCj4gdXNlZCBhcyB0aGF0IHJpc2tzIHJlLWludHJvZHVjaW5nIHRo
aXMgYnVnIGlmL3doZW4gdGhlIGRyaXZlciBpcw0KPiBjb252ZXJ0ZWQgdG8gQUNQSS4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFJ1c3NlbGwgS2luZyA8cm1rK2tlcm5lbEBhcm1saW51eC5vcmcudWs+
DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jIHwgNyArKysrKyst
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+IGIvZHJp
dmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+IGluZGV4IDRkZDQzYjFhZGYyYy4uNzRk
ZTVlOGM0NWM4IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhj
LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1lc2RoYy5jDQo+IEBAIC00OTUs
NyArNDk1LDEyIEBAIHN0YXRpYyBpbnQgZXNkaGNfb2ZfZW5hYmxlX2RtYShzdHJ1Y3Qgc2RoY2lf
aG9zdA0KPiAqaG9zdCkNCj4gIAkJZG1hX3NldF9tYXNrX2FuZF9jb2hlcmVudChkZXYsIERNQV9C
SVRfTUFTSyg0MCkpOw0KPiANCj4gIAl2YWx1ZSA9IHNkaGNpX3JlYWRsKGhvc3QsIEVTREhDX0RN
QV9TWVNDVEwpOw0KPiAtCXZhbHVlIHw9IEVTREhDX0RNQV9TTk9PUDsNCj4gKw0KPiArCWlmIChv
Zl9kbWFfaXNfY29oZXJlbnQoZGV2LT5vZl9ub2RlKSkNCj4gKwkJdmFsdWUgfD0gRVNESENfRE1B
X1NOT09QOw0KPiArCWVsc2UNCj4gKwkJdmFsdWUgJj0gfkVTREhDX0RNQV9TTk9PUDsNCj4gKw0K
PiAgCXNkaGNpX3dyaXRlbChob3N0LCB2YWx1ZSwgRVNESENfRE1BX1NZU0NUTCk7DQo+ICAJcmV0
dXJuIDA7DQo+ICB9DQo+IC0tDQo+IDIuNy40DQoNCg==
