From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH]  mmc: Resubmit: Bus Width testing for eMMC and MMC
	Cards
Date: Sat, 27 Nov 2010 19:32:30 +0000
Message-ID: <20101127193229.GA3019@void.printf.net>
References: <A8541278-E69B-43AC-A820-B8D11F718FC1@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41914 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752375Ab0K0Tcc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Nov 2010 14:32:32 -0500
Content-Disposition: inline
In-Reply-To: <A8541278-E69B-43AC-A820-B8D11F718FC1@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>

Hi Philip,

Some early stylistic review comments:

On Sat, Nov 27, 2010 at 11:00:19AM -0800, Philip Rakity wrote:
> Patch made against linux-next (see below) and tested against marvell mmp2
> controller using Marvell linux

The patch doesn't apply against current linux-next or Linus HEAD, due to
Ohad's recent runtime PM change to host.h.

> We define a new MMC_CAP: MMC_CAP_BUS_WIDTH_WORKS that the host adaptation
> layer can set if the controller can support bus width testing.

"BUS_WIDTH_WORKS" is a bit vague.  Maybe MMC_CAP_BUS_WIDTH_TEST?

>  	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
>  	    (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>  		unsigned ext_csd_bit, bus_width;
> +		int temp_caps = host->caps & (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA);
>  
> -		if (host->caps & MMC_CAP_8_BIT_DATA) {
> +		do {
> +			if (temp_caps & MMC_CAP_8_BIT_DATA) {
> +				ext_csd_bit = EXT_CSD_BUS_WIDTH_8;
> +				bus_width = MMC_BUS_WIDTH_8;
> +			} else {
> +				ext_csd_bit = EXT_CSD_BUS_WIDTH_4;
> +				bus_width = MMC_BUS_WIDTH_4;
> +			}
> +
> +			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +					 EXT_CSD_BUS_WIDTH, ext_csd_bit);
> +			if (err) {
> +				printk(KERN_WARNING "%s: switch to bus width %d ddr %d "

Please stick to 80 cols where possible.

> +					   "failed\n", mmc_hostname(card->host),
> +					   1 << bus_width, ddr);
> +				err = 0;
> +			} else {
> +				mmc_set_bus_width_ddr(card->host, bus_width, MMC_SDR_MODE);
> +				/*
> +				 * if controller can't handle bus width test
> +				 * try to use the highest bus width to
> +				 * maintain compatibility with previous linux
> +				 */
> +				if ((host->caps & MMC_CAP_BUS_WIDTH_WORKS) == 0)
> +					break;
> +				if (mmc_test_bus_width (card, 1<<bus_width))

Extra space here.

> +					break;
> +			}
> +
> +			if (bus_width == MMC_BUS_WIDTH_8)
> +				temp_caps &= ~MMC_CAP_8_BIT_DATA;
> +			else
> +				temp_caps &= ~MMC_CAP_4_BIT_DATA;
> +
> +			if (temp_caps == 0) {
> +				ext_csd_bit = EXT_CSD_BUS_WIDTH_1;
> +				bus_width = MMC_BUS_WIDTH_1;
> +			}
> +		} while (temp_caps);
> +
> +		if (temp_caps == 0) {
> +			ext_csd_bit = EXT_CSD_BUS_WIDTH_1;
> +			bus_width = MMC_BUS_WIDTH_1;
> +		} else if (temp_caps & MMC_CAP_8_BIT_DATA) {
>  			if (ddr)
>  				ext_csd_bit = EXT_CSD_DDR_BUS_WIDTH_8;
>  			else

Why is the "temp_caps == 0" test inside the while loop necessary, rather
than just relying on the same test outside of the loop?

> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 326447c..2b115a3 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -20,6 +20,138 @@
>  #include "core.h"
>  #include "mmc_ops.h"
>  
> +int mmc_test_bus_width(struct mmc_card *card, int bits)
> +{
> +	struct mmc_request mrq;
> +	struct mmc_command cmd;
> +	struct mmc_data data;
> +	struct scatterlist sg;
> +	int len;
> +	u8 test_data_write[8];
> +	u8 test_data_read[64];
> +
> +	switch (bits) {
> +	case 8:
> +		test_data_write[0] = 0x55;
> +		test_data_write[1] = 0xaa;
> +		test_data_write[2] = 0x00;
> +		test_data_write[3] = 0x00;
> +		test_data_write[4] = 0x00;
> +		test_data_write[5] = 0x00;
> +		test_data_write[6] = 0x00;
> +		test_data_write[7] = 0x00;
> +		len = 8;
> +		break;
> +	case 4:
> +		test_data_write[0] = 0x5a;
> +		test_data_write[1] = 0x00;
> +		test_data_write[2] = 0x00;
> +		test_data_write[3] = 0x00;
> +		len = 4;
> +		break;
> +	default:
> +		/* 1 bit bus cards ALWAYS work */
> +		return 1;
> +	}
> +
> +	memset(&mrq, 0, sizeof(struct mmc_request));
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +	memset(&data, 0, sizeof(struct mmc_data));
> +
> +	cmd.opcode = MMC_BUSTEST_W;
> +	cmd.arg = 0;
> +
> +	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
> +	 * rely on callers to never use this with "native" calls for reading
> +	 * CSD or CID.  Native versions of those commands use the R2 type,
> +	 * not R1 plus a data block.
> +	 */
> +	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +	data.flags = MMC_DATA_WRITE;
> +	data.blksz = len;
> +	data.blocks = 1;
> +	data.sg = &sg;
> +	data.sg_len = 1;
> +
> +	mrq.cmd = &cmd;
> +	mrq.data = &data;
> +
> +	sg_init_one(&sg, &test_data_write, len);
> +
> +	/*
> +	 * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses
> +	 * have a maximum timeout of 64 clock cycles.
> +	 */
> +	data.timeout_ns = 0;
> +	data.timeout_clks = 64;
> +
> +	mmc_wait_for_req(card->host, &mrq);
> +
> +	if (cmd.error || data.error ) {

Extra space here.

> +		printk(KERN_INFO "%s: Failed to send (BUSTEST_W) CMD19: %d %d\n",
> +			mmc_hostname(card->host), cmd.error, data.error);
> +	}
> +
> +	/* Now read back */
> +	memset(&mrq, 0, sizeof(struct mmc_request));
> +	memset(&cmd, 0, sizeof(struct mmc_command));
> +	memset(&data, 0, sizeof(struct mmc_data));
> +	memset (&test_data_read, 0, sizeof(test_data_read));
> +
> +	cmd.opcode = MMC_BUSTEST_R;
> +	cmd.arg = 0;
> +
> +	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
> +	 * rely on callers to never use this with "native" calls for reading
> +	 * CSD or CID.  Native versions of those commands use the R2 type,
> +	 * not R1 plus a data block.
> +	 */
> +	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +	data.flags = MMC_DATA_READ;
> +	data.blksz = len;
> +	data.blocks = 1;
> +	data.sg = &sg;
> +	data.sg_len = 1;
> +
> +	mrq.cmd = &cmd;
> +	mrq.data = &data;
> +
> +	sg_init_one(&sg, &test_data_read, len);
> +
> +	data.timeout_ns = 0;
> +	data.timeout_clks = 64;
> +
> +	mmc_wait_for_req(card->host, &mrq);
> +
> +	if (cmd.error) {
> +		printk(KERN_INFO "%s: Failed to send CMD14: %d %d\n",
> +			mmc_hostname(card->host), cmd.error, data.error);
> +		return 0;
> +	}
> +
> +#if 0
> +#warning PRINT RESULTS FROM CMD14
> +	printk (KERN_INFO "%s: Bits = %d, Got %02X %02X %02X %02X\n", __FUNCTION__,

Extra space, and please don't submit #if 0'd code.  You can use a debug
level printk if you want to condition it on CONFIG_MMC_DEBUG.  Also,
__func__ instead of __FUNCTION__.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
