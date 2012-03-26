From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I card
Date: Mon, 26 Mar 2012 12:00:27 +0530
Message-ID: <000601cd0b19$f136c9c0$d3a45d40$@codeaurora.org>
References: <1332482196-22572-1-git-send-email-subhashj@codeaurora.org> <20120326031723.GA22292@ladygaga> <000401cd0b17$fcf7bd20$f6e73760$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:41016 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab2CZGae (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 02:30:34 -0400
In-Reply-To: <000401cd0b17$fcf7bd20$f6e73760$@codeaurora.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Aaron Lu' <aaron.lu@amd.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, arindam.nath@amd.com

> Also note that mmc_ios_show() function is currently not updated to print
the
> UHS-I bus speed modes in user readable format. We need to fix this as well
> probably as separate patch.

Aaron,
Sorry, I just realized that I was looking at 3.0 kernel code. In mmc-next, I
can see your patch which had updated mmc_ios_show() for printing ush bus
speed modes in text format. So ignore this. 

> Actually we are already printing the HS200/DDR (for eMMC) bus speed mode
> along with card detected print. So why not bus speed mode for UHS-I cards.
> It really gives good impression to user what this card is capable of doing
by
> just looking at this print.
> Correct we can this information from /sys/kernel/debug/mmc/ios but this
> needs extra effort than just looking at the kernel logs.

But still please check if this point makes sense?

Regards,
Subhash

> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> Sent: Monday, March 26, 2012 11:46 AM
> To: 'Aaron Lu'
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> arindam.nath@amd.com
> Subject: RE: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I card
> 
> 
> 
> > -----Original Message-----
> > From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> > owner@vger.kernel.org] On Behalf Of Aaron Lu
> > Sent: Monday, March 26, 2012 8:47 AM
> > To: Subhash Jadavani
> > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> > arindam.nath@amd.com
> > Subject: Re: [PATCH v1 1/1] mmc: bus: print bus speed mode of UHS-I
> > card
> >
> > Hi Subhash,
> >
> > On Fri, Mar 23, 2012 at 11:26:36AM +0530, Subhash Jadavani wrote:
> > > When UHS-I card is detected also print the bus speed mode in which
> > > UHS-I card will be running.
> >
> > The patch looks correct to me, except that I' m not sure if this is
> needed.
> > /sys/kernel/debug/mmc/ios also has such info.
> 
> Thanks for pointing it out.
> Actually we are already printing the HS200/DDR (for eMMC) bus speed mode
> along with card detected print. So why not bus speed mode for UHS-I cards.
> It really gives good impression to user what this card is capable of doing
by
> just looking at this print.
> Correct we can this information from /sys/kernel/debug/mmc/ios but this
> needs extra effort than just looking at the kernel logs.
> 
> Also note that mmc_ios_show() function is currently not updated to print
the
> UHS-I bus speed modes in user readable format. We need to fix this as well
> probably as separate patch.
> 
> Regards,
> Subhash
> 
> >
> > -Aaron
> >
> > >
> > > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > > ---
> > >  drivers/mmc/core/bus.c |   26 +++++++++++++++++++++++++-
> > >  1 files changed, 25 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c index
> > > 5d011a3..0517a91 100644
> > > --- a/drivers/mmc/core/bus.c
> > > +++ b/drivers/mmc/core/bus.c
> > > @@ -267,6 +267,7 @@ int mmc_add_card(struct mmc_card *card)  {
> > >  	int ret;
> > >  	const char *type;
> > > +	const char *uhs_bus_speed_mode = "";
> > >
> > >  	dev_set_name(&card->dev, "%s:%04x", mmc_hostname(card-
> host),
> > > card->rca);
> > >
> > > @@ -296,6 +297,28 @@ int mmc_add_card(struct mmc_card *card)
> > >  		break;
> > >  	}
> > >
> > > +	if (mmc_sd_card_uhs(card)) {
> > > +		switch (card->sd_bus_speed) {
> > > +		case UHS_SDR104_BUS_SPEED:
> > > +			uhs_bus_speed_mode = "SDR104 ";
> > > +			break;
> > > +		case UHS_SDR50_BUS_SPEED:
> > > +			uhs_bus_speed_mode = "SDR50 ";
> > > +			break;
> > > +		case UHS_DDR50_BUS_SPEED:
> > > +			uhs_bus_speed_mode = "DDR50 ";
> > > +			break;
> > > +		case UHS_SDR25_BUS_SPEED:
> > > +			uhs_bus_speed_mode = "SDR25 ";
> > > +			break;
> > > +		case UHS_SDR12_BUS_SPEED:
> > > +			uhs_bus_speed_mode = "SDR12 ";
> > > +			break;
> > > +		default:
> > > +			uhs_bus_speed_mode = "";
> > > +			break;
> > > +		}
> > > +	}
> > >  	if (mmc_host_is_spi(card->host)) {
> > >  		pr_info("%s: new %s%s%s card on SPI\n",
> > >  			mmc_hostname(card->host),
> > > @@ -303,12 +326,13 @@ int mmc_add_card(struct mmc_card *card)
> > >  			mmc_card_ddr_mode(card) ? "DDR " : "",
> > >  			type);
> > >  	} else {
> > > -		pr_info("%s: new %s%s%s%s card at address %04x\n",
> > > +		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
> > >  			mmc_hostname(card->host),
> > >  			mmc_card_uhs(card) ? "ultra high speed " :
> > >  			(mmc_card_highspeed(card) ? "high speed " : ""),
> > >  			(mmc_card_hs200(card) ? "HS200 " : ""),
> > >  			mmc_card_ddr_mode(card) ? "DDR " : "",
> > > +			uhs_bus_speed_mode,
> > >  			type, card->rca);
> > >  	}
> > >
> > > --
> > > 1.7.1.1
> > >
> > > --
> > > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum.
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
> in
> > the body of a message to majordomo@vger.kernel.org More majordomo
> info
> > at  http://vger.kernel.org/majordomo-info.html
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

