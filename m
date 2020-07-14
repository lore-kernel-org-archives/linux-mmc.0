Return-Path: <SRS0=QsjN=AZ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D429BC433FB
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5CD221ED
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Jul 2020 19:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="tfxG78bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbgGNTMv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:12:51 -0400
Received: from mail-eopbgr680045.outbound.protection.outlook.com ([40.107.68.45]:12771
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729556AbgGNTMu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jul 2020 15:12:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ea+FiJpEGs9Xvgif/b5cy0pHFH0P+pYHjj8dDAXF82Et4XS4kQewnWfuBCwDrFYaEb9FFWPOgh9QgB914O6D6ttArsbFD/23wpvF3AcAyGUCebfJzvAbTN6SQjz3lVJYunv4obHG8UdXQ7XkqXNBZ8kNFWHdZotDJmndGYPa7IaoZw2QQVYJi37NmlwSZFP1U2pbhJQehTwhq/tk20Cw+06ychpBmptHRxdaHYItM3rIlVWAggFU11aIhevTALVMpFkOmVCPMJi1xrjzWzc8eH5/cUOXtPZR4qa3g7473PxeE1dSXm7sKwacxaXVSQKQIljmlgz49GE8wmTZkWMOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Iz2b3xrH+r+tLrV6b/JfHtOS97ymNODfcDCbuQAeoA=;
 b=ChPiGef7j9EWAuWnZ5bgHMaIWLpqtGDfJ56vpAgcOMYcwM9qDlNMazut2wLw7e3wC5STvW8FTNL4/nu/rwsI461s3J6ksaqAdz7VY6poqrwVYifH3XjdF4asvO5mcYCH1ph2Pg/WROM1kAgTz3PG4T+rW5XADPvtOtTmRR1Q3WqFilgRJAbKun/9j5flbzqYsYal5xB2DwzL3lsSz1ghbMlivGTCfvVJ5j89aMqI+pRJp9aRWlrZbyxy/KktdXu5UqfQ9EoV8BLVFcpbyGO9rBrBASUYI5ckGXvZW1aDPLDFF/b8PSiZWJD3G+ov9j2/P7Ha2mFmbbcpv7sOaw7AAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Iz2b3xrH+r+tLrV6b/JfHtOS97ymNODfcDCbuQAeoA=;
 b=tfxG78bKOtQOAs1rq6Q8Lb0gb/AX68PJaXOWAL8HqYdLbAQ6MIKGXlOscGkaTColBrfsmb3TO6LpsrjVw3GNWOPQtSulP46pE8Kg1hdXYUt+xCOglb4/ErQBkRjTNxXQXYlsOMth9nf/1AzxHIH7+w2nXqEQBHenzGKbds0I2Mw=
Received: from SN4PR0501CA0033.namprd05.prod.outlook.com
 (2603:10b6:803:40::46) by DM6PR02MB4457.namprd02.prod.outlook.com
 (2603:10b6:5:1f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 19:12:46 +0000
Received: from SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:40:cafe::6b) by SN4PR0501CA0033.outlook.office365.com
 (2603:10b6:803:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.11 via Frontend
 Transport; Tue, 14 Jul 2020 19:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT012.mail.protection.outlook.com (10.152.72.95) with Microsoft SMTP
 Server id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 19:12:46
 +0000
Received: from [149.199.38.66] (port=54826 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jvQKW-0007gO-6P; Tue, 14 Jul 2020 12:11:04 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jvQM9-0003ai-Sy; Tue, 14 Jul 2020 12:12:45 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06EJCcLp009699;
        Tue, 14 Jul 2020 12:12:38 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jvQM1-0003Z3-TL; Tue, 14 Jul 2020 12:12:38 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1CB44121134; Wed, 15 Jul 2020 00:42:37 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH] mmc: host: sdhci-of-arasan: fix timings allocation code
Date:   Wed, 15 Jul 2020 00:42:33 +0530
Message-Id: <1594753953-62980-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39850400004)(396003)(46966005)(36756003)(82740400003)(356005)(2616005)(2906002)(478600001)(47076004)(8676002)(81166007)(8936002)(70586007)(83380400001)(70206006)(82310400002)(6266002)(4326008)(6666004)(107886003)(42186006)(336012)(426003)(26005)(5660300002)(186003)(316002)(44832011);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c665dbf0-0fff-48cd-e233-08d82829e450
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4457D5DD1619582506458846C1610@DM6PR02MB4457.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mZJMBsZY4nNeY/xTyM0rH2d9TvhWxz5LA9PRIzWDXlmEiK0tTaHQeWp9ZS86K/QiUZRiz10oGLZ7tWmGn+sB5XdHWjTakjCLY3DzpDbDmFlJu/fx9zglhC5Z1MeDpgqfRj4yabljsFp2pBpqtiCL0DjI2nBzzIDVdSXYRoRO29k1i7rNm3Hw0r15s/JpA61wAn1bBJN1z/BkTVtt/BFKMi8t2PGOmYepwxAM7S51ShwyYShKLeRdmST9k5RKCzxMU3ue45Wato6qq0BgLYl0DQjzBhs+Y/cw4YD0GSb07j7FIt/vsINNrNdl2nYP7nquWx7EeeQ6wow8Qy73xkNWchDVRREB2+qRFmeNKcHcgAySzGG/dgCsipGW+nq78l/Js0in/pStdZndml/EllTGg==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 19:12:46.2121
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c665dbf0-0fff-48cd-e233-08d82829e450
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The initial code that was adding delays was doing a cast over undefined
memory. This meant that the delays would be all gibberish.

This change, allocates all delays on the stack, and assigns them from the
ZynqMP & Versal macros/phase-list. And then finally copies them over the
common iclk_phase & oclk_phase variables.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index db9b544..90e42d1 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1025,7 +1025,6 @@ static void arasan_dt_read_clk_phase(struct device *dev,
 static void arasan_dt_parse_clk_phases(struct device *dev,
 				       struct sdhci_arasan_clk_data *clk_data)
 {
-	int *iclk_phase, *oclk_phase;
 	u32 mio_bank = 0;
 	int i;
 
@@ -1037,28 +1036,32 @@ static void arasan_dt_parse_clk_phases(struct device *dev,
 	clk_data->set_clk_delays = sdhci_arasan_set_clk_delays;
 
 	if (of_device_is_compatible(dev->of_node, "xlnx,zynqmp-8.9a")) {
-		iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_ICLK_PHASE;
-		oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) ZYNQMP_OCLK_PHASE;
+		u32 zynqmp_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			ZYNQMP_ICLK_PHASE;
+		u32 zynqmp_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			ZYNQMP_OCLK_PHASE;
 
 		of_property_read_u32(dev->of_node, "xlnx,mio-bank", &mio_bank);
 		if (mio_bank == 2) {
-			oclk_phase[MMC_TIMING_UHS_SDR104] = 90;
-			oclk_phase[MMC_TIMING_MMC_HS200] = 90;
+			zynqmp_oclk_phase[MMC_TIMING_UHS_SDR104] = 90;
+			zynqmp_oclk_phase[MMC_TIMING_MMC_HS200] = 90;
 		}
 
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
-			clk_data->clk_phase_in[i] = iclk_phase[i];
-			clk_data->clk_phase_out[i] = oclk_phase[i];
+			clk_data->clk_phase_in[i] = zynqmp_iclk_phase[i];
+			clk_data->clk_phase_out[i] = zynqmp_oclk_phase[i];
 		}
 	}
 
 	if (of_device_is_compatible(dev->of_node, "xlnx,versal-8.9a")) {
-		iclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_ICLK_PHASE;
-		oclk_phase = (int [MMC_TIMING_MMC_HS400 + 1]) VERSAL_OCLK_PHASE;
+		u32 versal_iclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			VERSAL_ICLK_PHASE;
+		u32 versal_oclk_phase[MMC_TIMING_MMC_HS400 + 1] =
+			VERSAL_OCLK_PHASE;
 
 		for (i = 0; i <= MMC_TIMING_MMC_HS400; i++) {
-			clk_data->clk_phase_in[i] = iclk_phase[i];
-			clk_data->clk_phase_out[i] = oclk_phase[i];
+			clk_data->clk_phase_in[i] = versal_iclk_phase[i];
+			clk_data->clk_phase_out[i] = versal_oclk_phase[i];
 		}
 	}
 
-- 
1.7.1

