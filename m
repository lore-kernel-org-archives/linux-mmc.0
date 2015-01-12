From: "Russ W. Knize" <rknize@gmail.com>
Subject: Re: [PATCH 3/3] mmc: Support FFU for eMMC v5.0
Date: Mon, 12 Jan 2015 15:43:07 -0600
Message-ID: <ad7b0cf8509080f09a1c2e4def16362b@www.metagalaxy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:52166 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995AbbALVlY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jan 2015 16:41:24 -0500
Received: by mail-ig0-f173.google.com with SMTP id r10so676352igi.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 13:41:23 -0800 (PST)
Received: from . (c-73-8-120-95.hsd1.il.comcast.net. [73.8.120.95])
        by mx.google.com with ESMTPSA id f198sm9150735ioe.11.2015.01.12.13.41.22
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Jan 2015 13:41:23 -0800 (PST)
Received: from www-data by orion.metagalaxy.net with local (Exim 4.80 #3 (Debian))
	id 1YAmlP-0004LU-Sg
	for <linux-mmc@vger.kernel.org>; Mon, 12 Jan 2015 15:43:07 -0600
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Avi,

I won't go into the overall approach to this patch set, but here is 
some feedback about how this works with other eMMCs:

> diff --git a/drivers/mmc/core/mmc_ffu.c b/drivers/mmc/core/mmc_ffu.c
> new file mode 100644
> index 0000000..cde58eb
> --- /dev/null
> +++ b/drivers/mmc/core/mmc_ffu.c
>  <at>  <at>  -0,0 +1,487  <at>  <at>

^ Your latest patch got mangled, BTW.

> +/* Flush all scheduled work from the MMC work queue.
> + * and initialize the MMC device */
> +static int mmc_ffu_restart(struct mmc_card *card)
> +{
> +	struct mmc_host *host = card->host;
> +	int err = 0;
> +
> +	err = mmc_power_save_host(host);
> +	if (err) {
> +		pr_warn("%s: going to sleep failed (%d)!!!\n",
> +			__func__, err);
> +		goto exit;
> +	}

In practice, the above approach is not reliable.  There is nothing we 
can do for cases where a hardware reset is not possible (fixed power 
rails and no RST_n control), so we have to hope that going back to CMD0 
is enough.  Returning an error here can leave the system in an 
unrecoverable state and breaks the idea of a "field upgrade" (more 
below).

A more serious problem is that if the firmware upgrade causes a change 
to the CID (PRV for example), the driver cannot cope with this (eMMCs 
are flagged as non-removable).  I tried several approaches to deal with 
this, but trying to tear the host down far enough so that host->card 
could be freed ended up being a rabbit hole.  We have the host claimed 
here, so deadlocks are prevalent unless we perform the whole process by 
hand.  If we release the host at this point, we get into all kinds of 
nasty race conditions.  I ended up simply clearing raw_cid here and 
added code to mmc_init_card to look for this.  If the raw_cid is zeroed 
when host->card is present, it is reread and reparsed.  Hacky, but it 
works.  Also need to deal with partitions, as someone else mentioned 
(see mmc_blk_reset).

> +
> +	err = mmc_power_restore_host(host);
> +
> +exit:
> +
> +	return err;
> +}
> +
> +static int mmc_ffu_switch_mode(struct mmc_card *card, int mode)
> +{
> +	int err = 0;
> +	int offset;
> +
> +	switch (mode) {
> +	case MMC_FFU_MODE_SET:
> +	case MMC_FFU_MODE_NORMAL:
> +		offset = EXT_CSD_MODE_CONFIG;
> +		break;
> +	case MMC_FFU_INSTALL_SET:
> +			offset = EXT_CSD_MODE_OPERATION_CODES;
> +			mode = 0x1;
> +			break;
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	if (err == 0) {
> +		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			offset, mode,
> +			card->ext_csd.generic_cmd6_time);
> +	}
> +
> +	return err;
> +}
> +
> +static int mmc_ffu_install(struct mmc_card *card, u8 *ext_csd)
> +{
> +	int err;
> +	u32 timeout;
> +
> +	/* check mode operation */
> +	if (!card->ext_csd.ffu_mode_op) {

I found there is too much complexity here for the case where a device 
does not support operation modes.  With one vendor in particular, once 
the image was sent, the device seems to reset itself.  Every operation 
from here on will fail because we need to reinitialize the card.  These 
error legs effectively skip the required path to mmc_init_card.  The 
spec says we should set the mode to normal, but if it fails we really 
should reset the card anyway.

> +		/* host switch back to work in normal MMC Read/Write commands */
> +		err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);
> +		if (err) {
> +			pr_err("FFU: %s: switch to normal mode error %d:\n",
> +				mmc_hostname(card->host), err);
> +			return err;
> +		}
> +
> +		/* restart the eMMC */
> +		err = mmc_ffu_restart(card);
> +		if (err) {
> +			pr_err("FFU: %s: install error %d:\n",
> +				mmc_hostname(card->host), err);
> +			return err;
> +		}
> +	} else {
> +		timeout = ext_csd[EXT_CSD_OPERATION_CODE_TIMEOUT];
> +		if (timeout == 0 || timeout > 0x17) {
> +			timeout = 0x17;
> +			pr_warn("FFU: %s: operation code timeout is out "\
> +				"of range. Using maximum timeout.\n",
> +				mmc_hostname(card->host));
> +		}
> +
> +		/* timeout is at millisecond resolution */
> +		timeout = DIV_ROUND_UP((100 * (1 << timeout)), 1000);
> +
> +		/* set ext_csd to install mode */
> +		err = mmc_ffu_switch_mode(card, MMC_FFU_INSTALL_SET);
> +		if (err) {
> +			pr_err("FFU: %s: error %d setting install mode\n",
> +				mmc_hostname(card->host), err);
> +			return err;
> +		}
> +	}
> +
> +	/* read ext_csd */
> +	err = mmc_get_ext_csd(card, &ext_csd);
> +	if (err) {
> +		pr_err("FFU: %s: error %d sending ext_csd\n",
> +			mmc_hostname(card->host), err);
> +		return err;
> +	}
> +
> +	/* return status */
> +	err = ext_csd[EXT_CSD_FFU_STATUS];
> +	if (err) {
> +		pr_err("FFU: %s: error %d FFU install:\n",
> +			mmc_hostname(card->host), err);
> +		return  -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int mmc_ffu_invoke(struct mmc_card *card, const char *name)
> +{
> +	u8 *ext_csd;
> +	int err;
> +	u32 arg;
> +	u32 fw_prog_bytes;
> +	const struct firmware *fw;
> +	int block_size = card->ext_csd.data_sector_size;
> +
> +	/* Check if FFU is supported */
> +	if (!card->ext_csd.ffu_capable) {
> +		pr_err("FFU: %s: error FFU is not supported %d rev %d\n",
> +			mmc_hostname(card->host), card->ext_csd.ffu_capable,
> +			card->ext_csd.rev);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (strlen(name) > 512) {
> +		pr_err("FFU: %s: %.20s is not a valid argument\n",
> +			mmc_hostname(card->host), name);
> +		return -EINVAL;
> +	}
> +
> +	/* setup FW data buffer */
> +	err = request_firmware(&fw, name, &card->dev);
> +	if (err) {
> +		pr_err("FFU: %s: Firmware request failed %d\n",
> +			mmc_hostname(card->host), err);
> +		return err;
> +	}
> +	if ((fw->size % block_size)) {
> +		pr_warn("FFU: %s: Warning %zd firmware data size "\
> +			"is not aligned!!!\n", mmc_hostname(card->host),
> +			fw->size);
> +	}
> +
> +	mmc_get_card(card);
> +
> +	/* trigger flushing*/
> +	err = mmc_flush_cache(card);
> +	if (err) {
> +		pr_err("FFU: %s: error %d flushing data\n",
> +			mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> +
> +	/* Read the EXT_CSD */
> +	err = mmc_get_ext_csd(card, &ext_csd);
> +	if (err) {
> +		pr_err("FFU: %s: error %d sending ext_csd\n",
> +				mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> +
> +	/* set CMD ARG */
> +	arg = ext_csd[EXT_CSD_FFU_ARG] |
> +		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
> +		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
> +		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
> +
> +	/* set device to FFU mode */
> +	err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_SET);
> +	if (err) {
> +		pr_err("FFU: %s: error %d FFU is not supported\n",
> +			mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> +
> +	err = mmc_ffu_write(card, fw->data, arg, fw->size);
> +	if (err) {
> +		pr_err("FFU: %s: write error %d\n",
> +			mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> +	/* payload  will be checked only in op_mode supported */
> +	if (card->ext_csd.ffu_mode_op) {
> +		/* Read the EXT_CSD */
> +		err = mmc_get_ext_csd(card, &ext_csd);
> +		if (err) {
> +			pr_err("FFU: %s: error %d sending ext_csd\n",
> +				mmc_hostname(card->host), err);
> +			goto exit;
> +		}
> +
> +		/* check that the eMMC has received the payload */
> +		fw_prog_bytes = ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG] |
> +			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] << 8 |
> +			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] << 16 |
> +			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] << 24;
> +
> +		/* convert sectors to bytes: multiply by -512B or 4KB as
> +		   required by the card */
> +		 fw_prog_bytes *=
> +			block_size << (ext_csd[EXT_CSD_DATA_SECTOR_SIZE] * 3);
> +		if (fw_prog_bytes != fw->size) {
> +			err = -EINVAL;
> +			pr_err("FFU: %s: error %d number of programmed fw "\
> +				"sector incorrect %d %zd\n", __func__, err,
> +				fw_prog_bytes, fw->size);
> +			goto exit;
> +		}
> +	}
> +
> +	err = mmc_ffu_install(card, ext_csd);
> +	if (err) {
> +		pr_err("FFU: %s: error firmware install %d\n",
> +			mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> +
> +exit:
> +	if (err != 0) {
> +	   /* host switch back to work in normal MMC
> +	    * Read/Write commands */
> +		mmc_ffu_switch_mode(card, MMC_FFU_MODE_NORMAL);

Again, there is a chance that the eMMC is off in the weeds if something 
failed.  We should reset the card here before releasing the host.

> +	}
> +	release_firmware(fw);
> +	mmc_put_card(card);
> +	return err;
> +}
> +EXPORT_SYMBOL(mmc_ffu_invoke);

I have patches that apply on top of these to implement the changes that 
I suggested, but I suspect that these patches will change anyway, so....

Russ
