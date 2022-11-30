Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CAAC352A1
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Nov 2022 11:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiK3LzT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Nov 2022 06:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235202AbiK3Ly4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2022 06:54:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A26B393
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:54:38 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so40651147ejb.13
        for <linux-mmc@vger.kernel.org>; Wed, 30 Nov 2022 03:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSZH+b93DY0j3j6gGnMQsORZ2t5K5X0SUvr79UwRY/A=;
        b=WoZ7z1cZP3uZRYuN/53ae3E2LgtBUl3W8TBEbCS/CXQEWJc04afrUfpR1HgqG5hNZa
         jKrnWhe+B0qWtZQ0OQ2QheibwVCAuxTbXqbglYvYDgN1fpOEWfDJNro8hWyw2lheoUH4
         0ha5PMouKtADwE4dtandYSILW4xDHfdBBqNiJ/0uZr5OVHId+ONv8QQZBiMVPwOeqCFv
         PxTw38A41/aEiT8ASJXphG66OiQX6Kd2DJ041MRg31FEz0frihNl1C+1dG7RDERz1baQ
         YCc4zXlkuEeVXy1UBFBKZBvIOr4z+o8KW+y20LgQwCoLwBs5LRYImI99TDYh/tib7F0B
         m0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XSZH+b93DY0j3j6gGnMQsORZ2t5K5X0SUvr79UwRY/A=;
        b=4iYYHLsTtDNBhY8U0IhgmTdCjPV+E7fXIxvD9/BtsvYQXlwmNfcFkt6egvTaWArXy/
         zCm4ZnrEgH7zUwPMeYRX4edndJkbJ7Pv2e1vwwNh43twBWZsbDG7jJW7ry1Vj7EKt3uZ
         vFbg2HS1tNaM91w7jf5vDPXu84biOs5E49qiesxiPjpCPwqRA5fR8Yw6qpDQQYLCfbkm
         zVpUnYWkig8uM7d2V279qIPxERxVBA6ac5Ol9S7tT9AL7mP8UkC6opEvZkDgQPGRESXy
         ExdLAlZvvqf53guymmVMfBMpRPX9DmG6FIzM4FdvD0pNtchV9D+6lj5jimahdJvWjOvd
         gCJg==
X-Gm-Message-State: ANoB5pnF462MXdszxaVhuJDxlnUcBIq/5V6lw86s1RFqblB06h3fyU0r
        y4GvfTTwxORqbrmCW02Txjg=
X-Google-Smtp-Source: AA0mqf7bD2JjqDeJT9w6T1ifruXr82jjZqe/YtqbN1gwtsS1wvuwVmUrcd/EFWAV0zDdjTcP5k3yJQ==
X-Received: by 2002:a17:906:3952:b0:7b9:2a28:f6ff with SMTP id g18-20020a170906395200b007b92a28f6ffmr33118746eje.61.1669809276699;
        Wed, 30 Nov 2022 03:54:36 -0800 (PST)
Received: from [192.168.3.32] ([213.149.38.231])
        by smtp.gmail.com with ESMTPSA id e21-20020a170906315500b007bed316a6d9sm572005eje.18.2022.11.30.03.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 03:54:36 -0800 (PST)
Message-ID: <b040b2b2-10c2-5414-1c8f-fd02fc3b300e@gmail.com>
Date:   Wed, 30 Nov 2022 12:54:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2 2/4] mmc: sdhci: Avoid unnecessary re-configuration
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
References: <20221128133259.38305-1-adrian.hunter@intel.com>
 <20221128133259.38305-3-adrian.hunter@intel.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20221128133259.38305-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 28. 11. 2022. 14:32, Adrian Hunter wrote:
> Avoid re-configuring UHS and preset settings when the settings have not
> changed, irrespective of whether the clock is turning on.
>
> Tested-by: Haibo Chen <haibo.chen@nxp.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Hi, this is breaking sdhci-msm on IPQ8074 in next-20221130 for me
and reverting it makes the eMMC work again.

I get a lot of:

[    2.727287] mmc0: tuning execution failed: -5
[    2.727323] mmc0: error -5 whilst initialising MMC card
[    3.846540] mmc0: tuning execution failed: -5
[    3.846564] mmc0: error -5 whilst initialising MMC card
[    4.966517] mmc0: tuning execution failed: -5
[    4.966539] mmc0: error -5 whilst initialising MMC card
[    6.096486] mmc0: tuning execution failed: -5
[    6.096508] mmc0: error -5 whilst initialising MMC card
[    7.206431] mmc0: tuning execution failed: -5
[    7.206454] mmc0: error -5 whilst initialising MMC card

Regards,
Robert

> ---
>   drivers/mmc/host/sdhci.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 64750fbb0ac8..17e5ccf9a855 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2315,7 +2315,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   {
>   	struct sdhci_host *host = mmc_priv(mmc);
>   	bool reinit_uhs = host->reinit_uhs;
> -	bool turning_on_clk = false;
>   	u8 ctrl;
>   
>   	host->reinit_uhs = false;
> @@ -2345,8 +2344,6 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   		sdhci_enable_preset_value(host, false);
>   
>   	if (!ios->clock || ios->clock != host->clock) {
> -		turning_on_clk = ios->clock && !host->clock;
> -
>   		host->ops->set_clock(host, ios->clock);
>   		host->clock = ios->clock;
>   
> @@ -2374,11 +2371,10 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>   	host->ops->set_bus_width(host, ios->bus_width);
>   
>   	/*
> -	 * Special case to avoid multiple clock changes during voltage
> -	 * switching.
> +	 * Avoid unnecessary changes. In particular, this avoids multiple clock
> +	 * changes during voltage switching.
>   	 */
>   	if (!reinit_uhs &&
> -	    turning_on_clk &&
>   	    host->timing == ios->timing &&
>   	    host->version >= SDHCI_SPEC_300 &&
>   	    !sdhci_presetable_values_change(host, ios))
