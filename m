Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D6CC433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 19:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbhKWToG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 14:44:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbhKWToG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 14:44:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C75C061574
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:40:57 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f18so806783lfv.6
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKototm+ggjsnUIU+FMdClkd9TByERSoA+0AnaJd+Rs=;
        b=r+0oR66fWwZZGCS12XCPkrDbW1OWMDO9LBoAUcBHkn3XFkoHGEfkJMjbXYDaQXygyb
         v1ZVGxxD1QieCxmUZZhEUbQf/XCqNTHTYS/jhPz3eNDfA3hWyZRxO/ErigfrtSn36qNr
         vMFCNtOcQ6E7JpMAb1HK2qLMdB1zBjbw4OzNJaTNktcSbSp97WnnulF0WUIlZvmuGywL
         H9nH2w3yf9gP+fxjGlON7BYnX0qcSHCGXZqiw5GovTQHeKwBQxAXekiZ4oeYkDGCnxRA
         Nn1jsk/8LLepU/MdD9mBjzXPyB8ZNtvy6ZITFxXte7O+pgq8nFqAPVqkwgSD/lHjo+mb
         Jt7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKototm+ggjsnUIU+FMdClkd9TByERSoA+0AnaJd+Rs=;
        b=wvm/QtZj+MEl4RVQIhmGNZEnV/0oQfeffBLxt2x2Fqyd15Z0z8Jdo/JYlAu5z5aheT
         3I6M/o+/foVRN1ovRljMJvHMPY84XRt/gO+QDfeHh+Drlfvc8oSC1JyaokSJ2LcpOd5/
         8debk68Ub86/J1QUefuH2r2l6PvJ/Z0lNpyTBc3slpvLXsRW0UW3ss4zcVlMmxyfvqSm
         CZiUTXuAaXreAU9Mc2m2ZOqlsXKdb9DvHDfwaoMK9mByeQwhv3o/7WQQJd1lBQurze93
         5qn/H3xWjoEmm30gLDwnztaBHQVaWgNJ/rjtFWryT4uzzTzKkyr36H0PgvGbEdyMHdE4
         1Jzg==
X-Gm-Message-State: AOAM532Q94gvcz2C44Vgm7f2c//e6EVShsd1W9LvoEgs+k328mqytcPj
        pTxsYokxyZ0MuUOoCGz9DESuxlLZhY1Z/v7snp9ocrdweGU=
X-Google-Smtp-Source: ABdhPJxL4+9NfGeW1Em0Th9DeYYs3AFY6QNVvav2iJ6duv5bPeq45Y4JCbu2TGr4oOuoCwa6FCpUfQ+Ps4M4MiTSKew=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr7640142lfv.233.1637696455966;
 Tue, 23 Nov 2021 11:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20211115113813.238044-1-jonathanh@nvidia.com>
In-Reply-To: <20211115113813.238044-1-jonathanh@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 20:40:19 +0100
Message-ID: <CAPDyKFor-vf00nc+beshcq-N+L7jPWSLaN754gCCsqNHSxYKzQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: spi: Add device-tree SPI IDs
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Nov 2021 at 12:38, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> Commit 5fa6863ba692 ("spi: Check we have a spi_device_id for each DT
> compatible") added a test to check that every SPI driver has a
> spi_device_id for each DT compatiable string defined by the driver
> and warns if the spi_device_id is missing. The spi_device_id is
> missing for the MMC SPI driver and the following warning is now seen.
>
>  WARNING KERN SPI driver mmc_spi has no spi_device_id for mmc-spi-slot
>
> Fix this by adding the necessary spi_device_id.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmc_spi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
> index f4c8e1a61f53..b431cdd27353 100644
> --- a/drivers/mmc/host/mmc_spi.c
> +++ b/drivers/mmc/host/mmc_spi.c
> @@ -1514,6 +1514,12 @@ static int mmc_spi_remove(struct spi_device *spi)
>         return 0;
>  }
>
> +static const struct spi_device_id mmc_spi_dev_ids[] = {
> +       { "mmc-spi-slot"},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(spi, mmc_spi_dev_ids);
> +
>  static const struct of_device_id mmc_spi_of_match_table[] = {
>         { .compatible = "mmc-spi-slot", },
>         {},
> @@ -1525,6 +1531,7 @@ static struct spi_driver mmc_spi_driver = {
>                 .name =         "mmc_spi",
>                 .of_match_table = mmc_spi_of_match_table,
>         },
> +       .id_table =     mmc_spi_dev_ids,
>         .probe =        mmc_spi_probe,
>         .remove =       mmc_spi_remove,
>  };
> --
> 2.25.1
>
