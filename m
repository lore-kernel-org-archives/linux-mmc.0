Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9F4ECAAD8
	for <linux-mmc@archiver.kernel.org>; Tue, 20 Sep 2022 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiITMsU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 20 Sep 2022 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiITMsS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Sep 2022 08:48:18 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70134.outbound.protection.outlook.com [40.107.7.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BBE6524E
        for <linux-mmc@vger.kernel.org>; Tue, 20 Sep 2022 05:48:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNbyH/hd0Tq6jE7u6a1ae6wOhJK4GH9TfEeHqHIjFRTrBFD1ordAmeJm9X6KfQLno3LVCAx8maCx+OXU0eGcTFZ1dZ11GazmwHdlcjeLnUTwgHXqhBAeuyyVmqA65QY8QKmVtl66Rzr+ehG5v9EVaUSTV20EP7iBMPXYKMkmOvHFcTrN8sUOfOqaShzvRmIqqCN0hqQoO2ecaQ5igL1SQMSR+97PWdRLvzCZutPrl+aAi0gwHtPk5Eu+LJ/cOXW+S/94RobRIbyerg04d8uPYVH+VsMT5bbST0H0El/aTIWlGegyu98z6DTS46F5hL0bb8v3+SD/hc29E8okwXRbxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nk0mC1M2enYlpE8NNMUF9+JmeLZGWIoqCXTQI9KzjOs=;
 b=fsQuThhbfspKvg6i6EZrjgd8OimzetsSVta8upLm/uVisHAUwLcWxK6/ARjuFADBoxQo7rsHNjksF6BmkIGCFlVvMRRIzmew6jBYktLmGkJP/OyjRXqtakyAGUfyL4j8HECZvtRfRlsH2099g3VKbNVY/LCvbHsYUoK5TxY6wLg/P0q83Qtf/n/Lv6z0UejL9jJdimLQ0X1dUu8LN6R1fddWrdezMv4TV+ilYq7H0yfy3B3Q4Rqd2NCIn/xqGr1YkqWEHgCoO17ylp1zQdQs8Iac1Gu6OCiYHjyj8UDgp//I62lKunprl7n/rYNN0t4X0QpvozgF5xBIA2/F5qltOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.8) smtp.rcpttodomain=wdc.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk0mC1M2enYlpE8NNMUF9+JmeLZGWIoqCXTQI9KzjOs=;
 b=TSR1VjgQQ0NMC9gHHnkYefi976QcegJZ01MERiInRMG3owEg4bpuilzrSZn74CPQyRIX/q7zSKIMbsDVpuK1Hy1l7e1RLFroWkjHsq2cgefAeBaknl8VntvlzulrvHkOsNV2F6FISb0EFiBHoVvwztkWcwJd3wVClQf0/Kyz7YE=
Received: from AS9PR06CA0568.eurprd06.prod.outlook.com (2603:10a6:20b:485::30)
 by AS8PR07MB9066.eurprd07.prod.outlook.com (2603:10a6:20b:56b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 12:48:14 +0000
Received: from VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:485:cafe::1e) by AS9PR06CA0568.outlook.office365.com
 (2603:10a6:20b:485::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 12:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.8)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.8 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.8; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.8) by
 VE1EUR03FT034.mail.protection.outlook.com (10.152.18.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 12:48:13 +0000
Received: from ulegcphtsw6.emea.nsn-net.net (ulegcphtsw6.emea.nsn-net.net [10.151.74.187])
        by fihe3nok0734.emea.nsn-net.net (GMO) with ESMTP id 28KCmBtf024236;
        Tue, 20 Sep 2022 12:48:11 GMT
Received: by ulegcphtsw6.emea.nsn-net.net (Postfix, from userid 62095846)
        id 2112E81C; Tue, 20 Sep 2022 14:48:11 +0200 (CEST)
From:   Bruno Matic <bruno.matic@nokia.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, avri.altman@wdc.com,
        jakob.rossler@nokia.com, aarne.heinonen@nokia.com,
        Bruno Matic <bruno.matic@nokia.com>
Subject: [PATCH v2] mmc-utils: Fix ffu in case of unsupported MODE_OPERATION_CODES
Date:   Tue, 20 Sep 2022 14:47:49 +0200
Message-Id: <20220920124749.24073-1-bruno.matic@nokia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <DM6PR04MB65750F5EE2E1C9D2CC103A64FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB65750F5EE2E1C9D2CC103A64FC4C9@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR03FT034:EE_|AS8PR07MB9066:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e996c171-0bff-4d14-9a65-08da9b0661a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOT0NJy9YlpIuEMgoiTACR6I7ezaD5CkszjNVGqvrl1TYTYoUIlvg4jezqnSWhGpG/nNHmjR9s9xQ/gjR/oJohqCFXNE4gf6mn5xShPkbZgYruLfoP5Nr7Jz6Zybue5lFg9m1fPerFhyZRDeGXFCG0BxauRuB9FbjlyhN30onRz76Jv2Avtaiu+ZbTHt2YeECOxcgLpOib6BXagrz19qSJ8UUsws8VKB5UaaM1/rS+q7L/5g4XA0DhXloq8VXnbLsdFBXO35DCvGHhZME+dTFi+U5CxEUOtB1PZptCw/j9xqVKYhqFojrnt69qM9pvQEKedtgdS/cb/5TAYGeBOjietgkIYFkZrtYPH3bNFoUjCInuDj0c3Z4ElujXJeUCTCiD73pqTYfv/TLaNam0F7rk25hdsENsSR6P6LZAQmUkOttKeIDmAY06aLGE26X/7upfIhsj2qYw01Ja5HIZe9Bp1eV1CcnwtvgqTLGTu+LLHtAtYqYpN+iskslObAhUxyd/brPIXAOacnQGoe3uaHgcBZN7cWPXL+hvV3o7AtRu63TnSrSzvD8qOeNPANW5E9zxztHARRhhsR8WtwgQVpxYZNymucjh1vqgScFFw3jU7rPI46GucqxTO2FBl+Uc4eWBdGhj/6v1PUDQXNqzBzRAOBZSxjz3OwX9JtrZ0YMBjCoyQoEpUr0M2ZVNSNjaWzgwwLBMhZL71YyzE7dYKGEiqrC4nvO78xS1ihGJA0QafnhyfkXRKSEF30ZtlWHW5lzoq3xVJTa/HCLPR2p7tZOBfI8mh4ey3VlUuBZbjwBkyYyH+F0fJFPJmGjt3TaVsl3rANoCffl1O/ZXVIgvg7Vx2GBrXBoElqireoeuFy8Ig=
X-Forefront-Antispam-Report: CIP:131.228.2.8;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(36840700001)(46966006)(40470700004)(70586007)(82310400005)(70206006)(336012)(82740400003)(82960400001)(83380400001)(8936002)(47076005)(1076003)(6266002)(6666004)(26005)(107886003)(8676002)(41300700001)(42186006)(6916009)(40480700001)(44832011)(316002)(40460700003)(356005)(81166007)(4326008)(86362001)(36860700001)(2906002)(5660300002)(36756003)(186003)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 12:48:13.5720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e996c171-0bff-4d14-9a65-08da9b0661a2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.8];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT034.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9066
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move up the return in case MODE_OPERATION_CODES is not supported.
According to the specification when MODE_OPERATION_CODES is not
supported no checks should be done against NUM_OF_FW_SEC_PROG.

Changes in v2:
  - better explanation in the comment

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
---
 mmc_cmds.c | 85 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 40 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ef1d8c6..a3740ab 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2897,6 +2897,16 @@ do_retry:
 		goto out;
 	}
 
+	/*
+	 * By spec - check if mode operation codes are supported in ffu features,
+	 * if not then skip checking number of sectors programmed after install
+	 */
+	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
+		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
+		ret = 0;
+		goto out;
+	}
+
 	ret = read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
@@ -2927,49 +2937,44 @@ do_retry:
 		goto out;
 	}
 
-	/* check mode operation for ffu install*/
-	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
-		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
-	} else {
-		fprintf(stderr, "Installing firmware on %s...\n", device);
-		/* Re-enter ffu mode and install the firmware */
-		multi_cmd->num_of_cmds = 2;
-
-		/* set ext_csd to install mode */
-		multi_cmd->cmds[1].opcode = MMC_SWITCH;
-		multi_cmd->cmds[1].blksz = 0;
-		multi_cmd->cmds[1].blocks = 0;
-		multi_cmd->cmds[1].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
-				(EXT_CSD_MODE_OPERATION_CODES << 16) |
-				(EXT_CSD_FFU_INSTALL << 8) |
-				EXT_CSD_CMD_SET_NORMAL;
-		multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
-		multi_cmd->cmds[1].write_flag = 1;
-
-		/* send ioctl with multi-cmd */
-		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+	fprintf(stderr, "Installing firmware on %s...\n", device);
+	/* Re-enter ffu mode and install the firmware */
+	multi_cmd->num_of_cmds = 2;
 
-		if (ret) {
-			perror("Multi-cmd ioctl failed setting install mode");
-			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
+	/* set ext_csd to install mode */
+	multi_cmd->cmds[1].opcode = MMC_SWITCH;
+	multi_cmd->cmds[1].blksz = 0;
+	multi_cmd->cmds[1].blocks = 0;
+	multi_cmd->cmds[1].arg = (MMC_SWITCH_MODE_WRITE_BYTE << 24) |
+			(EXT_CSD_MODE_OPERATION_CODES << 16) |
+			(EXT_CSD_FFU_INSTALL << 8) |
+			EXT_CSD_CMD_SET_NORMAL;
+	multi_cmd->cmds[1].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
+	multi_cmd->cmds[1].write_flag = 1;
 
-		ret = read_extcsd(dev_fd, ext_csd);
-		if (ret) {
-			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-			goto out;
-		}
+	/* send ioctl with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
 
-		/* return status */
-		ret = ext_csd[EXT_CSD_FFU_STATUS];
-		if (ret) {
-			fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
-			goto out;
-		} else {
-			fprintf(stderr, "FFU finished successfully\n");
-		}
+	if (ret) {
+		perror("Multi-cmd ioctl failed setting install mode");
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+		goto out;
+	}
+
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
+
+	/* return status */
+	ret = ext_csd[EXT_CSD_FFU_STATUS];
+	if (ret) {
+		fprintf(stderr, "%s: error %d during FFU install:\n", device, ret);
+		goto out;
+	} else {
+		fprintf(stderr, "FFU finished successfully\n");
 	}
 
 out:
-- 
2.29.0

