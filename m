Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25124268C49
	for <linux-mmc@vger.kernel.org>; Tue,  3 Jun 2025 07:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748935522; cv=none; b=uvMQfTO2at3N/O5dGRjsknbFSdzBvl8wSyXMwP9Cr7bAchDByX8MoHnLXjsfWl/pXsMXeNRnoMglZvLvtNW7BlEY9DOf0QLUiLYhl/yUn8XTzPxrrF8rbOO40EOpvLMos/Q27AXgtN534kvyEe5ZTvxoL2os484rGlj+0iBXOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748935522; c=relaxed/simple;
	bh=c4Ud+MaBtcVCQGpG2BZCx8yeg/YoMvIyeJnW6nbL9vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtET0M/Y0/46cqDPPpdOrTOe+Jh9ZkWLBHFBMjcR3d8BqkCsxupiOIKWG0pbc6JWwwcYWCtf209rFn50LaA0jfcYyzmMSV1wXJKbfY4w+TilfunpostTfIh85WixD0/6V0u8zJlY2S86CDXIXogsL9d1c5m2aHyfmbRjvHCX5Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WF4RjjG8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WF4RjjG8"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-acb39c45b4eso839328766b.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2025 00:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748935517; x=1749540317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YZygjW1Ow6Z7940oMzrM6oQz0kZ+KW4RGq7tRBXcHTU=;
        b=WF4RjjG8KMPzgK8Z0EL/LWEatMQ/2ck1T/iIL/hGUnj9DBdvzVVOTfyJyRab0DBCw1
         mWpuWgcJnWj5v34ohY3j81TA+UlW/+XZNB+1k+CsDDCL6K9SXXoP4+kB1ksGCgd+fqkm
         XMLPR8vVWeZPLMFrOd98p3FddcoWnnhGm9eG77JgsemutkDsoLEcJQ+ZHJffs7MICmyW
         tQt8brXNZI7gyJlxC1cKFIpv/IUJAFk5VUPTXhO3LHjBp12rtjnuOxD+wCIIugYPgwvV
         nRyQqKsLzRmkaPXhYXDFubLuNwy8AsKGEW3lW/qvo0+u8+f07cbQkeCVhtljk0mQxcO8
         ISuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748935517; x=1749540317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YZygjW1Ow6Z7940oMzrM6oQz0kZ+KW4RGq7tRBXcHTU=;
        b=erblLE/1rrLPZH9VJ6iQ6/xlixMo39QasbhDVxrvCJvdPDQ4tdNoKWOmnTavZ2iQ/O
         CH/+x5ZinOS2xnmyroFRj4fhpf50+JP0snOUnL5o6xaDwUUOAOaLp6Xz1kKSRo/F83jR
         G0F5V77lGUQoio60zDdKoRB/QhCOB899Cf5m6f9prAM/VY7Uv5caCl91nBuDRoVMu++h
         NG9sqHg0Dbiw8+BhhV8fM92a6h6fSGetAfqJrWowHn6E0aWWSip9gjHvVwky50Dtnlhn
         j2zCC9Le/cGrFgJFBl33wJst5psW6of9YtVmJz84chiwyppdgh6UIreEPyv6JceJijQQ
         47qA==
X-Forwarded-Encrypted: i=1; AJvYcCU+nKoJkSufFIsM6FP6SVbzINFIQRC/JyrA3CEx19N0ZxwBKOMOoFdWq43kLVBuei/UJ6GkjYM8LWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQiQkD3Wh3JHm7LxxaLxzHsy8SJ81rh5lQVcxDUyPHA6VEtWUV
	/wv3RhhULLAzhG2QAPhs65vSUup3XfDUjUGxLQQ1h289y5bO2me9CaT9zQ6vwWJhj8at5myKPYE
	5RALJgDCOMACnxZWEQO3oU5grU0ELfJk=
X-Gm-Gg: ASbGncujhMDzdGKSJ3o91xgNJ9eP03zAu+T/Yo8eBkssO0rXrj2ScW2IrhYeH0yplyV
	7sbeI/GiYeO0pCwlpu0jiZI+y5QFVvMBD4Dv3MY3ol29PfR2eJm1Lu1B3fsnHOJxs6QpC4ez3Qe
	Yytm64hgfhcl28BXe8tJvpm7vrOWPZMzIu
X-Google-Smtp-Source: AGHT+IGQMSy8zLhv5XBeE+VXLzOH9PdJ7pHuxMHeHTthwBpn8XQZR029mieeMBHF3FDoPXo7EXT7vWTa/2EPhsb/ofo=
X-Received: by 2002:a17:907:944c:b0:ad5:7529:94d with SMTP id
 a640c23a62f3a-adb32431848mr1483726366b.42.1748935517007; Tue, 03 Jun 2025
 00:25:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1748515612.git.zhoubinbin@loongson.cn> <a1f998ecdae85cc3039cfa30096220d822b616fa.1748515612.git.zhoubinbin@loongson.cn>
 <59dd37bc-f138-4326-a8d6-197a4355bc1d@microchip.com>
In-Reply-To: <59dd37bc-f138-4326-a8d6-197a4355bc1d@microchip.com>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Tue, 3 Jun 2025 15:25:02 +0800
X-Gm-Features: AX0GCFuGdzl3CZcDWw_-4hjU3nMZvdEj2Id17zrYb4mdCcVtx3fqdIK9cegO0jM
Message-ID: <CAMpQs4Lo92Jj-+smAohbqNRz6zyi1C5pdeRK9+PdL_Yi-KJtDQ@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] mmc: sdhci-of-at91: Drop the use of sdhci_pltfm_free()
To: Aubin Constans <aubin.constans@microchip.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aubin:

Thanks for your reply.

On Tue, Jun 3, 2025 at 12:09=E2=80=AFAM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> Hi Binbin,
>
> Thank you for the change.
>
> On 29/05/2025 15:00, Binbin Zhou wrote:
> > Since the devm_mmc_alloc_host() helper is already in use,
> > sdhci_pltfm_free() is no longer needed.
> >
> > Cc: Aubin Constans <aubin.constans@microchip.com>
> > Cc: Eugen Hristev <eugen.hristev@linaro.org>
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >   drivers/mmc/host/sdhci-of-at91.c | 23 ++++++++---------------
> >   1 file changed, 8 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-=
of-at91.c
> > index 97988ed37467..0b7d7db79139 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -337,28 +337,23 @@ static int sdhci_at91_probe(struct platform_devic=
e *pdev)
> >                          priv->mainck =3D NULL;
> >                  } else {
> >                          dev_err(&pdev->dev, "failed to get baseclk\n")=
;
> > -                       ret =3D PTR_ERR(priv->mainck);
> > -                       goto sdhci_pltfm_free;
> > +                       return PTR_ERR(priv->mainck);
> >                  }
> >          }
>
> For consistency with the changes below, please use dev_err_probe() as wel=
l.
> Doing so, you can remove the brackets in both if/else blocks. Or preserve=
 these
> brackets may you wish to keep the changes minimal.

I will use dev_err_probe() to cleanup the code.
>
> Regards
> Aubin
>
> >
> >          priv->hclock =3D devm_clk_get(&pdev->dev, "hclock");
> > -       if (IS_ERR(priv->hclock)) {
> > -               dev_err(&pdev->dev, "failed to get hclock\n");
> > -               ret =3D PTR_ERR(priv->hclock);
> > -               goto sdhci_pltfm_free;
> > -       }
> > +       if (IS_ERR(priv->hclock))
> > +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->hclock),
> > +                                    "failed to get hclock\n");
> >
> >          priv->gck =3D devm_clk_get(&pdev->dev, "multclk");
> > -       if (IS_ERR(priv->gck)) {
> > -               dev_err(&pdev->dev, "failed to get multclk\n");
> > -               ret =3D PTR_ERR(priv->gck);
> > -               goto sdhci_pltfm_free;
> > -       }
> > +       if (IS_ERR(priv->gck))
> > +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->gck),
> > +                                    "failed to get multclk\n");
> >
> >          ret =3D sdhci_at91_set_clks_presets(&pdev->dev);
> >          if (ret)
> > -               goto sdhci_pltfm_free;
> > +               return ret;
> >
> >          priv->restore_needed =3D false;
> >
> > @@ -438,8 +433,6 @@ static int sdhci_at91_probe(struct platform_device =
*pdev)
> >          clk_disable_unprepare(priv->gck);
> >          clk_disable_unprepare(priv->mainck);
> >          clk_disable_unprepare(priv->hclock);
> > -sdhci_pltfm_free:
> > -       sdhci_pltfm_free(pdev);
> >          return ret;
> >   }
> >
> > --
> > 2.47.1
> >
>

--=20
Thanks.
Binbin
