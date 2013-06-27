From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: core: production year for eMMC 4.41 and later
Date: Thu, 27 Jun 2013 11:57:43 -0400
Message-ID: <87d2r7mtqg.fsf@octavius.laptop.org>
References: <1371212744-31596-1-git-send-email-romain.izard.pro@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:52986 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753258Ab3F0P5r (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:57:47 -0400
In-Reply-To: <1371212744-31596-1-git-send-email-romain.izard.pro@gmail.com>
	(Romain Izard's message of "Fri, 14 Jun 2013 14:25:44 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: linux-mmc@vger.kernel.org

Hi Romain,

On Fri, Jun 14 2013, Romain Izard wrote:
> The field containing the production date in the CID register only uses
> 4 bits to encode the year, starting from 1997 in the original standard.
> In 2013, the production year field contains 0, and the kernel reports a
> 1997 production date.
>
> The eMMC 4.51 specification adds a new interpretation rule. For all
> devices implementing the 4.41 specification or later, the production
> year field will be interpreted as a value between 2010 and 2025, with
> 0 corresponding to 2013.
>
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> ---
>  drivers/mmc/core/mmc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3a69b94..3914523 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -482,6 +482,10 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>  	}
>  
>  	if (card->ext_csd.rev >= 5) {
> +		/* Adjust production date as per JEDEC JESD84-B451 */
> +		if (card->cid.year < 2010)
> +			card->cid.year += 16;
> +
>  		/* check whether the eMMC card supports BKOPS */
>  		if (ext_csd[EXT_CSD_BKOPS_SUPPORT] & 0x1) {
>  			card->ext_csd.bkops = 1;

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
