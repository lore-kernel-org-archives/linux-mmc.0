Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6849CC43381
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 09:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1518C64ED0
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 09:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbhCKJlJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 04:41:09 -0500
Received: from mail-bn8nam12on2061.outbound.protection.outlook.com ([40.107.237.61]:23777
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232035AbhCKJk6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 04:40:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxMuExgui0jlDnccIxD6f3hE18JI7lzYN04nT0SR5Sq2njprUAPWqH0/2+5m8Mqao2eztD2QaOgjrnNJbw0vWMCF+X6cWUlYkSubxuwyAWowikqam2bkA2JcmuEAaONmwEcA9p7UD/JFtvRRUQCzQG8NBaydo3pygx8atMVEpvhbJ+6GshfrXQjQwXF7MXr6dQv5AdM1PM2lVgEfIri7sjJAhoxls+5eOBhkLAUdgq2JM0uqYHYDugNA2kaxdCsnyYi6+WR1CZZdApah9TsAsG5lNy8iHjnNQ9HTCCGkUFhva8yJl5s4mNdGcO3qc4OHhL/fooajdu28Nt/g/3rGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqRt3aOePS7X9e282GLzl8YFjE01YBWuKEoax0cVOdQ=;
 b=VHvcYIbAOcwOMF4YZRef1HsvJHJjoKtqamjEhkMuUEtZSv86sL2vrLqtZCdL8oU4beWawARkQmO7S7h4MUCCBAXmgT9KckYW5EKWHuSPEjQInpJSW6oxNziCKxODLN25t9dRVe9VPfnS4vtCiOHr79WQN5UX3Qzw3Z2Dw+jjvqHuu/07ouRQHEFCL/3L88nDEsYW0sWbFC4mipJY2JUSuACCE6dggmZggjVPKuUaC4Sl8e1/FDJ4ouxnaKSsFG309vngDpMkYBPU2TlxmhCwexD3MscxBw/alj196RCvOJWRWkW2EgipSGIWE+dsdPvxrPn0r31u3f5n6Ktfklyk1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqRt3aOePS7X9e282GLzl8YFjE01YBWuKEoax0cVOdQ=;
 b=occ0e0XNIBS6PQUS7rOezj8ve7qmyzbEHz4dmPCgOTRafOEW8JiDYorbXsqfYN1PzJhCfBPZN+kEn6ja06loqG8goJpKf69quF735QwdfC5rX4a1CwUSW0iDx1v7Z3fg99GtBFTaDb+zb6lx3GpGdraL3ZxVblTq9PEChnEmPbQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN3PR03MB2402.namprd03.prod.outlook.com
 (2a01:111:e400:7bbf::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 11 Mar
 2021 09:40:55 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 09:40:55 +0000
Date:   Thu, 11 Mar 2021 17:40:46 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci: Use "mmc" directly rather than "host->mmc"
Message-ID: <20210311174046.597d1951@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0047.namprd02.prod.outlook.com
 (2603:10b6:a03:54::24) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0047.namprd02.prod.outlook.com (2603:10b6:a03:54::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 09:40:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c537ec63-ac28-4cd8-1eb8-08d8e471c48e
X-MS-TrafficTypeDiagnostic: BN3PR03MB2402:
X-Microsoft-Antispam-PRVS: <BN3PR03MB2402577D5927486940735CE7ED909@BN3PR03MB2402.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:446;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MSAwRS05vk4Z8nbV6Itf8dae8cJvIuM/he6YvIqk+VYTDRTaql9F1rKwt0RKgKK3qzmW6hijr8K+GLYb8n9VhY36D8AKSz+N9JmWkdEXxv86j1tW+EGoAYljKaKgqQRTebf+xpqkO27ho+gj3lb4C+z1/mzJdX91BB3gFcW9mMGv6ycN8uFUETeBG7IFV949j4nIFamtDTSUBxCBtTkbSgdZtBzjs/RZeABr+NcLwyK+uV7QJ8G5woN1OYoSrS3XI4KHDcXaGZ+jfMABnZOnWSAQSHhopL+j6DoGV+K7xI9ThzkD0j5c27oiOCIyMdKy2HTXYTnl7aA2nXjkX3SfhSaxElnaZphKlc5i43K8UibA02VfKReLPFCo7B6hSVZG5INADhKYgnW8iSC5WPtrXck2XBYLu7E5xyJDN8b5VNFVksm2jjyNfra90MsBH7VLBpH9tS5eCmGYzYteo9NNS6H1onXvxTc9ZIYxyyFeOWaNoAUefsEar07RtLnbaWmzvsv7xjrzkQ/VD5FmS1jM2A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(136003)(366004)(39850400004)(6506007)(86362001)(478600001)(2906002)(9686003)(66476007)(66556008)(66946007)(6666004)(956004)(55016002)(1076003)(8936002)(316002)(8676002)(26005)(4326008)(110136005)(16526019)(186003)(52116002)(83380400001)(7696005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sbLurIdeOvcC/9Q2lTMfNYTz+G/ITYd4F/ysgYe04oAbAgq+ZWavmM2gKBlO?=
 =?us-ascii?Q?14fy6OjiXxMXQFaCNicoN7P0gwfMJDayMF5r3dz83h6gaPrGt/SJ1L6pQbpW?=
 =?us-ascii?Q?pCV39wqVBIbElgRVNU9t/lPQk85nChgdoFx20Q1vZj8Wnt2d9Int27pMQEfX?=
 =?us-ascii?Q?rcrLTNgQIsA643+hp6vLnJGrMfBdQBr18kMpieOn8mNipwuNA6AxGqcMGrfb?=
 =?us-ascii?Q?sRii6UNVeDLRC9eYxZ9aT5BpMeBjgortjiB9WGv6LHQVJpS6mx/2LZ9gOKBi?=
 =?us-ascii?Q?vEPdoeZr9Xj7nHbd1r7u5EWKGBBArySBA7SAH0SQ2kIlxiiDhj6cKgmsQ45a?=
 =?us-ascii?Q?y7kw8MnSM2IaWyjOlY4+yXdYqPXYATPvksQnd20mzsIhVW148P/eADiRbGCG?=
 =?us-ascii?Q?sNxauzodZg4dw+c8VHpJ7mdTi/eWtnK4H/DKu/n1dVMhdHwxiRE0g2TEstzm?=
 =?us-ascii?Q?BMQYG3gdTyPMoyixv35oD5/fGYGkrIKprQ2I+GikVHGh10dk+xXl/qP/2bx/?=
 =?us-ascii?Q?pHwwV0cjlwkyvNRQ/pXcUJrTfXWAIbfGekSuEw25PnA45IgsLyNbfZz64YUq?=
 =?us-ascii?Q?rmBeRYPN31taJ9QUrZILXI0C4z3DkPyJX/7zLKl8hi0RYBHAiAmuCtGv4iLB?=
 =?us-ascii?Q?eQJZ8t2DvfgbEZE9v2j6tVMY5JkpN4dA3wG2jVj5bD4W4JNbVSFz4To6f7cy?=
 =?us-ascii?Q?4H6KQb9im3NffmV2WP8n34LQLZtb46o8CDb64KTnRRTyazpDGu9V1Fhk9jfr?=
 =?us-ascii?Q?sh82gN7VXV3Yfecv9Huz2jExxoTVesIioocxKl1sQY56CcL9p7f2xmPpYb5u?=
 =?us-ascii?Q?T1hVGyY7WvN/oz3bUhC2cVHcVZR/xPxhg0HNjcfyLQn1ZqSMx877xVR1uk7j?=
 =?us-ascii?Q?zXYC7OZ8l3roteI04dMnLQ/CrxWYSibsTk0oJTn7QOtcudAe92yZ3Qw9HVX1?=
 =?us-ascii?Q?Bn4xojPdgf9x6zchVhsmufpjZG94h9GwC4jIUtEYhdVGssoQcO7UHg2+QJ1h?=
 =?us-ascii?Q?n4DIZr1d9Dqo1RNzMCvVIKCtRyoeVH2gvxQUfPqjbCvnsSZOkYCCWH24u9xs?=
 =?us-ascii?Q?/J0BWqiHWZrMYAUiCabLMOIM8Y1QR2tlQMT14GYytk8v/EbNTkVd8c/dv++G?=
 =?us-ascii?Q?4Sedl8ndHa/OJyIFJI8lKzugHJ1dgekZtGT8rbCZSjxtA0Xk4/PK3T72YMkP?=
 =?us-ascii?Q?kWLgArYfLGGTRUznx6+qTmEV8WAQylaJ2eJS2aDCeajBooZLeyORwlywQUlk?=
 =?us-ascii?Q?WjdfQhBAkwtLRXAxt3IrlnHi3uaYh0P/CYiwdTGzHRzISpGuChZqROZd+d3H?=
 =?us-ascii?Q?LsEyv7QoytH5uwN7yvzuZXtn?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c537ec63-ac28-4cd8-1eb8-08d8e471c48e
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 09:40:55.4330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQAGM78o7+BhfZLxwuwG2C9t3Jd9Q41hZ682cJMnZm1SSo21pIo7cwaYP4fvii+tOQ4k70tDZt84iMJZndhQyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR03MB2402
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Clean up the code to use the "mmc" directly instead of "host->mmc".
If the code sits in hot code path, this clean up also brings trvial
performance improvement. Take the sdhci_post_req() for example:

before the patch:
     ...
     8d0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     8d4:	910003fd 	mov	x29, sp
     8d8:	f9000bf3 	str	x19, [sp, #16]
     8dc:	f9400833 	ldr	x19, [x1, #16]
     8e0:	b9404261 	ldr	w1, [x19, #64]
     8e4:	34000161 	cbz	w1, 910 <sdhci_post_req+0x50>
     8e8:	f9424400 	ldr	x0, [x0, #1160]
     8ec:	d2800004 	mov	x4, #0x0                   	// #0
     8f0:	b9401a61 	ldr	w1, [x19, #24]
     8f4:	b9403262 	ldr	w2, [x19, #48]
     8f8:	f9400000 	ldr	x0, [x0]
     8fc:	f278003f 	tst	x1, #0x100
     900:	f9401e61 	ldr	x1, [x19, #56]
     904:	1a9f17e3 	cset	w3, eq  // eq = none
     908:	11000463 	add	w3, w3, #0x1
     90c:	94000000 	bl	0 <dma_unmap_sg_attrs>
     ...

After the patch:
     ...
     8d0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     8d4:	910003fd 	mov	x29, sp
     8d8:	f9000bf3 	str	x19, [sp, #16]
     8dc:	f9400833 	ldr	x19, [x1, #16]
     8e0:	b9404261 	ldr	w1, [x19, #64]
     8e4:	34000141 	cbz	w1, 90c <sdhci_post_req+0x4c>
     8e8:	b9401a61 	ldr	w1, [x19, #24]
     8ec:	d2800004 	mov	x4, #0x0                   	// #0
     8f0:	b9403262 	ldr	w2, [x19, #48]
     8f4:	f9400000 	ldr	x0, [x0]
     8f8:	f278003f 	tst	x1, #0x100
     8fc:	f9401e61 	ldr	x1, [x19, #56]
     900:	1a9f17e3 	cset	w3, eq  // eq = none
     904:	11000463 	add	w3, w3, #0x1
     908:	94000000 	bl	0 <dma_unmap_sg_attrs>
     ...

We saved one ldr instruction: "ldr     x0, [x0, #1160]"

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2d73407ee52e..b1afabab9cae 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -907,7 +907,7 @@ static void sdhci_calc_sw_timeout(struct sdhci_host *host,
 
 	if (data) {
 		blksz = data->blksz;
-		freq = host->mmc->actual_clock ? : host->clock;
+		freq = mmc->actual_clock ? : host->clock;
 		transfer_time = (u64)blksz * NSEC_PER_SEC * (8 / bus_width);
 		do_div(transfer_time, freq);
 		/* multiply by '2' to account for any unknowns */
@@ -2269,14 +2269,14 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 		if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK &&
 		    host->clock) {
-			host->timeout_clk = host->mmc->actual_clock ?
-						host->mmc->actual_clock / 1000 :
+			host->timeout_clk = mmc->actual_clock ?
+						mmc->actual_clock / 1000 :
 						host->clock / 1000;
-			host->mmc->max_busy_timeout =
+			mmc->max_busy_timeout =
 				host->ops->get_max_timeout_count ?
 				host->ops->get_max_timeout_count(host) :
 				1 << 27;
-			host->mmc->max_busy_timeout /= host->timeout_clk;
+			mmc->max_busy_timeout /= host->timeout_clk;
 		}
 	}
 
@@ -2399,7 +2399,7 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 		return 0;
 
 	/* If nonremovable, assume that the card is always present. */
-	if (!mmc_card_is_removable(host->mmc))
+	if (!mmc_card_is_removable(mmc))
 		return 1;
 
 	/*
@@ -2489,14 +2489,14 @@ void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	unsigned long flags;
 
 	if (enable)
-		pm_runtime_get_noresume(host->mmc->parent);
+		pm_runtime_get_noresume(mmc->parent);
 
 	spin_lock_irqsave(&host->lock, flags);
 	sdhci_enable_sdio_irq_nolock(host, enable);
 	spin_unlock_irqrestore(&host->lock, flags);
 
 	if (!enable)
-		pm_runtime_put_noidle(host->mmc->parent);
+		pm_runtime_put_noidle(mmc->parent);
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_sdio_irq);
 
@@ -2837,7 +2837,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		goto out;
 	}
 
-	host->mmc->retune_period = tuning_count;
+	mmc->retune_period = tuning_count;
 
 	if (host->tuning_delay < 0)
 		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
@@ -2886,11 +2886,10 @@ static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable)
 static void sdhci_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
 				int err)
 {
-	struct sdhci_host *host = mmc_priv(mmc);
 	struct mmc_data *data = mrq->data;
 
 	if (data->host_cookie != COOKIE_UNMAPPED)
-		dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len,
+		dma_unmap_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
 
 	data->host_cookie = COOKIE_UNMAPPED;
@@ -2941,9 +2940,9 @@ static void sdhci_card_event(struct mmc_host *mmc)
 	/* Check sdhci_has_requests() first in case we are runtime suspended */
 	if (sdhci_has_requests(host) && !present) {
 		pr_err("%s: Card removed during transfer!\n",
-			mmc_hostname(host->mmc));
+			mmc_hostname(mmc));
 		pr_err("%s: Resetting controller.\n",
-			mmc_hostname(host->mmc));
+			mmc_hostname(mmc));
 
 		sdhci_do_reset(host, SDHCI_RESET_CMD);
 		sdhci_do_reset(host, SDHCI_RESET_DATA);
@@ -3675,7 +3674,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
+	if ((mmc->pm_flags & MMC_PM_KEEP_POWER) &&
 	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
 		/* Card keeps power but host controller does not */
 		sdhci_init(host, 0);
@@ -3683,7 +3682,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 		host->clock = 0;
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	} else {
-		sdhci_init(host, (host->mmc->pm_flags & MMC_PM_KEEP_POWER));
+		sdhci_init(host, (mmc->pm_flags & MMC_PM_KEEP_POWER));
 	}
 
 	if (host->irq_wake_enabled) {
@@ -3691,7 +3690,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	} else {
 		ret = request_threaded_irq(host->irq, sdhci_irq,
 					   sdhci_thread_irq, IRQF_SHARED,
-					   mmc_hostname(host->mmc), host);
+					   mmc_hostname(mmc), host);
 		if (ret)
 			return ret;
 	}
@@ -4378,7 +4377,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
 	    mmc_card_is_removable(mmc) &&
-	    mmc_gpio_get_cd(host->mmc) < 0)
+	    mmc_gpio_get_cd(mmc) < 0)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (!IS_ERR(mmc->supply.vqmmc)) {
-- 
2.30.2

