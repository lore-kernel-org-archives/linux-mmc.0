Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27591F2BAD
	for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750677893; cv=none; b=Np2/wzBl2U9BlN87Sc4GQU4ksF9ND0keirYXTBekEKXIF42JzXGQpJBv+9BiLUicZLr2PUkudfORmk4bs3tUqLmh0rZ+W8XUqMmtG46vQuVcmEY/EOuAgottVi55nqjN7yMF+GT6/7pFubCUh09mAt+o3y7piyxm3TSvrL+wR1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750677893; c=relaxed/simple;
	bh=P5Sl98y38xvSSFCfZCfnoyyg8/BK5OPvXyrI5MLUPNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIAYjE4WDyAZU0f32Mhrr2MAEl2D5dOoUhJ1FtPDVRiSxxkERhEzGeZi1XucViqXaaizSAi2dVhnY+k0pE3H+kCuJMgfr5bNAM292SP/Umr+bZ2ucFbzyKYFhhnK8CRc4e/jxsSX+M4Pc+tkX987CO6kTLdjf6BZvdukazsSM7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WnPSi4wm; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WnPSi4wm"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso3486334276.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jun 2025 04:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750677890; x=1751282690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=S3F6ZEyg8xrhvs90KaNs4ZQkdGcaIaLATUUJxYt5iNs=;
        b=WnPSi4wmpk0QbRiU0SpS2Ydxic57HwRbxpnmd2cKoYmARD5PdIQNYmfcEMrnVA3x8d
         TdzNw37FfOvpt4jPcf9kJuz9qjHNODr+HF/bWnQOjUcKMND4awi3wUOh8SrQDwaO+ZnN
         DwkEZZ+wdZZj4QePxBWX4K9XqQ/FjwQLxd3ifnDVRG5kBZMIfe/D9BsbehGFtpBdXKxk
         sXbk3wvYFb9ZYkQwHc58HYAaWpqJBrZVVdpNnjr5n0I053XDmtUKaW9a4t+jVri7RIe9
         M43kW7PkxmCn6SSbcKThSVTgIxFwQF8W13RwrvJJTQT77EmwESz4OmQWnFE8hGRViqDf
         YBvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750677890; x=1751282690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3F6ZEyg8xrhvs90KaNs4ZQkdGcaIaLATUUJxYt5iNs=;
        b=qRvpmYvRjBa1Z2Lp2giMJ1a1ZLGjE53D0S596rSobaa4ODsK69+p3lGY3xy2YzRBYY
         Mtc3HFIscIXTnRxX9m/ax8s0YRr8vKGlcS40DtnwJfMazZAj0Y7I0sC4cBulBRfWJF4a
         85+0XtePYafdOXYmODBNY8QyWKMFc0HIo4O9zutBMW1xDWaT6CoZR1E4yNpF7azZjASr
         2RkIe3WosvsLvQqD1fR7ChnLLsdVE1VB6l0XAUX/ecinEGFXQ+0ocAqjyYd82r5wR9Bx
         ywUrpM+6ovtadBEuKy4arnFcy9KvGKo67Q+SOVE9eSdw0a0pyp73yCqPtnvtutRg+J9x
         ra1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3YushIkljOOWh8ZsF6VhLahNmmV0Mb/kMLsxpBjTzURzbyaNtsDfXqEuiILB/Af9lvWfrJmIr5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKsK0ggewnYb9YANrJRC0wHqTSxnJVw0wwI0kD+FHrNyOR3Bct
	1AIDQpqYj+HHnkrr3HL/bv3CNgOeTmwWW9bOliYF2LGBjEMENxmTvGc9YHsJHE8a0U1Xer3p4cJ
	4ZfGeMsmPJO7uuc9faxjMukDvLvS74tgvPuSIUOcmdA==
X-Gm-Gg: ASbGncvRX4Atdd07WZSerw3Xi5GUPtB31woWuvRq43tCmcYMNCcWj/Ubys9ROWodb+G
	GqgSa80gvFUxckFSSAKN14atfxYJpb+pUDzsuALxD/bjPscVnM9ANZKeuNZ9A+/PgnJLrLSq+6B
	JqfTUNkhEF4ssHGKz6Fj0ySpxy5CGLfh/vmhY0BUqqov/L
X-Google-Smtp-Source: AGHT+IFBGQTkGwfG1sCUA1pxQDur/r09SkjVSlKnf4sftIQL2kU67dbH4LwgXNNxgqaZMbnr9M1AlBfGJTvOJn3cZQk=
X-Received: by 2002:a05:6902:110b:b0:e84:2761:9e57 with SMTP id
 3f1490d57ef6-e842bc9cb1bmr15596380276.20.1750677890449; Mon, 23 Jun 2025
 04:24:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750216134.git.zhoubinbin@loongson.cn> <aa9cfb9707334cd2e56692397dd4f54c418262ce.1750216134.git.zhoubinbin@loongson.cn>
In-Reply-To: <aa9cfb9707334cd2e56692397dd4f54c418262ce.1750216134.git.zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Jun 2025 13:24:13 +0200
X-Gm-Features: AX0GCFtUkm2_qzcRRHn7M8CtdXK3QWv2eyxlNDa6aJAl_8XE--LnCn5KSCmtfA4
Message-ID: <CAPDyKFocFfamgdB96xTCfBjLTFtgn2yrdZPTQZ0S5qW7Q2uvGg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] mmc: loongson2: Add Loongson-2K2000 SD/SDIO/eMMC
 controller driver
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"

On Wed, 18 Jun 2025 at 10:08, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> This patch describes the two MMC controllers of the Loongson-2K2000 SoC,
> one providing an eMMC interface and the other exporting an SD/SDIO
> interface.
>
> Compared to the Loongson-2K1000's MMC controllers, their internals are
> similar, except that we use an internally exclusive DMA engine instead of
> an externally shared APBDMA engine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  drivers/mmc/host/loongson2-mmc.c | 212 +++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index 872f5dc21b21..75144221a821 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c

[...]

> +static void loongson2_mmc_dll_mode_init(struct loongson2_mmc_host *host)
> +{
> +       u32 val, pad_delay, delay, ret;
> +
> +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_SEL,
> +                          LOONGSON2_MMC_SEL_DATA, LOONGSON2_MMC_SEL_DATA);
> +
> +       val = FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME, 0xc8)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_INCRE, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_CLK_MODE, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_START_BIT, 0x1)
> +           | FIELD_PREP(LOONGSON2_MMC_DLLCTL_TIME_BPASS, 0xf);
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_DLLCTL, val);
> +
> +       ret = regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_DLLVAL, val,
> +                                      (val & LOONGSON2_MMC_DLLVAL_DONE), 0, 4000);

Please use a define to specify the 4000us timeout.

> +       if (ret < 0)
> +               return;
> +
> +       regmap_read(host->regmap, LOONGSON2_MMC_REG_DLLVAL, &val);
> +       pad_delay = FIELD_GET(GENMASK(7, 1), val);
> +
> +       delay = FIELD_PREP(LOONGSON2_MMC_DELAY_PAD, pad_delay)
> +             | FIELD_PREP(LOONGSON2_MMC_DELAY_RD, pad_delay + 1);
> +
> +       regmap_write(host->regmap, LOONGSON2_MMC_REG_DELAY, delay);
> +}

[...]

> +/*
> + * This is a controller hardware defect. Single/multiple block write commands
> + * must be sent after the TX FULL flag is set, otherwise a data timeout interrupt
> + * will occur.
> + */
> +static void ls2k2000_mmc_fix_data_timeout(struct loongson2_mmc_host *host,
> +                                         struct mmc_command *cmd)
> +{
> +       int val;
> +
> +       if (cmd->opcode != MMC_WRITE_BLOCK && cmd->opcode != MMC_WRITE_MULTIPLE_BLOCK)
> +               return;
> +
> +       regmap_read_poll_timeout(host->regmap, LOONGSON2_MMC_REG_FSTS, val,
> +                                (val & LOONGSON2_MMC_FSTS_TXFULL), 0, 500);

Ditto.

[...]

Kind regards
Uffe
