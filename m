From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: [PATCH] atmel-mci: fix transfers < 16 bytes problem in PDC mode
Date: Wed, 18 Dec 2013 09:09:41 +0100
Message-ID: <20131218080925.GA26149@hposo>
References: <20131204080943.GK3582@odulo-laptop>
 <1386236716-25163-1-git-send-email-olivier@sobrie.be>
 <20131213110913.GB2138@ldesroches-Latitude-E6320>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:49723 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab3LRIJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2013 03:09:48 -0500
Received: by mail-ee0-f44.google.com with SMTP id b57so3336567eek.17
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2013 00:09:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131213110913.GB2138@ldesroches-Latitude-E6320>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org

Hi Ludovic,

On Fri, Dec 13, 2013 at 12:09:13PM +0100, Ludovic Desroches wrote:
> Hi Olivier,
> 
> On Thu, Dec 05, 2013 at 10:45:16AM +0100, Olivier Sobrie wrote:
> 
> [...]
> 
> > With this patch I'm able to use the wlan sdio module wl1271.
> > When you've time, it would be nice to validate or fix this
> > patch.
> 
> I have tested it and it doesn't solve issue I have with Atheros module.

What kind of errors do you see with this module?
Timeouts on some SDIO commands with small datasize?

>  
> > Thanks for your help,
> > 
> > Olivier
> > 
> >  drivers/mmc/host/atmel-mci.c |    6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index b86b482..c599731 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -45,6 +45,7 @@
> >  
> >  #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
> >  #define ATMCI_DMA_THRESHOLD	16
> > +#define ATMCI_PDC_MIN_DATASIZE	16
> >  
> >  enum {
> >  	EVENT_CMD_RDY = 0,
> > @@ -765,7 +766,10 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
> >  	}
> >  
> >  	if (host->data_size <= buf_size) {
> > -		if (host->data_size & 0x3) {
> > +		if ((host->data_size < ATMCI_PDC_MIN_DATASIZE) &&
> > +		    (dir == XFER_TRANSMIT)) {
> > +			atmci_writel(host, counter_reg, 4);
> > +		} else if (host->data_size & 0x3) {
> 
> I have feedback from people who have issue with atmel-mci driver but not
> with at91-mci which has been removed unfortunately (it seems I had the
> only sdio wifi module working with atmel-mci driver in pdc mode...). So I
> think the 12 bytes value in the errata is correct.

Does the atheros module work with the at91-mci driver ?

> 
> Moreover I am afraid that this patch could cause some other bugs. I mean the
> transfer size is 4 bytes, the sg length is 4 bytes too and we will ask
> PDC to perform a bigger transfer... With the previous driver it was not a
> problem because we didn't use sg directly, they were copied into another
> buffer.

Ok. I'll have a look at the old at91-mci driver.

Thanks,

-- 
Olivier
