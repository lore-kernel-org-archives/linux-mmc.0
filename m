Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CC2DC78F
	for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763022794; cv=none; b=JEpbZc4NM+K23384wTax/aNbn3dU+cAz3wAdPvwjd3vLozL1xoowoXE4xnxdEIyOVxiKtumezt3rtGzc276xh7z30neYctwAm/EclEtE43lLVO7DiHLYYEAzaJcAW7AfLro/Nl+EF2NVTiuLmN4r5F1xx31lyCU7OqNf2f0Pphw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763022794; c=relaxed/simple;
	bh=WDZYAHbv5mBkU9poLMWuB4yiOD3mBOoF+sIIPyL8TvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boLUJhNJnTtWH1ygX7SLXGPjlJs3kVI5ZgKa5RT1+m6aFfy1gQmqNP/jCoEHW9ORRRO8IaoXkVJa3O4OvgKvcY/yVR+Y7dE20pZLHzqlBNTNEFzdQUjCllddRF7nTLYYJsInTw88g8yNNkq0ktCStYx1xhCQYSZlSfFm74LdV7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-55ad466ad1eso160934e0c.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 00:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763022791; x=1763627591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xfvAxBKuBN5aIubnwQ1QO1UY6mKrYpvn3C7gF7sZv8=;
        b=SZECSrARxucz17xXx5mXM3l97Xn3Q9L1l8P6M68n0hxZlIefdb9y04aP++vvOyInO+
         nu34HLZz1UGZv+OFgP15BfhchNebMp4BugL0GsfLLa7SHNcewg7IennjIw0YprMLa7VV
         yZkpXfmHpJVBVxPxGap2F/oI14JsxIhCj7wJMKMlcDmzct07vfRl0Amf78NQQvHs915C
         vqcKON4z65dzQGFzWPNypKKcVkOXYIa4V2aSlgi7UvmEp6SfROuVssqkjHEIqCJwjU93
         BDa60vr8PLb+HsLLn1k1V00++DrzOruJESdL/R0s3AK6zVYwCabb71sHhxlFsdWhlb8i
         543w==
X-Forwarded-Encrypted: i=1; AJvYcCXA6lUAohhZ6GoOG78xa2KnCCiqy7XZ6qci5s7XoETShI6NlApiVlANXmf95CYL+VlEzfz25OvDDvs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyugx6PyJtJdd2bKulu7TA3Gt9OsTrTpONEUqKpZEDHa2xMnuTa
	fqeeF3p3WxhZRn2a3hQehvv/TRgy39sO5crcnZuqGqhg1bGPxOS1D6Fy/pg+Mu1+RG4=
X-Gm-Gg: ASbGnctoFZbrE6m8qSmmwA7wbVLeB2eoKEF+FqoiVMiSJyKq1Uh2cWxOmyZ9pjjMwmU
	m3By3kOoqjWmi5uV8sOwzLf0Y+u3RUTgNZnvnI8+Vj40PYTmtzouB5rJr+vAquSIg9noLNPf82i
	v3emE6DstMeJA6HcY1Jpsbz2g72biBP/B2EIb+gd96FZzjEfsnX0gUvtmCVS3HetSmZn+o/rdrl
	pWi9zpvdJS4T7+cUoToEZcwS8bB/23OdwmI2/EDsmYdx+rnkXoLwhkLPmxZIkxxvMpgQvUgwSpI
	lubsQnS1fGfAXFPoJSeODQigtQkVCyUa2jX3NWNvW0UBX5Ngyl038CzmaJ+gXBWxdTusrSD00VO
	mW/l+vd0pKZ3kN1LWCDj6aqNucnlp8wBPIEOR5NkBzgfgKnHgfczIYAPEk6uSbEcNBlT4Y427vz
	7p4Wsp71WBN9cIojO2u/M3+69wRNTKFCEV8/HrgQ==
X-Google-Smtp-Source: AGHT+IFjASaDuGe5IC3wvTcKO12xZ7QhzsPpctOe/8Y5D3UCwQaZQ02gHSvdm3sfcgZGAdHylfs2gw==
X-Received: by 2002:a05:6122:3481:b0:54c:3fe6:627b with SMTP id 71dfb90a1353d-559e79bd4f5mr2209548e0c.3.1763022790736;
        Thu, 13 Nov 2025 00:33:10 -0800 (PST)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b0f331034sm496201e0c.3.2025.11.13.00.33.10
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:33:10 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-5dfb5fcf063so139703137.1
        for <linux-mmc@vger.kernel.org>; Thu, 13 Nov 2025 00:33:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEHwyriHLxEn6iPSHWb+BIBUNDmoGN+TeC3c9bhif9QpdqlYJj2NLTJ2KXr4Nl58bkVBsPoOm5GHw=@vger.kernel.org
X-Received: by 2002:a05:6102:290b:b0:5df:b3ed:2c8b with SMTP id
 ada2fe7eead31-5dfb3ed30cdmr825635137.38.1763022790257; Thu, 13 Nov 2025
 00:33:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
 <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdXUqsU6MKh8WSO4EmrxCfUg8FZkrJKb7OH-KwMY4+iC4Q@mail.gmail.com> <aRTRshYq2MznnCYc@shikoro>
In-Reply-To: <aRTRshYq2MznnCYc@shikoro>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Nov 2025 09:32:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWkKCi848-jELO=XuNyyADRHJfVhUng4JWJ0CMhXRLYug@mail.gmail.com>
X-Gm-Features: AWmQ_blHht0AJ-x3GqfMcqWJKmRw1q0N88H_qFBWtcL7Np5xBSlxA2bfyasQ70I
Message-ID: <CAMuHMdWkKCi848-jELO=XuNyyADRHJfVhUng4JWJ0CMhXRLYug@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
 and pm_ptr()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, ulf.hansson@linaro.org, 
	p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Wolfram,

On Wed, 12 Nov 2025 at 19:28, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > -#ifdef CONFIG_PM
> > >  int tmio_mmc_host_runtime_suspend(struct device *dev);
> > >  int tmio_mmc_host_runtime_resume(struct device *dev);
> > > -#endif
> >
> > This change is indeed needed, because RUNTIME_PM_OPS() now
> > references these two functions unconditionally...
> >
> > >
> > >  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
> > >  {
> > > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> > > index 775e0d9353d5..8be642f737c7 100644
> > > --- a/drivers/mmc/host/tmio_mmc_core.c
> > > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > > @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
> > >  }
> > >  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
> > >
> > > -#ifdef CONFIG_PM
> > >  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
> > >  {
> > >         if (!host->clk_enable)
> > > @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
> > >         return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
> > > -#endif
> >
> > ... however, no actual code referencing them is emitted in the
> > CONFIG_PM=n case, as renesas_sdhi_internal_dmac_dev_pm_ops is not used
> > due to the use of pm_ptr().  Hence the changes to this file are needed.

Oops, I intended to write "are not needed"!

> > (verified with m68k allmodconfig/allyesconfig builds)
>
> Since you confirmed all this, did you forget a Rev-by? Or do you
> actually describe an issue which I am overlooking?

Thank you for pushing me to rethink why I didn't provide an Rb-tag!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
