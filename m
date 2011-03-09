From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 03/12] mmc: sd: query function modes for uhs cards
Date: Wed, 9 Mar 2011 12:16:58 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3AA21CF@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-4-git-send-email-arindam.nath@amd.com>
 <001801cbde63$89cf8bc0$9d6ea340$@org>
 <6C03668EAF45B747AF947A1603D1B300E3AA1EE8@SAUSEXMBP01.amd.com>
 <001b01cbde84$7c13c1b0$743b4510$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe004.messaging.microsoft.com ([213.199.154.142]:54038
	"EHLO DB3EHSOBE004.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302Ab1CISRV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Mar 2011 13:17:21 -0500
In-Reply-To: <001b01cbde84$7c13c1b0$743b4510$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "prakity@marvell.com" <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Subhash,


> -----Original Message-----
> From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> Sent: Wednesday, March 09, 2011 11:35 PM
> To: Nath, Arindam; cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: RE: [PATCH v2 03/12] mmc: sd: query function modes for uhs
> cards
> 
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > Sent: Wednesday, March 09, 2011 8:01 PM
> > To: subhashj@codeaurora.org; cjb@laptop.org
> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > Subject: RE: [PATCH v2 03/12] mmc: sd: query function modes for uhs
> > cards
> >
> > Hi Subhash,
> >
> >
> > > -----Original Message-----
> > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > Sent: Wednesday, March 09, 2011 7:39 PM
> > > To: Nath, Arindam; cjb@laptop.org
> > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > Subject: RE: [PATCH v2 03/12] mmc: sd: query function modes for uhs
> > > cards
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > > > Sent: Friday, March 04, 2011 5:03 PM
> > > > To: cjb@laptop.org
> > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> > > > subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
> > henry.su@amd.com;
> > > > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> > > > Subject: [PATCH v2 03/12] mmc: sd: query function modes for uhs
> > cards
> > > >
> > > > SD cards which conform to Physical Layer Spec v3.01 can support
> > > > additional Bus Speed Modes, Driver Strength, and Current Limit
> > > > other than the default values. We use CMD6 mode 0 to read these
> > > > additional card functions. The values read here will be used
> > > > during UHS-I initialization steps.
> > > >
> > > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > > > ---
> > > >  drivers/mmc/core/sd.c    |   99
> > > > +++++++++++++++++++++++++++++++++++++++-------
> > > >  include/linux/mmc/card.h |    3 +
> > > >  2 files changed, 87 insertions(+), 15 deletions(-)
> > > >
> > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > index 3e82599..a63956b 100644
> > > > --- a/drivers/mmc/core/sd.c
> > > > +++ b/drivers/mmc/core/sd.c
> > > > @@ -283,25 +283,94 @@ static int mmc_read_switch(struct mmc_card
> > > *card)
> > > >  		return -ENOMEM;
> > > >  	}
> > > >
> > > > -	err = mmc_sd_switch(card, 0, 0, 1, status);
> > > > -	if (err) {
> > > > -		/* If the host or the card can't do the switch,
> > > > -		 * fail more gracefully. */
> > > > -		if ((err != -EINVAL)
> > > > -		 && (err != -ENOSYS)
> > > > -		 && (err != -EFAULT))
> > > > +	if (card->scr.sda_spec3) {
> > > > +		/* First find out the supported Bus Speed Modes. */
> > > > +		err = mmc_sd_switch(card, 0, 0, 1, status);
> > > Reading function-group-1 status applies for both SD3.0 and SD2.0
> > cards
> > > as
> > > well. With card->scr.sda_spec check, you are duplicating the same
> > code
> > > in
> > > else part of it as well. You can optimize it to only one call to
> > > mmc_sd_switch() to read function-group-1.
> >
> > Yes, there is a duplication of the code. I will try to minimize it in
> > the next version.
> >
> > >
> > > > +		if (err) {
> > > > +			/*
> > > > +			 * If the host or the card can't do the switch,
> > > > +			 * fail more gracefully.
> > > > +			 */
> > > > +			if ((err != -EINVAL)
> > > > +			&& (err != -ENOSYS)
> > > > +			&& (err != -EFAULT))
> > > > +				goto out;
> > > > +
> > > > +			printk(KERN_WARNING "%s: problem reading "
> > > > +				"Bus Speed modes.\n",
> > > > +				mmc_hostname(card->host));
> > > > +			err = 0;
> > > > +
> > > >  			goto out;
> > > > +		}
> > > >
> > > > -		printk(KER	N_WARNING "%s: problem reading switch "
> > > > -			"capabilities, performance might suffer.\n",
> > > > -			mmc_hostname(card->host));
> > > > -		err = 0;
> > > > +		card->sw_caps.uhs_bus_mode = status[13];
> > > Is adding uhs* prefix is appropriate? If card supports SD3.0 spec
> > means
> > > card
> > > have to support UHS modes? Can we have cards (SDXC?) which sets
> SD3.0
> > > spec
> > > bit in SCR but does not support any of the UHS modes. So in this
> case
> > > putting uhs* prefix might not be appropriate.
> >
> > As per Physical Layer Spec v3.01, UHS-I can be applied to SDHC and
> SDXC
> > cards. Cards which support UHS-I should have sda_spec3 set in the SCR
> > register. Since we need to set the data rate depending on the exact
> > UHS-I speed mode, I have prefixed the variable with uhs_ to make
> things
> > clear.
> 
> UHS-I speed mode support is not a must condition to set SD_SPEC3 bit to
> 1 in
> SCR register:
> This is what the spec says:
> . Essential conditions to indicate Version 3.00 Card (SD_SPEC=2 and
> SD_SPEC3=1)
> (1) The card shall support CMD6
> (2) The card shall support CMD8
> (3) The card shall support CMD42
> (4) User area capacity shall be up to 2GB (SDSC) or 32GB (SDHC)
> User area capacity shall be more than or equal to 32GB and up to 2TB
> (SDXC)
> (5) Speed Class shall be supported (SDHC or SDXC)
> 
> Supporting UHS-I mode is an optional conditional.

Thanks for the clarification. I will change the variable names as sd3_*.

Arindam

> 
> >
> > Thanks,
> > Arindam
> >
> > >
> > >
> > > > +
> > > > +		/* Find out Driver Strengths supported by the card */
> > > > +		err = mmc_sd_switch(card, 0, 2, 1, status);
> > > > +		if (err) {
> > > > +			/*
> > > > +			 * If the host or the card can't do the switch,
> > > > +			 * fail more gracefully.
> > > > +			 */
> > > > +			if ((err != -EINVAL)
> > > > +			&& (err != -ENOSYS)
> > > > +			&& (err != -EFAULT))
> > > > +				goto out;
> > > > +
> > > > +			printk(KERN_WARNING "%s: problem reading "
> > > > +				"Driver Strength.\n",
> > > > +				mmc_hostname(card->host));
> > > > +			err = 0;
> > > >
> > > > -		goto out;
> > > > -	}
> > > > +			goto out;
> > > > +		}
> > > >
> > > > -	if (status[13] & 0x02)
> > > > -		card->sw_caps.hs_max_dtr = 50000000;
> > > > +		card->sw_caps.uhs_drv_type = status[9];
> > > > +
> > > > +		/* Find out Current Limits supported by the card */
> > > > +		err = mmc_sd_switch(card, 0, 3, 1, status);
> > > > +		if (err) {
> > > > +			/*
> > > > +			 * If the host or the card can't do the switch,
> > > > +			 * fail more gracefully.
> > > > +			 */
> > > > +			if ((err != -EINVAL)
> > > > +			&& (err != -ENOSYS)
> > > > +			&& (err != -EFAULT))
> > > > +				goto out;
> > > > +
> > > > +			printk(KERN_WARNING "%s: problem reading "
> > > > +				"Current Limit.\n",
> > > > +				mmc_hostname(card->host));
> > > > +			err = 0;
> > > > +
> > > > +			goto out;
> > > > +		}
> > > > +
> > > > +		card->sw_caps.uhs_curr_limit = status[7];
> > > > +	} else {
> > > > +		err = mmc_sd_switch(card, 0, 0, 1, status);
> > > > +		if (err) {
> > > > +			/*
> > > > +			 * If the host or the card can't do the switch,
> > > > +			 * fail more gracefully.
> > > > +			 */
> > > > +			if ((err != -EINVAL)
> > > > +			&& (err != -ENOSYS)
> > > > +			&& (err != -EFAULT))
> > > > +				goto out;
> > > > +
> > > > +			printk(KERN_WARNING "%s: problem reading switch
> "
> > > > +				"capabilities, performance might
> suffer.\n",
> > > > +				mmc_hostname(card->host));
> > > > +			err = 0;
> > > > +			goto out;
> > > > +		}
> > > > +
> > > > +		if (status[13] & 0x02)
> > > > +			card->sw_caps.hs_max_dtr = 50000000;
> > > > +	}
> > > >
> > > >  out:
> > > >  	kfree(status);
> > > > diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> > > > index 22b0335..7080f22 100644
> > > > --- a/include/linux/mmc/card.h
> > > > +++ b/include/linux/mmc/card.h
> > > > @@ -75,6 +75,9 @@ struct sd_ssr {
> > > >
> > > >  struct sd_switch_caps {
> > > >  	unsigned int		hs_max_dtr;
> > > > +	unsigned int		uhs_bus_mode;
> > > > +	unsigned int		uhs_drv_type;
> > > > +	unsigned int		uhs_curr_limit;
> > > >  };
> > > >
> > > >  struct sdio_cccr {
> > > > --
> > > > 1.7.1
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-
> > mmc"
> > > in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
> > >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


