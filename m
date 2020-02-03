Return-Path: <SRS0=dEAU=3X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC20C3524D
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 07:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A802073C
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Feb 2020 07:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="OID7a02v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgBCHUZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Feb 2020 02:20:25 -0500
Received: from mail-bn8nam12on2045.outbound.protection.outlook.com ([40.107.237.45]:6150
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727315AbgBCHUZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Feb 2020 02:20:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYiGZU/rYh0RWAcDu+24lYw3bwsOS2B4rl2ubtJKn9zfDKBkVhcyDrrBeU1Y30O/KqF9QhhVzT0AStsp5TfAZcKalcrYIx26OitlHOx5solw1ey24BiPQEn6v8KTVw4u/l4Mm2bRd+sgEBwMWNL9Zy4u5Xzg9svTFj6zLmkZ3+4uvCjju2b+Ed6U7MGISAvA3l7yZjsyWeQewkIuM89OWxK/KPL71XQe8TT6rLTHDnJBCHnnyS6NAocY1L7fksD/xFYxYRR6KHy0WAi6nL0NWHsKK7MrNPY5H/leszWAb1Aq0RAk9G8Qhr4xqIf736VR+9Y5pdhlQgq0f8Gx51DPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WU3hs3ThGFKb5mr3PKmEOXHv0t+rgrytWFEYk6SQI8=;
 b=H/o/M8pzX1U6DXVti5H1q1PrkPzo7QHBAETp78Rj26yQrQVktqTVo8szDvC3AOvSvRp5GJUiXbeSRK2FYnRMS8JJkh9Q9+xyTHMxATbV/8XB+qU66L1MMvKCfiEC1y7sxWg/SXBJVvPn5RyUG+iRvgoKiEYkRZuZNUb2Izadh4KY+C+jkMZcP/YEyBTcG/ApzMujAcp+1hJaCLxYbVAsaGwaTb6sRGwh/OnlgQ3TLXiZEis8Sg/CJ0Cb13zZgYOJsWq1c/cMD69SRH6cLVGr8d3lQaBS5FmBLsZXCOINk0y7eSoYBfQWgqI6zY6N5efauXMSVl8WAvg9bl2uUO73ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WU3hs3ThGFKb5mr3PKmEOXHv0t+rgrytWFEYk6SQI8=;
 b=OID7a02v6G9CA+aaWuLSe8LJhujM4sTmumC00BRrTAHcz49LyqToRSc5WxPDbdqNMuEKgu7i0+o9i6uonDQ7CHM+IPU4/cxDHh1nJZ1uaWiL6uUf3MoZCGeBTxOj7jD8kwnghlrCu6e9y1neWFhfRJhFBJ/+6/ORMsKB69fX1OE=
Received: from DM6PR02MB4426.namprd02.prod.outlook.com (20.176.106.156) by
 DM6PR02MB6187.namprd02.prod.outlook.com (10.141.164.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 07:20:22 +0000
Received: from DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::c084:a7d0:ee5d:4673]) by DM6PR02MB4426.namprd02.prod.outlook.com
 ([fe80::c084:a7d0:ee5d:4673%6]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 07:20:22 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Tejas Patel <TEJASP@xilinx.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
Thread-Topic: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
Thread-Index: AQHV0ES+oJkeVmCLSEim2Z6Yhdi7uagJJAiw
Date:   Mon, 3 Feb 2020 07:20:21 +0000
Message-ID: <DM6PR02MB4426801844A0D91FEB4E6977C1000@DM6PR02MB4426.namprd02.prod.outlook.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=MNARANI@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a987890-4583-413d-029d-08d7a8798809
x-ms-traffictypediagnostic: DM6PR02MB6187:|DM6PR02MB6187:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB61876C6927257EE1E7614B50C1000@DM6PR02MB6187.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(376002)(366004)(136003)(346002)(39850400004)(189003)(199004)(26005)(55016002)(316002)(186003)(8676002)(2906002)(71200400001)(6506007)(53546011)(86362001)(81156014)(81166006)(8936002)(478600001)(6636002)(66946007)(76116006)(52536014)(66476007)(64756008)(66556008)(66446008)(33656002)(5660300002)(54906003)(4326008)(7696005)(110136005)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB6187;H:DM6PR02MB4426.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQAY9ugUZaSnNKaZpSkemotzfRjaWXGQSZDfCy3axoKqumR3Iz7CJJOosfvspKJ/HugrxoYl1Mz9AKbTfLbffeVByCHWytuOdOIfbxrp8eRXFru26FU1ShRDUuo2aumw2z6qTy/5Sev2QJ9S7A0tLRxLvnNfqgZKZVyMlNY4GWKimJGlOeXvrHI8nPF0bIe8HVgBu0FXerfIYo1QoX/a3HKitVvWevQKgjiE3rmLwXghAYFP+TFfTLePTJUoQmd42FLSM0KSbTlhkqlThCbdiWTMLmJntRFyYlhpO1BXiV3TuUgNUVoPJeh8xuA4se8tnDnevNqahC5/Hldib6RBBB9MbAfK9ZLbT6EkLqPQTCGGvsAA37WEj5BBLkJAVmFcDyHmuoVEP9X7JmBMPRLP6AVpRbhZ52Gt/w4m5pQhamf6gYkCA6HpOqQ/o572l0qC
x-ms-exchange-antispam-messagedata: rrMtbTRsY3CvCmae7oKEZ9/KTqHkOVB3gd5wu6isMIzwAxnKj0GndCWXUfFaNIFk+5L0NFtctkgCTJcGGvTA6+FpwYlgOCCdICevgB4BM+CWSe7L8+TYSCCBM4PpxB7USL0T8RDCEIq5hOe6f0mlkA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a987890-4583-413d-029d-08d7a8798809
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 07:20:22.1476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iceOcwW4gHWdPwoaulg4JxCrlBBH/cdOvTCNk9hsiK9xltxA8aLDCon0iesnXz9xwoiaASFzq2oaKXyhxIa1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6187
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ping!

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Tuesday, January 21, 2020 3:52 PM
> To: Michal Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> ulf.hansson@linaro.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Nava kishore Manne <navam@xilinx.com>; Manish
> Narani <MNARANI@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; l=
inux-
> mmc@vger.kernel.org
> Subject: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
>=20
> This patch series includes:
> -> Mark the Tap Delay Node as valid for ioctl calls
> -> Add support for DLL reset in firmware driver
> -> Add support to reset DLL from Arasan SDHCI driver for ZynqMP platform
> -> Fix incorrect base clock reporting issue
>=20
> Manish Narani (4):
>   firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to the valid list
>   firmware: xilinx: Add DLL reset support
>   mmc: sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms
>   sdhci: arasan: Remove quirk for broken base clock
>=20
>  drivers/firmware/xilinx/zynqmp.c     |  2 +
>  drivers/mmc/host/sdhci-of-arasan.c   | 59 +++++++++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h |  9 ++++-
>  3 files changed, 68 insertions(+), 2 deletions(-)
>=20
> --
> 2.17.1

