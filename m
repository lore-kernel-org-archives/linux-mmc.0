Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2353BC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07F920867
	for <linux-mmc@archiver.kernel.org>; Tue, 29 Dec 2020 08:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL2IUS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 29 Dec 2020 03:20:18 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:64800
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725979AbgL2IUR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 29 Dec 2020 03:20:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePuGnbFnAankUnfhfBxE8mRIMONgkkDmEolRCZ5TJbqtHqZ6frLxMDWKQKRH1XHQb9adyhce7udi0s0gLKhPlhxrhyevARaHEubqsl5CUi/qzfvgHGMrsMYEBr6yE2W2QQhmqBTY0nyWVjeZ6mMH6SnT13YyLy0zitJ4rUeNPlnak+hHBsrHpy65yJ2LMYXaw6FMn3NAAYJKQCLOX680vXS6zz4OlBYqYpIIA0HXYtyBlJkd1PM3c1+lYPgHCLLcWyK2RURXot9dJ4kLCTSp/sRogMIbq2Yl7PQbc8j93bp6OC8SBTly517tEkdGK7wSyJxqFevGbZQtmR6Jd/SieQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X3u72+ZOHgAOinJvSGb/vEK4bwX1APmwWyY2TA7tYE=;
 b=dN5CTTj/0UMaUt1rL1nSvtOzvLrTqDMQ9BAQT8yeVsJzSvWAmOO6BrO894myyswHWewrlmUG2AHN/ncml9uxKXnZcpKARyQODnV8+DcoeDQ2iDWFqZoSv4QdlW1ijDrhQHwKryBsvnCJX79mh03cP0AIdza+kP1wC8WqHfjdzvwfXSNz07jrFGdCZCc0RY9yvyIrtl1GoIXlYVnb3VC71vsUcU/V0t0fv88kSeGf6IZV4a5qqIR2kMeLNSXpsyEbwN1TE01TKvClKhhXfMJDGCupCBR4Yr6cliIuh9WtXpzcmt0XBLgDdQyKmdLWSbnIa51RRku7fo/Oru6uQxbpFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X3u72+ZOHgAOinJvSGb/vEK4bwX1APmwWyY2TA7tYE=;
 b=o4HnawRPoLDWb1vQH3g/BdyQ4S2qI/WRWcG8x1Es+HNRXJ/moekGfew+GerKk2v0xTpUetdUIJnkx5wWnc2LuJzBIaFREd8WaLIqIWEBnrpmFgd0Nn+hqgKqfCdKoAjNzfylExIIfNMI+rwIvLDWVzSMC2U7vmnmnnpoYnbJw/c=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN8PR03MB4724.namprd03.prod.outlook.com (2603:10b6:408:96::21)
 by BN6PR03MB2851.namprd03.prod.outlook.com (2603:10b6:404:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.28; Tue, 29 Dec
 2020 08:19:28 +0000
Received: from BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4]) by BN8PR03MB4724.namprd03.prod.outlook.com
 ([fe80::e192:4c65:5936:1fb4%5]) with mapi id 15.20.3700.031; Tue, 29 Dec 2020
 08:19:28 +0000
Date:   Tue, 29 Dec 2020 16:16:25 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: fix rpmb access
Message-ID: <20201229161625.38255233@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR16CA0019.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::32) To BN8PR03MB4724.namprd03.prod.outlook.com
 (2603:10b6:408:96::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR16CA0019.namprd16.prod.outlook.com (2603:10b6:a03:1a0::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend Transport; Tue, 29 Dec 2020 08:19:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a1349b-6c29-4f2b-7132-08d8abd275db
X-MS-TrafficTypeDiagnostic: BN6PR03MB2851:
X-Microsoft-Antispam-PRVS: <BN6PR03MB28516A19434525F0394821D0EDD80@BN6PR03MB2851.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JzyrLuOkY9Mc4u2kK+Ab0zQ3NWevi5+GTURpNaOMMVPT599ZdTpGUFhUwNIJLckOPlB4Mzj+Dl5jkNkiamMRHyfaTxjOLm6xFj+5DIl6WyKErpf5O+BXwqOeeQZQfAhCD33D696oM3VdwhPViI3JkMzvY/beS7iSkgmiJOkIlm3iL46vi9oNe7nguBmyMd0wLGn08GvdXUQ5FTjiiMViY5ef22v7zS612b+B7X4PtoBf+kYToYhtvhObUa9lp8kIp7ptzR7N8zFtG279876stVA4hfov8kP1HIulIUuNdWnLqmilgp+bMhEKgFgiMpY6JKVTjOSje0qA8kOAC4xnZ9igTsnCDqGuJE2JDuNir9/PMD3+rxyX73vtzu+t3ZlB9PZhLYmqr1DWwbvcDnVxtEM1a7vR62/jhhHUWgreAGL9SdSaIJYKGQXGlbZ+Ofvp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR03MB4724.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(186003)(6506007)(316002)(55016002)(956004)(7696005)(66946007)(5660300002)(66556008)(66476007)(86362001)(1076003)(52116002)(83380400001)(2906002)(4326008)(478600001)(9686003)(26005)(8676002)(8936002)(110136005)(16526019)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Y55kubgyPH9ExcITXIAdcsnCfk5l+xmMjSv1omYsDHi58MN/biKopRTcXdRA?=
 =?us-ascii?Q?VZom6OzpsB8vziQ8ud+H6qFegaQUjaHI4q6i8FA6FW/doUotPf9RpkMFWKVn?=
 =?us-ascii?Q?MsqiVB24FNq83KQ4D6SukCQALAestKJHKTwHY/gim9jfLvTMMBo4DMI/kXvL?=
 =?us-ascii?Q?kxDDp0GiN1/oGEVIPypQBNVnHC2pElbiC8Lgxyr4GKeBx11y5j746zOgwTTN?=
 =?us-ascii?Q?OLDDCJKTAaM0XuqDJJre59mJ7A5Wd69kanv6mFdZImJr/Rmu59B6pCqNYBve?=
 =?us-ascii?Q?xEd85T3qanhBQuSUpr1c7Pr8v1m4mHKoQTOlYK3XEBo23kfXWS9ytLjiwCm6?=
 =?us-ascii?Q?qHUxk1loN+MJVpcgTVR+L72P3R/Wf00vS19Y7X0cEO7GWZMN1c/4KHwDlcmX?=
 =?us-ascii?Q?77t+5L7bba66Dv/rTwghDQjV2sGJIdI2RI1U1ZtdIm3DSjHBQ3IdnAz8vMoN?=
 =?us-ascii?Q?q9ywvMFNpwWhtRi08L0S3fpFCntDWlC+gWV6/ZTkOiXXMyqRb9Jzch4WZrFJ?=
 =?us-ascii?Q?i5c+hh5qMQypyjylm4hnXHN8ZzRdzFdFFUZ3OOA4+98Xmu9EyLmuGy89iVdA?=
 =?us-ascii?Q?KrB687RNzDJ2xM52YlPtJ/v1faL2MsY+F2jq7HkCCYxkPLz/vQ24a6qpCiNh?=
 =?us-ascii?Q?4mdQ6ADt1VmyKYx27cN+tBnShFf8SZGtQ3s47HCWvaaIMeiXR5J5d2BgjjBU?=
 =?us-ascii?Q?t7Tu6Q4oGWMA2H4zh0eQGz4jQJGYTXOwq7iixrKxBr+hDyxPdpLAuWUgcGAw?=
 =?us-ascii?Q?5A8Tas7xk3bK5HzLF+ibDHKVyN2h1WF1AxDE+6Em3oxjnCDd/bDlPhLjJt7A?=
 =?us-ascii?Q?LvRDE0e1S+eVPO5fYVdfungk11QrJJofDge8RxMgl8IUqBj92NQ16YgxDhHR?=
 =?us-ascii?Q?MMKhUrIkMt2Ev2ZVhTRFhbgREs/vc/vy5Dcckgw2MLCS5zyb6oAbfyfikrmk?=
 =?us-ascii?Q?sA+zH3CRMNewDL5wd2jetaxWeIgNj8ns4DqPoEx2Ehr+3vsjqRM60KE4a39i?=
 =?us-ascii?Q?Eyyh?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-AuthSource: BN8PR03MB4724.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2020 08:19:28.1013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a1349b-6c29-4f2b-7132-08d8abd275db
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6QuFUzHZChrwv/txSyRNv5qzbWv46aC7tyRCpeq/P06lX9cJIMb4YH0sxY9ZpNHzUjrl7XpD0DjUkXQpOy/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2851
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Commit a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for
RPMB") began to use ACMD23 for RPMB if the host supports ACMD23. In
RPMB ACM23 case, we need to set bit 31 to CMD23 argument, otherwise
RPMB write operation will return general fail.

However, no matter V4 is enabled or not, the dwcmshc's ARGUMENT2
register is 32-bit block count register which doesn't support stuff
bits of CMD23 argument. So let's handle this specific ACMD23 case.

From another side, this patch also prepare for future v4 enabling
for dwcmshc, because from the 4.10 spec, the ARGUMENT2 register is
redefined as 32bit block count which doesn't support stuff bits of
CMD23 argument.

Fixes: a44f7cb93732 ("mmc: core: use mrq->sbc when sending CMD23 for RPMB")
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-o=
f-dwcmshc.c
index 4b673792b5a4..d90020ed3622 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -16,6 +16,8 @@
=20
 #include "sdhci-pltfm.h"
=20
+#define SDHCI_DWCMSHC_ARG2_STUFF	GENMASK(31, 16)
+
 /* DWCMSHC specific Mode Select value */
 #define DWCMSHC_CTRL_HS400		0x7
=20
@@ -49,6 +51,29 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *h=
ost, void **desc,
 	sdhci_adma_write_desc(host, desc, addr, len, cmd);
 }
=20
+static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
+				     struct mmc_request *mrq)
+{
+	struct sdhci_host *host =3D mmc_priv(mmc);
+
+	/*
+	 * No matter V4 is enabled or not, ARGUMENT2 register is 32-bit
+	 * block count register which doesn't support stuff bits of
+	 * CMD23 argument on dwcmsch host controller.
+	 */
+	if (mrq->sbc && (mrq->sbc->arg & SDHCI_DWCMSHC_ARG2_STUFF))
+		host->flags &=3D ~SDHCI_AUTO_CMD23;
+	else
+		host->flags |=3D SDHCI_AUTO_CMD23;
+}
+
+static void dwcmshc_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	dwcmshc_check_auto_cmd23(mmc, mrq);
+
+	sdhci_request(mmc, mrq);
+}
+
 static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
 				      unsigned int timing)
 {
@@ -133,6 +158,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
=20
 	sdhci_get_of_property(pdev);
=20
+	host->mmc_host_ops.request =3D dwcmshc_request;
+
 	err =3D sdhci_add_host(host);
 	if (err)
 		goto err_clk;
--=20
2.30.0.rc2

