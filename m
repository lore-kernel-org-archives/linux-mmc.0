From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: Issue with non-UHS-I SD3.0 cards
Date: Fri, 5 Aug 2011 14:08:21 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B3000197DD107A@SAUSEXMBP01.amd.com>
References: <1312199897-5536-1-git-send-email-subhashj@codeaurora.org>
 <m2d3goc2r1.fsf@bob.laptop.org>
 <6C03668EAF45B747AF947A1603D1B3000197C66B0B@SAUSEXMBP01.amd.com>
 <000001cc50f4$5a9e5530$0fdaff90$@org>
 <6C03668EAF45B747AF947A1603D1B3000197C66BA2@SAUSEXMBP01.amd.com>
 <000601cc5111$64c0e9c0$2e42bd40$@org> <000001cc5373$e4e466e0$aead34a0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:2842 "EHLO
	VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753200Ab1HETMN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Aug 2011 15:12:13 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Philip Rakity' <prakity@marvell.com>, 'zhangfei gao' <zhangfei.gao@gmail.com>



> -----Original Message-----
> From: Nath, Arindam
> Sent: Saturday, August 06, 2011 12:27 AM
> To: 'Subhash Jadavani'; 'linux-mmc@vger.kernel.org'
> Cc: 'Chris Ball'; 'Philip Rakity'; 'zhangfei gao'
> Subject: RE: Issue with non-UHS-I SD3.0 cards
> 
> 
> 
> > -----Original Message-----
> > From: Nath, Arindam
> > Sent: Saturday, August 06, 2011 12:15 AM
> > To: 'Subhash Jadavani'; linux-mmc@vger.kernel.org
> > Cc: 'Chris Ball'; 'Philip Rakity'; 'zhangfei gao'
> > Subject: RE: Issue with non-UHS-I SD3.0 cards
> >
> > Hi Subhash,
> >
> >
> > > -----Original Message-----
> > > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> > > Sent: Friday, August 05, 2011 7:01 PM
> > > To: linux-mmc@vger.kernel.org
> > > Cc: Nath, Arindam; 'Chris Ball'; 'Philip Rakity'; 'zhangfei gao'
> > > Subject: Issue with non-UHS-I SD3.0 cards
> > >
> > > Hi,
> > >
> > > I am seeing the issue where "SanDisk Extreme SDHC 8GB Class 10
> card"
> > is
> > > running in "Default Speed" mode even though it supports "High
> Speed"
> > > mode.
> > > After analysis, I found that this card is advertising itself as
> SD3.0
> > > card
> > > (with SD_SPEC=2 and SD_SPEC3=1 in SCR). But current mmc core later
> > > initialization sequence for SD3.0 cards is such that these non-UHS-
> I
> > > SD3.0
> > > cards runs in Default Speed mode @25MHz.
> > >
> > > Here is Essential conditions to indicate Version 3.00 Card (from
> > SD3.01
> > > spec)
> > >     (SD_SPEC=2 and SD_SPEC3=1) :
> > >     (1) The card shall support CMD6
> > >     (2) The card shall support CMD8
> > >     (3) The card shall support CMD42
> > >     (4) User area capacity shall be up to 2GB (SDSC) or 32GB (SDHC)
> > >         User area capacity shall be more than or equal to 32GB and
> > >         up to 2TB (SDXC)
> > >     (5) Speed Class shall be supported (SDHC or SDXC)
> >
> > I went through the particular section of the spec again, and IMO, the
> > essential conditions are for the manufacturer of the card to
> advertise
> > his card as SD3.0 card or otherwise. From software point of view, the
> > SD_SPEC=2 _and_ SD_SPEC3=1 will indicate a SD3.0 card.
> 
> I misread your comment, so please ignore what you mentioned above. So

*so please ignore what I mentioned above*

Sorry for the typo.

> if I understand correctly, in your case *sd_spec3* is set for the card,
> even though it is a non UHS-I card. In that case, what you tried in
> your patch looks fine, except that I would suggest to move it inside
> the
> 
> if (card->scr.sda_spec3) {
> 	...
> }
> 
> condition.
> 
> >
> > Thanks,
> > Arindam
> >
> > >
> > >
> > > So even if SD card doesn't support any of the newly defined UHS-I
> bus
> > > speed
> > > mode, it can advertise itself as SD3.0 cards as long as it supports
> > all
> > > the
> > > essential conditions of SD3.0 cards. Given this, these type of
> cards
> > > should
> > > at least run in High Speed mode @50MHZ if it supports HS.
> > >
> > > Here are the changes you have to do to make non-UHS-I SD3.0 cards
> run
> > > in
> > > High Speed Mode @50MHz. Do let me know if looks fine or not, so I
> can
> > > post
> > > the formal patch.
> > >
> > > ---
> > >  drivers/mmc/core/sd.c |    6 +++---
> > >  1 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > index 907662a..3fab676 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -305,6 +305,9 @@ static int mmc_read_switch(struct mmc_card
> *card)
> > >                 goto out;
> > >         }
> > >
> > > +       if (status[13] & 0x02)
> > > +               card->sw_caps.hs_max_dtr = 50000000;
> > > +
> > >         if (card->scr.sda_spec3) {
> > >                 card->sw_caps.sd3_bus_mode = status[13];
> > >
> > > @@ -347,9 +350,6 @@ static int mmc_read_switch(struct mmc_card
> *card)
> > >                 }
> > >
> > >                 card->sw_caps.sd3_curr_limit = status[7];
> > > -       } else {
> > > -               if (status[13] & 0x02)
> > > -                       card->sw_caps.hs_max_dtr = 50000000;
> > >         }
> > >
> > >  out:
> > > --
> > >
> > >
> > > Regards,
> > > Subhash
> > >
> > >


