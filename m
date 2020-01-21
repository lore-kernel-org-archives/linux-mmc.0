Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE21C2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0914B2253D
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GboBlKoo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAUKV4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:21:56 -0500
Received: from mail-eopbgr750052.outbound.protection.outlook.com ([40.107.75.52]:13719
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727220AbgAUKV4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jan 2020 05:21:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK6RYSZ+8GZMvlf/nEuD9wEbzSbT4me0bwggGdxgnMnLsGHcWiEkzn44ZxkLOn9eAwi6W1pBqG+GCbP+NkDewbDUPJlunTG/JCY0z9ppB1Tlp7IC0t6w6EyAyzsRMHHZzyJv0Jybg7Z29UB5V+VQKr0w1PTsVJNVjTaOcQxvPDc6sdcUk3vKfvBZJrPf7POiRauTUIFsln1CJid74y4bNXLNbNclWZ1rNJH5FfDq4ya23AwQ9XV2AGLYfzWNHYhSmdsC+wd+Z521UHoGE4Zt58LlBLrq+hsLmQFR2Y6r6Z1FSfkaE2g0aTsG7FpMqFp6e/IJ4/hvBuJYPzR0woTKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbWS3IO5nOe9odaHiUd7Lg/BE1l5j6DR7enHd18ORBM=;
 b=cX/vCbFemKeMTUEeC9fCbTexj1cFPZi5NyxH4Pnqav7XO6HrKixTWlZxg0tftn/WAeTTt9+pCsGjI907oBnVb40G8kvsHk1DJq2bxVm2BcNjpZbdCWb6rTjRL9n8vc8omSxYZgcNy/kFYoFOmJcbaRsgarcnBrGDG80p6NTUOBOhk8L4cY/T8O45mwnIIwHaxE+8m5oL8r2qXivtwBdI/k+N0OeKUPJn3G7o4uwic8m3KjIH+1Ct85ViHg5m8X0ZIeMSVSB9HBxveL25p3gbW3fhu2rv2OjcEDK6e+NT9Bre7BMZPxpUgMkfG2E9Yvtj419TXN9nYjpeefB7iSGL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbWS3IO5nOe9odaHiUd7Lg/BE1l5j6DR7enHd18ORBM=;
 b=GboBlKooiicSHE0OQFHKFyre39wElekYg4Yyzr7UY2/mYVKI4BrdU6f46zkZu1vz46X8iZn3XZdhC5QKN1woQe+olqTw8EItpwfhPkDVEEUyzxTRsS6Zy105omNvyRHbc9RvmLbMHLO6IBxZq+gnOxGSo4SVN/8sceRKadfUgTw=
Received: from DM6PR02CA0102.namprd02.prod.outlook.com (2603:10b6:5:1f4::43)
 by BYAPR02MB5896.namprd02.prod.outlook.com (2603:10b6:a03:122::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Tue, 21 Jan
 2020 10:21:53 +0000
Received: from CY1NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::202) by DM6PR02CA0102.outlook.office365.com
 (2603:10b6:5:1f4::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Tue, 21 Jan 2020 10:21:53 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT042.mail.protection.outlook.com (10.152.75.136) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Tue, 21 Jan 2020 10:21:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfQ-0000zF-BQ; Tue, 21 Jan 2020 02:21:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfL-0003Rc-7i; Tue, 21 Jan 2020 02:21:47 -0800
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00LALgUE001395;
        Tue, 21 Jan 2020 02:21:42 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1itqfF-0003Pm-QJ; Tue, 21 Jan 2020 02:21:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 0967E12007B; Tue, 21 Jan 2020 15:51:41 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        manish.narani@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 1/4] firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to the valid list
Date:   Tue, 21 Jan 2020 15:51:32 +0530
Message-Id: <1579602095-30060-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(4326008)(186003)(70206006)(6636002)(26005)(8676002)(2906002)(5660300002)(70586007)(81166006)(81156014)(36756003)(4744005)(42186006)(426003)(316002)(2616005)(478600001)(356004)(6266002)(8936002)(6666004)(44832011)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB5896;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfc6e236-800a-4781-ba8d-08d79e5bbbf8
X-MS-TrafficTypeDiagnostic: BYAPR02MB5896:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5896416797C25C6B7467E38AC10D0@BYAPR02MB5896.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5/rQz7TgY2s7lqq/FrBp4UYZrThiIVlqNacu8OzFAdmlMM7bLrnqJ6C5bAtT7s2+iZ97rmY0fFnL8Km+k3LdjvXRvuXtXShgJFR7OJ+D3w/l9OFzcyBnLrPiEwLxdZP1G+q7MLeQe+LXmpppP/POox7J5xhx8SMjqGB30LIxTXz5HMkSjU2E058Ze98/H28tZiZlfzsCcTNnkxuXM6rQaHOixlDnWWvrKT42aAXLirbWlscFFye2XSvqRs1tr/zBannkLg4FN5Uf+HZpVVOmIvsyTaTX9eH5YgvROLJWpjKEslwr1MJmNKPBy+oB5Ado4sUK5u1XjePPLY5zSgRnEmIQv9IxBljV9RVpae0BbMAnXQmSy88ngiFTnN5rNRLWvvPYhZqIsUMpY4nvVeAPJ8uwj1o5WqhpTM02m0ItoL+FeNbxolzTiU/FtR0Qyewh
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:21:52.7784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc6e236-800a-4781-ba8d-08d79e5bbbf8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5896
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The Tap Delay setup ioctl was not added to valid list due to which it
may fail to set Tap Delays for SD. This patch fixes the same.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/firmware/xilinx/zynqmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 75bdfaa08380..89eb198cee5e 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -469,6 +469,7 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
 static inline int zynqmp_is_valid_ioctl(u32 ioctl_id)
 {
 	switch (ioctl_id) {
+	case IOCTL_SET_SD_TAPDELAY:
 	case IOCTL_SET_PLL_FRAC_MODE:
 	case IOCTL_GET_PLL_FRAC_MODE:
 	case IOCTL_SET_PLL_FRAC_DATA:
-- 
2.17.1

