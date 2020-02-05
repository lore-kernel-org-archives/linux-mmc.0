Return-Path: <SRS0=4knG=3Z=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7653C35249
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 05:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631BE2082E
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Feb 2020 05:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sKuIWQr5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgBEF4Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Feb 2020 00:56:24 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:6223
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbgBEF4Y (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 5 Feb 2020 00:56:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXHzGcS4kx8aspLlfNqBApS1MXHmjmFvo4Gw7IQfT5f4rRlIcVFA733rniF9Zd89k87CfiOB6DQgA/IzP6Cahf4s67Z/RItPe9fPgm/1csB+AZWEDYCvpsXzp7mvB7yTh35Xr8M493EM3EQbtdH1ux7KqGxGiI8K3X25+CeT59vxeDTwldVvj4WBOsGa65glMOQymRolugmujSgUA142/kN6kluNfmea4jkiXYRcWwvqMmup+FyMVZOUwl4xy/wVcDVUMehoAp7p3ij935Pkh0JFac2jRuNyr3whYuT0dAoUcZyqzGs0ZK8Qkm2GvQtrQUmgztMna0J6FJ03k7Lz4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEDCnTEJ5xsV530UV2IWjPxSdCAzAsmZSv5WI3R8Ozo=;
 b=SZhid8s4b0ecvlUptgLZA14sZXtYf/hJVzt6B+sBGaN6AwOEvxdk1vfj0x6CH6NnCY4cnJlOQw1vS2YC0RBCrGfLBe8e7KtW5eZkI19GnRjeIJppSWGvFUzRkJKsO5jvMQ+e+YpYa4Q1WWzD5FmXkrh+S3oNrBZIt8ADW+uBDgRimNZKgIfH/ANenvGyEcLIx9hlNAdw9xr4aWYc8ahpuJRP9FHMt+KrukokeMk+KGO7Lir1dRD2T69LSMu6gup0Y3E3TJngzH7qyRP5sfOhUuGyOmBMrdb7sko1jBgxNk+55bTLLc71tjMey54Z0Y7R7b7CSNJZpSgknnoqxGa82w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEDCnTEJ5xsV530UV2IWjPxSdCAzAsmZSv5WI3R8Ozo=;
 b=sKuIWQr5nPPVi/9+YLJy6JT7rMObRPL9Wa5TCIOBgCFH9UvNp4khxwfT0Oqix+V5I76M7xRSiIdip0MVVCOGEhrEMHaMaY++oCzQnhzksg3AZklZehX4Omv0qH5f43jLkvDCu0rudZDhPs4UeFVhd160dBYUFu3Y07vHwjwd594=
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com (10.141.174.88) by
 AM7PR04MB6791.eurprd04.prod.outlook.com (10.141.171.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Wed, 5 Feb 2020 05:56:21 +0000
Received: from AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064]) by AM7PR04MB6885.eurprd04.prod.outlook.com
 ([fe80::8a5:3800:3341:c064%7]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 05:56:21 +0000
From:   "Y.b. Lu" <yangbo.lu@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dann frazier <dann.frazier@canonical.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Topic: [PATCH 2/3] mmc: sdhci-of-esdhc: set DMA snooping based on DMA
 coherence
Thread-Index: AQHVcTBOpWluYDvmwES2/jOGUAGSvaf0DJSwgAA9tQCAGKPVYA==
Date:   Wed, 5 Feb 2020 05:56:21 +0000
Message-ID: <AM7PR04MB6885C2B7186DE54E97C6E38BF8020@AM7PR04MB6885.eurprd04.prod.outlook.com>
References: <20190922102341.GO25745@shell.armlinux.org.uk>
 <E1iBz50-0008Mc-8K@rmk-PC.armlinux.org.uk>
 <AM7PR04MB688507B5B4D84EB266738891F8320@AM7PR04MB6885.eurprd04.prod.outlook.com>
 <50fe98f2-9ee6-c0fb-d246-e3d6b4b2cec5@arm.com>
In-Reply-To: <50fe98f2-9ee6-c0fb-d246-e3d6b4b2cec5@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a86c4547-2155-4aa8-e9ea-08d7aa002023
x-ms-traffictypediagnostic: AM7PR04MB6791:|AM7PR04MB6791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB6791EEC35D4C030266B92AB8F8020@AM7PR04MB6791.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(189003)(199004)(478600001)(53546011)(26005)(6506007)(8676002)(8936002)(81166006)(81156014)(71200400001)(55016002)(9686003)(5660300002)(86362001)(33656002)(2906002)(4326008)(52536014)(64756008)(66476007)(54906003)(66446008)(110136005)(316002)(66556008)(66946007)(7696005)(186003)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR04MB6791;H:AM7PR04MB6885.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYczagvYTv9TTcOnMuhW76giTRGBwSoGexzBvAt7AO9I8hzWkMCzbOoVi7Y1XRfCgitRE07oc+qu688FRzKlnX9kU/cdEAaZbjOgM53vbhJZ2LNDo3ZPcj+qWEEdMcAnvj4r7VOZ1RBM1sMcDaWg9/UGwtsfDf2FqN19wVh3MHjWC+qd8z0Tm4Ay46O/ZMuw2SRA/S3ythzR6iE9akjUVE4tNV8qK0x0zXIYj5xMtDSruQ81+aWPu5b/9W9A4PHhANUK5lYZSVD9iOAQTNwhpC6tSstyLfm7uFypsbb7qalgp8mP3qefZs5AOxLuyjpHC2tq/1LQBbpwUvYqBInv7siGCLXfEIJAu7wLX3gl4M1F4f/3DcYk1/lF/fz8zHX85Q7dNbFFeM2NCeySmT0JKtAsTbe5DUkCPBDxGR5LBiwZdGTW8HGB16f8pzaQlC+I
x-ms-exchange-antispam-messagedata: IDEHcKYODrODOVVymXuBJhJ/MQ8BQB5AKURlix1Vth2x18wprJCd/iFDg0451nUTUiYmbzV3ARMhBs1Uh4oAytJ2aAard+OuxYoguG0IPJV5dSU5Qt4YVVGBYayfVz5OspOKOW0VEVa2VQKhJrjPZQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c4547-2155-4aa8-e9ea-08d7aa002023
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 05:56:21.1533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfWH4it6k7Ra/5/kJkO/9sYfjv0l1GMT/zEb2CzSSMb8CwTm3/KzTYY4TqppxdVWbYC41pKQHEN/KDkcjv3NOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6791
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

SGkgUm9iaW4sDQoNClRoYW5rcyBsb3QgZm9yIHlvdXIgc3VnZ2VzdGlvbi4gSSBwcmVmZXIgeW91
ciBmaXgtdXAgcGF0Y2ggdG8gdHJlYXQgUG93ZXJQQyBhcyBhIHNwZWNpYWwgY2FzZS4NCg0KSGkg
QWRyaWFuIGFuZCBVZmZlLA0KDQpEbyB5b3UgdGhpbmsgaXQgaXMgb2s/IFNob3VsZCBJIGhlbHAg
dG8gcmUtc2VuZCB0aGF0IHBhdGNoIHRvIG1tYyBtYWlsaW5nIGxpc3QgZm9yIHJldmlld2luZy4N
ClRoYW5rcy4NCg0KQmVzdCByZWdhcmRzLA0KWWFuZ2JvIEx1DQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4N
Cj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDIwLCAyMDIwIDk6MzQgUE0NCj4gVG86IFkuYi4gTHUg
PHlhbmdiby5sdUBueHAuY29tPjsgUnVzc2VsbCBLaW5nIDxybWsra2VybmVsQGFybWxpbnV4Lm9y
Zy51az4NCj4gQ2M6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsgVWxm
IEhhbnNzb24NCj4gPHVsZi5oYW5zc29uQGxpbmFyby5vcmc+OyBsaW51eC1tbWNAdmdlci5rZXJu
ZWwub3JnOyBkYW5uIGZyYXppZXINCj4gPGRhbm4uZnJhemllckBjYW5vbmljYWwuY29tPjsgV2ls
bCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+OyBOaWNvbGluDQo+IENoZW4gPG5pY29sZW90
c3VrYUBnbWFpbC5jb20+OyBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzNdIG1tYzogc2RoY2ktb2YtZXNkaGM6IHNldCBETUEgc25vb3Bpbmcg
YmFzZWQgb24NCj4gRE1BIGNvaGVyZW5jZQ0KPiANCj4gT24gMjAvMDEvMjAyMCAxMDowOSBhbSwg
WS5iLiBMdSB3cm90ZToNCj4gPiBIaSBSdXNzZWxsLA0KPiA+DQo+ID4gUmVjZW50bHkgSSBnb3Qg
ZVNESEMgQURNQSBpc3N1ZSBvbiBQb3dlclBDIFQyMDgwIHBsYXRmb3JtLiBBZnRlcg0KPiBjaGVj
a2luZywgdGhlIGlzc3VlIGlzIHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCj4gPiBUaGlzIHBhdGNo
IHdhcyB0byBtYWtlIGVTREhDIERNQSBTTk9PUCBiaXQgc2V0IHBlciBkbWEtY29oZXJlbnQuIFRo
YXQNCj4gcmVzb2x2ZWQgaXNzdWUgb24gTFgyMTYwQSBBUk02NCBwbGF0Zm9ybS4NCj4gPiBIb3dl
dmVyIG9uIFQyMDgwLCB3ZSBhcmUgZmFjaW5nIHNpbWlsYXIgaXNzdWUgYWdhaW4uIEl0IGRpZG4n
dCBoYXZlDQo+IGRtYS1jb2hlcmVudCBpbiBkdHMuDQo+ID4gQWRkaW5nIGRtYS1jb2hlcmVudCBp
biBkdHMsIG9yIHJldmVydGluZyB0aGUgcGF0Y2ggY291bGQgcmVzb2x2ZSB0aGUNCj4gcHJvYmxl
bS4NCj4gDQo+IEFyZ3VhYmx5IHVwZGF0aW5nIHRoZSBEVFMgd291bGQgYmUgdGhlIG1vc3QgYWNj
dXJhdGUgb3B0aW9uLCBzaW5jZSBpdA0KPiB3b3VsZCBiZSBkZXNjcmliaW5nIHRoZSBoYXJkd2Fy
ZSBtb3JlIGNvcnJlY3RseSwgaG93ZXZlciBpZiB0aGVyZSBhcmUNCj4gcmVhc29ucyBmb3IgdGhh
dCBub3QgYmVpbmcgc3VmZmljaWVudCAoZS5nLiBEVEJzIGJha2VkIGludG8gZmlybXdhcmUsIG9y
DQo+IHdvcnJpZXMgb2YgY29uZnVzaW5nIHNvbWUgb3RoZXIgRFQgY29uc3VtZXIpIHRoZW4gc29t
ZXRoaW5nIGxpa2UgdGhlDQo+IGJlbG93IHNlZW1zIHJlYXNvbmFibGUgKGFsYmVpdCBhIGxpdHRs
ZSBjcnVkZSkgSU1PLg0KPiANCj4gUm9iaW4uDQo+IA0KPiAtLS0tLT44LS0tLS0NCj4gIEZyb20g
ZmFmYWQzMTk4OTNiNDE2OGZjY2NjNTQ0NTU0M2NhZjg3NmEwYmUyZCBNb24gU2VwIDE3IDAwOjAw
OjAwDQo+IDIwMDENCj4gTWVzc2FnZS1JZDoNCj4gPGZhZmFkMzE5ODkzYjQxNjhmY2NjYzU0NDU1
NDNjYWY4NzZhMGJlMmQuMTU3OTUyNjc1NS5naXQucm9iaW4ubXVycGgNCj4geUBhcm0uY29tPg0K
PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBEYXRlOiBNb24s
IDIwIEphbiAyMDIwIDEzOjExOjU5ICswMDAwDQo+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBzZGhj
aS1vZi1lc2RoYzogUmVzdG9yZSBjb2hlcmVuY3kgZm9yIFBQQyBwbGF0Zm9ybXMNCj4gDQo+IEhp
c3RvcmljYWxseSwgbm90IGFsbCBQUEMgcGxhdGZvcm1zIGhhdmUgc3VwcG9ydGVkIHBlci1kZXZp
Y2UgY29oZXJlbmN5LA0KPiBhbmQgc29tZSBtYXkgcmVseSBvbiBwbGF0Zm9ybS1sZXZlbCBhc3N1
bXB0aW9ucyByYXRoZXIgdGhhbiBleHBsaWNpdGx5DQo+IHNwZWNpZnlpbmcgdGhlICJkbWEtY29o
ZXJlbnQiIHByb3BlcnQgaW4gdGhlaXIgRFQuIEFsdGhvdWdoIHRoZSBlU0RIQw0KPiBkcml2ZXIg
bmVlZHMgdG8gdGllIGluIHRvIHBlci1kZXZpY2UgY29oZXJlbmN5IHRvIHdvcmsgY29ycmVjdGx5
IG9uDQo+IGFybS9hcm02NCBwbGF0Zm9ybXMsIHRoaXMgaGFzIGFwcGFyZW50bHkgY2F1c2VkIHBy
b2JsZW1zIGZvciBQUEMsIHNvDQo+IHJlc3RvcmUgdGhlIHByZXZpb3VzIGJlaGF2aW91ciB0aGVy
ZSB3aXRoIGEgc3BlY2lhbCBjYXNlLg0KPiANCj4gRml4ZXM6IDEyMWJkMDhiMDI5ZSAoIm1tYzog
c2RoY2ktb2YtZXNkaGM6IHNldCBETUEgc25vb3BpbmcgYmFzZWQgb24NCj4gRE1BDQo+IGNvaGVy
ZW5jZSIpDQo+IFJlcG9ydGVkLWJ5OiBZYW5nYm8gTHUgPHlhbmdiby5sdUBueHAuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiAtLS0N
Cj4gICBkcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMgfCAzICsrLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gYi9kcml2ZXJzL21tYy9o
b3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gaW5kZXggNTAwZjcwYTZlZTQyLi5hMjU5OTM2OGIyYmQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktb2YtZXNkaGMuYw0KPiArKysg
Yi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW9mLWVzZGhjLmMNCj4gQEAgLTUyNyw3ICs1MjcsOCBA
QCBzdGF0aWMgaW50IGVzZGhjX29mX2VuYWJsZV9kbWEoc3RydWN0IHNkaGNpX2hvc3QNCj4gKmhv
c3QpDQo+IA0KPiAgIAl2YWx1ZSA9IHNkaGNpX3JlYWRsKGhvc3QsIEVTREhDX0RNQV9TWVNDVEwp
Ow0KPiANCj4gLQlpZiAob2ZfZG1hX2lzX2NvaGVyZW50KGRldi0+b2Zfbm9kZSkpDQo+ICsJLyog
SGlzdG9yaWNhbGx5LCBQUEMgaGFzIGFsd2F5cyBhc3N1bWVkIGNvaGVyZW5jeSBoZXJlICovDQo+
ICsJaWYgKElTX0VOQUJMRUQoQ09ORklHX1BQQykgfHwgb2ZfZG1hX2lzX2NvaGVyZW50KGRldi0+
b2Zfbm9kZSkpDQo+ICAgCQl2YWx1ZSB8PSBFU0RIQ19ETUFfU05PT1A7DQo+ICAgCWVsc2UNCj4g
ICAJCXZhbHVlICY9IH5FU0RIQ19ETUFfU05PT1A7DQo+IC0tDQo+IDIuMjMuMC5kaXJ0eQ0K
