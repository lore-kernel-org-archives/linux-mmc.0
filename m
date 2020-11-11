Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76737C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 07:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FA92072C
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 07:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="QcCwT+hh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbgKKH7y (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:59:54 -0500
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:47500
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbgKKH7x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Nov 2020 02:59:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjXjjtD9Q7V5gcp6IDGpUkMdf1Qwfp6oNo5TDUjlJRYk102+hoImsdY+dsPHc0WVo1CEvp4VUjs9VVMvDrYQdFoo0605e0wlYn2W3C78dP607AD2Xr5Nm54MoayZvn2RtRTpIzSCeq7h6p/O0bn7d2KxGikIXQEJKFOXHb6saqeYw/VoQJHrjGDa21ChuuHA1axsw6OoNSvjk1E+LdTcAa02BfKVuGZywfENQo5i4COmFBannCaDNuguM9GgU1U/CM2haIS6ms/1a70QIjFuG/VWqLw0aYAdA50+WuhFbIfAXGFg7P2NgEbk5EuyzMvO9XnwY7hXQFQZxu8GhIizzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq2Ay8xZzTKEuRpxfTimdd/Hj17tLv04TcB9X9IIU84=;
 b=js985ENX2e0bmjHfyc+CSjufQrNatBlpKxg3PaLbe/34BxIwDq65h+9tn4hHQ5hgK9NZeeEqmIGlXiPzGgR3ngaFwPh3+J8s/wzOrlAAUPBKVFRi9VkSDMyiDOyxNzgbqFgSMhGZAYp7ZnzXyW3Tm3a2ToUs9G515JImX9eaEbVXKzATDLnexxL7EIWFDI6pr9mmOj0iGd4VmjLD3HW41yK1p1RkIBbe6UC6JsAX8sn0Wf+Qhxc4fpj1ivIc8hw62vHSGXVRWotrmCvPf1EQVoWmWwkSXogF3YScItNh57vjH/vPfdCgzfC0dBQNSgTIrUYbh01fxqlrQnCu/EsCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=denx.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq2Ay8xZzTKEuRpxfTimdd/Hj17tLv04TcB9X9IIU84=;
 b=QcCwT+hhtSUlCep46cbEWASEUTfuMXKPVprJNZeBhhme+2nyfs/MN4WedDev8RdkJBOhsHnh1rIoBYXjrX5Ny6xI8aI4TP6vZr41iaLa+IqA0h/OMA49tcF7d04F14EPpzcmTcbsFasXF8yNu+hp7KnRhGzgFc7gdADwQyI6tOw=
Received: from CY4PR20CA0012.namprd20.prod.outlook.com (2603:10b6:903:98::22)
 by DM6PR02MB5130.namprd02.prod.outlook.com (2603:10b6:5:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 07:59:50 +0000
Received: from CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:98:cafe::e9) by CY4PR20CA0012.outlook.office365.com
 (2603:10b6:903:98::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25 via Frontend
 Transport; Wed, 11 Nov 2020 07:59:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; denx.de; dkim=none (message not signed)
 header.d=none;denx.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT039.mail.protection.outlook.com (10.152.75.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Wed, 11 Nov 2020 07:59:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 23:59:43 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 10 Nov 2020 23:59:43 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 marex@denx.de,
 linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 ulf.hansson@linaro.org,
 adrian.hunter@intel.com
Received: from [172.30.17.110] (port=60358)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kcl2c-0006P2-S2; Tue, 10 Nov 2020 23:59:43 -0800
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Allow configuring zero tap values
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Marek Vasut <marex@denx.de>
References: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b04e5acd-d832-3bc5-d76c-24966045833d@xilinx.com>
Date:   Wed, 11 Nov 2020 08:59:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <1605030122-52196-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4095f067-f089-40de-588e-08d88617c377
X-MS-TrafficTypeDiagnostic: DM6PR02MB5130:
X-Microsoft-Antispam-PRVS: <DM6PR02MB51303C4FF261CF0750938AD4C6E80@DM6PR02MB5130.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYRKgaqmdj9+kHj0l4LopnQUs4RL50q/5z61YoIDMRcFKqsIh8Y52s8wHASJ+H8YPd43s8LUvnU0RKT/XRFP259zj+lrfGitpCH1xBoHEULVclyOrxiQ3Ohe1c3oNoQL/0UezApr3J4wOd5g0Gp5TPa3Rfn54vWXgMlIiRIY9HwTIWVkzYHl/PzAEp57bQmXlPbd4i6FlMTsJ0le3/Sqa54ymaK+8Ibt+yppQW3SKBHcS4QyEVx3BahxT4ypiUaZ5nyXwUJCjWm6AhQoV/jsK+NB3IxnikIPOnSvlLFitDqDGurMFEUQ+ga4Msajo7T/f8N4HEq1fa3o6oRetisKHM6MogOlwx8KoM0uJ5jb5zDLiSm8HiWe+Oo+B4tiS6ZWDx3E7NB6hLgoBZ4P/N6M9/GSkLCvfff0YGoHZdgSgRqqCcUM8wjRRPwceB3SzY+kbGZt6YmZQY3WZCpqbWFf0g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966005)(478600001)(44832011)(70206006)(336012)(9786002)(110136005)(2906002)(83380400001)(8936002)(36906005)(54906003)(70586007)(26005)(8676002)(316002)(31686004)(4326008)(426003)(6666004)(31696002)(186003)(5660300002)(2616005)(7636003)(82740400003)(47076004)(82310400003)(356005)(36756003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 07:59:49.4044
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4095f067-f089-40de-588e-08d88617c377
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5130
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+Marek

On 10. 11. 20 18:42, Manish Narani wrote:
> Allow configuring the Output and Input tap values with zero to avoid
> failures in some cases (one of them is SD boot mode) where the output
> and input tap values may be already set to non-zero.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 40 ++++++------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..100621e55427 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -600,14 +600,8 @@ static int sdhci_zynqmp_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  	u8 tap_delay, tap_max = 0;
>  	int ret;
>  
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * ZynqMP does not set phase for <=25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing == MMC_TIMING_LEGACY ||
> -	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
>  	switch (host->timing) {
> @@ -668,14 +662,8 @@ static int sdhci_zynqmp_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	u8 tap_delay, tap_max = 0;
>  	int ret;
>  
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * ZynqMP does not set phase for <=25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing == MMC_TIMING_LEGACY ||
> -	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
>  	switch (host->timing) {
> @@ -733,14 +721,8 @@ static int sdhci_versal_sdcardclk_set_phase(struct clk_hw *hw, int degrees)
>  	struct sdhci_host *host = sdhci_arasan->host;
>  	u8 tap_delay, tap_max = 0;
>  
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * Versal does not set phase for <=25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing == MMC_TIMING_LEGACY ||
> -	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
>  	switch (host->timing) {
> @@ -804,14 +786,8 @@ static int sdhci_versal_sampleclk_set_phase(struct clk_hw *hw, int degrees)
>  	struct sdhci_host *host = sdhci_arasan->host;
>  	u8 tap_delay, tap_max = 0;
>  
> -	/*
> -	 * This is applicable for SDHCI_SPEC_300 and above
> -	 * Versal does not set phase for <=25MHz clock.
> -	 * If degrees is zero, no need to do anything.
> -	 */
> -	if (host->version < SDHCI_SPEC_300 ||
> -	    host->timing == MMC_TIMING_LEGACY ||
> -	    host->timing == MMC_TIMING_UHS_SDR12 || !degrees)
> +	/* This is applicable for SDHCI_SPEC_300 and above */
> +	if (host->version < SDHCI_SPEC_300)
>  		return 0;
>  
>  	switch (host->timing) {
> 
