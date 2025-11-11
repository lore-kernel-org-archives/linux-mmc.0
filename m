Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84103A1D1D
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882601; cv=none; b=lnR77MnIyXVlmU4/ucynkPBuT0BQJv8le6b9MIfNcTWEpmKhkW17UgS1s9OIMoX0i3Y84nVVuG6P6rXTmE1LKoE3ePVOEFkql1qQrW/jzz1UTTQGMPzGV/HA7j3MmByYj0Xl2Fx5JYovtk46Io+APTSOwn5+bccw1DbwDrPi8eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882601; c=relaxed/simple;
	bh=7w69gEIQRD9DpRmZ1hipFG+Vuhi9EbgUYt2kjgHRRw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmRXzNGpMTnyRu8KxSDMyzJMpfvGKvrxHwQYzuHZO83NRDAlTpTxe0LL+UgFrPXve6fxRYOZi7yMzLnAv4PZeF2vvESGo80vyLOzp7gDuLmGtPUVY2oNtyPOBnhYxgs69bcr67F9tEiRH4/kTMMnJ0mT5dVeEOoH/HXZ2IY4EKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xyb4JMDS; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xyb4JMDS"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-786d1658793so40062197b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882599; x=1763487399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cq330mV0aM3KkFwnynOWcCz+kzqPG1AsqJROu3kzYnM=;
        b=Xyb4JMDSw86oZ4aVt3m/idh2YZSRpGxH+rtr7N8XjtXuwLDqYqN4dm40ozqoMbZu1X
         2N8twZpE6P4gk60znAiFZx72khJJlCUzNgg/NpKAVFMzYU6ecqqGbaTQFIlsytArHuJp
         tfIaw7OTIvazMEficm14ZH5TK8rW90/2Jo6b+tQ6dP+ftuXZl50z0xdDDVrxyvS805GG
         EO++SYC2yyag4HEZ96zhfz3Oi/i8Ho/cex5sPv7msOmi38IzvexB4HV0c0aC3exqPJoi
         b6hqrBpFZtfN6uJvJwP9MpqZe0aZhgBadYH8r4u2tWrUDPDynjCMLQ40NnJwgu/OsUwz
         gZcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882599; x=1763487399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cq330mV0aM3KkFwnynOWcCz+kzqPG1AsqJROu3kzYnM=;
        b=aUJ0Muhw+LNyXoTL3txgN8Fz8YPVLjcOySj9/1YWk/WeFDgBKwxa/qGMW7QUySQoGU
         74gZ+oei4msr3q0xNcxkpY3sKu7mNnHnEx+3MUnZLee8xlkDGoNJGMFRO+zkQHQjaH5/
         uvqeYeac9umF8lgL+jMFvNce3Uh5T/67x2TmlTRb80AruAg1AwuoXI4q7YhtCvb0DYoh
         nUQSRwRTjwII/neC2lU+LziHlA7CYsdDiDptWmvgMnlRecF+aa3tUbewQhaMt+bqq3Xh
         CtVT1GR+eIALuVwSWnSnzY/PBTx+s72S2NdlzLDir/z0gJVcV4Y8qXXx9AR4chkO1CHf
         Ynjg==
X-Forwarded-Encrypted: i=1; AJvYcCUhTEIBdfa7eNn25stWVdtsS9jDPnT2X2iTxHhg8rwJxvkPN5I4MgvKd2acLVMIBQNhxhH1213wnjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJkHPwUhliFf1LeA7S1XZzn9skywd6iiy58/TtTu0h6WDdgfc5
	nM0qxOrOkV/vgFWhdpw15XrbbhpAQAy6PdxJj+DOQMb8BpJqW9PIeY1wnFEqhySd8hZfPYZh8Ha
	64YM7f8MyLzQvGEN3ajrxBdLYIVfEz8YJA/DX/rpWDg==
X-Gm-Gg: ASbGncu4kpxki971fH7jVMgw74PkuvghRbZW4un/XGLXMcXfDtvKEzsMl9zgDBqGGLG
	RNPfRkFRvPr/RvRbTNzYqS7dfMm+cuHDVJjkmKFhX6+PcnpgIbFOjIdkAau4Oqqy6glrtpIYsb6
	8SOqN4DdNXUl4lWOGJwUeb2ljVFE3JAoF8kqpC+MlViTtSu86eS2mKX7DkCBarmZ6jBbcmf34ap
	M2ttHz6DTqZBZM6kFYa0P9nHbxRbWRQkOBo5bDidgda2a+qWHoAnxm5dpDIDA==
X-Google-Smtp-Source: AGHT+IGFeWkmGYHnfsYLyug0SUXVIrlIHteZgTm7nrPaPsLkRxroQIQ00QVPMrq7+dreV7IBhR+16iaHx55xCI61maQ=
X-Received: by 2002:a05:690c:312:b0:784:99f7:8d04 with SMTP id
 00721157ae682-787d541bf0dmr200759467b3.40.1762882598635; Tue, 11 Nov 2025
 09:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023145432.164696-1-rakuram.e96@gmail.com>
In-Reply-To: <20251023145432.164696-1-rakuram.e96@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:02 +0100
X-Gm-Features: AWmQ_bm-HtvwPjB1I0R7_VasVYGA_DNOzwFIcqKcTupiDBJdq-x3xg3-mjSwxF8
Message-ID: <CAPDyKFoSX7QZGv78dL10C38wY0Sg5QC1qxvhyGXJ+VUYHihP3A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: u.kleine-koenig@baylibre.com, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	zhoubinbin@loongson.cn, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, lkp@intel.com, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Oct 2025 at 16:54, Rakuram Eswaran <rakuram.e96@gmail.com> wrote=
:
>
> This patch refactors pxamci_probe() to use devm-managed resource
> allocation (e.g. devm_dma_request_chan) and dev_err_probe() for
> improved readability and automatic cleanup on probe failure.
>
> It also removes redundant NULL assignments and manual resource release
> logic from pxamci_probe(), and eliminates the corresponding release
> calls from pxamci_remove().
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202510041841.pRlunIfl-lkp@intel.com/
> Fixes: 58c40f3faf742c ("mmc: pxamci: Use devm_mmc_alloc_host() helper")
> Suggested-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Changes since v2:
> - Dropped redundant dma_release_channel() calls from pxamci_remove() as
>   devm_dma_request_chan() automatically handles resource cleanup.
> - Added link to v2 for reference:
>   https://lore.kernel.org/linux-mmc/20251014184657.111144-1-rakuram.e96@g=
mail.com/
>
> Changes since v1:
> Following Uwe Kleine-K=C3=B6nig=E2=80=99s suggestion:
> - Replaced dma_request_chan() with devm_dma_request_chan() to make DMA
>   channel allocation devm-managed and avoid manual release paths.
> - Adopted dev_err_probe() for improved error reporting and consistent
>   probe failure handling.
> - Removed redundant NULL assignments and obsolete goto-based cleanup logi=
c.
> - Updated commit message to better describe the intent of the change.
> - Added link to v1 for reference:
>   https://lore.kernel.org/linux-mmc/20251007161948.12442-1-rakuram.e96@gm=
ail.com/
>
> Testing note:
> I do not have access to appropriate hardware for runtime testing.
> Any help verifying on actual hardware would be appreciated.
>
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: s390-randconfig-r071-20251004) using
> `s390x-linux-gnu-gcc (Ubuntu 14.2.0-19ubuntu2) 14.2.0`.
>
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
>
> Command used for verification:
>   ARCH=3Ds390 CROSS_COMPILE=3Ds390x-linux-gnu- \
>   ~/project/smatch/smatch_scripts/kchecker ./drivers/mmc/host/pxamci.c
>
>  drivers/mmc/host/pxamci.c | 56 +++++++++++++--------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 26d03352af63..b5ea058ed467 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -652,10 +652,9 @@ static int pxamci_probe(struct platform_device *pdev=
)
>         host->clkrt =3D CLKRT_OFF;
>
>         host->clk =3D devm_clk_get(dev, NULL);
> -       if (IS_ERR(host->clk)) {
> -               host->clk =3D NULL;
> -               return PTR_ERR(host->clk);
> -       }
> +       if (IS_ERR(host->clk))
> +               return dev_err_probe(dev, PTR_ERR(host->clk),
> +                                       "Failed to acquire clock\n");
>
>         host->clkrate =3D clk_get_rate(host->clk);
>
> @@ -703,46 +702,37 @@ static int pxamci_probe(struct platform_device *pde=
v)
>
>         platform_set_drvdata(pdev, mmc);
>
> -       host->dma_chan_rx =3D dma_request_chan(dev, "rx");
> -       if (IS_ERR(host->dma_chan_rx)) {
> -               host->dma_chan_rx =3D NULL;
> +       host->dma_chan_rx =3D devm_dma_request_chan(dev, "rx");
> +       if (IS_ERR(host->dma_chan_rx))
>                 return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
>                                      "unable to request rx dma channel\n"=
);
> -       }
>
> -       host->dma_chan_tx =3D dma_request_chan(dev, "tx");
> -       if (IS_ERR(host->dma_chan_tx)) {
> -               dev_err(dev, "unable to request tx dma channel\n");
> -               ret =3D PTR_ERR(host->dma_chan_tx);
> -               host->dma_chan_tx =3D NULL;
> -               goto out;
> -       }
> +
> +       host->dma_chan_tx =3D devm_dma_request_chan(dev, "tx");
> +       if (IS_ERR(host->dma_chan_tx))
> +               return dev_err_probe(dev, PTR_ERR(host->dma_chan_tx),
> +                                       "unable to request tx dma channel=
\n");
>
>         if (host->pdata) {
>                 host->detect_delay_ms =3D host->pdata->detect_delay_ms;
>
>                 host->power =3D devm_gpiod_get_optional(dev, "power", GPI=
OD_OUT_LOW);
> -               if (IS_ERR(host->power)) {
> -                       ret =3D PTR_ERR(host->power);
> -                       dev_err(dev, "Failed requesting gpio_power\n");
> -                       goto out;
> -               }
> +               if (IS_ERR(host->power))
> +                       return dev_err_probe(dev, PTR_ERR(host->power),
> +                                               "Failed requesting gpio_p=
ower\n");
>
>                 /* FIXME: should we pass detection delay to debounce? */
>                 ret =3D mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
> -               if (ret && ret !=3D -ENOENT) {
> -                       dev_err(dev, "Failed requesting gpio_cd\n");
> -                       goto out;
> -               }
> +               if (ret && ret !=3D -ENOENT)
> +                       return dev_err_probe(dev, ret, "Failed requesting=
 gpio_cd\n");
>
>                 if (!host->pdata->gpio_card_ro_invert)
>                         mmc->caps2 |=3D MMC_CAP2_RO_ACTIVE_HIGH;
>
>                 ret =3D mmc_gpiod_request_ro(mmc, "wp", 0, 0);
> -               if (ret && ret !=3D -ENOENT) {
> -                       dev_err(dev, "Failed requesting gpio_ro\n");
> -                       goto out;
> -               }
> +               if (ret && ret !=3D -ENOENT)
> +                       return dev_err_probe(dev, ret, "Failed requesting=
 gpio_ro\n");
> +
>                 if (!ret)
>                         host->use_ro_gpio =3D true;
>
> @@ -759,16 +749,8 @@ static int pxamci_probe(struct platform_device *pdev=
)
>         if (ret) {
>                 if (host->pdata && host->pdata->exit)
>                         host->pdata->exit(dev, mmc);
> -               goto out;
>         }
>
> -       return 0;
> -
> -out:
> -       if (host->dma_chan_rx)
> -               dma_release_channel(host->dma_chan_rx);
> -       if (host->dma_chan_tx)
> -               dma_release_channel(host->dma_chan_tx);
>         return ret;
>  }
>
> @@ -791,8 +773,6 @@ static void pxamci_remove(struct platform_device *pde=
v)
>
>                 dmaengine_terminate_all(host->dma_chan_rx);
>                 dmaengine_terminate_all(host->dma_chan_tx);
> -               dma_release_channel(host->dma_chan_rx);
> -               dma_release_channel(host->dma_chan_tx);
>         }
>  }
>
> --
> 2.48.1
>
