Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11E8237707
	for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2026 18:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612270; cv=none; b=WCyy420B3NONXKBfEkWVkbCiff6pBuQ0SlqTViONRDr1RI3uePyo4VJONMgr7t3hjyL6h2J5rZVZGjb91zIm6Py2uwU8lSzW0HJA0nm1Ds5DIyDCX+2rSDUQGouRw91XGvQznBX5xEYXSkGntcQbQ94irL0SxigCi8wpR8trGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612270; c=relaxed/simple;
	bh=jtxdnsFoaJ7ZZ3Cqn+tSp7m5G53dJk4cSH6H7At3v18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kp+rtEdgDOEtbWG7SCBtv4TW0TrfNUrlv9mj/mYcyfGxxatKWUIFc1dOjdF5G4MffLKPRWa7FJ/Z28d1jL1YfwrFGH3NQCTBO3sX/jIVXPlvhMUV/l/e8R5CnKVhZeBc94DAfKXuU97NROSZIyyhMnX4H85XzsmGrA9YJjueW50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6uJkrPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6uJkrPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32876C19425
	for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2026 18:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771612270;
	bh=jtxdnsFoaJ7ZZ3Cqn+tSp7m5G53dJk4cSH6H7At3v18=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=a6uJkrPwgYJUifSyCTS6qLRblT3UuP8pQhDCmNAd2ogqq5vgBEsHwq8dslg95Fr1M
	 QE1qEwpPqLbgGyGBKdPG/vP4VNWVDlhs9IYK06sSbep9fCo3MBIK+S5fNuzsKmGmWL
	 h2/G71sxc2mVMfFqbdMY7IclfV225a4CVo51pykG11YGDk2h68oBqoWRHwrOTXN+eB
	 HsbrO5uBlRdRKmL/zJwkT1bbPqJYSawCm7Zz78cgYbavZ+KUnACdpmbZj5IO+i0aRE
	 XNBFYKoaXBvfdKZOJURklibqI4NNg3hc/C/o8ekrxP3QxYh6KF4Kdav65dJaAoaVfg
	 nEz+gA8l7HzDQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59de2d1fc2cso2777979e87.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2026 10:31:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWbhRCV71OvUEteN8SBihpdbIv8hQa5P3M4IcT9NnbBSCNFXO8HxSmQM+e1D+5qnHCUmTdy+zWOalg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV0l5zJLUa6rbEu1E/EbVB66O8Im+afyDXDd7OUzZCvuMEswUG
	MUZfF4Ft8ZYzzjjRuEgHZIEzXpU+I9Vu+VsOpnqNQV28GbLnPXSvWgEXbaLMlaqFhGsT9xY0DzC
	31T08KFJ1Q08/n3gtfZZm5YpPC14sbt0=
X-Received: by 2002:ac2:4f0d:0:b0:59d:f2a4:3e98 with SMTP id
 2adb3069b0e04-5a0ed88d733mr123595e87.4.1771612268567; Fri, 20 Feb 2026
 10:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219231624.8226-1-sean.wang@kernel.org> <0cb6c45b-a5a4-46bf-a73d-97c482da9339@molgen.mpg.de>
In-Reply-To: <0cb6c45b-a5a4-46bf-a73d-97c482da9339@molgen.mpg.de>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 20 Feb 2026 12:30:56 -0600
X-Gmail-Original-Message-ID: <CAGp9LzqYB=xPfAuL61xi-ve=f6PZWWaa2gpf50-75yXWee-ZHA@mail.gmail.com>
X-Gm-Features: AaiRm50CGzZAUpdHBs8DARRVcPhWLB2FVeLnVfyzVg436zGF1NWQ8dHO4F1lG6w
Message-ID: <CAGp9LzqYB=xPfAuL61xi-ve=f6PZWWaa2gpf50-75yXWee-ZHA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, ulf.hansson@linaro.org, 
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-mmc@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Paul,

On Thu, Feb 19, 2026 at 5:28=E2=80=AFPM Paul Menzel <pmenzel@molgen.mpg.de>=
 wrote:
>
> Dear Sean,
>
>
> Thank you for the patch.
>
> Am 20.02.26 um 00:16 schrieb Sean Wang:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.
>
> Tested how?

Tested on real hardware with successful card detection, driver
initialization and the connectivity.

>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >   include/linux/mmc/sdio_ids.h | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.=
h
> > index 673cbdf43453..97cc834fb3d5 100644
> > --- a/include/linux/mmc/sdio_ids.h
> > +++ b/include/linux/mmc/sdio_ids.h
> > @@ -112,6 +112,7 @@
> >   #define SDIO_DEVICE_ID_MEDIATEK_MT7663              0x7663
> >   #define SDIO_DEVICE_ID_MEDIATEK_MT7668              0x7668
> >   #define SDIO_DEVICE_ID_MEDIATEK_MT7961              0x7961
> > +#define SDIO_DEVICE_ID_MEDIATEK_MT7902               0x790a
>
> Please sort it.

I will address the sorting in v2.
Thanks for the review.

>
> >
> >   #define SDIO_VENDOR_ID_MICROCHIP_WILC               0x0296
> >   #define SDIO_DEVICE_ID_MICROCHIP_WILC1000   0x5347
>
>
> Kind regards,
>
> Paul
