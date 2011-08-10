From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v1 1/1] mmc: sd: Handle SD3.0 cards not supporting UHS-I
 bus speed mode
Date: Wed, 10 Aug 2011 07:19:14 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B3000197F3F595@SAUSEXMBP01.amd.com>
References: <1312955161-24844-1-git-send-email-subhashj@codeaurora.org>
 <000001cc5756$e04dc9a0$a0e95ce0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:56471 "EHLO
	TX2EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931Ab1HJMWZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Aug 2011 08:22:25 -0400
In-Reply-To: <000001cc5756$e04dc9a0$a0e95ce0$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: 'Chris Ball' <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 'Philip Rakity' <prakity@marvell.com>

Hi Subhash,

Reviewed-by: Arindam Nath <arindam.nath@amd.com>


> -----Original Message-----
> From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> Sent: Wednesday, August 10, 2011 5:43 PM
> To: Nath, Arindam
> Subject: RE: [PATCH v1 1/1] mmc: sd: Handle SD3.0 cards not supporting
> UHS-I bus speed mode
> 
> Hi Arindam,
> 
> This is the same patch which talked about and you gave reviewed-by on
> that.
> Can you please look at this formal patch and give your reviewed-by?
> 
> Regards,
> Subhash
> 
> > -----Original Message-----
> > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> > Sent: Wednesday, August 10, 2011 11:16 AM
> > To: linux-mmc@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org; Subhash Jadavani
> > Subject: [PATCH v1 1/1] mmc: sd: Handle SD3.0 cards not supporting
> UHS-
> > I bus speed mode
> >
> > Here is Essential conditions to indicate Version 3.00 Card
> > (SD_SPEC=2 and SD_SPEC3=1) :
> > (1) The card shall support CMD6
> > (2) The card shall support CMD8
> > (3) The card shall support CMD42
> > (4) User area capacity shall be up to 2GB (SDSC) or 32GB (SDHC)
> >     User area capacity shall be more than or equal to 32GB and
> >     up to 2TB (SDXC)
> > (5) Speed Class shall be supported (SDHC or SDXC)
> >
> > So even if SD card doesn't support any of the newly defined
> > UHS-I bus speed mode, it can advertise itself as SD3.0 cards
> > as long as it supports all the essential conditions of
> > SD3.0 cards. Given this, these type of cards should atleast
> > run in High Speed mode @50MHZ if it supports HS.
> >
> > But current initialization sequence for SD3.0 cards is
> > such that these non-UHS-I SD3.0 cards runs in Default
> > Speed mode @25MHz.
> >
> > This patch makes sure that these non-UHS-I SD3.0 cards run
> > in High Speed Mode @50MHz.
> >
> > Tested this patch with SanDisk Extreme SDHC 8GB Class 10 card.
> >
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > ---
> >  drivers/mmc/core/sd.c |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index ff27741..e2dcf23 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -306,6 +306,9 @@ static int mmc_read_switch(struct mmc_card *card)
> >  		goto out;
> >  	}
> >
> > +	if (status[13] & 0x02)
> > +		card->sw_caps.hs_max_dtr = 50000000;
> > +
> >  	if (card->scr.sda_spec3) {
> >  		card->sw_caps.sd3_bus_mode = status[13];
> >
> > @@ -348,9 +351,6 @@ static int mmc_read_switch(struct mmc_card *card)
> >  		}
> >
> >  		card->sw_caps.sd3_curr_limit = status[7];
> > -	} else {
> > -		if (status[13] & 0x02)
> > -			card->sw_caps.hs_max_dtr = 50000000;
> >  	}
> >
> >  out:
> > --
> > 1.7.1.1
> >
> > --
> > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > Forum.
> 
> 


