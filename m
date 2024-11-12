Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40777217F5C
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437053; cv=none; b=Gx/MJyB8e4ya1okGSBIs+7VhfMWb5BDxfkgBH9wyWhp6ygozW4LXL9fFdJ9S79YK2HjKF55RGMAT5wCI+nlbEM0r2Gl1DYmXxcebuC1gyBqbYlQR5INZAgNhDbRlEe5uHAtV65ltg6xp0bl85ayNRsIwC/tCHZBblF2AgL6kBCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437053; c=relaxed/simple;
	bh=I+FspxCvjXN1d6jAEz7mVDNmvXxhrfS/Nunabzq1yo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnELzAeYskID7t4VWxYRav1VE3H5cEcuKjmsEMSJhGLNRbhpoMDdIr0Qg0oXP3jMl3Lg81V9kmSD87SpvY785TI1AnKvkGCg3LACJpwbiqg9lHNg1/OnPt2TxLbgNueLLCpeGH+vEeYPCrvVnPINoMjaeSwFLimZ/ArdZakeMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUmGUQQj; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUmGUQQj"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e9ba45d67fso55970737b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437051; x=1732041851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=raxppSo1jMcpz5wA1AgpjcgkeRdGGPMkWi2ZmAReokQ=;
        b=kUmGUQQjLMaEdk2RFniXP2MVtZqGxT8vga6vTmzXE327+Go98UiLDzB5eSo3flSLzH
         3EAdbaiVaDUOSzYGViO/PM9BRZG9tloXkqb3EUh7luC1gtUX1pcDFxRilOWADOPakARd
         FSjlxNQceucubmHVf+fBJrdHPlLEcWjyZnNfyN30A7mBS9CZhYqLCSmoFV34kgslNISw
         Cu9ynpvQrQvzvqE1J6n1sB4clc4SDHhQJ6sCDss2TJ9UUU1n+XtfceDzlvOe0+FP1+/a
         jOjbQihgHlhqOmsssa3RgIFn7mQEyZ3fI89LYZEtComwaUt139A+XD999vdMFmOmkBzx
         +KCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437051; x=1732041851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raxppSo1jMcpz5wA1AgpjcgkeRdGGPMkWi2ZmAReokQ=;
        b=YTuzPEyQZYtAPhEsKydlk59rmmivLMFK4cGNyK1UznBSrnVYa0q39VrkMvh601h8qZ
         GaJQRka6pEmBSGGFBeO24vgfVEpjZ9nBYIY9iEOo0cIkoU7VsmrK+9z9WrMqRm+kvtph
         G8VMJ+yfLRBua5MV5xclD35UyfjJxDP5yyK24nbaSf9b7N3GAGgSwdpGPAYJBJvKwceO
         iNcOKCBsv2Itn0UP/Z9p+jiUDjEI0+i1y/VLOMyw+6kDSgdGzuElVMOVKwCoWMv2yZiq
         VvtneGsXUfZK/duj7SfmaR+mJ++Bfo1CQqFy4injGP5GJSob7k7usZUxLgste4SuyBkC
         U6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS8MbaRdmklXSru07GDOjX9BTxX218NMzLXxEhLT4Ss5jN3ne4nhJqcMzoeOeVgkiLTd8gsBA8UZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBwQibnzVk7Skq20NZjLIY0escxvBpCEdMKRBKRNXdqXmJimbm
	SCY4OvaNryDmcbPxIFX/E23YqAf1FQ94Fba2wr1IbSlP50KFcj9D6MgahyjuGzpPI7wbCP5FAXe
	lYLQgnOb0sfPYbABcKwcuwQJ+sk6zyxus1GdtoA==
X-Google-Smtp-Source: AGHT+IHggGwQBF3hSzjzb92c45ZRJ4m2KowZjmIDRaih1Yr1+njT1vET97p0CVVZ9fc8pdTOaC5cWsqpuqzxPOTvyJ4=
X-Received: by 2002:a05:690c:6483:b0:6ea:8132:4081 with SMTP id
 00721157ae682-6eca4640b4emr44240157b3.3.1731437050114; Tue, 12 Nov 2024
 10:44:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101104416.4954-1-victorshihgli@gmail.com>
In-Reply-To: <20241101104416.4954-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:34 +0100
Message-ID: <CAPDyKFq25Y2Ftk+7A-hxEu1dLx2hJeAA7yzrcc7FZkSyjL=B+g@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-uhs2: correction a warning caused by
 incorrect type in argument
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, 
	kernel test robot <lkp@intel.com>, Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 11:44, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> There is a type issue in the argument in the uhs2_dev_cmd()
> that will generate a warning when building the kernel.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-uhs2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
> index 7f41ca67b069..33a16cf2e656 100644
> --- a/drivers/mmc/host/sdhci-uhs2.c
> +++ b/drivers/mmc/host/sdhci-uhs2.c
> @@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
>
>  static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
>  {
> -       return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
> +       return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
>  }
>
>  static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
> --
> 2.25.1
>
