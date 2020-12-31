Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C0FC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Dec 2020 06:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB92D22288
	for <linux-mmc@archiver.kernel.org>; Thu, 31 Dec 2020 06:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLaGm5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 31 Dec 2020 01:42:57 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:48315 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLaGm5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 31 Dec 2020 01:42:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1609396953; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OG7q1REiQSPkTlES34Ckv8c4QBwurXTi+jB+GQDEsKI=; b=xVYVDmL/Xm+peiHKhSpFPm6Hp0a3e1pBb36mUcZm4XBAtuF4fpzuqBN8B+WD6tM3yhutHS7F
 MgoNU2cj9Z1Vgi+qowkIVXBt/rkY2tr0lyeVYh0SzXJITLzfrLsh3TtAf6hyOeyjmSB6tfpm
 M3qwVphrXnakMZhA0jpNGYC3Yfw=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fed72bd584481b01bdb3189 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 31 Dec 2020 06:42:05
 GMT
Sender: vbadigan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B26A7C43462; Thu, 31 Dec 2020 06:42:04 +0000 (UTC)
Received: from [192.168.1.7] (unknown [117.198.144.215])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 84A56C433CA;
        Thu, 31 Dec 2020 06:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 84A56C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH] mmc: sdhci-msm: Fix possible NULL pointer exception
To:     Md Sadre Alam <mdalam@codeaurora.org>, bjorn.andersson@linaro.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     sricharan@codeaurora.org
References: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <9687f027-7a5d-2959-82fe-96e68d59c1ab@codeaurora.org>
Date:   Thu, 31 Dec 2020 12:11:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1608626913-16675-1-git-send-email-mdalam@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 12/22/2020 2:18 PM, Md Sadre Alam wrote:
> of_device_get_match_data returns NULL when no match.
> So add the NULL pointer check to avoid dereference.
>
> Signed-off-by: Md Sadre Alam <mdalam@codeaurora.org>
> ---

Reviewed-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

>   drivers/mmc/host/sdhci-msm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 9c7927b..f20e424 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2235,6 +2235,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>   	 * the data associated with the version info.
>   	 */
>   	var_info = of_device_get_match_data(&pdev->dev);
> +	if (!var_info)
> +		goto pltfm_free;
>   
>   	msm_host->mci_removed = var_info->mci_removed;
>   	msm_host->restore_dll_config = var_info->restore_dll_config;
