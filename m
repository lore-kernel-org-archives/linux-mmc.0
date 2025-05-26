Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4928DD0
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748242028; cv=none; b=ue/tSMZz9q0Z28FZn5a73X4ERNTnrF0S2A0d3RqW8gMLUhLoiz5qzbvxupcW+DzEp1VhBH0Joh3pxCabnXyAhmPKyqQhaGwe2xrzwOwe0IrZ4GQ6GfANdge36y9NzQAgDsA6UByIqrQYLLqhpM7aU3VtNKuyO/exQkXgMwmwzuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748242028; c=relaxed/simple;
	bh=ahWGiknWQUGYC530YYqtj0dJN+HlCItsjmks+RzQa0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjNKxsRxrDiRJTwV+Mogxd/YjvVojVFodkor+1yFBUxWpc84wFt+IwIRoocGhrBCPNA7rfnnK2nDvy5R4hFIImlN0I+X2pkCabgHqRkhva+o1K1Fo1bPxLDn7kgWUGfH/HCRJ5G4MLzrxF4lqyzlqpbrLz7ZTdraUkol5Qc0TiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYISZ6W6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYISZ6W6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad56e993ae9so369919666b.3
        for <linux-mmc@vger.kernel.org>; Sun, 25 May 2025 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748242024; x=1748846824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QR+5A8DwRtOVG/Acq21JmByfASzia+vDA+z5MvCzirU=;
        b=EYISZ6W6mnDmyqqeTpazLf8ZprjreD/IMC0w7BO9JNS+CKknFYcukQg5SI3nLDka13
         gmB4EqRLelv+miEHQB9qqcVPCMnhx2PggagAEnaSDY2TojV354wa9X/a6osh7fcbI4ya
         O8bGpMVOQW1AKWuRE/cUd5Zud+vUfnSABKaaZjAhMD4dMxPsVkjiCxZkLUdX2PoBhFef
         qTknLfkTWyGcl0wSf4STz5JqSIYcz1EtNxnCUZow+Iha7XllV7sSfiIKq6SusW/cono2
         HzECdImCgvzz6m0SGCGDf/fIHZRR8xC881rKpu5cuj+UHrRwh6WZxdYYNHzI2vkotQDV
         T0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748242024; x=1748846824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QR+5A8DwRtOVG/Acq21JmByfASzia+vDA+z5MvCzirU=;
        b=beqUh6hVOFLjdBQtwyR1SMuDtJNQixe4hZS3GMit18nkDSv8bSphuuVbMhjP1NtdZd
         sHaNnvY6mKhMtpiQ2d8uVsnRFB/KFdd2AT99WVu/1E+8x+WVrlOBNhs9hcOrno+7cfmp
         dksuhMkzYgAY52ysjAJGZv/CnMmmEIVsMWHxG49VfQhkCiJiZICniw+jBXgIJzT52XSq
         ZXCwPj3aEYy2d4f45I4sA6y9UHZRr4Ltyn7YfYQiGAEv5DbVpWqfV79jbD47aF4B3k3D
         t4Gm3PBUvsQFZxGHaQTruPlNEjj3JiaHI0n9R3Ys6i/Pu1qHG/Q0xcTcdBHJkdKsQBhw
         cCrA==
X-Forwarded-Encrypted: i=1; AJvYcCUo5gsRBC91etS4pBJwTc+o19B84GnYRaXAlORalGNFwFphlMnhueCzfghgcF9ZAERQG4YiZmYLHDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PBqhqbEPuDd+/TLzCMQ4mJJd8QqsHvwt6x5KgFfDIkvJP+PL
	ywZ8K7IxeF7bQo1WXENk3FK6ah6eFY94jxhSoln2Rt8Wn8zFRD/vfSJZZtFdvdAnPANedSiMLKV
	fhn/G2AnxTkID5WJvktZNpLufDXdnmDRaT79F1D8=
X-Gm-Gg: ASbGncumaUOZEnEeTtHT9iceqSqxLcIGJSeU8hUe8jkqSKchmp/Xyy3GO2+aTva0MIA
	iC83yn6sxHEcsea8d2Zs967KCvL9IxRsfhblVvYcgqnLC0AEL19PgvuEMebzPYzpS48tZvLndW8
	POV6QEAA289MnkmNtRlzIXvCK6ehA0gN2P
X-Google-Smtp-Source: AGHT+IG89c8X14Q5uCFA3SsE1vgGeUJYhEvMlgnmUUdCJqT0kruTA/epE3yyC/lSOygbC9W/L2av3LqUJLIj+r6e0FA=
X-Received: by 2002:a17:907:3d09:b0:ad2:4fb7:6cd7 with SMTP id
 a640c23a62f3a-ad85b00c695mr759671666b.2.1748242024365; Sun, 25 May 2025
 23:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747792905.git.zhoubinbin@loongson.cn> <6fd5afb003982bb5edbf95f76b605686223730e0.1747792905.git.zhoubinbin@loongson.cn>
 <78ffbae6-1c75-46ac-a5d7-bbc07bca1fd0@intel.com>
In-Reply-To: <78ffbae6-1c75-46ac-a5d7-bbc07bca1fd0@intel.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 26 May 2025 14:46:51 +0800
X-Gm-Features: AX0GCFuJKWhutAVTgMafspWxpReZhTBBFfsM3M0_8SGps5dPDfAHQLWlKQftEHE
Message-ID: <CAMpQs4KPYn1VpMFehqmyM0PLg3gm14JA47nyAvPBhRhrDDiq=g@mail.gmail.com>
Subject: Re: [PATCH 01/34] mmc: sdhci: Use devm_mmc_alloc_host() helper
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian:

Thanks for your reply.

On Mon, May 26, 2025 at 2:27=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 26/05/2025 09:05, Binbin Zhou wrote:
> > Use new function devm_mmc_alloc_host() to simplify the code.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  drivers/mmc/host/sdhci.c | 9 +--------
> >  drivers/mmc/host/sdhci.h | 1 -
> >  2 files changed, 1 insertion(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 32fa0b2bb912..c40caa3f003f 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -4076,7 +4076,7 @@ struct sdhci_host *sdhci_alloc_host(struct device=
 *dev,
> >
> >       WARN_ON(dev =3D=3D NULL);
> >
> > -     mmc =3D mmc_alloc_host(sizeof(struct sdhci_host) + priv_size, dev=
);
> > +     mmc =3D devm_mmc_alloc_host(dev, sizeof(struct sdhci_host) + priv=
_size);
> >       if (!mmc)
> >               return ERR_PTR(-ENOMEM);
> >
> > @@ -5000,13 +5000,6 @@ void sdhci_remove_host(struct sdhci_host *host, =
int dead)
> >
> >  EXPORT_SYMBOL_GPL(sdhci_remove_host);
> >
> > -void sdhci_free_host(struct sdhci_host *host)
> > -{
> > -     mmc_free_host(host->mmc);
> > -}
> > -
> > -EXPORT_SYMBOL_GPL(sdhci_free_host);
>
> Doesn't that break the compile for everything still using sdhci_free_host=
()?
>
> You probably need to make it like this:
>
>         void sdhci_free_host(struct sdhci_host *host)
>         {
>         }
>         EXPORT_SYMBOL_GPL(sdhci_free_host);
>
> and then remove sdhci_free_host() at the end when there are no callers
> left.
>
Yes, I didn't think it through and I will change it in the next
version the way you said.
Patch-07 has the same problem, I'll fix it all together.

>
> > -
> >  /*********************************************************************=
********\
> >   *                                                                    =
       *
> >   * Driver init/exit                                                   =
       *
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index f9d65dd0f2b2..58291a6f093d 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -811,7 +811,6 @@ static inline u8 sdhci_readb(struct sdhci_host *hos=
t, int reg)
> >  #endif /* CONFIG_MMC_SDHCI_IO_ACCESSORS */
> >
> >  struct sdhci_host *sdhci_alloc_host(struct device *dev, size_t priv_si=
ze);
> > -void sdhci_free_host(struct sdhci_host *host);
> >
> >  static inline void *sdhci_priv(struct sdhci_host *host)
> >  {
>

--=20
Thanks.
Binbin
