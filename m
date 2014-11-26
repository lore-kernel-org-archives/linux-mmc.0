From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: core: add core-level function for sending tuning commands
Date: Wed, 26 Nov 2014 14:39:56 +0100
Message-ID: <CAPDyKFp48LvM5E_vQ+T36T=aCQ+8P9ZicfG8fGtnke+tXj=qXQ@mail.gmail.com>
References: <1416978333-3086-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170]:48272 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbaKZNj5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Nov 2014 08:39:57 -0500
Received: by mail-qc0-f170.google.com with SMTP id x3so2066286qcv.1
        for <linux-mmc@vger.kernel.org>; Wed, 26 Nov 2014 05:39:56 -0800 (PST)
In-Reply-To: <1416978333-3086-1-git-send-email-21cnbao@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

On 26 November 2014 at 06:05, Barry Song <21cnbao@gmail.com> wrote:
> From: Minda Chen <Minda.Chen@csr.com>
>
> According to the SD card spec, Add a manual tuning command function
> for SDR104/HS200.
> Sending command 19 or command 21 to read data and compare with the
> tunning block pattern.
>
> This patch will help to decrease some platform private codes in SDHCI
> platform_execute_tuning() callbacks.
>
> Signed-off-by: Minda Chen <Minda.Chen@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>

Thanks! Applied for next.

Actually it didn't apply as is, but I managed to resolve the trivial
conflict. In future, please use my mmc tree and the next branch to
base your patches upon.

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc_ops.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/core.h   |  1 +
>  2 files changed, 71 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 7911e05..a897894 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -543,6 +543,76 @@ int mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  }
>  EXPORT_SYMBOL_GPL(mmc_switch);
>
> +int mmc_send_tuning(struct mmc_card *card)
> +{
> +       struct mmc_request mrq = {NULL};
> +       struct mmc_command cmd = {0};
> +       struct mmc_data data = {0};
> +       struct scatterlist sg;
> +       struct mmc_host *mmc = card->host;
> +       struct mmc_ios *ios = &mmc->ios;
> +       const u8 *tuning_block_pattern;
> +       int size, err = 0;
> +       u8 *data_buf;
> +       u32 opcode;
> +
> +       if (ios->bus_width == MMC_BUS_WIDTH_8) {
> +               tuning_block_pattern = tuning_blk_pattern_8bit;
> +               size = sizeof(tuning_blk_pattern_8bit);
> +               opcode = MMC_SEND_TUNING_BLOCK_HS200;
> +       } else if (ios->bus_width == MMC_BUS_WIDTH_4) {
> +               tuning_block_pattern = tuning_blk_pattern_4bit;
> +               size = sizeof(tuning_blk_pattern_4bit);
> +               opcode = MMC_SEND_TUNING_BLOCK;
> +       } else
> +               return -EINVAL;
> +
> +       data_buf = kzalloc(size, GFP_KERNEL);
> +       if (!data_buf)
> +               return -ENOMEM;
> +
> +       mrq.cmd = &cmd;
> +       mrq.data = &data;
> +
> +       cmd.opcode = opcode;
> +       cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> +
> +       data.blksz = size;
> +       data.blocks = 1;
> +       data.flags = MMC_DATA_READ;
> +
> +       /*
> +        * According to the tuning specs, Tuning process
> +        * is normally shorter 40 executions of CMD19,
> +        * and timeout value should be shorter than 150 ms
> +        */
> +       data.timeout_ns = 150 * NSEC_PER_MSEC;
> +
> +       data.sg = &sg;
> +       data.sg_len = 1;
> +       sg_init_one(&sg, data_buf, size);
> +
> +       mmc_wait_for_req(mmc, &mrq);
> +
> +       if (cmd.error) {
> +               err = cmd.error;
> +               goto out;
> +       }
> +
> +       if (data.error) {
> +               err = data.error;
> +               goto out;
> +       }
> +
> +       if (memcmp(data_buf, tuning_block_pattern, size))
> +               err = -EIO;
> +
> +out:
> +       kfree(data_buf);
> +       return err;
> +}
> +EXPORT_SYMBOL_GPL(mmc_send_tuning);
> +
>  static int
>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>                   u8 len)
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index f206e29..b5c2763 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -154,6 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card, bool from_exception);
>  extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
>                         bool, bool);
>  extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
> +extern int mmc_send_tuning(struct mmc_card *);
>  extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);
>
>  #define MMC_ERASE_ARG          0x00000000
> --
> 2.1.3
>
