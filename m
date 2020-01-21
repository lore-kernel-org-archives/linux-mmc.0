Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0BAC33CAA
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063D024125
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TRE9Oz/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgAUKWF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:22:05 -0500
Received: from mail-mw2nam10on2076.outbound.protection.outlook.com ([40.107.94.76]:10348
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728803AbgAUKV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jan 2020 05:21:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj1kiikUC0VIuU6gVfW39P86ZbNtYBYLr/e0zfakL899MYqgbckCyPnpNY+WXe3+vgyY1li8LAROHrTgRwdzlORPjqDfpwronela2DTNv1o4llFgUapokV1aKvyq7tRdhgE/on3YYF4NQ0luXVyrxxWyyaj0QSSN9M+pP9lpC5/RPPGwTwOAEOpjF/0+mhj0brkjAGmmjO0jDG6FG3dekfQq3HMbu7oxeb3EanuS3u1zF/sw+CwEgZi2HAIVSOC7mZjQL93lBT/w1sY9St5Fskrzw2RH0JnvB6h4HSf9z+aENEBe6phuG2jFu2vtZtPqAbiYPE9LqglvlHhOtqJybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbwY3cqfAxRai/Dnhxkz3oxoBveEgWgChfQmAB3UH/k=;
 b=Zqk83Ri59Ox9h1IL8OqWmGotVeOSTyeNYqFQ5XUBUhwpnQAzD00jCfsVWNjir7SMrDoqe7zbvLUhD2Fltd6Hk/5GCUVj7JhQjpsveSGc7WB5gzVqw6vXhouvngOPpvIL3kdBwL80ytoWxrulExxKJ+VO0zBM1xJL0wXBTj5PS5Frn6hYJbs7S5ceKR4fVR49LXAE+KLtG5TYoZO2dpIFVuqQa0bEskGQHbY3Q699ExmEGOWhrIMzoKm9P52troNljs4C/sqUH/ojCTD8pd8UyXo82CMG/pZC+05i5wHXPJczk3vVOL55gMhDkDJZhn7/ceNneJ6/xF5QZMsxZ66zfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbwY3cqfAxRai/Dnhxkz3oxoBveEgWgChfQmAB3UH/k=;
 b=TRE9Oz/XDwm8IFbLecujUItNZxHWXoYudFWmZ7THQXQnn40lowiw7efjIW7PlqpCVvI7HnH+dHTNhh/X7vODcex/8Nr6GdTCN1VDGeR0eCrmnH4kgk3U/KoxSFdQRaknTXzyUou6IVwBxT1mNFSdtbkynaXu1ybleDXjINK6DEM=
Received: from CY4PR02CA0044.namprd02.prod.outlook.com (2603:10b6:903:117::30)
 by DM6PR02MB4377.namprd02.prod.outlook.com (2603:10b6:5:22::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Tue, 21 Jan
 2020 10:21:53 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::208) by CY4PR02CA0044.outlook.office365.com
 (2603:10b6:903:117::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 10:21:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Tue, 21 Jan 2020 10:21:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfQ-0000zD-6u; Tue, 21 Jan 2020 02:21:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfL-0003Rc-30; Tue, 21 Jan 2020 02:21:47 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00LALgCD001401;
        Tue, 21 Jan 2020 02:21:42 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1itqfF-0003Pp-SH; Tue, 21 Jan 2020 02:21:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 18BA3122162; Tue, 21 Jan 2020 15:51:41 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        manish.narani@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
Date:   Tue, 21 Jan 2020 15:51:35 +0530
Message-Id: <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(346002)(376002)(189003)(199004)(5660300002)(426003)(8936002)(6636002)(336012)(2616005)(70586007)(478600001)(26005)(316002)(42186006)(2906002)(6666004)(186003)(356004)(81166006)(4326008)(6266002)(81156014)(8676002)(44832011)(36756003)(70206006);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4377;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a607ba13-4729-41cc-bfb1-08d79e5bbbe2
X-MS-TrafficTypeDiagnostic: DM6PR02MB4377:
X-Microsoft-Antispam-PRVS: <DM6PR02MB4377ADCB3580FB4D032F6D8FC10D0@DM6PR02MB4377.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1voyOdRGH+ntvKWeyvt0AflNJL8umalmu1CfCx/LhKBPnk9Wwely8QJ7AHIKHSsWuGKHyuCsoHSz7I+Z8eUh+hpAWGX4poh1Ro/Q67LVNplW1ySqJ+4PqZZ1TO5bUoBm2lIVwMbdifJ/XgWjYsDgtFIKFBG4o7J1oB1ONaiVoqAb1XY3H1MV1rbEWqrnfuX0nWE7kG6W/oto8tncz4N5vARp3OocF4qFY8xBQMHfgrVo+C9Rpl+KZVqLxRdFVWp348Tb+RcUWOKU5of2qW3zOyu0HZwUtE7+8Cu96E2fFicM4u6nSAVQpTLkFO0JYxsHtiL5M4vAWtgnK5kxbxs5s+lIHlKiOSlQobdyJ7g5nJ6D2nanimcYQz+84y5GAzrnE4vbAkFGtjVuBeDQ8j0lhG9NWrlUqWcriBrj/xkxcdhFVbbRr2UZ9yOhr8WIzqdQ
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:21:52.6335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a607ba13-4729-41cc-bfb1-08d79e5bbbe2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4377
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch removes quirk which indicates a broken base clock. This was
making the kernel report wrong base clock of ~187MHz instead of 200MHz
even as the measurement on the hardware was showing 200MHz.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
State: pending
---
 drivers/mmc/host/sdhci-of-arasan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 39176ab5ca1f..0146d7dd315b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -358,6 +358,17 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
 	.pdata = &sdhci_arasan_pdata,
 };
 
+static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
+	.ops = &sdhci_arasan_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
+};
+
+static struct sdhci_arasan_of_data sdhci_arasan_zynqmp_data = {
+	.pdata = &sdhci_arasan_zynqmp_pdata,
+};
+
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -553,7 +564,7 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 	},
 	{
 		.compatible = "xlnx,zynqmp-8.9a",
-		.data = &sdhci_arasan_data,
+		.data = &sdhci_arasan_zynqmp_data,
 	},
 	{ /* sentinel */ }
 };
-- 
2.17.1

