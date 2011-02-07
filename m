From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 06 Feb 2011 19:55:53 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102061953030.12104@xanadu.home>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
 <20110206003845.GA15019@void.printf.net>
 <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
 <20110206011514.GA15322@void.printf.net>
 <173274DF-475D-44FB-8C34-25728D12ADBB@marvell.com> <4D4E826E.40905@yahoo.es>
 <00AF35E9-3CE0-44C7-AF18-E765AD5184D0@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:50784 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754348Ab1BGAz4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2011 19:55:56 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG800CR52KHDMA0@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sun, 06 Feb 2011 19:55:30 -0500 (EST)
In-reply-to: <00AF35E9-3CE0-44C7-AF18-E765AD5184D0@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Albert Herranz <albert_herranz@yahoo.es>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Sun, 6 Feb 2011, Philip Rakity wrote:

> 
> On Feb 6, 2011, at 3:13 AM, Albert Herranz wrote:
> 
> > Hi,
> > 
> > On 02/06/2011 02:35 AM, Philip Rakity wrote:
> >> 
> >> proposed solution:  I cannot verify this fix until Monday.
> >> =====
> >> 
> >> CMD52 is a reset for SDIO cards.  CMD0 is not sufficient when
> >> the card is being re-initialized.  Only send CMD52 if
> >> a) doing a reinitialize
> >> b) card is SDIO or SDIO_COMBO
> >> 
> >> Signed-off-by: Philip Rakity <prakity@marvell.com>
> >> ---
> >> drivers/mmc/core/core.c |    7 ++++++-
> >> 1 files changed, 6 insertions(+), 1 deletions(-)
> >> 
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 30d4da4..f0ce6f6 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1521,7 +1521,12 @@ static int mmc_rescan_try_freq(struct mmc_host *host, unsigned freq)
> >> 		mmc_hostname(host), __func__, host->f_init);
> >> #endif
> >> 	mmc_power_up(host);
> >> -	sdio_reset(host);
> >> +
> >> +	/* reset sdio before CMD0 when card is being reinitialized */
> >> +	if (host->card &&
> >> +		(host->card->type == MMC_TYPE_SDIO ||
> >> +		host->card->type == MMC_TYPE_SD_COMBO))
> >> +			sdio_reset(host);
> >> 	mmc_go_idle(host);
> >> 	mmc_hwungate_clock(host);
> >> 
> > 
> > At least on the Nintendo Wii, a platform reset _does not_ reset the SDIO hardware, and there is no known way to power-off/power-on it.
> > So, in some cases like after a system reboot, we need to issue a CMD52 before a CMD0 (even if on that particular case host->card is NULL) to properly reset the Nintendo Wii SDIO-based Wireless LAN card from its previous state, otherwise the card is not detected.
> > 
> > The proposed fix breaks this and makes the card unavailable after a system reboot.
> > 
> > If you are concerned about unconditionally issuing a CMD52 then we can use a quirk to make sure that we always perform a SDIO reset at least for the Nintendo Wii.
> 
> Would be happy with either a quirk or comment in the code.   Comment seems easiest.
> 
> /* sdhci_reset will generate CMD52 to reset card.  SD/eMMC cards are ignore this */
> 
> or something like that.

Indeed.  If always issuing cmd52 doesn't bother other types of cards, 
then I'd simply always send it without trying to be too smart.  On some 
other boards such as the SheevaPlug it is impossible to power off or 
reset the card too.


Nicolas
