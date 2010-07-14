From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] mmc: csd version check updated to support MMC v4.41
Date: Wed, 14 Jul 2010 17:49:20 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E27D730@dbde02.ent.ti.com>
References: <1279095667-21255-1-git-send-email-s-ghorai@ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870305CE5795@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58423 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0GNMTZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2010 08:19:25 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305CE5795@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



> -----Original Message-----
> From: Sripathy, Vishwanath
> Sent: Wednesday, July 14, 2010 5:23 PM
> To: Ghorai, Sukumar; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Subject: RE: [PATCH] mmc: csd version check updated to support MMC v4.41
> 
> 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Ghorai, Sukumar
> > Sent: Wednesday, July 14, 2010 1:51 PM
> > To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> > Cc: Ghorai, Sukumar
> > Subject: [PATCH] mmc: csd version check updated to support MMC v4.41
> >
> >  CSD_STRUCTURE [127:126] describes the version of the CSD structure.
> >  According to the MMC specificaiton (v4.4.1), 3 is also a valid number.
> >
> > Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> > ---
> >  Tested on omap4430 ES2.0
> >
> >  drivers/mmc/core/mmc.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 89f7a25..525af33 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -122,7 +122,7 @@ static int mmc_decode_csd(struct mmc_card *card)
> >  	 * v1.2 has extra information in bits 15, 11 and 10.
> >  	 */
> >  	csd_struct = UNSTUFF_BITS(resp, 126, 2);
> > -	if (csd_struct != 1 && csd_struct != 2) {
> > +	if (csd_struct > 3) {
> 
> Can't csd_struct be 0? If so then your new check will break right?
[Ghorai] 0 to 3 are the valid numbers.

> 
> >  		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
> >  			mmc_hostname(card->host), csd_struct);
> >  		return -EINVAL;
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
