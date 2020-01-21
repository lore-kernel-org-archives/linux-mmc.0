Return-Path: <SRS0=t5qd=3K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3F1C2D0CE
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87272465B
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Jan 2020 10:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="dtOqXwq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgAUKV5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:21:57 -0500
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:6120
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728831AbgAUKV5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Jan 2020 05:21:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nENrV76B90/nL49hB23GOd1qXIAXW93fdJDKkm1ztrc9KdMIl3N9e/CFVUSdWrsqCXqR0mmJmm4wIW5YTWk8GAnP8eXaUvs0va6WA5fqrBIX34G9Hz4kwq/bnby9R0rrEiRIf7tkUIPl3DCIuTkRE664u7WiYQqlFJrmLS3mEW1JaVwnzaMzDNnwYYPuxGWNP9t435nuVuJe6byfJwP2IMAdcOv1UxdgBFI7UkmGXQbg/EV2N4oZu7rDldRpdX6gCUZg3TBj/i7M3Zl23VH6pixd26IxR78Fs5gTx/jKc2jpqPqfUwJq8kiHorAl62v2Ufn6oucv0IR71VDvmqh86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJSKX2rj6pYwLWRX67lh36MWnhuaGoIjmki4w+gKq04=;
 b=ZZNlXjwHFYk/db23yWVoYO4F/bUATbTHm/Z2wH7ks72w39nt6sHIF4LcIz5+GvwYAQf+tSR+t6rzYlCXA+0OBrs3/D8l4VsAhzRTbTZn28SLy3ntvJCj1Fqw8vz3xuxq1vE/ZC3qF23PHA+rqTRc2/dYNz1NPoYcdx/uJI/CulL2fPV+3e+PPYKYfRRNAlpjWQz0uSb53Pm/DDru7v1e6gtbjgopoPh1SK/LGqA14TxfH0wghWtGX+yWITNjzRU0FpQrrONOLQhuq3KQuBdoZ/uqVeHOhT2/1KzQO0vibfQ02auY3Yl0a+nKc7jMDSA+4tb1oP98eGn9hFNmCc7aEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IJSKX2rj6pYwLWRX67lh36MWnhuaGoIjmki4w+gKq04=;
 b=dtOqXwq6LQQQKcxrxbumhaqyoL1Tgi6K9To/45sUHBqHF7bgLuh9EO9HsBLeni8VF1eQI73DqI2bWsFBPDFHTvl5PHPmnPR+LK3JeYZt9lOmKafP54iqKIMxOhsRdIrOvEikJ2rvXfkgMCsaAuTOyRC1SAnNzg+OOcoFkyaPdcY=
Received: from MN2PR02CA0024.namprd02.prod.outlook.com (2603:10b6:208:fc::37)
 by BY5PR02MB6242.namprd02.prod.outlook.com (2603:10b6:a03:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23; Tue, 21 Jan
 2020 10:21:53 +0000
Received: from CY1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::206) by MN2PR02CA0024.outlook.office365.com
 (2603:10b6:208:fc::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 10:21:52 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT062.mail.protection.outlook.com (10.152.75.60) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2644.19
 via Frontend Transport; Tue, 21 Jan 2020 10:21:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfQ-0000zE-8H; Tue, 21 Jan 2020 02:21:52 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1itqfL-0003Rc-4e; Tue, 21 Jan 2020 02:21:47 -0800
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 00LALghh003286;
        Tue, 21 Jan 2020 02:21:42 -0800
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1itqfF-0003Pl-Q8; Tue, 21 Jan 2020 02:21:42 -0800
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 06698121E00; Tue, 21 Jan 2020 15:51:40 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     michal.simek@xilinx.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        manish.narani@xilinx.com, tejas.patel@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
Date:   Tue, 21 Jan 2020 15:51:31 +0530
Message-Id: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(39850400004)(199004)(189003)(70206006)(70586007)(426003)(186003)(26005)(8936002)(36756003)(336012)(6266002)(2616005)(6636002)(81156014)(44832011)(4326008)(81166006)(5660300002)(4744005)(42186006)(6666004)(2906002)(316002)(356004)(478600001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6242;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ad5363b-dcec-4072-48a0-08d79e5bbbe8
X-MS-TrafficTypeDiagnostic: BY5PR02MB6242:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6242B49A30A5358495672AF3C10D0@BY5PR02MB6242.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0289B6431E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xSLM3qAhvzQ0poGOTMq/zkLqg+9V51edYq/LFdv06EwN3zfWFT7oPOAd9yrUHZOFTvHCXPUBhKVXJB7PeGJwardL4s378CTWdbTBNmGG6yLx612lkwpPIrm+97Y/7hLm/vTeQZdBIGV3vKHt5OmcuQxuR/7c38Ynd92BVE+HaXlzCsM7JwGxUxJ2sBnbC5qQtsSqgSH/qP2KTaH7x8lJTSK8W4MwaKQXe6U46sKBUnzCXyFEYVvkmkq7oAvqiPjlqHfEyjkSKlB5gJyuzjzx1NFOUbSAwTMX/um8bE6HK0Yn+xJ82deArl5KLnkte4vzcMoisi97UjKLpmxZVlnap1WiR+9TwspPvl5rwsMZMYUHEZNCKV4qOyPFckzJV20elkqH3o4SUeErLFOOJXTF0ZrCV44dIDF93AdW/UAMeeq7A8q7uztMwmnYdmDm4wEg
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 10:21:52.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad5363b-dcec-4072-48a0-08d79e5bbbe8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6242
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series includes:
-> Mark the Tap Delay Node as valid for ioctl calls
-> Add support for DLL reset in firmware driver
-> Add support to reset DLL from Arasan SDHCI driver for ZynqMP platform
-> Fix incorrect base clock reporting issue

Manish Narani (4):
  firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to the valid list
  firmware: xilinx: Add DLL reset support
  mmc: sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms
  sdhci: arasan: Remove quirk for broken base clock

 drivers/firmware/xilinx/zynqmp.c     |  2 +
 drivers/mmc/host/sdhci-of-arasan.c   | 59 +++++++++++++++++++++++++++-
 include/linux/firmware/xlnx-zynqmp.h |  9 ++++-
 3 files changed, 68 insertions(+), 2 deletions(-)

-- 
2.17.1

