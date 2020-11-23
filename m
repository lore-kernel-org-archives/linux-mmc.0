Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FA1C2D0E4
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 07:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061022078E
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Nov 2020 07:01:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="MWry/IUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbgKWHAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Nov 2020 02:00:43 -0500
Received: from mail-eopbgr760072.outbound.protection.outlook.com ([40.107.76.72]:14083
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgKWHAn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 23 Nov 2020 02:00:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF+wp9o7sP2/Y7gACndYwpci4yCzgTND1xwghqNHr/GbrXWLjbJYhFd+CZfoKnRuiWaYJ++5fRBZ6P4hq+U2K+z4yOPKVmZ49wD+TVqNUkcvjRDZ1M5eud7OlI9j1Mkzuyl66Tzw4fTRa/1+XHVH961S798C/2I7thM8g8gQq0Bce/DjN0cIYAJ6E2FwSqFQ11ZoQZwpN6WDglax6VCutwMUlI0/04EA9KILOHs8BNfrp0EYXxzmNCf0qaISFf5kyGGLxF7f2eqOZjCz5QtW3A49d3hGqd+JxuJljpTZXbzSdGsnF4a5CWDe52NLAmcpsQ4HW7gUcGGiIr5pvEKOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FyMBEq0IzR3AfIjsQVd4qfGEAVJyfcbBR1iKaMcdDc=;
 b=arxM9BQse8ebCOGgwAE2sULdgJEEXDXMPqgkcTYrGTIZcsd6Fi0SoK+q+caFHzr1Eg7OFXSfH0cHBrQzTdbNBzAQ7VREeAIQAMUMCav32iNQb8rG9zk8FesGFGc021cENyVxnVhlRqr7D93jkU+VT8C1TZlj+zDHhH8DXtZ5pYTok6nhDOnqAN/M9/pKT1KAGXdr4/0Nd9rQMa1hAXsCk/2hG84miMrYgHSgjAQ8LT9slyrN6pzq1Ws5bpo3CcV8vsq8PtUEpmzu2PGRThv88r4RYu7CAjbHMw5Doz/IzDR3RDBRYPhd4iVKF0LCvFIEXp8FrTPpShNEKeCNsH1gAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5FyMBEq0IzR3AfIjsQVd4qfGEAVJyfcbBR1iKaMcdDc=;
 b=MWry/IUmneXsQ8pfk/KZvrW1fnWWNdXr/br3GA09W205iybk+Kws7jgZ9srUQf0H3WtLKFq8S9Av9f4geHh3nbzYHHNeMyfLekPRNBlsNLMe2jOihXVH/XXS08QUSvkidmveFc7rHYBzLTg/HHhv8YvjFDDNv8z+zULTXkHIYRI=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by CO6PR02MB7827.namprd02.prod.outlook.com (2603:10b6:303:a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 07:00:40 +0000
Received: from BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:236:cafe::4f) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.14 via Frontend
 Transport; Mon, 23 Nov 2020 07:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT015.mail.protection.outlook.com (10.152.77.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 07:00:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 22 Nov 2020 23:00:38 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 22 Nov 2020 23:00:38 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com,
 gustavoars@kernel.org
Received: from [172.30.17.109] (port=38970)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kh5q2-0005mM-8f; Sun, 22 Nov 2020 23:00:38 -0800
Subject: Re: [PATCH 098/141] mmc: sdhci-of-arasan: Fix fall-through warnings
 for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Ulf Hansson" <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ae070e37-f631-d016-d436-92f59a0e59e1@xilinx.com>
Date:   Mon, 23 Nov 2020 08:00:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <387cab3a466038aa5d1fc34b8b6a7c4f693826ea.1605896060.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccbab119-ca5c-4ab1-b538-08d88f7d7c69
X-MS-TrafficTypeDiagnostic: CO6PR02MB7827:
X-Microsoft-Antispam-PRVS: <CO6PR02MB7827109357EA8CE212D461A2C6FC0@CO6PR02MB7827.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nacUfrcHepkfCiNBhG4XiYj8rU/DX7dMz/kWx1eoJYE73s+wmueHAMuIw/2XDs+iGn6WPRujlxD0mpDkPzFQcDbZimbsPnKhU8HZLzKM5xE8ZJR0a3yug3wzTJOfil4uXwa2BmzeMEsr3zMUKpkTZKhlZeDhhLNCaWS1zcIKBJ07riLVAq43Ga1vTAUHVFEjkY83xwt6sCFJYMjB8LZCWCkbJaqb4asSys+ohgbyCTSou5CZYDJVF16/7KaUUHvhONs7jzf7kK9ZWTvBeOPNNv49nkZc0bVGY/4hoWf1E+RBOIAKYWYPRfgYaD2joEaRz0aw6cU6A7QxyMglcEWfXI+MoU2C/CcquVYdoxsTBrVp63/AXhDhh9mdXIsfmJC/uKajf1pelnEoAAKV9N31Ngf2kiAwWz8owI6vYNdX6BfBCvG977gylSrdl9Vo1bDBw0/BY8IQhqjKYulaUmOB/4PpFaRNRz2cynQXVsyExhgY2BZ01VteGT2UpbjUgEYLbl3A6njJEgOXVB+hkIIocQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39850400004)(396003)(46966005)(70206006)(2616005)(36756003)(44832011)(478600001)(82310400003)(8676002)(31686004)(70586007)(31696002)(83380400001)(36906005)(9786002)(966005)(316002)(356005)(6666004)(336012)(426003)(47076004)(110136005)(82740400003)(2906002)(54906003)(4326008)(8936002)(7636003)(186003)(5660300002)(26005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 07:00:39.2502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccbab119-ca5c-4ab1-b538-08d88f7d7c69
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT015.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7827
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 20. 11. 20 19:37, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding multiple break statements instead of
> letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..1f7e42b6ced5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -627,6 +627,7 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  	case MMC_TIMING_MMC_HS200:
>  		/* For 200MHz clock, 8 Taps are available */
>  		tap_max = 8;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -695,6 +696,7 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	case MMC_TIMING_MMC_HS200:
>  		/* For 200MHz clock, 30 Taps are available */
>  		tap_max = 30;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -760,6 +762,7 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  	case MMC_TIMING_MMC_HS200:
>  		/* For 200MHz clock, 8 Taps are available */
>  		tap_max = 8;
> +		break;
>  	default:
>  		break;
>  	}
> @@ -831,6 +834,7 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	case MMC_TIMING_MMC_HS200:
>  		/* For 200MHz clock, 30 Taps are available */
>  		tap_max = 30;
> +		break;
>  	default:
>  		break;
>  	}
> 

No problem with it.

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
