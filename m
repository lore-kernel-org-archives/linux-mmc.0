From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 1/3] mmc: tmio: correct treatment of errors during
 tuning
Date: Tue, 13 Feb 2018 12:31:58 +0100
Message-ID: <20180213113157.gr2guro2smyixaiw@verge.net.au>
References: <20180119133906.11280-1-horms+renesas@verge.net.au>
 <20180119133906.11280-2-horms+renesas@verge.net.au>
 <20180207215252.dirj5x7ky5bdznmk@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47808 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933926AbeBMLcC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Feb 2018 06:32:02 -0500
Content-Disposition: inline
In-Reply-To: <20180207215252.dirj5x7ky5bdznmk@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org

On Wed, Feb 07, 2018 at 10:52:52PM +0100, Wolfram Sang wrote:
> On Fri, Jan 19, 2018 at 02:39:04PM +0100, Simon Horman wrote:
> > From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> > 
> > If the return value of mmc_send_tuning() is error other than -EILSEQ, the
> > tuning fails and process goes out of for_loop.  But the correct processing
> > is to judge their TAP as bad.
> 
> Ideally, we would have more specific reasons why this is correct processing.
> 
> What other codes could happen here?

I mistakenly attached log below following to patch 2/3 rather than 1/3 (this
patch) which explains my reason for including this patch in the series.

However, I am no longer able to reproduce this problem - I tried to do so
in order to work out which errors were being handled differently with
and without the patch.

I think we can drop this patch for now.



* M3-W ES1.0 / Salvator-X

[    1.812758] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    1.818778] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    1.874951] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000
+max clock rate 200 MHz
[    1.884950] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    1.891088] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    2.083508] mmc0: new HS400 MMC card at address 0001
[    2.084827] mmcblk0: mmc0:0001 eMMC   28.8 GiB
[    2.085234] mmcblk0boot0: mmc0:0001 eMMC   partition 1 4.00 MiB
[    2.085727] mmcblk0boot1: mmc0:0001 eMMC   partition 2 4.00 MiB
[    2.086398] mmcblk0rpmb: mmc0:0001 eMMC   partition 3 4.00 MiB, chardev
+(243:0)
[    2.097926]  mmcblk0: p1
[    2.360533] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.367633] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    2.424700] renesas_sdhi_internal_dmac ee100000.sd: mmc1 base at 0xee100000
+max clock rate 200 MHz
[    2.436021] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    2.443100] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO

* On H3 ES2.0 / Salvator-XS:

[    2.452354] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.458344] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    2.513917] renesas_sdhi_internal_dmac ee140000.sd: mmc0 base at 0xee140000
+max clock rate 200 MHz
[    2.523564] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    2.529559] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO
[    2.636678] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.643739] mmc0: tuning execution failed: -5
[    2.648211] mmc0: error -5 whilst initialising MMC card
[    2.730078] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.730085] mmc0: tuning execution failed: -5
[    2.730093] mmc0: error -5 whilst initialising MMC card
[    2.858718] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    2.858725] mmc0: tuning execution failed: -5
[    2.858733] mmc0: error -5 whilst initialising MMC card
[    2.991258] renesas_sdhi_internal_dmac ee100000.sd: Got CD GPIO
[    2.998333] renesas_sdhi_internal_dmac ee100000.sd: Got WP GPIO
[    3.063121] renesas_sdhi_internal_dmac ee140000.sd: Tuning procedure failed
[    3.063128] mmc0: tuning execution failed: -5
[    3.063135] mmc0: error -5 whilst initialising MMC card
[    3.085170] renesas_sdhi_internal_dmac ee160000.sd: Got CD GPIO
[    3.092222] renesas_sdhi_internal_dmac ee160000.sd: Got WP GPIO

> 
> > Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2 [Simon Horman]
> > * Added to patchset targeted at upstream
> > * Minor revision of changelog
> > 
> > v0 [Masaharu Hayakawa]
> > ---
> >  drivers/mmc/host/tmio_mmc_core.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> > index 6d8719be75a8..41767d33ef97 100644
> > --- a/drivers/mmc/host/tmio_mmc_core.c
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -800,10 +800,7 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> >  		if (host->prepare_tuning)
> >  			host->prepare_tuning(host, i % host->tap_num);
> >  
> > -		ret = mmc_send_tuning(mmc, opcode, NULL);
> > -		if (ret && ret != -EILSEQ)
> > -			goto out;
> > -		if (ret == 0)
> > +		if (!mmc_send_tuning(mmc, opcode, NULL))
> 
> I'd prefer (mmc_send_tuning() == 0) here instead of '!mmc_send_tuning()'.
> This reads as 'is ok' while the other reads more 'if not ok'.
> 
> >  			set_bit(i, host->taps);
> >  
> >  		usleep_range(1000, 1200);
> > -- 
> > 2.11.0
> > 


