Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A140F8F8
	for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007290; cv=pass; b=I8WJdVLV5MzcImOV8gjtYSonafogaoX2tiCXjyMnd3Zu4MpXl9Qs3kX6zgSkJe8ixmqPNQx3lWRxTyVbQ2xybKcW8yhgSY7L1RHjhE8WjyZU8z693vTDwiyl2uUiqkyqGLejhbtkti1rO07tqXpyorto/3jjCplbHW7EeUQuMfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007290; c=relaxed/simple;
	bh=d9/+HUZ65R2g+EYBw6/TaAbQWd9jCDum+Lq3Iz+Frmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIznbwTOZQR/IJM5+ciYqF5Fuz2G5lqfbwi/g9v1guRxit4Tlpv++bbEiK/zEaDoWvn2MJW2ZTA1vUFNySWiKNnAAMpAdby87voh3HFMqSXjQ6Z8WTdkXshBr5FqEBxFFASMJ8eVr/agZlfjbe/lM7BlD9w2BwZntceLVfmbp0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UgK0WrhL; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgK0WrhL"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b6d5bd575so6671128e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 06:54:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007286; cv=none;
        d=google.com; s=arc-20240605;
        b=Zfxd5BFWkl619jT8Ixp8fE97isIdgWgjpjTOi9nnwpHwO5UTr1Al8FAYYjrOndEaHz
         0CuywJmNR/1aI2vNPkSkNxerruIMyPwD3/aIYKYrNBZtkrUdxLZY1INyy8SP8zf6RH1t
         Fsr+Amvinfr+NOFPOmxQ1nEXruFhpGgqEacDAFa8z4F4K+52ODUtXONq/XXY+LUsxewp
         r+YSBM73soFyMK1qnmN07wWlRvRPJ+9X1zOmRVD1/AtMEouE8B/beOWxSnfZ6CtofUTw
         TZmikT3xHYPLbcMvp6ePuyGT5sq56/5FvYhK1EQ4J44A5bzWC52Awu605aTsGsJmSR/S
         o25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X8B8W35ykA0Ke/sM6/szEbMTxBgBNATFdRe1K56rKo4=;
        fh=gonkVEFI9HtQqFgwbXjkgzev2c7KOm54IF/5cXwSfo0=;
        b=HeszYYqRHLVCcemuV4ukxwKLN/eGcJl+2yrJ5HVXuOG2GhCaTVRIzjjEhm42E4WFID
         OtO7rRRov4eMzZDThvG6CPmdgYa9tBlow1Nmo/froV9JR3lxGgGS+51q2Aqr3TvV4l49
         qReKbGPIKPXd48x64zS9jamcTuDxtxvJpmOzFdDGdcZHzBX2hjsZ2k8+XsxhHXU/qTj/
         ZHqUFmBHDr07n/I90hhUQOQ3dYIbD1FgeLTq2QRbNXlEZuwyz9RklirdmOOCdUb9UDs7
         QNGYWwRTv5KDE094wO3kcxXERHu0bFC3HMeAkc0Ds/qrK/+i4sTQXa9H4wlnYgmHT9rW
         bB+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769007286; x=1769612086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8B8W35ykA0Ke/sM6/szEbMTxBgBNATFdRe1K56rKo4=;
        b=UgK0WrhL5vI3CR/TAIe6R4S1+n0HyGWPqdO6H8HQqq4AXM3yspYQafx315w2sArj7P
         YP4k7IchzBbY9MoumW/P1DZYkz5pArtqmXqRLJo1rqNAODmOBPVuQaw8cTplvcHjCdDX
         rzfb+qA2jFlNxDYPdxtKfemISRp2H8DTlVXNV9vVG3AOxdbc0Qcq6plzVEgPJSMVVNtz
         VQwcriw45cie4mQ8x+NyzWFXCXvZx0RA+Ynrg1euxDw5u6d+J1Um0V/Qw3boWNPK43dS
         84hDctLdSn6noh5+9KnuS1Af3wNskmcGUSdq02OdbYIFTaBXxAfuskhGnlyS+aNcjRR4
         oT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007286; x=1769612086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8B8W35ykA0Ke/sM6/szEbMTxBgBNATFdRe1K56rKo4=;
        b=cWDYd+1NaLQ3tnTIccp6SZDIA5dhEIt1dCfqSVPYeuO++gqLR3En41y0T6sLzt0DZ8
         e8DaoNuGWEyLSiq0p1ppqYLDje3iuqG1QENcB6jTBuaN3tO8OBVtvBgk4JwnA/ZkUlBG
         BiAyfXpr4o+0FWG3rHYkPwskGe3HVPCPBVnfARTzMqE0kmWUl+rxVPEGYRfXRkrpRvmk
         mVdf37C8vy4wNaW8e4zpwCNC4KKG6awFnFO2bTtShLQvInyd5KPFqHmgrF+alSyYZz7N
         XohLLthbBPwSHbIdtI226zFrjoPCdKeDt6v/oQ6Q5NAMBPiJCMJ+lGy7HCCY4I2e27Ht
         xgeA==
X-Gm-Message-State: AOJu0YwyKWU+8M9A/+lzkdA++925v2J9Jomyq8YAWgLDnFOvPhL/iKTS
	1CNC4RPJWIToihtUnEMJvwrqvynjwvdb4oP8K/zUJry+CXtHEIxaa8ZgnmYW0caaVzLZcSo7N6d
	aAp9BQn10p+eIpxBOm0wu8tYvQNvkJyEQwONhkvoQrcAuz2YEB5Sy
X-Gm-Gg: AZuq6aJWGb0OdBYxOGr1h9iPspk4w3IAhL0JGizwTpXgyN8nRr94ToI709kLcXnWvYr
	IB0pm7rRieEReAaKhiDKEgT99CnsqMbGU8LBAanEduVIb0fYTkr4Scgw+Qp3y3SQpMjCaopu1GI
	I0oZEga7cizK/FrzvoJErfh5J+FK0QR/bNYfSM1pccHW5w+WZlsUi1rWDkgnoulYvir3Y/4gLLu
	uQ2Hf4wiiB0ve4XYxc0FU0ckxMvMjkPGLT1oAPf4+fA4XLa1GP50iXFiyAjx8kHVF7g0tnD
X-Received: by 2002:a05:6512:2345:b0:598:de1b:40e4 with SMTP id
 2adb3069b0e04-59dc9347cf4mr2229639e87.30.1769007285972; Wed, 21 Jan 2026
 06:54:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251229204526.2850803-1-matthew.schwartz@linux.dev> <220bd61b3ab743b492632764a38f95f0@realtek.com>
In-Reply-To: <220bd61b3ab743b492632764a38f95f0@realtek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 Jan 2026 15:54:10 +0100
X-Gm-Features: AZwV_QiuVMXTmjKSA1dDnDGJMbm5UGpP1nK597PYVUWKcyOlCFTiT_1_WXa1sCE
Message-ID: <CAPDyKFpt_7SgXKEqpGSYYNcdhrNYLsYEKM0N=sG7YeVxVaYzfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx_pci_sdmmc: implement sdmmc_card_busy function
To: Ricky WU <ricky_wu@realtek.com>, Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 at 11:23, Ricky WU <ricky_wu@realtek.com> wrote:
>
> Hi Matthew,
>
> Thanks for working on this patch.
>
> We=E2=80=99ve tested this change on our platforms and can confirm that ad=
ding the
> card_busy() callback does resolve the
> =E2=80=9Ccannot verify signal voltage switch=E2=80=9D issue for us =F0=9F=
=91=8D.
>
> That said, while reviewing the change we noticed a potential redundancy i=
n
> the existing driver logic. In sdmmc_switch_voltage() we already perform
> explicit DAT line stabilization checks via
> sd_wait_voltage_stable_1() and sd_wait_voltage_stable_2().
>
> Once card_busy() is implemented and used by the MMC core during the
> voltage-switch verification phase, these two stabilization steps appear t=
o
> be partially overlapping with what the core now validates via
> card_busy(). In our testing, with card_busy() present, the stable_1 /
> stable_2 logic no longer seems strictly necessary and could likely be
> simplified or removed with some adjustment.
>
> From a process point of view, we=E2=80=99re not sure which approach you=
=E2=80=99d prefer:
>
> Land your patch as-is first, and then we can follow up with a separate
> cleanup/modification patch to adjust sdmmc_switch_voltage(), or
>
> We can prepare an additional patch that builds on top of yours and share
> it with you for review, so the changes can be aligned together.
>
> Please let us know which option you think makes more sense for upstream, =
or
> if you=E2=80=99d prefer a different approach.
>
> Thanks again for the fix and for looking into this driver.
>
> Best regards,
> Ricky
>
> > rtsx_pci_sdmmc does not have an sdmmc_card_busy function, so any voltag=
e
> > switches cause a kernel warning, "mmc0: cannot verify signal voltage sw=
itch."
> >
> > Copy the sdmmc_card_busy function from rtsx_pci_usb to rtsx_pci_sdmmc t=
o
> > fix this.
> >
> > Fixes: ff984e57d36e ("mmc: Add realtek pcie sdmmc host driver")
> > Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>

I have applied this for fixes and by adding a stable tag. I am also
adding Ricky's reviewed/tested-by tag, according to the above.

Let's deal with the potential improvement on-top, as agreed.

Kind regards
Uffe


> > ---
> >  drivers/mmc/host/rtsx_pci_sdmmc.c | 41
> > +++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >
> > diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > index dc2587ff8519..4db3328f46df 100644
> > --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> > +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> > @@ -1306,6 +1306,46 @@ static int sdmmc_switch_voltage(struct mmc_host
> > *mmc, struct mmc_ios *ios)
> >         return err;
> >  }
> >
> > +static int sdmmc_card_busy(struct mmc_host *mmc) {
> > +       struct realtek_pci_sdmmc *host =3D mmc_priv(mmc);
> > +       struct rtsx_pcr *pcr =3D host->pcr;
> > +       int err;
> > +       u8 stat;
> > +       u8 mask =3D SD_DAT3_STATUS | SD_DAT2_STATUS | SD_DAT1_STATUS
> > +       | SD_DAT0_STATUS;
> > +
> > +       mutex_lock(&pcr->pcr_mutex);
> > +
> > +       rtsx_pci_start_run(pcr);
> > +
> > +       err =3D rtsx_pci_write_register(pcr, SD_BUS_STAT,
> > +                                     SD_CLK_TOGGLE_EN |
> > SD_CLK_FORCE_STOP,
> > +                              SD_CLK_TOGGLE_EN);
> > +       if (err)
> > +               goto out;
> > +
> > +       mdelay(1);
> > +
> > +       err =3D rtsx_pci_read_register(pcr, SD_BUS_STAT, &stat);
> > +       if (err)
> > +               goto out;
> > +
> > +       err =3D rtsx_pci_write_register(pcr, SD_BUS_STAT,
> > +                                     SD_CLK_TOGGLE_EN |
> > +SD_CLK_FORCE_STOP, 0);
> > +out:
> > +       mutex_unlock(&pcr->pcr_mutex);
> > +
> > +       if (err)
> > +               return err;
> > +
> > +       /* check if any pin between dat[0:3] is low */
> > +       if ((stat & mask) !=3D mask)
> > +               return 1;
> > +       else
> > +               return 0;
> > +}
> > +
> >  static int sdmmc_execute_tuning(struct mmc_host *mmc, u32 opcode)  {
> >         struct realtek_pci_sdmmc *host =3D mmc_priv(mmc); @@ -1418,6
> > +1458,7 @@ static const struct mmc_host_ops realtek_pci_sdmmc_ops =3D {
> >         .get_ro =3D sdmmc_get_ro,
> >         .get_cd =3D sdmmc_get_cd,
> >         .start_signal_voltage_switch =3D sdmmc_switch_voltage,
> > +       .card_busy =3D sdmmc_card_busy,
> >         .execute_tuning =3D sdmmc_execute_tuning,
> >         .init_sd_express =3D sdmmc_init_sd_express,  };
> > --
> > 2.52.0
>
