Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2009E224234
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827425; cv=none; b=ME5KRlvIBaug1x9td8BjG8IvVB7cWodEPcKYI6vVywofjm1794NOJYsE6/eWQbMpUXaKSPIy9tySAilI3tC+w087AnuPfgI6DHstFgOHRI8xlyFtlItn9CDO/lzNZgTuNqXIofUkORDuH8Qxx4MrLgKFDAtnUX1ISIYplNUThz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827425; c=relaxed/simple;
	bh=cMeZSP4ASQ8GWND8BDmf5TSh+qhh/ToWaWSuqXzHvDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH2wXDmRj1dTONFFxUdPWGAUXLwQYvqrxTnndNETfNkQ/d0DZ+SZNHL2uflfU+Nx7/nm+/TJJHRzuxEnia+gharT6cjMY+Ivnh0a2Mw+BzQaFtd7cNZ+hVZ6RSWCfFI2GqAUCnW/gBURM+2ZkdeNVDVUpBxzy6OSv9gS8/5KHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5fc456c3742so707049137.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 08:30:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770827423; x=1771432223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B4ogstsr1LPrx78n1KJ8ejaHIz64tROV+G0WDoBzT9Y=;
        b=HY6u6dKcJ0PihGhWoJZyEtLm7ML09bJ/8NcyAxC3MLSANtQ3U+OWjjf/sWoZDM5RKL
         ZW0pV5wc0n5gg4eJaSk5wcunqc5myRR13MukNXb/yy0y+jIWo5rZrehkPPrp1oJK2wV6
         zS+Q9S+iebGs8wDdCFdfFvzk2MM0B+dXsIEt7HM5z1V7XnX7ry9fldeWatiV/qGmfKFM
         JbCaupca7wfxCCzSmKwSyaocUL3paPeYiwUSgY0uA37SW5tTfIQ2XblMB2UkO958H5hb
         KXnlrddgTZjeYEHjusp2B2HuR1V3eihlE0TKJQZua/fJRs/uibWOB5z1NilyuxQ6F5mf
         AJvA==
X-Forwarded-Encrypted: i=1; AJvYcCXveTjLnNdnM949lshNO9xD30Bo5FISmt0lq/G2W2afVf8Rusd5+IWoaWHXThglq81hjMk+2fnySQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx48PrBGIzF4eOwIrTuEel6W+hsKcDFX+7AB4btgLJpBOejenki
	+Vluw6ejm9BZyDYY92vewik/4VAhxKtiNMeu5n670H+VAx+h5FPFYddOnJ6J4hae
X-Gm-Gg: AZuq6aIi4kWOxGqQDsrQa6Cm2GHpcFPLZZj/mg9UmPZTaZzfi8CMnFrNheE/qXAR/ig
	BykpcpeF8zhOSjuhBbm11TSqcYBEg7uM3v0CYOog2KAwlyPdWiYssjN12iCLBgYzV9h5bX4WW5R
	c8P7by/Ur3dVQIP4s57Ff/1l+tbzGMNe9VAEP7mKfJDvFLGN3whlE++SuhnkGZESfprlcSwPt5y
	3ezQEluKhuEfIL4NbSwonXnDL5GPEgZnGf4SL0zxPix+sSQbv8cY7RoJjJzNw1idqvH131IOdA9
	spmEf8H1Y2An5lcO3qkSJmC0LaAbgkkLgq1RFL74IviELUxShyW4EOVFeq8vkHi/oXqsArokDUJ
	qM1TXRegwX/JoiNvGpB0Hbf3ikmcR2HzCv8MdqCzyQZBWdekoY+UPlmKK3Q7s2uU1/XiXxqyhJT
	G8yIY7y82F1DABilAU3eYbyJN8GePH7DHcA2ez9uAn5H98co1U4u9vByQIXBTXkjN7ol7Qqfg=
X-Received: by 2002:a05:6102:dd0:b0:5f9:39e9:29e3 with SMTP id ada2fe7eead31-5fde9064ef2mr746932137.1.1770827422849;
        Wed, 11 Feb 2026 08:30:22 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5fde88575b3sm778741137.5.2026.02.11.08.30.19
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 08:30:19 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5fc456c3742so707006137.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 08:30:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXCyFMxIJbsU9Flnnx2+S1cUJMvLijb0+XYFWwSreg//lmoLliib2wJomK2Lgcm18r09Tg9oZjOpvI=@vger.kernel.org
X-Received: by 2002:a05:6102:4421:b0:5ee:a8c4:18f2 with SMTP id
 ada2fe7eead31-5fde93f801emr629474137.26.1770827418853; Wed, 11 Feb 2026
 08:30:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
 <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com> <aYyrsPTH1923jV7y@vaman>
In-Reply-To: <aYyrsPTH1923jV7y@vaman>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Feb 2026 17:30:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHNRuMmHU2ACX84nsZdXn_-fSamnF+LMFvZS3vkHnEWA@mail.gmail.com>
X-Gm-Features: AZwV_QiOx-vNn3RXDRusgjf7_W4m-z1gNAHOmJNuwbjVfchz_J9gD3jZ3pe8F9o
Message-ID: <CAMuHMdUHNRuMmHU2ACX84nsZdXn_-fSamnF+LMFvZS3vkHnEWA@mail.gmail.com>
Subject: Re: [PATCH next] phy: renesas: rcar-gen3-usb2: Drop local devm_mux_state_get_optional()
To: Vinod Koul <vkoul@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Vladimir Oltean <olteanv@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Josua Mayer <josua@solid-run.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, linux-phy@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vinod,

On Wed, 11 Feb 2026 at 17:17, Vinod Koul <vkoul@kernel.org> wrote:
> On 10-02-26, 14:34, Ulf Hansson wrote:
> > On Tue, 10 Feb 2026 at 11:53, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Now the mux core provides devm_mux_state_get_optional():
> > >
> > >     drivers/phy/renesas/phy-rcar-gen3-usb2.c:944:1: error: static dec=
laration of =E2=80=98devm_mux_state_get_optional=E2=80=99 follows non-stati=
c
> > >      declaration
> > >       944 | devm_mux_state_get_optional(struct device *dev, const cha=
r *mux_name)
> > >           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >     In file included from drivers/phy/renesas/phy-rcar-gen3-usb2.c:20=
:
> > >     include/linux/mux/consumer.h:64:19: note: previous declaration of=
 =E2=80=98devm_mux_state_get_optional=E2=80=99 with type =E2=80=98struct mu=
x_state *(struct device *, const char *)=E2=80=99
> > >        64 | struct mux_state *devm_mux_state_get_optional(struct devi=
ce *dev, const char *mux_name);
> > >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Fix this by dropping the temporary local wrapper.
> > >
> > > Fixes: ad314348ceb4fe1f ("mux: Add helper functions for getting optio=
nal and selected mux-state")
> > > Fixes: 8bb92fd7a0407792 ("phy: renesas: rcar-gen3-usb2: Use mux-state=
 for phyrst management")
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Thanks Geert for helping out!
> >
> > > ---
> > >   - ad314348ceb4fe1f is in mmc/next, and a PR has already been sent
> > >     https://lore.kernel.org/20260209133441.556464-1-ulf.hansson@linar=
o.org
> > >   - 8bb92fd7a0407792 is in phy/next
> >
> > Vinod, do you want to pick up the $subject patch as a fix for 7.0-rc1
> > or do you prefer me to handle it?
>
> Should I drop the 8bb92fd7a0407792 and it makes things easier for
> everyone and then we can pick fixed commit for 7.1 cycle..
>
> Does that work for everyone. I was about to send PR, will hold off for a
> bit.

Alternatively, you can mention the semantic conflict in your PR to Linus,
and ask him to fold my patch into the merge commit.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
