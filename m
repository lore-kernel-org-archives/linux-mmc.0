Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5446DC2BB85
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 17:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BA3208E0
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 17:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lT/jtIdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411544AbgDOR5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441103AbgDORz7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 13:55:59 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C88C061A10
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 10:55:58 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q19so4664379ljp.9
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnna/6OnfA+ZY6dFpwQADy6VF1hPNJpTLuPWcjrS+9o=;
        b=lT/jtIdHqRmRii6Mhp0kxfUeDNI5rGqofv9QErcLovXn4eP3jZocb3Bpl2WPwsG8BE
         KS3mM5EpSs+Uu+Tf56iJssZM4HvTeyjXO2moUDIzsOf3sraCA477lBpkK08LxtZKFHuR
         M6ScyxD+ddeekgfX79R9iCS71aGqv658euPY0EYzrWu4mk1S98xVzeYIyffvlQ1RCd39
         NEcluG9VClepTW+ECpxn/bGQQUo0oE2EWe9hncZ2MkRMOR/fVeT+5thwm9CPeJ+mIV2w
         XfcJFIzjYpuM0ZVVd+xatRdOe8sG3Vj/ANuev2T5NAzhy0SJwiNCNHeEHiRKGctan+R+
         DFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnna/6OnfA+ZY6dFpwQADy6VF1hPNJpTLuPWcjrS+9o=;
        b=kE1glRQFey/bEi6TLl2gjHgpCvZDxTPld+vNAESlaialpK2f2fwGoyrwe5UEBz9YF/
         pSgFAWvctFLRI2+hs7au7K3fzjpcNSCaCmv3h+8+d687m1mGvubgQYZM1iQjRWclZ8qz
         icFC+DKYouxWDupJJg8n1859kFWkDboMx+7XN9komyQbk0I7BxqYfsHMFMYE83RwAMV2
         rwzvXLqyOChLOPHdTJKcsc9HnzsxgLIIHYJxr4OtvhTNEbVAG0mLXod91FY7qKsneQtd
         o7Jq9ZUt2Cd4N9RPOp5q9wcQ10k3dNBe1VdFJ/tKnF55L5ARgt5AFa80sIrT6PBVvAyj
         Esuw==
X-Gm-Message-State: AGi0PuYKXFRSBhM72R8zo3wLgxyqHvvTXadEktzirJZY/YNAhzrspFeo
        ro188tpaFaphG2dIKNTDZR4xYrivdJVxeVAOx6ilIA==
X-Google-Smtp-Source: APiQypIAX9TwClluLsNWlpVGtTbHrq5zHPu1eJSAJi8mSv7889eeJU3EbUg3C4LKaPOzQf5ye9c0nsPcuwjNkmygnO4=
X-Received: by 2002:a2e:6c05:: with SMTP id h5mr3968173ljc.217.1586973356820;
 Wed, 15 Apr 2020 10:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 15 Apr 2020 23:25:45 +0530
Message-ID: <CA+G9fYvreAv5HmZg0O4VvLvf_PYSvzD1rp08XONNQGExctgQ0Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sdhci: tegra: Implement Tegra specific set_timeout callback
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, baolin.wang@linaro.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, bradleybolen@gmail.com,
        thierry.reding@gmail.com, Jon Hunter <jonathanh@nvidia.com>,
        anrao@nvidia.com, linux-tegra <linux-tegra@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org, lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 13 Mar 2020 at 06:41, Sowjanya Komatineni
<skomatineni@nvidia.com> wrote:
>
> Tegra host supports HW busy detection and timeouts based on the
> count programmed in SDHCI_TIMEOUT_CONTROL register and max busy
> timeout it supports is 11s in finite busy wait mode.
>
> Some operations like SLEEP_AWAKE, ERASE and flush cache through
> SWITCH commands take longer than 11s and Tegra host supports
> infinite HW busy wait mode where HW waits forever till the card
> is busy without HW timeout.
>
> This patch implements Tegra specific set_timeout sdhci_ops to allow
> switching between finite and infinite HW busy detection wait modes
> based on the device command expected operation time.
>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index a25c3a4..fa8f6a4 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -45,6 +45,7 @@
>  #define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT       8
>
>  #define SDHCI_TEGRA_VENDOR_MISC_CTRL                   0x120
> +#define SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT            BIT(0)
>  #define SDHCI_MISC_CTRL_ENABLE_SDR104                  0x8

>  #define SDHCI_MISC_CTRL_ENABLE_SDR50                   0x10
>  #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300          0x20
> @@ -1227,6 +1228,34 @@ static u32 sdhci_tegra_cqhci_irq(struct sdhci_host *host, u32 intmask)
>         return 0;
>  }
>
> +static void tegra_sdhci_set_timeout(struct sdhci_host *host,
> +                                   struct mmc_command *cmd)
> +{
> +       u32 val;
> +
> +       /*
> +        * HW busy detection timeout is based on programmed data timeout
> +        * counter and maximum supported timeout is 11s which may not be
> +        * enough for long operations like cache flush, sleep awake, erase.
> +        *
> +        * ERASE_TIMEOUT_LIMIT bit of VENDOR_MISC_CTRL register allows
> +        * host controller to wait for busy state until the card is busy
> +        * without HW timeout.
> +        *
> +        * So, use infinite busy wait mode for operations that may take
> +        * more than maximum HW busy timeout of 11s otherwise use finite
> +        * busy wait mode.
> +        */
> +       val = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> +       if (cmd && cmd->busy_timeout >= 11 * HZ)
> +               val |= SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> +       else
> +               val &= ~SDHCI_MISC_CTRL_ERASE_TIMEOUT_LIMIT;
> +       sdhci_writel(host, val, SDHCI_TEGRA_VENDOR_MISC_CTRL);
> +
> +       __sdhci_set_timeout(host, cmd);

kernel build on arm and arm64 architecture failed on stable-rc 4.19
(arm), 5.4 (arm64) and 5.5 (arm64)

drivers/mmc/host/sdhci-tegra.c: In function 'tegra_sdhci_set_timeout':
drivers/mmc/host/sdhci-tegra.c:1256:2: error: implicit declaration of
function '__sdhci_set_timeout'; did you mean
'tegra_sdhci_set_timeout'? [-Werror=implicit-function-declaration]
  __sdhci_set_timeout(host, cmd);
  ^~~~~~~~~~~~~~~~~~~
  tegra_sdhci_set_timeout

Full build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.5/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/83/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-5.4/DISTRO=lkft,MACHINE=juno,label=docker-lkft/158/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/511/consoleText

- Naresh
