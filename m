Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DC027933C
	for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747657948; cv=none; b=rqfZxYqZJOi5EhI5SBx6AOOJeduQXZBb2ePtpB6XtMAt+Dswog5fP+tW0kW9PPkSslwKnTZrX5NgGxgSIAfPtotxkIlpEAKf0KsTexnfgDSKAdGdAaemBTp9qeS6WEs50MfhC5Q03tGDu0kAT+qUX5JL19f8tkRzsuXlJko0PHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747657948; c=relaxed/simple;
	bh=OG5kN+zFwm6jMpsyyhiXOa0Gh5embl2VyNBsO29c1Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pd6XWq6s1ESIQd2pIXdjVq5H9YFGEZTyG3YZ/ofh8NimrprWteh5B2f3mWDAIkFG3k75TJQrCZ7RPg2D/ooQOWqzGhAWZhWOhTMqnRIW9Uy2Cd9aKxsCW8PVlqGAvFZxrqIdRqxlvpmRwjACQa+6DLe+rH74MHTKbqjzzdK9LeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qslu6fkt; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qslu6fkt"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70cb3121db1so20574707b3.3
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2025 05:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747657945; x=1748262745; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IPwRNXOWl24GFO+rgmgF+qLJpM89plODyl58iZqW/T4=;
        b=qslu6fkt8+cqeUlphmNM8i2rLTXoqVzWGUKirH0G5eEpD1FEbRfNAj+iSPiRJimanB
         G/uKFpGKW6mzKuVSuqfJXMdLYu8nceRf558kGtfwk+4xJW+IS57tAWLXQnfSOcaFhLXw
         0otFIJsD/JQGg7y0IUTawKMB47xkaJrc28Kz5yTvKJJR4iRtvbxZVyIAVhYm4V7ZVtpr
         HxwZLICBDfmFE5lQ0VrlyYEsyM90yZCpeNlf2Q95r0G5g+wnPn1w/3jELPSxbx6Kc+Y6
         6dxgHMky4UiMWJ7afBOAokg89BlLjmcdWiGU+tIsiaJDsnjWS94KZdAnE/9cktXYda9U
         VzZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747657945; x=1748262745;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IPwRNXOWl24GFO+rgmgF+qLJpM89plODyl58iZqW/T4=;
        b=F9vCMfMfQ1psICawoamEzTETyulA0kemkAR5l9YJTb2lzEQv+knn41etGzN4vp8NEc
         Q1+sxggmEbOrG2UZqAVg5hiUeO/bF/By226qB/Oq1uUDjuJuvmms8s4JhVJbjEW4YR3y
         CiZYjnDqnwIpDxMC3mv4ldcj2UenUH8WV2Ojpo7R70vcwh1RGkDDdWMgfO4F9iCdo0hQ
         db/eAYqSeANYlUm2Ow+fUEpsut0BwoYElJQEToBD6iPbI8ByYPUW7eTD/foc1Dz1jjbS
         2RpUhKn9kdmWDV3BqYszkoJWpEKuErBRDkJzD3JWIh+/W1TyNUyCuf/vlUJySwbbivFl
         rplg==
X-Forwarded-Encrypted: i=1; AJvYcCXFW420BRyu4EFZpx+JWeUnU2wfyJqP4ONxTVAUW9xMTbTodUPzY7gcTrbI4CQF+OSt1zYyvgHbqEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb0dQqLhFoCtN91F8wnjAz8M1yfFbK6oOSum/5JxUNcdQ/PU3N
	uM6O+h6NLQCO5ba7migkt56/2j3AWTGdDdMb/K2RWqJHooPbFkcblGMJ7AWV14Bg6Puoiju4Lh+
	hXGXcI4IlCd17bd/tM8cHGUgWWXKgXfFn0wjHT2o29Q==
X-Gm-Gg: ASbGncvU+bAjpxxyPoI83Vv6HZIpDQ/fB3sqOsCnGFF7xvmfzQSHHTy33y3IvNKsvl9
	14KTbC2+bTbqpFK4sa8Sg6TeSglm5AeYn9jmdMC4rRqiAenuuApx6oSOFiWFs/ycoLQxEJGS6q3
	gjymZ/d38OkjcUg11MCq31P4b/reh9FAwTeA==
X-Google-Smtp-Source: AGHT+IHEFdLHniAqxHZG4kqnpVrKvVBNypE6W6kV8LKivZdut35hNYYXEIT1Ua0XVeMkAptb/2GMnLOxiQxqeaEooXo=
X-Received: by 2002:a05:6902:1887:b0:e7b:8dd2:b136 with SMTP id
 3f1490d57ef6-e7b8dd2b339mr8889269276.32.1747657945346; Mon, 19 May 2025
 05:32:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250516203121.3736379-1-jm@ti.com>
In-Reply-To: <20250516203121.3736379-1-jm@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 19 May 2025 14:31:49 +0200
X-Gm-Features: AX0GCFu5LdKL-XO3AKJ_vFo9TR_8O6ABPngDS_Z20Tf3MyzVBm9WfnLA56qznbQ
Message-ID: <CAPDyKFrxLbkP_En_XL+AypEGygm+gMVLiAoz+AZLg_i4CrhXBw@mail.gmail.com>
Subject: Re: [PATCH v6] mmc: sdhci_am654: Add SDHCI_QUIRK2_SUPPRESS_V1P8_ENA
 quirk to am62 compatible
To: Judith Mendez <jm@ti.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Josua Mayer <josua@solid-run.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nishanth Menon <nm@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
	Hiago De Franco <hiagofranco@gmail.com>, Moteen Shah <m-shah@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 May 2025 at 22:31, Judith Mendez <jm@ti.com> wrote:
>
> Add a new struct for platform data for the ti,am62-sdhci compatible to
> apply additional quirks, namely "SDHCI_QUIRK2_SUPPRESS_V1P8_ENA", to
> host controllers with am62 compatible.
>
> Note, the fix was originally introduced by commit 941a7abd4666
> ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch") but was
> found to be applied too broadly and had to be reverted.
>
> This fixes MMC init failures seen across am62x boards.
>
> Fixes: ac5a41b472b4 ("Revert "mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch"")
> Fixes: 941a7abd4666 ("mmc: sdhci_am654: Add sdhci_am654_start_signal_voltage_switch")
> Cc: stable@vger.kernel.org
> Suggested-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Judith Mendez <jm@ti.com>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes since v5:
> - Drop sdhci_am62_4bit_pdata
> - Pick Adrians tag
> - Add note to commit message
>
> Tested on am62x SK, am64x EVM and am64x SK. Tested-bys are welcome
>
> Link to v5:
> https://lore.kernel.org/linux-mmc/20250514002513.1179186-1-jm@ti.com/
> Link to v4:
> https://lore.kernel.org/linux-mmc/20250424180036.1541568-1-jm@ti.com/
> Link to v3 RESEND:
> https://lore.kernel.org/linux-mmc/8678d284-db12-451a-b789-2b75f9932f9f@ti.com
> Link to v2:
> https://lore.kernel.org/linux-mmc/20250417182652.3521104-1-jm@ti.com/
> Link to v1:
> https://lore.kernel.org/linux-mmc/20250407222702.2199047-1-jm@ti.com/
> ---
>  drivers/mmc/host/sdhci_am654.c | 35 +++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index f75c31815ab0..73385ff4c0f3 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -155,6 +155,7 @@ struct sdhci_am654_data {
>         u32 tuning_loop;
>
>  #define SDHCI_AM654_QUIRK_FORCE_CDTEST BIT(0)
> +#define SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA BIT(1)
>  };
>
>  struct window {
> @@ -166,6 +167,7 @@ struct window {
>  struct sdhci_am654_driver_data {
>         const struct sdhci_pltfm_data *pdata;
>         u32 flags;
> +       u32 quirks;
>  #define IOMUX_PRESENT  (1 << 0)
>  #define FREQSEL_2_BIT  (1 << 1)
>  #define STRBSEL_4_BIT  (1 << 2)
> @@ -356,6 +358,29 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
>         sdhci_set_clock(host, clock);
>  }
>
> +static int sdhci_am654_start_signal_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if ((sdhci_am654->quirks & SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA) &&
> +           ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = mmc_regulator_set_vqmmc(mmc, ios);
> +                       if (ret < 0) {
> +                               pr_err("%s: Switching to 1.8V signalling voltage failed,\n",
> +                                      mmc_hostname(mmc));
> +                               return -EIO;
> +                       }
> +               }
> +               return 0;
> +       }
> +
> +       return sdhci_start_signal_voltage_switch(mmc, ios);
> +}
> +
>  static u8 sdhci_am654_write_power_on(struct sdhci_host *host, u8 val, int reg)
>  {
>         writeb(val, host->ioaddr + reg);
> @@ -650,6 +675,12 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
>         .flags = IOMUX_PRESENT,
>  };
>
> +static const struct sdhci_am654_driver_data sdhci_am62_4bit_drvdata = {
> +       .pdata = &sdhci_j721e_4bit_pdata,
> +       .flags = IOMUX_PRESENT,
> +       .quirks = SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA,
> +};
> +
>  static const struct soc_device_attribute sdhci_am654_devices[] = {
>         { .family = "AM65X",
>           .revision = "SR1.0",
> @@ -872,7 +903,7 @@ static const struct of_device_id sdhci_am654_of_match[] = {
>         },
>         {
>                 .compatible = "ti,am62-sdhci",
> -               .data = &sdhci_j721e_4bit_drvdata,
> +               .data = &sdhci_am62_4bit_drvdata,
>         },
>         { /* sentinel */ }
>  };
> @@ -906,6 +937,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>         pltfm_host = sdhci_priv(host);
>         sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>         sdhci_am654->flags = drvdata->flags;
> +       sdhci_am654->quirks = drvdata->quirks;
>
>         clk_xin = devm_clk_get(dev, "clk_xin");
>         if (IS_ERR(clk_xin)) {
> @@ -940,6 +972,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
>                 goto err_pltfm_free;
>         }
>
> +       host->mmc_host_ops.start_signal_voltage_switch = sdhci_am654_start_signal_voltage_switch;
>         host->mmc_host_ops.execute_tuning = sdhci_am654_execute_tuning;
>
>         pm_runtime_get_noresume(dev);
>
> base-commit: 8566fc3b96539e3235909d6bdda198e1282beaed
> --
> 2.49.0
>
