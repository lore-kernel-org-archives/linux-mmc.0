Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C426ECAAD3
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Sep 2022 11:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiIILDo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Sep 2022 07:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiIILDn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Sep 2022 07:03:43 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2123.outbound.protection.outlook.com [40.107.104.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4445175B4
        for <linux-mmc@vger.kernel.org>; Fri,  9 Sep 2022 04:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBN2sdCn/LPOvNznds4ZmbrdM5y6fw0qcuE31GI+0iiXJAda02uOeeV3SodgFwPR61iKg3E+8nB7aVMnn21DsAZavYsYntYAPXBzGdJ8x5cVugNGwKknC46dcx2lvDw8OpFdBBcE9dwwdsgfU5z63x0hao5z4voIJUTWBBKHZ8cNdGoCyI9KRWMXuacMEIcRk4AOQAXZ5MqIGTGHT3U9r94mpNJmHGqxD5EPbosYOr03wKxd47J+Mbsy/f4W44IN2a5lSEfccaKFGbIm6nmBEHhDFtb3kztl4P10aj1L2a+KTkKKDW8JpNKVizqVlOuT7r4mMDtS7ZQnAy3fKCyiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAtzIKLAzWdroIsy2lm/4Per8bpDz14qqKb1vvvqeEY=;
 b=KMykuo7RoTlTGzo861K0RaHP26Q/hI8kUrT43F/Oojyp93D8RfwP3y3tPLA/kkYmONrGySJ0AaxbmAOrNyr8WUahlx6elsGxU5DtX/o2mwJfJTyAGOAh2AiVA6ONEl/ppMUwgJrurd9NCaGp8w5ZJwFS76WX4raNihlAS1Kj5w1GkAMfpeLT+bxGrREC3Fff2nOSOYBd1lMWCQKXWNz46Z/5czncrX+D2zk2h2UW4Alp0hND3R1k2piegGkYKc2AqNZusyDImaGBy9JuUK0tcydBhA2i7PSAfvB25f6zd5+4m82ubmbUYVVpOhwb6bobhW1F6LH0K9D149AvCCu0bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=wdc.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAtzIKLAzWdroIsy2lm/4Per8bpDz14qqKb1vvvqeEY=;
 b=HqZ6hm2RXOH3qXyJtYDCMRFonz5qVY3ssNdOzZLX/dJEP/HSL57Jm8FpsPlUeVbrNhIGugJIB0wsVv9PSltLwxKdSH6W/psezOXi2MH1gU38M3zeas36ttYvQczBhvgrmIXGQUmTGprTKhT1WyvAAGbOL6GOIBxKOdpJpPjS5AY=
Received: from AS8PR04CA0005.eurprd04.prod.outlook.com (2603:10a6:20b:310::10)
 by DB7PR07MB5078.eurprd07.prod.outlook.com (2603:10a6:10:5b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 11:03:39 +0000
Received: from VE1EUR03FT015.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:310:cafe::78) by AS8PR04CA0005.outlook.office365.com
 (2603:10a6:20b:310::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19 via Frontend
 Transport; Fri, 9 Sep 2022 11:03:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.101 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.101; helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 VE1EUR03FT015.mail.protection.outlook.com (10.152.18.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 11:03:38 +0000
Received: from ulegcphtsw6.emea.nsn-net.net (ulegcphtsw6.emea.nsn-net.net [10.151.74.187])
        by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 289B3ZO7001101;
        Fri, 9 Sep 2022 11:03:36 GMT
Received: by ulegcphtsw6.emea.nsn-net.net (Postfix, from userid 62095846)
        id 800F4821; Fri,  9 Sep 2022 13:03:35 +0200 (CEST)
From:   Bruno Matic <bruno.matic@nokia.com>
To:     ulf.hansson@linaro.org, avri.altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, CLoehle@hyperstone.com,
        jakob.rossler@nokia.com, aarne.heinonen@nokia.com,
        Bruno Matic <bruno.matic@nokia.com>
Subject: [PATCH v3] mmc-utils: correct and clean up the file handling
Date:   Fri,  9 Sep 2022 13:03:22 +0200
Message-Id: <20220909110322.25141-1-bruno.matic@nokia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR03FT015:EE_|DB7PR07MB5078:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c6bcde1b-7410-4284-9e95-08da9252f305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKfr/GWPJulnOku/bZ5z0SRle8iMmw+Kj4n6PhKB4x55nqIbppbQpOs2t5cuhZSiqeTW/w4ZLW2FetsLFEUUkiGvSzNco/BfEwIaqknxpuC+msG6BD6uBnWh3xjnwg+W1LAHS/7LcSD2OVXYnmTdeAxWAKI+gdrZqAArk2gbAIRPOTUCDJDgSxOtGY853QUd4eiVzkgmnZHqtzMaqz5hlkdLM5KoLKyQUwaEOL/3s4HLQsffxAsTGBnFMDPsS2qVWKSPgB7HXmgLFdYehDwkQNN3rhe7rKbyrBoB62eVtNpeHcGnjFCcyHCK5ge2Je84hHxj2un/kdugqXUFdd79V/n7UmMiwETUX6qfDmhJGnr2J8wgL+TKe9zOu+6xnOw2lDxJihTQUQDyzRc5PoWwCG282ps23yH1VAX7J1p76LBJqyQuYoDbrXx/F0Lc4cELdHA5B0QKWqI+qifuG8z8ARAFGK4iSgIYO7TcWZ13Iu5DiuaBhN80BTiwWM1fJ9mFNQjLL1rZAe6ubRCn+tggmFefceZ+mMSbxUvAxf3qa5guA6F/6F5Peyoahndv9ChaO2EHPkbrZCtpYMZKFFu+8loDsgPFHgqdOpWQiigTa8ZpNz3phJmu8PBEjFd81xXUU5MX0XKLn57UcXNEhuxnhpWGSkzhOLvc1J9RjEqSooDJEDBPDT8n5EmULwkJRfUmGzsjD7PkoZ5Gvk0jr3mbey4ZkU299QGbcghCn6eGLXtnPkTdI0Y6yqX21D/iKJqs/DoxPTZivmAKTVIjVZv2HHnLipUtEaXJhsXVp+kGYKc=
X-Forefront-Antispam-Report: CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(376002)(346002)(40470700004)(46966006)(36840700001)(82960400001)(2616005)(186003)(336012)(1076003)(26005)(6266002)(82740400003)(44832011)(8936002)(36860700001)(4326008)(2906002)(70206006)(82310400005)(70586007)(8676002)(36756003)(5660300002)(86362001)(42186006)(356005)(107886003)(81166007)(40480700001)(41300700001)(6666004)(47076005)(316002)(40460700003)(478600001)(83380400001)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5078
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the check if the whole firmware was loaded.
Cleaned up the leftovers of handling the file in chunks.

Changes in v3:
  - checked and formated the patch
Changes in v2:
  - use perror to propagate the error on file read

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
Reviewed-by: Avri Altman <avri.altman@wdc.com>
---
 mmc_cmds.c | 66 ++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 34 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index 12b7802..ef1d8c6 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2765,7 +2765,6 @@ int do_ffu(int nargs, char **argv)
 	__u8 *buf = NULL;
 	__u32 arg;
 	off_t fw_size;
-	ssize_t chunk_size;
 	char *device;
 	struct mmc_ioc_multi_cmd *multi_cmd = NULL;
 
@@ -2879,45 +2878,44 @@ int do_ffu(int nargs, char **argv)
 	multi_cmd->cmds[3].flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
 	multi_cmd->cmds[3].write_flag = 1;
 
-do_retry:
-	/* read firmware chunk */
+	/* read firmware */
 	lseek(img_fd, 0, SEEK_SET);
-	chunk_size = read(img_fd, buf, fw_size);
+	if (read(img_fd, buf, fw_size) != fw_size) {
+		perror("Could not read the firmware file: ");
+		ret = -ENOSPC;
+		goto out;
+	}
 
-	if (chunk_size > 0) {
-		/* send ioctl with multi-cmd */
-		ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
+do_retry:
+	/* send ioctl with multi-cmd */
+	ret = ioctl(dev_fd, MMC_IOC_MULTI_CMD, multi_cmd);
 
-		if (ret) {
-			perror("Multi-cmd ioctl");
-			/* In case multi-cmd ioctl failed before exiting from ffu mode */
-			ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
-			goto out;
-		}
+	if (ret) {
+		perror("Multi-cmd ioctl");
+		/* In case multi-cmd ioctl failed before exiting from ffu mode */
+		ioctl(dev_fd, MMC_IOC_CMD, &multi_cmd->cmds[3]);
+		goto out;
+	}
 
-		ret = read_extcsd(dev_fd, ext_csd);
-		if (ret) {
-			fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
-			goto out;
-		}
+	ret = read_extcsd(dev_fd, ext_csd);
+	if (ret) {
+		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
+		goto out;
+	}
 
-		/* Test if we need to restart the download */
-		sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
-				ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
-		/* By spec, host should re-start download from the first sector if sect_done is 0 */
-		if (sect_done == 0) {
-			if (retry > 0) {
-				retry--;
-				fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
-				goto do_retry;
-			}
-			fprintf(stderr, "Programming failed! Aborting...\n");
-			goto out;
-		} else {
-			fprintf(stderr, "Programmed %d/%jd bytes\r", sect_done * sect_size, (intmax_t)fw_size);
+	/* Test if we need to restart the download */
+	sect_done = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0] |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_1] << 8 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_2] << 16 |
+			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_3] << 24;
+	/* By spec, host should re-start download from the first sector if sect_done is 0 */
+	if (sect_done == 0) {
+		if (retry--) {
+			fprintf(stderr, "Programming failed. Retrying... (%d)\n", retry);
+			goto do_retry;
 		}
+		fprintf(stderr, "Programming failed! Aborting...\n");
+		goto out;
 	}
 
 	if ((sect_done * sect_size) == fw_size) {
-- 
2.29.0

