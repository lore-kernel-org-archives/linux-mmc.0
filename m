Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829AC38A2A
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 123C52073A
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 13:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kUOFuDGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgEFNBE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 09:01:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:14415 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728173AbgEFNBD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 09:01:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588770062; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=EEVpYpqQ1QRwHdkwdt5mqy1ieqOZLEZitiAbr0eLLME=; b=kUOFuDGhhKgCxFzxKfm1vuTPZqlPt6UTHSjgFfZKadV8Jp+YiqYDKy7B5SVoRq7O6xR4Pwb3
 6qx3aDQb2iMdiiinuqSgw8d5WlaCkq1XqYQSlDHH4RfJ4cHnvy6A/OXUjmHKwDxSFxjWshOG
 LjluxZTjd8j8DjNQ2Gwxjrv8UeA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb2b4e8.7fc83cd1fdf8-smtp-out-n03;
 Wed, 06 May 2020 13:00:24 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0BFC2C00456; Wed,  6 May 2020 13:00:20 +0000 (UTC)
Received: from [192.168.43.57] (unknown [27.59.131.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9225C433BA;
        Wed,  6 May 2020 13:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9225C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: [PATCH v5 1/5] mmc: core: Extend mmc_of_parse() to parse CQE
 bindings
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>, mirq-linux@rere.qmqm.pl,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Pavel Machek <pavel@ucw.cz>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pan Bian <bianpan2016@163.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Mathieu Malaterre <malat@debian.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <1588031768-23677-1-git-send-email-chun-hung.wu@mediatek.com>
 <1588031768-23677-2-git-send-email-chun-hung.wu@mediatek.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <9bc2454f-0b42-e256-7927-2564b56f369f@codeaurora.org>
Date:   Wed, 6 May 2020 18:30:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588031768-23677-2-git-send-email-chun-hung.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 4/28/2020 5:26 AM, Chun-Hung Wu wrote:
> Parse CQE bindings "supports-cqe" and "disable-cqe-dcmd"
> in mmc_of_parse().
>
> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>   drivers/mmc/core/host.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c876872..47521c6 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -302,6 +302,11 @@ int mmc_of_parse(struct mmc_host *host)
>   		host->caps2 |= MMC_CAP2_NO_SD;
>   	if (device_property_read_bool(dev, "no-mmc"))
>   		host->caps2 |= MMC_CAP2_NO_MMC;
> +	if (device_property_read_bool(dev, "supports-cqe"))
> +		host->caps2 |= MMC_CAP2_CQE;

This change is breaking emmc driver on qcom platforms where this dt 
property is defined.

[    1.543453]  cqhci_deactivate+0xc/0x38
[    1.545627]  sdhci_msm_reset+0x40/0x58
[    1.549447]  sdhci_do_reset+0x48/0x7c
[    1.553180]  __sdhci_read_caps+0x7c/0x214
[    1.556913]  sdhci_setup_host+0x58/0xce8
[    1.560905]  sdhci_msm_probe+0x588/0x8a4
[    1.564900]  platform_drv_probe+0x4c/0xb0

So, we cant have this flag defined before sdhci_setup_host().

I will have to clear this cap and re-enable it in our initialization.

> +	if (!device_property_read_bool(dev, "disable-cqe-dcmd")) {
> +		host->caps2 |= MMC_CAP2_CQE_DCMD;
> +	}
>   
>   	/* Must be after "non-removable" check */
>   	if (device_property_read_u32(dev, "fixed-emmc-driver-type", &drv_type) == 0) {
