Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A226F443
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765288091; cv=none; b=mLmba+EUO8Bb83AD/7YhyyoDTp0cgv5u2c050KSlJkjX6M/Nxgn3LcdCMeMhfvB/VJxrWQDCceuE+sZRyhic57ijDaRyt0mZ2YA/HF0zvIdkA1rY+0XEbulEwvsvXtnLUhx5uJCNHWM/w32hpmaxZO4Oxioi+MbiPIwmGAm0Rek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765288091; c=relaxed/simple;
	bh=J7R1jg7yHqWsHV4j0LSnzaT5xQsAlw72hWeQeos/AbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCv89VlWkdbyAHlpw6wme3yXXZlHSxSwelnjG8/0VQlCg1/9Bng9BgUyma/W9vS9Iio23C9X4AiMaI7j9nmS5dcqro1AqjYHggWqLc+dCyy0ZMxYtPXC4PdfltTxm1QiDmEENCxqgmNHntnunZD+LdZTLvY7A0z3N/E8Ne5TSlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q0VnmOqv; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q0VnmOqv"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-78c6277df86so4448417b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 09 Dec 2025 05:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765288087; x=1765892887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLZGxZfGPH+m9Hz1QW1ANR0vUG8mNwWWC1iVjfNrwBw=;
        b=q0VnmOqv8qso07Erw07oGhydCfLaatmh8+vpWxIlgwI8WqXvD/R+EK1HRIRlbnoakO
         y5gTYitaDLPX6rsUurJXj7ufLURddDjivkVeTjMNmItLXLMBmCkmrYiksATx9a2sCxQE
         Z8MrD2uFlfaknCxzjshSiwMDegafvCHMGqBG1P4Z7NHQr6/gGUAO2lmfGmQAF6N35M0b
         t+A8giMPzUiZ2/sqG/2IYE1O337ewqhDQANSHREHOfos10/GRoNbNStjTAq7FCAdrq9u
         Y2m2p66BCQS0OBVirwuttkbfdSvFQyOCQdnSJFwQmtiM2DjNBUNKgb4L8d+9Py+fur/X
         I2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765288087; x=1765892887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PLZGxZfGPH+m9Hz1QW1ANR0vUG8mNwWWC1iVjfNrwBw=;
        b=VxuxjPfn2ywRZ6Vk/Sq8ELs0Tvn6V0JJsN9uv72zXiaH6SfO0lycRa6VLfRU7+S5C/
         TIPSIafYuGT17wCY1w8pKK+3+qXHzk6fPcDYBbL2vfnH75Cuk2kOZZo4mErjcYrEaceP
         9xnupXYUUlJGGOjHg/RkWoTk+x4rpC4fpmqk5ScdkzYnDW59ux+NL2bCJAX11Zf5WlR7
         y+RGSA2lgj6QViNw6ZPkPhfs1TMk8SomiA8I5yAgGSfgRNYz6juD2XQwk5FNh3ZLzVQ7
         /qtDys9AxHvXt1tCCVkoGrJb6wcY+1hizemJmodhf7AHchXAFIX52jg13elEpgTHTM3h
         c6Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXPB2tSGycARE0YvDTCrZYVvA8ZVTOuiC9mil2TUKaOCok+H962AlTUkDyarWL34bYircFdIKxrEKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ICFuKesOUjnZP2FuVZHOhGaJqZrn5RVS0t7fsCsBgpi4/eHD
	1X3T/Ux4cxlASyaI+TU0y8hVvBK1/Z1sObV99dbzNrH4fU3QK9rTJKmlRcbn8KedfDD5G1UWzcN
	B+YLuZSJZPfIVLuNplAe50Lu9/fTyHuSHgloD7XlGRQ==
X-Gm-Gg: AY/fxX79wrrGuz2Bka3halMwRv2HQEKUknNSVwzI77vKJ8RkUFK7dYgIjFyWJ7IRwSL
	vnXfDFyYiz48Zk46B2+aS+VpBfGNdtG5C0EL/ARnS6gzJXkvCsqJjlB1enTLbvMZ0zSvw+c4rKb
	qoLvSUugIRYUicIuESNnE5gxiNaYbDxQrvASSoRwKiytu2gE0HjtEaXVfoZX7oM5Zb2D01eWcxs
	sVUQgku4jevt90qV0EypDgMRNU0e06CLzg7Io7JOF2CE7rksozESY4XMlNJdspMKNRpxQHC
X-Google-Smtp-Source: AGHT+IEhUYw77OAuRxBe3uwIoYgLrjRR2ua77WK+8dBaIDSS/4dMnfDxmkWH5Vf8ObUVvDYmN/ivRcBPoD/iRYvRkdY=
X-Received: by 2002:a05:690c:6307:b0:786:4fd5:e5cb with SMTP id
 00721157ae682-78c33c019bbmr104464077b3.35.1765288087582; Tue, 09 Dec 2025
 05:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205071729.83857-1-ziniu.wang_1@nxp.com> <DU0PR04MB94962D103B1A92354CDD1FE690A7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94962D103B1A92354CDD1FE690A7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Dec 2025 14:47:30 +0100
X-Gm-Features: AQt7F2oaS3uBiOmr3kjDFYVzcu04ROd5j3j8IYFRAzYsQq--q0dUbLCTRNsuSTc
Message-ID: <CAPDyKFpYU3PZs-dSREyGyyyoptY0zCQmHP+mxMMgvYQL-xXQZA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer
 completion before reset
To: Bough Chen <haibo.chen@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>
Cc: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, 
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, dl-S32 <S32@nxp.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Dec 2025 at 09:12, Bough Chen <haibo.chen@nxp.com> wrote:
>
> > -----Original Message-----
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> > Sent: 2025=E5=B9=B412=E6=9C=885=E6=97=A5 15:17
> > To: adrian.hunter@intel.com; Bough Chen <haibo.chen@nxp.com>;
> > ulf.hansson@linaro.org
> > Cc: shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; linux-mmc@vger.kernel.org; imx@lists.linux.dev; dl-=
S32
> > <S32@nxp.com>; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Subject: [PATCH v2] mmc: sdhci-esdhc-imx: wait for data transfer comple=
tion
> > before reset
> >
> > From: Luke Wang <ziniu.wang_1@nxp.com>
> >
> > On IMX7ULP platforms, certain SD cards (e.g. Kingston Canvas Go! Plus) =
cause
> > system hangs and reboots during manual tuning. These cards exhibit larg=
e gaps
> > (~16us) between tuning command response and data transmission.
> > When cmd CRC errors occur during tuning, the code assumes data errors e=
ven
> > tuning data hasn't been fully received and then reset host data circuit=
.
> >
> > Per IMX7ULP reference manual, reset operations (RESET_DATA/ALL) need to
> > make sure no active data transfers. Previously, resetting while data wa=
s in-flight
> > would clear data circuit, including ADMA/SDMA address, causing data to =
be
> > transmitted to incorrect memory address. This patch adds polling for da=
ta
> > transfer completion before executing resets.
> >
> > Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> > ---
> > v2: amend commit message
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index a7a5df673b0f..affde1936510 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1453,6 +1453,21 @@ static void esdhc_set_uhs_signaling(struct
> > sdhci_host *host, unsigned timing)
> >
> >  static void esdhc_reset(struct sdhci_host *host, u8 mask)  {
> > +     u32 present_state;
> > +     int ret;
> > +
> > +     /*
> > +      * For data or full reset, ensure any active data transfer comple=
tes
> > +      * before resetting to avoid system hang.
> > +      */
> > +     if (mask & (SDHCI_RESET_DATA | SDHCI_RESET_ALL)) {
> > +             ret =3D readl_poll_timeout_atomic(host->ioaddr + ESDHC_PR=
SSTAT,
> > present_state,
>
> I'm okay with the patch, but I find one thing here:
>
> I notice you use _atomic here, I guess you want to cover the case when th=
e reset function is called in hardware irq handler sdhci_irq().
> I'm not sure whether it is suitable to add delay in hardware iqr handler,=
 I find there is also udelay in sdhci_reset(), sdhci_reset can also be call=
ed in hardware irq handler when there is cmd_crc/data_crc error.
> Adrian/Ulf, do you notice this issue before? Any comments?

You are right. In general it's certainly not preferred to poll/delay
in an atomic context. But if I understand correctly here, polling in
atomic context should not happen that frequently, right?

Moreover, I wonder if we really need to have a polling-timeout of
100ms? Where did that value come from?

In any case, please add a define to specify the timeout and make sure
the define-name has the suffix corresponding to the unit (_US,
_MS,...)

>
> Regards
> Haibo Chen
>
>
> > +                                             !(present_state & SDHCI_D=
ATA_INHIBIT), 2,
> > 100000);
> > +             if (ret =3D=3D -ETIMEDOUT)
> > +                     dev_warn(mmc_dev(host->mmc),
> > +                              "timeout waiting for data transfer compl=
etion\n");
> > +     }
> > +
> >       sdhci_and_cqhci_reset(host, mask);
> >
> >       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> > --
> > 2.34.1
>

Kind regards
Uffe
