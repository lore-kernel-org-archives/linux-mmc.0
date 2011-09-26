From: J Freyensee <james_p_freyensee@linux.intel.com>
Subject: Re: [PATCH] mmc: replace printk with appropriate display macro
Date: Mon, 26 Sep 2011 11:00:56 -0700
Message-ID: <4E80BDD8.2030606@linux.intel.com>
References: <1317027652-14043-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1317027652-14043-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 09/26/2011 02:00 AM, Girish K S wrote:
> All the files using printk function for displaying kernel messages
> in the mmc driver have been replaced with corresponding macro.

Nice work :-).

>
> Signed-off-by: Girish K S<girish.shivananjappa@linaro.org>
> ---
>   drivers/mmc/card/block.c        |   10 ++--
>   drivers/mmc/card/mmc_test.c     |   34 +++++++-------
>   drivers/mmc/card/queue.c        |    4 +-
>   drivers/mmc/card/sdio_uart.c    |   10 ++--
>   drivers/mmc/core/bus.c          |    8 ++--
>   drivers/mmc/core/core.c         |   10 ++--
>   drivers/mmc/core/mmc.c          |   24 +++++-----
>   drivers/mmc/core/mmc_ops.c      |    4 +-
>   drivers/mmc/core/sd.c           |   40 +++++++++---------
>   drivers/mmc/core/sdio.c         |    6 +-
>   drivers/mmc/core/sdio_bus.c     |    2 +-
>   drivers/mmc/core/sdio_cis.c     |    4 +-
>   drivers/mmc/core/sdio_irq.c     |    6 +-
>   drivers/mmc/host/au1xmmc.c      |   10 ++--
>   drivers/mmc/host/dw_mmc.c       |    2 +-
>   drivers/mmc/host/imxmmc.c       |    2 +-
>   drivers/mmc/host/mmci.c         |    2 +-
>   drivers/mmc/host/msm_sdcc.c     |    8 ++--
>   drivers/mmc/host/mvsdio.c       |   14 +++---
>   drivers/mmc/host/mxcmmc.c       |    2 +-
>   drivers/mmc/host/omap_hsmmc.c   |    6 +-
>   drivers/mmc/host/pxamci.c       |    2 +-
>   drivers/mmc/host/s3cmci.c       |    4 +-
>   drivers/mmc/host/sdhci.c        |   90 +++++++++++++++++++--------------------
>   drivers/mmc/host/tifm_sd.c      |   18 +++----
>   drivers/mmc/host/tmio_mmc_pio.c |    2 +-
>   drivers/mmc/host/via-sdmmc.c    |    2 +-
>   drivers/mmc/host/wbsd.c         |   22 +++++-----
>   28 files changed, 172 insertions(+), 176 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index ad005e5..06b1649 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -938,7 +938,7 @@ static int mmc_blk_err_check(struct mmc_card *card,
>   		do {
>   			int err = get_card_status(card,&status, 5);
>   			if (err) {
> -				printk(KERN_ERR "%s: error %d requesting status\n",
> +				pr_err("%s: error %d requesting status\n",
>   				       req->rq_disk->disk_name, err);
>   				return MMC_BLK_CMD_ERR;
>   			}
> @@ -1185,7 +1185,7 @@ static int mmc_blk_issue_rw_rq(struct mmc_queue *mq, struct request *rqc)
>   			 * were returned by the host controller, it's a bug.
>   			 */
>   			if (status == MMC_BLK_SUCCESS&&  ret) {
> -				printk(KERN_ERR "%s BUG rq_tot %d d_xfer %d\n",
> +				pr_err("%s BUG rq_tot %d d_xfer %d\n",
>   				       __func__, blk_rq_bytes(req),
>   				       brq->data.bytes_xfered);
>   				rqc = NULL;
> @@ -1465,7 +1465,7 @@ static int mmc_blk_alloc_part(struct mmc_card *card,
>
>   	string_get_size((u64)get_capacity(part_md->disk)<<  9, STRING_UNITS_2,
>   			cap_str, sizeof(cap_str));
> -	printk(KERN_INFO "%s: %s %s partition %u %s\n",
> +	pr_info("%s: %s %s partition %u %s\n",
>   	       part_md->disk->disk_name, mmc_card_id(card),
>   	       mmc_card_name(card), part_md->part_type, cap_str);
>   	return 0;
> @@ -1506,7 +1506,7 @@ mmc_blk_set_blksize(struct mmc_blk_data *md, struct mmc_card *card)
>   	mmc_release_host(card->host);
>
>   	if (err) {
> -		printk(KERN_ERR "%s: unable to set block size to 512: %d\n",
> +		pr_err("%s: unable to set block size to 512: %d\n",
>   			md->disk->disk_name, err);
>   		return -EINVAL;
>   	}
> @@ -1608,7 +1608,7 @@ static int mmc_blk_probe(struct mmc_card *card)
>
>   	string_get_size((u64)get_capacity(md->disk)<<  9, STRING_UNITS_2,
>   			cap_str, sizeof(cap_str));
> -	printk(KERN_INFO "%s: %s %s %s %s\n",
> +	pr_info("%s: %s %s %s %s\n",
>   		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
>   		cap_str, md->read_only ? "(ro)" : "");
>
> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
> index 9cdce63..d1e5a16 100644
> --- a/drivers/mmc/card/mmc_test.c
> +++ b/drivers/mmc/card/mmc_test.c
> @@ -250,7 +250,7 @@ static int mmc_test_wait_busy(struct mmc_test_card *test)
>   		if (!busy&&  mmc_test_busy(&cmd)) {
>   			busy = 1;
>   			if (test->card->host->caps&  MMC_CAP_WAIT_WHILE_BUSY)
> -				printk(KERN_INFO "%s: Warning: Host did not "
> +				pr_info("%s: Warning: Host did not "
>   					"wait for busy state to end.\n",
>   					mmc_hostname(test->card->host));
>   		}
> @@ -552,7 +552,7 @@ static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
>   	rate = mmc_test_rate(bytes,&ts);
>   	iops = mmc_test_rate(100,&ts); /* I/O ops per sec x 100 */
>
> -	printk(KERN_INFO "%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
> +	pr_info("%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
>   			 "seconds (%u kB/s, %u KiB/s, %u.%02u IOPS)\n",
>   			 mmc_hostname(test->card->host), sectors, sectors>>  1,
>   			 (sectors&  1 ? ".5" : ""), (unsigned long)ts.tv_sec,
> @@ -578,7 +578,7 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
>   	rate = mmc_test_rate(tot,&ts);
>   	iops = mmc_test_rate(count * 100,&ts); /* I/O ops per sec x 100 */
>
> -	printk(KERN_INFO "%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
> +	pr_info("%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
>   			 "%lu.%09lu seconds (%u kB/s, %u KiB/s, "
>   			 "%u.%02u IOPS, sg_len %d)\n",
>   			 mmc_hostname(test->card->host), count, sectors, count,
> @@ -1408,7 +1408,7 @@ static int mmc_test_multi_read_high(struct mmc_test_card *test)
>
>   static int mmc_test_no_highmem(struct mmc_test_card *test)
>   {
> -	printk(KERN_INFO "%s: Highmem not configured - test skipped\n",
> +	pr_info("%s: Highmem not configured - test skipped\n",
>   	       mmc_hostname(test->card->host));
>   	return 0;
>   }
> @@ -1435,7 +1435,7 @@ static int mmc_test_area_map(struct mmc_test_card *test, unsigned long sz,
>   				      t->max_seg_sz,&t->sg_len, min_sg_len);
>   	}
>   	if (err)
> -		printk(KERN_INFO "%s: Failed to map sg list\n",
> +		pr_info("%s: Failed to map sg list\n",
>   		       mmc_hostname(test->card->host));
>   	return err;
>   }
> @@ -2135,7 +2135,7 @@ static int mmc_test_rw_multiple(struct mmc_test_card *test,
>
>   	return ret;
>    err:
> -	printk(KERN_INFO "[%s] error\n", __func__);
> +	pr_info("[%s] error\n", __func__);
>   	return ret;
>   }
>
> @@ -2149,7 +2149,7 @@ static int mmc_test_rw_multiple_size(struct mmc_test_card *test,
>
>   	if (rw->do_nonblock_req&&
>   	((!pre_req&&  post_req) || (pre_req&&  !post_req))) {
> -		printk(KERN_INFO "error: only one of pre/post is defined\n");
> +		pr_info("error: only one of pre/post is defined\n");
>   		return -EINVAL;
>   	}
>
> @@ -2690,7 +2690,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   {
>   	int i, ret;
>
> -	printk(KERN_INFO "%s: Starting tests of card %s...\n",
> +	pr_info("%s: Starting tests of card %s...\n",
>   		mmc_hostname(test->card->host), mmc_card_id(test->card));
>
>   	mmc_claim_host(test->card->host);
> @@ -2701,14 +2701,14 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   		if (testcase&&  ((i + 1) != testcase))
>   			continue;
>
> -		printk(KERN_INFO "%s: Test case %d. %s...\n",
> +		pr_info("%s: Test case %d. %s...\n",
>   			mmc_hostname(test->card->host), i + 1,
>   			mmc_test_cases[i].name);
>
>   		if (mmc_test_cases[i].prepare) {
>   			ret = mmc_test_cases[i].prepare(test);
>   			if (ret) {
> -				printk(KERN_INFO "%s: Result: Prepare "
> +				pr_info("%s: Result: Prepare "
>   					"stage failed! (%d)\n",
>   					mmc_hostname(test->card->host),
>   					ret);
> @@ -2738,25 +2738,25 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   		ret = mmc_test_cases[i].run(test);
>   		switch (ret) {
>   		case RESULT_OK:
> -			printk(KERN_INFO "%s: Result: OK\n",
> +			pr_info("%s: Result: OK\n",
>   				mmc_hostname(test->card->host));
>   			break;
>   		case RESULT_FAIL:
> -			printk(KERN_INFO "%s: Result: FAILED\n",
> +			pr_info("%s: Result: FAILED\n",
>   				mmc_hostname(test->card->host));
>   			break;
>   		case RESULT_UNSUP_HOST:
> -			printk(KERN_INFO "%s: Result: UNSUPPORTED "
> +			pr_info("%s: Result: UNSUPPORTED "
>   				"(by host)\n",
>   				mmc_hostname(test->card->host));
>   			break;
>   		case RESULT_UNSUP_CARD:
> -			printk(KERN_INFO "%s: Result: UNSUPPORTED "
> +			pr_info("%s: Result: UNSUPPORTED "
>   				"(by card)\n",
>   				mmc_hostname(test->card->host));
>   			break;
>   		default:
> -			printk(KERN_INFO "%s: Result: ERROR (%d)\n",
> +			pr_info("%s: Result: ERROR (%d)\n",
>   				mmc_hostname(test->card->host), ret);
>   		}
>
> @@ -2767,7 +2767,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>   		if (mmc_test_cases[i].cleanup) {
>   			ret = mmc_test_cases[i].cleanup(test);
>   			if (ret) {
> -				printk(KERN_INFO "%s: Warning: Cleanup "
> +				pr_info("%s: Warning: Cleanup "
>   					"stage failed! (%d)\n",
>   					mmc_hostname(test->card->host),
>   					ret);
> @@ -2777,7 +2777,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
>
>   	mmc_release_host(test->card->host);
>
> -	printk(KERN_INFO "%s: Tests completed.\n",
> +	pr_info("%s: Tests completed.\n",
>   		mmc_hostname(test->card->host));
>   }
>
> diff --git a/drivers/mmc/card/queue.c b/drivers/mmc/card/queue.c
> index 5196312..fed290e 100644
> --- a/drivers/mmc/card/queue.c
> +++ b/drivers/mmc/card/queue.c
> @@ -197,13 +197,13 @@ int mmc_init_queue(struct mmc_queue *mq, struct mmc_card *card,
>   		if (bouncesz>  512) {
>   			mqrq_cur->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
>   			if (!mqrq_cur->bounce_buf) {
> -				printk(KERN_WARNING "%s: unable to "
> +				pr_warning("%s: unable to "
>   					"allocate bounce cur buffer\n",
>   					mmc_card_name(card));
>   			}
>   			mqrq_prev->bounce_buf = kmalloc(bouncesz, GFP_KERNEL);
>   			if (!mqrq_prev->bounce_buf) {
> -				printk(KERN_WARNING "%s: unable to "
> +				pr_warning("%s: unable to "
>   					"allocate bounce prev buffer\n",
>   					mmc_card_name(card));
>   				kfree(mqrq_cur->bounce_buf);
> diff --git a/drivers/mmc/card/sdio_uart.c b/drivers/mmc/card/sdio_uart.c
> index c8c9edb..2c151e1 100644
> --- a/drivers/mmc/card/sdio_uart.c
> +++ b/drivers/mmc/card/sdio_uart.c
> @@ -1082,7 +1082,7 @@ static int sdio_uart_probe(struct sdio_func *func,
>   		return -ENOMEM;
>
>   	if (func->class == SDIO_CLASS_UART) {
> -		printk(KERN_WARNING "%s: need info on UART class basic setup\n",
> +		pr_warning("%s: need info on UART class basic setup\n",
>   		       sdio_func_id(func));
>   		kfree(port);
>   		return -ENOSYS;
> @@ -1101,23 +1101,23 @@ static int sdio_uart_probe(struct sdio_func *func,
>   				break;
>   		}
>   		if (!tpl) {
> -			printk(KERN_WARNING
> +			pr_warning(
>          "%s: can't find tuple 0x91 subtuple 0 (SUBTPL_SIOREG) for GPS class\n",
>   			       sdio_func_id(func));
>   			kfree(port);
>   			return -EINVAL;
>   		}
> -		printk(KERN_DEBUG "%s: Register ID = 0x%02x, Exp ID = 0x%02x\n",
> +		pr_debug("%s: Register ID = 0x%02x, Exp ID = 0x%02x\n",
>   		       sdio_func_id(func), tpl->data[2], tpl->data[3]);
>   		port->regs_offset = (tpl->data[4]<<  0) |
>   				    (tpl->data[5]<<  8) |
>   				    (tpl->data[6]<<  16);
> -		printk(KERN_DEBUG "%s: regs offset = 0x%x\n",
> +		pr_debug("%s: regs offset = 0x%x\n",
>   		       sdio_func_id(func), port->regs_offset);
>   		port->uartclk = tpl->data[7] * 115200;
>   		if (port->uartclk == 0)
>   			port->uartclk = 115200;
> -		printk(KERN_DEBUG "%s: clk %d baudcode %u 4800-div %u\n",
> +		pr_debug("%s: clk %d baudcode %u 4800-div %u\n",
>   		       sdio_func_id(func), port->uartclk,
>   		       tpl->data[7], tpl->data[8] | (tpl->data[9]<<  8));
>   	} else {
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 393d817..eeb3404 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -295,13 +295,13 @@ int mmc_add_card(struct mmc_card *card)
>   	}
>
>   	if (mmc_host_is_spi(card->host)) {
> -		printk(KERN_INFO "%s: new %s%s%s card on SPI\n",
> +		pr_info("%s: new %s%s%s card on SPI\n",
>   			mmc_hostname(card->host),
>   			mmc_card_highspeed(card) ? "high speed " : "",
>   			mmc_card_ddr_mode(card) ? "DDR " : "",
>   			type);
>   	} else {
> -		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
> +		pr_info("%s: new %s%s%s card at address %04x\n",
>   			mmc_hostname(card->host),
>   			mmc_sd_card_uhs(card) ? "ultra high speed " :
>   			(mmc_card_highspeed(card) ? "high speed " : ""),
> @@ -334,10 +334,10 @@ void mmc_remove_card(struct mmc_card *card)
>
>   	if (mmc_card_present(card)) {
>   		if (mmc_host_is_spi(card->host)) {
> -			printk(KERN_INFO "%s: SPI card removed\n",
> +			pr_info("%s: SPI card removed\n",
>   				mmc_hostname(card->host));
>   		} else {
> -			printk(KERN_INFO "%s: card %04x removed\n",
> +			pr_info("%s: card %04x removed\n",
>   				mmc_hostname(card->host), card->rca);
>   		}
>   		device_del(&card->dev);
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 9698d8a..fa2ca8b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1527,7 +1527,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>   	err = mmc_wait_for_cmd(card->host,&cmd, 0);
>   	if (err) {
> -		printk(KERN_ERR "mmc_erase: group start error %d, "
> +		pr_err("mmc_erase: group start error %d, "
>   		       "status %#x\n", err, cmd.resp[0]);
>   		err = -EIO;
>   		goto out;
> @@ -1542,7 +1542,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_AC;
>   	err = mmc_wait_for_cmd(card->host,&cmd, 0);
>   	if (err) {
> -		printk(KERN_ERR "mmc_erase: group end error %d, status %#x\n",
> +		pr_err("mmc_erase: group end error %d, status %#x\n",
>   		       err, cmd.resp[0]);
>   		err = -EIO;
>   		goto out;
> @@ -1555,7 +1555,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   	cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>   	err = mmc_wait_for_cmd(card->host,&cmd, 0);
>   	if (err) {
> -		printk(KERN_ERR "mmc_erase: erase error %d, status %#x\n",
> +		pr_err("mmc_erase: erase error %d, status %#x\n",
>   		       err, cmd.resp[0]);
>   		err = -EIO;
>   		goto out;
> @@ -1572,7 +1572,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>   		/* Do not retry else we can't see errors */
>   		err = mmc_wait_for_cmd(card->host,&cmd, 0);
>   		if (err || (cmd.resp[0]&  0xFDF92000)) {
> -			printk(KERN_ERR "error %d requesting status %#x\n",
> +			pr_err("error %d requesting status %#x\n",
>   				err, cmd.resp[0]);
>   			err = -EIO;
>   			goto out;
> @@ -2163,7 +2163,7 @@ int mmc_resume_host(struct mmc_host *host)
>   		BUG_ON(!host->bus_ops->resume);
>   		err = host->bus_ops->resume(host);
>   		if (err) {
> -			printk(KERN_WARNING "%s: error %d during resume "
> +			pr_warning("%s: error %d during resume "
>   					    "(card was removed?)\n",
>   					    mmc_hostname(host), err);
>   			err = 0;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index c632b1f..963bf53 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -101,7 +101,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>   		break;
>
>   	default:
> -		printk(KERN_ERR "%s: card has unknown MMCA version %d\n",
> +		pr_err("%s: card has unknown MMCA version %d\n",
>   			mmc_hostname(card->host), card->csd.mmca_vsn);
>   		return -EINVAL;
>   	}
> @@ -135,7 +135,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>   	 */
>   	csd->structure = UNSTUFF_BITS(resp, 126, 2);
>   	if (csd->structure == 0) {
> -		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
> +		pr_err("%s: unrecognised CSD structure version %d\n",
>   			mmc_hostname(card->host), csd->structure);
>   		return -EINVAL;
>   	}
> @@ -195,7 +195,7 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
>   	 */
>   	ext_csd = kmalloc(512, GFP_KERNEL);
>   	if (!ext_csd) {
> -		printk(KERN_ERR "%s: could not allocate a buffer to "
> +		pr_err("%s: could not allocate a buffer to "
>   			"receive the ext_csd.\n", mmc_hostname(card->host));
>   		return -ENOMEM;
>   	}
> @@ -217,12 +217,12 @@ static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
>   		 * stored in their CSD.
>   		 */
>   		if (card->csd.capacity == (4096 * 512)) {
> -			printk(KERN_ERR "%s: unable to read EXT_CSD "
> +			pr_err("%s: unable to read EXT_CSD "
>   				"on a possible high capacity card. "
>   				"Card will be ignored.\n",
>   				mmc_hostname(card->host));
>   		} else {
> -			printk(KERN_WARNING "%s: unable to read "
> +			pr_warning("%s: unable to read "
>   				"EXT_CSD, performance might "
>   				"suffer.\n",
>   				mmc_hostname(card->host));
> @@ -250,7 +250,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
>   	if (card->csd.structure == 3) {
>   		if (card->ext_csd.raw_ext_csd_structure>  2) {
> -			printk(KERN_ERR "%s: unrecognised EXT_CSD structure "
> +			pr_err("%s: unrecognised EXT_CSD structure "
>   				"version %d\n", mmc_hostname(card->host),
>   					card->ext_csd.raw_ext_csd_structure);
>   			err = -EINVAL;
> @@ -260,7 +260,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>
>   	card->ext_csd.rev = ext_csd[EXT_CSD_REV];
>   	if (card->ext_csd.rev>  6) {
> -		printk(KERN_ERR "%s: unrecognised EXT_CSD revision %d\n",
> +		pr_err("%s: unrecognised EXT_CSD revision %d\n",
>   			mmc_hostname(card->host), card->ext_csd.rev);
>   		err = -EINVAL;
>   		goto out;
> @@ -306,7 +306,7 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>   		break;
>   	default:
>   		/* MMC v4 spec says this cannot happen */
> -		printk(KERN_WARNING "%s: card is mmc v4 but doesn't "
> +		pr_warning("%s: card is mmc v4 but doesn't "
>   			"support any high-speed modes.\n",
>   			mmc_hostname(card->host));
>   	}
> @@ -805,7 +805,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   			goto free_card;
>
>   		if (err) {
> -			printk(KERN_WARNING "%s: switch to highspeed failed\n",
> +			pr_warning("%s: switch to highspeed failed\n",
>   			       mmc_hostname(card->host));
>   			err = 0;
>   		} else {
> @@ -914,7 +914,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>   					 0);
>   		}
>   		if (err) {
> -			printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
> +			pr_warning("%s: switch to bus width %d ddr %d "
>   				"failed\n", mmc_hostname(card->host),
>   				1<<  bus_width, ddr);
>   			goto free_card;
> @@ -1152,7 +1152,7 @@ int mmc_attach_mmc(struct mmc_host *host)
>   	 * support.
>   	 */
>   	if (ocr&  0x7F) {
> -		printk(KERN_WARNING "%s: card claims to support voltages "
> +		pr_warning("%s: card claims to support voltages "
>   		       "below the defined range. These will be ignored.\n",
>   		       mmc_hostname(host));
>   		ocr&= ~0x7F;
> @@ -1191,7 +1191,7 @@ remove_card:
>   err:
>   	mmc_detach_bus(host);
>
> -	printk(KERN_ERR "%s: error %d whilst initialising MMC card\n",
> +	pr_err("%s: error %d whilst initialising MMC card\n",
>   		mmc_hostname(host), err);
>
>   	return err;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 7aa13d0..4e11d56 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -414,7 +414,7 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>   			return -EBADMSG;
>   	} else {
>   		if (status&  0xFDFFA000)
> -			printk(KERN_WARNING "%s: unexpected status %#x after "
> +			pr_warning("%s: unexpected status %#x after "
>   			       "switch", mmc_hostname(card->host), status);
>   		if (status&  R1_SWITCH_ERROR)
>   			return -EBADMSG;
> @@ -476,7 +476,7 @@ mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>   	else if (len == 4)
>   		test_buf = testdata_4bit;
>   	else {
> -		printk(KERN_ERR "%s: Invalid bus_width %d\n",
> +		pr_err("%s: Invalid bus_width %d\n",
>   		       mmc_hostname(host), len);
>   		kfree(data_buf);
>   		return -EINVAL;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 342b18c..25b9372 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -163,7 +163,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>   		csd->erase_size = 1;
>   		break;
>   	default:
> -		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",
> +		pr_err("%s: unrecognised CSD structure version %d\n",
>   			mmc_hostname(card->host), csd_struct);
>   		return -EINVAL;
>   	}
> @@ -187,7 +187,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>
>   	scr_struct = UNSTUFF_BITS(resp, 60, 4);
>   	if (scr_struct != 0) {
> -		printk(KERN_ERR "%s: unrecognised SCR structure version %d\n",
> +		pr_err("%s: unrecognised SCR structure version %d\n",
>   			mmc_hostname(card->host), scr_struct);
>   		return -EINVAL;
>   	}
> @@ -218,7 +218,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>   	u32 *ssr;
>
>   	if (!(card->csd.cmdclass&  CCC_APP_SPEC)) {
> -		printk(KERN_WARNING "%s: card lacks mandatory SD Status "
> +		pr_warning("%s: card lacks mandatory SD Status "
>   			"function.\n", mmc_hostname(card->host));
>   		return 0;
>   	}
> @@ -229,7 +229,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>
>   	err = mmc_app_sd_status(card, ssr);
>   	if (err) {
> -		printk(KERN_WARNING "%s: problem reading SD Status "
> +		pr_warning("%s: problem reading SD Status "
>   			"register.\n", mmc_hostname(card->host));
>   		err = 0;
>   		goto out;
> @@ -253,7 +253,7 @@ static int mmc_read_ssr(struct mmc_card *card)
>   			card->ssr.erase_offset = eo * 1000;
>   		}
>   	} else {
> -		printk(KERN_WARNING "%s: SD Status: Invalid Allocation Unit "
> +		pr_warning("%s: SD Status: Invalid Allocation Unit "
>   			"size.\n", mmc_hostname(card->host));
>   	}
>   out:
> @@ -273,7 +273,7 @@ static int mmc_read_switch(struct mmc_card *card)
>   		return 0;
>
>   	if (!(card->csd.cmdclass&  CCC_SWITCH)) {
> -		printk(KERN_WARNING "%s: card lacks mandatory switch "
> +		pr_warning("%s: card lacks mandatory switch "
>   			"function, performance might suffer.\n",
>   			mmc_hostname(card->host));
>   		return 0;
> @@ -283,7 +283,7 @@ static int mmc_read_switch(struct mmc_card *card)
>
>   	status = kmalloc(64, GFP_KERNEL);
>   	if (!status) {
> -		printk(KERN_ERR "%s: could not allocate a buffer for "
> +		pr_err("%s: could not allocate a buffer for "
>   			"switch capabilities.\n",
>   			mmc_hostname(card->host));
>   		return -ENOMEM;
> @@ -299,7 +299,7 @@ static int mmc_read_switch(struct mmc_card *card)
>   		if (err != -EINVAL&&  err != -ENOSYS&&  err != -EFAULT)
>   			goto out;
>
> -		printk(KERN_WARNING "%s: problem reading Bus Speed modes.\n",
> +		pr_warning("%s: problem reading Bus Speed modes.\n",
>   			mmc_hostname(card->host));
>   		err = 0;
>
> @@ -319,7 +319,7 @@ static int mmc_read_switch(struct mmc_card *card)
>   			if (err != -EINVAL&&  err != -ENOSYS&&  err != -EFAULT)
>   				goto out;
>
> -			printk(KERN_WARNING "%s: problem reading "
> +			pr_warning("%s: problem reading "
>   				"Driver Strength.\n",
>   				mmc_hostname(card->host));
>   			err = 0;
> @@ -339,7 +339,7 @@ static int mmc_read_switch(struct mmc_card *card)
>   			if (err != -EINVAL&&  err != -ENOSYS&&  err != -EFAULT)
>   				goto out;
>
> -			printk(KERN_WARNING "%s: problem reading "
> +			pr_warning("%s: problem reading "
>   				"Current Limit.\n",
>   				mmc_hostname(card->host));
>   			err = 0;
> @@ -383,7 +383,7 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>
>   	status = kmalloc(64, GFP_KERNEL);
>   	if (!status) {
> -		printk(KERN_ERR "%s: could not allocate a buffer for "
> +		pr_err("%s: could not allocate a buffer for "
>   			"switch capabilities.\n", mmc_hostname(card->host));
>   		return -ENOMEM;
>   	}
> @@ -393,7 +393,7 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>   		goto out;
>
>   	if ((status[16]&  0xF) != 1) {
> -		printk(KERN_WARNING "%s: Problem switching card "
> +		pr_warning("%s: Problem switching card "
>   			"into high-speed mode!\n",
>   			mmc_hostname(card->host));
>   		err = 0;
> @@ -459,7 +459,7 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
>   		return err;
>
>   	if ((status[15]&  0xF) != drive_strength) {
> -		printk(KERN_WARNING "%s: Problem setting drive strength!\n",
> +		pr_warning("%s: Problem setting drive strength!\n",
>   			mmc_hostname(card->host));
>   		return 0;
>   	}
> @@ -538,7 +538,7 @@ static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
>   		return err;
>
>   	if ((status[16]&  0xF) != card->sd_bus_speed)
> -		printk(KERN_WARNING "%s: Problem setting bus speed mode!\n",
> +		pr_warning("%s: Problem setting bus speed mode!\n",
>   			mmc_hostname(card->host));
>   	else {
>   		mmc_set_timing(card->host, timing);
> @@ -600,7 +600,7 @@ static int sd_set_current_limit(struct mmc_card *card, u8 *status)
>   		return err;
>
>   	if (((status[15]>>  4)&  0x0F) != current_limit)
> -		printk(KERN_WARNING "%s: Problem setting current limit!\n",
> +		pr_warning("%s: Problem setting current limit!\n",
>   			mmc_hostname(card->host));
>
>   	return 0;
> @@ -622,7 +622,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>
>   	status = kmalloc(64, GFP_KERNEL);
>   	if (!status) {
> -		printk(KERN_ERR "%s: could not allocate a buffer for "
> +		pr_err("%s: could not allocate a buffer for "
>   			"switch capabilities.\n", mmc_hostname(card->host));
>   		return -ENOMEM;
>   	}
> @@ -852,7 +852,7 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>   			ro = host->ops->get_ro(host);
>
>   		if (ro<  0) {
> -			printk(KERN_WARNING "%s: host does not "
> +			pr_warning("%s: host does not "
>   				"support reading read-only "
>   				"switch. assuming write-enable.\n",
>   				mmc_hostname(host));
> @@ -1166,7 +1166,7 @@ int mmc_attach_sd(struct mmc_host *host)
>   	 * support.
>   	 */
>   	if (ocr&  0x7F) {
> -		printk(KERN_WARNING "%s: card claims to support voltages "
> +		pr_warning("%s: card claims to support voltages "
>   		       "below the defined range. These will be ignored.\n",
>   		       mmc_hostname(host));
>   		ocr&= ~0x7F;
> @@ -1174,7 +1174,7 @@ int mmc_attach_sd(struct mmc_host *host)
>
>   	if ((ocr&  MMC_VDD_165_195)&&
>   	!(host->ocr_avail_sd&  MMC_VDD_165_195)) {
> -		printk(KERN_WARNING "%s: SD card claims to support the "
> +		pr_warning("%s: SD card claims to support the "
>   		       "incompletely defined 'low voltage range'. This "
>   		       "will be ignored.\n", mmc_hostname(host));
>   		ocr&= ~MMC_VDD_165_195;
> @@ -1213,7 +1213,7 @@ remove_card:
>   err:
>   	mmc_detach_bus(host);
>
> -	printk(KERN_ERR "%s: error %d whilst initialising SD card\n",
> +	pr_err("%s: error %d whilst initialising SD card\n",
>   		mmc_hostname(host), err);
>
>   	return err;
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 698d813..925bab0 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -112,7 +112,7 @@ static int sdio_read_cccr(struct mmc_card *card)
>   	cccr_vsn = data&  0x0f;
>
>   	if (cccr_vsn>  SDIO_CCCR_REV_1_20) {
> -		printk(KERN_ERR "%s: unrecognised CCCR structure version %d\n",
> +		pr_err("%s: unrecognised CCCR structure version %d\n",
>   			mmc_hostname(card->host), cccr_vsn);
>   		return -EINVAL;
>   	}
> @@ -777,7 +777,7 @@ int mmc_attach_sdio(struct mmc_host *host)
>   	 * support.
>   	 */
>   	if (ocr&  0x7F) {
> -		printk(KERN_WARNING "%s: card claims to support voltages "
> +		pr_warning("%s: card claims to support voltages "
>   		       "below the defined range. These will be ignored.\n",
>   		       mmc_hostname(host));
>   		ocr&= ~0x7F;
> @@ -874,7 +874,7 @@ remove:
>   err:
>   	mmc_detach_bus(host);
>
> -	printk(KERN_ERR "%s: error %d whilst initialising SDIO card\n",
> +	pr_err("%s: error %d whilst initialising SDIO card\n",
>   		mmc_hostname(host), err);
>
>   	return err;
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index e4e6822..c643b2f 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -173,7 +173,7 @@ static int sdio_bus_remove(struct device *dev)
>   	drv->remove(func);
>
>   	if (func->irq_handler) {
> -		printk(KERN_WARNING "WARNING: driver %s did not remove "
> +		pr_warning("WARNING: driver %s did not remove "
>   			"its interrupt handler!\n", drv->name);
>   		sdio_claim_host(func);
>   		sdio_release_irq(func);
> diff --git a/drivers/mmc/core/sdio_cis.c b/drivers/mmc/core/sdio_cis.c
> index 541bdb8..f1c7ed8 100644
> --- a/drivers/mmc/core/sdio_cis.c
> +++ b/drivers/mmc/core/sdio_cis.c
> @@ -132,7 +132,7 @@ static int cis_tpl_parse(struct mmc_card *card, struct sdio_func *func,
>   			ret = -EINVAL;
>   		}
>   		if (ret&&  ret != -EILSEQ&&  ret != -ENOENT) {
> -			printk(KERN_ERR "%s: bad %s tuple 0x%02x (%u bytes)\n",
> +			pr_err("%s: bad %s tuple 0x%02x (%u bytes)\n",
>   			       mmc_hostname(card->host), tpl_descr, code, size);
>   		}
>   	} else {
> @@ -313,7 +313,7 @@ static int sdio_read_cis(struct mmc_card *card, struct sdio_func *func)
>
>   			if (ret == -ENOENT) {
>   				/* warn about unknown tuples */
> -				printk(KERN_WARNING "%s: queuing unknown"
> +				pr_warning("%s: queuing unknown"
>   				       " CIS tuple 0x%02x (%u bytes)\n",
>   				       mmc_hostname(card->host),
>   				       tpl_code, tpl_link);
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 03ead02..b644dd5 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -45,7 +45,7 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>
>   	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0,&pending);
>   	if (ret) {
> -		printk(KERN_DEBUG "%s: error %d reading SDIO_CCCR_INTx\n",
> +		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
>   		       mmc_card_id(card), ret);
>   		return ret;
>   	}
> @@ -55,7 +55,7 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>   		if (pending&  (1<<  i)) {
>   			func = card->sdio_func[i - 1];
>   			if (!func) {
> -				printk(KERN_WARNING "%s: pending IRQ for "
> +				pr_warning("%s: pending IRQ for "
>   					"non-existent function\n",
>   					mmc_card_id(card));
>   				ret = -EINVAL;
> @@ -63,7 +63,7 @@ static int process_sdio_pending_irqs(struct mmc_card *card)
>   				func->irq_handler(func);
>   				count++;
>   			} else {
> -				printk(KERN_WARNING "%s: pending IRQ with no handler\n",
> +				pr_warning("%s: pending IRQ with no handler\n",
>   				       sdio_func_id(func));
>   				ret = -EINVAL;
>   			}
> diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
> index ef72e87..707bc7d 100644
> --- a/drivers/mmc/host/au1xmmc.c
> +++ b/drivers/mmc/host/au1xmmc.c
> @@ -55,7 +55,7 @@
>
>   #ifdef DEBUG
>   #define DBG(fmt, idx, args...)	\
> -	printk(KERN_DEBUG "au1xmmc(%d): DEBUG: " fmt, idx, ##args)
> +	pr_debug("au1xmmc(%d): DEBUG: " fmt, idx, ##args)
>   #else
>   #define DBG(fmt, idx, args...) do {} while (0)
>   #endif
> @@ -268,7 +268,7 @@ static int au1xmmc_send_command(struct au1xmmc_host *host, int wait,
>   		mmccmd |= SD_CMD_RT_3;
>   		break;
>   	default:
> -		printk(KERN_INFO "au1xmmc: unhandled response type %02x\n",
> +		pr_info("au1xmmc: unhandled response type %02x\n",
>   			mmc_resp_type(cmd));
>   		return -EINVAL;
>   	}
> @@ -1031,7 +1031,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
>   #ifdef CONFIG_SOC_AU1200
>   	ret = au1xmmc_dbdma_init(host);
>   	if (ret)
> -		printk(KERN_INFO DRIVER_NAME ": DBDMA init failed; using PIO\n");
> +		pr_info(DRIVER_NAME ": DBDMA init failed; using PIO\n");
>   #endif
>
>   #ifdef CONFIG_LEDS_CLASS
> @@ -1056,7 +1056,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
>
>   	platform_set_drvdata(pdev, host);
>
> -	printk(KERN_INFO DRIVER_NAME ": MMC Controller %d set up at %8.8X"
> +	pr_info(DRIVER_NAME ": MMC Controller %d set up at %8.8X"
>   		" (mode=%s)\n", pdev->id, host->iobase,
>   		host->flags&  HOST_F_DMA ? "dma" : "pio");
>
> @@ -1188,7 +1188,7 @@ static int __init au1xmmc_init(void)
>   	 */
>   	memid = au1xxx_ddma_add_device(&au1xmmc_mem_dbdev);
>   	if (!memid)
> -		printk(KERN_ERR "au1xmmc: cannot add memory dbdma dev\n");
> +		pr_err("au1xmmc: cannot add memory dbdma dev\n");
>   #endif
>   	return platform_driver_register(&au1xmmc_driver);
>   }
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0ed1d28..701f14e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1701,7 +1701,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>
>   	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>   	if (IS_ERR(host->vmmc)) {
> -		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
> +		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>   		host->vmmc = NULL;
>   	} else
>   		regulator_enable(host->vmmc);
> diff --git a/drivers/mmc/host/imxmmc.c b/drivers/mmc/host/imxmmc.c
> index 881f7ba..ea0f3ce 100644
> --- a/drivers/mmc/host/imxmmc.c
> +++ b/drivers/mmc/host/imxmmc.c
> @@ -942,7 +942,7 @@ static int __init imxmci_probe(struct platform_device *pdev)
>   	int ret = 0, irq;
>   	u16 rev_no;
>
> -	printk(KERN_INFO "i.MX mmc driver\n");
> +	pr_info("i.MX mmc driver\n");
>
>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	irq = platform_get_irq(pdev, 0);
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 40e4c05..4602771 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -464,7 +464,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
>   	struct mmci_host_next *next =&host->next_data;
>
>   	if (data->host_cookie&&  data->host_cookie != next->cookie) {
> -		printk(KERN_WARNING "[%s] invalid cookie: data->host_cookie %d"
> +		pr_warning("[%s] invalid cookie: data->host_cookie %d"
>   		       " host->next_data.cookie %d\n",
>   		       __func__, data->host_cookie, host->next_data.cookie);
>   		data->host_cookie = 0;
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 61c7d38..80d8eb1 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -389,7 +389,7 @@ static int msmsdcc_config_dma(struct msmsdcc_host *host, struct mmc_data *data)
>   	n = dma_map_sg(mmc_dev(host->mmc), host->dma.sg,
>   			host->dma.num_ents, host->dma.dir);
>   	if (n == 0) {
> -		printk(KERN_ERR "%s: Unable to map in all sg elements\n",
> +		pr_err("%s: Unable to map in all sg elements\n",
>   			mmc_hostname(host->mmc));
>   		host->dma.sg = NULL;
>   		host->dma.num_ents = 0;
> @@ -475,7 +475,7 @@ msmsdcc_start_command_deferred(struct msmsdcc_host *host,
>   		*c |= MCI_CSPM_MCIABORT;
>
>   	if (host->curr.cmd != NULL) {
> -		printk(KERN_ERR "%s: Overlapping command requests\n",
> +		pr_err("%s: Overlapping command requests\n",
>   			mmc_hostname(host->mmc));
>   	}
>   	host->curr.cmd = cmd;
> @@ -1113,7 +1113,7 @@ msmsdcc_platform_status_irq(int irq, void *dev_id)
>   {
>   	struct msmsdcc_host *host = dev_id;
>
> -	printk(KERN_DEBUG "%s: %d\n", __func__, irq);
> +	pr_debug("%s: %d\n", __func__, irq);
>   	msmsdcc_check_status((unsigned long) host);
>   	return IRQ_HANDLED;
>   }
> @@ -1123,7 +1123,7 @@ msmsdcc_status_notify_cb(int card_present, void *dev_id)
>   {
>   	struct msmsdcc_host *host = dev_id;
>
> -	printk(KERN_DEBUG "%s: card_present %d\n", mmc_hostname(host->mmc),
> +	pr_debug("%s: card_present %d\n", mmc_hostname(host->mmc),
>   	       card_present);
>   	msmsdcc_check_status((unsigned long) host);
>   }
> diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
> index a5bf60e..211a495 100644
> --- a/drivers/mmc/host/mvsdio.c
> +++ b/drivers/mmc/host/mvsdio.c
> @@ -117,7 +117,7 @@ static int mvsd_setup_data(struct mvsd_host *host, struct mmc_data *data)
>   		host->pio_size = data->blocks * data->blksz;
>   		host->pio_ptr = sg_virt(data->sg);
>   		if (!nodma)
> -			printk(KERN_DEBUG "%s: fallback to PIO for data "
> +			pr_debug("%s: fallback to PIO for data "
>   					  "at 0x%p size %d\n",
>   					  mmc_hostname(host->mmc),
>   					  host->pio_ptr, host->pio_size);
> @@ -471,7 +471,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>   		if (mrq->data)
>   			err_status = mvsd_finish_data(host, mrq->data, err_status);
>   		if (err_status) {
> -			printk(KERN_ERR "%s: unhandled error status %#04x\n",
> +			pr_err("%s: unhandled error status %#04x\n",
>   					mmc_hostname(host->mmc), err_status);
>   			cmd->error = -ENOMSG;
>   		}
> @@ -489,7 +489,7 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
>   	if (irq_handled)
>   		return IRQ_HANDLED;
>
> -	printk(KERN_ERR "%s: unhandled interrupt status=0x%04x en=0x%04x "
> +	pr_err("%s: unhandled interrupt status=0x%04x en=0x%04x "
>   			"pio=%d\n", mmc_hostname(host->mmc), intr_status,
>   			host->intr_en, host->pio_size);
>   	return IRQ_NONE;
> @@ -505,9 +505,9 @@ static void mvsd_timeout_timer(unsigned long data)
>   	spin_lock_irqsave(&host->lock, flags);
>   	mrq = host->mrq;
>   	if (mrq) {
> -		printk(KERN_ERR "%s: Timeout waiting for hardware interrupt.\n",
> +		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>   				mmc_hostname(host->mmc));
> -		printk(KERN_ERR "%s: hw_state=0x%04x, intr_status=0x%04x "
> +		pr_err("%s: hw_state=0x%04x, intr_status=0x%04x "
>   				"intr_en=0x%04x\n", mmc_hostname(host->mmc),
>   				mvsd_read(MVSD_HW_STATE),
>   				mvsd_read(MVSD_NOR_INTR_STATUS),
> @@ -762,7 +762,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
>
>   	ret = request_irq(irq, mvsd_irq, 0, DRIVER_NAME, host);
>   	if (ret) {
> -		printk(KERN_ERR "%s: cannot assign irq %d\n", DRIVER_NAME, irq);
> +		pr_err("%s: cannot assign irq %d\n", DRIVER_NAME, irq);
>   		goto out;
>   	} else
>   		host->irq = irq;
> @@ -802,7 +802,7 @@ static int __init mvsd_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto out;
>
> -	printk(KERN_NOTICE "%s: %s driver initialized, ",
> +	pr_notice("%s: %s driver initialized, ",
>   			   mmc_hostname(mmc), DRIVER_NAME);
>   	if (host->gpio_card_detect)
>   		printk("using GPIO %d for card detection\n",
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index 14aa213..f48743d 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -842,7 +842,7 @@ static int mxcmci_probe(struct platform_device *pdev)
>   	int ret = 0, irq;
>   	dma_cap_mask_t mask;
>
> -	printk(KERN_INFO "i.MX SDHC driver\n");
> +	pr_info("i.MX SDHC driver\n");
>
>   	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	irq = platform_get_irq(pdev, 0);
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 75c6395..3c900f3 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1264,14 +1264,14 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
>   	host->reqs_blocked = 0;
>   	if (mmc_slot(host).get_cover_state(host->dev, host->slot_id)) {
>   		if (host->protect_card) {
> -			printk(KERN_INFO "%s: cover is closed, "
> +			pr_info("%s: cover is closed, "
>   					 "card is now accessible\n",
>   					 mmc_hostname(host->mmc));
>   			host->protect_card = 0;
>   		}
>   	} else {
>   		if (!host->protect_card) {
> -			printk(KERN_INFO "%s: cover is open, "
> +			pr_info"%s: cover is open, "
>   					 "card is now inaccessible\n",
>   					 mmc_hostname(host->mmc));
>   			host->protect_card = 1;
> @@ -1422,7 +1422,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
>
>   	if (!next&&  data->host_cookie&&
>   	data->host_cookie != host->next_data.cookie) {
> -		printk(KERN_WARNING "[%s] invalid cookie: data->host_cookie %d"
> +		pr_warning("[%s] invalid cookie: data->host_cookie %d"
>   		       " host->next_data.cookie %d\n",
>   		       __func__, data->host_cookie, host->next_data.cookie);
>   		data->host_cookie = 0;
> diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
> index 7257738..fc4356e 100644
> --- a/drivers/mmc/host/pxamci.c
> +++ b/drivers/mmc/host/pxamci.c
> @@ -558,7 +558,7 @@ static void pxamci_dma_irq(int dma, void *devid)
>   	if (dcsr&  DCSR_ENDINTR) {
>   		writel(BUF_PART_FULL, host->base + MMC_PRTBUF);
>   	} else {
> -		printk(KERN_ERR "%s: DMA error on channel %d (DCSR=%#x)\n",
> +		pr_err("%s: DMA error on channel %d (DCSR=%#x)\n",
>   		       mmc_hostname(host->mmc), dma, dcsr);
>   		host->data->error = -EIO;
>   		pxamci_data_done(host, 0);
> diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> index a04f87d..16ea29e 100644
> --- a/drivers/mmc/host/s3cmci.c
> +++ b/drivers/mmc/host/s3cmci.c
> @@ -247,7 +247,7 @@ static void s3cmci_check_sdio_irq(struct s3cmci_host *host)
>   {
>   	if (host->sdio_irqen) {
>   		if (gpio_get_value(S3C2410_GPE(8)) == 0) {
> -			printk(KERN_DEBUG "%s: signalling irq\n", __func__);
> +			pr_debug("%s: signalling irq\n", __func__);
>   			mmc_signal_sdio_irq(host->mmc);
>   		}
>   	}
> @@ -344,7 +344,7 @@ static void s3cmci_disable_irq(struct s3cmci_host *host, bool transfer)
>
>   	local_irq_save(flags);
>
> -	//printk(KERN_DEBUG "%s: transfer %d\n", __func__, transfer);
> +	/* pr_debug("%s: transfer %d\n", __func__, transfer); */
>
>   	host->irq_disabled = transfer;
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d66a7a1..bec979d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -51,51 +51,51 @@ static void sdhci_tuning_timer(unsigned long data);
>
>   static void sdhci_dumpregs(struct sdhci_host *host)
>   {
> -	printk(KERN_DEBUG DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
> +	pr_debug(DRIVER_NAME ": =========== REGISTER DUMP (%s)===========\n",
>   		mmc_hostname(host->mmc));
>
> -	printk(KERN_DEBUG DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Sys addr: 0x%08x | Version:  0x%08x\n",
>   		sdhci_readl(host, SDHCI_DMA_ADDRESS),
>   		sdhci_readw(host, SDHCI_HOST_VERSION));
> -	printk(KERN_DEBUG DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Blk size: 0x%08x | Blk cnt:  0x%08x\n",
>   		sdhci_readw(host, SDHCI_BLOCK_SIZE),
>   		sdhci_readw(host, SDHCI_BLOCK_COUNT));
> -	printk(KERN_DEBUG DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Argument: 0x%08x | Trn mode: 0x%08x\n",
>   		sdhci_readl(host, SDHCI_ARGUMENT),
>   		sdhci_readw(host, SDHCI_TRANSFER_MODE));
> -	printk(KERN_DEBUG DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
>   		sdhci_readl(host, SDHCI_PRESENT_STATE),
>   		sdhci_readb(host, SDHCI_HOST_CONTROL));
> -	printk(KERN_DEBUG DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
>   		sdhci_readb(host, SDHCI_POWER_CONTROL),
>   		sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
> -	printk(KERN_DEBUG DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Wake-up:  0x%08x | Clock:    0x%08x\n",
>   		sdhci_readb(host, SDHCI_WAKE_UP_CONTROL),
>   		sdhci_readw(host, SDHCI_CLOCK_CONTROL));
> -	printk(KERN_DEBUG DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Timeout:  0x%08x | Int stat: 0x%08x\n",
>   		sdhci_readb(host, SDHCI_TIMEOUT_CONTROL),
>   		sdhci_readl(host, SDHCI_INT_STATUS));
> -	printk(KERN_DEBUG DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Int enab: 0x%08x | Sig enab: 0x%08x\n",
>   		sdhci_readl(host, SDHCI_INT_ENABLE),
>   		sdhci_readl(host, SDHCI_SIGNAL_ENABLE));
> -	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
>   		sdhci_readw(host, SDHCI_ACMD12_ERR),
>   		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
> -	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Caps:     0x%08x | Caps_1:   0x%08x\n",
>   		sdhci_readl(host, SDHCI_CAPABILITIES),
>   		sdhci_readl(host, SDHCI_CAPABILITIES_1));
> -	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
>   		sdhci_readw(host, SDHCI_COMMAND),
>   		sdhci_readl(host, SDHCI_MAX_CURRENT));
> -	printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\n",
> +	pr_debug(DRIVER_NAME ": Host ctl2: 0x%08x\n",
>   		sdhci_readw(host, SDHCI_HOST_CONTROL2));
>
>   	if (host->flags&  SDHCI_USE_ADMA)
> -		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
> +		pr_debug(DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
>   		       readl(host->ioaddr + SDHCI_ADMA_ERROR),
>   		       readl(host->ioaddr + SDHCI_ADMA_ADDRESS));
>
> -	printk(KERN_DEBUG DRIVER_NAME ": ===========================================\n");
> +	pr_debug(DRIVER_NAME ": ===========================================\n");
>   }
>
>   /*****************************************************************************\
> @@ -180,7 +180,7 @@ static void sdhci_reset(struct sdhci_host *host, u8 mask)
>   	/* hw clears the bit when it's done */
>   	while (sdhci_readb(host, SDHCI_SOFTWARE_RESET)&  mask) {
>   		if (timeout == 0) {
> -			printk(KERN_ERR "%s: Reset 0x%x never completed.\n",
> +			pr_err("%s: Reset 0x%x never completed.\n",
>   				mmc_hostname(host->mmc), (int)mask);
>   			sdhci_dumpregs(host);
>   			return;
> @@ -654,7 +654,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>   	}
>
>   	if (count>= 0xF) {
> -		printk(KERN_WARNING "%s: Too large timeout requested for CMD%d!\n",
> +		pr_warning("%s: Too large timeout requested for CMD%d!\n",
>   		       mmc_hostname(host->mmc), cmd->opcode);
>   		count = 0xE;
>   	}
> @@ -949,7 +949,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>
>   	while (sdhci_readl(host, SDHCI_PRESENT_STATE)&  mask) {
>   		if (timeout == 0) {
> -			printk(KERN_ERR "%s: Controller never released "
> +			pr_err("%s: Controller never released "
>   				"inhibit bit(s).\n", mmc_hostname(host->mmc));
>   			sdhci_dumpregs(host);
>   			cmd->error = -EIO;
> @@ -971,7 +971,7 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>   	sdhci_set_transfer_mode(host, cmd);
>
>   	if ((cmd->flags&  MMC_RSP_136)&&  (cmd->flags&  MMC_RSP_BUSY)) {
> -		printk(KERN_ERR "%s: Unsupported response type!\n",
> +		pr_err("%s: Unsupported response type!\n",
>   			mmc_hostname(host->mmc));
>   		cmd->error = -EINVAL;
>   		tasklet_schedule(&host->finish_tasklet);
> @@ -1121,7 +1121,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>   	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
>   		&  SDHCI_CLOCK_INT_STABLE)) {
>   		if (timeout == 0) {
> -			printk(KERN_ERR "%s: Internal clock never "
> +			pr_err("%s: Internal clock never "
>   				"stabilised.\n", mmc_hostname(host->mmc));
>   			sdhci_dumpregs(host);
>   			return;
> @@ -1536,7 +1536,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>   		if (!(ctrl&  SDHCI_CTRL_VDD_180))
>   			return 0;
>   		else {
> -			printk(KERN_INFO DRIVER_NAME ": Switching to 3.3V "
> +			pr_info(DRIVER_NAME ": Switching to 3.3V "
>   				"signalling voltage failed\n");
>   			return -EIO;
>   		}
> @@ -1595,7 +1595,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>   		pwr |= SDHCI_POWER_ON;
>   		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
>
> -		printk(KERN_INFO DRIVER_NAME ": Switching to 1.8V signalling "
> +		pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
>   			"voltage failed, retrying with S18R set to 0\n");
>   		return -EAGAIN;
>   	} else
> @@ -1702,7 +1702,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>   		spin_lock(&host->lock);
>
>   		if (!host->tuning_done) {
> -			printk(KERN_INFO DRIVER_NAME ": Timeout waiting for "
> +			pr_info(DRIVER_NAME ": Timeout waiting for "
>   				"Buffer Read Ready interrupt during tuning "
>   				"procedure, falling back to fixed sampling "
>   				"clock\n");
> @@ -1732,7 +1732,7 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
>   		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>   	} else {
>   		if (!(ctrl&  SDHCI_CTRL_TUNED_CLK)) {
> -			printk(KERN_INFO DRIVER_NAME ": Tuning procedure"
> +			pr_info(DRIVER_NAME ": Tuning procedure"
>   				" failed, falling back to fixed sampling"
>   				" clock\n");
>   			err = -EIO;
> @@ -1837,9 +1837,9 @@ static void sdhci_tasklet_card(unsigned long param)
>
>   	if (!(sdhci_readl(host, SDHCI_PRESENT_STATE)&  SDHCI_CARD_PRESENT)) {
>   		if (host->mrq) {
> -			printk(KERN_ERR "%s: Card removed during transfer!\n",
> +			pr_err("%s: Card removed during transfer!\n",
>   				mmc_hostname(host->mmc));
> -			printk(KERN_ERR "%s: Resetting controller.\n",
> +			pr_err("%s: Resetting controller.\n",
>   				mmc_hostname(host->mmc));
>
>   			sdhci_reset(host, SDHCI_RESET_CMD);
> @@ -1926,7 +1926,7 @@ static void sdhci_timeout_timer(unsigned long data)
>   	spin_lock_irqsave(&host->lock, flags);
>
>   	if (host->mrq) {
> -		printk(KERN_ERR "%s: Timeout waiting for hardware "
> +		pr_err("%s: Timeout waiting for hardware "
>   			"interrupt.\n", mmc_hostname(host->mmc));
>   		sdhci_dumpregs(host);
>
> @@ -1972,7 +1972,7 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask)
>   	BUG_ON(intmask == 0);
>
>   	if (!host->cmd) {
> -		printk(KERN_ERR "%s: Got command interrupt 0x%08x even "
> +		pr_err("%s: Got command interrupt 0x%08x even "
>   			"though no command operation was in progress.\n",
>   			mmc_hostname(host->mmc), (unsigned)intmask);
>   		sdhci_dumpregs(host);
> @@ -2072,7 +2072,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>   			}
>   		}
>
> -		printk(KERN_ERR "%s: Got data interrupt 0x%08x even "
> +		pr_err("%s: Got data interrupt 0x%08x even "
>   			"though no data operation was in progress.\n",
>   			mmc_hostname(host->mmc), (unsigned)intmask);
>   		sdhci_dumpregs(host);
> @@ -2089,7 +2089,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>   			!= MMC_BUS_TEST_R)
>   		host->data->error = -EILSEQ;
>   	else if (intmask&  SDHCI_INT_ADMA_ERROR) {
> -		printk(KERN_ERR "%s: ADMA error\n", mmc_hostname(host->mmc));
> +		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
>   		sdhci_show_adma_error(host);
>   		host->data->error = -EIO;
>   	}
> @@ -2203,7 +2203,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>   	intmask&= ~SDHCI_INT_ERROR;
>
>   	if (intmask&  SDHCI_INT_BUS_POWER) {
> -		printk(KERN_ERR "%s: Card is consuming too much power!\n",
> +		pr_err("%s: Card is consuming too much power!\n",
>   			mmc_hostname(host->mmc));
>   		sdhci_writel(host, SDHCI_INT_BUS_POWER, SDHCI_INT_STATUS);
>   	}
> @@ -2216,7 +2216,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>   	intmask&= ~SDHCI_INT_CARD_INT;
>
>   	if (intmask) {
> -		printk(KERN_ERR "%s: Unexpected interrupt 0x%08x.\n",
> +		pr_err("%s: Unexpected interrupt 0x%08x.\n",
>   			mmc_hostname(host->mmc), intmask);
>   		sdhci_dumpregs(host);
>
> @@ -2372,7 +2372,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   	host->version = (host->version&  SDHCI_SPEC_VER_MASK)
>   				>>  SDHCI_SPEC_VER_SHIFT;
>   	if (host->version>  SDHCI_SPEC_300) {
> -		printk(KERN_ERR "%s: Unknown controller version (%d). "
> +		pr_err("%s: Unknown controller version (%d). "
>   			"You may experience problems.\n", mmc_hostname(mmc),
>   			host->version);
>   	}
> @@ -2409,7 +2409,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   	if (host->flags&  (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
>   		if (host->ops->enable_dma) {
>   			if (host->ops->enable_dma(host)) {
> -				printk(KERN_WARNING "%s: No suitable DMA "
> +				pr_warning("%s: No suitable DMA "
>   					"available. Falling back to PIO.\n",
>   					mmc_hostname(mmc));
>   				host->flags&=
> @@ -2429,7 +2429,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   		if (!host->adma_desc || !host->align_buffer) {
>   			kfree(host->adma_desc);
>   			kfree(host->align_buffer);
> -			printk(KERN_WARNING "%s: Unable to allocate ADMA "
> +			pr_warning("%s: Unable to allocate ADMA "
>   				"buffers. Falling back to standard DMA.\n",
>   				mmc_hostname(mmc));
>   			host->flags&= ~SDHCI_USE_ADMA;
> @@ -2457,8 +2457,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   	if (host->max_clk == 0 || host->quirks&
>   			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
>   		if (!host->ops->get_max_clock) {
> -			printk(KERN_ERR
> -			       "%s: Hardware doesn't specify base clock "
> +			pr_err("%s: Hardware doesn't specify base clock "
>   			       "frequency.\n", mmc_hostname(mmc));
>   			return -ENODEV;
>   		}
> @@ -2504,8 +2503,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   			host->timeout_clk = host->ops->get_timeout_clock(host);
>   		} else if (!(host->quirks&
>   				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
> -			printk(KERN_ERR
> -			       "%s: Hardware doesn't specify timeout clock "
> +			pr_err("%s: Hardware doesn't specify timeout clock "
>   			       "frequency.\n", mmc_hostname(mmc));
>   			return -ENODEV;
>   		}
> @@ -2664,7 +2662,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   		mmc->ocr_avail_mmc&= host->ocr_avail_mmc;
>
>   	if (mmc->ocr_avail == 0) {
> -		printk(KERN_ERR "%s: Hardware doesn't report any "
> +		pr_err("%s: Hardware doesn't report any "
>   			"support voltages.\n", mmc_hostname(mmc));
>   		return -ENODEV;
>   	}
> @@ -2712,7 +2710,7 @@ int sdhci_add_host(struct sdhci_host *host)
>   		mmc->max_blk_size = (caps[0]&  SDHCI_MAX_BLOCK_MASK)>>
>   				SDHCI_MAX_BLOCK_SHIFT;
>   		if (mmc->max_blk_size>= 3) {
> -			printk(KERN_WARNING "%s: Invalid maximum block size, "
> +			pr_warning("%s: Invalid maximum block size, "
>   				"assuming 512 bytes\n", mmc_hostname(mmc));
>   			mmc->max_blk_size = 0;
>   		}
> @@ -2751,7 +2749,7 @@ int sdhci_add_host(struct sdhci_host *host)
>
>   	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>   	if (IS_ERR(host->vmmc)) {
> -		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
> +		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>   		host->vmmc = NULL;
>   	} else {
>   		regulator_enable(host->vmmc);
> @@ -2780,7 +2778,7 @@ int sdhci_add_host(struct sdhci_host *host)
>
>   	mmc_add_host(mmc);
>
> -	printk(KERN_INFO "%s: SDHCI controller on %s [%s] using %s\n",
> +	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
>   		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
>   		(host->flags&  SDHCI_USE_ADMA) ? "ADMA" :
>   		(host->flags&  SDHCI_USE_SDMA) ? "DMA" : "PIO");
> @@ -2813,7 +2811,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
>   		host->flags |= SDHCI_DEVICE_DEAD;
>
>   		if (host->mrq) {
> -			printk(KERN_ERR "%s: Controller removed during "
> +			pr_err("%s: Controller removed during "
>   				" transfer!\n", mmc_hostname(host->mmc));
>
>   			host->mrq->cmd->error = -ENOMEDIUM;
> @@ -2872,9 +2870,9 @@ EXPORT_SYMBOL_GPL(sdhci_free_host);
>
>   static int __init sdhci_drv_init(void)
>   {
> -	printk(KERN_INFO DRIVER_NAME
> +	pr_info(DRIVER_NAME
>   		": Secure Digital Host Controller Interface driver\n");
> -	printk(KERN_INFO DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> +	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
>
>   	return 0;
>   }
> diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
> index 457c26e..052e613 100644
> --- a/drivers/mmc/host/tifm_sd.c
> +++ b/drivers/mmc/host/tifm_sd.c
> @@ -631,7 +631,7 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   	}
>
>   	if (host->req) {
> -		printk(KERN_ERR "%s : unfinished request detected\n",
> +		pr_err("%s : unfinished request detected\n",
>   		       dev_name(&sock->dev));
>   		mrq->cmd->error = -ETIMEDOUT;
>   		goto err_out;
> @@ -671,7 +671,7 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   					    r_data->flags&  MMC_DATA_WRITE
>   					    ? PCI_DMA_TODEVICE
>   					    : PCI_DMA_FROMDEVICE)) {
> -				printk(KERN_ERR "%s : scatterlist map failed\n",
> +				pr_err("%s : scatterlist map failed\n",
>   				       dev_name(&sock->dev));
>   				mrq->cmd->error = -ENOMEM;
>   				goto err_out;
> @@ -683,7 +683,7 @@ static void tifm_sd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>   						   ? PCI_DMA_TODEVICE
>   						   : PCI_DMA_FROMDEVICE);
>   			if (host->sg_len<  1) {
> -				printk(KERN_ERR "%s : scatterlist map failed\n",
> +				pr_err("%s : scatterlist map failed\n",
>   				       dev_name(&sock->dev));
>   				tifm_unmap_sg(sock,&host->bounce_buf, 1,
>   					      r_data->flags&  MMC_DATA_WRITE
> @@ -747,7 +747,7 @@ static void tifm_sd_end_cmd(unsigned long data)
>   	host->req = NULL;
>
>   	if (!mrq) {
> -		printk(KERN_ERR " %s : no request to complete?\n",
> +		pr_err(" %s : no request to complete?\n",
>   		       dev_name(&sock->dev));
>   		spin_unlock_irqrestore(&sock->lock, flags);
>   		return;
> @@ -786,8 +786,7 @@ static void tifm_sd_abort(unsigned long data)
>   {
>   	struct tifm_sd *host = (struct tifm_sd*)data;
>
> -	printk(KERN_ERR
> -	       "%s : card failed to respond for a long period of time "
> +	pr_err("%s : card failed to respond for a long period of time "
>   	       "(%x, %x)\n",
>   	       dev_name(&host->dev->dev), host->req->cmd->opcode, host->cmd_flags);
>
> @@ -905,7 +904,7 @@ static int tifm_sd_initialize_host(struct tifm_sd *host)
>   	}
>
>   	if (rc) {
> -		printk(KERN_ERR "%s : controller failed to reset\n",
> +		pr_err("%s : controller failed to reset\n",
>   		       dev_name(&sock->dev));
>   		return -ENODEV;
>   	}
> @@ -931,8 +930,7 @@ static int tifm_sd_initialize_host(struct tifm_sd *host)
>   	}
>
>   	if (rc) {
> -		printk(KERN_ERR
> -		       "%s : card not ready - probe failed on initialization\n",
> +		pr_err("%s : card not ready - probe failed on initialization\n",
>   		       dev_name(&sock->dev));
>   		return -ENODEV;
>   	}
> @@ -953,7 +951,7 @@ static int tifm_sd_probe(struct tifm_dev *sock)
>
>   	if (!(TIFM_SOCK_STATE_OCCUPIED
>   	&  readl(sock->addr + SOCK_PRESENT_STATE))) {
> -		printk(KERN_WARNING "%s : card gone, unexpectedly\n",
> +		pr_warning("%s : card gone, unexpectedly\n",
>   		       dev_name(&sock->dev));
>   		return rc;
>   	}
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 6275e3d..d85a60c 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -92,7 +92,7 @@ static int tmio_mmc_next_sg(struct tmio_mmc_host *host)
>   static void pr_debug_status(u32 status)
>   {
>   	int i = 0;
> -	printk(KERN_DEBUG "status: %08x = ", status);
> +	pr_debug("status: %08x = ", status);
>   	STATUS_TO_TEXT(CARD_REMOVE, status, i);
>   	STATUS_TO_TEXT(CARD_INSERT, status, i);
>   	STATUS_TO_TEXT(SIGSTATE, status, i);
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 4dfe2c0..7cebf97 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1191,7 +1191,7 @@ static void __devexit via_sd_remove(struct pci_dev *pcidev)
>   	mmiowb();
>
>   	if (sdhost->mrq) {
> -		printk(KERN_ERR "%s: Controller removed during "
> +		pr_err("%s: Controller removed during "
>   			"transfer\n", mmc_hostname(sdhost->mmc));
>
>   		/* make sure all DMA is stopped */
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index 62e5a4d..64acd9c 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -194,7 +194,7 @@ static void wbsd_reset(struct wbsd_host *host)
>   {
>   	u8 setup;
>
> -	printk(KERN_ERR "%s: Resetting chip\n", mmc_hostname(host->mmc));
> +	pr_err("%s: Resetting chip\n", mmc_hostname(host->mmc));
>
>   	/*
>   	 * Soft reset of chip (SD/MMC part).
> @@ -721,7 +721,7 @@ static void wbsd_finish_data(struct wbsd_host *host, struct mmc_data *data)
>   		 * Any leftover data?
>   		 */
>   		if (count) {
> -			printk(KERN_ERR "%s: Incomplete DMA transfer. "
> +			pr_err("%s: Incomplete DMA transfer. "
>   				"%d bytes left.\n",
>   				mmc_hostname(host->mmc), count);
>
> @@ -803,7 +803,7 @@ static void wbsd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>
>   		default:
>   #ifdef CONFIG_MMC_DEBUG
> -			printk(KERN_WARNING "%s: Data command %d is not "
> +			pr_warning("%s: Data command %d is not "
>   				"supported by this controller.\n",
>   				mmc_hostname(host->mmc), cmd->opcode);
>   #endif
> @@ -1029,7 +1029,7 @@ static void wbsd_tasklet_card(unsigned long param)
>   		host->flags&= ~WBSD_FCARD_PRESENT;
>
>   		if (host->mrq) {
> -			printk(KERN_ERR "%s: Card removed during transfer!\n",
> +			pr_err("%s: Card removed during transfer!\n",
>   				mmc_hostname(host->mmc));
>   			wbsd_reset(host);
>
> @@ -1429,7 +1429,7 @@ free:
>   	free_dma(dma);
>
>   err:
> -	printk(KERN_WARNING DRIVER_NAME ": Unable to allocate DMA %d. "
> +	pr_warning(DRIVER_NAME ": Unable to allocate DMA %d. "
>   		"Falling back on FIFO.\n", dma);
>   }
>
> @@ -1664,7 +1664,7 @@ static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
>   	ret = wbsd_scan(host);
>   	if (ret) {
>   		if (pnp&&  (ret == -ENODEV)) {
> -			printk(KERN_WARNING DRIVER_NAME
> +			pr_warning(DRIVER_NAME
>   				": Unable to confirm device presence. You may "
>   				"experience lock-ups.\n");
>   		} else {
> @@ -1688,7 +1688,7 @@ static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
>   	 */
>   	if (pnp) {
>   		if ((host->config != 0)&&  !wbsd_chip_validate(host)) {
> -			printk(KERN_WARNING DRIVER_NAME
> +			pr_warning(DRIVER_NAME
>   				": PnP active but chip not configured! "
>   				"You probably have a buggy BIOS. "
>   				"Configuring chip manually.\n");
> @@ -1720,7 +1720,7 @@ static int __devinit wbsd_init(struct device *dev, int base, int irq, int dma,
>
>   	mmc_add_host(mmc);
>
> -	printk(KERN_INFO "%s: W83L51xD", mmc_hostname(mmc));
> +	pr_info("%s: W83L51xD", mmc_hostname(mmc));
>   	if (host->chip_id != 0)
>   		printk(" id %x", (int)host->chip_id);
>   	printk(" at 0x%x irq %d", (int)host->base, (int)host->irq);
> @@ -1909,7 +1909,7 @@ static int wbsd_pnp_resume(struct pnp_dev *pnp_dev)
>   	 */
>   	if (host->config != 0) {
>   		if (!wbsd_chip_validate(host)) {
> -			printk(KERN_WARNING DRIVER_NAME
> +			pr_warning(DRIVER_NAME
>   				": PnP active but chip not configured! "
>   				"You probably have a buggy BIOS. "
>   				"Configuring chip manually.\n");
> @@ -1973,9 +1973,9 @@ static int __init wbsd_drv_init(void)
>   {
>   	int result;
>
> -	printk(KERN_INFO DRIVER_NAME
> +	pr_info(DRIVER_NAME
>   		": Winbond W83L51xD SD/MMC card interface driver\n");
> -	printk(KERN_INFO DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
> +	pr_info(DRIVER_NAME ": Copyright(c) Pierre Ossman\n");
>
>   #ifdef CONFIG_PNP
>


-- 
J (James/Jay) Freyensee
Storage Technology Group
Intel Corporation
