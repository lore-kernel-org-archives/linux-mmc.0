From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] mmc: csd version check updated to support MMC v4.41
Date: Wed, 14 Jul 2010 17:22:49 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870305CE5795@dbde02.ent.ti.com>
References: <1279095667-21255-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1279095667-21255-1-git-send-email-s-ghorai@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ghorai, Sukumar
> Sent: Wednesday, July 14, 2010 1:51 PM
> To: linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org
> Cc: Ghorai, Sukumar
> Subject: [PATCH] mmc: csd version check updated to support MMC v4.41
> 
>  CSD_STRUCTURE [127:126] describes the version of the CSD structure.
>  According to the MMC specificaiton (v4.4.1), 3 is also a valid number.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  Tested on omap4430 ES2.0
> 
>  drivers/mmc/core/mmc.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..525af33 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -122,7 +122,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>  	 * v1.2 has extra information in bits 15, 11 and 10.
>  	 */
>  	csd_struct = UNSTUFF_BITS(resp, 126, 2);
> -	if (csd_struct != 1 && csd_struct != 2) {
> +	if (csd_struct > 3) {

Can't csd_struct be 0? If so then your new check will break right?

>  		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
>  			mmc_hostname(card->host), csd_struct);
>  		return -EINVAL;
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
