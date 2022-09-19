Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D42C54EE9
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Sep 2022 16:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiISQTX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Sep 2022 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiISQTT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Sep 2022 12:19:19 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80109.outbound.protection.outlook.com [40.107.8.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2AE2983A
        for <linux-mmc@vger.kernel.org>; Mon, 19 Sep 2022 09:19:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhyRVwt0NsieUL/dSsyCn2TocNoUud7z8JWRlhSP4fWo9BM/sb3kIiUs2dqBZGumJ4jvYYllFI+FRGS9SWHqMQ2SYnNlZbpMP5hVk2/0k+bcspJiZfjqXmTSwe2TO8PRM79CJHrGAdXIFSovRrLSnSU6YexNfHYY97Dwg52sLGF9VL9ZpKf1yG4QFkiqbuQDqPm1h/IpAX+i11L1mbTeEpJeKd+h3gHxUABFDCBRcEV09eL4O1e33XS3xkexmMu1ngtpdyYAqa9y/w6bljBfXqT1lX8FBNBoRBP9aYhj0o4onOSkPsyj9vmTy3q276Q4OQbyPMTUg9FV0X11EwTXxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvY6juesECMYl9+SZFThj+PyDgXSLGZdDCSkVjlH9cM=;
 b=D3v/ohmPl+W4hR7Sss/qN/jYkxDU96SdFT6FjqGHa5ice+5soDPec5grTomRT5JcLWAQHgZrxxusxKHyyI0Yx9xoej2cP0TqRYeh+5afwcAV13vYb+QlflA6yKL/+e19+eRDm1qa9AAnjRbsyGO5QM37vfLwxVENSz8EUTK/WFRu/mnl6b6Ax3byCBVZFpEFb3Sf6jxF09ue1WLNf/pskEkT9Dm9r6iT27FJEtq0RIcqP104Zd0vuup7XOHM8F0OH7R2YGrm9P1IxrgIYT8kP/+dgOSRt5cDpWssE5jWd9bfako/MzOVKKHLSCTMWQLXf/EP7FtB8zDzb4exE/9MOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=wdc.com smtp.mailfrom=nokia.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=nokia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvY6juesECMYl9+SZFThj+PyDgXSLGZdDCSkVjlH9cM=;
 b=l4G2GIWsV4v3jDwT8i2CVYVK+2DTULllhOPqJUbNlGsjngkHrnLUODMWrLadGC5lqqnyO/0KERQbZg3nxOoIvg61qj0PjWx0z6flcDJ6cm50+K6NzqbaD+N/4X+tfxG31JAuZlGaAW3GyDDVEG6BK3E12yoqX4jfjZiUzvayjNQ=
Received: from AM6PR05CA0027.eurprd05.prod.outlook.com (2603:10a6:20b:2e::40)
 by PR3PR07MB8226.eurprd07.prod.outlook.com (2603:10a6:102:179::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Mon, 19 Sep
 2022 16:19:15 +0000
Received: from AM7EUR03FT009.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:2e:cafe::43) by AM6PR05CA0027.outlook.office365.com
 (2603:10a6:20b:2e::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 16:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.6.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.6.100; helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 AM7EUR03FT009.mail.protection.outlook.com (100.127.140.130) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 16:19:14 +0000
Received: from ulegcphtsw6.emea.nsn-net.net (ulegcphtsw6.emea.nsn-net.net [10.151.74.187])
        by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 28JGJDpI018669;
        Mon, 19 Sep 2022 16:19:13 GMT
Received: by ulegcphtsw6.emea.nsn-net.net (Postfix, from userid 62095846)
        id 015E5833; Mon, 19 Sep 2022 18:19:12 +0200 (CEST)
From:   Bruno Matic <bruno.matic@nokia.com>
To:     linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, avri.altman@wdc.com,
        jakob.rossler@nokia.com, aarne.heinonen@nokia.com,
        Bruno Matic <bruno.matic@nokia.com>
Subject: [PATCH] mmc-utils: correct ffu in case of unsupported  MODE_OPERATION_CODES
Date:   Mon, 19 Sep 2022 18:18:52 +0200
Message-Id: <20220919161852.28072-1-bruno.matic@nokia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT009:EE_|PR3PR07MB8226:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f634d123-5c54-427d-b5c2-08da9a5ab1d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNptr9xnV6LMrWdCgvAWuDW3OajgZKyLWpMGQUCpPkg/KqUgF15QWl+YOMtq2vCaaaxIsgC6xeJ8XaACvumt0iTjKuwW4g8Pfik8iCb7uYtaE7gUrFGqKxc0MSXffoQKF365+vmiKoPqVlvFQ+XI4sQ/ym6EehhOxnL5Tt2/IQtbEp6aXWq74HYAP2xEouwC0NvYG9Iv/FQLVg6/zRIh7UfnIFxA+wIXhNjnf4nVPbZbLa28dZb+sDbdzDUKqNWpZlxSCV1HhHt1ClA9KjHGm8jKl7QcC+vzp4IScLmvJe9kh/ABaBN3OWPjCUPmhV1owGCibXSkdpCEsSiFWLIHbKAgYVO4X2hHTA0ZIEMY6SZ02O+NaZHymHMP9RgrjeAZQeSwaxUUZqeedFkAMAevW8zdPMMkKyU+ZOW7cEhFVIbOk7YL70OrfmSfEftTXAyrGxDuPwg/F5plQSbFQPdMky6UfUgGPmL1UIkHAGbEntAuuEc0eg3oUd+IsVtAb5cyelCxlFhe+fpgFpZxYafjW9DtGHYDBKuYDcZQ9RdnvrXjRyUQoEvUQbTTDCUCD2Sgk1X4jewFR/TF+yN2oHVPhENoLcnX9cGztPqKplmA7FKkjNmVg/QINiUTGJpwQfp9iqfUx0zkqXh6qrf7tNS0Du7LaX0Z1x2jlvXXWKgguBT5cGP+icd2tviop4QskLK1Xd7C54lHQ0jKRC9Xollf2piz8Fox9NJWTyF7J7C6ljS1hQpYmW5z7KWBTyXIcpWg8NTwmNmxHD2mhkk7K/f5/YI6TmfNmIhBV13kqMhSmQzXCx2io/kyacbbidKJvD2H7nEQnRkEZ6TqRUDoOOf6PdGldoDqcXL9zAQ0CdNaGYA=
X-Forefront-Antispam-Report: CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(36756003)(107886003)(316002)(6916009)(82740400003)(82960400001)(2906002)(36860700001)(8676002)(4326008)(70206006)(70586007)(2616005)(186003)(336012)(47076005)(1076003)(478600001)(86362001)(40460700003)(40480700001)(42186006)(6666004)(83380400001)(6266002)(81166007)(26005)(82310400005)(356005)(5660300002)(41300700001)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8226
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Move up the return in case MODE_OPERATION_CODES is not supported.
According to the specification when MODE_OPERATION_CODES is not
supported no checks should be done against NUM_OF_FW_SEC_PROG.

Signed-off-by: Bruno Matic <bruno.matic@nokia.com>
---
 mmc_cmds.c | 82 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/mmc_cmds.c b/mmc_cmds.c
index ef1d8c6..81fdc7e 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -2897,6 +2897,13 @@ do_retry:
 		goto out;
 	}
 
+	/* check mode operation for ffu install*/
+	if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
+		fprintf(stderr, "Please reboot to complete firmware installation on %s\n", device);
+		ret = 0;
+		goto out;
+	}
+
 	ret = read_extcsd(dev_fd, ext_csd);
 	if (ret) {
 		fprintf(stderr, "Could not read EXT_CSD from %s\n", device);
@@ -2927,49 +2934,44 @@ do_retry:
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

