Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D8271479
	for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 16:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372419; cv=none; b=rIHx0/WXOzUI2xqaK8e+Z5jC5xHzs0ySCJ0on7/o2NWvMIAu3xkDPPRigMgVoizapdj1lhSzzogpqmW1luu61opAQqerUXleySKVyPPmFfiSXDKPy6THNo0KSBgNfm34HDTDtsowP0izq5xB1d+UyTxOXIUZGbUdHkIzLkZtEuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372419; c=relaxed/simple;
	bh=QZXGC+aNSm2VaxhXC6fK/8LfmGJE2quumpT2uKvw4qE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3KLjuJIGF/0exAb68ELZKnZpfzzdoz4UfY7H1HZMuUX+nVHrjqSqcPpnRxuMPhjhTQjOocNUQODRGrvwi05PSbtTCAFE/+Q/wqNob+zyGpCp7kxIR1b9wnHHzm4DsA6BTn5FHSKJIHJQ8CLThr22doP5EfD+lh587N5eLz0KyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54aa30f4093so1415213e0c.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 09:20:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760372415; x=1760977215;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFpRqZmIQrKu+7ylr5t2VWlgMZSJphDIQU23QX0pR+8=;
        b=XXR48fz2l5U5d26W/RkoObBQnkZT3KRVtwG2/d3+rsFY1RsNqIEEiuDurwFD1zZA4O
         b5dJCSds9/rct5Qpl2gUAWT+6oFhNf3xDw+7A3US0wjyrFitntWRgd6jB4uZ2jEUEG/M
         BEVdiAYuscfncBPq7zJon44IIehuZTb9ngHkJeavkHCosPtn32CGpOSomk95mElnYHL9
         Ohw01gRpkWD0rbHVx9HzSI9GY0rsexKKrIj50fCtI9qVRPWfp5GgCWinNoJ5IUlbeqtL
         ij3NR7NGOH5U5xJfs6akOatT3AkCn0z7AJmnpX6dZ1D4+zJASd80yiAu58W7SmXDXssH
         /rWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsCxzzM7ds35WypKBhJcZZLtsMmvOEyoCcKhIpbKenHpyokOu99cOB5+olCQLhw74GfkP6NFHMD/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHbRkU/S/dxcKsKJFvJHKs/RUz92GriHA7uDh26mx4ciYd3q/
	0rWShCFAFEVZ6fNZaNSOFbmoi0WWNCilHcwNSobhM/qKWyWtIj1E5pWt6TDK+D8R
X-Gm-Gg: ASbGncv7GrlFtik7xsNdqAoClpEx9vgB0e4xx7jUmbLwC09tT4zjker2eteFUwM3jPp
	2n7rWB9O1Y1brZLYulU9oqewANX30y95XJpOcnmxV3+Oskknup4pNv3M3uHFkgnrtolp8xIXcuX
	bZCiHJJWuSa648PSrXToXQXPtY5sfI3svWMWRBBf6qrBxP9JWQIdqaXSuTROcsWKM5TK8qPK3mQ
	PEQsQQZdhLvJUi+FX1L+AVodAweSAfv4zdo6hD2q0HQKs5VSXuKuFHxNH+VWKRC361BWDW2U21G
	Z3RJubmQA7RQatpzmC7fbhBAkh5DUEm9sWXf1u++fhFICOJ2NA6NhlZbIDu6O0gaSe6RPjuWlkd
	NdAhanXrBs5ZSJ4obdLNV4jdYeDevEznjkopAIwDnybbyFumDNqBOViVcOT1lhK2Lulk46KRNtO
	b6wVc=
X-Google-Smtp-Source: AGHT+IHWiFYSILF6+/cZvVJ8cSy1ftrRCzhEpDnwJkjlaf+gG0VSmYKqF5wa7n9BRoeHLW4yfMsNww==
X-Received: by 2002:a05:6102:3052:b0:523:759e:b0cf with SMTP id ada2fe7eead31-5d5e2344f40mr8604319137.21.1760372415095;
        Mon, 13 Oct 2025 09:20:15 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5d5fc8b165dsm3492341137.9.2025.10.13.09.20.14
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 09:20:14 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-8e401b11bfaso1124801241.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Oct 2025 09:20:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCJQOthur+uyr9vcnypvr4bLM66/vyZIooKsDHI9nN/fxccrHoNZdTe7exPiCEEqVHWlJVcvwbD10=@vger.kernel.org
X-Received: by 2002:a05:6102:548b:b0:5d5:f6ae:38c0 with SMTP id
 ada2fe7eead31-5d5f6ae3b65mr5428961137.41.1760372414371; Mon, 13 Oct 2025
 09:20:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com> <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Oct 2025 18:20:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com>
X-Gm-Features: AS18NWAZcmdiqSjfkUoPbuGPh-cNUsYtDKIlfc4ni5Js9vtMQnoS9mBsr70Q9Bc
Message-ID: <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 10 Oct 2025 at 22:16, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
> and require __maybe_unused protection against unused function warnings.
> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
> the compiler to see the functions, thus suppressing the warning. Thus
> drop the __maybe_unused markings.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>  }
>
>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> -                          tmio_mmc_host_runtime_resume,
> -                          NULL)
> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +       RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
> +                      tmio_mmc_host_runtime_resume,
> +                      NULL)
>  };
>
>  static struct platform_driver renesas_internal_dmac_sdhi_driver = {
>         .driver         = {
>                 .name   = "renesas_sdhi_internal_dmac",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -               .pm     = &renesas_sdhi_internal_dmac_dev_pm_ops,
> +               .pm     = pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
>                 .of_match_table = renesas_sdhi_internal_dmac_of_match,
>         },
>         .probe          = renesas_sdhi_internal_dmac_probe,
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index c8cdb1c0722e..b9de03325c58 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>  irqreturn_t tmio_mmc_irq(int irq, void *devid);
>
> -#ifdef CONFIG_PM
>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>  int tmio_mmc_host_runtime_resume(struct device *dev);
> -#endif

This change is indeed needed, because RUNTIME_PM_OPS() now
references these two functions unconditionally...

>
>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>  {
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index 775e0d9353d5..8be642f737c7 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>
> -#ifdef CONFIG_PM
>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>  {
>         if (!host->clk_enable)
> @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
> -#endif

... however, no actual code referencing them is emitted in the
CONFIG_PM=n case, as renesas_sdhi_internal_dmac_dev_pm_ops is not used
due to the use of pm_ptr().  Hence the changes to this file are needed.
(verified with m68k allmodconfig/allyesconfig builds)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
