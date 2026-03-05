Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBDF398911
	for <linux-mmc@vger.kernel.org>; Thu,  5 Mar 2026 11:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711831; cv=pass; b=X1Q8IcTaIUkb+Oblkzbyo8J4HgK+HiGzE2ibHVnR7dPAGt6StJ6xbfJxu3v/ZaIIOVTiTbJnP1JvmPm4r3gqU6wmOANYelaO4uKERhprsqZPogCGcz513r/ziRfNGl/CImR7B8xUjQ5UWYOXh1fdK91M6l4tu0b0Ze35tzmVHfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711831; c=relaxed/simple;
	bh=lHWXPInfOlSLtR9AxMbyxHin8i3+t8CIxh3kSbBKk9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dyFi7KiB5xEw1TPudoa254OXHpiSXVJmG7wWecFgM5sA/HBeEjm/+iP1rgy5YByBQLZRYUDe2QSufpA+7iZu9nPuUAoWRR229A42wg4NJuNuHoez5Ym1qnE0CwOSH8UYnXZaU6gVvqrmjQQPRqtf95VHh7yDtO0AwSlnDUGiFeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rvEsTSSB; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rvEsTSSB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a12cd0bd79so906030e87.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Mar 2026 03:57:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772711827; cv=none;
        d=google.com; s=arc-20240605;
        b=dwR/gKTyG5gSl8u2Ezh3HVQ2IwUCBGkBppcWaYyWiWMjdp37gmF7o+sOZenKevWH8n
         QfWnZXx0shxY5LFCvMG+5CSNKrKfuquf1Q0R1D726xmKMS2rTBd/M77ylYKrnTuS1K5b
         GsFlVpm8Lk6PBIqLdXfjz3uhEWzvT6jcSDD9CaJQIdCg9CtUkCV6lAkFoS42LRe/9xqZ
         gi09wC81Ze3dxZc45tErr9N4ml7gbIcYplWqH+bZSEf9yUQNPgR36rnJLGXIyQ6ex2er
         cH/bX5Bv8AylLStdM+jpAbSY1HDQ+UaXZcb0AO3scC/01bmbpUpZhCcsWYIkhSm7nAPC
         xmHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cHrJR4R/GB7EObPEroqQ0CaMY/ACFx+VG+EDJOZnzwA=;
        fh=pDqx55+Em9XwEp0dpjBha06N58ANQPCRYZAyq3Yyag4=;
        b=Ucax0yEPsZqBhuYUCx5YXIlOjgjsNIKvQj2fUc/OX37kZ5ewNBURCtQMlUZ/Qm3Bbo
         XGTVfzF0QjDv4o9C3gpJ2GrmBBFA7K4tCG4SUNqeyGzjCe3WFxiodW1MQM7te8fEf9XF
         PxJWiCd39/i+76D/IOhUlxgpjzZBbm/2mLAPYkTlu39dRDEApagypZFvCI6TWg7dOBei
         O39i+lNPFmdDerpcZTx5wh+shrljRUOPerCNxh/bw6nPyyuB4IZONb3sSvn6Zvjbpd7Y
         jmxdy030ucykhXEZ1cLvJXmEGFBi1M9QF9A0X7LQ/otTm5PV4+aCvI3OckD1lEglWqrF
         lFxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772711827; x=1773316627; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cHrJR4R/GB7EObPEroqQ0CaMY/ACFx+VG+EDJOZnzwA=;
        b=rvEsTSSBoPtJGdW0T+1cjEY8g33m4OtpyCNAtvGzA5Hpfe/uz9mK8CvbhX6lwWYucH
         DKdQTy4qYHplKkEO/619Rt+dz4DGxErzSzpOWjnMxR5xhaUz9wURAnc5Ahu9lXjMaqOQ
         WiBbPM4GzNYWpcUedgKUMt4UFyXP7GNisrDYT0qoKKf6fP5tGifIHffiKQlKiuz/Q4qJ
         DGtcgWZF/m0Hv9veUmAbxWMMIstDQxaMvARXadRDg+86ohDBIhWsq6lP0dBrxR/iLz3O
         ez9seo0ewwajd3eIpZ91RuMZ7wdfsv1hvMPyHr4ZmLLZNTRCOgJjAFe/4bE8ljEi1HVe
         +zPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711827; x=1773316627;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHrJR4R/GB7EObPEroqQ0CaMY/ACFx+VG+EDJOZnzwA=;
        b=LboSQ0QP+A6QNj4omqU9+nlBk2mqTse3QlM/l261clBk0ud91EONG2eX1hm7qVk5Dy
         Y/ZKLa5ZpLgs+cDwXKekf9RnKt+XKNMhCKBr7nGAsGgTGX5iykRal9hSo+6tzBhpVKYM
         UNENGHAxsPrKV7IXQfay3SUQAk0Ztr/n2qmvUGOD3bUGQDOPbGyvnaFZHzRh6/5rC5/u
         RRMzFqnkSZJeO6YMbQaIheLSFNWM7oB51rRysMVR0mz9ZEbY8P2SeuXp3jZFj1U+wlLw
         Cw4vXAe14hKfg9C7985UMXJr1/71+Fu71UElyZzJ+7GeZNllCaJWC70j6wX05UmH/Lg3
         cw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyQOHKVrUf0FY1OKK7Z6vPn7hzocV5lDyS5Z3Yjy5BZilAz/CYiFMGlV1ocR6Tw+SYR4a16Tw8Pvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU2c95mfgBzda6jI1yMnVCSqJmxm3L/W1VUA5cLhWyLO1+iYHl
	rVGeJyLrSNCihaJU2wPYDSgytgU3crUfA0vVu8MgP2fuTvCjbfb/TlXwkS5erEkcmL/mlY6UaP1
	1y0LRGVQbJhdBwFnkLL5sSN7KhojazqeiXllsjn1/fg==
X-Gm-Gg: ATEYQzwMaB8zqmd1EWIWAmbJsx2efK7JVzRV0FHVRQDO3iYx5S1IBzdkt0pUJ6KN39Q
	fZcvjAGWBV+Wk2KxUWbMW8ASHytGCAIJKy8Nkld3FcQXAJTaWNStOeVjG0ITAFe4hBP+RLjC9eD
	7u1m5YwpqC/RwLWxo5sbEkuCrvpvEW+dhdRPQEf8EKRxhcvKR7p7byme8wdIJ+irfUiI9jeSExb
	vPpPC7FqMW0XD2p02tIMVPT+e4bC8852mQcW9YlUBmgsDmCcyrcJWv+j7FykDvKPphDRMkqvM/K
	As6DSj8x
X-Received: by 2002:a05:6512:a91:b0:5a0:fb3d:b72d with SMTP id
 2adb3069b0e04-5a12c2d02f1mr833728e87.19.1772711827345; Thu, 05 Mar 2026
 03:57:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130030501.373630-1-ricky_wu@realtek.com>
In-Reply-To: <20260130030501.373630-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Mar 2026 12:56:31 +0100
X-Gm-Features: AaiRm53XGLC_tVUpaqzMxUwgKyZJxyhtTDJKqaw6rzeiVOznNZTJEVgwGyORO5o
Message-ID: <CAPDyKFpaN9MLoUFaixQvLdTdKLM8yPD8=af+fWcNg4QueyvHqA@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci_sdmmc: simplify voltage switch handling
 after card_busy()
To: ricky_wu@realtek.com
Cc: matthew.schwartz@linux.dev, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Jan 2026 at 04:05, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Now that the Realtek PCIe SDMMC host implements the card_busy() callback,
> the MMC core performs the required DAT[3:0] validation during the signal
> voltage switch sequence.
>
> As a result, the driver-side voltage stabilization helpers
> sd_wait_voltage_stable_1() and sd_wait_voltage_stable_2() become redundant.
> These helpers duplicate DAT line checks that are now handled centrally by
> the MMC core via card_busy().
>
> Remove the two stabilization helpers and simplify sdmmc_switch_voltage()
> accordingly, keeping only the minimal clock control needed around the
> voltage switch.
>
> No functional changes and intended.
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 88 +++----------------------------
>  1 file changed, 6 insertions(+), 82 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 4db3328f46df..8dfbc62f165b 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1181,79 +1181,6 @@ static int sdmmc_get_cd(struct mmc_host *mmc)
>         return cd;
>  }
>
> -static int sd_wait_voltage_stable_1(struct realtek_pci_sdmmc *host)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err;
> -       u8 stat;
> -
> -       /* Reference to Signal Voltage Switch Sequence in SD spec.
> -        * Wait for a period of time so that the card can drive SD_CMD and
> -        * SD_DAT[3:0] to low after sending back CMD11 response.
> -        */
> -       mdelay(1);
> -
> -       /* SD_CMD, SD_DAT[3:0] should be driven to low by card;
> -        * If either one of SD_CMD,SD_DAT[3:0] is not low,
> -        * abort the voltage switch sequence;
> -        */
> -       err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
> -       if (err < 0)
> -               return err;
> -
> -       if (stat & (SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
> -                               SD_DAT1_STATUS | SD_DAT0_STATUS))
> -               return -EINVAL;
> -
> -       /* Stop toggle SD clock */
> -       err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
> -                       0xFF, SD_CLK_FORCE_STOP);
> -       if (err < 0)
> -               return err;
> -
> -       return 0;
> -}
> -
> -static int sd_wait_voltage_stable_2(struct realtek_pci_sdmmc *host)
> -{
> -       struct rtsx_pcr *pcr = host->pcr;
> -       int err;
> -       u8 stat, mask, val;
> -
> -       /* Wait 1.8V output of voltage regulator in card stable */
> -       msleep(50);
> -
> -       /* Toggle SD clock again */
> -       err = rtsx_pci_write_register(pcr, SD_BUS_STAT, 0xFF, SD_CLK_TOGGLE_EN);
> -       if (err < 0)
> -               return err;
> -
> -       /* Wait for a period of time so that the card can drive
> -        * SD_DAT[3:0] to high at 1.8V
> -        */
> -       msleep(20);
> -
> -       /* SD_CMD, SD_DAT[3:0] should be pulled high by host */
> -       err = rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
> -       if (err < 0)
> -               return err;
> -
> -       mask = SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
> -               SD_DAT1_STATUS | SD_DAT0_STATUS;
> -       val = SD_CMD_STATUS | SD_DAT3_STATUS | SD_DAT2_STATUS |
> -               SD_DAT1_STATUS | SD_DAT0_STATUS;
> -       if ((stat & mask) != val) {
> -               dev_dbg(sdmmc_dev(host),
> -                       "%s: SD_BUS_STAT = 0x%x\n", __func__, stat);
> -               rtsx_pci_write_register(pcr, SD_BUS_STAT,
> -                               SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
> -               rtsx_pci_write_register(pcr, CARD_CLK_EN, 0xFF, 0);
> -               return -EINVAL;
> -       }
> -
> -       return 0;
> -}
> -
>  static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct realtek_pci_sdmmc *host = mmc_priv(mmc);
> @@ -1281,7 +1208,9 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>                 voltage = OUTPUT_1V8;
>
>         if (voltage == OUTPUT_1V8) {
> -               err = sd_wait_voltage_stable_1(host);
> +               /* Stop toggle SD clock */
> +               err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
> +                               0xFF, SD_CLK_FORCE_STOP);
>                 if (err < 0)
>                         goto out;
>         }
> @@ -1290,16 +1219,11 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>         if (err < 0)
>                 goto out;
>
> -       if (voltage == OUTPUT_1V8) {
> -               err = sd_wait_voltage_stable_2(host);
> -               if (err < 0)
> -                       goto out;
> -       }
> -
>  out:
>         /* Stop toggle SD clock in idle */
> -       err = rtsx_pci_write_register(pcr, SD_BUS_STAT,
> -                       SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
> +       if (err < 0)
> +               rtsx_pci_write_register(pcr, SD_BUS_STAT,
> +                               SD_CLK_TOGGLE_EN | SD_CLK_FORCE_STOP, 0);
>
>         mutex_unlock(&pcr->pcr_mutex);
>
> --
> 2.25.1
>
