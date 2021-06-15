Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41450C48BDF
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2331D6137D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbhFOKrD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:47:03 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com ([40.107.93.58]:31328
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231327AbhFOKrC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:47:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HDIXCwH8o1C/mM+xkTBmwl64fiL0H8WCHe62rtZNceVW1egfr1jWfQWKXTQOVjGGOBuwT52shgz5FCAQTTo+8ZIQjM445dVj74i81p7qkBzN91iJ+WrrH7ldVTkreoIRoVYIG3FhAj26uX0RYYAwCLGDs4EeGPoYzaE/IQAa4pHgGBMl7tabwuzdx17X2C/5MSaU7lYheFlGlq9CSfQk2HXwW2dPEecOqg3tuymUIwDi8rV5urmshafiK1CwAK4E7sXo2efDvKg+5C74uN4uMaFwJQdFHZAjSpFadn0yur/L99yX1mSdtpbmky2kPjykLuLY+w7fVWM30US8P6ngYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZAXm7TfAkASmMPEF0+iQ2b5NREZbUoyyCqWu4EIC6Y=;
 b=YswywRMkLfa+lt5jqw0eRuffcIYGLQ4v+Pky8dLjIg2/hAxHgQkfrxYVWFaNIj5UV30Ux/VptrY0/Q4rSI+nweS0DjEFpXqGA5Uhtk1Zgnw+rl1IUSNqocK3vkut904QKNkMhXnYeCNO+gtXbzo+Ih/ifayNBaQQBOlRFxHNaAFvhd6bVSR1OT9JdU4zPR4ujPQUkpAJvYOmDDcOy4tFLP4WOpnerC3mx/5BS2kMBJonwquvc1YU/LmAujLcqdddTqj1YnLLBCbAzwZsUTiao/lCzu1sKZRyWlnqa9BlsURvY2dBp9UTdCYKi38NoADBaYhoTMtLPhZqrINk4vCD8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZAXm7TfAkASmMPEF0+iQ2b5NREZbUoyyCqWu4EIC6Y=;
 b=CnAGWCv3hIxceyVi5BISn3hcoqK5ZuB16qZbJoVJCF+ZtuERXNmzmZAZ1v+fAgTKmizHZg5u90BgvRvDzrmYuglkjXUR46GNHuh3yl/u2adyROB/hWrUp5deLzP4z7w4dxZmGvDLzyQAGD108MQ3Nt4HXpwQcWJAukMBZusVtoY=
Received: from BN6PR16CA0029.namprd16.prod.outlook.com (2603:10b6:405:14::15)
 by BYAPR02MB5735.namprd02.prod.outlook.com (2603:10b6:a03:128::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 10:44:57 +0000
Received: from BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:14:cafe::1) by BN6PR16CA0029.outlook.office365.com
 (2603:10b6:405:14::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 10:44:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT059.mail.protection.outlook.com (10.13.2.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:44:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:44:53 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:44:53 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49389 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6Yu-0008Kc-Uc; Tue, 15 Jun 2021 03:44:53 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id D42181222C7; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 4/7] mmc: host: sdhci-of-arasan: Check return value of non-void funtions
Date:   Tue, 15 Jun 2021 16:13:54 +0530
Message-ID: <1623753837-21035-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a06f48b-6f1a-4cbd-b42a-08d92fea9e02
X-MS-TrafficTypeDiagnostic: BYAPR02MB5735:
X-Microsoft-Antispam-PRVS: <BYAPR02MB57357F875D036367232C3C28C1309@BYAPR02MB5735.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MuO6Oygn18YskJmuq2Cf6hms+no+Sy0ArGRVYMHySDBCSe8Rsj69/YBly4JEVIXacGroTeq6udIKIIOWWu9AX2h8bJCknJnBaKTaLNvBhr68yvxQpmpVWescrfpmNXsA2j5DwLI8efFcD/XJKDskgEdb27qihEbBKw4V3gcJAiqSMvGVDMRAjsOi/gHyy0R7VA0Uj6511xninYiwJAws1SuvGwGrYsq12zW83A2Jk7TTty0p5olZVOjlqAGx7X6YE6j4GXWjxHHUImJTmunbyNXZN3Ta6/xN7a7oQJ+df8kymz40ORgJeMpdi7KbnuyXibICDqZjJRAmwfF9ZgEDiSQOfgcOUr+4H9pAPk7Of9V7sjKz/M/aYJ4A5QLUTSB2HXgI85FtHZ50VsRr+Ceih2WYr75tjh/Zm0SKX7EavzIvEw/IVRR5nl69lAO1pLb7ZTDvmJMr3tlHJobVWMVI1nFc5Xfco9pSliPnikyqtWxvfPTaYlDJK4F9IOaw1xBgU4LpF7DLAqHPWxvEKXCVYt79TGrxAD8rKrRWb7UVFJMFnqE+Opkx+GxAiH1PvC61k8P0vTgVYJV4nVWOJqt/n31RF+5FHXNKkzXhiMtffda2oQESV+NwlLeNpsFGDViQjm37xFkxe3KAhxQPfPDIQKW6wO5IGmb34pShc97+omYlN2jVY6pASFRkDfky8pB1
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(46966006)(36840700001)(36906005)(70206006)(316002)(47076005)(186003)(426003)(4326008)(70586007)(8936002)(2616005)(336012)(36860700001)(36756003)(44832011)(5660300002)(2906002)(26005)(42186006)(8676002)(110136005)(83380400001)(478600001)(82310400003)(7636003)(107886003)(82740400003)(6666004)(356005)(6266002)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:44:56.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a06f48b-6f1a-4cbd-b42a-08d92fea9e02
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5735
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

At a couple of places, the return values of the non-void functions were
not getting checked. This was reported by the coverity tool. Modify the
code to check the return values of the same.

Addresses-Coverity: ("check_return")
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1980d0b..98671a3 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -273,7 +273,12 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 			 * through low speeds without power cycling.
 			 */
 			sdhci_set_clock(host, host->max_clk);
-			phy_power_on(sdhci_arasan->phy);
+			if (phy_power_on(sdhci_arasan->phy)) {
+				pr_err("%s: Cannot power on phy.\n",
+				       mmc_hostname(host->mmc));
+				return;
+			}
+
 			sdhci_arasan->is_phy_on = true;
 
 			/*
@@ -323,7 +328,12 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 		msleep(20);
 
 	if (ctrl_phy) {
-		phy_power_on(sdhci_arasan->phy);
+		if (phy_power_on(sdhci_arasan->phy)) {
+			pr_err("%s: Cannot power on phy.\n",
+			       mmc_hostname(host->mmc));
+			return;
+		}
+
 		sdhci_arasan->is_phy_on = true;
 	}
 }
@@ -479,7 +489,9 @@ static int sdhci_arasan_suspend(struct device *dev)
 		ret = phy_power_off(sdhci_arasan->phy);
 		if (ret) {
 			dev_err(dev, "Cannot power off phy.\n");
-			sdhci_resume_host(host);
+			if (sdhci_resume_host(host))
+				dev_err(dev, "Cannot resume host.\n");
+
 			return ret;
 		}
 		sdhci_arasan->is_phy_on = false;
-- 
2.1.1

