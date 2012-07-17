From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: sd: Fix sd current limit setting
Date: Tue, 17 Jul 2012 21:43:28 +0800
Message-ID: <20120717134325.GA2567@localhost.localdomain>
References: <1341296172-10645-1-git-send-email-aaron.lu@amd.com>
 <1341296172-10645-3-git-send-email-aaron.lu@amd.com>
 <CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:42610 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab2GQNni (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Jul 2012 09:43:38 -0400
Received: by yenl2 with SMTP id l2so369395yen.19
        for <linux-mmc@vger.kernel.org>; Tue, 17 Jul 2012 06:43:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGxe1ZF=T7GL6ZcyV-=MEd5WVWexNrUbrEZDsYGdFD+KPH4XfA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>

On Tue, Jul 17, 2012 at 03:04:05PM +0530, Girish K S wrote:
> > @@ -261,6 +261,14 @@ struct mmc_host {
> >  #define MMC_CAP2_HC_ERASE_SZ   (1 << 9)        /* High-capacity erase size */
> >  #define MMC_CAP2_CD_ACTIVE_HIGH        (1 << 10)       /* Card-detect signal active high */
> >  #define MMC_CAP2_RO_ACTIVE_HIGH        (1 << 11)       /* Write-protect signal active high */
> > +#define MMC_CAP_MAX_CURRENT_200_300 (1 << 12)  /* Host max current limit is 200mA at 3.0V */
> > +#define MMC_CAP_MAX_CURRENT_400_300 (1 << 13)  /* Host max current limit is 400mA at 3.0V */
> > +#define MMC_CAP_MAX_CURRENT_600_300 (1 << 14)  /* Host max current limit is 600mA at 3.0V */
> > +#define MMC_CAP_MAX_CURRENT_800_300 (1 << 15)  /* Host max current limit is 800mA at 3.0V */
> > +#define MMC_CAP_MAX_CURRENT_200_330 (1 << 16)  /* Host max current limit is 200mA at 3.3V */
> > +#define MMC_CAP_MAX_CURRENT_400_330 (1 << 17)  /* Host max current limit is 400mA at 3.3V */
> > +#define MMC_CAP_MAX_CURRENT_600_330 (1 << 18)  /* Host max current limit is 600mA at 3.3V */
> > +#define MMC_CAP_MAX_CURRENT_800_330 (1 << 19)  /* Host max current limit is 800mA at 3.3V */
> sorry for seeing this late.
> The macro name should be **_CAP2_***.

Thanks for pointing this out, I'll be more careful next time.

> This is already merged in chris's mmc-next branch,
> Chris,
> Is it possible to change the macro name in the mmc-next branch for this patch?

Chris, please let me know how you want to deal with this and I'll be
glad to do whatever I can to fix this. Sorry for the trouble.

-Aaron
