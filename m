Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60DA4204E
	for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748245706; cv=none; b=YO/PsJbvIpG+hiTg7ll2NPwPao7GYvdICC+/NncjKqeVb1vi/McP2UqexQ9CJ9E0CWs5J1RixUQvId+chal/OyTz+HgBfqPfzB6o5yvILhAT7EbaVnGijHMC/a0Rv53V3wtQOWhQTWTopcIoavek0uaOxrBwQkFFM3EzS+rFROU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748245706; c=relaxed/simple;
	bh=p+UZO9dFN5workx/5l0QBN64X9zCd3w+RMP97dJS4FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR+A8AQnYKLWTHxCbeXnof+jxpg5dLMYzC9+rlPolfySFucaqC67ChrOOzEqfxyK/13ib+8D+2rpE+LjMiKZthazOVDb9Gnz7xBLvI9QLTYk4ojs3q+pMbZW4neSW/1jtqSlRWxcowq3rbJUN6HMnJbr1j2Te6Dxj7w5rCfTdb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZ+cDICR; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ+cDICR"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad5394be625so378513266b.2
        for <linux-mmc@vger.kernel.org>; Mon, 26 May 2025 00:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748245703; x=1748850503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1k4arZ8HLwDFzolOR2yDYMXsIMUCJS+ZdtnHiDkm/PI=;
        b=TZ+cDICRHK5Smbb94Ca0ZzFkC2ePku5wUc1fU2Xk0zTH1xUhJUZcq36s+w7gZYcW83
         y9wAsbW7YLoTGDz4Y7rpuXlC3wYyz2lB0WK479GQ60NYA53Kd8jKOtu2XaPprlc1MNWK
         duexQx8HRzYqydJ0UN1yzIrqxcDc3/qIZaG8ipkdw9EaA679sZMgpNAdMBDaygSzTDa8
         WZpHzAKTYTNqFRwTmGUfpTLVvZvhMIONy3MosCGenplRW3Iqo1xgvhuuvGAK8mEbZlo1
         vyjq5HiQfbYJvCipvUayAeUlbWLWEUQ4SKhzu54CtFnskS+2Ap6NP2VT0GAcrcqAa0CJ
         s+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748245703; x=1748850503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1k4arZ8HLwDFzolOR2yDYMXsIMUCJS+ZdtnHiDkm/PI=;
        b=Nev+t8rdROnp8ygi86phKAzNtxx1J5fU7eTT0MWjCRWEAR0t6xcshS9FZbLKtR1Ipe
         7ym2turn1p6hXOaCwSqvpUmIeyB/Gn2xm4BzZnXGKqMvFaQiBqh0M8eAv2W1BvcfSBcE
         5sAdZoshuqbmeIc3oLBqgjvg57IMOUFDydn8nIIfo36BG/EhZn/k8nBCCJ1mDHGzQfVP
         KFHTWFNP+KtHvfzA9DkqeMeU/fdy825w8p7k5M2PakAoBY62WAbCimNIXwGWuGXG04s9
         b5WTOGY5EeMQDKaXfPZ6TbEou8/MntXT/d6vis1xfS4bXsig4VGUwGBkCcLstyU78HW2
         sJBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfGbDaolV09yqbElY9GreOCHEqlTKgRFcoNRPUZ9FptJPWI0I1Ow4QL5Uz4yRLSufaBsfKAzDPrlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzafWI6AOQcQFbTLYXLbscCVpjp7UqvvvPIaJ46hbcyMyXRY0x5
	O+7ZatRiKUKww30wvxQSoa+2+DFn5jLaqC0555Uu2LsbMnijOAGue9y42jBQpTTcRR0UnQYBZk8
	yben0iyk5KVrMGDvkEbefxDdanZC1zsw=
X-Gm-Gg: ASbGncsrI8kvZ4xzmeLEF4AucIoQ3776SFJ4yrIkvjbd+TOd6sSVtQMOkGLGU05Wel2
	E9/lTAJpj8E7QbCE/vGreyHm0ZZvQ2GO0Hvy4qbfUuzZqQFyuOtHS3gnE6cfbbWt8vhDG2WMC3X
	cO6F4umVuyBn6nFT1WngK5fKq8mN0HWI/oQESHNICItBc=
X-Google-Smtp-Source: AGHT+IG+siipmq7WTOrHqFy0nIkQnzHOvm87sO3zR53nB04dBrWcRtJEVGnHJqOOXEp7X2QAKS44ucwTtDzK5nmWQkU=
X-Received: by 2002:a17:907:3d09:b0:ad2:4fb7:6cd7 with SMTP id
 a640c23a62f3a-ad85b00c695mr777144966b.2.1748245702644; Mon, 26 May 2025
 00:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747792905.git.zhoubinbin@loongson.cn> <75f58a7bc0fef1236cd94cee8c9dc83bbc6a037c.1747792905.git.zhoubinbin@loongson.cn>
 <dec009ac-e185-4aca-986c-a8dda48fce19@amd.com>
In-Reply-To: <dec009ac-e185-4aca-986c-a8dda48fce19@amd.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 26 May 2025 15:48:10 +0800
X-Gm-Features: AX0GCFsMSa_UCd53XOD3zhSS-hatWOeweP7VTQGWuhZ0_R5g6pcj5jLXFbglBRk
Message-ID: <CAMpQs4LkUgJnDnRjrOF1mZ9RRfGGNKG-ztOhknoZ+h3grad+YA@mail.gmail.com>
Subject: Re: [PATCH 17/34] mmc: sdhci-of-arasan: Drop the use of sdhci_pltfm_free()
To: Michal Simek <michal.simek@amd.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michal:

Thanks for your reply.

On Mon, May 26, 2025 at 3:34=E2=80=AFPM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 5/26/25 08:06, Binbin Zhou wrote:
> > Since the devm_mmc_alloc_host() helper is already in
> > use, sdhci_pltfm_free() is no longer needed.
> >
> > Cc: Michal Simek <michal.simek@amd.com>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/mmc/host/sdhci-of-arasan.c | 26 ++++++++------------------
> >   1 file changed, 8 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhc=
i-of-arasan.c
> > index 8c29676ab662..42878474e56e 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -1883,34 +1883,26 @@ static int sdhci_arasan_probe(struct platform_d=
evice *pdev)
> >               sdhci_arasan->soc_ctl_base =3D syscon_node_to_regmap(node=
);
> >               of_node_put(node);
> >
> > -             if (IS_ERR(sdhci_arasan->soc_ctl_base)) {
> > -                     ret =3D dev_err_probe(dev,
> > +             if (IS_ERR(sdhci_arasan->soc_ctl_base))
> > +                     return dev_err_probe(dev,
> >                                           PTR_ERR(sdhci_arasan->soc_ctl=
_base),
> >                                           "Can't get syscon\n");
> > -                     goto err_pltfm_free;
> > -             }
> >       }
> >
> >       sdhci_get_of_property(pdev);
> >
> >       sdhci_arasan->clk_ahb =3D devm_clk_get(dev, "clk_ahb");
> > -     if (IS_ERR(sdhci_arasan->clk_ahb)) {
> > -             ret =3D dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb)=
,
> > +     if (IS_ERR(sdhci_arasan->clk_ahb))
> > +             return dev_err_probe(dev, PTR_ERR(sdhci_arasan->clk_ahb),
> >                                   "clk_ahb clock not found.\n");
> > -             goto err_pltfm_free;
> > -     }
> >
> >       clk_xin =3D devm_clk_get(dev, "clk_xin");
> > -     if (IS_ERR(clk_xin)) {
> > -             ret =3D dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin clo=
ck not found.\n");
> > -             goto err_pltfm_free;
> > -     }
> > +     if (IS_ERR(clk_xin))
> > +             return dev_err_probe(dev, PTR_ERR(clk_xin), "clk_xin cloc=
k not found.\n");
> >
> >       ret =3D clk_prepare_enable(sdhci_arasan->clk_ahb);
> > -     if (ret) {
> > -             dev_err(dev, "Unable to enable AHB clock.\n");
> > -             goto err_pltfm_free;
> > -     }
> > +     if (ret)
> > +             return dev_err_probe(dev, ret, "Unable to enable AHB cloc=
k.\n");
> >
> >       /* If clock-frequency property is set, use the provided value */
> >       if (pltfm_host->clock &&
> > @@ -2029,8 +2021,6 @@ static int sdhci_arasan_probe(struct platform_dev=
ice *pdev)
> >       clk_disable_unprepare(clk_xin);
> >   clk_dis_ahb:
> >       clk_disable_unprepare(sdhci_arasan->clk_ahb);
> > -err_pltfm_free:
> > -     sdhci_pltfm_free(pdev);
> >       return ret;
> >   }
> >
>
> I don't have problem with this change but your series is just wrong. Beca=
use
> "mmc: sdhci-pltfm: Drop the use of sdhci_pltfm_free()"
> is just removing this function before you convert all drivers. It means y=
ou just
> break bisectability of tree which is clear NACK.
>

Yes, that's my fault, I didn't think it through.
Adrian just pointed this out, and I'll rework this section to empty
sdhci_pltfm_free() first, and then remove sdhci_pltfm_free()
completely at the end of the patchset.

> Thanks,
> Michal
>


--=20
Thanks.
Binbin
