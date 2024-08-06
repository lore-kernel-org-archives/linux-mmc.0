Received: from jpms-ob01.noc.sony.co.jp (jpms-ob01.noc.sony.co.jp [211.125.140.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CEA625;
	Tue,  6 Aug 2024 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.140.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722908776; cv=none; b=Sxm4KcwuhVEEbEmadBwS+2cxZTHgmvBZDa3+j6nPslE7wSIK0VCRT2wrujzGvPEb9JWSMq8uzIdri61PMWdg3qsp3sLC1cb1zkihb+cBKuW3FDWqSzxki+uQjBcQ9ZDr/42x3MJGn9PvChBBk5ffGlCpiTp1RuYwvcXjM9lTH1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722908776; c=relaxed/simple;
	bh=PN2WYtrMkPO/2AIM0NOaircCgusQi2bOHSQYLj+X8Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq7IYW9jCKIU0etsKCIt/GgMrnLGqic1hgAY8KYjIUrYCRuzJ/Bjhq58OQOTxDF/rdlhJ/ryl8X+zjsvmfEEvwmKREOYhZbV588cUHJb7ELf0Mb23on1f2/SSf71xlGDO1ezIYXw8qHh/l7ICLovi3jPV5zthOf4myzpjH+hcYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=wVyppMX6; arc=none smtp.client-ip=211.125.140.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="wVyppMX6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1722908773; x=1754444773;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WeBvTic2bppPI7/toUgsscC2plQem/Mw3G2AfbZQKk=;
  b=wVyppMX67yWObapC+MS9MJr9goq7aCXPOHSKlJbUsPLm+fMZa9Tv1sgP
   XdPYRUeufUbPhq2WZU45+PiE84JWNf8ArUceLDavYLRnj4y7ILc0RofDf
   ECo9mvYhhBT2AFklxzeD42nmonNguGnqviCloFFzOTaNOnpa2/Hhw4qEp
   S/vFLS81a9NTa0jakMHX2gzutfLNPYkHK+t4y8mO9W6DBbdnNneBEvvNK
   WJ7j2JfM6HqyXbfDS3akOv91AGXa4oxnFAPdtXNek2dNotbYniSYLRv0O
   lZ8VJc3oHOnhW0dGKX3lPMhG48bv4QQ3p1br/yVbwf374BngBD484CAzK
   Q==;
Received: from unknown (HELO jpmta-ob02.noc.sony.co.jp) ([IPv6:2001:cf8:0:6e7::7])
  by jpms-ob01.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 10:36:03 +0900
X-IronPort-AV: E=Sophos;i="6.09,266,1716217200"; 
   d="scan'208";a="419612431"
Received: from unknown (HELO LXJ00013846) ([IPv6:2001:cf8:1:1611:9e7b:efff:fe46:27de])
  by jpmta-ob02.noc.sony.co.jp with ESMTP; 06 Aug 2024 10:36:03 +0900
Date: Tue, 6 Aug 2024 10:36:10 +0900
From: Keita Aihara <keita.aihara@sony.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com,
	Shingo.Takeuchi@sony.com, Masaya.Takahashi@sony.com,
	keita.aihara@sony.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mmc: core: apply SD quirks earlier during probe
Message-ID: <20240806013610.GA3438728@sony.com>
References: <20240802032121.GA4019194@sony.com>
 <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 12:14:25PM +0200, Ulf Hansson wrote:
> On Fri, 2 Aug 2024 at 05:21, Keita Aihara <keita.aihara@sony.com> wrote:
> >
> > Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> > registers are parsed prior to the quirk being applied in mmc_blk.
>
> In what way is it a problem to read the extended registers first?

SD quirks are referenced by mmc_card_broken_sd_cache() in
sd_parse_ext_reg_perf(). If the quirk is set, SD_EXT_PERF_CACHE is not
set to card->ext_perf.feature_support and the cache support will not be
enabled.

Therefore, SD quirks should be initialized before parsing the extension
registers.

>
> >
> > Split this out into an SD-specific list of quirks and apply in
> > mmc_sd_init_card instead.
> >
> > Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> > Authored-by: Jonathan Bell <jonathan@raspberrypi.com>
> > Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> > Signed-off-by: Keita Aihara <keita.aihara@sony.com>
>
> Kind regards
> Uffe

Best regards,
Keita Aihara

>
> > ---
> >  drivers/mmc/core/quirks.h | 22 +++++++++++++---------
> >  drivers/mmc/core/sd.c     |  4 ++++
> >  2 files changed, 17 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> > index cca71867bc4a..92905fc46436 100644
> > --- a/drivers/mmc/core/quirks.h
> > +++ b/drivers/mmc/core/quirks.h
> > @@ -15,6 +15,19 @@
> >
> >  #include "card.h"
> >
> > +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
> > +       /*
> > +        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> > +        * This has so far only been observed on cards from 11/2019, while new
> > +        * cards from 2023/05 do not exhibit this behavior.
> > +        */
> > +       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> > +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> > +                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> > +
> > +       END_FIXUP
> > +};
> > +
> >  static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> >  #define INAND_CMD38_ARG_EXT_CSD  113
> >  #define INAND_CMD38_ARG_ERASE    0x00
> > @@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
> >         MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
> >                   MMC_QUIRK_BLK_NO_CMD23),
> >
> > -       /*
> > -        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> > -        * This has so far only been observed on cards from 11/2019, while new
> > -        * cards from 2023/05 do not exhibit this behavior.
> > -        */
> > -       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> > -                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> > -                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> > -
> >         /*
> >          * Some SD cards lockup while using CMD23 multiblock transfers.
> >          */
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 1c8148cdda50..ee37ad14e79e 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -26,6 +26,7 @@
> >  #include "host.h"
> >  #include "bus.h"
> >  #include "mmc_ops.h"
> > +#include "quirks.h"
> >  #include "sd.h"
> >  #include "sd_ops.h"
> >
> > @@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
> >                         goto free_card;
> >         }
> >
> > +       /* Apply quirks prior to card setup */
> > +       mmc_fixup_device(card, mmc_sd_fixups);
> > +
> >         err = mmc_sd_setup_card(host, card, oldcard != NULL);
> >         if (err)
> >                 goto free_card;
> > --
> > 2.43.2
> >
