Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vdH9/viM"
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F810D4
	for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:02 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5cce3010367so10403987b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759942; x=1701364742; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRIUp/X6KH94V1dmHPajzonMFWyN0k2R15HuLH0rxE0=;
        b=vdH9/viMXZopA/i6o/AofO0nYc9zKPydxWYyd2rwmq8ZUjciWsFEoI0d7WgJGNh46I
         wLAiPyk0FSSoaorM7/J9G6ht4IGxBcj1y8mTYDbHgD6teYPf0OgWNBiCDLjg99ejs7u0
         IJU8+r22tPLpnFHpHRxbshaf5P0rKkNJAAR9jE+04zmL2WriT+YCbIOdf5WQoGMBTTq9
         ndsUQ1iNfvXHl8kB4ldnXFt3OLSRK7kDVECh4KhrdRft2qeP1xSLHmuaicjqauQCuNwW
         dIJ2QBwkGe+FVUcFyYW30m6F8FQxHdFGQzgikWDWHRqobJFIr9FGhBAZcyubXFszw4IG
         OAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759942; x=1701364742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRIUp/X6KH94V1dmHPajzonMFWyN0k2R15HuLH0rxE0=;
        b=qHcdlwuKDV2cq/52Hry6t69q1OrsMdj0BwZmTORc/x4IzUkq+QZhDDvNsYFpvbelQk
         ix3LXNBMPpLT4c2wng/v7JgXlgtfC6kL1nggivCh+Imfnr5FbKEp6uSoqvn66wa5qo9A
         X3cFdQHYSeiLcwNGOvW+YnSVKmvQkqqIszwZLzMwMvI5k1WJBNA8A4nHM2O97lRj0dVZ
         qHkDiz1tY5Xn5iTOOCWROXlwS6lxKVdFhGjzKEljC0ABeHGnxiLF1KlYvZNgZ2Vv9PD5
         HXvcYn8s8kvNZbQmJ3P4JA3HbwxWFkBQJW5cCyR813L8DLbGKw87nSLE4+fS+tgmgj/F
         I+hw==
X-Gm-Message-State: AOJu0YyARgLyoJ/4/Et3OlM1q6lPZHyVihPMFS93kBQVkq4eg5uZ5yfn
	9UQPnRtkdftY2ejHQMB3s7GIo3amYgPvck/g5VOOYA==
X-Google-Smtp-Source: AGHT+IFXzKMZeuvW1BPKO8joBFVKPsKfpM2I/+f/wsTRT3THsVsSAwM69EGwF7PtesQFhk7BaXI4Y8hMBA/Tv2oP78c=
X-Received: by 2002:a25:3746:0:b0:da3:76d7:ddbf with SMTP id
 e67-20020a253746000000b00da376d7ddbfmr6099448yba.33.1700759941864; Thu, 23
 Nov 2023 09:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115083406.7368-1-wenchao.chen@unisoc.com>
In-Reply-To: <20231115083406.7368-1-wenchao.chen@unisoc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 18:18:26 +0100
Message-ID: <CAPDyKFqJmPEps7tSxuOnerFLohzaTFXjmDo+Mb8nGVODhNE0+A@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sprd: Fix vqmmc not shutting down after the card
 was pulled
To: Wenchao Chen <wenchao.chen@unisoc.com>
Cc: zhang.lyra@gmail.com, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	wenchao.chen666@gmail.com, zhenxiong.lai@unisoc.com, yuelin.tang@unisoc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Nov 2023 at 09:34, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>
> With cat regulator_summary, we found that vqmmc was not shutting
> down after the card was pulled.
>
> cat /sys/kernel/debug/regulator/regulator_summary
> 1.before fix
> 1)Insert SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2.after fix
> 1)Insert SD cardt
>  vddsdio                1    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  1                         0mA  3500mV  3600mV
>
> 2)Pull out the SD card
>  vddsdio                0    1  0 unknown  3500mV 0mA  1200mV  3750mV
>     71100000.mmc-vqmmc  0                         0mA  3500mV  3600mV
>
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


>
> Change in v2:
> - Remove useless sdhci_sprd_signal_voltage_switch and power_mode.
> - Use mmc_regulator_get_supply in probe to prevent sdhci_setup_host
>   from powering up vqmmc.
> ---
>  drivers/mmc/host/sdhci-sprd.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 6b84ba27e6ab..6b8a57e2d20f 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -416,12 +416,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>         mmc_request_done(host->mmc, mrq);
>  }
>
> +static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
> +                                unsigned short vdd)
> +{
> +       struct mmc_host *mmc = host->mmc;
> +
> +       switch (mode) {
> +       case MMC_POWER_OFF:
> +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
> +
> +               mmc_regulator_disable_vqmmc(mmc);
> +               break;
> +       case MMC_POWER_ON:
> +               mmc_regulator_enable_vqmmc(mmc);
> +               break;
> +       case MMC_POWER_UP:
> +               mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
> +               break;
> +       }
> +}
> +
>  static struct sdhci_ops sdhci_sprd_ops = {
>         .read_l = sdhci_sprd_readl,
>         .write_l = sdhci_sprd_writel,
>         .write_w = sdhci_sprd_writew,
>         .write_b = sdhci_sprd_writeb,
>         .set_clock = sdhci_sprd_set_clock,
> +       .set_power = sdhci_sprd_set_power,
>         .get_max_clock = sdhci_sprd_get_max_clock,
>         .get_min_clock = sdhci_sprd_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
> @@ -823,6 +844,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
>                          SDHCI_SUPPORT_DDR50);
>
> +       ret = mmc_regulator_get_supply(host->mmc);
> +       if (ret)
> +               goto pm_runtime_disable;
> +
>         ret = sdhci_setup_host(host);
>         if (ret)
>                 goto pm_runtime_disable;
> --
> 2.17.1
>
