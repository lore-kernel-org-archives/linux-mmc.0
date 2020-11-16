Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729F6C6369E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20870221F9
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 06:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RmCvgP1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgKPGQD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 01:16:03 -0500
Received: from mail-mw2nam12on2076.outbound.protection.outlook.com ([40.107.244.76]:20181
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbgKPGQD (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 01:16:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kde9huFVAd2cfO6AFMRi4PY3cOLO/f+EHk0q11yFAxdQnr2fth5/w3jKx/rpwpm/uevuiRYcjrpRO9f+mAfG9pjDJ0fW9vHoEfUPtVzoR8oRj5QNeFyQHODvUZ5/bLgiWZwIb89fMpCo5rhzyd7/Ckc2RqPEZa1a+04wpcuWrCEd+ImwppnN1Sti7+v/FEaSpiJEk9J83kwC4YJkj7ypcVrklj1P6sDX6VxqPBdi0FStUItGshBd96dgDsABxfqDTIS7JpQ4ZrF470vaeuwUoVR5kyEYI0Ko/z/6dOTWbXpuZ190OXFor0E/gHC6F10TR1fNPmXERgowl4pX4XuYZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rqxRj7fk9vRZ7vZxg7lmIfJVMJucO5hfkvBtxlvhzA=;
 b=OxqgbcGzzrhG3u4G+ywwuJZLdywLnDEQ09ppKjhLEzsDepASui34JjxGhitG7970gOT45HI9zhNreLl8krb5YmVxbA+6VF3ITutEvhPCqySxLR1DFpQCnYjYmYoLtWErjAvmwezQydk5PQe3YIogsfgJT2Cb3veqIuWJMrxKsmJRQXQfoMKr1gYMEqD7nOLlLGa4NH9pCQ/3co6giodtbXUE9rL1kyKDClrtvMy376Q4RRBLUG+ChoWivvCV5PAhpFp44sRKzQT0FmMTTVOe1GiDtmix7sBuingY6hnn1U+0aNooN7p+2MwzygllSmkgKLo6bIH++V+q1UCbS7umiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rqxRj7fk9vRZ7vZxg7lmIfJVMJucO5hfkvBtxlvhzA=;
 b=RmCvgP1cgcT74Kia2Stbl7UEIK2mE9vwX3AMNBL4zfERZmtppPhPEeX3dE1V66kj0b/PcuboxSFdDBfgUZR7QaRVOjneUBQvtfoMXH/lIcq79lEbY9viphM8lFQTP/T2UtsoB7pk0D79Z4oZA3+yCmcAVD873T4jbd3QOVGVXYk=
Received: from CY4PR16CA0047.namprd16.prod.outlook.com (2603:10b6:910:60::34)
 by CY4PR02MB2872.namprd02.prod.outlook.com (2603:10b6:903:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Mon, 16 Nov
 2020 06:16:00 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:60:cafe::f4) by CY4PR16CA0047.outlook.office365.com
 (2603:10b6:910:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Mon, 16 Nov 2020 06:16:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 06:15:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 15 Nov 2020 22:15:56 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 15 Nov 2020 22:15:56 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 adrian.hunter@intel.com,
 ulf.hansson@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
Received: from [172.23.64.106] (port=44810 helo=xhdvnc125.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1keXnv-0007Ji-RZ; Sun, 15 Nov 2020 22:15:56 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id C221E121216; Mon, 16 Nov 2020 11:45:28 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>, Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 2/2] mmc: sdhci-of-arasan: Issue DLL reset explicitly
Date:   Mon, 16 Nov 2020 11:45:27 +0530
Message-ID: <1605507327-106818-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
References: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ddb60ea0-d9c3-4abc-9480-08d889f716dd
X-MS-TrafficTypeDiagnostic: CY4PR02MB2872:
X-Microsoft-Antispam-PRVS: <CY4PR02MB28720ED8414F55865A7808F7C1E30@CY4PR02MB2872.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VlW3FG/abpn2z2/3Jv5kP8B0uUB35YY+Er/R1HtrToQNRBOmGvGQ7NHCMJL/703NKQPAjVutojEzzahgpOTJLLfbRuaaI06eDGt/eIliaa2iNsppjEIjd09N6FZj3Jw8XHyUX8Gk2lgsjXzHzX91EEwkCx0y+IBW5C1aeTIR4mDtITqiApCzwVKWU8S156AfiDYjg3CcE2ZSiquGB+DVOsqmCJ32uf1Ppma1Aoy7bj+4b7J6dNw6bHnzdc3lM9aqCKqLakO/hn3SlXqZcpDJtQQoGx43V544B5GBrLvdNKkGRNbKt9bwwHn75NXMeB5eB6OVnwsc1ICsVFDg6d0fCWXyQikmq4yA9/1Oe9t2KNlR/KkIXDdVNUQn3spcslStjdE8MwbBHCKfaX35Xg3wglDtELTfb5upl6xPtpxSdc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(346002)(376002)(136003)(396003)(46966005)(336012)(356005)(186003)(7636003)(82740400003)(47076004)(6266002)(107886003)(36756003)(26005)(2616005)(426003)(478600001)(4326008)(44832011)(8936002)(42186006)(36906005)(110136005)(54906003)(316002)(2906002)(70206006)(83380400001)(8676002)(5660300002)(82310400003)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 06:15:59.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddb60ea0-d9c3-4abc-9480-08d889f716dd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2872
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
index 3ec5ecad637c..e066d8f51954 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -635,6 +635,9 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
 	if (ret)
 		pr_err("Error setting Output Tap Delay\n");
 
+	eemi_ops->ioctl(node_id, IOCTL_SD_DLL_RESET,
+			PM_DLL_RESET_RELEASE, 0, NULL);
+
 	return ret;
 }
 
@@ -794,6 +797,9 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 
+	eemi_ops->ioctl(node_id, IOCTL_SD_DLL_RESET,
+			PM_DLL_RESET_ASSERT, 0, NULL);
+
 	switch (host->timing) {
 	case MMC_TIMING_MMC_HS:
 	case MMC_TIMING_SD_HS:
-- 
2.17.1

