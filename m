From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: add device class attribute for ext_csd
Date: Mon, 26 Jul 2010 15:42:48 +0300
Message-ID: <4C4D82C8.3040307@nokia.com>
References: <20100726100956.GA17996@july> <4C4D6BF9.1040704@nokia.com> <2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:29770 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab0GZMnD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Jul 2010 08:43:03 -0400
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B030E4176E6@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Ghorai, Sukumar wrote:
> All,
> EXT_CSD is 512byte information (read using CMD8) for the MMC (eMMC) device.
> And for the latest and upcoming specification, ext_csd are much relevant then past.
> 
> So please let me know your idea to add and get the same ext_csd as MMC device attribute. This is the same way currently available for csd, cid, src, etc.
> (# cat /sys/class/mmc_host/mmc1/mmc1\:0001/ext_csd)

Some of the values in Extended CSD can change so storing
it could cause incorrect values to be reported.

Note that Extended CSD is available via debugfs
e.g. for device mmc0:0001 with debugfs mounted on /sys/kernel/debug

    cat /sys/kernel/debug/mmc0/mmc0\:0001/ext_csd 

> 
> Regards,
> Sukumar Ghorai
> 
> From: Sukumar Ghorai <s-ghorai@ti.com>
> Date: Mon, 26 Jul 2010 10:47:12 +0530
> Subject: [PATCH] mmc: add device class attribute for ext_csd
> 
>  ext_csd is getting more informative form eMMC 4.4 onwards and better to
>  have this in device information as currently available for csd, cid, src.
> 
> Signed-off-by: Sukumar Ghorai <s-ghorai@ti.com>
> ---
>  drivers/mmc/core/bus.c   |    1 +
>  drivers/mmc/core/mmc.c   |   23 +++++++++++++++++------
>  include/linux/mmc/card.h |    1 +
>  3 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 49d9dca..57d035e 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -191,6 +191,7 @@ static void mmc_release_card(struct device *dev)
>  	if (card->info)
>  		kfree(card->info);
>  
> +	kfree(card->raw_ext_csd);
>  	kfree(card);
>  }
>  
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..23b1813 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -167,10 +167,6 @@ static int mmc_read_ext_csd(struct mmc_card *card)
>  	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
>  		return 0;
>  
> -	/*
> -	 * As the ext_csd is so large and mostly unused, we don't store the
> -	 * raw block in mmc_card.
> -	 */
>  	ext_csd = kmalloc(512, GFP_KERNEL);
>  	if (!ext_csd) {
>  		printk(KERN_ERR "%s: could not allocate a buffer to "
> @@ -250,11 +246,25 @@ static int mmc_read_ext_csd(struct mmc_card *card)
>  	}
>  
>  out:
> -	kfree(ext_csd);
> -
> +	card->raw_ext_csd = ext_csd;
>  	return err;
>  }
>  
> +static ssize_t mmc_ext_csd_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +int i;
> +struct mmc_card *card = container_of(dev, struct mmc_card, dev);
> +
> +	for (i = 0; i < 512; i++)
> +		buf += sprintf(buf, "%02x", card->raw_ext_csd[i]);
> +
> +	buf -= 512;
> +	return 512;
> +}
> +
> +static DEVICE_ATTR(ext_csd, S_IRUGO, mmc_ext_csd_show, NULL);
> +
>  MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1],
>  	card->raw_cid[2], card->raw_cid[3]);
>  MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
> @@ -270,6 +280,7 @@ MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>  static struct attribute *mmc_std_attrs[] = {
>  	&dev_attr_cid.attr,
>  	&dev_attr_csd.attr,
> +	&dev_attr_ext_csd.attr,
>  	&dev_attr_date.attr,
>  	&dev_attr_fwrev.attr,
>  	&dev_attr_hwrev.attr,
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index d02d2c6..00332ca 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -105,6 +105,7 @@ struct mmc_card {
>  	u32			raw_cid[4];	/* raw card CID */
>  	u32			raw_csd[4];	/* raw card CSD */
>  	u32			raw_scr[2];	/* raw card SCR */
> +	u8			*raw_ext_csd;	/* raw card EXT CSD for MMC */
>  	struct mmc_cid		cid;		/* card identification */
>  	struct mmc_csd		csd;		/* card specific */
>  	struct mmc_ext_csd	ext_csd;	/* mmc v4 extended card specific */

