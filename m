From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH 2/2] mmc: core: fix the signaling 1.8V for HS200
Date: Wed, 25 Apr 2012 11:54:06 +0530
Message-ID: <000201cd22ac$06857020$13905060$@codeaurora.org>
References: <003001cd2131$07773760$1665a620$%jun@samsung.com> <4F966071.8080309@codeaurora.org> <003f01cd22a2$7c082f90$74188eb0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:40341 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758932Ab2DYGYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 02:24:11 -0400
In-Reply-To: <003f01cd22a2$7c082f90$74188eb0$%jun@samsung.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Seungwon Jeon' <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>


> -----Original Message-----
> From: Seungwon Jeon [mailto:tgih.jun@samsung.com]
> Sent: Wednesday, April 25, 2012 10:46 AM
> To: 'Subhash Jadavani'
> Cc: linux-mmc@vger.kernel.org; 'Chris Ball'; 'Girish K S'
> Subject: RE: [PATCH 2/2] mmc: core: fix the signaling 1.8V for HS200
> 
> Subhash Jadavani <subhashj@codeaurora.org> wrote:
> > Hi Seungwon,
> >
> > On 4/23/2012 2:41 PM, Seungwon Jeon wrote:
> > > Currently only 1.2V is treated for HS200 mode. If the host has only
> > > 1.8V I/O capability not 1.2V, mmc_set_signal_voltage can't be called
> > > for 1.8V HS200. EXT_CSD_CARD_TYPE_SDR_1_8V needs to be considered.
> > Commit text looks confusing to me. In this change, you are trying to
> > set the 1.8V I/O voltage only if there is an error setting the 1.2v
> > I/O? Can you please clarify more?
> This patch's purpose is to support 1.8V I/O. Origin considers only 1.2V I/O case.
> If the host has only 1.8V capability and card type is HS200 1.8V, there is no way
> to 1.8V I/O.

Thanks for clarification. I was assuming that most of the devices will have I/O voltage always set to 1.8v by host (when device is powered up) but yes, according to spec, it's possible that I/O may be at 3.3v (high voltage) as well.
This patch looks good to me.

Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>

Regards,
Subhash

> 
> Assuming that card is type of HS200 1.2V and host has 1.2V capability, the 1.2
> I/O voltage will be tried. If it succeeds in 1.2V I/O , we don't need to trying the
> 1.8V I/O voltage though 1.8V I/O is possible.
> But the 1.8V I/O may be tried in case of 1.2V I/O failure, so error condition is
> needed.
> 
> And error is initialized by -EINVAL at the first time.
> Thus, if card and host only are capable of 1.8V I/O, we can try to set the 1.8V
> I/O regardless of 1.2V I/O result.
> 
> Best regards,
> Seungwon Jeon.
> 
> > >
> > > Signed-off-by: Seungwon Jeon<tgih.jun@samsung.com>
> > > ---
> > >   drivers/mmc/core/mmc.c |   12 +++++++-----
> > >   1 files changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> > > ebb9522..71eb320 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -732,7 +732,7 @@ static int mmc_select_powerclass(struct mmc_card
> *card,
> > >    */
> > >   static int mmc_select_hs200(struct mmc_card *card)
> > >   {
> > > -	int idx, err = 0;
> > > +	int idx, err = -EINVAL;
> > >   	struct mmc_host *host;
> > >   	static unsigned ext_csd_bits[] = {
> > >   		EXT_CSD_BUS_WIDTH_4,
> > > @@ -748,10 +748,12 @@ static int mmc_select_hs200(struct mmc_card
> *card)
> > >   	host = card->host;
> > >
> > >   	if (card->ext_csd.card_type&  EXT_CSD_CARD_TYPE_SDR_1_2V&&
> > > -	    host->caps2&  MMC_CAP2_HS200_1_2V_SDR)
> > > -		if (mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_120, 0))
> > > -			err = mmc_set_signal_voltage(host,
> > > -
> MMC_SIGNAL_VOLTAGE_180, 0);
> > > +			host->caps2&  MMC_CAP2_HS200_1_2V_SDR)
> > > +		err = mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_120, 0);
> > > +
> > > +	if (err&&  card->ext_csd.card_type&
> EXT_CSD_CARD_TYPE_SDR_1_8V&&
> > > +			host->caps2&  MMC_CAP2_HS200_1_8V_SDR)
> > > +		err = mmc_set_signal_voltage(host,
> MMC_SIGNAL_VOLTAGE_180, 0);
> > >
> > >   	/* If fails try again during next card power cycle */
> > >   	if (err)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> > in the body of a message to majordomo@vger.kernel.org More majordomo
> > info at  http://vger.kernel.org/majordomo-info.html


