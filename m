Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E915EC433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 04:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F7F22475
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Jan 2021 04:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbhARE2Y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Jan 2021 23:28:24 -0500
Received: from mail-dm6nam10on2082.outbound.protection.outlook.com ([40.107.93.82]:50817
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728690AbhARE2X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 17 Jan 2021 23:28:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiJnFdSf3CGCByInJA2zuVZEBLMhrRHYmNbmKgtzyjuiMgNpxx7JqtXx89E5AQrC+smBogXRchNexjxagZYeWATRTjB1TRQk+YRKBL4Qz5ZZZtVZok1pcsp82tpYu5fvWCiBCa4DTtL24c2b8BWxEdXU1ASJZ0hPPybg47jicsqrZKlnkzLnbapAAbl31GFgBFyHxeW5UQW4zou7mZHebMLIzuUwCCO9BDMIQMM2qP/o8Q7u8HCQEwOWXpzXBbxq9ttzI8wczAuT1O0zgeuh0XcBI0N5EYzmc3pUDYQg8uEBe1MRhiDgsmLzMWh11grKF4EeAO0ryrscfAUFAVFwLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU7e4Lab+GoLyhqudA5m/Mt+CzQd+haaHkp+UTOv/D8=;
 b=PiG+awJYJz8ccNaFqZd2hxNNsbqu3pqN499y3p2A6XWmwos69V12oOk1fUAlohoMikFzIK+2/2fDx5l+bg3bLjPZ8XfPQKaSNTMDSp171SDv8HF6nQ7CnpHVIA6Ek/T/upizOg2qL0MoN9F26tywcvtYp8Cx2GGlLJG5wdqfbqL3qChz6uxOueIm9k7QPFt8ypMXhdsbBbiqUo6M9n8vWolt4uHF6MF8UX/Y9HSMu9IOtxxLDGIgib78jaL6kGUWh9hmrUt4wKAtwryIU61zYM4QA6+ZP6HRSAfDOw0GDIOpGv9LIy150QvgyWyrTfyMIcNy1jucgs5WHbHDrn0JTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hU7e4Lab+GoLyhqudA5m/Mt+CzQd+haaHkp+UTOv/D8=;
 b=fd6BZLeyw4FO9inD6487J3EeRM7QAm1p7WCCC9RZa18r0vpl1lEhjcdMquWiPthVCljrJqr+oqzxC8/PRxY/ICJbMa0kNELPxKR1b/xhgoWPlYFg1dIWzPdbhiKv720/Z5VrTorOAwzvTMHJFRFtq0mtxZ0WLs+cMV/bUGeT09c=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=windriver.com;
Received: from PH0PR11MB5077.namprd11.prod.outlook.com (2603:10b6:510:3b::17)
 by PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 04:27:36 +0000
Received: from PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896]) by PH0PR11MB5077.namprd11.prod.outlook.com
 ([fe80::564:ae38:9aae:7896%6]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 04:27:36 +0000
From:   Xiaolei Wang <xiaolei.wang@windriver.com>
To:     ulf.hansson@linaro.org
Cc:     pali@kernel.org, lee.jones@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaolei.wang@windriver.com
Subject: [PATCH] mmc: core: Apply trim broken quirk to R1J57L
Date:   Mon, 18 Jan 2021 12:27:17 +0800
Message-Id: <20210118042717.2549123-1-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::24) To PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK0PR01CA0060.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9 via Frontend Transport; Mon, 18 Jan 2021 04:27:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87c8a992-a2bc-4aeb-a19a-08d8bb69619a
X-MS-TrafficTypeDiagnostic: PH0PR11MB5175:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB51751E7C3A98167EFAEF2D7595A40@PH0PR11MB5175.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GoCl0RgTXBzR2eHsV1ZeRT2GrnVIk7tw7Jyoz2AnSX77KsT3YAfhWOpYp4xP/xpShXoPf079gE4HqwE3bE/zXqbTaLR86gwwhyLzseULpgsiU5q3xEpv0kY4+DyVaBdK+6vX6z4covdBs2C8PndBGOZBJAlsqQdzPN5SeRE8gYuJIPaEtHoca69Gr6fGQ/lqJ+RhuD79W7w2uTRf11gJpb6XBfxBVMyXrbPMGQvOhoOnv1Nxc/eYX7h3KSeCR3Ku/rTGp6aNmq4xKqbW8AlhYmzcO7K142hPg08o7MChJ4GvybDIOrdVMpvXukip2AWqcDq0f0DBEmPI4xZ3tdFzeRv8mnsUe+pwvWpY3KHSRsH4N8sUd81Hg7VsHczBF4znPa7Mtxa/EEaVO3hytq5/LOoze4Z2G/4HhZr0NCJZkMM1Jpem5B3s3nvf6j7YE2YNPP8cAHS0TSIeKvbY4v1Ybl53qx6e4Rp48RVAPeHoGQK+9CiivfTDeTmg9n1qamIF2LzhrlESCrbGFnSzc+VHcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5077.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39840400004)(376002)(396003)(136003)(478600001)(26005)(6512007)(1076003)(86362001)(6666004)(107886003)(52116002)(8936002)(956004)(6916009)(8676002)(316002)(66556008)(6486002)(4326008)(66476007)(66946007)(44832011)(5660300002)(2616005)(2906002)(186003)(36756003)(6506007)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yjMEg4lU6Efmhn7Rip69THkz6DuQvFFzjyA/vJc/I70x0xnCF/v+8TUn8XBz?=
 =?us-ascii?Q?KmA+VyjuKlys/KmveYke2Dvbziwst8KOFufjnXVKGzOY8fHZTzBHRN/TPYD+?=
 =?us-ascii?Q?focjZj2dxCVmliQ38v4YUXLVcrh4y8ABGKoSC1ZbuuNZHmKN1quLaUg/gSCE?=
 =?us-ascii?Q?6UEZtr5KaquY6aMyE23vOp6q+CYtGDkIf7hCpVfxHppluJf0yMPaFAz2GeHy?=
 =?us-ascii?Q?F7Nn+i7arblO44MoNPyNjM/aME2AvPeE5MBd/djYWqvCZ5yhVQ0IGNFSjhN5?=
 =?us-ascii?Q?j/uQYgmPkf3gYJdtxDopAe2aFNkF5T6spz9yMiLtnrgMHs+8vHvlcmlCnCOQ?=
 =?us-ascii?Q?yx2vcGuihmNtaBqqTejvRYXGAzPrUy+xQ5n6vMPcEkg3myUwpZtVzUR4BEyY?=
 =?us-ascii?Q?GxoufzRKl08g8jPjMq9QHXnN4178c/HGcJF3uyTTP5H28hdA9nlKLQ/vmpEc?=
 =?us-ascii?Q?SA09mLTxnyEfhUl3loY8a54XN2Sqe4qbVroKpslnuXmM254oljYsKGwT6Oer?=
 =?us-ascii?Q?rNUx7wZWfJT7kOI1GDrH0k/XqSxG1nIESPmJVU0+EaK8D4VRJNvvNzwgSwrp?=
 =?us-ascii?Q?AilzGoDRbf5SvABx1wjkmUPQcZkLmofC7fxlqipn6AIM0XFB8svCpbaQf5BJ?=
 =?us-ascii?Q?CJMGyzHy3m8f0LZBc8KN9esRnBuVCtI+P8IaY+00rixENA0CY7SHoLuT71PP?=
 =?us-ascii?Q?OHbe0ML0e7t6GV5auTqz/sJXtJzNuXlJ/sp65o/yx0xNnLxsXbqkOYkCAa0z?=
 =?us-ascii?Q?29ViI0trjz4tiPAjTczWn4V0Ulrz5AqDfM+VVr/mw6czpsZYY/j/gHUlXokt?=
 =?us-ascii?Q?4PA/o0m1cZSMfYHfg7oFxBzctI9pNLuAtGQ+WIZZh+PuciyDHwpitIavfxDe?=
 =?us-ascii?Q?JM45ho3h20ZIhYbake3QmXmeQqdd2e1eVrUTPZMO3RyYi+rRf+7p7xWpvdJD?=
 =?us-ascii?Q?gFI+59rzkzUfxBX5ova5BMxo7xnhi2vKfXjmageR9IzHNSBOYJDNQgZ1nKOK?=
 =?us-ascii?Q?tjy7?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87c8a992-a2bc-4aeb-a19a-08d8bb69619a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5077.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 04:27:35.9903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hralCGIs/17EEKgHNBD0STIiUw5KF6TV2qKgrhq6/0I1UpWJkctldY/mCznja5pYchn20fQGcK8vAm/0msR3nvqBPy/tHrPqyBoxWHbIESY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

R1J57L mmc chip hw capibility indicates that it supports trim function,
but this function does not work properly, the SDIO bus does not respond,
and the IO has been waiting so set quirks to skip trim

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
---
 drivers/mmc/core/quirks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index d68e6e513a4f..63e02391c133 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -89,6 +89,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
 	MMC_FIXUP("VZL00M", CID_MANFID_SAMSUNG, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
+	MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_SEC_ERASE_TRIM_BROKEN),
 
 	/*
 	 *  On Some Kingston eMMCs, performing trim can result in
@@ -98,6 +100,8 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
 		  MMC_QUIRK_TRIM_BROKEN),
 	MMC_FIXUP("V10016", CID_MANFID_KINGSTON, CID_OEMID_ANY, add_quirk_mmc,
 		  MMC_QUIRK_TRIM_BROKEN),
+	MMC_FIXUP("R1J57L", CID_MANFID_MICRON, CID_OEMID_ANY, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
 
 	END_FIXUP
 };
-- 
2.25.1

