Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9542203710
	for <linux-mmc@vger.kernel.org>; Tue, 12 May 2026 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546173; cv=none; b=Ez1/jkr5le+h0Y/IiWeb6/Van2eF6UUAJewJWoXU3Vo7QfBA1I/Sq0YPYNZ18hJvgSbTXUmPdCU0W6r/IelODiOjMuEaTOiC4uEk72hnaYGQ3jqEbZj5tUoi9Zv5fI0MgC22FGkpiS30pCVKabuMUKKVKuAMyZZ62r1RcdRpNDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546173; c=relaxed/simple;
	bh=blJBzgUHAUtaPJlb+5Oh7K4tbo9vv+d+DqDbf+DDSOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nwSyOqHlXm02oM6wvwY09942yUQh3MregbfVkyNjdXKEXOy0G/5bT6of79PTPXSllTuUI7SOcLU9K5+R6UXSWLiLCBELCIqla20S683KbROAUQeO8NxQkAe/EhtNp0PawH73/0ZvniEHEC25DQUEwi3fXyrn/0VwEKN8JMNkVVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CQ3a/qPK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQ3a/qPK"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bc85eda6b6so11151265ad.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 17:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778546171; x=1779150971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FrVVtUgfOTXQmbIBWwPggikMOHzXWvBM1dIScqMwVk4=;
        b=CQ3a/qPKOzWlb7qV7MRdFBX/G73r2lQWSOUGwlxZl44remuK4uexKMpHn7PsqIqcAp
         Dkx/8oH8Qo5cbubSMSuvTlL4ZZ4pb6dvScO9BvWCg9yw7NQya7ekd3nUwRTkgFRKxCz0
         1PkaXBCR4KQn7OdE2zo61IaV9a9Vbklxz3zcvlBS+NXwSYVfgLKJs3YAKwAN4RRXMGmX
         49E1prXacbuFTRbSpm4Omvd8Q2/J3xFeb18sB1VRgFO2AI/jGfpO+uVnwFgyVejNzTk1
         j25qPeICXyBmv3MlZ/yZPtxhckWKC6iDmWAEbWoHM9n9Oy3CTWZ5ZxxK9K8Xm8ZSLYFe
         /ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778546171; x=1779150971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrVVtUgfOTXQmbIBWwPggikMOHzXWvBM1dIScqMwVk4=;
        b=WnRGFXFEsdmOU/IrFAruHPpRThH8+tDXn+Dfxh2MR4ryS4F6Mk+vtex9jMaCoqNKgm
         W8+GLf7dz7y5MDW251FUrNEQMSATtnKD6ACMlLdkcomD7XMHELx8ry3Sk78DzEy8sldw
         zNof3U6p01/baEB+HLwaP9zFHQLOaM2l+dgR3wkzkJHneK0FWG+zP1IzFS3ZnuJULRr+
         WPu9AHEwJ78CFfa/CpaUFJx0rBS8FgZ/MjyLYIB+1itIQKKlSzXQlaDhsD9FvjpQ+Xty
         6WTEUZcMNo9dqZk+0Mn1rkKS4+6clp7cDgka5fSh5wnTQFkOrHYvCvZuD+1zp2EceYsa
         /dkA==
X-Forwarded-Encrypted: i=1; AFNElJ/YLJgi2+n/NaL8BaCN3uvlkHyBIeEgTT0PGMn3ryaRY3zx96SiJfKmBwff7knNQ2AFLZeJUL+NYHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNKdb3k9Ht4tXbhSThMjP3sOIPE1qVmWuf6Z9m3iufTzRb+Pd
	tSJ0iJGbUp2tx8hHs6cXprGDvPNkzoQWFJ6Ty9vmckIHCR4iDJ77miYh
X-Gm-Gg: Acq92OFFufjvovYQTd8Ue0eU9Kw9OtI/jvpTr5y964y96PyHL92tG1G0jxQSFdSBULv
	0pkGQdlc9eL3Xmu66ADej5Teo6ralE0ci4jiJLaqsiteoqtYVQb/OYr7DAj4xKpejV0KtAuKBNZ
	bcJbXxphInYnERgXOQefzfdLh8sVG7OzzodrMH4GkKu29edMhWF1f/4smSpFgvyUZ8mSDtwlzA8
	q5SWLEEeIYxdKt4H4BRJGFeRPalOKENK8UYnmnwelbKP13/3D6R9gTecix/lba/4oAk3Qy/BT3i
	qgNu30EJgyFtIwoED/NUQpkfcTHysyvEV+18UhUg7ltea4P1fYo3lxMnPTHnRmz/yOOqaTeG5Zn
	mFdIEjnE+mDLJK74Fsz/Z2OBCx/KrLM4RD9aS9OJIsX1ahbPZh9xtg1yWopWfmxMEEdGfYEPJ9T
	6ChHXcawsY87LXukec9y7OeME=
X-Received: by 2002:a17:902:ea01:b0:2b0:a957:304 with SMTP id d9443c01a7336-2baf0cf267dmr168280775ad.6.1778546171197;
        Mon, 11 May 2026 17:36:11 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm112248115ad.44.2026.05.11.17.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 17:36:10 -0700 (PDT)
Date: Tue, 12 May 2026 08:35:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, 
	Inochi Amaoto <inochiama@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
	Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>, 
	Paul Mackerras <paulus@ozlabs.org>, Maciej Dudek <mdudek@internships.antmicro.com>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v3 2/2] mmc: litex_mmc: Set mandatory idle clocks before
 CMD0
Message-ID: <agJ1ne0NbReqhrRO@inochi.infowork>
References: <20260426112016.1370929-1-inochiama@gmail.com>
 <20260426112016.1370929-3-inochiama@gmail.com>
 <CAPDyKFo-0h_=a5bSS1QFiXtasjRk06ERL7H+X=-U3J1+XX9TBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo-0h_=a5bSS1QFiXtasjRk06ERL7H+X=-U3J1+XX9TBg@mail.gmail.com>

On Mon, May 11, 2026 at 04:52:21PM +0200, Ulf Hansson wrote:
> On Sun, 26 Apr 2026 at 13:20, Inochi Amaoto <inochiama@gmail.com> wrote:
> >
> > The litex_mmc driver assumes the card is already probed in the BIOS
> > and skip the phy initialization. This will cause the command fail
> > like the following when the old card is unplugged and then insert
> > a new card:
> >
> > [   62.923593] litex-mmc f0004000.mmc: Command (cmd 8) error, status -110
> > [   62.949717] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   62.976606] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.002516] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> > [   63.028442] litex-mmc f0004000.mmc: Command (cmd 55) error, status -110
> >
> > Add required clock settings and initialization for the CMD 0, so it can
> > probe the new card.
> >
> > Fixes: 92e099104729 ("mmc: Add driver for LiteX's LiteSDCard interface")
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  drivers/mmc/host/litex_mmc.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
> > index a8d9c0ece16a..c984398d0803 100644
> > --- a/drivers/mmc/host/litex_mmc.c
> > +++ b/drivers/mmc/host/litex_mmc.c
> > @@ -68,6 +68,9 @@
> >  #define SD_SLEEP_US       5
> >  #define SD_TIMEOUT_US 20000
> >
> > +#define SD_INIT_DELAY_US  1000
> > +#define SD_INIT_CLK_HZ    400000
> > +
> >  #define SDIRQ_CARD_DETECT    1
> >  #define SDIRQ_SD_TO_MEM_DONE 2
> >  #define SDIRQ_MEM_TO_SD_DONE 4
> > @@ -142,6 +145,12 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
> >         int ret;
> >         u8 evt;
> >
> > +       if (cmd == MMC_GO_IDLE_STATE) {
> 
> Rather than doing this explicit check for each command being sent, we
> have the ->set_ios() callback where things like this belong. Please
> move it there instead.
> 

OK, And I think the patch 1 can be removed if this got moved
to set_ios(). I will prepare a new version for it.

Regards,
Inochi

> > +               litex_mmc_setclk(host, SD_INIT_CLK_HZ);
> > +               litex_write8(host->sdphy + LITEX_PHY_INITIALIZE, 1);
> > +               fsleep(SD_INIT_DELAY_US);
> > +       }
> > +
> >         litex_write32(host->sdcore + LITEX_CORE_CMDARG, arg);
> >         litex_write32(host->sdcore + LITEX_CORE_CMDCMD,
> >                       cmd << 8 | transfer << 5 | response_len);
> > --
> > 2.54.0
> >
> 
> Kind regards
> Uffe
