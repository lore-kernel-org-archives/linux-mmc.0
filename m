Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5933859C
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 14:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809086; cv=none; b=DN1pZi3UpbdnBgrpeHnFtHRaDjHYqftMcV5IWSgmD5yIK7Qz3SNfzqB6iBtnBTg3X/5HOz/AM9EueL1eObseJYqMlRujPyVbeS+7u9Nf9iPlfMUC26LL2Kw0zVYai+IbHvNAQvCu7K1xz7DrntATDI55xoA9kmedtB11DokJ4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809086; c=relaxed/simple;
	bh=O6LO35ibJiMDG4LpY2AuIk9Trag9Z16zf+SmdvNtyGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZZ41jON/5GIDQwnQvgSdLn8utOQqzwHPJifBT8Mj1S82euE9uzicmuaLVHm1hQn93GU0NJ0Bs7dS6A33vvhazcnJE24a9/swh9tjP9dm9+W0Z0t7x8nIdWua/aOBagpP0lYtFlhz5S3dIj5fnRSA6MDdgoBmVmM/RAnFE6DvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kHS8ERDU; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kHS8ERDU"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a3340391cso25854621fa.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 06:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765809082; x=1766413882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kQIaLIQgPpvPjwvo09rPXECQ9GNbtlmOEkU/FC+31bQ=;
        b=kHS8ERDU3Ct92nMrdzclKnq5HsHGsFmZwtbfjuXpIx229h8RMrLtoMMOzxHzTdIZS8
         V3ccCOY9OEIr+//EJPfy8gMBfAdI/XCW4Lz12APtTL3b1u2i0F5tLOvOWsiR+NCg7mOY
         s0REagUT0kjR2xMfoSFxy4yld3jk64VIX/Y5VI070Lqz7G2Qb5zq7ixqIE9LqxuH6UJ5
         dDKbK/8bBJxbRMmeGSTwxD3Xjj1Nn5MlaTytubHBIsBdqEm7Y+JWq/4qReEBdz2gxJI3
         uqj+Cix+f9GtCZE1RoocEpCtHDlh0fTBLDOtd4HwuQMsj9Qe7XsJG/rn8sgX7M8t+7ly
         SqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809082; x=1766413882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQIaLIQgPpvPjwvo09rPXECQ9GNbtlmOEkU/FC+31bQ=;
        b=GbHbnpaJ6GXJhdKlN96+mh9fplLKfqq9zEBm5QMWO3clQNPojffQW31HMDBGRyQIom
         p+palfdR+dOMjVLkLht0iKFpc4r4UOUFAgcRiwWLgHX02ikctT5IT5u9BHnW37peSvqF
         qIZ4hP4fmZg9thknH8p4eFc+qYpZlaLfKwQtVlOQ/IpB/xorvibrpkW7bh0S72Vr2NEV
         sDNi/nbq3H+RVWIzT/fy//4m9TAzYRHtOmQ5BaII15ZupBpIlyNFVZzFWxMokW/lZTof
         ug5mxYHZZu9i/naSmNRhugnAs+tybXUQ93Xrlq2BCn8koxLB6zI7pxaU9ZJZfHPhj+Xu
         OhRA==
X-Gm-Message-State: AOJu0YzVTmTF1mNDLGzCUDmVxvZOL45zmaYy0sL+rZGPGdUWRIvlRRfB
	QooJCvhMZY+4hV6qbLLDABeYhjVsQhd6qSYSdNSArs2809YcM71/6GYlpJfCWcYYSwahttSIk2T
	1d3vnRiQoP7W9OumNgj0BtmIKMEGC0OV/Ew9AHmhVBQ==
X-Gm-Gg: AY/fxX6eMW1uD01GLv+DuSZGl3A1SFDwV+Nn/VyqGW3theOGtdGnlVrKU2aDbMKiwgS
	+MzKv1gtlfgz20u+Jbhix6zlkV3It/lidfesUzz/T3yCo9jhFvks7Y0aIFnYMiaiE8OCm5ya4ti
	PlWf3BcVk90Ewl6YszNoT0dkdrFcx2i17uiUnNhEMjjWr+nLwP3kutygxallNgtF4Oz2KD/oxqn
	RYOccvCx5NZWtaDTlMCCvo/tCsxgFkdI6ZNyvLcLa6pmieovYl3luH+0qGThVSNulKfWvlo
X-Google-Smtp-Source: AGHT+IFlaDVI+a5oMLnnHCarjVgbBPgr2VgUq2ZfG0OqjCUgTs9clO9eYAiDEFUHZrTmfCMub+6A03GzehLbgyLQfCk=
X-Received: by 2002:a2e:bc0b:0:b0:37b:8ae8:f690 with SMTP id
 38308e7fff4ca-37fd089a11bmr26436161fa.31.1765809081322; Mon, 15 Dec 2025
 06:31:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1764116093-5430-1-git-send-email-shawn.lin@rock-chips.com> <1764116093-5430-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1764116093-5430-4-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 15:30:45 +0100
X-Gm-Features: AQt7F2pf1mRIoiQM90a3njypo0dH2KFMiLdh_Bqzuie2GPGaqljqZ8raY7YmBWM
Message-ID: <CAPDyKFq8EzMtCVnmXvwMuH9f46ii9HN8wFurMRAYMzpMa+Cyxw@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct
 dw_mci and user helpers from core
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Nov 2025 at 01:16, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
> introduced tracking of vqmmc_enabled. Currently, mmc_regulator_enable_vqmmc() and
> mmc_regulator_disable_vqmmc() well record the status of vqmmc, so use these two helpers
> to remove vqmmc_enabled locally. And also remove the if(!IS_ERR..) check before calling
> mmc_regulator_set_ocr() as mmc_regulator_set_ocr() already checks if vqmmc is correct.
>
> This patch is tested on RK3588s EVB1 with TF cards with both vqmmc present or not.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
> Changes in v2:
> - Use helpers from regulator.c and remove check for mmc_regulator_set_ocr.
>
>  drivers/mmc/host/dw_mmc.c | 41 ++++++++++-------------------------------
>  drivers/mmc/host/dw_mmc.h |  2 --
>  2 files changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 2d81d021..1c352d2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1424,15 +1424,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         switch (ios->power_mode) {
>         case MMC_POWER_UP:
> -               if (!IS_ERR(mmc->supply.vmmc)) {
> -                       ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> -                                       ios->vdd);
> -                       if (ret) {
> -                               dev_err(slot->host->dev,
> -                                       "failed to enable vmmc regulator\n");
> -                               /*return, if failed turn on vmmc*/
> -                               return;
> -                       }
> +               ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
> +               if (ret) {
> +                       dev_err(slot->host->dev,
> +                               "failed to enable vmmc regulator\n");
> +                       /*return, if failed turn on vmmc*/
> +                       return;
>                 }

Perhaps make the above a separate change? It seems independent of the
changes below, right?

>                 set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
>                 regs = mci_readl(slot->host, PWREN);
> @@ -1440,25 +1437,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 mci_writel(slot->host, PWREN, regs);
>                 break;
>         case MMC_POWER_ON:
> -               if (!slot->host->vqmmc_enabled) {
> -                       if (!IS_ERR(mmc->supply.vqmmc)) {
> -                               ret = regulator_enable(mmc->supply.vqmmc);
> -                               if (ret < 0)
> -                                       dev_err(slot->host->dev,
> -                                               "failed to enable vqmmc\n");
> -                               else
> -                                       slot->host->vqmmc_enabled = true;
> -
> -                       } else {
> -                               /* Keep track so we don't reset again */
> -                               slot->host->vqmmc_enabled = true;
> -                       }
> -
> -                       /* Reset our state machine after powering on */
> -                       dw_mci_ctrl_reset(slot->host,
> -                                         SDMMC_CTRL_ALL_RESET_FLAGS);
> -               }
> -
> +               mmc_regulator_enable_vqmmc(mmc);
>                 /* Adjust clock / bus width after power is up */
>                 dw_mci_setup_bus(slot, false);
>
> @@ -1470,13 +1449,13 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 if (!IS_ERR(mmc->supply.vmmc))
>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>
> -               if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
> -                       regulator_disable(mmc->supply.vqmmc);
> -               slot->host->vqmmc_enabled = false;
> +               mmc_regulator_disable_vqmmc(mmc);
>
>                 regs = mci_readl(slot->host, PWREN);
>                 regs &= ~(1 << slot->id);
>                 mci_writel(slot->host, PWREN, regs);
> +               /* Reset our state machine after powering off */
> +               dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);

Previously this was done together with enabling the vqmmc, a few lines
above. The corresponding code was introduced in commit d1f1dd86006c
"mmc: dw_mmc: Give a good reset after we give power". It's not exactly
clear why the reset is needed at this particular point though.

That said, at least we need to mention that we are moving the reset to
the power-off phase and explain why in the commit message. Perhaps
even better would be to preserve the old behaviour in the first step
and then make this change being separate on top? Not sure if that
makes sense though.

>                 break;
>         default:
>                 break;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index b4ceca0..6faa63b 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -121,7 +121,6 @@ struct dw_mci_dma_slave {
>   * @push_data: Pointer to FIFO push function.
>   * @pull_data: Pointer to FIFO pull function.
>   * @quirks: Set of quirks that apply to specific versions of the IP.
> - * @vqmmc_enabled: Status of vqmmc, should be true or false.
>   * @irq_flags: The flags to be passed to request_irq.
>   * @irq: The irq value to be passed to request_irq.
>   * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
> @@ -228,7 +227,6 @@ struct dw_mci {
>         void (*pull_data)(struct dw_mci *host, void *buf, int cnt);
>
>         u32                     quirks;
> -       bool                    vqmmc_enabled;
>         unsigned long           irq_flags; /* IRQ flags */
>         int                     irq;
>
> --
> 2.7.4
>

Kind regards
Uffe
