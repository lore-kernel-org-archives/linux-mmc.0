Return-Path: <SRS0=IwUb=AU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06AD1C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 10:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78A9207BB
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jul 2020 10:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="k5uOXI6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGIKCL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:02:11 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22780 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbgGIKCK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 9 Jul 2020 06:02:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594288929; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=v+jwstoVbZ4249Wkrj/1thWtYXqQODzL8Dy0S6jd7/o=; b=k5uOXI6I6ju/NY026cIXOj6pyesG3oThX7yruA+wLPwsmqwrJSdr6jF5bN+nsTgBnWc0bjqJ
 I27lDOGn06k/TC17ib4ZOCMs66ulwzcZ8IVEDCk+7+JhZTjX9RvtfscnTdIC/9lnzyFwca6f
 lykPjlq81NRgjEiNAj497SkNoV0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-west-2.postgun.com with SMTP id
 5f06eb190082b27848325cc4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 10:02:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1A705C43387; Thu,  9 Jul 2020 10:02:01 +0000 (UTC)
Received: from [192.168.0.103] (unknown [183.83.66.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92730C433CB;
        Thu,  9 Jul 2020 10:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92730C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [bug report] mmc: sdhci: Allow platform controlled voltage
 switching
To:     dan.carpenter@oracle.com, vviswana@codeaurora.org
Cc:     linux-mmc@vger.kernel.org
References: <20200709094338.GA17926@mwanda>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <d4c802c3-ac84-b27d-53b8-fcaa109f622c@codeaurora.org>
Date:   Thu, 9 Jul 2020 15:31:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709094338.GA17926@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Thanks for reporting this issue. Will post a patch to fix this issue.

Thanks
Veera

On 7/9/2020 3:13 PM, dan.carpenter@oracle.com wrote:
> Hello Vijay Viswanath,
>
> The patch f870b6d480d3: "mmc: sdhci: Allow platform controlled
> voltage switching" from Jun 23, 2020, leads to the following static
> checker warning:
>
> 	drivers/mmc/host/sdhci.c:4396 sdhci_setup_host()
> 	warn: potential ERR_PTR parameter dereference 'mmc->supply.vqmmc'
>
> drivers/mmc/host/sdhci.c
>    4375          if (host->caps & SDHCI_CAN_DO_HISPD)
>    4376                  mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>    4377
>    4378          if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
>    4379              mmc_card_is_removable(mmc) &&
>    4380              mmc_gpio_get_cd(host->mmc) < 0)
>    4381                  mmc->caps |= MMC_CAP_NEEDS_POLL;
>    4382
>    4383          if (!IS_ERR(mmc->supply.vqmmc)) {
>    4384                  if (enable_vqmmc) {
>    4385                          ret = regulator_enable(mmc->supply.vqmmc);
>    4386                          if (ret) {
>    4387                                  pr_warn("%s: Failed to enable vqmmc regulator: %d\n",
>    4388                                          mmc_hostname(mmc), ret);
>    4389                                  mmc->supply.vqmmc = ERR_PTR(-EINVAL);
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is an error pointer.
>
>    4390                          }
>    4391                          host->sdhci_core_to_disable_vqmmc = !ret;
>    4392                  }
>    4393
>    4394                  /* If vqmmc provides no 1.8V signalling, then there's no UHS */
>    4395                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 1700000,
>                                                              ^^^^^^^^^^^^^^^^^
> It is dereferenced inside the function and will crash.
>
>    4396                                                      1950000))
>    4397                          host->caps1 &= ~(SDHCI_SUPPORT_SDR104 |
>    4398                                           SDHCI_SUPPORT_SDR50 |
>    4399                                           SDHCI_SUPPORT_DDR50);
>    4400
>    4401                  /* In eMMC case vqmmc might be a fixed 1.8V regulator */
>    4402                  if (!regulator_is_supported_voltage(mmc->supply.vqmmc, 2700000,
>    4403                                                      3600000))
>    4404                          host->flags &= ~SDHCI_SIGNALING_330;
>    4405          }
>    4406
>
> regards,
> dan carpenter
