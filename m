Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0BBA49;
	Thu,  5 Jun 2025 03:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749092624; cv=none; b=I55Ri6vcXDz2IyZrBEbQ4FZRauPdgVHWXVChV6wneIfiGTQKVdU3heqNgvfj2spzpJ2YNl0BB5iGN99+5J5cByUPIWnYhhDb+czCpZ1voi0ok9Mwn+R7GUmBiTuJpuZcO+TCosgvLtotQhLZbv8ACzbG6n8NQ9LyqhuAnMf05rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749092624; c=relaxed/simple;
	bh=7khZwdE7hBbUhIpRjfQLJdOyp+TlX1pmOvgRjH9YJXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjoD5rXO/yGJbNWl639sSaIVci2BQiM2uiDNzvDD1p/DkYzizmGJLGT7siU3NTXdSdWiLvQHZGrQ13DN3tjZG2OIGXYeaGrkUJa4eFuKkuOiQvMwaMf89+Havso1jcFOBNNchDHspREP8jkrp44sCwpu/XgEfwGleHb3fQfr0ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWqVHvnZ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWqVHvnZ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-60707b740a6so614755a12.0;
        Wed, 04 Jun 2025 20:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749092621; x=1749697421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voKhAbgrcXm8mkXGW8nWXWOPo8BU4qMPnZBEd4pfud0=;
        b=mWqVHvnZ8Y5427F2v8/wNIYQVa4cUd5vkQewkhKWA0Vbv3YmI7vqqB2mrdFUKSXmZq
         cLBLii22jZ0eidm9ruc7ynKzQ00LVCqWaNtJOxbk2+giKDDhMf1OV5fZdGuXkc+7Ehof
         L3OrcZNO5CvAM+pPmeexbyYaLkt58QbY8qvTDgZwX4rUHwFG9ADfaXldUNKneKkY03fi
         UXQLuMQU+xxGbnoIg69xkYdKH4Qz4sQI7ba1Rq6kQDcjExO1HHpH+EaC04oMaDv+De1T
         WeCYl61floPIZvGz4+siHU83l/VhT0CPggErOFeQkuD5EGT3yMYLa6TnSePq9RIVEhHD
         XskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749092621; x=1749697421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voKhAbgrcXm8mkXGW8nWXWOPo8BU4qMPnZBEd4pfud0=;
        b=c16F+TPMTlyVdT92va5DdjJMB2nILXsyVqGNLxD5G42PYqQ4/rXeGBgiEsuJ4Jan69
         3W2oJt13rWM9LApSL3j1VFmikuDFnKeVB3Mt/shhNi3zh1x3Wme24Qu1BwlY/oSjIEEs
         BXj56nh17Uk/QhKEjq6iTtnDTYRJH0HblFjQgdR4okQ5nvo7CkUBcHF5fAxVv+M4G8cu
         hUe0aPnTcsm0TpnxZ0TZ+mFG//YCAmQRfb6jSDXmMFvLrPueuuK6RgnozwXlVTpNsPEK
         a2r1Y1XDsvYi1vaz62uXQ9Ct4zeFEgzd/ukcUyzgIraGPl2YPak+AA+vPO+Y+eYPkS73
         yq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8CaEtJ4fVqDTTYvNqlM1bRTutp8yy3LGNmhsRFF7mtIQn/DwkpIhuHCm1/CCDRzRGxR9DjwAJj0n@vger.kernel.org, AJvYcCVp3QhH1umTtQHMnrvOXnszouoL8WeJbW8ceL/7WFJBBK2WrLjWFBKXqzk7ZZ3hzPG7nMug9LUqc15Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwfDC0Sm6JTRQDirSuVVZDrsruS7ka/cSPuN3EEavf1xi/O5K3f
	UTCLMJKn2lbV4XiBQMcLrMZPgdIin2OONgVF85Ka9hTKWh96NH7Q9dCWQu9XyspHCtRUfF4SUlw
	VwpycK7sWR/qLmFsrMBsbRRXohxxZ8p9XmK08
X-Gm-Gg: ASbGncvBusI0FvN6+3wyU9F4mzMaN3B/p42wKm3uL/3qnwUjfJ7VIu+Grp9VE3tHFYB
	9g31VZMwURh7qXx938ql7CxSH2AkARvth6ynehC+SmtleZHsrZTHzOMHZGFOjiho8UrpoaVywi4
	NlzBOYi0cbr9b8gcmxW3+46nZJiLq0zP5P
X-Google-Smtp-Source: AGHT+IFOO6StkM0IAqHmVPeC0pasgrjZRt18m8ZM47Xa2afLr6FMLU95O24gk0y2c263N5XAsUJyVEaAEAeaPIVk7As=
X-Received: by 2002:a17:907:6d28:b0:adb:449c:7621 with SMTP id
 a640c23a62f3a-addf8e7ea4cmr540699366b.29.1749092621041; Wed, 04 Jun 2025
 20:03:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1746581751.git.zhoubinbin@loongson.cn> <1308b6ca9ffc2674cc0f089cfd163da87e53a8cd.1746581751.git.zhoubinbin@loongson.cn>
 <CAPDyKFouNpdnQSXBxRmKhECyojrT_TkCpgg01GHbzQpuYFvEZg@mail.gmail.com>
In-Reply-To: <CAPDyKFouNpdnQSXBxRmKhECyojrT_TkCpgg01GHbzQpuYFvEZg@mail.gmail.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Thu, 5 Jun 2025 11:03:28 +0800
X-Gm-Features: AX0GCFsyTcAFRf1n8zcXVDtGZMbNr_eXrzE1FjqIUCdZXqVP92KbfJ9GX93iKyg
Message-ID: <CAMpQs4KQHHiJZFXhz2hgxv6qMA+CCEqQpZkug2JL35FBj+iEYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] mmc: loongson2: Add Loongson-2K SD/SDIO controller driver
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf:

Sorry for the late reply.

On Mon, May 19, 2025 at 7:03=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 7 May 2025 at 09:28, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
> >
> > The MMC controllers on the Loongson-2K series CPUs are similar,
> > except for the interface characteristics and the use of DMA controllers=
.
> >
> > This patch describes the MMC controllers on the Loongson-2K0500/2K1000,
> > with the distinguishing feature being the use of an externally shared
> > APBDMA engine.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
>
> [...]
>
> > +
> > +static void loongson2_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios=
 *ios)
> > +{
> > +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
>
> As we now have support for regulators, we should use them here too.
>
> Some something along the lines of this at MMC_POWER_OFF:
> if (!IS_ERR(mmc->supply.vmmc))
>       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
>
> and at MMC_POWER_UP:
> if (!IS_ERR(mmc->supply.vmmc))
>       mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
>
> > +
> > +       switch (ios->power_mode) {
> > +       case MMC_POWER_ON:
>
> Is the fallthrough really what we want here?
>
> MMC_POWER_ON is used quite frequently when changing various ios
> settings when the core calls mmc_set_ios(). MMC_POWER_UP is set only
> once in mmc_power_up().

Indeed, this has been handled too roughly here. I will try to
subdivide each case and add regulator support.
>
> > +       case MMC_POWER_UP:
> > +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONG=
SON2_MMC_CTL_RESET);
> > +               mdelay(10);
> > +               regmap_write(host->regmap, LOONGSON2_MMC_REG_CTL, LOONG=
SON2_MMC_CTL_EXTCLK);
> > +               regmap_write(host->regmap, LOONGSON2_MMC_REG_INT, LOONG=
SON2_MMC_IEN_ALL);
> > +               regmap_write(host->regmap, LOONGSON2_MMC_REG_IEN, LOONG=
SON2_MMC_INT_CLEAR);
> > +               break;
> > +       case MMC_POWER_OFF:
> > +               regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_CTL,
> > +                                  LOONGSON2_MMC_CTL_RESET, LOONGSON2_M=
MC_CTL_RESET);
> > +               return;
> > +       default:
> > +               return;
> > +       }
> > +
> > +       loongson2_mmc_set_clk(host, ios);
> > +
> > +       host->bus_width =3D ios->bus_width;
> > +}
> > +
>
> [...]
>
> > +
> > +static void loongson2_mmc_enable_sdio_irq(struct mmc_host *mmc, int en=
able)
> > +{
> > +       struct loongson2_mmc_host *host =3D mmc_priv(mmc);
> > +
> > +       regmap_update_bits(host->regmap, LOONGSON2_MMC_REG_IEN,
> > +                          LOONGSON2_MMC_INT_SDIOIRQ, enable);
> > +}
> > +
> > +static struct mmc_host_ops loongson2_mmc_ops =3D {
> > +       .request        =3D loongson2_mmc_request,
> > +       .set_ios        =3D loongson2_mmc_set_ios,
> > +       .get_ro         =3D mmc_gpio_get_ro,
> > +       .get_cd         =3D mmc_gpio_get_cd,
> > +       .enable_sdio_irq =3D loongson2_mmc_enable_sdio_irq,
>
> The ->ack_sdio_irq() callback needs to be implemented too.
>
> Moreover we need to set MMC_CAP2_SDIO_IRQ_NOTHREAD.

OK..
>
> [...]
>
> Kind regards
> Uffe



--=20
Thanks.
Binbin
