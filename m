Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0227BC4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8332F2224F
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 09:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ottlg8b0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKPIqn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:46:43 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:3811
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbgKPIqn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 03:46:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opn/t5GuN1l0EeWSAqp0z4qlGNlA1eZnFBxwjq9zUcJrHGOXOAR3A0AJjMM7TsSx9BoiJhVU4fxp+yZQm+n6OIZhILz6LDgfIzIkdfc1aH+UhbjEYQfzk+E6a/uxHYuIo4J8Gz4qzYDykySW3rhvOC6OorKK6OwOCwJb8tzcuvYsHSZ24SswVy0fTAK4f3NiG+KOohJBPltwkXzkd2jp+r7uDiBLJrgDYjP+YNdocGO4nAY+EyrjA91N/rnPn2o/6hmXIPVFpHPFO/9w9h9VszCi/AbYaoQvIio3nA7aLoVuJYJF65Agn020V25sDcklUH7y8bP4XNuzQjG22m25kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4S0ciZbgVuZOEI7SRTLepUKDXjsNROv/k07G8WInyY=;
 b=klUHxNJSuTcjzj6oy6E3/bjKVNNN5yqL45DPMKowDl0ePP4RcKY+FZaiNMaLFeAkjK06CB7zpKY3sn0ak0Qn/VL5tUBuXHyEvvlKwp71J2X6AlNInP4U15cenJWpoT+nI9xEn2iKR4edSGomqgBzSoGzwiH8kJPgUgnJXlUPKlCGYE5T1y+W7oYtbV6cW3gl89P1BzwH1YBWnC17Sl9QuiNDPa07TLPrEDj6RyhbFZCynTAmHeWjeY1aF88MIGl+vznNr9H0Aj4K4+ExUaKQdSiPB6vTSljtOu0/t1WOsKI3R4+SBV0/uTpxrCL/fbM8J/8h2I8yfxZTVvCvOlX9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4S0ciZbgVuZOEI7SRTLepUKDXjsNROv/k07G8WInyY=;
 b=ottlg8b0UmKd8Zb1vn8veISBHd2GXccbjulUPOHgv0yYKZHxMgCX14LoySi42404KUFS/Ea/2lSzTNcTML5RfaiYE9NKfdaryWkSUMmzrc4/sN5hQLC3c8eyUjR7NEeDLU2WxhAVUB2ni/3T1x4vX+TBENc95NyyWaMkZPs5AxU=
Received: from BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10)
 by BYAPR02MB5064.namprd02.prod.outlook.com (2603:10b6:a03:71::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 08:46:39 +0000
Received: from BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b]) by BYAPR02MB5896.namprd02.prod.outlook.com
 ([fe80::1876:e714:1c03:e89b%6]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 08:46:39 +0000
From:   Manish Narani <MNARANI@xilinx.com>
To:     Manish Narani <MNARANI@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Sai Krishna Potthuri <lakshmis@xilinx.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
Thread-Topic: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
Thread-Index: AQHWt4jdqyLias1MGEyvXezJC++3FanKeOJg
Date:   Mon, 16 Nov 2020 08:46:39 +0000
Message-ID: <BYAPR02MB58967C89CA4D09E5F9F39E5EC1E30@BYAPR02MB5896.namprd02.prod.outlook.com>
References: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [149.199.50.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 869217fb-6bc2-45e8-fe13-08d88a0c2299
x-ms-traffictypediagnostic: BYAPR02MB5064:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5064AF11650E8AD4A95E316CC1E30@BYAPR02MB5064.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TabD8AaAbX8wc6ZaZK52J1pp2W4txzYKaPaAa8xd8r6u1mgcSSmCFZK6+4A5U0JDCYYKcxipXqw+VHascdVrYFZqWL6bXYLqcvSSFS8rHrnQ7LBiAp6oYIG9/atJr2W2FlC5sOy+/5hDRizoy80XOHbVEyQJw6Rklq5jKA9fCMMg0eAdjXprFtnpjvcxEQwHLC6h251WJq4bN4HaYquvwy0H+SxttIQL+bLb8PhU2SbevUZVyBMi00Exz5zohuZdl+OYSMgro5LILWwj3xS3dRyQdnxD2Y5KLku0BOv5Wkzxs9ponsU85LFBpL0XIOI9YaQNrr82tnf8Sivv8RXRHFxB1KzfvqxCj16kA0CyUdEypS7V81Nj9XBDm65cTfQQwJhgkcCnvzAN6lJ0bd/BjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB5896.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(346002)(136003)(4744005)(2906002)(66476007)(66946007)(66556008)(66446008)(5660300002)(64756008)(52536014)(76116006)(33656002)(54906003)(110136005)(44832011)(966005)(478600001)(316002)(9686003)(55016002)(26005)(53546011)(6506007)(4326008)(186003)(107886003)(71200400001)(7696005)(83380400001)(8936002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: v9Qy57UCDY5iNL1r3jPsC2u6PidNnvOSuNK00SUqsQp9zCWPC0UdOLkf3OAmd0PNzRFoT6QCzL1kzuH7NVwS3suXYlSdFCUNkGEgEpksHiLFa35SOEGMOqEHQQ5ATGoXdhtGPvFSXwUbP9hqC/Awd+jOsMw+FkozRZBLPhWb5CLIqdGojOAJ9F05ViOGBJ/zqCsjGlS0PhycV9PwUa+5bpiOUyDDqZ21obRYlBQnMKjbKCpyLFih73clRzUnjCVSKZXX/4Sv0tMWxhx1FRoT04GM92LUMxsMcyFOQwAItMKArVpY9sEXAioCP7qfe2zpsfzwBV/n6Q2NZB65UPvXj1q9n/vowCVNfKBMwmANDJr4foZC4r/66cFjYD8v/GM0RRBBE50OiKvCT7HYCcdTrJND1LMzFOLng5HVGzahCWY0wyZSRH8G6eM6V/SttXWnYJ+RR1iS7ah5ZPGrlnK41V8PZotdku1dHIhcYDM1EQZQEpRpkd0DV+sXGs61DNgLdo534A210BVUMoRLK1v/8M7Yvcvo2f4++PmjUlHsdK6i/j2xLIdAyoJnT2Gg0CcK96Rp84u7e6GbhRG8Jse+CdW1xntvZSJHKba4x3a0MHOR7aw53LuTXz+/+JS9Jb3OAVqmEZR1vU2H381vqW8CiQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB5896.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 869217fb-6bc2-45e8-fe13-08d88a0c2299
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 08:46:39.6054
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSaPlfmhkeze0WAfbtYB5yBqo33Ze4UviQl8k+09MkB453vZaoiz/SSyKD1Y1eyuvtYBm0WNcinax84kyKiIDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5064
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

> -----Original Message-----
> From: Manish Narani <manish.narani@xilinx.com>
> Sent: Tuesday, November 10, 2020 11:12 PM
> To: Michal Simek <michals@xilinx.com>; adrian.hunter@intel.com;
> ulf.hansson@linaro.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-mmc@vger.kernel.org; linu=
x-
> kernel@vger.kernel.org; git <git@xilinx.com>; Manish Narani
> <MNARANI@xilinx.com>; Sai Krishna Potthuri <lakshmis@xilinx.com>
> Subject: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
>=20
> Allow configuring the Output and Input tap values with zero to avoid
> failures in some cases (one of them is SD boot mode) where the output
> and input tap values may be already set to non-zero.
>=20
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.=
com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 40 ++++++------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
>=20

This patch, with "Fixes" tag added in commit, is included along with the
v2 patch series for couple of bug fixes in https://lkml.org/lkml/2020/11/16=
/142 .
Please review this patch series.

Thanks,
Manish
