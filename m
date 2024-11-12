Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D6217476
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437049; cv=none; b=qC7aKJhgRoXylWVqXC/jZPcwCEoyX/1hNlIcO157Kg3u24/Crf2EvU3vKcFnVFPGNRVgkCV8yTh83O02067rKL7RTHyYiNl6yDbFGnDT7o5ZcwWThJJQ24b0t+MplKxGgVDvUNb6bqyibFgwSxpghZlgdXAWutSvWfpCmkKGC0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437049; c=relaxed/simple;
	bh=0t8sOmwlSOH1o1/6C/3qT6TANEqdqVcQQAurabnYBIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fk8gDQVosddSBaV981g5K9ZuqOG5yzZe7xN+tnkXA4Rl3922ALgRNAMeWUdv10Id+HFXRl/UsDAAI0Bei6xUf3qBBUlMw3D8CLSA/XrllRvVXxTp3rUIyMZDA1SK1v+kQWROVlUr3gwngslovQYlMbDx2gfSGOFgpnNWxu4iQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lNauDYvu; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNauDYvu"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e3cdbc25a0so60321197b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437047; x=1732041847; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmlE3ocaQwI744iyoEKb0Mlm8+PfDOrWjfONTieFefw=;
        b=lNauDYvua2CJ0TotVd6/rHjgkprqjGgJDyWlfthLZpZDRxPNSfMuA15TFxeSVhYBk3
         VLTx9qs+otuM9ZN0gRGrOKfxTqzqFkN7dL/1zuJ7ID1IYoUm7isx4xYVxhOpN0Hi/3Qn
         w1yq1Wg8hiqM5l8/ubMHLa4Th8NL7FTcfI8lAwF4sF2GZ5Y9JpNTPmSzNhbaswcbYukq
         Wg3kR1k9QQcNqkZ74Qd+V/f5hjbFDMnJrMepS94liYs2spuDhGJSx0FaSuO5pNFCg2b1
         Kfua03yYL/Vwxt3rAl2pP42XLZOA9itxKXA2dFEz7ax2/XeD4mZXSmDu7hoBxQeSHCUC
         9BAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437047; x=1732041847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmlE3ocaQwI744iyoEKb0Mlm8+PfDOrWjfONTieFefw=;
        b=qcoMeoDVGXfPJG7ro5NYi8nqaARbABudK+ykVC7lQsbnyv181jNiWBofJEz7vX0tyS
         4FjESZSYHaSAcZqRelQ1hN8HfUS8jhUh7fCbc2SHqsZH8o/eBe2J6U9dOzDvbtQGL+yG
         qaeAPXxg6+wjPRkpOgV11O+/wGFCuIGe+wExKsRGV8sw9LB1/bihG9WNiFT6hxlCESQG
         jj1lFervUUb73IwGfSsuCbViMgdWVlDUMfFQ+E8T3Ggt4ALoho0kclGAw1gdZTozHXc/
         imUXeQAZYbRoraHvo8vBWXYXJFEHpM8lszQzR3ynXjvhyo9AAdZvzI0CzRMCdtI39av1
         AOEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZPpLtMjRiYAkbkkJESzLZR8t/WnLSpYHD4TO66V5VTleBSrwMxoH3YQMeLK6bKiCg2UM36kZUYM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPa05XPTcp+S3ut8cupASQbpB8Hu9oK6MxpzawYffr1VQmUB6e
	HkEyiJL2E4tqNJKYh/jGyHwZKG0vGrGgTNYySlZLx+g1sVOS9mNTs1KZ4iUFPVLYAKtWOdXRPpR
	3+5+9nYhlrfuuJUkIViNE+IIkAW2GdP3Atkx6Jw==
X-Google-Smtp-Source: AGHT+IFh1YSNqJrUyWFeYrySj4puHrtEywEG7OT7qiq8/ABi/USrmbl/pgQBx5lmlFIuZUP2a34Q11eyh0jgarstWi0=
X-Received: by 2002:a05:690c:998b:b0:6e3:3508:e32e with SMTP id
 00721157ae682-6eaddfb97a5mr155863057b3.41.1731437047401; Tue, 12 Nov 2024
 10:44:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
In-Reply-To: <20241101-imx-emmc-reset-v3-0-184965eed476@solid-run.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:31 +0100
Message-ID: <CAPDyKFq9uQcDsMpYXKe=8f7AGybZaUsvMVU9RDxv2SZpYwbdgA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] mmc: host: sdhci-esdhc-imx: implement emmc
 hardware reset
To: Josua Mayer <josua@solid-run.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Haibo Chen <haibo.chen@nxp.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Mikhail Anikin <mikhail.anikin@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
	Yazan Shhady <yazan.shhady@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>, imx@lists.linux.dev, 
	linux-mmc@vger.kernel.org, s32@nxp.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 1 Nov 2024 at 12:42, Josua Mayer <josua@solid-run.com> wrote:
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
> Changes in v3:
> - reused existing control register definition from sdhci-esdhc.h
>   (Reported-by: Bough Chen <haibo.chen@nxp.com>)
> - placed both control register mask definitions next to each other
> - fixed timeout write register name
> - Link to v2: https://lore.kernel.org/r/20241030-imx-emmc-reset-v2-0-b3a823393974@solid-run.com
>
> Changes in v2:
> - replaced udelay with usleep_range
>   (Reported-by: Adrian Hunter <adrian.hunter@intel.com>)
> - added comments for delay values
>   (Reported-by: Peng Fan <peng.fan@nxp.com>)
> - delay values based on JEDEC Standard No. 84-B51, 6.15.10 H/W Reset Operation,
>   on page 159
>   (Thanks to Bough Chen <haibo.chen@nxp.com>)
> - added a second patch demonstrating a cosmetic issue revealed by first
>   patch - it bothered me during development but is not important
> - Link to v1: https://lore.kernel.org/r/20241027-imx-emmc-reset-v1-1-d5d0c672864a@solid-run.com
>
> ---
> Josua Mayer (2):
>       mmc: host: sdhci-esdhc-imx: implement emmc hardware reset
>       mmc: host: sdhci-esdhc-imx: update esdhc sysctl dtocv bitmask
>
>  drivers/mmc/host/sdhci-esdhc-imx.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)


The series applied for next, thanks!

Kind regards
Uffe
