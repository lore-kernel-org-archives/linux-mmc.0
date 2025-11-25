Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C42C1A9B58
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073460; cv=none; b=DN8gfi4y3SnJfHNlYi/9/PU+iqyn2MOgjWGLwokV/MmlDAgPibV1a1vCmQFCgfECGtiv28wQ2Wg5VNtG3Ti2oGUEjtwLgtxL+KXf82V5ybJbRGWu3FOyLwqTr1osNd8sA3rRlufuyZQmbNFjTB+y5XC0lceJnsEt4q4G80hyQTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073460; c=relaxed/simple;
	bh=8kRK3yBJdAdCfWGIEn51BM89SaZ4gS2AVzCH9BXLVAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M4VARGsuLx2GYyRrb2x1/tVJF+qGnlgbpa+boQd43eBH8SrxjFP6pMPzIjXeLSkQU9iu7WBExB0OwNhc4xeWNjo36v4/me1DROWTJ1n18nDLCBvN/hcM/yiAYYDerb8zShwaljiw5vCNzVw4fA95R2ILuFdDG5eHOhNsU2hQeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ObOsQ+mz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObOsQ+mz"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78a6c7ac3caso53483767b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 04:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764073458; x=1764678258; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzqSo7cWbQYxKBUWBAYYsHMei2+c+xIFeDmwd5VQBDM=;
        b=ObOsQ+mzviWiLz0Twp7bWAP2xjYgfZFpd7e6lrGZ+vaw3EXryGtt3fi+a/Q/MvjLxc
         XP9fNX4+eYnWGkDdyIjb0IDwqui185Z3jzoMP6AG5AH6VDY8cFotAdJAUlJTkcaBga5C
         WHq/sd7e+Pw2zYTLGBqIF6xe4YtdZ124ZKF8ZGTRw15GbzveUd7nWSX98O/ekz7B8q9E
         H48kuy+2hvwI4NCEixL+P3+UHST4AhgoIUlPAIvyQqR41hCZvmN96tVHtY1SSbz2dt/w
         EKTND2LTRZhA+Roj0QrR/Ko0LDgh6NOkaLS5Q6zzFKpD3NcMYAwRfH1WdcH8th6T9q9p
         JSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764073458; x=1764678258;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzqSo7cWbQYxKBUWBAYYsHMei2+c+xIFeDmwd5VQBDM=;
        b=sfvnLa8zcNhV9QiQ5ed5PAkqZ8KxF+hrcnMeVS6/FZkd9jbAyEXDJysf+UOtV+4B0Q
         Gbq9x/Xc2exa0jWHJjALDqDbSNYttoq1/zmNWjAFG76xVHeoTVx8poi94TlZSbw4L4QC
         4WJ38buS1vYnFYftGvFYVuzjJ5z7RVJJzGP8r0kmcnqXoK5zPydzKQSzSNRldqKyMJWV
         qk7An0w81jYVIaC+fr9Rmy0yESeAKld9t+9KsOrlvHDXUJ82HJpq7EHqnS+mpPxZHzjU
         J5YLwOUK2x8tq/ZmXqRqz6hVV3aUrnQY9H9lOVC0Em6eP2/WvZcqeSPDUOg1ZT8ssyiQ
         xuyw==
X-Gm-Message-State: AOJu0YzqnsJzS/fBScJUuI0gKq8YBkOummXxle6rUiB9qwKHI2hHQRci
	6Ma/1RGFjYn5exSu9K9KQTzzCJC1iGyNUWbmJFcfqTWuKNYGS6fSSoxYEhwHoWcdn4qREMCunou
	eXwWpNy6gSU8lgzuatPUIY0JmYAgOLoGZzoJDsiSsBuYKQpfWx9l3E+g=
X-Gm-Gg: ASbGncs3z0t/5fzFFiUcQHSRB9OZMn/An14bIh6S2K1XYWeMb2qFFcOixuwH717ACZ9
	9sv8KKjOqA5uOUU5hRDU8o72fH3AU3cWVilEtDvSjC+P3uj4Xk7K0A4XD4oFpIPG8hT4FflEhOH
	U55LD0m738gmesapKMjV90TXGoPV5PsflLULDtT4k0eeagm7ejliu8wr0DE0niFMkt8HaGoFRHx
	smWsBdnCrXqG8fvQyiIYs/57EkAH+eogzcgKoOsHeZpfYaIL64rRSfB9UHhinAFHxrfnzu2aXNk
	6n5Up9E=
X-Google-Smtp-Source: AGHT+IHGFiHdCe51Jz9VXIeoPeS9TSnBCy2YVBc391U99a3xkYqxO7isAPjOAZ79Z45C2UISTdjoOl3lBKg+wduhU+w=
X-Received: by 2002:a05:690e:849:b0:641:718:8a08 with SMTP id
 956f58d0204a3-64302af0921mr8390961d50.52.1764073457893; Tue, 25 Nov 2025
 04:24:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1763634565-183891-1-git-send-email-shawn.lin@rock-chips.com> <1763634565-183891-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1763634565-183891-4-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 13:23:41 +0100
X-Gm-Features: AWmQ_blwcTQbe0sn1fUvu7rajPabTfz1rA38GGTiLaU_Ntcf2HauvpLIIjhE9NE
Message-ID: <CAPDyKFpsUYRfN8+5bthC0UttGkRDL6cf-VzgOW-6mP1L2G-_5A@mail.gmail.com>
Subject: Re: [PATCH 03/13] mmc: dw_mmc: Remove vqmmc_enabled from struct dw_mci
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 at 11:30, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> commit 51da2240906c ("mmc: dw_mmc: use mmc_regulator_get_supply to handle regulators")
> introduced tracking of vqmmc_enabled. Currently, dw_mmc properly maintains power sequence
> according to MMC_POWER_* from mmc core, which should be enough. There is nothing special
> I could see here to still keep tracking of vqmmc status. Hence, remove it.
>
> This patch is tested on RK3588s EVB1 with TF cards with both vqmmc present or not.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 28 ++++++++--------------------
>  drivers/mmc/host/dw_mmc.h |  2 --
>  2 files changed, 8 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 80d3851..ebbf1a6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1436,25 +1436,12 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 mci_writel(slot->host, PWREN, regs);
>                 break;
>         case MMC_POWER_ON:

The mmc core may call the ->set_ios() callback with MMC_POWER_ON
several times during initialization. For example, to change the clock
rate. Hence the below is needed to keep the reference counting of the
regulator correctly balanced.

Although, we have added mmc_regulator_enable_vqmmc() which should be
able to replace the below code.

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
> +               if (!IS_ERR(mmc->supply.vqmmc)) {
> +                       ret = regulator_enable(mmc->supply.vqmmc);
> +                       if (ret < 0)
> +                               dev_err(slot->host->dev,
> +                                       "failed to enable vqmmc\n");
>                 }
> -
>                 /* Adjust clock / bus width after power is up */
>                 dw_mci_setup_bus(slot, false);
>
> @@ -1466,13 +1453,14 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>                 if (!IS_ERR(mmc->supply.vmmc))
>                         mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>
> -               if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
> +               if (!IS_ERR(mmc->supply.vqmmc))
>                         regulator_disable(mmc->supply.vqmmc);
> -               slot->host->vqmmc_enabled = false;
>
>                 regs = mci_readl(slot->host, PWREN);
>                 regs &= ~(1 << slot->id);
>                 mci_writel(slot->host, PWREN, regs);
> +               /* Reset our state machine after powering off */
> +               dw_mci_ctrl_reset(slot->host, SDMMC_CTRL_ALL_RESET_FLAGS);
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
