Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFA111A8
	for <linux-mmc@vger.kernel.org>; Mon,  3 Feb 2025 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591497; cv=none; b=N+Kw0iLbznNMbg7x64d3CTsyrnKk5uaYLIOmS9T8si0CutyeC9AJle1o3okCa7Unlk34xDAwmw2U1jTE5VqjKfnt+2ja0d0zXf1fw5re5r7Jk66a/7Z2q9kykNw4VZToMHLMePjb58JZjKHAa/BWXtj1OtskAxLhkCgxxcdXcwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591497; c=relaxed/simple;
	bh=TXJnyxnZJmXNK7Qr/0ocqomhEyCISrE6NMMIXWvv41g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu8fryxWT06j36CS9oa+rfvm09ql6666QloBE7TjEMi6AZ7XprRZoklpJWJRaLLbrtANWUSuR0gvYpWOx7Z3/Q8NuLft77+MQJBE4l+zXLDKbjTcpexPsX2oDXuHe6wM4NwzCuJzaYE2HZa3yUv39nyJx5GJEEhxM79wKjXHWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeoOaB41; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeoOaB41"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f6715734d9so27076977b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 03 Feb 2025 06:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738591493; x=1739196293; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gs2EHxUDMxq+Baz9mBmpS68Jbe8XGEdWwve18lbP/Cg=;
        b=MeoOaB41jXI87K3iClqKnxDCl35saNRQm8EIREOrI5DuhqV7R8mlLJCT7e0Zw3SwGr
         pvtvpMSozUly1xTQbc00s1T5H2jdsbN+1Mp987lXzP7GcZkpPhGD+3whfKVYoZ+ggYGC
         ExSkCiJlgjXZQ9bxlahHUQPJz2rTC5ailUKm0EzpgGo7KC1juUqpHhJoWnEjMsmkcnUy
         Zp5xQhI6NPC4HmYZpeUMEgGiGDlNZs/60OTNh6Z1lNPusAGsithEApYGS5LQAa8ks7sY
         zTg1P5eanAICR/riykehy9T/f8vK91IjvZFLNWGwX0f48OUCpSU5PmzKGfIuVtW7e8uo
         8iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738591493; x=1739196293;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gs2EHxUDMxq+Baz9mBmpS68Jbe8XGEdWwve18lbP/Cg=;
        b=H1OyhV3zc91EE9pX5TusHXUV0JlgsDjiZ4AGfN6u3L5R5NFbe7OHSJG3UYfcBJoEPO
         6bRXdlOBNTFURVzKX0gegJ9LeixA6VbeFGCJyh6uZTKoUwkeO4koSp5lwQws90VdqDMW
         wCB5XVOHqtj/6koorlYoasY9+VRGa/LytQiy5aEB87X7BxhK+lG0H5E224dFP0/FYvdF
         BdK7egnaZugT7qSkE2//BezQILYYcobMleJiWJqc82CLIGNmOP1cPeb2hXMob01XJccT
         AG+WCyCk6Emqiufimvhh0YiCVwgxAs+Zv1GJ9vMaoFlm2Oii5uz0yrZUf30GfonMeIS3
         UGqw==
X-Forwarded-Encrypted: i=1; AJvYcCWMoIC4IBjrTQ2Fcv7KtE1/dJrVOrIab+JCFN1AyOWj5QxxRFjv0/JTTopjJZqIZcobn4574EukQLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcOC23o/LPPtYk2HnzBD5uCBJW1MvOcF1w+XlQ7y8kLSO2AadE
	JicvV0T+XWlu6Kl/dJ8MfXj1firaYmRwK8HWFToTz5C1mLxLUhWeQtLIv7WPuXxb9oUg+OppKPh
	Dqb/4RF0VHuastx5LqG5YBDM3aLp8fUKixbbW+A==
X-Gm-Gg: ASbGncto4Neomwp914bDEdR98KkpIdzMv79/Yn99onSe0aYsL8XJYyrTtXi1pxgr4uF
	GXcUwalyZ35BYtXnW1nNDh94dWaicgRdy1fG1RkJAri0mBoveErHsVu/xCHk74JhrjGeUvrLDLQ
	==
X-Google-Smtp-Source: AGHT+IGtg5NkrdgYScCRmI/OmJ7Dav6l6O2tNODPfC6EZHSpdKj02qXroe7xo38HtwQW79jYwAn/G9iInvsvRkTxKKI=
X-Received: by 2002:a05:690c:25c8:b0:6ef:7c8e:f00e with SMTP id
 00721157ae682-6f7a8424724mr174604677b3.35.1738591493192; Mon, 03 Feb 2025
 06:04:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
In-Reply-To: <20250127-am654-mmc-regression-v2-1-9bb39fb12810@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 3 Feb 2025 15:04:16 +0100
X-Gm-Features: AWEUYZk6xEPi1SMesWD-n8GvcXLzo5PaGCWwFhzEnEsJ_1yCwEJdTyoJEQJDy2c
Message-ID: <CAPDyKFqdKj5EVPGCSUw1YN-E2q9=dQtNGMPVOxBHGK7svGoQig@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"
To: Josua Mayer <josua@solid-run.com>, Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rabeeh@solid-run.com, jon@solid-run.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 21:12, Josua Mayer <josua@solid-run.com> wrote:
>
> This reverts commit 941a7abd4666912b84ab209396fdb54b0dae685d.
>
> This commit uses presence of device-tree properties vmmc-supply and
> vqmmc-supply for deciding whether to enable a quirk affecting timing of
> clock and data.
> The intention was to address issues observed with eMMC and SD on AM62
> platforms.
>
> This new quirk is however also enabled for AM64 breaking microSD access
> on the SolidRun HimmingBoard-T which is supported in-tree since v6.11,
> causing a regression. During boot microSD initialization now fails with
> the error below:
>
> [    2.008520] mmc1: SDHCI controller on fa00000.mmc [fa00000.mmc] using ADMA 64-bit
> [    2.115348] mmc1: error -110 whilst initialising SD card
>
> The heuristics for enabling the quirk are clearly not correct as they
> break at least one but potentially many existing boards.
>
> Revert the change and restore original behaviour until a more
> appropriate method of selecting the quirk is derived.
>
> Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
> Closes: https://lore.kernel.org/linux-mmc/a70fc9fc-186f-4165-a652-3de50733763a@solid-run.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied this for fixes, thanks!

Kind regards
Uffe



> ---
> Changes in v2:
> - Fixed "Fixes:" tag invalid commit description copied from history
>   (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
>   (Reported-by: Greg KH <gregkh@linuxfoundation.org>)
> - Link to v1: https://lore.kernel.org/r/20250127-am654-mmc-regression-v1-1-d831f9a13ae9@solid-run.com
> ---
>  drivers/mmc/host/sdhci_am654.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index b73f673db92bbc042392995e715815e15ace6005..f75c31815ab00d17b5757063521f56ba5643babe 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,7 +155,6 @@ struct sdhci_am654_data {
>         u32 tuning_loop;
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> -#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>
>  struct window {
> @@ -357,29 +356,6 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         sdhci_set_clock(host, clock);
>  }
>
> -static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> -{
> -       struct sdhci_host *host = mmc_priv(mmc);
> -       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> -       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> -       int ret;
> -
> -       if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> -           ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               if (!IS_ERR(mmc->supply.vqmmc)) {
> -                       ret = mmc_regulator_set_vqmmc(mmc, ios);
> -                       if (ret < 0) {
> -                               pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> -                                      mmc_hostname(mmc));
> -                               return -EIO;
> -                       }
> -               }
> -               return 0;
> -       }
> -
> -       return sdhci_start_signal_voltage_switch(mmc, ios);
> -}
> -
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>         writeb(val, host->ioaddr + reg);
> @@ -868,11 +844,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
>         if (device_property_read_bool(dev, "ti,fails-without-test-cd"))
>                 sdhci_am654->quirks |= SDHCI_AM654_QUIRK_FORCE_CDTEST;
>
> -       /* Suppress v1p8 ena for eMMC and SD with vqmmc supply */
> -       if (!!of_parse_phandle(dev->of_node, "vmmc-supply", 0) ==
> -           !!of_parse_phandle(dev->of_node, "vqmmc-supply", 0))
> -               sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> -
>         sdhci_get_of_property(pdev);
>
>         return 0;
> @@ -969,7 +940,6 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> -       host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
>         pm_runtime_get_noresume(dev);
>
> ---
> base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
> change-id: 20250127-am654-mmc-regression-ed289f8967c2
>
> Best regards,
> --
> Josua Mayer <josua@solid-run.com>
>
