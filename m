Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC975C2BA17
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9C020678
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iPjyvEQf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDFRnu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:43:50 -0400
Received: from mail-mw2nam10on2064.outbound.protection.outlook.com ([40.107.94.64]:64832
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726703AbgDFRnt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 13:43:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWvqrc0WbvR+saNHV3FxmU625Z6OFV1smbLoUJcv/QuoaoM76D2Gf+OljKz8OJs+EiElw4s9jH22deZsT4SyCpNXDJ+k2BzRzFVjMMk6CPIPFokFDHjTnIIUAkt2rXoC7zl6B6PK/GNC/KMx2sRr3kAQ1sYQgxxVdKbCfZKjuqJpWvScufiCoNGw+kt1rkrrZCghH6PIZxN7i49j2P2M4eOxOD/0WxoB5QFRhckcsq3MEgRq4AiOzMdzIeucdjQqywWfZkrSYjos3dLa/uSEPz/a3HxGEZXwcFw0Rr8V9PKgfW+152wXtj77EHE/wNb2d+a3hwHvwwRAMXrXEOZW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7la2qJGrRTTJ84B/rnDVHIfmpYeTc8cZSGQBmczHHU=;
 b=XwAJTp/xFrkNhi9hZ0JpiKsIyW6Lt2LhzPUKIWNCnHmR0LTAZzuIBg9bJZzHStJmwUXpVgjoZ5Ww/PazEuTuWBZ9a4vhy8eURP9jOG+WROvz1B2rfzd1/sPiCEJFkh5VxHcN9QlduhkHXgZJN2LW6r7iBUddgJ9Agi8VpLpfQXxS6jrbA6LJaAzVcAZIG6+WwQyfz0jn5VTUsekkaXviMnrtNu/06Lu18tyZbniwrfOl/ul11RppROokiSOHeYmlZrhq09lNxFuAs4Vny4Um9GxbWtT8hagtTzqsw30JyE1eRptFbT3qjBL0L9AEwSxfe72x2uf9lbBQNzhNFvvHGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7la2qJGrRTTJ84B/rnDVHIfmpYeTc8cZSGQBmczHHU=;
 b=iPjyvEQfRZF8UaZCXR+TgEPJA2OQdY434/Z9roZmrEb0g1TL1c+la+kUUn9PU3Fnyvk/IeJkWRFiwhSKtUwe6oZ574VqWCQLKTwmlc2HYbkgilH2NXAinWUU4XNJRxKuUMj+Sa/OkLASr7TUW/eANZ0ORXqr0p3WEUuzhoxpayE=
Received: from SN4PR0801CA0015.namprd08.prod.outlook.com
 (2603:10b6:803:29::25) by BN7PR02MB3986.namprd02.prod.outlook.com
 (2603:10b6:406:f0::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Mon, 6 Apr
 2020 17:43:45 +0000
Received: from SN1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::73) by SN4PR0801CA0015.outlook.office365.com
 (2603:10b6:803:29::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 17:43:44 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT052.mail.protection.outlook.com (10.152.72.146) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:43:44
 +0000
Received: from [149.199.38.66] (port=44341 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVmQ-0007Zr-Fk; Mon, 06 Apr 2020 10:43:26 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVmi-0001Ne-1G; Mon, 06 Apr 2020 10:43:44 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 036HheHd017224;
        Mon, 6 Apr 2020 10:43:40 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jLVme-0001N1-1L; Mon, 06 Apr 2020 10:43:40 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 1F4631211F6; Mon,  6 Apr 2020 23:13:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 0/6] Add support for Xilinx Versal SDHCI in Arasan driver
Date:   Mon,  6 Apr 2020 23:13:29 +0530
Message-Id: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(396003)(39860400002)(346002)(136003)(46966005)(5660300002)(4326008)(107886003)(26005)(6266002)(6666004)(426003)(356004)(81156014)(186003)(2616005)(44832011)(8936002)(8676002)(36756003)(336012)(47076004)(82740400003)(81166006)(478600001)(70586007)(70206006)(6636002)(2906002)(42186006)(316002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1ea59eb-2269-4b6f-7ce2-08d7da520d70
X-MS-TrafficTypeDiagnostic: BN7PR02MB3986:
X-Microsoft-Antispam-PRVS: <BN7PR02MB3986E161E1AA41FD4CCABCB6C1C20@BN7PR02MB3986.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xNgAAF/s2BvcHhoxz65DkSdvEIeGHlTK4AzE0mEmktKXTqM67BAp/NbTDmy6AydGzwSkSZwrgqjIOEJVKFHyUyHMN4Zp3DEaJWBLp83c2xa2tGfGVaYIbku84YIOKgflDT7J+d4IYhN3RR5XYbxm/9E5aJ5aDbqw6d+juebkslXqP6d2g1zQiSDaNIJhsTLKn5a0GFqP2dpxGBtWpAwNad9EpS88UeOcrbyLVt6uXHHP8kNiqQVsSe4gjxYzQGPEDoDM5E8n7zHGtWC7Yb7QtD/WBa6s/Fsj2fjK11O86rPhOXu7ul8xRyhNPBkxHTs97yEbx1MRzQ8oQ1ZY85AAbs/q6e/+5eQppAkXzsLqNDvp20mdRoqWMWCwbyBvwa571hxvfMGfK0rIKbuQMQkTNunL0rd9Y6ZV0kuE1goxakFnj3U0hmQK/OWQy3SqAM0Yicz6h+SgkKDcuMxj+7tz43CvXt14oUqLsewY1IhV8eXd7GSL6NJjCxXasa233h/tDKXts3wHyxBiUFJNWEsPw==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:43:44.3743
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1ea59eb-2269-4b6f-7ce2-08d7da520d70
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3986
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch series includes:
 -> Document the Xilinx Versal SD controller
 -> Add support for Versal SD Tap Delays
 -> Reorganizing the clock operations handling
 -> Resolve kernel-doc warnings

Changes in v2:
	- Addressed review comments given in v1
	- Changed clock operation handling for better modularity.
	- Changed comments to fix kernel-doc warnings

Changes in v3:
	- Addressed review comments from v2
	- Move platform related structure before doing clock related changes
	- Rename sdhci_arasan_data to avoid confusion with another struct name

Manish Narani (6):
  dt-bindings: mmc: arasan: Document 'xlnx,versal-8.9a' controller
  sdhci: arasan: Add support for Versal Tap Delays
  mmc: sdhci-of-arasan: Rename sdhci_arasan_data to avoid confusion
  mmc: sdhci-of-arasan: Rearrange the platform data structs for
    modularity
  mmc: sdhci-of-arasan: Modify clock operations handling
  mmc: sdhci-of-arasan: Fix kernel-doc warnings

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |  15 +
 drivers/mmc/host/sdhci-of-arasan.c                 | 473 +++++++++++++++------
 2 files changed, 361 insertions(+), 127 deletions(-)

-- 
2.1.1

