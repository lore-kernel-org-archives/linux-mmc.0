Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B02BC55ABD
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EB0F208C7
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="K4Bjixvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKPIdh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:33:37 -0500
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:44353
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgKPIdc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg0rmsr5gUiBko2uKpzL8g5ur1AppMsF2d/76uwBzFrGCoZ+hDg9iOsIPMMcHFcZiEpDjO186uBwFGruUiKGgKxZbO1wplWCYNgXebbg7JAZczXqQ7XjFfCh4Z45wfVht2pYBBLHu9NcsHEncKv+ykkVS2+bODUsKHxz+7sm1NA8h+cHqVIefUd9Lz2sdIoEUzBCi4Ju1mdUHcnsqcXj/Rd4O0hJSAyik+4/BM1RAStyQRpMK43XAFaJ0VjpeLXWzJUY99SR5CweWC41txs6o9pdkKPsVQPcxW35tw6hG9iH43SUjYiEr1AS3H83uxkEtLQ6d7Lkog8KAs4REPDlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDlnLgqE+mpMh1k2o/if8A3nKkv8KASdChtlgJNAs/g=;
 b=k2vQ/Xzzmz9eRxOJ2kDXZqtyYfAMqCTYa380X6RXOLfT/IOheHkFT7pflXDJNcW13Jiv9fwfz+l8HiGhWe/32T527B+SZaR/goiuNO+gmI7IUQJvj7w4Zr1ctobPVgKcIfinlShVF5ctE1oIQYKlzf2OLm33BWEohCk83MPZZniLHUcbiA5oTfmZJekjU9OZmRSsefqMXIuvqDEA3ObMZCKd9AQruu7GB4PofwzFytjgSX4y2ZDwjxS9sD/s24qbWpZgbxcu34/OAYm2xM7UBnb2b93UMm9YnUWofzX29o4h4bwBC0GmmJxMXzASpmSMgiNm3mWgi03ob2DhMunI8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDlnLgqE+mpMh1k2o/if8A3nKkv8KASdChtlgJNAs/g=;
 b=K4Bjixvstuk3kPWO9TRwHhj8QDmXFluN5HlPbvyRm2xAKdsJ+M1H0EH4yVVRJMX6H0u6UxFlBq4BWyhBbGfRTMCkRRmEarHjgg9vb9aw1oE4H9sQSfju0qGn6b2OpkHgqVWcUnuLehv6cc/m/slYwbzxC5olSuW3k0VLjSVE4CA=
Received: from BL0PR02CA0100.namprd02.prod.outlook.com (2603:10b6:208:51::41)
 by DM5PR02MB3324.namprd02.prod.outlook.com (2603:10b6:4:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Mon, 16 Nov
 2020 08:33:27 +0000
Received: from BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:51:cafe::c3) by BL0PR02CA0100.outlook.office365.com
 (2603:10b6:208:51::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Mon, 16 Nov 2020 08:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT020.mail.protection.outlook.com (10.152.77.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 08:33:27 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 00:33:02 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 00:33:02 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=51138 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keZwb-0002UY-CR; Mon, 16 Nov 2020 00:33:01 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6B86A121067; Mon, 16 Nov 2020 14:02:47 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH v2 1/3] mmc: sdhci-of-arasan: Allow configuring zero tap values
Date:   Mon, 16 Nov 2020 14:02:43 +0530
Message-ID: <1605515565-117562-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
References: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34249311-1c19-4c5d-b19a-08d88a0a4a33
X-MS-TrafficTypeDiagnostic: DM5PR02MB3324:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3324EABE66988278ABEC211DC1E30@DM5PR02MB3324.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2p4H1H/XMNt0FH8bLgaASDGyGzkavBUB2CHcLUAvzz+rUbR/JDonMboFjwyNEcbmn5y1VYy9qmQFh9Uy4c7bX4tUK/aV6GQCOC+HMw6j8GD24fxnlrhr3zsE/ptdpLwbvDraiXUPH36/QXXt+JUNQc3t9KmvRefe2IYokoWbXsSvxv3Qv6FLq2Fqf9dPxm15eqmVdEZrveTABN0Bg54APcVUoaFdlqGl9+niEUnXZ1nrx4C7C0idSyBhxE6wicO/H9dspOJXwbJYRW1EF/8MZKivf+gImoTjw4GVzUcYn/CJCAUBIitp4QWLEGRi/YafSDSyVchczCO3lf7Ge9ZiNDrbBFidkAtARjtgXL8wv7kNex7oz5O7owArowQ9U6khvouFBy1ZiOZ6jnBFRp4dgpa7CfFvF9eSHy1vqKXDecU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(46966005)(2616005)(82740400003)(4326008)(6266002)(70586007)(107886003)(426003)(44832011)(47076004)(7636003)(478600001)(83380400001)(82310400003)(356005)(2906002)(5660300002)(36906005)(8936002)(70206006)(186003)(26005)(54906003)(8676002)(110136005)(42186006)(316002)(336012)(6666004)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:33:27.0673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34249311-1c19-4c5d-b19a-08d88a0a4a33
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3324
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Allow configuring the Output and Input tap values with zero to avoid
failures in some cases (one of them is SD boot mode) where the output
and input tap values may be already set to non-zero.

Fixes: a5c8b2ae2e51 ("mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup")
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 40 ++++++------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 829ccef87426..100621e55427 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -600,14 +600,8 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	u8 tap_delay, tap_max = 0;
 	int ret;
 
-	/*
-	 * This is applicable for SDHCI_SPEC_300 and above
-	 * ZynqMP does not set phase for <=25MHz clock.
-	 * If degrees is zero, no need to do anything.
-	 */
-	if (host->version < SDHCI_SPEC_300 ||
-	    host->timing == MMC_TIMING_LEGACY ||
-	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+	/* This is applicable for SDHCI_SPEC_300 and above */
+	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
 	switch (host->timing) {
@@ -668,14 +662,8 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	u8 tap_delay, tap_max = 0;
 	int ret;
 
-	/*
-	 * This is applicable for SDHCI_SPEC_300 and above
-	 * ZynqMP does not set phase for <=25MHz clock.
-	 * If degrees is zero, no need to do anything.
-	 */
-	if (host->version < SDHCI_SPEC_300 ||
-	    host->timing == MMC_TIMING_LEGACY ||
-	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+	/* This is applicable for SDHCI_SPEC_300 and above */
+	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
 	switch (host->timing) {
@@ -733,14 +721,8 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
 
-	/*
-	 * This is applicable for SDHCI_SPEC_300 and above
-	 * Versal does not set phase for <=25MHz clock.
-	 * If degrees is zero, no need to do anything.
-	 */
-	if (host->version < SDHCI_SPEC_300 ||
-	    host->timing == MMC_TIMING_LEGACY ||
-	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+	/* This is applicable for SDHCI_SPEC_300 and above */
+	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
 	switch (host->timing) {
@@ -804,14 +786,8 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	struct sdhci_host *host = sdhci_arasan->host;
 	u8 tap_delay, tap_max = 0;
 
-	/*
-	 * This is applicable for SDHCI_SPEC_300 and above
-	 * Versal does not set phase for <=25MHz clock.
-	 * If degrees is zero, no need to do anything.
-	 */
-	if (host->version < SDHCI_SPEC_300 ||
-	    host->timing == MMC_TIMING_LEGACY ||
-	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
+	/* This is applicable for SDHCI_SPEC_300 and above */
+	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
 	switch (host->timing) {
-- 
2.17.1

