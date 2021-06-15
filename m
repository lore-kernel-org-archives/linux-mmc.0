Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46C9C48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 964A76137D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhFOKqr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:46:47 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:20320
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231700AbhFOKqr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:46:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/58alMKLo+qJTMFMPJbRg3QEe80gI5qC3cX4KzJ8Afn07eCCWhJK+GVlPnVWIkttUfH0SGyxD4lxIXYT/LHZY4KfCcgi7Xa12eNZ1OU1RnZPVGry5LRt/hZtADkRPU8d5gJMr6euaz0OGjA6//+asueaHTl8obGyll0QKm1HT7a7ZZnmM+unSYIpXlmxvPBiwchdM8RhO6AbgbSgdPg15CEI94s94OrBg/7FIX7/PcELfaZsbk4tGlqFz3bJYl1edEDMei3d1vaVInBHK+HgltIaqp2cl50d65leT8C/FHFcg/HrobAM2y2Z+w6I1U1vTfHbH3M5ISwkuu68PZVhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awISeX8nP/8a7l8ZdxA4sP1jd8hT49vVAvwbW90WokA=;
 b=PTFoqAdgzILjF0pQT6NPyrjePw81WIpwFwu9xYRl7OtSlVrMJ1CecSj7POM+DUhy5maOMTL3mDKoz6lxhZCMXKgrfGYZf/hJ24aVYI5nQSbWuJVWv8JCz9XY7o35TtSEzKr03ys70n6Yq79cHCblhs1sW3Ra+qzHXCAAFM56QF3ZtWnf9KFPhDheHBZBpOwamS1DB/bIvPK+A+bi9ADrTdDRyvfBK/ejIZNj7X3Rqmy7TVYt0J36+D5b4B1yxvtXhC4bHjpRPkRYnP/vRW6K7CItWk8zxJ46DfF+X6kSekcAcXyrCTo7qkMNgkPyPCM/rlny6xZXhxwLt4q/trOgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awISeX8nP/8a7l8ZdxA4sP1jd8hT49vVAvwbW90WokA=;
 b=Jnrj0FylBDA0OXdP5hFkmd3oUa/Wnzf9xAf0l3Xn3nFP8iuKZEAEr+FX4gQNpAgKmpTt+wQFbS3kYlfp9A01ErbX+jCAxgFVpBoNat2z7MBpTGIXHTU56RhzkAQNLpUqRZdQ1yINWzR58/aFmnNQX54ZnB/zDpUQS2MDoi+QL+Q=
Received: from BN6PR2001CA0041.namprd20.prod.outlook.com
 (2603:10b6:405:16::27) by PH0PR02MB7799.namprd02.prod.outlook.com
 (2603:10b6:510:5d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 10:44:41 +0000
Received: from BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::3e) by BN6PR2001CA0041.outlook.office365.com
 (2603:10b6:405:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Tue, 15 Jun 2021 10:44:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT003.mail.protection.outlook.com (10.13.2.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:44:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:44:40 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:44:40 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49387 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6Yh-0002Y5-R8; Tue, 15 Jun 2021 03:44:40 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id CB5601222C4; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 3/7] mmc: sdhci-of-arasan: Skip Auto tuning for DDR50 mode in ZynqMP platform
Date:   Tue, 15 Jun 2021 16:13:53 +0530
Message-ID: <1623753837-21035-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d628794-8228-42cb-5465-08d92fea945b
X-MS-TrafficTypeDiagnostic: PH0PR02MB7799:
X-Microsoft-Antispam-PRVS: <PH0PR02MB77993467EF5AD42FC7B580D8C1309@PH0PR02MB7799.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYMwM86wGBDW/GLMtMVIMssZPS7MgevYAFFT0TR/4dUscIim8oqbyVCKT091/SL3SplLa35MeLmoWMZHCUsWTzu2qh6Ltf0cPaxm8PhM+Z+DCb+WOgVF+xxXdceHASIDJ/gwqyARvnsNJuhjgw5Pxt3dVVDcRDfR9mQGM5hHbIRjHD37mP9MA8r6zSQbKI9d0MfP2G6tDuoMD4LZPiWX2xL1ebIHu17jMMbpuVr4/A50ms9S9JvSDRknc5LW1NfoFfU2YxPCvSrmjZ+gqKy9KglnjnZctpyWhO7xwvOxifReiyzp1TTeBpExqeejHHolxKvdpTuDL5hBz840kWjz+xIR1beEabjIYui301b2y853n9y/nZvFE5E/s0dl4oTvnw0Z10BJ2K4Y2+z9E+3j5Ls5UkcOqMpkzVrSBKBZdtYIPaK5H4svmE3Q/NHkzXjjaJGMI3ydCz60XWOkBlmyEFLNrDIYvkkJBnjds1T5KXjRmba46bMpg6A8ZgdWzHs+U/ThFiUq7SHBAqp5NiHshO2bJXu691VQN0ZmyMHOc5G22eMhGENIhAaFuaroFgE/HfVsErDiQPKvRy2pUGinqE4GtaQ/Hksn2KfJsBSvZPU+EgyOTAkKZDJnL21WGHqxrY3Q0Q1DiBV/1vLW3qVOHKUAFRuwBroUOsvZSoGSLg4wU1w9gC0SvkbCK1vlN90/
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(39850400004)(346002)(46966006)(36840700001)(82740400003)(6666004)(26005)(70586007)(2616005)(107886003)(426003)(186003)(47076005)(7636003)(8676002)(356005)(5660300002)(8936002)(70206006)(4744005)(36756003)(478600001)(44832011)(54906003)(36906005)(2906002)(6266002)(336012)(42186006)(316002)(4326008)(82310400003)(36860700001)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:44:40.6022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d628794-8228-42cb-5465-08d92fea945b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7799
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

ZynqMP platform does not perform auto tuning in DDR50 mode. Skip the
same while the card is operating in DDR50 mode.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index b13e719..1980d0b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -894,6 +894,10 @@ static int arasan_zynqmp_execute_tuning(struct mmc_host *mmc, u32 opcode)
 							   NODE_SD_1;
 	int err;
 
+	/* ZynqMP SD controller does not perform auto tuning in DDR50 mode */
+	if (mmc->ios.timing == MMC_TIMING_UHS_DDR50)
+		return 0;
+
 	arasan_zynqmp_dll_reset(host, device_id);
 
 	err = sdhci_execute_tuning(mmc, opcode);
-- 
2.1.1

