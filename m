Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16974C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 10:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B751164F9D
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Mar 2021 10:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhCKKOv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Mar 2021 05:14:51 -0500
Received: from mail-eopbgr700080.outbound.protection.outlook.com ([40.107.70.80]:56928
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232021AbhCKKOm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Mar 2021 05:14:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bucbsVAIJzMxRcv4P9sr1knYZe03FybI+RIVm8GYAfCio6uQUko7b5SuIA5Ax7vfpzfBfqt27bhcu11IwzobFR79eusM1tE3J0H8bMhOpFwcZPSRYu6b8tMnJZBkirjFF3xWq5wrMZfgWkBfjpZW7rIofj42VX8gwqvY8uGPHnChwhPloH1lbldjaMwViOFAz7vKE9GL00C3NZTW6383ACW6A73THFlNVCnDnU8vftxC/SfY/3OU/NrPiy0uzK0X74Y5hjY/yNrEBpBa7rsYOCMBH3niVjycaPbeQVcTC9hySxXKHe9/MrEs5dQdB6szqKo0JzQ7dJ56w3qsQjjrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfF7zCmOsPpWaBHtlKFZD48WtbHOLpKB7V/vMhbSgmg=;
 b=PRFtBQ192Ighic+lY/ucD9DglTEiympjTXyBZyldpED209ZoUhBS/uJZCgpJvePEQlTcsKTD4kCBXqj2BclKffpgcGgM5MftNm+UeweuWrJKcp4R5e+82wozig8cNzWZHCVWiORr9x7XgizprgJv6Zg/y0LLm6W4ebT1y0z56ACClk19nUfxEzzFS1kwK1svoKELapgYpxUzNq4BrT1+1EABxaYT0UDybR80FT64RqiO8d+0K0wpj/4yKAvt5zN6GZSuM9lTt1WPH6ZQxlCPHtYGbjca33gU2J6OFUrS6Y5uRwBeb2jJ6NY8aiZpq+fXigXqzMz5S94Qhz65kRgoIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfF7zCmOsPpWaBHtlKFZD48WtbHOLpKB7V/vMhbSgmg=;
 b=hT+ozIU0puR/CShCWz71YqeF5CnS8d1eAq8J2oASSkINW78PC+E6vVEiJia0Fklj7RQRDM6WOcH9uBepJIMuR1Fil/PX5i92VrrDEv4IsWTCP6MA8OlrTCvzRoHxf9t2jiePivqwf75606CLQgpDZlty2J7pM2xYEZDgvBbflTQ=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16) by BN7PR03MB3603.namprd03.prod.outlook.com
 (2603:10b6:406:c4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.28; Thu, 11 Mar
 2021 10:14:40 +0000
Received: from BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56]) by BN3PR03MB2307.namprd03.prod.outlook.com
 ([fe80::246d:2f3d:93bf:ee56%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 10:14:40 +0000
Date:   Thu, 11 Mar 2021 18:14:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-pci: Avoid comma separated statements
Message-ID: <20210311181432.6385cd2b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY3PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::22) To BN3PR03MB2307.namprd03.prod.outlook.com
 (2a01:111:e400:7bb1::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY3PR05CA0047.namprd05.prod.outlook.com (2603:10b6:a03:39b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.11 via Frontend Transport; Thu, 11 Mar 2021 10:14:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9eadd2c8-b0ab-46fd-e6be-08d8e4767b74
X-MS-TrafficTypeDiagnostic: BN7PR03MB3603:
X-Microsoft-Antispam-PRVS: <BN7PR03MB3603D15AE604B202576123FEED909@BN7PR03MB3603.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgV2Hp4ialVnfQ/2r20xqhmCvCX8FDvJNZHJxBztjcC/NgKg/SepTAI8D6Nyj6Lpx+6P/sibbf8U64oJMFfKzXFeEXgY3Ai+AtH2neGljxInEe8iZOa4Aza5mhbcIBZplr/i+8bMbHl0tyLuZaVu6SONvBYXg537XC0sU2QCgeRGXmJ0QKAThV4dhimjqJshyWX/JC2yrS5iUolu6MFfFMCSbC8q6nVXbP8/n0q9d9GjDSmS8qE5Rb/YiAmrOCqFZZutE5h7a7e4596hcUZd7LJefSBgL22P5aDNa4ZMWBL/X0Hw8DCMYr/f8T5o56gQovN7OJu4nJGjPw4ZT9CrwG74iV2oB/YRFR6659yai7dj5uqRNccEVGQaKr9OmRxq/lMLwoJHgU+fYcerNxCAxrE827BwfP4uQlR1goSggqOIrrb6sa5xevx5V+W7/VEkFN04YboqIXhAoNQJUsBeDabk76dfvljEBJnrANtM734ktWQirUxmMs/AuJ2fQQTqju+Adk0Y41q+nF6SxfaYpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR03MB2307.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39850400004)(396003)(366004)(376002)(346002)(1076003)(66946007)(66556008)(8676002)(7696005)(110136005)(316002)(4326008)(6666004)(52116002)(8936002)(66476007)(5660300002)(478600001)(4744005)(956004)(26005)(2906002)(9686003)(55016002)(6506007)(83380400001)(16526019)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aqdZgatbvKaER5R0wbVMBXNEGQBNpVBWHhXzpubnMi9woeB0tqx6TBxrQMbw?=
 =?us-ascii?Q?swY1eyrk1IuTrBxrvu/tln5721cPnQSTQ2uG8B4AdtGX97qsnOUHFdbDL9dU?=
 =?us-ascii?Q?UEKApwb5ei0gZrek9jeCHKLBEo/XxAibrAg9j75d7bXLuoWVB9Pgz7ZodS0F?=
 =?us-ascii?Q?SFGZ1Ju4/q88OgKZWBvTW9Ek5QIWXkd5RVtjae1Ls6/zCWKS7hrWG4yFeHIV?=
 =?us-ascii?Q?3xR/YkwBFsta5lzUU/Ulbme3DnLCPLCcNvA3O+sMqCHQ7g2znye2FFGqUwSv?=
 =?us-ascii?Q?L/KVuNAMFo7QQljKA7XxNLO85waxSAtgrMUWuNH8BVW3RsNXGsntDe2ax/vy?=
 =?us-ascii?Q?rVwFftD8YbtnmTVqbfzVdr5txtWufMPp+7v2W6gKU9CmFusFxZ7dNosGdPI/?=
 =?us-ascii?Q?swfrtlizWxQ5cXBg1BPRHk82algori+hTzs5gfktqnIk/W1xfV7z5mUEwpAp?=
 =?us-ascii?Q?3bhiSFAoE3cGBrxDmicSJo/Acx0Cq3ffE3NOTHvK/qoBSdtn2/XUNZ770S2x?=
 =?us-ascii?Q?sFkvGru/gQawhOn09hPIqPKgAs7NUUXKtYrEuxjjMuyApmr/nqZ3NZZhGr+t?=
 =?us-ascii?Q?1h0T63T8XQq8mtvEHwzLVaDhmhgXjN3cbEwkwYvyNy1qKER8K0v82yIrN5gq?=
 =?us-ascii?Q?c6CL+ITxmjNYKQuqx6UCKHsD+GGKEGHr0QrklHLHpQukfpF4cYQ01fMyEhK2?=
 =?us-ascii?Q?ROliKN31YGsnUZ4D8/a2R0qTLHHk+cVJSzDx60sng/nvpL98Wg8qxi54pfRx?=
 =?us-ascii?Q?8Gmn9UCg/MXT51bSKDqAbSbbLd8DSgm5uMtXO0D7y9H6Ghhkp/5bnEpV7kAn?=
 =?us-ascii?Q?vSJMQPZr4RWZJ/deMmeNvBC+hCbvsBpvmXER2hNUSWLjs1yRm4wXvQW2Mj/F?=
 =?us-ascii?Q?yMxQ70Nq2TwfamPltfiruRVaz32/TYYIooP0nYiZw190syRcldwY8xCokdim?=
 =?us-ascii?Q?P3qo0GPNg3r5sqmzpT58qocG1lxJa45cNV0w+pNMCzFTSDSE6B6mv4CJ5c7a?=
 =?us-ascii?Q?fQEHvxVdAWzzS/1U0wjQl+fr4BvK0lfa6rIMvYgVLXC4VpZf1s0ZyXA70TE7?=
 =?us-ascii?Q?caeFxAiP4VOOkP6PPriYtpKWYPTzbQHLhHl69Wqe3sTP+vRsQxcH3VxVPRn5?=
 =?us-ascii?Q?+bQ6p8PKTeljHtM6MFXySoyzOeDEhFHR3THYRKjrjsDm4I/oRvXhHGjibNbU?=
 =?us-ascii?Q?xbXdSUo+TR2HVQ3TNGIDwsAW/LraYTiodrhHiQ0JMFbrM1T5CpV7mieIoSGW?=
 =?us-ascii?Q?txzy89xjlEGXuwiP6rWplvYSNVC7cDQF8JYrrMJGVPuWHBcvZehD8CbGXG7i?=
 =?us-ascii?Q?kVHOQBlVCwblAstl5UeeR6pO?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eadd2c8-b0ab-46fd-e6be-08d8e4767b74
X-MS-Exchange-CrossTenant-AuthSource: BN3PR03MB2307.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 10:14:40.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdEKbsK+daKXXBiorcaGb5hCr984zBeVOl4WdA688ZlBArS3IIQGt7qQhBjk151DUQ0S6G6nExVCx21et8mY6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3603
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use semicolons.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 9552708846ca..62799c1d9c0c 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -958,7 +958,7 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE;
 
 	if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
-		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES,
+		slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
 		slot->host->mmc_host_ops.hs400_enhanced_strobe =
 						intel_hs400_enhanced_strobe;
 		slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
-- 
2.30.2

