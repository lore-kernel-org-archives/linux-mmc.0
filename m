From: "Maupin, Chase" <chase.maupin@ti.com>
Subject: RE: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
Date: Fri, 9 Mar 2012 13:06:07 +0000
Message-ID: <7D46E86EC0A8354091174257B2FED1012F06FAEF@DLEE12.ent.ti.com>
References: <1330622780-1909-1-git-send-email-Chase.Maupin@ti.com>
 <m2399iqtgf.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2CINGW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Mar 2012 08:06:22 -0500
In-Reply-To: <m2399iqtgf.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Thursday, March 08, 2012 10:39 PM
> To: Maupin, Chase
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] mmc: omap_hsmmc: set dto to 14 for all devices
> 
> Hi Chase,
> 
> On Thu, Mar 01 2012, Chase Maupin wrote:
> > * With certain SD cards timeouts like the following have been
> seen
> >   due to an improper calculation of the dto value:
> >     mmcblk0: error -110 transferring data, sector 4126233, nr 8,
> >     card status 0xc00
> > * By removing the dto calculation and setting the timeout value
> >   to the maximum specified by the SD card specification part A2
> >   section 2.2.15 these timeouts can be avoided.
> > * This change has been used by beagleboard users as well as the
> >   Texas Instruments SDK without a negative impact.
> > * There are multiple discussion threads about this but the most
> >   relevant ones are:
> >     * http://talk.maemo.org/showthread.php?p=1000707#post1000707
> >     * http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg42213.html
> > * Original proposal for this fix was done by Sukumar Ghoral of
> >   Texas Instruments
> >
> > * Tested using a Texas Instruments AM335x EVM
> >
> > Signed-off-by: Chase Maupin <Chase.Maupin@ti.com>
> 
> Thanks, I've pushed this to mmc-next for 3.4.  (With a trivial
> indentation fix, below.)

Thank you Chris.

> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c
> b/drivers/mmc/host/omap_hsmmc.c
> index 82b400793..9d4ce1c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1360,7 +1360,7 @@ static void set_data_timeout(struct
> omap_hsmmc_host *host)
>  	if (clkd == 0)
>  		clkd = 1;
> 
> -    /* Use the maximum timeout value allowed in the standard of 14
> or 0xE */
> +	/* Use the maximum timeout value allowed in the standard of
> 14 or 0xE */
>  	dto = 14;
> 
>  	reg &= ~DTO_MASK;
> 
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
