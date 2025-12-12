Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAF727E1DC
	for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765516451; cv=none; b=bBvNrN1dD4IZdwvpkVbDWNSFnwjrz6fCYGlW0bYXd8obY8J8mmpEW0etgyrdw1JplnQG8QKpU3XEhxprTC1TGuDEvOxel4ojXgZ9gEl1wHbo/DDP7A7NDGL4mmyNxthPXM2yyfjKmEZ3lwRs671CXC1fDOM2MH5Ay4pfvFfV3hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765516451; c=relaxed/simple;
	bh=5OpAmE7nJ9MtBhoh+gbRPyjSe1KubF0z+05oV9K/LCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BibhKt9xqBRLH1yFV5/8W1gLvP7hNGxBceOxfKfRwu7eGtNSaJENBDc0K7yCu6ZesysoAothlz1tkMV/p61xsV7REVHIrqg9yXYMbe1KMvXw+wHhgbEn+fzfxuoFv9p71OY/ANni/d6pw1cmPocz+YW4zN2UiwuGYBA+rnFfJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHS/uTCs; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHS/uTCs"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29d7b019e0eso11102855ad.2
        for <linux-mmc@vger.kernel.org>; Thu, 11 Dec 2025 21:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765516449; x=1766121249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTh/4yILgLNMJOnKGwF0QfZ+c73Zf5egQB4cRrExU7A=;
        b=lHS/uTCsr/4RPCZm0ix/9/364qvUC57WXor5qJB4WRTYoGDNpFZKQpTjUjZi4uAeWL
         bEwJH7yld8iDyJ7kPYJSO0o5WnlqaNr8f9v53arVO52jz9Q3U/W7KcTSmU3VgX9qh8W8
         S0WzUxBHl3vxX4jtSbjfwF5tJDyttx55wOtV4voP/rELmCkc1zh+/dxB0CCUl+zP7x9F
         YFi/BUXEIB5D9mzlzk1H5jpy4lLQEFIkYkuRwq1xrqzmD+LcDph1NLLwBKCS5U/d1IxL
         47HMo6ra7j1NUO/nnEThK7mk80JS51mJ1HdDyDdEu82pg498uKOQZRq8eypnC5lUGWIP
         ZM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765516449; x=1766121249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTh/4yILgLNMJOnKGwF0QfZ+c73Zf5egQB4cRrExU7A=;
        b=tHVPiV7u0xVWbCYkrgpXT7F923f/zFvl0b1gRmeu4sXB43AsRX9tRCiwz4d75hX6TP
         Gi9PW4xY83YWmgjXi6QmIL5E6PP8AP3LOaeyVzKYOf5iLXe3tFcgtIoOTlBHLg35unga
         OoJ7w/ixTixl7eBECfreUoMCYpG3bilUydEZieUpP1HRGmVgRCE32m1j4WPbIgYMOgq2
         1/Zj9eJER669AR4hoA/kifbBiCVxJUzdP1WawnV4QIvs2GngKR29cOd4b+OH7E8jFJmT
         Thd4XjD/+Uqg8R3Xjf9Kc1meY3RcpL1wLyh36j4F/hzZ8SpJqUXb2n0RXHsQWyZUmTSf
         A4KQ==
X-Gm-Message-State: AOJu0YzRzXxhmO9GByMNLDv/IXCiIWKZ1g+SOd0EOFvVdL1ByhqkXhL7
	cLoJmBbNRuuktnt9s3QWx0nfF3atWFc9XM/Y66QyTKhKW6e+O8v2XdCJ/I7EjFNbL6EqxgYDZVX
	IjKSdXMY7LSND6pro+KBhbz9OG02qDJ0=
X-Gm-Gg: AY/fxX65Hx554faeZzfSoypgUZJEG0ibfKv/qx9+uEWk6nH4dplNAY+wdog8wqoU9/J
	/vUDuRS71k3OfBo2QnfjxhkBBvFcRoUptWVdXK19GeBoBP/FnOJyiVrtex6Mj36uqOLhujxfwDA
	3RfdogV8lVn7IwwgIKjPdQGJNMvR37/A4rLSCXlBOEbkVC/1YG7ZQGGOj5TuiB9DBqj5IrFo0OT
	G8CqTVUip/6oTOvDT1JwMcZEDh+hZVJnG7cNK/vsLqFJRn9CRvvfPlGlb+9G1B4QVtBDkDECLsv
	ZqaZBg==
X-Google-Smtp-Source: AGHT+IEYNo59zAycuNi/LT7Ff/P7Y+SmQh9VaoXTRVpClq9wibMpl+Qye+KYeetZK9jaHtzzUjyR7mGfYwBssYl+KSI=
X-Received: by 2002:a05:7022:7e0a:b0:11e:65b5:75ce with SMTP id
 a92af1059eb24-11f34ac15e5mr703332c88.10.1765516448824; Thu, 11 Dec 2025
 21:14:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211161313.3994317-1-islituo@gmail.com> <7a24821b-d54e-4463-9274-215c027c9be2@rock-chips.com>
In-Reply-To: <7a24821b-d54e-4463-9274-215c027c9be2@rock-chips.com>
From: Tuo Li <islituo@gmail.com>
Date: Fri, 12 Dec 2025 13:13:56 +0800
X-Gm-Features: AQt7F2qR6KrI9RM_VTf1jDRJ1oQVNMERl63_FStRU4XUY_2CWf-oXH4zv-mTPB4
Message-ID: <CADm8TekznJMG=wDFAsqdb-g7_8CVmoNEU96JyDQDUxEJwFPJfw@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add a defensive check to prevent potential
 null-pointer dereferences in dw_mci_runtime_resume()
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jh80.chung@samsung.com, ulf.hansson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

On Fri, Dec 12, 2025 at 8:28=E2=80=AFAM Shawn Lin <shawn.lin@rock-chips.com=
> wrote:
>
> Hi Tuo,
>
> =E5=9C=A8 2025/12/12 =E6=98=9F=E6=9C=9F=E4=BA=94 0:13, Tuo Li =E5=86=99=
=E9=81=93:
> > In this function, the variable host->slot is checked and then dereferen=
ced
> > in several places which indicates it can be NULL, for example:
> >
> >    if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >               dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
> >
> > However, in the following cases, host->slot is dereferenced without a
> > preceding NULL check, which introduces a risk of null-pointer dereferen=
ce:
> >
> >    dw_mci_setup_bus(host->slot, true);
> >
> >    if (sdio_irq_claimed(host->slot->mmc))
> >      __dw_mci_enable_sdio_irq(host->slot, 1);
> >
> >    dw_mci_enable_cd(host);
> >
> > To prevent such issues, add a defensive check to ensure host->slot is n=
ot
> > NULL before dereferencing it.
> >
>
> Thanks for your patch. we plan to remove the slot design
> entirely soon, probably this cycle.
>

Thanks for your feedback!

> > Signed-off-by: Tuo Li <islituo@gmail.com>
> > ---
> >   drivers/mmc/host/dw_mmc.c | 17 ++++++++++-------
> >   1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 9e74b675e92d..e74dea0a32d4 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -3670,15 +3670,18 @@ int dw_mci_runtime_resume(struct device *dev)
> >       if (host->slot && host->slot->mmc->pm_flags & MMC_PM_KEEP_POWER)
> >               dw_mci_set_ios(host->slot->mmc, &host->slot->mmc->ios);
> >
> > -     /* Force setup bus to guarantee available clock output */
> > -     dw_mci_setup_bus(host->slot, true);
> >
> > -     /* Re-enable SDIO interrupts. */
> > -     if (sdio_irq_claimed(host->slot->mmc))
> > -             __dw_mci_enable_sdio_irq(host->slot, 1);
> > +     if (host->slot) {
> > +             /* Force setup bus to guarantee available clock output */
> > +             dw_mci_setup_bus(host->slot, true);
> >
> > -     /* Now that slots are all setup, we can enable card detect */
> > -     dw_mci_enable_cd(host);
> > +             /* Re-enable SDIO interrupts. */
> > +             if (sdio_irq_claimed(host->slot->mmc))
> > +                     __dw_mci_enable_sdio_irq(host->slot, 1);
> > +
> > +             /* Now that slots are all setup, we can enable card detec=
t */
> > +             dw_mci_enable_cd(host);
> > +     }
> >
> >       return 0;
> >
>

Sincerely,
Tuo Li
