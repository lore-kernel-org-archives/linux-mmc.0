Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76875C55ABD
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04F9C2071E
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Nov 2020 07:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ToMnoqO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgKPHJz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Nov 2020 02:09:55 -0500
Received: from mail-eopbgr690045.outbound.protection.outlook.com ([40.107.69.45]:31298
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725819AbgKPHJz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 16 Nov 2020 02:09:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mblr5f+bwnMLPf0N6RIGGw3JaVAl0RbfjqAaklQUnlROC0lq6xYfiW9HaUPIQlJfJN3egA0qjoZMGARsfywHQIOEUOPllXps7lQpoW72duVEY+LRfGLOkEo22YPnpYuicx4KT1/Yej+MhvuvspseODg1AoaOluHujoaJo+eAAnVKOr/DwmEnFHc6Nmqo9YJ6WLYwnPvZkSAEQqXGNQJS5Clm8ZTZbMEianKFd0IwRlgFDcyx1GY1Y/nBtsae6rYuvVrxP1UN4ezQp9QrpDAGeZsSgS/LqpQdJpX2vZILUj70pDsHWNykWj8anS1cUxzOWsGFLwLDTfolaiV+djCYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcHcLt0Ev+E1HSS3yHOLZZKcparKMg2b4rIFoFgGkBs=;
 b=bvR3qsydjpw68VC5t96YfJtLUabkeY6ZcvmwY3iz/+H5O65Fp47GLB2UQugPJI0KW89yvxK+i5EeYIMW85ihQ27PwRZ8F//NszLRttbf9UHyHVA3drLgTtmJGe2EuYwqL6zJ/c3+9voDNP8S+QQthKQSEwNFWXr1p4b/KtJxRXEAQ6wDXo7qyIDceIbQ3jq/GqRN6vqyjuEtkg1C9ra458IBG9lw8lHdLzlannjQ1X8ba/hJMDAj6hpWM7niHxtQVkzHBPcN4TX1JKseokZmxJSDEYnOOp490zRr01cTK5Mi4/gPtngAalNsa0TnCswWNVcdrZ2HLc0Z7MhZK9avng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcHcLt0Ev+E1HSS3yHOLZZKcparKMg2b4rIFoFgGkBs=;
 b=ToMnoqO8K+vda3oCrPPQck7yhcJdmM1+pH4boLVpE+eyq3UGCJJygXcqGeFwKs54zoSas8B0XB3252FOdeIrk4ywe1tzZVXdnw3ruVSOEbF6UyTo6Kr1aHP8Kjb2V/0GC0xPCcTh5dq+ate9JpOMS4Jv1kGLpIVxT8xe/JidnKU=
Received: from MN2PR14CA0001.namprd14.prod.outlook.com (2603:10b6:208:23e::6)
 by BL0PR02MB3890.namprd02.prod.outlook.com (2603:10b6:207:3e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Mon, 16 Nov
 2020 07:09:50 +0000
Received: from BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23e:cafe::89) by MN2PR14CA0001.outlook.office365.com
 (2603:10b6:208:23e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28 via Frontend
 Transport; Mon, 16 Nov 2020 07:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT044.mail.protection.outlook.com (10.152.77.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3564.22 via Frontend Transport; Mon, 16 Nov 2020 07:09:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 15 Nov 2020 23:09:35 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 15 Nov 2020 23:09:35 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=37256)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1keYdq-0005Y9-KV; Sun, 15 Nov 2020 23:09:34 -0800
Subject: Re: [PATCH 2/2] mmc: sdhci-of-arasan: Issue DLL reset explicitly
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1605507327-106818-1-git-send-email-manish.narani@xilinx.com>
 <1605507327-106818-3-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <62e86fcf-a50c-6e7a-3eb2-919f0cb34c01@xilinx.com>
Date:   Mon, 16 Nov 2020 08:09:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <1605507327-106818-3-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41cc7432-8713-454c-83e1-08d889fe9c1e
X-MS-TrafficTypeDiagnostic: BL0PR02MB3890:
X-Microsoft-Antispam-PRVS: <BL0PR02MB3890CB9A2979C35E9416E501C6E30@BL0PR02MB3890.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBQcB++THDWCOB4JHt1pkzV5Fsfw0xTuLdzXMh29Pkf72en5zPw+IjAn9vdzy96cPF+etM+hblg2uiDtrZfowosEmkpdsKnYRRlnUHIftAKq+UOLpio+rvwJlf8hd0S02uUowh7w+wnMcrfaEfIXnEQLm5iYZfpuAn2WEVF22mrCARoezVVjZfwzta0VSBB2GPCClhJIzCSpAGqIPqwo9PoCcZ+DfgBJJT1wJpfoMQfjWZtaKRMK4DAQuvLqQsedEAEkTXcOTzBXwjb84JM3ywFbnGIWWj+WQ5IkE6vsTGTXLVChotYRa0befjj13+Pme8ZAc++jJBWSooi7fwlbKcbnOq2zy4wf4y1kBZMzxrMepfMMqQIinYV+FzWPBLPo6KUp5Eh8p2KLE9KVCu+WGScukU1RPhX3YPQjaiECGtDP1T7bGgBjfJR0AbTKuipxGfNEGEPHFmcQTW3MhiOlKQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(346002)(376002)(46966005)(26005)(54906003)(31696002)(8676002)(31686004)(9786002)(110136005)(83380400001)(356005)(2906002)(7636003)(8936002)(316002)(70586007)(336012)(107886003)(426003)(82740400003)(82310400003)(478600001)(44832011)(36906005)(186003)(5660300002)(2616005)(47076004)(70206006)(4326008)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2020 07:09:50.5449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41cc7432-8713-454c-83e1-08d889fe9c1e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3890
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 16. 11. 20 7:15, Manish Narani wrote:
> In the current implementation DLL reset will be issued for
> each ITAP and OTAP setting inside ATF, this is creating issues
> in some scenarios and this sequence is not inline with the TRM.
> To fix the issue, DLL reset should be removed from the ATF and
> host driver will request it explicitly.
> This patch update host driver to explicitly request for DLL reset
> before ITAP (assert DLL) and after OTAP (release DLL) settings.
> 
> Fixes: a5c8b2ae2e51 ("mmc: sdhci-of-arasan: Add support for ZynqMP Platform Tap Delays Setup")
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 3ec5ecad637c..e066d8f51954 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -635,6 +635,9 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  	if (ret)
>  		pr_err("Error setting Output Tap Delay\n");
>  
> +	eemi_ops->ioctl(node_id, IOCTL_SD_DLL_RESET,
> +			PM_DLL_RESET_RELEASE, 0, NULL);
> +
>  	return ret;
>  }
>  
> @@ -794,6 +797,9 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
> +	eemi_ops->ioctl(node_id, IOCTL_SD_DLL_RESET,
> +			PM_DLL_RESET_ASSERT, 0, NULL);
> +
>  	switch (host->timing) {
>  	case MMC_TIMING_MMC_HS:
>  	case MMC_TIMING_SD_HS:
> 

this won't apply. It needs to be fixed.

Thanks,
Michal
