Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9262D28C86C
	for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750767626; cv=none; b=BbXBaRSEw2qeKqOfl77yEZpWoV7rW6MfFVmWILODlaRGMsoomsb005yS2GmAItzgRY+f/jg/yB99LTn7XCn9qKQyqKrReVhSXzE0XK1sQZU/SbWwY1eeDYzYdRHPcHZc1+R3fRoOcUoR8FzmEQS9iVSjcyhf0hRguDYAMaq6qRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750767626; c=relaxed/simple;
	bh=GZ/5iwl8ZZPmakE+efLtYtbJJP7cX9eI0cexO3y8u8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEWm6W3jQiMNrJqLmHXMWsWhSfAblETm8Y5GYoXeNPFcmqWZN8SFlYFkyRYiv2K93WroBjMHKKMyUVA1l2DCsQ7gqaqHDlC01hQAFVs8cMnOp/4f+cwJX7nZTYOMiAg+R+DcAyYHjTo3Oc+xI+RQ4uX1Q/+Nskrtrrx0xd9VAL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C2/92yD9; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2/92yD9"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so4710328276.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750767622; x=1751372422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=17QGHlSSDUGN/mqnXiKE0ZuW4uit1RiwoU2bfSWcixE=;
        b=C2/92yD9YxFTmpln1Dem2TL+U8jjm47uGjWuICg65ONXV/WmY0fPgpdVwVS0sYH4qE
         /dzURNyUO8OETR+8MSkxccqlkxdSrER+Rzi7GJ0OyQUwvkh7vcPRZm7c+y/kaTge3FHE
         ZJsDmyQRu/3hjXK5Ir8KRoWo8dlVZApl83I/UcHCaG5W4eewMJhJNAVoUs74hTOdRHOt
         6w1vdfVk4GRdOXtFLc+c/k4dD/Umk7MtXcIST4QvBqP00MhDHCJoa5BTUIVOCo5myZR8
         +K53RkAaQa8bsL7PNYFMj1r7h/g8Nez2wl7PwxQuxWvo1GbBcXlTn4t/Yzs8pOry3IrT
         mA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750767622; x=1751372422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17QGHlSSDUGN/mqnXiKE0ZuW4uit1RiwoU2bfSWcixE=;
        b=dAgdZowsSsrumB25q+4MhxzmnpaOzvsLYFXvaw+tCXK00WgXucNIvIHBddBDxyxh5Y
         HgnZakEi09N9it9cUtq07wqiB+M65LNcvuCcwk1MgJiYdis7yW/cZ8+tFuQSmWC5z1L/
         WJUMudivnv8v0eYgvIBv90TvGB3a6jHl17W6ENpdqLVBAqMP0Jkl2LPJ5u39rK9aLquy
         94yjwrCt/oUjTVCnufHB4GFyqUUzhueCqyDxpHTBO6inPEOOvLi+F8HX/C86BiDpmN+m
         s0AOYm0O1Xm7UhFg2mkSuGBlBVxGtyYcRRYToMaaZiofKzz/aHr/b+N9ukqYdVtvwzKv
         OnYg==
X-Gm-Message-State: AOJu0YzI0XYxkcCPg/xqq2jSCA3DZNoSj7wdzw8ZmZnaZBF1nWhsyRVn
	BoO97Q/qWykzzesYLx2TFqkI5YL6dYWwt3dPCXxTcc+0leMtZtRsd4VNQniOoiqDRR614LwhiWf
	URgAbzmQqzG8SMj7MgfB4Bkgt4eMCZcDaXp1WoDaLPw==
X-Gm-Gg: ASbGncuHTeZgz+CSpI719/5W56OelhMAzFqxTAuo+/j5o17R/oPRTAIuzV3OH5zr1+A
	/bWnEe0AOdfIBhyHC0ciZdzY3JBE8N8Wrr7zyRDlX7PdgFNONl07hS44XhHioW1jJqlzcIAvgX/
	/ubXhf4T8Af1GtNk1BAwf4fgKlknVjaLF8h59Fm4PyJbS2
X-Google-Smtp-Source: AGHT+IGPTctpVVW06WOrtz3efzF82iIEaeDrUDN4ojSw3HrQtEK0IapvoQQeUraQNubsJNcTfkjZNirZjEE8U0ZxCKI=
X-Received: by 2002:a05:6902:1207:b0:e85:f1e3:81c0 with SMTP id
 3f1490d57ef6-e85f1e382b6mr4407587276.5.1750767622430; Tue, 24 Jun 2025
 05:20:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624110932.176925-1-ulf.hansson@linaro.org> <a0343926-1495-4766-a7d2-108d40fe9ea1@intel.com>
In-Reply-To: <a0343926-1495-4766-a7d2-108d40fe9ea1@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Jun 2025 14:19:46 +0200
X-Gm-Features: AX0GCFvm9jdM9vz3y8zmX9_7oU6NfR6QW6tWLObXhLGRJNwV8Wj0thFllf6dB0g
Message-ID: <CAPDyKFpFp=ONrpcfuK1K-GzhR81PxYBBNhjQxkHZwO86iw1KdA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci: Disable SD card clock before changing parameters"
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Erick Shepherd <erick.shepherd@ni.com>, stable@vger.kernel.org, 
	Jonathan Liu <net147@gmail.com>, Salvatore Bonaccorso <carnil@debian.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Jun 2025 at 13:30, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 24/06/2025 14:09, Ulf Hansson wrote:
> > It has turned out the trying to strictly conform to the SDHCI specification
> > is causing problems. Let's revert and start over.
> >
> > This reverts commit fb3bbc46c94f261b6156ee863c1b06c84cf157dc.
> >
> > Cc: Erick Shepherd <erick.shepherd@ni.com>
> > Cc: stable@vger.kernel.org
> > Fixes: fb3bbc46c94f ("mmc: sdhci: Disable SD card clock before changing parameters")
> > Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> > Reported-by: Jonathan Liu <net147@gmail.com>
> > Reported-by: Salvatore Bonaccorso <carnil@debian.org>
> > Closes: https://bugs.debian.org/1108065
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>

Thanks, applied for fixes!

Kind regards
Uffe

> > ---
> >  drivers/mmc/host/sdhci.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 4c6c2cc93c41..3a17821efa5c 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2065,15 +2065,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> >
> >       host->mmc->actual_clock = 0;
> >
> > -     clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > -     if (clk & SDHCI_CLOCK_CARD_EN)
> > -             sdhci_writew(host, clk & ~SDHCI_CLOCK_CARD_EN,
> > -                     SDHCI_CLOCK_CONTROL);
> > +     sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> >
> > -     if (clock == 0) {
> > -             sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +     if (clock == 0)
> >               return;
> > -     }
> >
> >       clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> >       sdhci_enable_clk(host, clk);
>
