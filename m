Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBAD347DD
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764086559; cv=none; b=pLcdKOWTgk8wGElkC9zHIL4xznhN0lnRUXy2geu4XJwP/uzG/TIeEFPGlSCxaEKMVGfT+zRb2DoZe0J38TlcDFv8zHkDD2YNFS3pnBk36HiRN5SOGEdZ2z9RLY/qevR3OIEv9rlCgbOlxG4VA3dy8CK2PRh0dyX3cePEfxwIePo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764086559; c=relaxed/simple;
	bh=YNPKpdyB5dusa8BYQdvIl1sQOW2HzGafNUHndmNDYsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BmjASuQ7PebaJP/1ZTxDeO+jauLRFj8Ump4Ej3ElPuU5bBn/y3Z5kYy6SPPDoJ27n+fCprQH/SvKv+L7JSVeUerX2EMAyk4uHR4he2g9P8+/R6XlW0pxK4R8f6wwYfkWPaGp2bPbBb7aQtl/GOYHKyRb1sbqc216iWQfzvhl7VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kuvzVE3h; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kuvzVE3h"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-6420c08f886so6310379d50.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764086557; x=1764691357; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqpl2WN+S9iWcthCxem8RsD0XLSYeeBSXHkUH4PWWig=;
        b=kuvzVE3htMwlThxWE5dqXAtScLV18rMcUOoEMs2G6KXbf1yaX+f/bYiNbQKbUSIjdg
         +Hsd8lqMZL/kazFkR6u46GVAknHqeZLfOIhbjQG/UMudugwdIYfbuyU9DdMNuttj+R9L
         +ySo3wfu1MrXzNWkuXOkXmsz9pN3t6E65tfjsr7Wd8ao1H3itjmuE6Ow8GwgsiTrHTcg
         5TAGlWN6PEtYNbH5ZxjYAU7lTvXT+qhFj+HSCncvQqvWua96Qtttql1GpluyIFV2348Q
         ey/FVlfMyaSQLRark1aRo45zN0kNrFZtIco+E248IylMO+r97qAHgA9X7msX1L44m6Th
         ujdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764086557; x=1764691357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pqpl2WN+S9iWcthCxem8RsD0XLSYeeBSXHkUH4PWWig=;
        b=jowXM3oDD5QJlnY9OT2KmAQt9xxxC5lzlU0SPhRUVjpt4C+1eGYI+3le7W012d9Nyg
         fbJ9Q9XbttDbwsF0ZVd2Eq5AbeEHn+l/xYJZVc/Iq28lCGiFP7iTMDWGBcl730s8rmup
         aOtiYLbwf5+mvTfXsxOgh2u1I2BYMCGa1V9fyStHfxrepZ/KCHRrjKt7Y5vWDhyH8H1x
         1RZt7Rbfs+XSyZM66R/Yk5oNn2EG+z0Nx64roWF4JW45H2ppJ+Ngf56NZ4KUril/4BYB
         zxHhqPcUP+9B77op9iUB45NuJJwmwWI085NOMWCqOkYriq7tOeo4y59ha+tldW2vrx5i
         muXw==
X-Forwarded-Encrypted: i=1; AJvYcCXw0HQAozIApMihv1LThUganBk0E9/9gvnZWifJJePRKwnAERBJUAzMsQl3ncLe8s9LmUUiJ/GgHeM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7OtobsRscyFyAviODoNvd5pVRZrJBYpZF/SeUi6GlTZh3UELH
	AZ90jgetkxqwD11BzmrqQth3B5tIFmSUEmDTgA9IqvfdD6VazE10XYSVYAlndzxna3QNXL87+/l
	b7zkxXwOvyYJ8UFwSrRi8ZCLg6UnfgjWkY2MfLsqZaeiRMq1jjpYD
X-Gm-Gg: ASbGncvlQJh4+fmf5mO8ZciKwJPcUXP3xwOoTFlSHSGkX3G7J2nVKe2l72OkWzX9rY4
	WPZ/zEJkfIp+R2keWakpai16JeU9Znr2uNC26PDfzJyIfsseavDgDl3ERwRlLraHJgsuuRHMHc0
	qOgBaIgbc2uDr/HFxEVqWTtfuRwlfoX8KhdmWJWPFFsKAT8m0I72nK0VnsCQdcZOEVOv1f47O8s
	Hdu2NkK2v25+wLrbKdQUS5zzjyinWxb3w3rgLLTQeTfMdO++tOLugmaIQwObEqIydIkAdv0GCKy
	D25FXR4=
X-Google-Smtp-Source: AGHT+IGpO5BPMxeylIdMjWariOvCpXVT6NrfqSYCzNaodeR3am93shFU9PHr+I8yfzgj0ZXah/lNbkQ8g6/k76Pzjy8=
X-Received: by 2002:a05:690e:1548:10b0:641:f5bc:68d9 with SMTP id
 956f58d0204a3-64302aee469mr8861206d50.70.1764086556397; Tue, 25 Nov 2025
 08:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762933460-204066-1-git-send-email-shawn.lin@rock-chips.com>
 <1762933460-204066-2-git-send-email-shawn.lin@rock-chips.com> <7b05327d-fc76-471e-9148-3dfc0cd17623@rock-chips.com>
In-Reply-To: <7b05327d-fc76-471e-9148-3dfc0cd17623@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 17:02:00 +0100
X-Gm-Features: AWmQ_bm9QV4yvW5iHTMzjmKdqVj9ajUyBnx67ONCeq9Q2ozIo2PPx2RYZQeLlJc
Message-ID: <CAPDyKFrx_5cnyFeLRhoia2aHK9Cxo+fp_kKhyQ526xE02_+vSA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-dwcmshc: reduce CIT for better performance
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Sebastian Reichel <sebastian.reichel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 at 14:58, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2025/11/12 =E6=98=9F=E6=9C=9F=E4=B8=89 15:44, Shawn Lin =E5=86=
=99=E9=81=93:
> > CQHCI_SSC1.CIT indicates to the CQE the polling period to use for
> > periodic SEND_QUEUE_STATUS (CMD13) polling. Some eMMCs have only one
> > hardware queue, and CMD13 can only query one slot at a time for data
> > transmission, which cannot be processed in parallel. Modifying the
> > CMD13 query interval can increase the query frequency and improve
> > random write performance.
> >
>
> Ping...
>
> Adrain acked these two patches, so will them be candidates for 6.19
> given the merge windows is coming soon?

Looks like I simply failed to see them. Possibly because there was
cover-letter, which makes it harder for me to follow all the different
series.

Anyway, I tried to apply them, but there are conflicts that I am not
sure I can resolve easily by myself. Would you mind doing a re-base
and post a new version, then I can apply them asap.

Kind regards
Uffe

>
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > ---
> >
> >   drivers/mmc/host/cqhci.h            | 1 +
> >   drivers/mmc/host/sdhci-of-dwcmshc.c | 5 +++++
> >   2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> > index ce189a1..3668856 100644
> > --- a/drivers/mmc/host/cqhci.h
> > +++ b/drivers/mmc/host/cqhci.h
> > @@ -93,6 +93,7 @@
> >   /* send status config 1 */
> >   #define CQHCI_SSC1                  0x40
> >   #define CQHCI_SSC1_CBC_MASK         GENMASK(19, 16)
> > +#define CQHCI_SSC1_CIT_MASK          GENMASK(15, 0)
> >
> >   /* send status config 2 */
> >   #define CQHCI_SSC2                  0x44
> > diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdh=
ci-of-dwcmshc.c
> > index e276a4e..cad5165 100644
> > --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> > +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> > @@ -631,6 +631,11 @@ static void rk35xx_sdhci_cqe_pre_enable(struct mmc=
_host *mmc)
> >       struct dwcmshc_priv *dwc_priv =3D sdhci_pltfm_priv(pltfm_host);
> >       u32 reg;
> >
> > +     /* Set Send Status Command Idle Timer to 10.66us (256 * 1 / 24) *=
/
> > +     reg =3D sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI=
_SSC1);
> > +     reg =3D (reg & ~CQHCI_SSC1_CIT_MASK) | 0x0100;
> > +     sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_S=
SC1);
> > +
> >       reg =3D sdhci_readl(host, dwc_priv->vendor_specific_area2 + CQHCI=
_CFG);
> >       reg |=3D CQHCI_ENABLE;
> >       sdhci_writel(host, reg, dwc_priv->vendor_specific_area2 + CQHCI_C=
FG);
>
