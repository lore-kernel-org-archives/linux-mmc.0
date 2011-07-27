From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH 1/1] fix card interrupt losing issue on freescale eSDHC
Date: Wed, 27 Jul 2011 11:42:51 +0200
Message-ID: <8762mokqjo.fsf@lebrac.rtp-net.org>
References: <1310966402-12318-1-git-send-email-tony.lin@freescale.com>
	<20110727074710.GS16561@pengutronix.de>
	<97D3A72708D04647A5AC84A04996E5B5166B17@039-SN1MPN1-006.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lebrac.rtp-net.org ([88.191.135.105]:32806 "EHLO
	lebrac.rtp-net.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752628Ab1G0JnP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2011 05:43:15 -0400
In-Reply-To: <97D3A72708D04647A5AC84A04996E5B5166B17@039-SN1MPN1-006.039d.mgd.msft.net>
	(Lin Tony-B's message of "Wed, 27 Jul 2011 09:27:15 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lin Tony-B19295 <B19295@freescale.com>
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>

Lin Tony-B19295 <B19295@freescale.com> writes:

Hi,

>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
>> kernel-bounces@lists.infradead.org] On Behalf Of Uwe Kleine-K?nig
>> Sent: Wednesday, July 27, 2011 3:47 PM
>> To: Lin Tony-B19295
>> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; kernel@pengutronix.de;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 1/1] fix card interrupt losing issue on freescale
>> eSDHC
>> 
>> Hello Tony,
>> 
>> On Mon, Jul 18, 2011 at 01:20:02PM +0800, Tony Lin wrote:
>> > apply workaround for imx eSDHC controller to avoid missing card
>> > interrupt so that SDIO function is workable
>> Fixing a few typos (but note, I'm not a native speaker):
>> 
>> 	mmc/sdhci-esdhc-imx: fix losing card interrupt
>> 
>> 	Apply workaround for the imx eSDHC controller to avoid missing a
>> 	card interrupt.
>> 
>> 	Signed-off-by: ...
>> 
>> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
>> > ---
>> >  drivers/mmc/host/sdhci-esdhc-imx.c |   39 +++++++++++++++++++++++++++-
>> -------
>> >  1 files changed, 30 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > index a19967d..da77cae 100644
>> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> > @@ -32,6 +32,8 @@
>> >  #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
>> >
>> >  #define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
>> > +
>> > +#define	SDHCI_CTRL_D3CD			0x08
>> >  /*
>> >   * The CMDTYPE of the CMD register (offset 0xE) should be set to
>> >   * "11" when the STOP CMD12 is issued on imx53 to abort one @@ -87,14
>> > +89,31 @@ static void esdhc_writel_le(struct sdhci_host *host, u32
>> > val, int reg)  {
>> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> >  	struct pltfm_imx_data *imx_data = pltfm_host->priv;
>> > -
>> > -	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
>> > -			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
>> > -		/*
>> > -		 * these interrupts won't work with a custom card_detect gpio
>> > -		 * (only applied to mx25/35)
>> > -		 */
>> > -		val &= ~(SDHCI_INT_CARD_REMOVE | SDHCI_INT_CARD_INSERT);
>> > +	u32 data;
>> > +
>> > +	if (unlikely((reg == SDHCI_INT_ENABLE || reg ==
>> SDHCI_SIGNAL_ENABLE))) {
>> > +		if (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)
>> > +			/*
>> > +			 * these interrupts won't work with a custom
>> > +			 * card_detect gpio (only applied to mx25/35)
>> hmm, ok, this was here before, but I wonder about the "only applied to
>> mx25/35" part. How is that meant? I don't see logic to prevent other socs
>> using this workaround.
> Sorry, not so sure about mx25/35 history. But the flag is set only if it's mx25 or mx35. 
> You can check the code in esdhc_pltfm_init.

btw, I didn't notice when looking at the patch but this flag has been
renamed and maybe will be gone. See :
- latest commits on this file on mmc for-next:
http://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=e8cd77e467f7bb1d4b942037c47b087334a484d4
- last patch of the imx mmc fixes for cd/wp:
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052743.html

So, imho, it would be better to use an other way to check for mx25/35 as
current one won't work (at least won't compile but won't work as
intended if the last patch mentionned is merged. There are other systems
using gpio for cd or wp which are not mx25/35).

Arnaud
