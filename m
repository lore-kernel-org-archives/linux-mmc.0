Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5CC4741F
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 17:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A14C5207D3
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 17:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="SHi6JQHf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730760AbgKJRnI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 12:43:08 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:44000
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730299AbgKJRnH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Nov 2020 12:43:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bADIW7hc0gSwhV49f9fG0HXwL+xBt2Mm++BJ09q7Vi80BT+eWXw35iNcov2Na4Hax82InWEuOokL2JXOMeoGFkrHbv61mHY6buH5a2QFt+NW02fGM1xW74Ik3PFc/PidP+fDEqOLA72IanTCKnj51GfJjDnvb3TPXjpOiAXm4COMPlyrfWQQMBaXJ31lKNt7fh25q5TNw6PNnZ/33jX3aCNLeLxFC62wtlto4oUCPGDcWgfTqNWAJtZ2kejdPFnHGT9Gw1pHp1vXPjhXQheVQm5fqxRulUpB/Rr3NiGEQIv1idiSft9ykAT6Ic8PXNwNWX7YdIvt0bvIxyuIOrFFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Wg/8Fvpw5tqql03mUCPBW8TxgNTGoMVnFKQnNqpuY=;
 b=fT+FRPJefy7pSjrOD8IKu4WbOO5xRIXUHy7NbTRvBpZVH4kRhs0df36AGuNW/jJs4bq/85pvWnWMf/Wy1juJoOIEB0317xaKf0eRqW88MEbQtK+s3TwNTlqL+sf3mGtke82qERD2hox2dF2xBV44urd81uWx/lA8fj77A32xO38TWVb8VQDpWBsu5WH1pdKZF7cpxl/nRUxf6z2dB8mo6x2sUEpFV7ybCUmtSxV3QvIpkctrWvri8svQweZzAteaX1a5QPCVC8QAFicIlCSP3jughIY130Pt0UrYC2rJRJZS3mQiBMiWAKl/7TGfZSOTSloP+v5NGusKF45keCnF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Wg/8Fvpw5tqql03mUCPBW8TxgNTGoMVnFKQnNqpuY=;
 b=SHi6JQHf5PlfeNDLXvQpoB/J7xiR3h5ur4gZ0/kgdSbE15V1aOMpRZCmoyFLUB6RKwZ7qPJGaieCDGnfqErI69Qz4Mvm6oJvwNDTpPwJOjT+3j83jKxqFjIbvt84KkOS41hl8vNr68eL+cx/6H1d9aGgtpI9AuTy0OfLkPb5kP0=
Received: from SA9PR13CA0209.namprd13.prod.outlook.com (2603:10b6:806:26::34)
 by DM6PR02MB6058.namprd02.prod.outlook.com (2603:10b6:5:1d6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Tue, 10 Nov
 2020 17:43:05 +0000
Received: from SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:26:cafe::45) by SA9PR13CA0209.outlook.office365.com
 (2603:10b6:806:26::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend
 Transport; Tue, 10 Nov 2020 17:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT031.mail.protection.outlook.com (10.152.72.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Tue, 10 Nov 2020 17:43:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 09:42:08 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 10 Nov 2020 09:42:08 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=50955 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1kcXeh-0005fk-Ch; Tue, 10 Nov 2020 09:42:07 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 87D4A121188; Tue, 10 Nov 2020 23:12:06 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
Date:   Tue, 10 Nov 2020 23:12:02 +0530
Message-ID: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d679d331-d71a-4087-a57a-08d885a0128a
X-MS-TrafficTypeDiagnostic: DM6PR02MB6058:
X-Microsoft-Antispam-PRVS: <DM6PR02MB6058C74F438DB8A685BF50C2C1E90@DM6PR02MB6058.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vpZV4Cd2DteRTuUEonzQqSrQ+xfsqrdHl57FEMFy5DpnDEXOqQ8/QM4SUZPqHgl5jmCAqkEL8P7uJsB4rMFdfz1csoCM01WQVEfebYJnMqWFwLaNcPiRruCC1cxSPYWwO0BPhzrBab6f9nAjCkgM9PmmGcOLVUbwiyuyoFUt1ddQP6q9eusca7VuE4TUtDXMhXsoq4ZtqCaUTURWUtKnI5dzB955GZo9XakBAtg308hYjFc+CMzxaRJ39nNmTlUHrPF2tj1k97mkgCkxTos/7QgkwxPab8pHKPem1Gyg01cTc9TARruYNc5QZgNqyaqr/i9L10zHdYg3kgbdDoZMR4+KSUuO6PsA9Sq8gg/wmSIQnjwkYGYLxvFrJPxi3imBMaCMGNB9RwpHurQi5HZDsEBHqdnpbt7/iBytv2zyAh8=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(346002)(396003)(46966005)(44832011)(426003)(4326008)(2906002)(8676002)(42186006)(82310400003)(5660300002)(36906005)(36756003)(186003)(54906003)(316002)(83380400001)(110136005)(6266002)(107886003)(82740400003)(47076004)(26005)(6666004)(356005)(2616005)(70206006)(336012)(7636003)(8936002)(70586007)(478600001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 17:43:02.3204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d679d331-d71a-4087-a57a-08d885a0128a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT031.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6058
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Allow configuring the Output and Input tap values with zero to avoid
failures in some cases (one of them is SD boot mode) where the output
and input tap values may be already set to non-zero.

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

