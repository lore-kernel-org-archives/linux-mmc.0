Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94042173324;
	Fri, 21 Jun 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969193; cv=none; b=mP7ppoDEqpjgR53puh7xpYJItEloUDy6aRokcTEiuaWuDs2uo+3kYIFEwh0SgMyvk3X8p6fIRLrUtrYVV4XY3rORsIVewoSc4V1nSIYRHAERdlUzOzXNKdg1bR1IdQxkM4ZhcyAAO2WSrn1YGmYOxIZ+7a86MN5gPmK88FGWLFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969193; c=relaxed/simple;
	bh=6Z4wpojLz/hacj79e57BMfp429TSIJBj0CjR5tMbUrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=joL3+eZd9Lvtxi9aj119/MCegC2ZzDfwROxO5atclLNThVfE6ErgKdMW7m7Rjc4mCL1Gm2TLqxXmEFe0+M5jNhL7TqtpgYFtP8YzKYM64pZP3gyOIX7ydA5UXOcn8sQh3871X8rmauWhr5DXMgsGMkRRyqV69ZR4NOLklhMGqW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnGQS1B2; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnGQS1B2"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57cf8880f95so2173816a12.3;
        Fri, 21 Jun 2024 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718969190; x=1719573990; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0NS7LlelhpSen05TQ03Z1wb2gyNuCOX1l5VdBrZGKM=;
        b=cnGQS1B24Or85wx5TZlYZ2q9+XcyMQ4LkxV9ST5vhMQ1Ojj5eFVL/JZthtnKNKKisp
         c93Z3K8YwKc0hSaaSeWYRwl6a9FZAzZX0mWNphShJ1tHOPgDdfp6zI+NAdA+bzU/qV/B
         3oCRleIIeI1S8qlYcAKt+HX9dUHiOaZ+kOCgWWF2n2uuqDEXZShEzvbrKk+y2pe2TNyw
         Bk8bGgFusX3oGRpBpkk8sBNJGpExTikCNQMIi4xFFjl1AMocGAjb6uaG9D6DDaavhmtG
         bWHZ9wuhwt89FOCcdcgKewDRbTzP48/SRM2ZYkVTEVBwFjZ92CZpv5egLguzBfHusjek
         9kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718969190; x=1719573990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0NS7LlelhpSen05TQ03Z1wb2gyNuCOX1l5VdBrZGKM=;
        b=WqloSIrZUPbLcQAVRMfdhFneHBbQoXlxKVNvbGYcI0DzKYFVvFoRwq6DDPAXng5/Ri
         WUgHLhMGob+IUiEhiWPnOwTn8aavnMC77LZ9ysjUzQlIvm5HBe+ZlEpXrXg/XMfbd4L2
         kZC0UvlzY5yGaAQH0ovNfslfE1safqRPVh+gH47Dqtxurc3BGd+ymBSah58vFA85n4wm
         orpLSvZmQ6oJJFY88tzBXa866Oj2nqc+aZgAfAcK6/3DjvJhNL4P99qE+YoOEiA6fVNo
         sOahBNZ6lqLrQpXktYBJEP8R3w9rUIYLUr4fhS4DzcVKBvtdc4/l8lQOOmr+yNk5iBfo
         MU5g==
X-Forwarded-Encrypted: i=1; AJvYcCVjJHjbTsvqKFFa4DrSgqo9WbD/O9atSgVeS/gBf3udG8KOi7MlkHj3tvYePGtU6teq6thc1Dhos1xlvJsqryKmFhVYifg4MPOcs7/W/OyjBOUkbwf3Bl/mJ/I+fQ9ggFVubjO0IOAJ9ljHcdbXcHzS/E0+gOMWHkiEnZH3QdqtXED9Ow==
X-Gm-Message-State: AOJu0Yyiw/ub3MLY3XwIK2JQRE9Xn3TW7EyOswmf/OGBllgfYgOQaCij
	uFfhsWEYv7IPV7BKjyP1h85vgYtTi8nneuqSSFD2q9OHiaP+x7xIHCDHhclWbXa0RpHJGme+UkA
	E6QOvXahJNpv9i+D7BK/1EOMsQe1xyqjI
X-Google-Smtp-Source: AGHT+IEj3xJiyLNIRUImQfeckjZNz/P5iTFKuJO/ro0q3UwgZoaarlsLmvCBnakUjtcivQryct+kRTzskos2kA1Ceks=
X-Received: by 2002:a17:906:80c:b0:a6f:2de0:54d with SMTP id
 a640c23a62f3a-a6fab7d6c69mr582759066b.76.1718969189569; Fri, 21 Jun 2024
 04:26:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-3-shanchun1218@gmail.com> <CAHp75VcJGoDaAbD7vWin8yTGarrLZbVQqucHs+M9rAAS0BZd9g@mail.gmail.com>
 <1e249c77-def1-4ffc-bbd6-d64f7e95b0ac@gmail.com>
In-Reply-To: <1e249c77-def1-4ffc-bbd6-d64f7e95b0ac@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 21 Jun 2024 13:25:52 +0200
Message-ID: <CAHp75VfpPR3Nat2dJrwLaxvnQNmn6KbpAfLcD-BvadwyHXDE1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de, 
	pbrobinson@gmail.com, serghox@gmail.com, mcgrof@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com, 
	tmaimon77@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 10:06=E2=80=AFAM Shan-Chun Hung <shanchun1218@gmail=
.com> wrote:
> On 2024/6/20 =E4=B8=8A=E5=8D=88 03:09, Andy Shevchenko wrote:
> > On Wed, Jun 19, 2024 at 7:47=E2=80=AFAM Shan-Chun Hung<shanchun1218@gma=
il.com>  wrote:

...

> > You are missing a lot of header inclusions, please follow IWYU principl=
e.
> I am not familiar with IWYU yet, but I will learn it and use it for
> checks later on.

"Include What You Use". But some of the headers may be omitted as they
are guaranteed to be included by others. It's a bit hard because one
should know and follow the kernel development, currently the headers
in the kernel are a bit of a mess.

...

> >> +#define BOUNDARY_OK(addr, len) \
> >> +       ((addr | (SZ_128M - 1)) =3D=3D ((addr + len - 1) | (SZ_128M - =
1)))
> > Besides sizes.h being missed, this can be done with help of ALIGN()
> > macro (or alike). So, kill this and use the globally defined macro
> > inline.
> I will add sizes.h and directly apply globally defined  ALIGN() macro
> instead

Also check what header should be included for that macro, IIRC it's align.h=
.

...

> >> +               for (idx =3D 0; idx < ARRAY_SIZE(restore_data); idx++)=
 {
> >> +                       if (restore_data[idx].width =3D=3D 32)
> > sizeof(u32) ?
> Your idea is better, I will change it.

You might probably want to use the same in the restore_data array initialis=
er.

> >> +                               val[idx] =3D sdhci_readl(host, restore=
_data[idx].reg);
> >> +                       else if (restore_data[idx].width =3D=3D 8)
> > sizeof(u8) ?
> I will fix it.
> >> +                               val[idx] =3D sdhci_readb(host, restore=
_data[idx].reg);
> >> +               }

...

> >> +               pltfm_host->clk =3D devm_clk_get(&pdev->dev, NULL);
> >> +               if (IS_ERR(pltfm_host->clk)) {
> >> +                       err =3D PTR_ERR(pltfm_host->clk);
> >> +                       dev_err(&pdev->dev, "failed to get clk: %d\n",=
 err);
> > Use
> >
> >    return dev_err_probe(...);
> I will use dev_err_probe() instead of dev_err()
> >> +                       goto free_pltfm;
> > This is wrong. You may not call non-devm before devm ones, otherwise
> > it makes a room for subtle mistakes on remove-probe or unbind-bind
> > cycles. Have you tested that?
> I have tested it, there is no error messages during driver initial proces=
s.
>
> My thought is that sdhci_pltfm_init() and sdhci_pltfm_free() are used tog=
ether.
>
> If there's any error after the successful execution of sdhci_pltfm_init()=
,
> I'll use sdhci_pltfm_free().
>
> I am not entirely sure if this answers your question.

Yes, they are, the problem is that freeing resources happens in
non-reversed order (for some of the resources). This might lead to
subtle mistakes as I said above. The rule of thumb is to avoid mixing
devm_*() with non-devm_*() calls. If you have both, they have to be
grouped as all devm_*() followed by all non-devm_*().
In some cases you might need to wrap existing calls to become managed.
This may be done with the help of devm_add_action_or_reset(). Check
other drivers which are using that.

> >> +               }
> >> +               err =3D clk_prepare_enable(pltfm_host->clk);
> >> +               if (err)
> >> +                       goto free_pltfm;
> > Use _enabled variant of devm_clk_get() instead.
> I will use devm_clk_get_optional_enabled() instead.
> >> +       }

...

> >> +free_pltfm:
> >> +       sdhci_pltfm_free(pdev);
> > This should go to be correct in ordering.
>
> I am not entirely sure if it is similar to the "goto free_pltfm;" issue.

Yes. It's part of the same issue.

> >> +       return err;
> >> +}
> >> +
> >> +static int ma35_remove(struct platform_device *pdev)
> > Use remove_new callback.
> I will fix it.
> >> +{
> >> +       struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> >> +
> >> +       sdhci_remove_host(host, 0);
> >> +       clk_disable_unprepare(pltfm_host->clk);
> >> +       sdhci_pltfm_free(pdev);
> > At least these two will go away as per probe error path.
> I will use sdhci_pltfm_remove instead of  the ma35_remove.

After fixing the ordering issues in ->probe() this might need more
modifications.

> >> +       return 0;
> >> +}


--
With Best Regards,
Andy Shevchenko
