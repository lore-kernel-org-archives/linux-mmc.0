From: Philip Rakity <prakity@marvell.com>
Subject: [RFC]: mmc bus width testing
Date: Tue, 23 Nov 2010 07:56:26 -0800
Message-ID: <798674B4-E7B8-4437-A689-18536D1B6180@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47787 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753098Ab0KWP5g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 10:57:36 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>


A long time (2.6.2x days) I tried to submit a patch to do bus width testing on mmc and would appreciate some feedback before I do a formal submission.

Bus width testing is defined in JEDEC Standard No. 84-A441: section A.8.3 Changing the data bus width

The problem is that it does NOT work in all cases.  Some controllers do not handle the CMD19/CMD14 exchange.
(BUSTEST_W/BUSTEST_R)

When this failure happens it is not at all clear what to do....   

We could default to 1 bit mode and just do what we do today and take 4 bit bus width -- assuming CAPS are appropriately enabled.

I was thinking of adding a new MMC_CAP saying controller supports bus width testing.      Any thoughts ?

<snippet of code from today implementation == based on 2.6.32 but with DDR support back ported>

look for mmc_test_bus_width()

My thought was to replace

			if (err) {
				printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
					   "failed\n", mmc_hostname(card->host),
					   1 << bus_width, ddr);
				err = 0;
			} else {
				mmc_set_bus_width_ddr(card->host, bus_width, MMC_SDR_MODE);
				if (mmc_test_bus_width (card, 1<<bus_width))
					break;
			}

with

			if (err) {
				printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
					   "failed\n", mmc_hostname(card->host),
					   1 << bus_width, ddr);
				err = 0;
			} else {
				mmc_set_bus_width_ddr(card->host, bus_width, MMC_SDR_MODE);
				if ((mmc->caps & MMC_CAPS_CONTROLLER_SUPPORTS_BUSTEST) == 0)
					break;
				if (mmc_test_bus_width (card, 1<<bus_width))
					break;
			}

and let the platform code set MMC_CAPS_CONTROLLER_SUPPORTS_BUSTEST



from mmc.c
==========

static int mmc_init_card(struct mmc_host *host, u32 ocr,
	struct mmc_card *oldcard)
{
	struct mmc_card *card;
	int err, ddr = 0;
	u32 cid[4];
	unsigned int max_dtr;
	u32 rocr;

	BUG_ON(!host);
	WARN_ON(!host->claimed);

	/*
	 * Since we're changing the OCR value, we seem to
	 * need to tell some cards to go back to the idle
	 * state.  We wait 1ms to give cards time to
	 * respond.
	 */
	mmc_go_idle(host);

	/* The extra bit indicates that we support high capacity */
	err = mmc_send_op_cond(host, ocr | MMC_CARD_SECTOR_ADDR, &rocr);
	if (err)
		goto err;

	/*
	 * For SPI, enable CRC as appropriate.
	 */
	if (mmc_host_is_spi(host)) {
		err = mmc_spi_set_crc(host, use_spi_crc);
		if (err)
			goto err;
	}

	/*
	 * Fetch CID from card.
	 */
	if (mmc_host_is_spi(host))
		err = mmc_send_cid(host, cid);
	else
		err = mmc_all_send_cid(host, cid);
	if (err)
		goto err;

	if (oldcard) {
		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
			err = -ENOENT;
			goto err;
		}

		card = oldcard;
	} else {
		/*
		 * Allocate card structure.
		 */
		card = mmc_alloc_card(host, &mmc_type);
		if (IS_ERR(card)) {
			err = PTR_ERR(card);
			goto err;
		}

		card->type = MMC_TYPE_MMC;
		card->rca = 1;
		memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
	}

	/*
	 * For native busses:  set card RCA and quit open drain mode.
	 */
	if (!mmc_host_is_spi(host)) {
		err = mmc_set_relative_addr(card);
		if (err)
			goto free_card;

		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
	}

	if (!oldcard) {
		/*
		 * Fetch CSD from card.
		 */
		err = mmc_send_csd(card, card->raw_csd);
		if (err)
			goto free_card;

		err = mmc_decode_csd(card);
		if (err)
			goto free_card;
		err = mmc_decode_cid(card);
		if (err)
			goto free_card;
	}

	/*
	 * Select card, as all following commands rely on that.
	 */
	if (!mmc_host_is_spi(host)) {
		err = mmc_select_card(card);
		if (err)
			goto free_card;
	}

#if 0
	if (mmc_card_mmc(card)) {
		/* work around of Micorn 16G emmc */
		/* set bus_width to 1 bit as init state */
		mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
				EXT_CSD_BUS_WIDTH, EXT_CSD_BUS_WIDTH_1);

	}
#endif

	if (!oldcard) {
		/*
		 * Fetch and process extended CSD.
		 */
		err = mmc_read_ext_csd(card);
		if (err)
			goto free_card;

		if (rocr & MMC_CARD_SECTOR_ADDR)
			mmc_card_set_blockaddr(card);
	}


	/* switch to user partition, emmc may stay in boot partition after boot */
	mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
			EXT_CSD_PART_CONF, 0);

	/*
	 * Activate high speed (if supported)
	 */
	if ((card->ext_csd.hs_max_dtr != 0) &&
		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
			EXT_CSD_HS_TIMING, 1);
		if (err && err != -EBADMSG)
			goto free_card;

		if (err) {
			printk(KERN_WARNING "%s: switch to highspeed failed\n",
			       mmc_hostname(card->host));
			err = 0;
		} else {
			mmc_card_set_highspeed(card);
			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
		}
	}

	/*
	 * Compute bus speed.
	 */
	max_dtr = (unsigned int)-1;

	if (mmc_card_highspeed(card)) {
		if (max_dtr > card->ext_csd.hs_max_dtr)
			max_dtr = card->ext_csd.hs_max_dtr;
	} else if (max_dtr > card->csd.max_dtr) {
		max_dtr = card->csd.max_dtr;
	}

	mmc_set_clock(host, max_dtr);

	/*
	 * Indicate DDR mode (if supported).
	 */
	if (mmc_card_highspeed(card)) {
		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
			&& (host->caps & (MMC_CAP_1_8V_DDR)))
				ddr = MMC_1_8V_DDR_MODE;
		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
			&& (host->caps & (MMC_CAP_1_2V_DDR)))
				ddr = MMC_1_2V_DDR_MODE;
	}

	/*
	 * Activate wide bus and DDR (if supported).
	 */
	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
	    (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
		unsigned ext_csd_bit, bus_width;
		int temp_caps = host->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA);

		do {
			if (temp_caps & MMC_CAP_8_BIT_DATA) {
				ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
				bus_width = MMC_BUS_WIDTH_8;
			} else {
				ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
				bus_width = MMC_BUS_WIDTH_4;
			}

			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
					 EXT_CSD_BUS_WIDTH, ext_csd_bit);
			if (err) {
				printk(KERN_WARNING "%s: switch to bus width %d ddr %d "
					   "failed\n", mmc_hostname(card->host),
					   1 << bus_width, ddr);
				err = 0;
			} else {
				mmc_set_bus_width_ddr(card->host, bus_width, MMC_SDR_MODE);
				if (mmc_test_bus_width (card, 1<<bus_width))
					break;
			}
			
			if (bus_width == MMC_BUS_WIDTH_8)
				temp_caps &= ~MMC_CAP_8_BIT_DATA;
			else
				temp_caps &= ~MMC_CAP_4_BIT_DATA;

			if (temp_caps == 0) {
				ext_csd_bit = EXT_CSD_BUS_WIDTH_1;
				bus_width = MMC_BUS_WIDTH_1;
			}
		} while (temp_caps);

		if (temp_caps == 0) {
			ext_csd_bit = EXT_CSD_BUS_WIDTH_1;
			bus_width = MMC_BUS_WIDTH_1;
		}
		else if (temp_caps & MMC_CAP_8_BIT_DATA) {
			if (ddr)
				ext_csd_bit = EXT_CSD_DDR_BUS_WIDTH_8;
			else
				ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
			bus_width = MMC_BUS_WIDTH_8;
		} else {
			if (ddr)
				ext_csd_bit = EXT_CSD_DDR_BUS_WIDTH_4;
			else
				ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
			bus_width = MMC_BUS_WIDTH_4;
		}

		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
				 EXT_CSD_BUS_WIDTH, ext_csd_bit);

		if (ddr) {
			mmc_card_set_ddr_mode(card);
			mmc_set_bus_width_ddr(card->host, bus_width, ddr);
		} else
			mmc_set_bus_width_ddr(card->host, bus_width, MMC_SDR_MODE);

		if (err && err != -EBADMSG)
			goto free_card;
	}

	if (!oldcard)
		host->card = card;

	return 0;

free_card:
	if (!oldcard)
		mmc_remove_card(card);
err:

	return err;
}


from mmc_ops.c
=============
int mmc_test_bus_width(struct mmc_card *card, int bits)
{
	struct mmc_request mrq;
	struct mmc_command cmd;
	struct mmc_data data;
	struct scatterlist sg;
	int len;
	u8 test_data_write[8];
	u8 test_data_read[64];

	switch (bits) {
	case 8:
		test_data_write[0] = 0x55;
		test_data_write[1] = 0xaa;
		test_data_write[2] = 0x00;
		test_data_write[3] = 0x00;
		test_data_write[4] = 0x00;
		test_data_write[5] = 0x00;
		test_data_write[6] = 0x00;
		test_data_write[7] = 0x00;
		len = 8;
		break;
	case 4:
		test_data_write[0] = 0x5a;
		test_data_write[1] = 0x00;
		test_data_write[2] = 0x00;
		test_data_write[3] = 0x00;
		len = 4;
		break;
	default:
		return 0;
	}

	memset(&mrq, 0, sizeof(struct mmc_request));
	memset(&cmd, 0, sizeof(struct mmc_command));
	memset(&data, 0, sizeof(struct mmc_data));

	cmd.opcode = MMC_BUSTEST_W;
	cmd.arg = 0;
	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;

	data.flags = MMC_DATA_WRITE;
	data.blksz = 64;
	data.blocks = 1;
	data.sg = &sg;
	data.sg_len = 1;

	mrq.cmd = &cmd;
	mrq.data = &data;

	sg_init_one(&sg, &test_data_write, 64);

	/*
	 * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses have a timeout
	 * of 64 clock cycles.
	 */
	data.timeout_ns = 0;
	data.timeout_clks = 64;

	mmc_wait_for_req(card->host, &mrq);

	if (cmd.error || data.error ) {
		printk(KERN_INFO "Failed to send CMD19: %d %d\n", cmd.error, data.error);
		return 0;
	}

	/* Now read back */
	memset(&mrq, 0, sizeof(struct mmc_request));
	memset(&cmd, 0, sizeof(struct mmc_command));
	memset(&data, 0, sizeof(struct mmc_data));
	memset (&test_data_read, 0, sizeof(test_data_read));

	cmd.opcode = MMC_BUSTEST_R;
	cmd.arg = 0;
	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;

	data.flags = MMC_DATA_READ;
	data.blksz = sizeof(test_data_read);
	data.blocks = 1;
	data.sg = &sg;
	data.sg_len = 1;

	mrq.cmd = &cmd;
	mrq.data = &data;

	sg_init_one(&sg, &test_data_read, sizeof(test_data_read));

	/*
	 * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses have a timeout
	 * of 64 clock cycles.
	 */
	data.timeout_ns = 0;
	data.timeout_clks = 64;

	mmc_wait_for_req(card->host, &mrq);

	if (cmd.error) {
		printk(KERN_INFO "Failed to send CMD14: %d %d\n", cmd.error, data.error);
		return 0;
	}

#if 0
#warning PRINT RESULTS FROM CMD14
	printk (KERN_INFO "%s: Got %02X %02X %02X %02X\n", __FUNCTION__,
		test_data_read[0],
		test_data_read[1],
		test_data_read[2],
		test_data_read[3]);
#endif

	switch (bits) {
	case 8:
		return (test_data_read[0] == 0xaa && test_data_read[1] == 0x55);
	case 4:
		return (test_data_read[0] == 0xa5);
	}
	return 0;
}

