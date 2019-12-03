Return-Path: <SRS0=3zNE=ZZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8E8C43215
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 09:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A225E20833
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Dec 2019 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="m+Es4aNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfLCJtj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 04:49:39 -0500
Received: from mail-eopbgr720078.outbound.protection.outlook.com ([40.107.72.78]:51450
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725907AbfLCJti (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 3 Dec 2019 04:49:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWr/mGqxJf+6QqdvGxVVNuVTooLtJLt6xufjp+p/CcgIKB3OHivkSBKVMYTDOUx7xD/ch8WEByQs8O2s3o/P4mbrNmrGRaRLQdy5ziV6g2rRYSodU4KJ0n5epW+OZmDlDC1odoRiaTguY3QRb2ysSr8KSWSjZL9Z5IHx4jP+vQbGem/OkeU/jir6BUjcw4s4Pam97Emfpojr0G2RXxe7oNsYIhLXau/06045gEvwpSLC2Wx656hqvBnwaLjD3ssZEyne4V5HspQmPFqtANWKYSko3OZEx+i+qElD1CP/GuKm4vIbOukzj1rG6tjW7q+eTNysInuSSeAgim72tK0rmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOKjV2WeOdvoTsuQVXD1zoQmhjPX30sRIp+sl3jFRPM=;
 b=I5iCXsrmio+YzvQRXkWrdx9M6gyxo7yEHKA7Ezjr0QRRFfK+ppym3KnSHCiyv0WVJ8wLNnBcQvYvpxXjiYPJMysesPca2IfjjEFQdXFh0aioCSYJFRAI1Ud79X7E0Wo6L3PK9t/z4KiRp3cJdISwEyBoKcnAbTHUc8F04lh16efywUVxF9Abcw6z7YN/Pr3N9Q0XJWPJDF3EedFnboW++d7bn5wq/h+60UZQcg5ZZGnur2KhTC/P49v81yDydHb7Jm9yjiY1qn2YfI50p3QNJ7EkjX3gdjsgOU7RYqqhMT4zDAZKdGK58jCqW+hzTxikRBFbGtRQoIRxSTls/N69tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOKjV2WeOdvoTsuQVXD1zoQmhjPX30sRIp+sl3jFRPM=;
 b=m+Es4aNKVqkk1ceFKHLpq+8MguPKnqh0bXBzq+gShbg78/TkiHYW6CKfttTqLCJ+4eKNE2oJ9VU7bNjPpPTcJU4bBRmVWW+k/AYPvKLru85dtCpU56Q65XT+2S+Yn7peSLcwG0CGx2TnWhZHGdmzaPxOp1PVwfjap2YSbFj27+A=
Received: from BYAPR03MB4773.namprd03.prod.outlook.com (20.179.93.213) by
 BYAPR03MB3669.namprd03.prod.outlook.com (52.135.214.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.21; Tue, 3 Dec 2019 09:49:34 +0000
Received: from BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a]) by BYAPR03MB4773.namprd03.prod.outlook.com
 ([fe80::708d:91cc:79a7:9b9a%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 09:49:33 +0000
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
Thread-Index: AQHVqR6bSNy8xcyAyESfm+a1vx+I5KensdkAgAAQtICAAFjjgIAADGsA
Date:   Tue, 3 Dec 2019 09:49:33 +0000
Message-ID: <20191203173256.55f527d5@xhacker.debian>
References: <20191202144104.5069-1-jun.nie@linaro.org>
        <20191202144104.5069-5-jun.nie@linaro.org>
        <20191203103320.273a7309@xhacker.debian>
        <CABymUCMVi_N2Mt82YDt7wrys4Z_vnXYEu15-YBa+S1CejT9iZw@mail.gmail.com>
        <20191203165123.4e6f9e28@xhacker.debian>
In-Reply-To: <20191203165123.4e6f9e28@xhacker.debian>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [124.74.246.114]
x-clientproxiedby: TY2PR0101CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::23) To BYAPR03MB4773.namprd03.prod.outlook.com
 (2603:10b6:a03:139::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 942a79b4-8fe2-4fc1-a584-08d777d619ba
x-ms-traffictypediagnostic: BYAPR03MB3669:
x-microsoft-antispam-prvs: <BYAPR03MB3669D6CAA05A200B88FFCEAFED420@BYAPR03MB3669.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39850400004)(346002)(376002)(136003)(199004)(189003)(51914003)(186003)(6116002)(2906002)(66556008)(50226002)(25786009)(26005)(99286004)(81156014)(8676002)(8936002)(110136005)(6486002)(54906003)(14454004)(316002)(305945005)(7736002)(6436002)(5660300002)(71200400001)(256004)(102836004)(76176011)(11346002)(446003)(81166006)(4326008)(229853002)(478600001)(3846002)(71190400001)(6246003)(6512007)(9686003)(86362001)(52116002)(1076003)(66476007)(66446008)(64756008)(66946007)(6506007)(386003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR03MB3669;H:BYAPR03MB4773.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UUSrYvMMXsGhtc5PYG0YMsZTMIIkcWzUAHW9cYHDslmlnioqQx5Xh27P0lRb3Epc52cMYIqo5jNTt70TcdHHASzcgB+ChvV78kLhNXm/Mr+LN3a1jF3PSuPDkU1NzSkJfRX74uDcPYnlLzW2xr5LNhSheEK0en0z752hQ/ID14YPE3ULReq2L8UjfEHc9/tyx7R2BNTcLma704tisQDm2NCetW2kneQqolYm+CInPXnVutov9nS8nsoyEBai7au/wq0oEq0c7Lz4tSNF00sbDZNscu/iey4MwkHqaPLg2y38HHBCIQbNBlZahi+FETzIDPMZTIXs849WvJA/FEeQYb55oy66HhzQMidR7bZN1RJBqXpGXyE2DuHAfitVLF4E8fvhtoTMV6g4UNgamq/4pJxOsaBBlT9tT9bnH1aM0aSe3DmzodvXjJWil3XJZAZs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3597E13CE4D6F84B9443F1A9B6708237@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942a79b4-8fe2-4fc1-a584-08d777d619ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 09:49:33.7352
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Py+8xzNmFosoPEMTiY1jGlbFir3xT38nLOLUPs+KqpZnV1d6PWobV4N3DF1tzhkitQj/pFSUp442jrq/sZ57mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3669
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

T24gVHVlLCAzIERlYyAyMDE5IDA5OjA1OjIzICswMDAwIEppc2hlbmcgWmhhbmcgd3JvdGU6DQoN
Cg0KPiANCj4gKyBDaHJpc3RvcGgNCj4gDQo+IE9uIFR1ZSwgMyBEZWMgMjAxOSAxMTozMzoxNSAr
MDgwMCBKdW4gTmllIHdyb3RlOg0KPiANCj4gPg0KPiA+DQo+ID4gSmlzaGVuZyBaaGFuZyA8Smlz
aGVuZy5aaGFuZ0BzeW5hcHRpY3MuY29tPiDkuo4yMDE55bm0MTLmnIgz5pel5ZGo5LqMIOS4iuWN
iDEwOjQ35YaZ6YGT77yaICANCj4gPiA+DQo+ID4gPiBPbiBNb24sICAyIERlYyAyMDE5IDIyOjQx
OjA0ICswODAwIEp1biBOaWUgd3JvdGU6DQo+ID4gPg0KPiA+ID4gIA0KPiA+ID4gPg0KPiA+ID4g
Pg0KPiA+ID4gPiBETUEgbWVtb3J5IGNhbm5vdCBjcm9zcyBzcGVjaWZpYyBib3VuZGFyeSBmb3Ig
c29tZSBTREhDSSBjb250cm9sbGVyLA0KPiA+ID4gPiBzdWNoIGFzIERlc2lnbldhcmUgU0RIQ0kg
Y29udHJvbGxlci4gQWRkIERNQSBtZW1vcnkgYm91bmRhcnkgZHQNCj4gPiA+ID4gcHJvcGVydHkg
YW5kIHdvcmthcm91bmQgdGhlIGxpbWl0YXRpb24uICANCj4gPiA+DQo+ID4gPiBJTUhPLCB0aGUg
d29ya2Fyb3VuZCBjb3VsZCBiZSBpbXBsZW1lbnRlZCBpbiBlYWNoIFNESENJIGhvc3QgZHJpdmVy
Lg0KPiA+ID4NCj4gPiA+IGVnLiBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWR3Y21zaGMuYw0K
PiA+ID4gIA0KPiA+IFRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIENocmlzdG9waCdzIHN1Z2dl
c3Rpb24gY2FuIHByZXZlbnQgdGhlIHRoZSBpc3N1ZQ0KPiA+IGZyb20gdGhlIGJsb2NrIGxheWVy
LCB0aHVzIHRoZSBjb2RlIGNhbiBiZSBzaGFyZWQgYWNyb3NzIGFsbCAgDQo+IA0KPiBUbyBiZSBo
b25lc3QsIEkgZGlkIGNvbnNpZGVyIHNpbWlsYXIgc29sdXRpb24gZnJvbSBibG9jayBsYXllciwg
SS5FIHNldA0KPiB0aGUgc2VnX2JvdW5kYXJ5X21hc2ssIHdoZW4gc3VibWl0dGluZyB0aGUgd29y
a2Fyb3VuZCBsYXN0IHllYXIsIGJ1dCBwZXINCj4gbXkgdW5kZXJzdGFuZGluZywgU0RIQ0kgbGlt
aXRhdGlvbiBpcyB0aGUgcGh5c2ljYWwgRE1BIGFkZHIgY2FuJ3Qgc3BhbiBvbmUNCj4gc3BlY2lm
aWMgYm91bmRhcnksIHNvIHNldHRpbmcgc2VnX2JvdW5kYXJ5X21hc2sgdy8gYmxrX3F1ZXVlX3Nl
Z21lbnRfYm91bmRhcnkNCj4gY2FuJ3Qgd29yay4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCBi
bGtfcXVldWVfc2VnbWVudF9ib3VuZGFyeSgpIHByb3Blcmx5Lg0KPiBNYXkgQ2hyaXN0b3BoIGhl
bHAgdG8gY2xhcmlmeT8NCg0Kd2hhdCdzIG1vcmUsIG5vdCBhbGwgc2NhdHRlcmxpc3QgaW4gbW1j
IGFyZSBmcm9tIGJsb2NrIGxheWVyLCBmb3IgZXhhbXBsZSwgDQpfX21tY19ibGtfaW9jdGxfY21k
KCksIG1tY190ZXN0LmMgZXRjLi4NCg0KSG93IGRvIHdlIGVuc3VyZSB0aGUgYm91bmRhcnkgaXMg
ZmluZSBpbiB0aGVzZSBjYXNlcz8NCg0KPiANCj4gRnJvbSBhbm90aGVyIHNpZGUsIGRyaXZlcnMv
YXRhL2xpYmF0YS1zZmYuYyBhbHNvIHdvcmthcm91bmQgdGhlIDY0SyBwaHkgRE1BDQo+IGJvdW5k
YXJ5IGxpbWl0YXRpb24gaXRzZWxmIHJhdGhlciB0aGFuIGZyb20gYmxvY2sgbGF5ZXIuDQoNCj4g
VGhhbmtzDQo+IA0KPiA+IGNvbnRyb2xsZXJzLiBJIHByZWZlcg0KPiA+IGhpcyBzdWdnZXN0aW9u
cy4NCj4gPg0KPiA+IEp1biAgDQo+IA0KDQo=
