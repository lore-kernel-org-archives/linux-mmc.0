From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: UHS-I bus speed mode should be set last in UHS initialization
Date: Tue, 14 Jun 2011 22:00:00 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300015F9F47DD@SAUSEXMBP01.amd.com>
References: <000a01cc2a04$09c9d600$1d5d8200$@org>
 <6C03668EAF45B747AF947A1603D1B300015F91E376@SAUSEXMBP01.amd.com>
 <000001cc2aee$dd8a8e90$989fabb0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:38494
	"EHLO CH1EHSOBE014.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753965Ab1FODDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2011 23:03:18 -0400
In-Reply-To: <000001cc2aee$dd8a8e90$989fabb0$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "subhashj@codeaurora.org" <subhashj@codeaurora.org>
Cc: 'Philip Rakity' <prakity@marvell.com>, 'zhangfei gao' <zhangfei.gao@gmail.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Lu, Aaron" <Aaron.Lu@amd.com>

Hi Philip,

Can you please confirm what should be the correct implementation?

Thanks,
Arindam

> -----Original Message-----
> From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> Sent: Wednesday, June 15, 2011 5:28 AM
> To: Nath, Arindam
> Cc: 'Philip Rakity'; 'zhangfei gao'; cjb@laptop.org; linux-
> mmc@vger.kernel.org; Lu, Aaron
> Subject: RE: UHS-I bus speed mode should be set last in UHS
> initialization
> 
> Hi Arindam,
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > Sent: Tuesday, June 14, 2011 12:00 AM
> > To: subhashj@codeaurora.org
> > Cc: Philip Rakity; zhangfei gao; cjb@laptop.org; linux-
> > mmc@vger.kernel.org; Lu, Aaron
> > Subject: RE: UHS-I bus speed mode should be set last in UHS
> > initialization
> >
> > Adding Philip and Zhangfei.
> >
> > Hi Subhash,
> >
> > Does your controller follow some non-standard steps for
> initialization?
> > I referred to Figure 3-14, section 3.9.4 of Physical Layer Spec
> v3.01,
> > and it shows the order, setting Driver Strength Select, Bus Speed
> Mode,
> > and then Current Limit. So please confirm back.
> 
> Sorry, I don't know what do you mean by non standard steps for
> initialization. Nowhere in v3.01 spec, it is mentioned that Bus speed
> mode
> **must** be set before current limit. Figure 3-14 also doesn't indicate
> this.
> 
> If you set the bus speed mode in sd_set_bus_speed_mode(), you are
> changing
> the host controller timings as well and if it's SDR50/SDR104 mode, then
> immediately after setting the host controller timing mode, we have to
> execute tuning sequence but here before executing tuning sequence, you
> are
> sending the CMD6 which involves the read data transfer from card which
> is
> bound to fail without tuning and it does fail with our host controller.
> 
> Do let me know if this explanation make sense.
> 
> Regards,
> Subhash
> 
> >
> > Thanks,
> > Arindam
> >
> > > -----Original Message-----
> > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > Sent: Tuesday, June 14, 2011 1:27 AM
> > > To: Nath, Arindam
> > > Subject: FW: UHS-I bus speed mode should be set last in UHS
> > > initialization
> > >
> > > Hi Arindam,
> > >
> > > Does this change make sense for you? If yes, then I can go ahead
> and
> > > post a
> > > patch for this.
> > >
> > > Regards,
> > > Subhash
> > >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org
> > > [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Subhash
> > Jadavani
> > > Sent: Monday, June 06, 2011 3:44 PM
> > > To: linux-mmc@vger.kernel.org
> > > Subject: UHS-I bus speed mode should be set last in UHS
> > initialization
> > >
> > > Hi Chris, Arindam,
> > >
> > > mmc_sd_init_uhs_card function sets the driver type, current limit
> and
> > > bus
> > > speed mode on card as well as on host controller side. Currently
> bus
> > > speed
> > > mode is set by sending CMD6 to card and setting timing mode in host
> > > controller and then before initiating tuning sequence, it also
> tries
> > to
> > > set current limit by sending CMD6 to card which fails on our host
> > > controller (due to data CRC or timeout errors) if bus speed mode is
> > > SDR50/SDR104 mode.
> > >
> > > So basically bus speed mode should be set only after current limit
> is
> > > set
> > > in the card and immediately after setting the bus speed mode,
> tuning
> > > sequence should be initiated. So following changes is needed. If it
> > > looks
> > > fine then I can send you this change in patch.
> > >
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> > > 0da37eb..19634d5 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -610,13 +610,13 @@ static int mmc_sd_init_uhs_card(struct
> mmc_card
> > > *card)
> > >         if (err)
> > >                 goto out;
> > >
> > > -       /* Set bus speed mode of the card */
> > > -       err = sd_set_bus_speed_mode(card, status);
> > > +       /* Set current limit for the card */
> > > +       err = sd_set_current_limit(card, status);
> > >         if (err)
> > >                 goto out;
> > >
> > > -       /* Set current limit for the card */
> > > -       err = sd_set_current_limit(card, status);
> > > +       /* Set bus speed mode of the card */
> > > +       err = sd_set_bus_speed_mode(card, status);
> > >         if (err)
> > >                 goto out;
> > >
> > > Regards,
> > > Subhash
> > >
> > > --
> > > Sent by a consultant of the Qualcomm Innovation Center, Inc.
> > > The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> > > Forum.
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> mmc"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


