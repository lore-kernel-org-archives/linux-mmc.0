Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CADC47083
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 06:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89EB161405
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 06:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFDGP3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Jun 2021 02:15:29 -0400
Received: from mail-mw2nam12on2065.outbound.protection.outlook.com ([40.107.244.65]:31009
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230050AbhFDGP3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Jun 2021 02:15:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/FCkb6sf+Yt4+JU/6cMe7yoWcLxudJ6a+nHKrdHFiMcGhNKWUBKjfvcRThWqxyvES6BDx9Hd8l/epSp8EFY/5JF+M/IzQo5NzVgi1ODmjDyDF/ntwQD2t+KHn+3aqFNinZ4jTr6AZ9gs0JcWf0dOZPuT5X0OU5yyBCOmt7JArPpNpiL15/BAaqsAn1NRw1+8F6Gmxx6d1eF8ai7OERUoV82yuZsPKeVRdwneM9uP1IoduJeKOEsNassvT0LiY6/9TOU4cREd/PHRAGYxZkLbdAN/4vUT3hsMCM/zjDxacZdLxqJuH9Nh2CPZAHSWKCseTgKGIhPMts5XULbE1xsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKRHne2sfaVfqlD94/AK3t8rDKC4i5VvytKYUfoRaw8=;
 b=NQIm69/DicPsGfO2mYJgoGOxmugUgzo3Yc5cY0K5gviuYdA2sZvg6P/roQqt4nmGoolUEUDLAJTPBYkmmgZuV2xm6G2qSuGe3N2JP47ZYp3ymSjjSUq+YSEn13U1dibiCwWDTP5wOilqSmHWAyoojhSOe9Y41QNuWEMKuupQnToq9XLXQx/ZZC4LFNX7kTT6Y59iPdnXgUNQhj6cH28NrqOsc7YjgjYBQV/IKBhkVXys8O9ddVrEuqnB19bxHodoNrhvDnknFHa+bzhRmXMutA5/adL29pUkXDAao647c7OIJAWqndDg7kUvrjrN6qNwEWasqsHtGPIhTlGZ1vb8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VKRHne2sfaVfqlD94/AK3t8rDKC4i5VvytKYUfoRaw8=;
 b=ZznZ+HdlLWg5HXhDS1ZfVQ0AqaB/xI1wjMmcUItHNhai6u9rMulZCj2KA93BOlh+vhfZPUN1VjrrLWvQ7xlzg7s1284uI8b28o1UziG2avon74lenVqRO/kxm2YVTbWPFsap8cHOArUs797uaB4TemxWpLVllq81EfEmhHb5pE8=
Received: from BN0PR04CA0041.namprd04.prod.outlook.com (2603:10b6:408:e8::16)
 by CH2PR02MB6328.namprd02.prod.outlook.com (2603:10b6:610:5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Fri, 4 Jun
 2021 06:13:41 +0000
Received: from BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::d) by BN0PR04CA0041.outlook.office365.com
 (2603:10b6:408:e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Fri, 4 Jun 2021 06:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT011.mail.protection.outlook.com (10.13.2.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Fri, 4 Jun 2021 06:13:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 23:13:40 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 3 Jun 2021 23:13:40 -0700
Envelope-to: lakshmi.bai.raja.subramanian@intel.com,
 nandhini.srikandan@intel.com,
 mahesh.r.vaidya@intel.com,
 adrian.hunter@intel.com,
 mallikarjunappa.sangannavar@intel.com,
 furong.zhou@intel.com,
 kris.pan@linux.intel.com,
 mgross@linux.intel.com,
 linux-phy@lists.infradead.org,
 andriy.shevchenko@linux.intel.com,
 vkoul@kernel.org,
 kishon@ti.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org,
 ulf.hansson@linaro.org,
 linux-drivers-review-request@eclists.intel.com,
 rashmi.a@intel.com
Received: from [172.30.17.109] (port=36838)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lp35P-0003um-OE; Thu, 03 Jun 2021 23:13:39 -0700
Subject: =?UTF-8?B?UmU6IFvigJxQQVRDSOKAnSAxLzJdIG1tYzogc2RoY2ktb2YtYXJhc2Fu?=
 =?UTF-8?Q?=3a_Use_clock-frequency_property_to_update_clk=5fxin?=
To:     <rashmi.a@intel.com>,
        <linux-drivers-review-request@eclists.intel.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <linux-phy@lists.infradead.org>,
        Manish Narani <manish.narani@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
CC:     <mgross@linux.intel.com>, <kris.pan@linux.intel.com>,
        <furong.zhou@intel.com>, <mallikarjunappa.sangannavar@intel.com>,
        <adrian.hunter@intel.com>, <mahesh.r.vaidya@intel.com>,
        <nandhini.srikandan@intel.com>,
        <lakshmi.bai.raja.subramanian@intel.com>
References: <20210603182242.25733-1-rashmi.a@intel.com>
 <20210603182242.25733-2-rashmi.a@intel.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <397dc803-f4ea-e8d3-9956-de8b3f537e2f@xilinx.com>
Date:   Fri, 4 Jun 2021 08:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210603182242.25733-2-rashmi.a@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559f8f7a-822a-4f89-a301-08d9271fe610
X-MS-TrafficTypeDiagnostic: CH2PR02MB6328:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6328C767470E450BD8D2FAE6C63B9@CH2PR02MB6328.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HNClYKPjOg1ub2cAQGwIZn434lqY+C4rkC6MTr8wuDdQY98wJzBIZ0rR59MGNJJ2HeABr0wPPN91s9GznDPes8PiprGeu9somz7mFyI8e7yW9XzRs8EFqK+SD5YZ86BA93oFmK1MoH+CcqeBNllP+8cytkAAqKDMF3TPXw2rl8JZB0kqBrLIPHFmSCh7F293Kl0oNZfedS3lZFb+JnjM5QY5T89Z7t3nhAruYrI5i7Uz7uT0ChPI1ktIEedGf3/ZcbMJOOaDuVpsaavGoLdiryuPfqs608IyGjFlozd6v7tQVKn7Syq9OlppnvKLv1g2+Ssw9GPr9HJo4Q0BihMgsQOYEXMSSMd4/y7HiH6h2MUQb3Uyjh5Xei2BwLDdIvkbWP+Yic2VrwNoy+irLsuX6bzVeJmwxB+Nbmp2h5u5Mf94lbLewqsZhCTUtyQkhUqY7YgDrfrzu+OnfDYfXVHi/4a1szcsRf4PRCbl+rBCBp0RgNpRvnMPYNfy8Kaltp7Y5hcLWTEi9bBI0HiAzEkiqBZLQQwnt7Qtgw/+RLSNvcM3Kmwsf0yofDB04J+scugD3xP408lC6oRjCxCOv1e7kh0nTcMs6Kazwg95cj02D/ZIS8ykR7guQLaUo97a2TXVMVzCZSbJ7DjTFSaNHn4MK24SBvO7jITB+AxyM6B6z1jnGDOR06ZJicW7YzAkO9b0HwpglG8k5FLGs2ASACmWbmcztsRv/xQ0q1N/r5NweHSCehUnC8eEIOCq77WLjDuVKdnfZLyuvkh6izb4O3AUag==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(346002)(396003)(136003)(46966006)(36840700001)(47076005)(7636003)(316002)(36860700001)(31696002)(44832011)(2616005)(82740400003)(4326008)(426003)(36906005)(336012)(921005)(83380400001)(26005)(70206006)(186003)(82310400003)(53546011)(70586007)(54906003)(8936002)(31686004)(356005)(5660300002)(36756003)(110136005)(9786002)(7416002)(478600001)(6636002)(6666004)(2906002)(50156003)(83996005)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 06:13:40.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 559f8f7a-822a-4f89-a301-08d9271fe610
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6328
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 6/3/21 8:22 PM, rashmi.a@intel.com wrote:
> From: Rashmi A <rashmi.a@intel.com>
> 
> If clock-frequency property is set and it is not the same as the current
> clock rate of clk_xin(base clock frequency), set clk_xin to use the
> provided clock rate.
> 
> Signed-off-by: Rashmi A <rashmi.a@intel.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 839965f7c717..0e7c07ed9690 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1542,6 +1542,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	sdhci_get_of_property(pdev);
> +
>  	sdhci_arasan->clk_ahb = devm_clk_get(dev, "clk_ahb");
>  	if (IS_ERR(sdhci_arasan->clk_ahb)) {
>  		ret = dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
> @@ -1561,14 +1563,22 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  		goto err_pltfm_free;
>  	}
>  
> +	/* If clock-frequency property is set, use the provided value */
> +	if (pltfm_host->clock &&
> +	    pltfm_host->clock != clk_get_rate(clk_xin)) {
> +		ret = clk_set_rate(clk_xin, pltfm_host->clock);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to set SD clock rate\n");
> +			goto clk_dis_ahb;
> +		}
> +	}
> +
>  	ret = clk_prepare_enable(clk_xin);
>  	if (ret) {
>  		dev_err(dev, "Unable to enable SD clock.\n");
>  		goto clk_dis_ahb;
>  	}
>  
> -	sdhci_get_of_property(pdev);
> -
>  	if (of_property_read_bool(np, "xlnx,fails-without-test-cd"))
>  		sdhci_arasan->quirks |= SDHCI_ARASAN_QUIRK_FORCE_CDTEST;
>  
> 

Manish/Sai: Please retest this on Xilinx SOC.

Thanks,
Michal
