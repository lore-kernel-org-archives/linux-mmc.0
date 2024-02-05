Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DD6208CF
	for <linux-mmc@vger.kernel.org>; Mon,  5 Feb 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707146949; cv=none; b=qRwNUR/oB2HA6I3D90V/Az7V8ixjpWtKoij0Btcm62odX1eXzT4LtoVh5eKVkwXuDs3cPVLPOaKx8+vo64rgU/cDuj8q6MQYZZ2lnc1kf3mGXmknHNHWmKcIDT9HsVVRAc2zgpSwF2ZFnTT/aLhJHvPzQvh5w0U4WdKXERb1abM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707146949; c=relaxed/simple;
	bh=d6wbAM4aDdGGjpQwVdYrM+oOfAbd3RxgpP6Abo8fpgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6greeLfVTsh/78T8tKbG83AucojlRwsQ6xPLdtJlilXEzrcE+LX8bHvm6NIMxDvfS/iLurbZFHubwfcBUrRhz+ONmrk3SL/DHGH5GwtkT/Zs0jlPRCYtmi2aAwYqnet+R2APQ2SppWNJKnVFqwGrwhB2eLZmDbtabOWBUjZ2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oV9v9qBR; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV9v9qBR"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbed179f0faso4150365276.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Feb 2024 07:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707146946; x=1707751746; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TrhbdBjpZYfHwabFxcHUce9eaBfUeDV85cQjXOpQbCI=;
        b=oV9v9qBRPNqDuoRbB1xXmkMmcNi+m5WFW/4JVEv7v8RXu7DfSXj2+NZsaroUjfzGua
         AlTZpJFnllXcx2ysCssF5Kcz9cwGbKVjFVO+mTeFWhnpXj2xzQE/POvbVthaQEgkuYco
         QgAmQnGWc5K04wLPnpHssnizu/Afytrp3iGLYr8xracsCfPYOPiBvmy/qDRqqyvMGk0D
         X9LOeeS9By/rVlmBmBBUKW9ukTdA/CAQZOkE89iVFlLgAcnNetx47ElyxYb6v9sBrV6s
         TvwxBJTSCHh0EttjVJ+6Z6QTgaaeIVbHhIj+YAglmUxs3c71In8PD6jTwUlChM4lwedY
         zEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707146946; x=1707751746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TrhbdBjpZYfHwabFxcHUce9eaBfUeDV85cQjXOpQbCI=;
        b=nsxZ2LN+C02fIbFtDeiXX3PMHxrq9phSSdqUcsu7kZs0UV2f7+dNnjajLYFgdEXwIR
         mYjGn4RJ7cS0ClzBprAJkDaXROtjY3foZfKStfN7CTN1fD5V6B5kyM3TW2Nnjk3Q2k7J
         Xt8JAFh/izzMzbEhYssiNQTT+H4m8bgY1Fd4Alh8OARnewMXn41wt2fTdAWjFAOyYKTG
         7TCVxO3zQ8rRNyHDx3n0hTOehg1AaMmYKyDYXpi01+StshnZvPhjSmfQU3j4xVRzDLGd
         +0uSbWaWT2TybGYpzvXg0t/qXlXVi5Khu1wn/ykq5MO96HI3erWoxUst1ircSNUo4f5J
         0emg==
X-Gm-Message-State: AOJu0YxaKcVgCQQqSM3wMjlUjP77eHU/Yqoc3o23DtjmtveNWLYnLeys
	Jp6W7swZzwCBx8dbsZ8GLwyEvvSIozsRVSrQ2DtI5B5h9++/+WLzOV5KSzN4T/wkJXr8qulkxP0
	yYCwRiHG1uW1VCNPzO6PkJth+Tr7UVRKXF816nw==
X-Google-Smtp-Source: AGHT+IGQelaOobngFU1ZPvjGKsCZvVU+JjK/jTUi8xxoCrI3yWT4zVOL05macztiXBw8WDb6KcVSC1q23xmXAsKu+PU=
X-Received: by 2002:a05:6902:2784:b0:dc6:a072:bc8d with SMTP id
 eb4-20020a056902278400b00dc6a072bc8dmr3134ybb.21.1707146946296; Mon, 05 Feb
 2024 07:29:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203102908.4683-1-fredaibayhubtech@126.com>
In-Reply-To: <20240203102908.4683-1-fredaibayhubtech@126.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 16:28:29 +0100
Message-ID: <CAPDyKFrt80WPeCGJZsQaCsN5a+95ru6rKnQb3kPODMkU1G6Ocw@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix a warm reboot issue
 that disk can't be detected by BIOS
To: fredaibayhubtech@126.com
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux.kernel@vger.kernel.org, shaper.liu@bayhubtech.com, 
	chevron.li@bayhubtech.com, xiaoguang.yu@bayhubtech.com, 
	Fred Ai <fred.ai@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 11:29, <fredaibayhubtech@126.com> wrote:
>
> From: Fred Ai <fred.ai@bayhubtech.com>
>
> Driver shall switch clock source from DLL clock to
> OPE clock when power off card to ensure that card
> can be identified with OPE clock by BIOS.
>
> Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>

I assume we want a stable tag to be added to this, but perhaps we can
also add a fixes tag? In that case, what is the commit this is fixing?

Kind regards
Uffe

> ---
> Change in V1:
> Implement the "set_power" callback in sdhci_ops,
> then switch PCR register 0x354 clock source back to
> OPE clock when power off card.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 7bfee28116af..d4a02184784a 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -693,6 +693,35 @@ static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *io
>         return 0;
>  }
>
> +static void sdhci_pci_o2_set_power(struct sdhci_host *host, unsigned char mode,  unsigned short vdd)
> +{
> +       struct sdhci_pci_chip *chip;
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       u32 scratch_32 = 0;
> +       u8 scratch_8 = 0;
> +
> +       chip = slot->chip;
> +
> +       if (mode == MMC_POWER_OFF) {
> +               /* UnLock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 &= 0x7f;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +
> +               /* Set PCR 0x354[16] to switch Clock Source back to OPE Clock */
> +               pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
> +               scratch_32 &= ~(O2_SD_SEL_DLL);
> +               pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
> +
> +               /* Lock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 |= 0x80;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +       }
> +
> +       sdhci_set_power(host, mode, vdd);
> +}
> +
>  static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_pci_chip *chip;
> @@ -1051,6 +1080,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> +       .set_power = sdhci_pci_o2_set_power,
>  };
>
>  const struct sdhci_pci_fixes sdhci_o2 = {
>
> base-commit: 56897d51886fa7e9f034ff26128eb09f1b811594
> --
> 2.25.1
>
