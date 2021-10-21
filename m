Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D2C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 969BE60F9F
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Oct 2021 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhJUHQI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Oct 2021 03:16:08 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:43845 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231133AbhJUHQH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Oct 2021 03:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1634800430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=86TYZPidQ+mxVXRw8yttxkDIDJR+nLwhpLS5uD6oxUs=;
        b=RXyvJqw0dd/PRvbpKAq+sSJjHE4z0ZihlXUdl9+h5A7m/EwggnV4uek+sZet14UvKJVy/q
        0OXuEYewzGoDrdGDhw2VpCWQJJqDoNQkE+E+83c3EYpCZtGJ8sXa6GUvLOnriXMAc4OLkY
        rr9r959THpswjujsyrSko5qeEJcARDE=
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-1-lEyEwUpoPXyN_vg_NF6iTw-1; Thu, 21 Oct 2021 09:13:49 +0200
X-MC-Unique: lEyEwUpoPXyN_vg_NF6iTw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/bA2AiRwGYSO18LgpX94uhQEls11sLxtCVApK8TxpdUYj/THeaL/JUydxX8TF5MM/1ghH2Z6n7lqXNNgIdM3keosgogyDeqHRGdai6IOY1apPt3J0ouv1cMpE6LwLW5jSUZ2uqvKtmUkeZg8RF2ToaKtLxqXoYEmG+JkzSnexS2sILkRASXCIjI5gfqV6Vg+O1Gk7sIk+XhPJTiZNXbrT0pR7P17jbC4rpHV71kN0I5XrQfPZcihDMdr113emoZsRz/bUr8xzwB30QHpgLzENEKuIUK+AyCeQpprtJzsDfp7wDksnqMG8xbdFQnbANprYBKizbmwUagPUNf26O3jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac/j72FDz4rJJC0pYIN84Ut92XrdhN60oX9Th+y/m40=;
 b=H5Y4k0lc31Fu80bI5cpY7HYjmrC7g9L+8vRwa85hevsL/U0DG89DCdBFPYU48ZOWH7bm4QheedOOb/s0UW8AidS9vaF6/QjO+xJ7f6PW433x7+3/h6O4U96y0TqZuK2R1uJuwQrWrDX+IOkHslw4K/QBhXEjBg25cEWEDkbM0GSrUUfSHbF5RxIV+BjBnFzvxy4dgrWVrUMcv0Gr+eF8/jP5CpPUEF2+OHRqewGxrKdjE2/P+C2j2QF2CGmhQcliz5N3oO25HT19GxYDXvVdausW64VOMR7WEWd0oljZqV/QnmS4NOUiU9rQ2fBQ0aeBwBoPz5XEbD59ADbJmBB6cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com (2603:10a6:803:4::13)
 by VI1PR04MB4271.eurprd04.prod.outlook.com (2603:10a6:803:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Thu, 21 Oct
 2021 07:13:48 +0000
Received: from VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde]) by VI1PR0402MB3439.eurprd04.prod.outlook.com
 ([fe80::88cc:32fc:2cae:3fde%7]) with mapi id 15.20.4608.018; Thu, 21 Oct 2021
 07:13:47 +0000
From:   Chester Lin <clin@suse.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, s32@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
CC:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Radu Nicolae Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        BOUGH CHEN <haibo.chen@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        "Lee, Chun-Yi" <jlee@suse.com>, Chester Lin <clin@suse.com>
Subject: [PATCH 0/3] Add SDHCI driver support for NXP S32G2
Date:   Thu, 21 Oct 2021 15:13:30 +0800
Message-ID: <20211021071333.32485-1-clin@suse.com>
X-Mailer: git-send-email 2.30.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS8PR05CA0030.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::35) To VI1PR0402MB3439.eurprd04.prod.outlook.com
 (2603:10a6:803:4::13)
MIME-Version: 1.0
Received: from localhost (118.166.56.207) by AS8PR05CA0030.eurprd05.prod.outlook.com (2603:10a6:20b:311::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Thu, 21 Oct 2021 07:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db574ffe-59f6-4ff5-6609-08d99462535b
X-MS-TrafficTypeDiagnostic: VI1PR04MB4271:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4271B2AD6FA5B88DCE96890EADBF9@VI1PR04MB4271.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMnxrXXf4L6JTib9+KE2uLYIIN714J58hBcfjaHq3aSt2PA+aJbPXIGZ2IW6CWHlp00Y947DQsEjFUdwovBwgHqJZNriz6jGU1zqKah91YKy4ymQLGHUS9LWKYUJ/4dKWO2CSOpPvrPbLVivKD/heDr3eU4uWTJ1HR7ER/QZReIYk0gdzjshi0OdI9VN8bjX9MqF7stY2IgfSxNsZLzD+8uos+2ulw+zTOP5Ft7isRjyGDZxas69Q2666ooAcy1+03fIdobCgxfdXPB/btOE4kgXfsUzPTcrxD1AT0rt87hAS3x/oePofGjxtduUi+JM+S8PmiFWE0IeWSVhWX4kjJa1cr3P0X/vD3m4LheT1bbd7T1lziHjuHm4AAEEP1VZc5zttyvanyN+O+cVNFX3aSoA73/sFdx0DYOZ5w+Lsw6iaEElz5+8biadFxh3Pgruub3eLF4G8phBgQyUCFeqQTLgS9vu0kz4URGzX4qEYYb/ATjlcMPuOYTvwQ0+DvaU4l3Pri4QKG+E2IzabfPt3Iil2AS7ijgUS0RSmJ2SadBblMhvdHZd4NU7DPbgfbvmdvIDc0n3eeMQZ7n2cY/pcyHDAS/rHBBjTqnCi0WGTklAjTJU0emthUgwbTNYe49VhLjMZxTMG+c9D17IG9ntlPNYKPIlq3ou8Ebz181OBYJAjA80KOcFdWOdrY9izrec48Y5/rTPraH55mdHqO9vR6oNYYUM4dFoJudsUfMLoLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3439.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(186003)(54906003)(66556008)(8936002)(2906002)(107886003)(5660300002)(86362001)(966005)(110136005)(7416002)(4326008)(1076003)(316002)(55236004)(66476007)(6666004)(83380400001)(66946007)(26005)(36756003)(6486002)(6496006)(508600001)(38100700002)(956004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5RjvzSZuOS6zJtXeit0lUq88JRojGvpWw1oH2DakeGyaUj5+/QmAyuR+89Ju?=
 =?us-ascii?Q?OG0cifRCC28dtr/3O7fJUykBm5pjrKDkgcjhZkpkaNUzWE42xIbtuHjsoMWJ?=
 =?us-ascii?Q?pfIDyXasoP8xiwqEpxJfz9uZhpkupgWhmO1n6hhpZd/PI4SeBCG/k6EwOYSe?=
 =?us-ascii?Q?fEirM+QqmHTvfq7GNW+dXCqXFm8wO4WXKEVsEMbYSFZ6dAaNrp1qa1UF8pc0?=
 =?us-ascii?Q?VWKiRgBT7g1Uq0JiqkVdotaFuGZUSkHrc7k6p4AszDhvm1zU0YUCl1GJpm9E?=
 =?us-ascii?Q?9l43mqzZz59DM16+BH8IM+RA99SbgbpXEIk+RNqBGIZKDSUv3BmKHNm5MQPX?=
 =?us-ascii?Q?5ohdoEahEiVmNyt8UCj876yu3aMjs/8ddf/JaUjDEd++UXWyd0t+6VuF40af?=
 =?us-ascii?Q?yxppa5Ln8AVA3mkFkpHazQzPmrLBPPAhUPsdEnFepFFxbrxszmwZuebTLpz9?=
 =?us-ascii?Q?hqDTPIX7/t6K6bNXZ85h7ni37rIe3mOGjBriVCdzonMTWu9KBCSiGX2mcXvt?=
 =?us-ascii?Q?QzssN0OmdzGQGhYYdXVOIBkc992q1dT+cRRifrzCHtAJ6b5FozRY+UMRTSZz?=
 =?us-ascii?Q?3lm6sbbEQY6+MK3UjKjNV1L2dPd1v2ystMYPJft1+TVxWLC+AVz/n95YA6aT?=
 =?us-ascii?Q?ZR78aAwOctXSSWfY7LndH75NBGEZ7HiT+FZaokZjc9Bud+K7RpaWAI6TfWj4?=
 =?us-ascii?Q?sX5nJyHbdSgAs8X7SgOl0n1OzCG87H2y7pjICBuC6HfOvnykQ0RnM4gv/5lq?=
 =?us-ascii?Q?nJZjQoGJO9vSeT8v8JqkCZcEpioS3z4N+iUV3Lup53VqgniiwTJJQyRxzqa1?=
 =?us-ascii?Q?gMB1TI0bHAsDDqcsBCDROSNfmehKWLSuJ9lBswxQCNH5HlWkEWWabg8Cfuuo?=
 =?us-ascii?Q?8yHfnrPO+an6J1Bx0KJwE/S5FIOiYpR0dvSLImEi0ncrWp3VniqTKxbYD4tL?=
 =?us-ascii?Q?Y2RItVTVm+drs25lV+f8RkIiknxmNA4qEFJfTSoc8okHpPsiaU2ArYZ+YYFq?=
 =?us-ascii?Q?cbw5pUk5pV4DpaaKJyNr9gI6ke3KCeBLEala5dSz1WZJfb8qhZECrIBFx2q7?=
 =?us-ascii?Q?IaXHgIiXU9S1bTsmmWay0mF0DVWTYyuZeQAY/ba8T7RSuIsSprVQdQaQiaWQ?=
 =?us-ascii?Q?HPk974DqER2U4U/lKYQMTT//To0StRge9JDleLxSF+zE8iQ3QXy0qEL+tmA6?=
 =?us-ascii?Q?JXn1f95LiYqU5GSqZNzKj4KAWll+5zDDjNGGjv4lTJ6fR3iyLTS9qc0RZjvg?=
 =?us-ascii?Q?yM09m3OfFLwVS8EykrmUFz5Hud07BI9AH/fbWEVIHFdmlhEkJ5mWZxdrErnq?=
 =?us-ascii?Q?rIg+8B8dDmsPTocNMiZbwNX3?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db574ffe-59f6-4ff5-6609-08d99462535b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3439.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2021 07:13:47.7339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: clin@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4271
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

This is a patch series for initial sdhci support on NXP S32G2 platforms.
In the previous work[1], only basic DTs and serial ports are supported for
minimum hardware booting. Here we want to add a mmc-host node and add
support in the sdhci-esdhc-imx driver so that S32G2 can also mount file
system from SDCard but not just ramdisk. As the first step, we choose fixed
clocks to fulfill the requirements the mmc host driver needs, and they will
be replaced by ARM SCMI clock protocol (0x14) once the SCMI feature are
added into S32G2 DT later.

This patchset has been verified with NXP downstream firmware blobs [ver:
bsp27/28/29/30], such as TF-A[2] and U-Boot[3] (BL33) on CodeAurora.

Thanks,
Chester

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tr=
ee/arch/arm64/boot/dts/freescale/s32g2.dtsi
[2]: https://source.codeaurora.org/external/autobsps32/arm-trusted-firmware=
/
[3]: https://source.codeaurora.org/external/autobsps32/u-boot/

Chester Lin (3):
  dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G2 support
  mmc: sdhci-esdhc-imx: add NXP S32G2 support
  arm64: dts: s32g2: add USDHC support

 .../bindings/mmc/fsl-imx-esdhc.yaml           |  1 +
 arch/arm64/boot/dts/freescale/s32g2.dtsi      | 32 +++++++++++++++++++
 .../arm64/boot/dts/freescale/s32g274a-evb.dts |  4 +++
 .../boot/dts/freescale/s32g274a-rdb2.dts      |  4 +++
 drivers/mmc/host/sdhci-esdhc-imx.c            | 17 ++++++++--
 5 files changed, 56 insertions(+), 2 deletions(-)

--=20
2.30.0

