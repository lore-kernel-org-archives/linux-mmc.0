Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF5C43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3622080F
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 09:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="GgImHakZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfLCJF1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:05:27 -0500
Received: from mail-eopbgr740040.outbound.protection.outlook.com ([40.107.74.40]:52642
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbfLCJF1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 04:05:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpz+9/7m9MW+8P5Z/4jRdv1ZnThEC+wpIonY7hUkY7brrgaeq5uyHTudTqknwt/m/A0RFJBVgHLxIGHQBX/5V6iscKgpdA4ishdV383caLaaqrECFw36cUal2mbbpvqatVNj816/9xGNXyXGrrgnZQIMVmWORXOndsWyuA0hsxBGcK2i4LUvDIRcqRTCqQ2Wivo7K57EoIT9gUK9OC2u5NJWnX3OhAgbxUNA2ao+/gisDn62CgNDZDyXSQEjJU0TjJxgdZeXi5cmD7dsWveWWcCsY6nkUlrj6NsBwGRlxRPLjU7Td7nT2fS9GS/jlJ1poHi/PGyMVg+TCRs+fIHLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lIOeaQGbLpqXrt2JvWyUvXrDLgSWozGA9otpJH7PWc=;
 b=e7XzBqMiTmAdonSQYkZiWM3WWFUAgUteg6oGmlwipwxI4nia0CS47ks8TsZ9IdcUvbhImxUsXjutyqFCMwzN6Y5g8VVC02UZVUMzQvop3g1booppg4f7aweTN6tien3K3DFlBS3bPQUyzf+ocI7nIfdbZz4BVOcYHYf50/U2+wiSVhs7JGnFpncGhz4kB8t3rNja5m/yjWceziSdhGh+wdQUUm8uO0Cd7S0v94TAY5XtGA2fKqh5OXZWcKSeQC0KADuxHAAl8kIaK+AI7pLGsVjMOKHs3i4GzaUM5CqjvxyE+W6BeQ2nM1Qzj7xvhFxb2akQpbYiWn5ZCVXD+hH2Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lIOeaQGbLpqXrt2JvWyUvXrDLgSWozGA9otpJH7PWc=;
 b=GgImHakZ44eVgXoFMsIzC60wJZLlVcnf6vPCSLS/q8751NttOol/8kHbyhuctSKaXoqejuOrsRLd/jMK2F/UM/T++NKEDiPRk7++hWbsslSPv8djQzQ4SKP5h5u+YS19FDI/eg/7H5DNWQhwuflNBtrMZAGUK6Z6nFsN5dgBjlY=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB4598.namprd03.prod.outlook.com (20.179.92.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.20; Tue, 3 Dec 2019 09:05:24 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:05:24 +0000
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jun Nie <jun.nie@linaro.org>, Christoph Hellwig <hch@infradead.org>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Topic: [PATCH 4/4] mmc: sdhci: Add DMA memory boundary workaround
Thread-Index: AQHVqR6bSNy8xcyAyESfm+a1vx+I5KensdkAgAAQtICAAFjjgA==
Date:   Tue, 3 Dec 2019 09:05:23 +0000
Message-ID: <20191203165123.4e6f9e28@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
        <20191203103320.273a7309@xhacker.debian>
        <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
In-Reply-To: <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TYAPR03CA0007.apcprd03.prod.outlook.com
 (2603:1096:404:14::19) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b35c800b-ee77-42a0-5ef0-08d777cfee4a
x-ms-traffictypediagnostic: BYAPR03MB4598:
x-microsoft-antispam-prvs: <BYAPR03MB45980A6E1D275FFD26ECB9B0ED420@BYAPR03MB4598.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(39860400002)(376002)(366004)(346002)(189003)(199004)(51914003)(6436002)(6486002)(26005)(110136005)(11346002)(446003)(186003)(9686003)(66946007)(66476007)(86362001)(66446008)(64756008)(66556008)(386003)(102836004)(76176011)(229853002)(52116002)(6506007)(6512007)(81156014)(1076003)(81166006)(71200400001)(71190400001)(5660300002)(99286004)(316002)(50226002)(54906003)(256004)(8936002)(4326008)(478600001)(25786009)(6246003)(2906002)(3846002)(6116002)(8676002)(14454004)(7736002)(305945005)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB4598;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aj+IW1DLdStsALzDNpjsZtjdjf7U+CajgHjrAxd9ZwQERYsa4MYvNZoFMNlmzJ/cr34SEggyXvLhHWh0M6OR810aSuQ+Baw4dyBkKM745afuE8BproS24KDbonvMYys3QmmEK2w662FwjZmxMvrkx2gkuOE0DMxuLDdfIbpH/U+mYJwlYKgtF9oFGM70QHld8WTLONXUNgoRzH+ECXIU2XJryCLb7wDO9V2ys1uLbPoKVqiHpxNDtfRruZr8vfnE02Lsoh4laMiCDOzkg0fX8XBQIEL/Wv4jZrIGEpaaPOswkYhhrIQgsJbHU3rGzl/wU4Yk/w1se1hNCGgmUJ9xuHnor5Bl0af+lplhriezaQX3oAAJUcgA+Xn4FodQDU1TWzWc//5hnNSzS2lM0qokg0Bdv1dy9HYBQJiRn1orRW2/5SV7uERwvQdzwxzE/qYt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <440789C5C920DC4288D62DC7C75D6252@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35c800b-ee77-42a0-5ef0-08d777cfee4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:05:23.9329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K4y/4XNjZpoL1pZc/TZ81N6BStDbwu9tRDxQhMiYrYmfKALP1BpZGLzfMVrDxSqYPltCa/2zAwuIPHLoT79eVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4598
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

KyBDaHJpc3RvcGgNCg0KT24gVHVlLCAzIERlYyAyMDE5IDExOjMzOjE1ICswODAwIEp1biBOaWUg
d3JvdGU6DQoNCj4gDQo+IA0KPiBKaXNoZW5nIFpoYW5nIDxKaXNoZW5nLlpoYW5nQHN5bmFwdGlj
cy5jb20+IOS6jjIwMTnlubQxMuaciDPml6Xlkajkuowg5LiK5Y2IMTA6NDflhpnpgZPvvJoNCj4g
Pg0KPiA+IE9uIE1vbiwgIDIgRGVjIDIwMTkgMjI6NDE6MDQgKzA4MDAgSnVuIE5pZSB3cm90ZToN
Cj4gPg0KPiA+ICANCj4gPiA+DQo+ID4gPg0KPiA+ID4gRE1BIG1lbW9yeSBjYW5ub3QgY3Jvc3Mg
c3BlY2lmaWMgYm91bmRhcnkgZm9yIHNvbWUgU0RIQ0kgY29udHJvbGxlciwNCj4gPiA+IHN1Y2gg
YXMgRGVzaWduV2FyZSBTREhDSSBjb250cm9sbGVyLiBBZGQgRE1BIG1lbW9yeSBib3VuZGFyeSBk
dA0KPiA+ID4gcHJvcGVydHkgYW5kIHdvcmthcm91bmQgdGhlIGxpbWl0YXRpb24uICANCj4gPg0K
PiA+IElNSE8sIHRoZSB3b3JrYXJvdW5kIGNvdWxkIGJlIGltcGxlbWVudGVkIGluIGVhY2ggU0RI
Q0kgaG9zdCBkcml2ZXIuDQo+ID4NCj4gPiBlZy4gZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1vZi1k
d2Ntc2hjLmMNCj4gPiAgDQo+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIENocmlzdG9waCdz
IHN1Z2dlc3Rpb24gY2FuIHByZXZlbnQgdGhlIHRoZSBpc3N1ZQ0KPiBmcm9tIHRoZSBibG9jayBs
YXllciwgdGh1cyB0aGUgY29kZSBjYW4gYmUgc2hhcmVkIGFjcm9zcyBhbGwNCg0KVG8gYmUgaG9u
ZXN0LCBJIGRpZCBjb25zaWRlciBzaW1pbGFyIHNvbHV0aW9uIGZyb20gYmxvY2sgbGF5ZXIsIEku
RSBzZXQNCnRoZSBzZWdfYm91bmRhcnlfbWFzaywgd2hlbiBzdWJtaXR0aW5nIHRoZSB3b3JrYXJv
dW5kIGxhc3QgeWVhciwgYnV0IHBlcg0KbXkgdW5kZXJzdGFuZGluZywgU0RIQ0kgbGltaXRhdGlv
biBpcyB0aGUgcGh5c2ljYWwgRE1BIGFkZHIgY2FuJ3Qgc3BhbiBvbmUNCnNwZWNpZmljIGJvdW5k
YXJ5LCBzbyBzZXR0aW5nIHNlZ19ib3VuZGFyeV9tYXNrIHcvIGJsa19xdWV1ZV9zZWdtZW50X2Jv
dW5kYXJ5DQpjYW4ndCB3b3JrLiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIGJsa19xdWV1ZV9z
ZWdtZW50X2JvdW5kYXJ5KCkgcHJvcGVybHkuDQpNYXkgQ2hyaXN0b3BoIGhlbHAgdG8gY2xhcmlm
eT8NCg0KRnJvbSBhbm90aGVyIHNpZGUsIGRyaXZlcnMvYXRhL2xpYmF0YS1zZmYuYyBhbHNvIHdv
cmthcm91bmQgdGhlIDY0SyBwaHkgRE1BDQpib3VuZGFyeSBsaW1pdGF0aW9uIGl0c2VsZiByYXRo
ZXIgdGhhbiBmcm9tIGJsb2NrIGxheWVyLg0KDQpUaGFua3MNCg0KPiBjb250cm9sbGVycy4gSSBw
cmVmZXINCj4gaGlzIHN1Z2dlc3Rpb25zLg0KPiANCj4gSnVuDQoNCg==
