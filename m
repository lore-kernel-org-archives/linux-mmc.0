Return-Path: <SRS0=djOR=56=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B51C2BBFD
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 05:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4979620857
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Apr 2020 05:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SynwL+OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405611AbgDNFtM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:49:12 -0400
Received: from mail-mw2nam10on2062.outbound.protection.outlook.com ([40.107.94.62]:13121
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729111AbgDNFtK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Apr 2020 01:49:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0/myYQnNp6Mh+uIXG5Dkqq7hqHp28L7P6uWPVc2XcHP4+w/jhsAQBGFAUpeGCEo4ON89YqzmFLcdpWDXj1H74I6r5OlvF164mPl1maI9MgdUzQYrlzIbYXOq0nuYqjtFsrBDMUaMkipDSgzFuGKFO3ywUvfQoLBD6SLG1KsV7jY6IPzkhxiDG4K7mQNanmughzFFfSRwJT7eemwISLCkmbeoAx4IHxkhAr0j24V2zVnLkfoySgPk2Q3kQ45nyJHdTZomCDBhtOWFpk70aQoNTGDTQAMRU/MVi7dkgtWNw7DZEZ9m7q7RB7DMQR1MVHQw4IWREuYGXPi+fJY5mr2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T+h6ZTNnmu/FTHXu5fdBtv4AFr3LYnrqQecMNzxO5U=;
 b=Kti6wFgnktpJJJZMEiP2kUTlbPVrZiGPNscRC3ZeVtV03Lyl3DSNQv/hs6zz0r8NbWRONvUOTg2t8elfUpORYQZKJlO74mSZ5BYnV8UmuNLSpkXCYbiX3+uwGheRoOKAQ4yF78OvLOoWd2G/+NdmMPErmv6SDUGqdYJbPEGQwJtH6O+CiQrq+h6Odtm/hJrc+lTrWQoWJf0os+t4VksjLjJL2i17e6zu3pugAjRE6Vi3h6iJ2coNigANixYpaYMJe9CVOjF+kAVvxwXRokNC8HBctdTMQ/I4p++t5GlZwrLk+MlVV3WGh+B36SDokMVP9cV59NH2q9KIIvsHLq4ODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1T+h6ZTNnmu/FTHXu5fdBtv4AFr3LYnrqQecMNzxO5U=;
 b=SynwL+OKXxiWLQWFEWXnL88xZAzB/kXNmbDIC9mj0JhKHmWlGbnFXrbzJKsmUZEuqiEW30CEv1gtlC7/wciB4hrpVqAIsXhvZOrUX17GDB/PCvx0GH++bpaaFsZOnASHpmR1b1g74nUBAfKBwFoPJvU3NKRtqKz8S/WkkE6IUVQ=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5253.namprd02.prod.outlook.com (2603:10b6:a03:61::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.28; Tue, 14 Apr
 2020 05:49:06 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c9d7:1fa3:6ec1:f7a9]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::c9d7:1fa3:6ec1:f7a9%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 05:49:06 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        Michal Simek <michals@xilinx.com>
CC:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, git <git@xilinx.com>
Subject: RE: [PATCH v3 0/6] Add support for Xilinx Versal SDHCI in Arasan
 driver
Thread-Topic: [PATCH v3 0/6] Add support for Xilinx Versal SDHCI in Arasan
 driver
Thread-Index: AQHWDDsANGwar7+SeUGv1U0VGn/7m6h4KBHg
Date:   Tue, 14 Apr 2020 05:49:06 +0000
Message-ID: <BYAPR02MB5896E3E2BB1DC4C2D454B2E2C1DA0@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [183.83.137.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b2dfda0-e2e2-4279-b329-08d7e0378baa
x-ms-traffictypediagnostic: BYAPR02MB5253:|BYAPR02MB5253:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB52534E3F5FFD5109835E607FC1DA0@BYAPR02MB5253.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(478600001)(110136005)(7416002)(26005)(4326008)(6636002)(107886003)(54906003)(186003)(71200400001)(53546011)(86362001)(6506007)(316002)(7696005)(55016002)(66476007)(33656002)(64756008)(66446008)(9686003)(8676002)(52536014)(81156014)(66946007)(8936002)(2906002)(5660300002)(76116006)(66556008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1Owk4emep2SVnad8d+DjVlKRwteCaqalPovln/QBAIK1suWLgEGio79ZmfYPO7XQxQfJ7lLc1LolhhPRv8/EP1TS/coOwzUc9b7+crNto1wdZB+EkwWN5tIhiYot1TwqVCKzBF7s6VJc/a+e6ZE/x0eIuAFrR7RIfL7+Oi/8zpOUq8Mo9P8SjORH4czCcnKNADm4gV1RRUJUSs9pb56c6V/ZtjeKnTsm1+Y0pXkAfB1JdW6HtilxT+vNpWUzUAuEWyQUJaXR4MDttjhFKzqXs09UYeFZtsYpckn6RlytSCyMjaP2qVXs80DWuSviKJL5Lgcqvhtpjn4O1XByEx3p6qPAWwvswxFS0hemFCYvCPCNbmwCs5aaGmBx0UOjp3Sc1DwRx353RrSog/4n8hVIpKyDAkWQxDQ61Cq6Y6fnpiooRg/40FpFDurXko5vmIA
x-ms-exchange-antispam-messagedata: VVQ0k9LQpQB73gSRh4Neb/oIcMqQzQAsxHfCQTH+Wh6qbrnbCML2glnELf1E5V4MC4k2a10yTSrjt2sV4J+8IDVbdurorHd5cSOc3mtTUAW0cGf5X6WDP82ynME5wZ4sEU8Wxzls9jgZU/jsH04Qlg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b2dfda0-e2e2-4279-b329-08d7e0378baa
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 05:49:06.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7sYt1lapZ6f/3vwiNdXEeQ5Rh9u5b33TpJB8y31bHHuEL3qipptBuDWb4XeDT8ilFMVgXWJudPiPfpvKZJTWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5253
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ping!

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Monday, April 6, 2020 11:13 PM
> To: ulf.hansson@linaro.org; robh+dt@kernel.org; mark.rutland@arm.com;
> adrian.hunter@intel.com; Michal Simek <michals@xilinx.com>
> Cc: linux-mmc@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; git
> <git@xilinx.com>; Manish Narani <MNARANI@xilinx.com>
> Subject: [PATCH v3 0/6] Add support for Xilinx Versal SDHCI in Arasan dri=
ver
>=20
> This patch series includes:
>  -> Document the Xilinx Versal SD controller
>  -> Add support for Versal SD Tap Delays
>  -> Reorganizing the clock operations handling
>  -> Resolve kernel-doc warnings
>=20
> Changes in v2:
> 	- Addressed review comments given in v1
> 	- Changed clock operation handling for better modularity.
> 	- Changed comments to fix kernel-doc warnings
>=20
> Changes in v3:
> 	- Addressed review comments from v2
> 	- Move platform related structure before doing clock related changes
> 	- Rename sdhci_arasan_data to avoid confusion with another struct
> name
>=20
> Manish Narani (6):
>   dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
>   sdhci: arasan: Add support for Versal Tap Delays
>   mmc: sdhci-of-arasan: Rename sdhci_arasan_data to avoid confusion
>   mmc: sdhci-of-arasan: Rearrange the platform data structs for
>     modularity
>   mmc: sdhci-of-arasan: Modify clock operations handling
>   mmc: sdhci-of-arasan: Fix kernel-doc warnings
>=20
>  .../devicetree/bindings/mmc/arasan,sdhci.txt       |  15 +
>  drivers/mmc/host/sdhci-of-arasan.c                 | 473 +++++++++++++++=
------
>  2 files changed, 361 insertions(+), 127 deletions(-)
>=20
> --
> 2.1.1

