Return-Path: <SRS0=po4a=5W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B55C2BA1E
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FE220BED
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Apr 2020 17:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="iQaybejU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDFRo2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:44:28 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:8848
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726670AbgDFRo2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Apr 2020 13:44:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oS+rS8n4KK6Wa4U7Hg9+KJg3oWiA8N72zZ/MAZMuCjyv49IqqoF7RGBmsR6IP7TFs9fhyc2HaYgWdo+HNhNAyuKk+TzG7CrSpxAU0tHPm7e49hHcfzcxSlbU2w22bk435mAYPffSmOSf5P8reBQZkZ7Gays3OjFW7HikPTDV8BDi3u8oa8Q8krAuBLtFj4Q4oJqAUf86iklZUlsh1AXBinmJWh/ZGeVZGvPO9aSrNZkT/PBiZXF5HUtt/38JicojgwPkE3pdenk9GDL/0ftHmhpqtAwhrokkn61xA9kSeFk/hlXz26KGVQCU2KFd6hqAL0eSAdsW9JY3JqgapQ/bEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7FWgjq0okTM2/qyCwHbOuT0Q6wJ7iF9RKpJVx5Xbk0=;
 b=fUBh6cyvzAtRzai1NUiatwPLW7qD/n6bUEYIdsgyEbKfX8nPZFDkNyV5FlKF9SVcq8SfqhqlWFsXUg67SbbEgm+hc84PHKkh4UPTO4Mu30JmYje9xrHR4GxllI9Xye8KqHH+h0MOzRK7oVbR10u8WTVF5eAXvvwB9Z0fxaJyN/hncyWe3x8qTqi2X7DrGCAfZcCgrbqiVpj17FW7H/b4m46bdJASG9i8JtVt2ESee1oagP6igvsZ0D//q4CSNR3+6rF/KFiG8H9rbc+D30qAvUpw6OhsXVnV3nDWLKb/gtuUhYn30eQ3OI9uhhqWtSPEDQnOPn7DyzzkmHGA14VXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7FWgjq0okTM2/qyCwHbOuT0Q6wJ7iF9RKpJVx5Xbk0=;
 b=iQaybejULtegKD9ivzCqmw4XHjBWRJ6Q7azOhOVNZz0T5hwK6UU1UZ9xphDNdiUNQDgjTjw83AHw6qX+bDHxBfpWbXLG/NZpVT00gBYKqxE8pQ1BRvgMc1zJ3oV1a1NqKC1L2e5GBDuzSt8xcYUEsUnyL7LEFhTOlaUezmIQjnM=
Received: from SN4PR0401CA0016.namprd04.prod.outlook.com
 (2603:10b6:803:21::26) by SN6PR02MB5168.namprd02.prod.outlook.com
 (2603:10b6:805:78::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Mon, 6 Apr
 2020 17:44:25 +0000
Received: from SN1NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::d2) by SN4PR0401CA0016.outlook.office365.com
 (2603:10b6:803:21::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Mon, 6 Apr 2020 17:44:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT003.mail.protection.outlook.com (10.152.73.29) with Microsoft SMTP
 Server id 15.20.2878.15 via Frontend Transport; Mon, 6 Apr 2020 17:44:24
 +0000
Received: from [149.199.38.66] (port=46069 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVn4-0007ak-U6; Mon, 06 Apr 2020 10:44:06 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1jLVnM-0001ge-GF; Mon, 06 Apr 2020 10:44:24 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 036HiK5K017991;
        Mon, 6 Apr 2020 10:44:20 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1jLVnI-0001g6-4a; Mon, 06 Apr 2020 10:44:20 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 2CE8E121246; Mon,  6 Apr 2020 23:13:39 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@xilinx.com, Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 3/6] mmc: sdhci-of-arasan: Rename sdhci_arasan_data to avoid confusion
Date:   Mon,  6 Apr 2020 23:13:32 +0530
Message-Id: <1586195015-128992-4-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
References: <1586195015-128992-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(2616005)(316002)(82740400003)(6636002)(44832011)(336012)(36756003)(42186006)(6266002)(26005)(70206006)(70586007)(2906002)(186003)(4326008)(5660300002)(478600001)(107886003)(356004)(81156014)(426003)(81166006)(47076004)(6666004)(8676002)(8936002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2af3971-a4e9-4999-ec28-08d7da52258e
X-MS-TrafficTypeDiagnostic: SN6PR02MB5168:
X-Microsoft-Antispam-PRVS: <SN6PR02MB51689008EA987F5C4CF8FCF5C1C20@SN6PR02MB5168.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 0365C0E14B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zeOhq+ReGhO/SKObqhdBgoSyieZN8BpZZqFfbas+Ye3P/fN2OkiRw+BnaxLin0fEDIJ/WPTdRo4JH9XfDikc7T4AkGCT8wlV5n9/5JpJbQLrYq2/+B9OajCwO6uh4Nel71ZTui5RdrKJVQxtyVq29nYwnqOsiY7KKKOVSGmldC9j+6NnvwAN9ovczOlZlVD8pf4CZHcH3c76CF6QVyfXXa37JNmkuaqLygKPmyxl1zuN7jw2WH0ZR11ADmMj35dUR+oh88KdXceXPiBo+jDpa6BTUzUHqeba6w5ds/OqJNXbhoAHKm4GbDeENi6nyhS9k8ob9R+d4K1nXAnTwBQ0rfpAcFS8Da4SIEmi3ev6aFdGmWXco1AWxFthLpMnLbEEI//SyUKhMHS5FJw0Xrv1XaDmMeh/6IrR2xSHzJyGv+CnOK/n+bgHlu/xCxiFAnGLRYq/ZWXNv9i8ZvLsolJhkpvhQwPYTWMvKUwwIgi/kSmnuicmCHcJdSJLMnYqWn/cba/ZjbF+2vKxEUCujHG6A==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2020 17:44:24.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2af3971-a4e9-4999-ec28-08d7da52258e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5168
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is 'struct sdhci_arasan_data' but also
'struct sdhci_arasan_of_data sdhci_arasan_data'. Rename the latter to
avoid confusion with the name of the struct.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 34403b2..72f5d83 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -365,7 +365,7 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
-static struct sdhci_arasan_of_data sdhci_arasan_data = {
+static struct sdhci_arasan_of_data sdhci_arasan_generic_data = {
 	.pdata = &sdhci_arasan_pdata,
 };
 
@@ -563,15 +563,15 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
-		.data = &sdhci_arasan_data,
+		.data = &sdhci_arasan_generic_data,
 	},
 	{
 		.compatible = "arasan,sdhci-5.1",
-		.data = &sdhci_arasan_data,
+		.data = &sdhci_arasan_generic_data,
 	},
 	{
 		.compatible = "arasan,sdhci-4.9a",
-		.data = &sdhci_arasan_data,
+		.data = &sdhci_arasan_generic_data,
 	},
 	{
 		.compatible = "xlnx,zynqmp-8.9a",
-- 
2.1.1

