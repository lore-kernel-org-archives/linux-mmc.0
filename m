Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D37AC4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Dec 2022 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiLPQRR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Dec 2022 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiLPQRA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Dec 2022 11:17:00 -0500
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2045.outbound.protection.outlook.com [40.107.8.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540A68FE6
        for <linux-mmc@vger.kernel.org>; Fri, 16 Dec 2022 08:16:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwf5MKbyuxJzKgblSuHQcXvbuXY56ttVyj/oYIRWrm/VkVCt30jIW6ullwDsGRN1dRVN/IAQUXLWyv+NQe0GKwD+HGE269L2ME/8VzBZLkSerOLYNH3hMq5Zas0G/k300UHYkway8zq08cOgLL3nNckmW3jzNiXqkGmFKjMbdMAkUdahBegb/X630n0KCC9K4/7hL8XIprHOiCrV8BNqKUGAxdV1E87Lfm/zqTH1qI7fg+gNEmOyT6Tk+gHj01DZmobgZeW8w4jbRFnI0xbnZCVsQQF506xg4mTM09CY5ouNWeXqmXMCkpADr2kL8FljdmkwmIsUFP4TD1CDv+8Isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUhBsnzy/9ku/L0zfJGXXFPHalXHb1fUUZZusgTBfPw=;
 b=QGXBP9LDQr+sRuZEcr5umJdaQMf8C+qCntmNWGIPt766J2lbtBJ2K57sC/fYBbKAtYQNehazPqJjkS0HudODByoCyVFL7IKMWu7d8lGpTXwSba2GrfCRjJl1zil6uKbBSG5XBtIOhK3+B8e23as9lXC3wRYX2ZWozQF8PKzNaoIVTc1r/DqcNHDE4RajZNdYQ0KIKheICQlTLlPLqdpF3YWwP4BCh7iqkTVpga3NVuqB9F0WQXcUBIPb6oV6X2Tg8fC3M3aRqcvl4GWqXkPzF+yAajKpQkBjNSLAEDaNVl7aQbLYdrOVB5k2H01YFqn9rQQ5jNWR5jcvLpKl+MgVgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUhBsnzy/9ku/L0zfJGXXFPHalXHb1fUUZZusgTBfPw=;
 b=bjpQlwCjSQ+LIFPAPMgJUuwOFUAE6vGAZmZxI3FaxrcUui/2vjCz8UVVRFip06SGIgQJeqPwXLuihIgw76FNlJnQW9TOS5gaJsJut+YHdpe1BhXsHCRYcHDv5JafF82gyT7j4NHjmTDCSkwguzWCpzazCPiKJ4ILg5wFO91Nk412sDWUVuC13WHgcScAuPyrDU7j7LNkUDKp3bSO0aj0CT1WQbg8C/VGunxt3ZZwxb9Ll14R8dP4NbuvZGa66axua8csaydFeJjbaCgc4yg7Ur7WQ2oIK1v2cC+bBxJId7ARw33iLhN6i14+mjp3mqw0f7aksTBgJ40tAgGEePbBgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB7349.eurprd03.prod.outlook.com (2603:10a6:20b:2b6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 16:16:55 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::2b95:1fe4:5d8f:22fb%6]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 16:16:54 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Philippe Reynes <philippe.reynes@sagemcom.com>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] Add a command to write extcsd registers
Date:   Fri, 16 Dec 2022 11:16:25 -0500
Message-Id: <20221216161625.2924013-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS8PR03MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 15244a8a-1c08-41aa-d224-08dadf80f1c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n3RFdB5H8Zg3vpehWWqGdEag9pz9yLABaaFNUVhfaJA2B53dJsuj/j16vQMkhK/k4oSsptLv2j8qx+3EOmQ03jXn4j72PxpFOP45q+NXGXk7G8vHRf5tfRqolHNNFvQ/CVYK+wAULC4Ce7hqMAFi9f2WwCUoHFmBLcmq21p2vLGB0o2kycagzxAb1x0DNM/xkWDFUZ4PNQzfi4nPWY+QpWTakhjt7zbL8wboJCnki2urvzKxJBYr1u8CsV8mSPGdEXcoHmwGmJctPP00gtalaXLICn2qtZ6LXREHQWG/kqy1GV8jXFvKJG0GUyPmZRKw3OQd4VnClQW+ARBy1gEHeiysLSQBHl+DUdNx9YAZIcknkO14reIkfvrnzwiI7JPmpNYB4/ofY92P/qJSD29EHCqZHEXKhk9AX8U3ViP9k+/t4ELrIf7IipGXHvpJpOJ6w5rd5ZQ+OkemBTnipEKLzNTq6AdsaC/2PKoVSABOlFSFmtsqbejdbAxQY3rVHFw7QyGZq3q5GYmyzDgooietSB7XrH6CD7PwqaGXMSNHWcM2YiDiQjoyoqNOHTrd8QZSUhodIUfK+Ci+mLYpQAYhPmMEID+teQzIb3R20XgOsqos93lCUeLjOPRu83lmQ9K5m3nNgedvMMwnM9hh+YjEBfs/f0QZb2kOfT1ux4OqUyAvOXFK6FLBM10pn/WCTIhQv6aSRcNoU2q/aKr+CE7bUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR03MB8847.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(136003)(39850400004)(376002)(451199015)(83380400001)(38350700002)(86362001)(2906002)(5660300002)(8936002)(41300700001)(66556008)(1076003)(4326008)(26005)(6666004)(107886003)(6512007)(66946007)(2616005)(8676002)(6506007)(66476007)(478600001)(186003)(316002)(110136005)(52116002)(6486002)(54906003)(44832011)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hQZ7DGjjr8J9T6jAAXp/544KpPIx9tuHRQU7oOt+QmY/55+k+K/VVTLfF8mG?=
 =?us-ascii?Q?CeppuJzNta9RrVH9MMhhz7OqhN8pVwFCgcQh200UsFADdT6kv3GfcsMVKwjt?=
 =?us-ascii?Q?ztNE69wwHOLuK6RakxLj+JjRmt8l7Ob8qUidWq+0/ykE+KndQyX4YekM4LzP?=
 =?us-ascii?Q?glcITADvotveMODfC+F8wsdlNGIOl5GLflv1LZdPRtmJLcD3RQKFaQhMnEpz?=
 =?us-ascii?Q?4jHoLlW/Sx+5JcxYL4um43wm08HhSezGi5aPrggr5ZqZIUyObljYB6vF5gES?=
 =?us-ascii?Q?1ioVo3MUOjQT5yCfO8KDJjBOq8kutXgvJGFmiLqcD41y/Dvs3B+hzYHY2lTW?=
 =?us-ascii?Q?ohMLuPf61l1hXfn/qCpJXF5J8d2DLBIqtqSoVMG2ffRJPcBC52+5kKcNc5C+?=
 =?us-ascii?Q?wgF0dvrdFvWBUFSn+SuBzgQ3MN4nOUUHzw96qRVJSEoC7kc8lNyQ6P4bLFs2?=
 =?us-ascii?Q?P0A7sTmJU46mkijpdkezfYRid9/4otfhZbXvXBPpb94XIsqdca0NjjHDDczw?=
 =?us-ascii?Q?wuQNHhQ0z9U0MG75fGLE1OXDw5lnyRvG0Mxn9Vey+4MQECh0PTyT8A50bzxa?=
 =?us-ascii?Q?UceAvqiuLR7NtQgrIn203o9oBbqt+hRegfId5+g+e5qW9v6SIYxwNLYL0d8e?=
 =?us-ascii?Q?1GpyFZeSzCb0DCwWhJrhQ7QPTrz/GtutGVwOZa+pXbjLz9RT6OK0f+a5m51m?=
 =?us-ascii?Q?QMHoqVWQQNOKX3w167J8jdI+LWGNpLa3x+uvEUKw6dKjQSVlnmnock2juvfc?=
 =?us-ascii?Q?7GHNlXWMfzVujbUwB3W+UXx3VIhc7XBnKBN09PhO3AXVSit/izvEUMmwihd7?=
 =?us-ascii?Q?l09ZUn0RuD77lFJmHWZK09OUkvO0cA/0Iz3/3pPO67QpMj70GwPTa4E5cWWk?=
 =?us-ascii?Q?bm5WNiwrnbOQvgSZG2h5K5QONdtcuoD/hNNHIQxE/uUyEZ8W82ffoVOqRQ6H?=
 =?us-ascii?Q?C8mj90qlktAwm0ESrSqTYZ7FX+LpwojWtNZMFOASaRcgT8u50zzXejpsr8iN?=
 =?us-ascii?Q?h0HqcueE1dv+uJzE77dfjfqQoFZ3biE6F/bfn4FVPnzG76TUcjaTxUhaVNBj?=
 =?us-ascii?Q?Ie1Lyla3snkhmuUB1kWTs6QrFSez7KT74ad0i6OT25MXQPFwWZJcrT0NSKoo?=
 =?us-ascii?Q?bAgpjF38KZ0pghuS6fotXV5YhAVq6Vol52DKcrGa5OZS7giBVXUKVFqTWJru?=
 =?us-ascii?Q?gmCl8He3ajRKTgfBuSUjbPS6wMTlUS/DhzQKqP/I8yJ66iGqBvqnWw3Ajxn7?=
 =?us-ascii?Q?Dxx9oOJJ1AAPZWmNkReh2lMDdY14NeLu4H8pNT/DWHhNUEstj67vFjHKEP0A?=
 =?us-ascii?Q?9FxgwhXPMQtwM3Tmr6FKlyHB75NpFrKea4uNIauX0TNPK5CKOKu4QCjw9ml1?=
 =?us-ascii?Q?qEXI2EyNhlcjR3Qgdi7JGc7b0zGi1d6hW36Z3mn4ipO7H/dImo5Cn+Yn9Yh3?=
 =?us-ascii?Q?8ettqsph13VcOJ9V2yHIOJ2/M4vQX2sWsuzVHVVScqoJMHiObkfmKQb15SnM?=
 =?us-ascii?Q?oJHvDdrVcP9XkF6RFVWYxUcE4QegniqKBqt6wm9zWTF37f2I4NbWgSTYlMYP?=
 =?us-ascii?Q?os8Qj9eM70MMsDvUR67+OYRexoE1Q8CHwM8oXJW6nKqi/xPLOQv16LdNv5Ca?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15244a8a-1c08-41aa-d224-08dadf80f1c1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB8847.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 16:16:54.9130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6OCqu5h9FjyzIQFs3mycUoAMxo1N0j7nvK9HSnK2Hv7AGFihKQpGogvifCMH6Toe8irwTNg9c+Z3oNsD9rTGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7349
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

There is a command to read the extcsd and some commands to configure
particular features, but no generic write extcsd command. Such a command
may be useful for not-yet-supported features and manufacturer-specific
registers.

Signed-off-by: Philippe Reynes <philippe.reynes@sagemcom.com>
[ rebased onto latest master and updated commit message ]
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 mmc.c      |  5 +++++
 mmc_cmds.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/mmc.c b/mmc.c
index adcd814..b9aa478 100644
--- a/mmc.c
+++ b/mmc.c
@@ -58,6 +58,11 @@ static struct Command commands[] = {
 		"Print extcsd data from <device>.",
 	  NULL
 	},
+	{ do_write_extcsd, 3,
+	  "extcsd write", "<offset> <value> <device>\n"
+		  "Write <value> at offset <offset> to <device>'s extcsd.",
+	  NULL
+	},
 	{ do_writeprotect_boot_get, -1,
 	  "writeprotect boot get", "<device>\n"
 		"Print the boot partitions write protect status for <device>.",
diff --git a/mmc_cmds.c b/mmc_cmds.c
index e6d3273..33b9e43 100644
--- a/mmc_cmds.c
+++ b/mmc_cmds.c
@@ -1982,6 +1982,38 @@ out_free:
 	return ret;
 }
 
+int do_write_extcsd(int nargs, char **argv)
+{
+	int fd, ret;
+	int offset, value;
+	char *device;
+
+	if (nargs != 4) {
+		fprintf(stderr, "Usage: mmc extcsd write <offset> <value> </path/to/mmcblkX>\n");
+		exit(1);
+	}
+
+	offset = strtol(argv[1], NULL, 0);
+	value  = strtol(argv[2], NULL, 0);
+	device = argv[3];
+
+	fd = open(device, O_RDWR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	ret = write_extcsd_value(fd, offset, value, 0);
+	if (ret) {
+		fprintf(stderr,
+			"Could not write 0x%02x to EXT_CSD[%d] in %s\n",
+			value, offset, device);
+		exit(1);
+	}
+
+	return ret;
+}
+
 int do_sanitize(int nargs, char **argv)
 {
 	int fd, ret;
-- 
2.35.1.1320.gc452695387.dirty

