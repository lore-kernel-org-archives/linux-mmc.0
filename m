Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5203F787A
	for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952640; cv=pass; b=FU9VmCydfOgQqD4B0X512fyYQ5d3yxlHmgrd5f/eJcmbCLwY+KJegJ0+5ixPZYOkFKwP5fc4SWoebKzQ/20bUXRs4BkLPgCF9QIS8k1wlLVXky1LI5e3A73xuzDMN76ZMouFyJy1z9DElG/rNImSYrR1CxNZw5axbxqev9GLbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952640; c=relaxed/simple;
	bh=OKcQF1kpAs1PMLQtJxV4BxsdutnEF0dS5maqemA1Tzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R65stGdN6nIv04R3MRMW9e4j71b3wM6/OqTYAlRhTz3IFncxTwHjtEdS8QA60le17aaD76wWeXb7hr6lQ1rUmREhLT5RoocH6fPeXtfSsT68ozIzjMPWsr54q8lLTMGhDkc5XTOgy3AbCkSMIlYyHYOfw/0ln29OwXsE6X8hoM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETh7kP8X; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETh7kP8X"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a4118c4f7so10617591fa.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Mar 2026 13:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773952636; cv=none;
        d=google.com; s=arc-20240605;
        b=WwN9vmRfSbuBL8nmf6w8IQux+qoAKVUHiYp2STje62m8IOHX49xQpgCclvorjHlspT
         gbtvlPPEciDQz/nca5NdoYrCSGTuAGtRbDVj/sEfFdOtXCL+jh7AzzhY/vycpl9nyFEN
         by7DxYwkgZxtRZ7d1/D5J5KhuVCdZLKGXxhMxAj3BA/GESQjp5CS3nOCGtmLpnUb3zoe
         ZaAuXTVRIaUkcfl8x1BRmoDfesjn6fWdtkeLuItXcs9Xo2+AYdTq07ORAmwPcyRZ8EpV
         yNP8BDZl9RynuBzPJD1a2pFm74IqlT245JStyd6as+Ybgm2gQ8h4yY7AqERVrmaUopqp
         ppiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4jm2MmqwJpQn+S058TYQTUmQvMQC9Tb/3vBRI4X0gPQ=;
        fh=oqhe7HduweOzhxpiVtAZCWKFr9jNG6gxCoiBaE67cwY=;
        b=NNlrWBzEyXaNrO87KibXbO4o4NAI72V5Sbcx/+s9ynX+LinHtRXqiIx0rjzVfqIcu/
         IDO2kvXL7bodRROJqAskpJEaXU+w8Tf1j1Cw3tVoOn8HJF31lJh6Liqvj0jAKVyXoMrj
         0WESKpD9lGOdCT3DtUUmIOsahivo8B3s9dtflPhz/cCoITl/D19ivxwd97ekQLei8yv7
         NQJFR6/KZk2GvOc61BWmJCVSDDosCbWtjfNU2hSFTk7hHsvWMGGwqxp68J7aDrhfZ4Bu
         Csxtz+FoBUComAehRDWIoYyWw1C5gVYai3+ihQKYMgSpSrdSEmRtLo/Vj8nNOFxQ0fLR
         jbCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773952636; x=1774557436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4jm2MmqwJpQn+S058TYQTUmQvMQC9Tb/3vBRI4X0gPQ=;
        b=ETh7kP8X+27TvzMqy/eHisKhzvYw2ZjLW+Ov7EXkrkAAyMfvueQnapF5ckjoIbZVW+
         cfMoGbpB3USxxBvJAlvJVZy8fPZz+nOO68til0z+M6b7B8M0XNHule0bqDMM9FL5nrXx
         XjHrhemV/rkNlfLMrSee8xpInBuriNfzppV1HF6asSLDSIIBOp/naJvE/TmMnMFRxNkt
         XmSnQUhOIBIK+yRzDZ0RK11MgN4RaEPC4z1+5DOtvtNU53FFcXZokiFF9wlFsiHO1UZ9
         iWX9Swk9yWL6t3C75iR6rK9ldvvQu4t3HJQT8oRgl083yLrrZe0ffOkT1p1A6DfZaEMM
         8dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773952636; x=1774557436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4jm2MmqwJpQn+S058TYQTUmQvMQC9Tb/3vBRI4X0gPQ=;
        b=rbKEnPJiqIRbRu7fxS8qbMLI4zP/naST0+PtHZfoL1q1YS+yeEnZYjLxR5riDVxGfD
         lK+lVRzsNSa9wiuS383yTHEcqwObdcC7e4+8wso+xD4eiD/ybs8he8v/VcvC1vSpYU8B
         p4FH2MUoIZ7+op+4JIf1T2SQW68VeSVu/gnmhkhURWxBIvktRwatlAj79pDVpvAWBu+z
         AyzRH65cE1DjkR42QtVqvucXpXQ/ym5XDbEpqQ7NhcUrTOs0ie9uhHrNart/PLu82wMb
         SB5vBUFcJqWUUv9qf2Mlj5ze9znxU+8rPORaYDGh6DQrjHYsBVqIHXhy3lIRBuNvO8jE
         UHVg==
X-Forwarded-Encrypted: i=1; AJvYcCX7lbRuB6KgTahz0tk+3xA5Fxo5WQXDrqAD1402p8PNGnQsjljZvr662y/5SQLVL61Od6DXDXXDuSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YycO+n74tohkvcp18QrfW6nb3mYwM1lWV8iiDfecrvzAgH6dVcA
	Lf/aw0rkgI+q+1f6eGeVes2ohULLYCBJoGpRuk0UFEugMUYwQfqIVtUmzg1dXwwNt4pMGhouJaY
	1GRSRCBDUd8xOT+VzisJtWjfRJ0fEhpU=
X-Gm-Gg: ATEYQzwXmZj+fIUgKkxJBsl8Kxl6nEAkYZAPUYTK/XQDSAj5D5HL6I36KymKn9r52rs
	BYkC9xyJggMxC/OnAs1DJ5dzVynd2t6zp7GY9zwG4TOxwm+aQUmS2qlGV0Whq0Dv+p1wUSvY1yV
	0lZNjNqUe9xtZ8imH9a3yU0LyUZh+eqxsaIp9Up2GOE0WA6JsPO1i+KjAD8cJeZT5giMlIrZsJz
	bHFjaA2zOLlbcH4/lryOxoQzAZ7VIkX+zN3chWVYtFVaU/DqiFx+3sGGAkzNc4H957DP+nk81Do
	W0YdHfub4GHCZB/9HubMoGbaiiD37jF5A5c4vQ9J8KCikxnLr1BcI+hjWM3hYFsrbn6UMT5R
X-Received: by 2002:a2e:3215:0:b0:383:18fb:fdf0 with SMTP id
 38308e7fff4ca-38bf96ee31amr2254101fa.22.1773952635602; Thu, 19 Mar 2026
 13:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319200945.23333-1-adriangarciacasado42@gmail.com>
In-Reply-To: <20260319200945.23333-1-adriangarciacasado42@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 19 Mar 2026 17:37:04 -0300
X-Gm-Features: AaiRm50-FVCrW5uqx_caj9h1BrDi-gvkU_nz1UeamW4uIfef2gzzYIjKPKykSOA
Message-ID: <CAOMZO5DcaucpKj2=gO5kP3vd=f==ydzB+3FbGB4Jwg19Vi8fpg@mail.gmail.com>
Subject: Re: [PATCH v8 3/3] mmc: sdhci-esdhc-imx: remove redundant mx25
 handling and consolidate soc data
To: =?UTF-8?Q?Adri=C3=A1n_Garc=C3=ADa_Casado?= <adriangarciacasado42@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Haibo Chen <haibo.chen@nxp.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 5:10=E2=80=AFPM Adri=C3=A1n Garc=C3=ADa Casado
<adriangarciacasado42@gmail.com> wrote:

> @@ -873,11 +865,8 @@ static void esdhc_writeb_le(struct sdhci_host *host,=
 u8 val, int reg)
>                 new_val =3D val & SDHCI_CTRL_LED;
>                 /* ensure the endianness */
>                 new_val |=3D ESDHC_HOST_CONTROL_LE;
> -               /* bits 8&9 are reserved on mx25 */
> -               if (!is_imx25_esdhc(imx_data)) {
> -                       /* DMA mode bits are shifted */
> -                       new_val |=3D (val & SDHCI_CTRL_DMA_MASK) << 5;
> -               }

This removal of the i.MX25 check does not look correct.
