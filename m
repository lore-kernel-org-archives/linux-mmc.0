Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241E8C48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F616137D
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 10:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhFOKrn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:47:43 -0400
Received: from mail-bn8nam11on2051.outbound.protection.outlook.com ([40.107.236.51]:5344
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231393AbhFOKrk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 15 Jun 2021 06:47:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNIDn/6i658GapgSgA5Yt4haHC0ZkLO56q5dPNCfB8gxioywkzy1dxZ3Qc05T2qO+5cxZIJBthHKyGhD0jcL0e2Pox9GIVFlDr1HvW5VdgJ3GUlORuMQ54ix0g79rGiircp8S1H8DW7fTDubOF40TwY7ENqnOSEzgm7W6nNvTyE92GRXK7eyad7YQYCB81Y/zTAfSnW/nZHZq2Y4A5RO8daVnLGlFeoGbbM9NMvUkeT0bomFHeFshZvs6O1oVBMxtUKMTO/iiPR0JvYRaSde9jUIXQYP1zMSGmokGnR0wNZsKKWWveqQPpHtz9AQJgaXOYJe8VrZA0qOnnpPHRZOug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdBqTpgcIFoE6eOARZhuZubIdVZsLqWfeqOEE1TCt5A=;
 b=koO1jNn/BYPUvfqTBCfLj7gVdU8A9DEnG9PAeK7BtbZlKJT7URaFwSjBX0rZqZpfuMhMmnvGIS+Of5P7JRXdL74WhhqXzLDFCEb+3srY91guEVz6IUD87ZtCT+SgiqW1+Vxl1ppfm6BlazplFtE13NNeuZiBz8qx+jV4xPbotB0tsywfFI8IsWFfxwJsSSPAR9W3DzTdgjepKzVTAe34YqN2TKg8qBDFZk8m3M0HdvllaQ3Im0ceFbhQj5trczqdDyakxU6e0aM4L6mTkvsKN5+rrZtZlv8g1pAB+Nq6twiRTdpqsHNqr7eG0OUk5/aqgbo7PpGGg8BEt5vi7yBkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdBqTpgcIFoE6eOARZhuZubIdVZsLqWfeqOEE1TCt5A=;
 b=QleiqIyLi0UlQVdhPQ2rAXhIiqND9tG+CCO+7qFnkyV0WhDMrxBtN/zcrO7H9ov+h7+VqqmQ6U2K5sR8nJP6p3hWZYhgXrjs9+Yml1wCX5CrAj3w3bgzyvulR8pRVLsvUeNLRUvQITT4Fx3DZiWzBtSgDilHF7UlvOntv+zK+tg=
Received: from DS7PR03CA0225.namprd03.prod.outlook.com (2603:10b6:5:3ba::20)
 by MWHPR0201MB3578.namprd02.prod.outlook.com (2603:10b6:301:77::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 10:45:34 +0000
Received: from DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::5d) by DS7PR03CA0225.outlook.office365.com
 (2603:10b6:5:3ba::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Tue, 15 Jun 2021 10:45:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT032.mail.protection.outlook.com (10.13.5.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Tue, 15 Jun 2021 10:45:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 15 Jun 2021 03:45:32 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 15 Jun 2021 03:45:32 -0700
Envelope-to: adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=49401 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1lt6ZY-0008TK-85; Tue, 15 Jun 2021 03:45:32 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id E1CE51222CD; Tue, 15 Jun 2021 16:13:59 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH 7/7] mmc: arasan: Fix the issue in reading tap values from DT
Date:   Tue, 15 Jun 2021 16:13:57 +0530
Message-ID: <1623753837-21035-8-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
References: <1623753837-21035-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cad25c2e-e045-4ed6-d9b5-08d92feab406
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3578:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3578E8EEC7B015F20A935A61C1309@MWHPR0201MB3578.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SywYRLu1NuqtVriwaKNOLb/UkoOynuksRh8knmo8bJrVM7YqVzwy/WDtqsDizEu7qVUYW/eP2ma1cyKz7XmLiyRl6Cq1yfwYVdu9Vh65Zuc0Aghv9y4W03JH6RA/p1DyjXoH/5JPEy4GQ5xJAS1o+ids9MlsevyykSFAUPuOcj2pCAFcCzb7RLjPTQT+flgH0z5ce3HA7Gqg5/KoAK4hIrgJQCxicFJyVDEMGPM4p70WcAq3c/s67KOu5gS/nCVHAXnJZoPceBvgcAyXJiJ2Ww+OQWsJVo0olQ1f7FBRsA4UsmoHskWqWbX/aayrhGvuzYRrbYRNzyru7kbBkTA6ltHze9hiNE9k0cG5NuoV08SxV4knKIh2sGM6veskMO72Kc71ITc9tnptS/GuFUR7IkSeumZBn3P+7HsEmJAchRmk2lf/9rp2qwZYBZqkd+g7V1c/fcDazSggmJ0ysY0s4K8pp35rnObCm6HNM217g+iEZF7FFqvqCKxKl57XnXKndZfjPLu7K8xfAJSJph4BDiuzkEP0LtVQ3bos5mN45GJ8sQkpfz2Nj55ojgwUuIxSFNjbpSz3LWkNItHYxWTHS3kDmjY6l6n4Caz0/QKE++c3SpH0SlZDhDL4m3VIKpVgjMTPH7kWMTAIYkE0jJBcDFsFppKFZ5jGBDkH/xUrdQnnJra3SUCNg0FYG4TEH5lj
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(346002)(396003)(46966006)(36840700001)(2616005)(356005)(44832011)(426003)(186003)(6266002)(7636003)(47076005)(82310400003)(336012)(70206006)(70586007)(8676002)(110136005)(42186006)(107886003)(4326008)(26005)(2906002)(83380400001)(82740400003)(36906005)(8936002)(36756003)(478600001)(5660300002)(316002)(36860700001)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 10:45:33.7916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cad25c2e-e045-4ed6-d9b5-08d92feab406
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3578
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>

'of_property_read_variable_u32_array' function returns number
of elements read on success. This patch updates the condition
check in the driver to overwrite the tap values from DT if exist.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 61fe13c..3f50095 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1019,13 +1019,15 @@ static void arasan_dt_read_clk_phase(struct device *dev,
 	struct device_node *np = dev->of_node;
 
 	u32 clk_phase[2] = {0};
+	int ret;
 
 	/*
 	 * Read Tap Delay values from DT, if the DT does not contain the
 	 * Tap Values then use the pre-defined values.
 	 */
-	if (of_property_read_variable_u32_array(np, prop, &clk_phase[0],
-						2, 0)) {
+	ret = of_property_read_variable_u32_array(np, prop, &clk_phase[0],
+						  2, 0);
+	if (ret < 0) {
 		dev_dbg(dev, "Using predefined clock phase for %s = %d %d\n",
 			prop, clk_data->clk_phase_in[timing],
 			clk_data->clk_phase_out[timing]);
-- 
2.1.1

