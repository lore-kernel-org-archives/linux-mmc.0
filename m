Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87CFC10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04B420663
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FFA0e+6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCLNIt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:08:49 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35566 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLNIs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 09:08:48 -0400
Received: by mail-ua1-f68.google.com with SMTP id y6so2077928ual.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 06:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=615uTM0DnrncREOe2KMCqisaLBgj11Sr3HONWNz+aSc=;
        b=FFA0e+6cg+LOma5AcX0rPtuPzExG8R49KllYxY8XJbVvagwzpy9nhwUHm5t9SIwSDy
         bIzg+HNhDxnf6ntIDVKSACZilQ8647xb610y0PnN0o/9fG6oi2a0T0X/eRAW46ViGKz6
         N/+r6mj2bo5SqTs4xFusTNw0mlF3J3Vgeyu6l6W8ylRpdonjlvQqi71TxR47PvvnY7BH
         RGjFyIOKFeOYJR5bUqiJb+rgBnLLJlgXQb9Pszr1VbbXmNQyyRPd3n+Rj39QzqJKzidI
         /cTQ90+22AWOQng+9JbvAkZJMaFdP139HdHJQTXrcUAfNkdFGXmDBXHVGsFVMlGaZ9o/
         49zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=615uTM0DnrncREOe2KMCqisaLBgj11Sr3HONWNz+aSc=;
        b=sV/BNUGVs8djFkUU/bxxh4lEn4jNh7JmvTFyWt+huw0EDQnrwTdngfG/+4UvQxgp5r
         WAAIWaEsiIJvo0YmaciRqwtsmHmfPhAX5YBKEPX13NWcFtPBB82U0kv4+lK/Plwa6uIF
         b+OSEL4TcsKCMVMfVRQG9HG4x22p+pcJ130Y+FAxEmYLo46HYupfD6qDWdCs0LGnNHWd
         XtFfs9wdXId5bczP5Af5gu2+fdhV3zq3+qpG39dtP7FzyNttTvPHWMcN3kyCqSxNgFsT
         Trnj2UU4oJD2NkwavAh1Wai0Qxx0Y8bQ63RCy/1LxZ/OYthdsI6in5vkRH/TVXmUZZxs
         ZwZA==
X-Gm-Message-State: ANhLgQ11ipM8wb+o+fN3XmgJDlfpvcrRv/z1q4bzMZpJK6RglANbQG/W
        FCV3XW26lv0rVD4sn0nCKIXbdPadX9/ztRXATChs0g==
X-Google-Smtp-Source: ADFU+vtDr7w0rDYA7tLfhsh1VLaqV9dOvWkxWZQ1ep/cF52NPLjEf9RtpUKr5RXbY+RVuYJD1jc0bFBtl6R7KN9s2/o=
X-Received: by 2002:a9f:3046:: with SMTP id i6mr4835277uab.15.1584018527825;
 Thu, 12 Mar 2020 06:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
In-Reply-To: <1583886030-11339-1-git-send-email-skomatineni@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 14:08:11 +0100
Message-ID: <CAPDyKFpAgk0uboGXdmA_m1-2=GK2oRXVv+97ZFFFAtT-ZZo4fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] sdhci: tegra: Implement Tegra specific set_timeout callback
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bradley Bolen <bradleybolen@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Aniruddha Tvs Rao <anrao@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

-trimmed cc list

On Thu, 12 Mar 2020 at 00:51, Sowjanya Komatineni
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

Applied for next, thanks!

We should probably tag this for stable as well, don't you think?

Kind regards
Uffe



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
> +}
> +
>  static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>         .write_l    = tegra_cqhci_writel,
>         .enable = sdhci_tegra_cqe_enable,
> @@ -1366,6 +1395,7 @@ static const struct sdhci_ops tegra210_sdhci_ops = {
>         .set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
>         .voltage_switch = tegra_sdhci_voltage_switch,
>         .get_max_clock = tegra_sdhci_get_max_clock,
> +       .set_timeout = tegra_sdhci_set_timeout,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
> @@ -1403,6 +1433,7 @@ static const struct sdhci_ops tegra186_sdhci_ops = {
>         .voltage_switch = tegra_sdhci_voltage_switch,
>         .get_max_clock = tegra_sdhci_get_max_clock,
>         .irq = sdhci_tegra_cqhci_irq,
> +       .set_timeout = tegra_sdhci_set_timeout,
>  };
>
>  static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
> --
> 2.7.4
>
