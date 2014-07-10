From: Alex Lemberg <Alex.Lemberg@sandisk.com>
Subject: RE: [PATCH] Fix on top of sandisk patches.
Date: Thu, 10 Jul 2014 23:40:46 +0000
Message-ID: <282CEDFCBC30114F83C499CB8F2ED5333ADE6F97@SACMBXIP01.sdcorp.global.sandisk.com>
References: <CANEJEGvRXkCy-R3=hFsPg2DLaD+bOEwC+dUL1ZFgSME+b5Q7KA@mail.gmail.com>
 <1405033685-24810-1-git-send-email-gwendal@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:36307
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750845AbaGJXkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jul 2014 19:40:51 -0400
In-Reply-To: <1405033685-24810-1-git-send-email-gwendal@chromium.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "chris@printf.net" <chris@printf.net>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "olofj@chromium.org" <olofj@chromium.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "grundler@chromium.org" <grundler@chromium.org>, Yaniv Iarovici <Yaniv.Iarovici@sandisk.com>

Thanks Gwendal!
We will test your changes.

Are you still experiencing the "request_firmware" failure?

Alex

> -----Original Message-----
> From: Gwendal Grignou [mailto:gwendal@chromium.org]
> Sent: Thursday, July 10, 2014 4:08 PM
> To: Avi Shchislowski; chris@printf.net; ulf.hansson@linaro.org
> Cc: olofj@chromium.org; Alex Lemberg; linux-mmc@vger.kernel.org;
> cjb@laptop.org; grundler@chromium.org; Yaniv Iarovici; Gwendal Grignou
> Subject: [PATCH] Fix on top of sandisk patches.
> 
> To apply on top of
> [RFC PATCH 1/1 v7]mmc: Support-FFU-for-eMMC-v5.0
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> 
> Avi,
> 
> As I mentioned earlier, I found several problems with your patch.
> Here is a patch that allows to go further.
> It is still not working reliably. The eMMC I am using has a problem being
> reseted after upgrade, and I am still hitting what appears to be memory
> corruptions. I believe the issues I am still having are due to the kernel code,
> not the eMMC I am testing.
> 
> Gwendal.
> 
>  drivers/mmc/card/block.c |   3 +-
>  drivers/mmc/card/ffu.c   | 121 +++++++++++++++++++++++--------------------
> ----
>  drivers/mmc/core/mmc.c   |   8 ++++
>  include/linux/mmc/card.h |   1 +
>  include/linux/mmc/ffu.h  |  13 +----
>  5 files changed, 71 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c index
> fc65a6c..9d866fb 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -504,8 +504,7 @@ static int mmc_blk_ioctl_cmd(struct block_device
> *bdev,
>  	mmc_get_card(card);
> 
>  	if (cmd.opcode == MMC_FFU_DOWNLOAD_OP) {
> -		err = mmc_ffu_download(card, &cmd , idata->buf,
> -			idata->buf_bytes);
> +		err = mmc_ffu_download(card, idata->buf);
>  		goto cmd_rel_host;
>  	}
> 
> diff --git a/drivers/mmc/card/ffu.c b/drivers/mmc/card/ffu.c index
> 04e07a5..0e85b2b 100644
> --- a/drivers/mmc/card/ffu.c
> +++ b/drivers/mmc/card/ffu.c
> @@ -63,15 +63,13 @@ struct mmc_ffu_area {
> 
>  static void mmc_ffu_prepare_mrq(struct mmc_card *card,
>  	struct mmc_request *mrq, struct scatterlist *sg, unsigned int sg_len,
> -	u32 arg, unsigned int blocks, unsigned int blksz, int write) {
> +	u32 arg, unsigned int blocks, unsigned int blksz) {
>  	BUG_ON(!mrq || !mrq->cmd || !mrq->data || !mrq->stop);
> 
>  	if (blocks > 1) {
> -		mrq->cmd->opcode = write ?
> -			MMC_WRITE_MULTIPLE_BLOCK :
> MMC_READ_MULTIPLE_BLOCK;
> +		mrq->cmd->opcode = MMC_WRITE_MULTIPLE_BLOCK;
>  	} else {
> -		mrq->cmd->opcode = write ? MMC_WRITE_BLOCK :
> -			MMC_READ_SINGLE_BLOCK;
> +		mrq->cmd->opcode = MMC_WRITE_BLOCK;
>  	}
> 
>  	mrq->cmd->arg = arg;
> @@ -89,11 +87,12 @@ static void mmc_ffu_prepare_mrq(struct mmc_card
> *card,
> 
>  	mrq->data->blksz = blksz;
>  	mrq->data->blocks = blocks;
> -	mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
> +	mrq->data->flags = MMC_DATA_WRITE;
>  	mrq->data->sg = sg;
>  	mrq->data->sg_len = sg_len;
> 
> -	mmc_set_data_timeout(mrq->data, card); }
> +	mmc_set_data_timeout(mrq->data, card); }
> 
>  /*
>   * Checks that a normal transfer didn't have any errors @@ -153,7 +152,7
> @@ static int mmc_ffu_wait_busy(struct mmc_card *card) {
>   */
>  static int mmc_ffu_simple_transfer(struct mmc_card *card,
>  	struct scatterlist *sg, unsigned int sg_len, u32 arg,
> -	unsigned int blocks, unsigned int blksz, int write) {
> +	unsigned int blocks, unsigned int blksz) {
>  	struct mmc_request mrq = {0};
>  	struct mmc_command cmd = {0};
>  	struct mmc_command stop = {0};
> @@ -162,8 +161,7 @@ static int mmc_ffu_simple_transfer(struct mmc_card
> *card,
>  	mrq.cmd = &cmd;
>  	mrq.data = &data;
>  	mrq.stop = &stop;
> -	mmc_ffu_prepare_mrq(card, &mrq, sg, sg_len, arg, blocks, blksz,
> -		write);
> +	mmc_ffu_prepare_mrq(card, &mrq, sg, sg_len, arg, blocks, blksz);
>  	mmc_wait_for_req(card->host, &mrq);
> 
>  	mmc_ffu_wait_busy(card);
> @@ -175,19 +173,17 @@ static int mmc_ffu_simple_transfer(struct
> mmc_card *card,
>   * Map memory into a scatterlist.
>   */
>  static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int size,
> -	struct scatterlist *sglist, unsigned int max_segs,
> -	unsigned int max_seg_sz)
> +	struct scatterlist *sglist)
>  {
>  	struct scatterlist *sg = sglist;
>  	unsigned int i;
>  	unsigned long sz = size;
> -	unsigned int sctr_len = 0;
>  	unsigned long len;
> 
> -	sg_init_table(sglist, max_segs);
> +	sg_init_table(sglist, mem->cnt);
> 
> -	for (i = 0; i < mem->cnt && sz; i++, sz -= len) {
> -		len = PAGE_SIZE * (1 << mem->arr[i].order);
> +	for (i = 0; i < mem->cnt && sz; i++, sg++, sz -= len) {
> +		len = PAGE_SIZE << mem->arr[i].order;
> 
>  		if (len > sz) {
>  			len = sz;
> @@ -195,12 +191,10 @@ static unsigned int mmc_ffu_map_sg(struct
> mmc_ffu_mem *mem, int size,
>  		}
> 
>  		sg_set_page(sg, mem->arr[i].page, len, 0);
> -		sg = sg_next(sg);
> -		sctr_len += 1;
>  	}
>  	sg_mark_end(sg);
> 
> -	return sctr_len;
> +	return mem->cnt;
>  }
> 
>  static void mmc_ffu_free_mem(struct mmc_ffu_mem *mem) { @@ -277,6
> +271,8 @@ static struct mmc_ffu_mem *mmc_ffu_alloc_mem(unsigned
> long min_sz,
>  		mem->arr[mem->cnt].page = page;
>  		mem->arr[mem->cnt].order = order;
>  		mem->cnt += 1;
> +		pr_debug("FFU: cnt: %d - order %d\n", mem->cnt, order);
> +
>  		if (max_page_cnt <= (1UL << order))
>  			break;
>  		max_page_cnt -= 1UL << order;
> @@ -298,11 +294,11 @@ out_free:
>   * Copy the data to the allocated pages.
>   */
>  static int mmc_ffu_area_init(struct mmc_ffu_area *area, struct mmc_card
> *card,
> -	u8 *data, int size)
> +	const u8 *data, int size)
>  {
>  	int ret;
>  	int i;
> -	int length = 0;
> +	int length = 0, page_length;
> 
>  	area->max_tfr = size;
> 
> @@ -323,20 +319,20 @@ static int mmc_ffu_area_init(struct mmc_ffu_area
> *area, struct mmc_card *card,
>  			goto out_free;
>  		}
> 
> +		page_length = PAGE_SIZE << area->mem->arr[i].order;
>  		memcpy(page_address(area->mem->arr[i].page), data +
> length,
> -			min(size - length, (int)area->max_seg_sz));
> -		length += area->max_seg_sz;
> +			min(size - length, page_length));
> +		length += page_length;
>  	}
> 
>  	area->sg = kmalloc(sizeof(struct scatterlist) * area->mem->cnt,
> -		GFP_KERNEL);
> +			   GFP_KERNEL);
>  	if (!area->sg) {
>  		ret = -ENOMEM;
>  		goto out_free;
>  	}
> 
> -	area->sg_len = mmc_ffu_map_sg(area->mem, size, area->sg,
> -		area->max_segs, area->mem->cnt);
> +	area->sg_len = mmc_ffu_map_sg(area->mem, size, area->sg);
> 
>  	return 0;
> 
> @@ -345,7 +341,7 @@ out_free:
>  	return ret;
>  }
> 
> -static int mmc_ffu_write(struct mmc_card *card, u8 *src, u32 arg,
> +static int mmc_ffu_write(struct mmc_card *card, const u8 *src, u32 arg,
>  	int size)
>  {
>  	int rc;
> @@ -370,7 +366,8 @@ static int mmc_ffu_write(struct mmc_card *card, u8
> *src, u32 arg,
>  			goto exit;
> 
>  		rc = mmc_ffu_simple_transfer(card, area.sg, area.sg_len, arg,
> -			max_tfr / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE, 1);
> +			max_tfr / CARD_BLOCK_SIZE, CARD_BLOCK_SIZE);
> +		mmc_ffu_area_cleanup(&area);
>  		if (rc != 0)
>  			goto exit;
> 
> @@ -379,7 +376,6 @@ static int mmc_ffu_write(struct mmc_card *card, u8
> *src, u32 arg,
>  	} while (size > 0);
> 
>  exit:
> -	mmc_ffu_area_cleanup(&area);
>  	return rc;
>  }
> 
> @@ -406,47 +402,39 @@ exit:
>  	return err;
>  }
> 
> -int mmc_ffu_download(struct mmc_card *card, struct mmc_command
> *cmd,
> -	u8 *data, int buf_bytes)
> +int mmc_ffu_download(struct mmc_card *card, const char *name)
>  {
>  	u8 ext_csd[CARD_BLOCK_SIZE];
>  	int err;
>  	int ret;
> -	u8 *buf = NULL;
> +	u32 arg;
>  	const struct firmware *fw;
> 
> -	/* Read the EXT_CSD */
> -	err = mmc_send_ext_csd(card, ext_csd);
> -	if (err) {
> -		pr_err("FFU: %s: error %d sending ext_csd\n",
> -			mmc_hostname(card->host), err);
> +	pr_debug("FFU: %s uploading firmware %.20s to device\n",
> +		 mmc_hostname(card->host), name);
> +
> +	if (strlen(name) > 512) {
> +		err = -EINVAL;
> +		pr_err("FFU: %s: %.20s is not a valid argument\n",
> +		       mmc_hostname(card->host), name);
>  		goto exit;
>  	}
> 
> -	/* check if card is eMMC 5.0 or higher */
> -	if (card->ext_csd.rev < 7)
> -		return -EINVAL;
> -
>  	/* Check if FFU is supported */
> -	if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])
> ||
> -		FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
> -		err = -EINVAL;
> +	if (!card->ext_csd.ffu_capable) {
> +		err = -EOPNOTSUPP;
>  		pr_err("FFU: %s: error %d FFU is not supported\n",
>  			mmc_hostname(card->host), err);
>  		goto exit;
>  	}
> 
> -	/* setup FW data buffer */
> -	err = request_firmware(&fw, data, &card->dev);
> +	/* setup FW name buffer */
> +	mmc_put_card(card);
> +	err = request_firmware(&fw, name, &card->dev);
> +	mmc_get_card(card);
>  	if (err) {
>  		pr_err("Firmware request failed %d\n", err);
> -		goto exit_normal;
> -	}
> -
> -	buf = kmalloc(fw->size, GFP_KERNEL);
> -	if (buf == NULL) {
> -		pr_err("Allocating memory for firmware failed!\n");
> -		goto exit_normal;
> +		goto exit;
>  	}
> 
>  	if ((fw->size % CARD_BLOCK_SIZE)) {
> @@ -454,9 +442,16 @@ int mmc_ffu_download(struct mmc_card *card,
> struct mmc_command *cmd,
>  			mmc_hostname(card->host), fw->size);
>  	}
> 
> -	memcpy(buf, fw->data, fw->size);
> +	/* Read the EXT_CSD */
> +	err = mmc_send_ext_csd(card, ext_csd);
> +	if (err) {
> +		pr_err("FFU: %s: error %d sending ext_csd\n",
> +			mmc_hostname(card->host), err);
> +		goto exit;
> +	}
> 
>  	/* set device to FFU mode */
> +	pr_debug("FFU: %s switch to FFU mode\n", mmc_hostname(card-
> >host));
>  	err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> EXT_CSD_MODE_CONFIG,
>  		MMC_FFU_MODE_SET, card->ext_csd.generic_cmd6_time);
>  	if (err) {
> @@ -466,18 +461,18 @@ int mmc_ffu_download(struct mmc_card *card,
> struct mmc_command *cmd,
>  	}
> 
>  	/* set CMD ARG */
> -	cmd->arg = ext_csd[EXT_CSD_FFU_ARG] |
> +	arg = ext_csd[EXT_CSD_FFU_ARG] |
>  		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
>  		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
>  		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
> 
> -	err = mmc_ffu_write(card, buf, cmd->arg, (int)fw->size);
> +	err = mmc_ffu_write(card, fw->data, arg, (int)fw->size);
> 
>  exit_normal:
>  	release_firmware(fw);
> -	kfree(buf);
> 
>  	/* host switch back to work in normal MMC Read/Write commands
> */
> +	pr_debug("FFU: %s switch to normal mode\n", mmc_hostname(card-
> >host));
>  	ret = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>  		EXT_CSD_MODE_CONFIG, MMC_FFU_MODE_NORMAL,
>  		card->ext_csd.generic_cmd6_time);
> @@ -495,6 +490,8 @@ int mmc_ffu_install(struct mmc_card *card)
>  	u32 ffu_data_len;
>  	u32 timeout;
> 
> +	pr_debug("FFU: %s installing firmware to device\n",
> +		 mmc_hostname(card->host));
>  	err = mmc_send_ext_csd(card, ext_csd);
>  	if (err) {
>  		pr_err("FFU: %s: error %d sending ext_csd\n", @@ -503,9
> +500,8 @@ int mmc_ffu_install(struct mmc_card *card)
>  	}
> 
>  	/* Check if FFU is supported */
> -	if (!FFU_SUPPORTED_MODE(ext_csd[EXT_CSD_SUPPORTED_MODE])
> ||
> -		FFU_CONFIG(ext_csd[EXT_CSD_FW_CONFIG])) {
> -		err = -EINVAL;
> +	if (!card->ext_csd.ffu_capable) {
> +		err = -EOPNOTSUPP;
>  		pr_err("FFU: %s: error %d FFU is not supported\n",
>  			mmc_hostname(card->host), err);
>  		goto exit;
> @@ -514,19 +510,20 @@ int mmc_ffu_install(struct mmc_card *card)
>  	/* check mode operation */
>  	if (!FFU_FEATURES(ext_csd[EXT_CSD_FFU_FEATURES])) {
>  		/* restart the eMMC */
> +		mmc_put_card(card);
>  		err = mmc_ffu_restart(card);
> +		mmc_get_card(card);
>  		if (err) {
>  			pr_err("FFU: %s: error %d FFU install:\n",
>  				mmc_hostname(card->host), err);
>  		}
>  	} else {
> -
>  		ffu_data_len =
> ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG]|
>  			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 1] <<
> 8 |
>  			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 2] <<
> 16 |
>  			ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG + 3] <<
> 24;
> 
> -		if (!ffu_data_len) {
> +		if (ffu_data_len == 0) {
>  			err = -EPERM;
>  			return err;
>  		}
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 4099424..ace9123 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -552,6 +552,14 @@ static int mmc_read_ext_csd(struct mmc_card
> *card, u8 *ext_csd)
>  		card->ext_csd.data_sector_size = 512;
>  	}
> 
> +	/* eMMC v5 or later */
> +	if (card->ext_csd.rev >= 7) {
> +		card->ext_csd.ffu_capable =
> +			((ext_csd[EXT_CSD_SUPPORTED_MODE] & 1) == 1)
> &&
> +			((ext_csd[EXT_CSD_FW_CONFIG] & 1) == 0);
> +	} else {
> +		card->ext_csd.ffu_capable = false;
> +	}
>  out:
>  	return err;
>  }
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
> 6a5c754..6a7de8d 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -87,6 +87,7 @@ struct mmc_ext_csd {
>  	unsigned int            data_tag_unit_size;     /* DATA TAG UNIT size */
>  	unsigned int		boot_ro_lock;		/* ro lock support */
>  	bool			boot_ro_lockable;
> +	bool			ffu_capable;  /* support Firmware Field
> Upgrade */
>  	u8			raw_exception_status;	/* 54 */
>  	u8			raw_partition_support;	/* 160 */
>  	u8			raw_rpmb_size_mult;	/* 168 */
> diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h index
> f5dcedb..a0ade1b 100644
> --- a/include/linux/mmc/ffu.h
> +++ b/include/linux/mmc/ffu.h
> @@ -34,19 +34,10 @@
>  #define MMC_FFU_INSTALL_SET 0x1
> 
>  #ifdef CONFIG_MMC_FFU
> -#define MMC_FFU_ENABLE 0x0
> -#define MMC_FFU_CONFIG 0x1
> -#define MMC_FFU_SUPPORTED_MODES 0x1
>  #define MMC_FFU_FEATURES 0x1
> +#define FFU_FEATURES(ffu_features) (ffu_features & MMC_FFU_FEATURES)
> 
> -#define FFU_ENABLED(ffu_enable)	(ffu_enable & MMC_FFU_CONFIG)
> -#define FFU_SUPPORTED_MODE(ffu_sup_mode) \
> -	(ffu_sup_mode && MMC_FFU_SUPPORTED_MODES)
> -#define FFU_CONFIG(ffu_config) (ffu_config & MMC_FFU_CONFIG) -
> #define FFU_FEATURES(ffu_fetures) (ffu_fetures & MMC_FFU_FEATURES)
> -
> -int mmc_ffu_download(struct mmc_card *card, struct mmc_command
> *cmd,
> -	u8 *data, int buf_bytes);
> +int mmc_ffu_download(struct mmc_card *card, const char *name);
>  int mmc_ffu_install(struct mmc_card *card);  #else  static inline int
> mmc_ffu_download(struct mmc_card *card,
> --
> 2.0.0.526.g5318336

