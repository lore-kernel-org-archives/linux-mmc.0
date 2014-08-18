From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [PATCH] mmc: core: optimize mmc device power up ramp up time
Date: Mon, 18 Aug 2014 06:54:04 +0000
Message-ID: <0AA7DC03D52A654FA5AF208AE38A967D01D7D5B3@shsmsx102.ccr.corp.intel.com>
References: <1408342625-23720-1-git-send-email-yunpeng.gao@intel.com>
 <17296D9F8FF2234F831FC3DF505A87A911B2268E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:38153 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbaHRGyI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Aug 2014 02:54:08 -0400
In-Reply-To: <17296D9F8FF2234F831FC3DF505A87A911B2268E@shsmsx102.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Dong, Chuanxiao
> Sent: Monday, August 18, 2014 2:19 PM
> To: Gao, Yunpeng; linux-mmc@vger.kernel.org
> Subject: RE: [PATCH] mmc: core: optimize mmc device power up ramp up time
> 
> > -----Original Message-----
> > From: Gao, Yunpeng
> > Sent: Monday, August 18, 2014 2:17 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Gao, Yunpeng; Dong, Chuanxiao
> > Subject: [PATCH] mmc: core: optimize mmc device power up ramp up time
> >
> > In current kernel mmc driver, it uses two 'msleep(10)'
> > for eMMC/SD card power up ramp up time delay.
> >
> > According to Spec, the ramp up time should be max of 74 eMMC/SD bus
> > clock or 1ms.
> > Take the worst eMMC/SD card I can image as the example - assume it has
> > to work on 32KHz or 16KHz during the card initialzation, then 74 clock
> > should be 2.312ms or 4.625ms.
> > So, 5ms delay should be enough.
> >
> > Also, msleep(10) will invlove sechdule and may consume more time than
> > what we expected.
> > Measured on Merrifield platform showed it consumed almost
> > 2*20 = 40ms. This is much more than what we expected.
> >
> > Submit this patch to reduce the time of mmc boot up and the time of
> > mmc D3 resume.
> >
> > Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> > Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
> > ---
> >  drivers/mmc/core/core.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
> > 7dc0c85..7bcb797 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1556,7 +1556,7 @@ void mmc_power_up(struct mmc_host *host, u32
> > ocr)
> >  	 * This delay should be sufficient to allow the power supply
> >  	 * to reach the minimum voltage.
> >  	 */
> > -	mmc_delay(10);
> > +	usleep_range(10000, 12000);
> 
> Instead of directly change the mmc_delay to usleep_range, I prefer to do it in
> changing the drivers/mmc/core/core.h:
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h index
> 443a584..b7584d8 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -55,9 +55,10 @@ static inline void mmc_delay(unsigned int ms)
>         if (ms < 1000 / HZ) {
>                 cond_resched();
>                 mdelay(ms);
> -       } else {
> +       } else if (ms < 20)
> +               usleep_range(ms * 1000, (ms + 1) * 1000);
> +       else
>                 msleep(ms);
> -       }
>  }
> 
> Thanks
> Chuanxiao

Thanks Chuanxiao for the comments.
I think it's better to redefine mmc_delay() instead of directly changing the mmc_delay() multiple times.

In Documentation/timers/timers-howto.txt, it mentioned that 'not msleep for (1ms - 20ms)'.
So, I think it's reasonable, in Chuanxiao's patch, to use usleep_range() for delay less than 20ms.

> >
> >  	host->ios.clock = host->f_init;
> >
> > @@ -1567,7 +1567,7 @@ void mmc_power_up(struct mmc_host *host, u32
> > ocr)
> >  	 * This delay must be at least 74 clock sizes, or 1 ms, or the
> >  	 * time required to reach a stable voltage.
> >  	 */
> > -	mmc_delay(10);
> > +	usleep_range(5000, 6000);
> >
> >  	mmc_host_clk_release(host);
> >  }
> > --
> > 1.7.9.5

