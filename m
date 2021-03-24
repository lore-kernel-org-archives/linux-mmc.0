Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F6CC433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 07:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF13619F6
	for <linux-mmc@archiver.kernel.org>; Wed, 24 Mar 2021 07:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCXHrp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 24 Mar 2021 03:47:45 -0400
Received: from mail-bn8nam12on2069.outbound.protection.outlook.com ([40.107.237.69]:38496
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231344AbhCXHrf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Mar 2021 03:47:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmkFKN/14j8VilnlQPFnQTzdrRL8X2QejA61NAz19Gh7p3YG6p60gZhK41pNBSqk2/nPXbD8mL7sH8JcdmP8q9z9pP1idFtuQCiHBRTw5/xMhWBDXFQAQzKWFAwZ0ihdpqpFJ1/2wN2gHDFHvg9cZWW1DMZwCG0NV3izVbsZZf6McuZB1wywMlf6iqXDY9xAa3LFzbv/uXyODGbCKxJX4YASLUq0DD/MzWQsCU077xMqFYM4Mjiu2EL+FrzdlWN1vmYJz89Mm+7NDWjAngphURbvgoKzb6+CFtsRG4jVlbPdoESZqhwagSclN2z4Z304fsa0LiXNWSvrxuNHqkJBpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRY4slBiMcBX+GaFohZmvlolgcLAtvqkZGYPj2aLarY=;
 b=jNAqujCgazjH9mTqYMaYkWYKjwTWqlHd5CnQ/E4w95gqQLeb6dDgJmqQPIjHdPcL+Cwlhj0paCxXWTkYh3l0Bn/b5UPyU2dsnnTdJIjyzoabUb+M+0u8q5VuaSLK6HNIYM5D+M2yn+A1vf1UKq2e/bnboTg4ZSYVs9SD2JB4W/nq9PnW4MbfZi2V3jRYmXM/ubYd5G+uGYUChWBhdfIhCAO3aKqzJ3HRDuN4yKg7LSswLo6AVK31TrMln2O6WaNi+bmH3ipjnVLkWSf2BnROmTCneliKYxIvjhUrcLBN0m7gPYVzV8EOmKbrfZqNWLlwt8Wf1oq3m+qPKHDc7xJPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRY4slBiMcBX+GaFohZmvlolgcLAtvqkZGYPj2aLarY=;
 b=hMHgC34m2kVnnFjsoOUF4uIXWiu1x3bQ1t46NBnjgcaqljN26dmy1fZ2TICyZvgssL2RAqmWvfZXlEjLAg1r23uaBZNputWniAkyr8C90ApHfVNWA0kja2e72r8SoBb5XqoqP+XV9WsmQTXQPNiqw51d1qYkzcga8W4+s7GJGDA=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4551.namprd03.prod.outlook.com (2603:10b6:a03:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 07:47:30 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 07:47:30 +0000
Date:   Wed, 24 Mar 2021 15:47:21 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-of-dwcmshc: set MMC_CAP_WAIT_WHILE_BUSY
Message-ID: <20210324154703.69f97fde@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY3PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::16) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY3PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:39a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 07:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 424e3897-05db-4863-aefa-08d8ee9913ad
X-MS-TrafficTypeDiagnostic: BYAPR03MB4551:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4551537B1C148F12F9C1D8FEED639@BYAPR03MB4551.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YwrhL44RStT9mBU3WYLH2ClwQHyUKKbfmUjo+W5KXf2Mpu28l7UOVLKDh+W4qqFKCzBQCUY/eMnqYz4GcvmeeyMc82AtN+o1dYTJLKIrCoqwcl6UEtKTbdgLtSDVt5YUjdd5I4zdBzj9GD6LgL2VH5qR1NtGn5EO29osZuEEv4pWEj74c6/yo7m2dlQFyRFHRMGofDZ/jcZqGcr5XHweTjUCFyj/Ynj7nRafg8OTM+U4uuqcaR5dN62bz1Jp7ks5ecnHxDZEhCqlkCWNAKKjNcgW9Bqp/ovCycUGZS/j33vsm02I583LRwlHaSLZqV5LiY94fanBYZSQMjS9nb1W0A6TtnMXsR7CdkmRXzLBSM3EVmHDgzW7hlU854/+c9gArQI4ddaN6LLHnQjQQwsnI6Tyob7iyYMD9yaFJ7fzfK9Al0UtuIn6gE8M6GjIEV42QWj0pUlQkuM7cg0nidGDrFz0Du9hdebeTti4JFeyaDtoK1kp+8iKejJ4eSpJxZRVqhJjogX8XMNzkj0TCzRO+2ST6fxaM0WCRrD9xD7tuxm+xri03/1Oy5HHYRUyosuN8BTrml2I5h/rTy940545JfLUoSrwc7/fdg9XB5VCiATZvyG/Ywlj1uCfL5kedBnejFOEi7ne4eaZFVadV8A3i4GyfKgydQ2ZlWQQE7BWnsVSgBGhegZV20VrQi+z7ePa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(83380400001)(5660300002)(2906002)(16526019)(4744005)(478600001)(8676002)(956004)(66556008)(8936002)(52116002)(7696005)(6506007)(66476007)(55016002)(6666004)(86362001)(110136005)(1076003)(316002)(38100700001)(26005)(4326008)(186003)(9686003)(66946007)(133343001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?hET3Kv3Qc5ZzhTjogHTKjVpbNM5gYOWCN5w6Q+RvBmVrhvKaY2Qv99VZxQN0?=
 =?us-ascii?Q?5KIKCOxTjXdydGIhbKcCQzzbBYtb77n7rHXfXXlI+1hlYNpMtHXkv6uEUGK4?=
 =?us-ascii?Q?LGGfXC04N17tdc4lC6yE4oncyHSUA6ynT56SMjWo1tsALuEnBdhTMBORjqcN?=
 =?us-ascii?Q?54Oxi+ndr0srNma8M405AuaVqEHsCPJEqMg4Q0JjnVGElp3nfBlfOfDOtAZf?=
 =?us-ascii?Q?KISG3C5LQbTBvFhfv23QhXndbG0L4sF1O2l6PUDl350ovFRMqorTvjLw9yzm?=
 =?us-ascii?Q?wTsxZoTbMeTNPXGspw3ztaydKymHmpvb2PCPexSGjEcz74g1Zk9jaJX84iJ8?=
 =?us-ascii?Q?mWpf97jU9HOjoDOUNhTLrX1jy8KO1A9a/mdt2cd311wphhIL8pYewy5laNHV?=
 =?us-ascii?Q?LUWMknhmbfww97DJNXSON4OuxA2CKFTemv3K4cNuDSBL282L8Jr78rpWICDn?=
 =?us-ascii?Q?s50IflQ4jMCqiRWSIyJj13+TxdgGN6LIhdUER5eTN+fEQB55QpmEuKPuy624?=
 =?us-ascii?Q?vcuZ9zoYnS13jCkAAzn5AUGVwr4kV+Uu/NwH8NpIx9AK4bNJ8QciFq3FkUte?=
 =?us-ascii?Q?evYgwT+Lwt41ble60d6showyEiq5XU1g0aLnnt+cmPxr5dgdugAo4NlXRqZA?=
 =?us-ascii?Q?PEmzWgPQILiFlRc68Aa2Jd/BldUwsOgHvqI0Xj8wFKmwKnkQwoCYOweAAGyd?=
 =?us-ascii?Q?KEMENAFY/D8c0hlz8gJr++7Fm1DDjX2lHIhVGlG4Jb+y+XZvu8SdOkyFT127?=
 =?us-ascii?Q?mPzgq4SHOPiognLMdbtY56+kmbidb3xtcnoaxDWQNeHSa8ke9DlQLFr4CmMm?=
 =?us-ascii?Q?dKoAHcOCJm4oFqkJYn1ajJyDUS50LemNfGpFEAwZFmrIrzhveq14860xv13I?=
 =?us-ascii?Q?psWflZ5qC9O0JYYWjqGRBQKo8Qzt02bHr1aCQnCNKDLEfOVgZdAxhGvLwf4j?=
 =?us-ascii?Q?GOKu0xk+WROA50cq3Nqrxhvv83ihVVac09dyzR9oVi0X68IdiXqLln7O2ihE?=
 =?us-ascii?Q?1WvIoZEcVhx8sP2rVwBTyfzqLa+wwI1fnpIpawW51zLpCNYuNhHqcvT3usMg?=
 =?us-ascii?Q?//Mm72iWEMdMm3e8vJEzSBghRpTtvgr5sLRFvk+298hzLn5kEsfF0I4Ku/Zc?=
 =?us-ascii?Q?oLC6sSsP0m1sLzoviqs7ggrjNHymtu7znvq/SrpkdVRqGI7k0GyEtO2ypw60?=
 =?us-ascii?Q?y0faAtBra+uVpUjjE2n+c19KFzhNN1HYrHEwZMVjYOxA+KWWeVx4KNgW3DW/?=
 =?us-ascii?Q?YGtplDr9rARYN6xtKdNpdOCJoxha6hU0iEUbQFzU0Le2VayXJbgo6r6SyM7A?=
 =?us-ascii?Q?N2hwo3E4jLPRY6Yrrh9LhNUD?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424e3897-05db-4863-aefa-08d8ee9913ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 07:47:30.2333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wyw9L0sT+Cxo/vrD5UOeghVvCc/MOs3dfbQfLWayND4izIZl5uwpCTIGimxHmLnzJEazWbIijlfMyhKjpwL8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4551
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The host supports HW busy detection of the device busy signaling over
dat0 line. Set MMC_CAP_wAIT_WHILE_BUSY host capability.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 06873686d5e9..b6ceb1b92b3f 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -393,6 +393,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 			goto err_clk;
 	}
 
+	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
+
 	err = sdhci_add_host(host);
 	if (err)
 		goto err_clk;
-- 
2.31.0

