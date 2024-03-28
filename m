Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A877E59F
	for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629543; cv=none; b=IIwAzvi73bUSQQBPJB24Q4QjoRWLPOOlqfLte+fhQyR4vSiqxCpYf/vtDs0w+LLLO+AggGB4nIlNey6ulathM4oh8GkSwICQcDypCf1PiTPAN1Q0xUQBbjiVSunKa27U3Oq2twMXxAsfMGqmSwtyxwv9iOliHaimOHd64gJUTMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629543; c=relaxed/simple;
	bh=i3zyUL1p+Drh++oy3h6WA7kTXggCpKM16wFE0I1SiNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSLWBioXiaEo+eoU8ifVyeFzLQd8sRbR/rXe7An4DO51KmWDXTG1/bpaZWKS6z0egV+yqrBXuDsN5kL7iwjJATY36hKxOEdlz2Md2WsDF/YOK2B/6Z+QGTsYqD9cUufT1hG536r996ceefXGFmRq1NtMD8VYbj8Jdid+276IC3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCcqPo2h; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCcqPo2h"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso848363276.0
        for <linux-mmc@vger.kernel.org>; Thu, 28 Mar 2024 05:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711629541; x=1712234341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbFZsO42nxYTcylJXM+AgVeR+gZ+Nokwozi7iOFo168=;
        b=sCcqPo2h1PgNjicmUv1twnJ42ofd1MD/p8FdmKaf/eQEkBWp62jcfSAV/axFK7rww8
         1xUxVFay/dEC0uqjyTHVzYC8cx8RBtl2g86e9LorJlAlJemagNaSlwjIDRQQ3Q9C51qE
         lmJAMI9vZACxxa7u6EngP8zgyOf2eM3nD7fRKqbJT49xi5Lwn4MKv+vnkMl4FXwAlqH7
         yj2thN3RCBANMBmelwjeSLjU/yLMs7NOkA1WtFcYF4t1xwHnZuJqHSdOocnQge7DQD9D
         wQqVFJIyGpFgma0Mb3/kqbI1wm8QUPfPRQ8YTx+M6b0FrAqM6huic/sYVsXyQnCDTfeb
         EL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629541; x=1712234341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbFZsO42nxYTcylJXM+AgVeR+gZ+Nokwozi7iOFo168=;
        b=IURmmSMST0YZrUsiyXFrKjQiYlKYBslSqIX4dPR06IWRJD7ziJ852y+sLkF88DHwZT
         9S5T7Y7Ky7wrVyXMtWFGlDNIZPd8TSrG8xeyuT/updTwRqQ3X3Je6UdVMfUjLm9aUBnr
         iKwK0J+B4EtVVOMdIRJStmHeuaRTxAXlylLkXBJd0HzchlE35SmbcWxTdivOH5tLoTC9
         J+ARtAd+Qh1CuPgSFdm7xDojE7/oZz08TYlENj6PgbmJLMbbWqWzTJ5M3bV1OzgfGpbD
         DW9zOw8yktxC1CmIPNqwjyvf6Mf/MDcQtm8Gv8R+2C77I0Ln6vBPxLIKsFVhqTnwcGD/
         TlvA==
X-Forwarded-Encrypted: i=1; AJvYcCXcfyWrSzm9nthC/hJDoyDF25ZBTxMvzwobh8A8Nl6Q7D/hoS/4C8BkyTJNH2taY5aIWHy9UpSJuvoGXyVDnSf2kIvyoMWftoBy
X-Gm-Message-State: AOJu0YwyBjy5rNgqR9SmlJXXDpuWrggV7Zk0frHblxCvzhfXCYpdFtRF
	YCfPztLMhpqRnSmBUyNXQoO/CpbgycAvnn4iXmLj0/cn66o3RbpPq7pD3AbKDP1Xg4qLRc2suZ1
	reeqJLcZA9TaaM6AliARej0p7dxvsW1lfUCIRbQ==
X-Google-Smtp-Source: AGHT+IFkDjr06H+k4p59jSQxZrMcpP2X/pxbmbf0Ojewgx1WYGoZRii2U3W8FdVbFnM+76XqmRq0dkex1V+VyDzFjO8=
X-Received: by 2002:a25:bed1:0:b0:dc6:d22e:ef4c with SMTP id
 k17-20020a25bed1000000b00dc6d22eef4cmr2625248ybm.17.1711629540724; Thu, 28
 Mar 2024 05:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327024545.138351-1-ricky_wu@realtek.com>
In-Reply-To: <20240327024545.138351-1-ricky_wu@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 28 Mar 2024 13:38:24 +0100
Message-ID: <CAPDyKFo3dkzDDEU7Lk14zH0td0AP=z2RJQibj8SP6JeUuz=iFA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: resume not check card exist before powerup
To: Ricky Wu <ricky_wu@realtek.com>
Cc: wenchao.chen@unisoc.com, ricardo@marliere.net, marex@denx.de, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 27 Mar 2024 at 03:46, Ricky Wu <ricky_wu@realtek.com> wrote:
>
> _mmc_sd_resume
> add get_cd before call powerup, make sure the card exist

Please elaborate more on what problem you are trying to solve, the
above doesn't make much sense to me, sorry.

Yes, the card may be removed while the system is suspended. Then, even
if ->get_cd() indicates that there is no card inserted in the
SD-card-slot, we may still have the card being registered - and then
we need to unregister it.
That said, we need to call mmc_power_up() in order to try to
communicate with the card again. At least that is what the
mmc_rescan() work assumes when it runs the bus_ops->detect() callback
at some point later in time.

>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/core/sd.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..35e036672cfb 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1750,6 +1750,9 @@ static int _mmc_sd_resume(struct mmc_host *host)
>         if (!mmc_card_suspended(host->card))
>                 goto out;
>
> +       if (host->ops->get_cd && !host->ops->get_cd(host))
> +               goto out;
> +
>         mmc_power_up(host, host->card->ocr);
>         err = mmc_sd_init_card(host, host->card->ocr, host->card);
>         mmc_card_clr_suspended(host->card);
> --
> 2.25.1
>

Kind regards
Uffe
