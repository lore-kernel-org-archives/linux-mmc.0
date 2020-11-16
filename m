Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E70C4742C
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D3C216C4
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 08:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="abUK6fmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgKPId6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 03:33:58 -0500
Received: from mail-bn7nam10on2041.outbound.protection.outlook.com ([40.107.92.41]:19296
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726759AbgKPId4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 03:33:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8pCrG0cCvlIfnqCCKh54KDxZ1g3D6q3vQJLWqFrhM/0A7InssSuoH5EJegg/a41WuljpmWuh93CvqaderQGMG3MS8vGdjg8hyKxmdmrRp+AVzqh281wOc7Mya//AJr48MOjK/OTDBsl+1CSlj7Q3cg+S7VUmeXNkU+UX5oHn02e6Y33SOAnzxJ/VN7igrdDzr70YAOqsjyvSfVUtuRFgwGoabxDxFI29ym+7yxNWtDTlgWU/IJWbnABccGAYywKbdRI2VNakKDMZUa+hD5CuEfQKkWx706noBJ3bsVqvhWTUNWONsjxI6mRXRSqDertJixYYDzbr+bQdGo1agbedA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3PC6HKJlnagsA+B4h6NfIPrw/IhvEB6/AcFQIbXXtQ=;
 b=f5qvUQ3Nq+LzhpKDi2Z9/9Rm4aLy4IwPggLmi+vrlok5S/1PkIcaMfGeMlfxMo4zBKu3zLHm//hUpc6XjmEwsQ19skxLCT6sqbKbckNc7vgn61TrVGKkluCMK2J2Wvc1U6d0EyZdWJd2MiZm0AcZtdg4xB9DpMYkYbAtUKPfcb4PpWD3qfqvF52zsUXk3N8lDUpduyO83pSVlWTIiB4rta78JOGOAZTfpR/t3tbfgSCYK9UCaJdAdsLDoYIQ/9VrtXDGlF/friIeQ5yRjbNKOadgHf5QqLrWnwwqpot+qbRaqMt/+ISX+XPba1Rp0Vj5QDnGiCxOFN+ctkgamZLJpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3PC6HKJlnagsA+B4h6NfIPrw/IhvEB6/AcFQIbXXtQ=;
 b=abUK6fmbxeMhCITknvB2Fm3jYoxlATM0hXNHnPognMCGk3g6oWIfOGtvPR5ZXcunL7Sv6FFV6iJLokp1OEEvywuWHm3qA7EgvdruPz5BRz3pOtiijEL1xJOpXrYKYsuNogcOdAeH2U6xuuLyef4cP35XY6pGaPuOZNEx5HDIyGc=
Received: from BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21)
 by MW2PR02MB3833.namprd02.prod.outlook.com (2603:10b6:907:4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.24; Mon, 16 Nov
 2020 08:33:52 +0000
Received: from BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2b9:cafe::67) by BL1PR13CA0106.outlook.office365.com
 (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend
 Transport; Mon, 16 Nov 2020 08:33:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT038.mail.protection.outlook.com (10.152.77.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 08:33:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 00:33:28 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 16 Nov 2020 00:33:28 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=51164 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keZx1-0002WJ-Ma; Mon, 16 Nov 2020 00:33:27 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 773CB1211EF; Mon, 16 Nov 2020 14:02:47 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH v2 3/3] mmc: sdhci-of-arasan: Issue DLL reset explicitly
Date:   Mon, 16 Nov 2020 14:02:45 +0530
Message-ID: <1605515565-117562-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
References: <1605515565-117562-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd1a5bc-8152-4575-8a36-08d88a0a5931
X-MS-TrafficTypeDiagnostic: MW2PR02MB3833:
X-Microsoft-Antispam-PRVS: <MW2PR02MB3833B97203CFB2F8B9EFFBBBC1E30@MW2PR02MB3833.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0HWSx/HTmocBoXhbam/OzeRQBXETrEMZ7Jv9B4KCuCwKqABpIo/9pd4j3u93l4SBlC1XU9aAjY0ecAPV4+Gax+NuXxxGmc1AMS3ahTAuFegg9H2PpmD3jTLxRBzaNrNaG5Uk9L7pjyW2BhCLy/YW7I78Xg9d6rAIQ5LMZtgz1lAfgNW0CbaGFx7ysshvVl8QrHhSvJ35ETqpjldjzo7PPe+G36LHUztBCTsUPy17jmG5NBnxqkw/qCSpmC8CiUT647p6m5Mx3qLQYfAoKcAIoHv4WEsTqxdOkGh9xuIX/PJo/C4C232iOkrZ/+kkpWwaszuhfhsgYMHCP581kcL8edRdFnzgvvAO3FMB4qqbKi5tWnhK181c+Wlos9G+uXkP4u5+q4WvoOmTtEN7z9mX9WjPJSJT7I29ELGx5Eaxjrs=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(46966005)(8676002)(110136005)(7636003)(8936002)(36756003)(83380400001)(316002)(26005)(4326008)(70586007)(82310400003)(82740400003)(54906003)(2906002)(47076004)(2616005)(44832011)(6266002)(107886003)(42186006)(186003)(336012)(356005)(478600001)(5660300002)(426003)(70206006)(36906005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 08:33:52.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd1a5bc-8152-4575-8a36-08d88a0a5931
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3833
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

In the current implementation DLL reset will be issued for
each ITAP and OTAP setting inside ATF, this is creating issues
in some scenarios and this sequence is not inline with the TRM.
To fix the issue, DLL reset should be removed from the ATF and
host driver will request it explicitly.
This patch update host driver to explicitly request for DLL reset
before ITAP (assert DLL) and after OTAP (release DLL) settings.

Fixes: a5c8b2ae2e51 ("mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup")
Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 3ec5ecad637c..d25a4b50c2f3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -635,6 +635,9 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	if (ret)
 		pr_err("Error setting Output Tap Delay\n");
 
+	/* Release DLL Reset */
+	zynqmp_pm_sd_dll_reset(node_id, PM_DLL_RESET_RELEASE);
+
 	return ret;
 }
 
@@ -669,6 +672,9 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
+	/* Assert DLL Reset */
+	zynqmp_pm_sd_dll_reset(node_id, PM_DLL_RESET_ASSERT);
+
 	switch (host->timing) {
 	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_SD_HS:
-- 
2.17.1

