From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: use empty initializer list to zero-clear structures
Date: Tue, 10 Jan 2017 16:38:23 +0100
Message-ID: <CAPDyKFp+jC_sVm62VP8=F6sVQbdocmWHi97Q=_9MtNNWkWE25Q@mail.gmail.com>
References: <1482148278-11395-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38609 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755040AbdAJPi0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 10:38:26 -0500
Received: by mail-wm0-f47.google.com with SMTP id k184so166043770wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jan 2017 07:38:26 -0800 (PST)
In-Reply-To: <1482148278-11395-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Bojan Prtvar <prtvar.b@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <rmk+kernel@arm.linux.org.uk>, Pratibhasagar V <pratibha@codeaurora.org>, Gwendal Grignou <gwendal@chromium.org>, Linus Walleij <linus.walleij@linaro.org>, Jens Axboe <axboe@fb.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <aisheng.dong@nxp.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Shawn Lin <shawn.lin@rock-chips.com>, Dan Carpenter <dan.carpenter@oracle.com>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>

On 19 December 2016 at 12:51, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> In the MMC subsystem, we see such initializers that only clears the
> first member explicitly.
>
> For example,
>
>   struct mmc_request mrq = {NULL};
>
> sets the first member (.sbc) to NULL explicitly.  However, this is
> an unstable form because we may insert a non-pointer member at the
> top of the struct mmc_request in the future. (if we do so, the
> compiler will spit warnings.)
>
> So, using a designated initializer is preferred coding style.  The
> expression above is equivalent to:
>
>   struct mmc_request mrq = { .sbc = NULL };
>
> Of course, this does not express our intention.  We want to fill
> all struct members with zeros.  Please note struct members are
> implicitly zero-cleared unless otherwise specified in the initializer.
>
> After all, the most reasonable (and stable) form is:
>
>   struct mmc_request mrq = {};
>
> Do likewise for mmc_command, mmc_data as well.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/core/block.c          | 16 +++++++-------
>  drivers/mmc/core/core.c           | 10 ++++-----
>  drivers/mmc/core/mmc.c            |  2 +-
>  drivers/mmc/core/mmc_ops.c        | 44 +++++++++++++++++++--------------------
>  drivers/mmc/core/mmc_test.c       | 26 +++++++++++------------
>  drivers/mmc/core/sd_ops.c         | 30 +++++++++++++-------------
>  drivers/mmc/core/sdio_ops.c       | 10 ++++-----
>  drivers/mmc/host/rtsx_pci_sdmmc.c |  2 +-
>  drivers/mmc/host/rtsx_usb_sdmmc.c |  2 +-
>  drivers/mmc/host/sdhci.c          |  4 ++--
>  10 files changed, 73 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index bab3f07..82764786d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -442,9 +442,9 @@ static int ioctl_do_sanitize(struct mmc_card *card)
>  static int __mmc_blk_ioctl_cmd(struct mmc_card *card, struct mmc_blk_data *md,
>                                struct mmc_blk_ioc_data *idata)
>  {
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> -       struct mmc_request mrq = {NULL};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
> +       struct mmc_request mrq = {};
>         struct scatterlist sg;
>         int err;
>         int is_rpmb = false;
> @@ -768,9 +768,9 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
>         u32 result;
>         __be32 *blocks;
>
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>
>         struct scatterlist sg;
>
> @@ -819,7 +819,7 @@ static u32 mmc_sd_num_wr_blocks(struct mmc_card *card)
>
>  static int get_card_status(struct mmc_card *card, u32 *status, int retries)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>
>         cmd.opcode = MMC_SEND_STATUS;
> @@ -884,7 +884,7 @@ static int send_stop(struct mmc_card *card, unsigned int timeout_ms,
>                 struct request *req, bool *gen_err, u32 *stop_status)
>  {
>         struct mmc_host *host = card->host;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>         bool use_r1b_resp = rq_data_dir(req) == WRITE;
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 543eadd..047f672 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -809,7 +809,7 @@ EXPORT_SYMBOL(mmc_interrupt_hpi);
>   */
>  int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd, int retries)
>  {
> -       struct mmc_request mrq = {NULL};
> +       struct mmc_request mrq = {};
>
>         WARN_ON(!host->claimed);
>
> @@ -1650,7 +1650,7 @@ int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
>
>  int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage, u32 ocr)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err = 0;
>         u32 clock;
>
> @@ -2131,7 +2131,7 @@ static unsigned int mmc_erase_timeout(struct mmc_card *card,
>  static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>                         unsigned int to, unsigned int arg)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         unsigned int qty = 0, busy_timeout = 0;
>         bool use_r1b_resp = false;
>         unsigned long timeout;
> @@ -2553,7 +2553,7 @@ EXPORT_SYMBOL(mmc_calc_max_discard);
>
>  int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         if (mmc_card_blockaddr(card) || mmc_card_ddr52(card) ||
>             mmc_card_hs400(card) || mmc_card_hs400es(card))
> @@ -2569,7 +2569,7 @@ EXPORT_SYMBOL(mmc_set_blocklen);
>  int mmc_set_blockcount(struct mmc_card *card, unsigned int blockcount,
>                         bool is_rel_write)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_SET_BLOCK_COUNT;
>         cmd.arg = blockcount & 0x0000FFFF;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b61b52f9..f4d1b52 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1805,7 +1805,7 @@ static int mmc_can_sleep(struct mmc_card *card)
>
>  static int mmc_sleep(struct mmc_host *host)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         struct mmc_card *card = host->card;
>         unsigned int timeout_ms = DIV_ROUND_UP(card->ext_csd.sa_timeout, 10000);
>         int err;
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index b11c345..db2969f 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -57,7 +57,7 @@ static const u8 tuning_blk_pattern_8bit[] = {
>  int mmc_send_status(struct mmc_card *card, u32 *status)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_SEND_STATUS;
>         if (!mmc_host_is_spi(card->host))
> @@ -79,7 +79,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>
>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_SELECT_CARD;
>
> @@ -115,7 +115,7 @@ int mmc_deselect_cards(struct mmc_host *host)
>   */
>  int mmc_set_dsr(struct mmc_host *host)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_SET_DSR;
>
> @@ -128,7 +128,7 @@ int mmc_set_dsr(struct mmc_host *host)
>  int mmc_go_idle(struct mmc_host *host)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         /*
>          * Non-SPI hosts need to prevent chipselect going active during
> @@ -164,7 +164,7 @@ int mmc_go_idle(struct mmc_host *host)
>
>  int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int i, err = 0;
>
>         cmd.opcode = MMC_SEND_OP_COND;
> @@ -203,7 +203,7 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_ALL_SEND_CID;
>         cmd.arg = 0;
> @@ -220,7 +220,7 @@ int mmc_all_send_cid(struct mmc_host *host, u32 *cid)
>
>  int mmc_set_relative_addr(struct mmc_card *card)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = MMC_SET_RELATIVE_ADDR;
>         cmd.arg = card->rca << 16;
> @@ -233,7 +233,7 @@ static int
>  mmc_send_cxd_native(struct mmc_host *host, u32 arg, u32 *cxd, int opcode)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = opcode;
>         cmd.arg = arg;
> @@ -256,9 +256,9 @@ static int
>  mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
>                 u32 opcode, void *buf, unsigned len)
>  {
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>
>         mrq.cmd = &cmd;
> @@ -387,7 +387,7 @@ EXPORT_SYMBOL_GPL(mmc_get_ext_csd);
>
>  int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>
>         cmd.opcode = MMC_SPI_READ_OCR;
> @@ -402,7 +402,7 @@ int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp)
>
>  int mmc_spi_set_crc(struct mmc_host *host, int use_crc)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>
>         cmd.opcode = MMC_SPI_CRC_ON_OFF;
> @@ -533,7 +533,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>  {
>         struct mmc_host *host = card->host;
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         bool use_r1b_resp = use_busy_signal;
>         unsigned char old_timing = host->ios.timing;
>
> @@ -611,9 +611,9 @@ EXPORT_SYMBOL_GPL(mmc_switch);
>
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int *cmd_error)
>  {
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>         struct mmc_ios *ios = &host->ios;
>         const u8 *tuning_block_pattern;
> @@ -680,7 +680,7 @@ EXPORT_SYMBOL_GPL(mmc_send_tuning);
>
>  int mmc_abort_tuning(struct mmc_host *host, u32 opcode)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         /*
>          * eMMC specification specifies that CMD12 can be used to stop a tuning
> @@ -707,9 +707,9 @@ static int
>  mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
>                   u8 len)
>  {
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>         u8 *data_buf;
>         u8 *test_buf;
> @@ -803,7 +803,7 @@ int mmc_bus_test(struct mmc_card *card, u8 bus_width)
>
>  int mmc_send_hpi_cmd(struct mmc_card *card, u32 *status)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         unsigned int opcode;
>         int err;
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 3ab6e52..bd8eb9b 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -260,7 +260,7 @@ static int mmc_test_busy(struct mmc_command *cmd)
>  static int mmc_test_wait_busy(struct mmc_test_card *test)
>  {
>         int ret, busy;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         busy = 0;
>         do {
> @@ -292,10 +292,10 @@ static int mmc_test_wait_busy(struct mmc_test_card *test)
>  static int mmc_test_buffer_transfer(struct mmc_test_card *test,
>         u8 *buffer, unsigned addr, unsigned blksz, int write)
>  {
> -       struct mmc_request mrq = {0};
> -       struct mmc_command cmd = {0};
> -       struct mmc_command stop = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_command stop = {};
> +       struct mmc_data data = {};
>
>         struct scatterlist sg;
>
> @@ -885,10 +885,10 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
>         struct scatterlist *sg, unsigned sg_len, unsigned dev_addr,
>         unsigned blocks, unsigned blksz, int write)
>  {
> -       struct mmc_request mrq = {0};
> -       struct mmc_command cmd = {0};
> -       struct mmc_command stop = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_command stop = {};
> +       struct mmc_data data = {};
>
>         mrq.cmd = &cmd;
>         mrq.data = &data;
> @@ -910,10 +910,10 @@ static int mmc_test_simple_transfer(struct mmc_test_card *test,
>  static int mmc_test_broken_transfer(struct mmc_test_card *test,
>         unsigned blocks, unsigned blksz, int write)
>  {
> -       struct mmc_request mrq = {0};
> -       struct mmc_command cmd = {0};
> -       struct mmc_command stop = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_command stop = {};
> +       struct mmc_data data = {};
>
>         struct scatterlist sg;
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index de125a4..9d5824a 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -25,7 +25,7 @@
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         if (WARN_ON(card && card->host != host))
>                 return -EINVAL;
> @@ -68,7 +68,7 @@ EXPORT_SYMBOL_GPL(mmc_app_cmd);
>  int mmc_wait_for_app_cmd(struct mmc_host *host, struct mmc_card *card,
>         struct mmc_command *cmd, int retries)
>  {
> -       struct mmc_request mrq = {NULL};
> +       struct mmc_request mrq = {};
>
>         int i, err;
>
> @@ -120,7 +120,7 @@ EXPORT_SYMBOL(mmc_wait_for_app_cmd);
>
>  int mmc_app_set_bus_width(struct mmc_card *card, int width)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = SD_APP_SET_BUS_WIDTH;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> @@ -141,7 +141,7 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
>
>  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int i, err = 0;
>
>         cmd.opcode = SD_APP_OP_COND;
> @@ -185,7 +185,7 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>
>  int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>         static const u8 test_pattern = 0xAA;
>         u8 result_pattern;
> @@ -217,7 +217,7 @@ int mmc_send_if_cond(struct mmc_host *host, u32 ocr)
>  int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         cmd.opcode = SD_SEND_RELATIVE_ADDR;
>         cmd.arg = 0;
> @@ -235,9 +235,9 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca)
>  int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
>  {
>         int err;
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>         void *data_buf;
>
> @@ -290,9 +290,9 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr)
>  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>         u8 value, u8 *resp)
>  {
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>
>         /* NOTE: caller guarantees resp is heap-allocated */
> @@ -332,9 +332,9 @@ int mmc_sd_switch(struct mmc_card *card, int mode, int group,
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr)
>  {
>         int err;
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg;
>
>         /* NOTE: caller guarantees ssr is heap-allocated */
> diff --git a/drivers/mmc/core/sdio_ops.c b/drivers/mmc/core/sdio_ops.c
> index 90fe554..3c0d3ab 100644
> --- a/drivers/mmc/core/sdio_ops.c
> +++ b/drivers/mmc/core/sdio_ops.c
> @@ -21,7 +21,7 @@
>
>  int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int i, err = 0;
>
>         cmd.opcode = SD_IO_SEND_OP_COND;
> @@ -66,7 +66,7 @@ int mmc_send_io_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>  static int mmc_io_rw_direct_host(struct mmc_host *host, int write, unsigned fn,
>         unsigned addr, u8 in, u8 *out)
>  {
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>         int err;
>
>         if (fn > 7)
> @@ -118,9 +118,9 @@ int mmc_io_rw_direct(struct mmc_card *card, int write, unsigned fn,
>  int mmc_io_rw_extended(struct mmc_card *card, int write, unsigned fn,
>         unsigned addr, int incr_addr, u8 *buf, unsigned blocks, unsigned blksz)
>  {
> -       struct mmc_request mrq = {NULL};
> -       struct mmc_command cmd = {0};
> -       struct mmc_data data = {0};
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       struct mmc_data data = {};
>         struct scatterlist sg, *sg_ptr;
>         struct sg_table sgtable;
>         unsigned int nents, left_size, i;
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index ecb99a8..41b5771 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -707,7 +707,7 @@ static int sd_tuning_rx_cmd(struct realtek_pci_sdmmc *host,
>                 u8 opcode, u8 sample_point)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         err = sd_change_phase(host, sample_point, true);
>         if (err < 0)
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index dc1abd1..12d2fbe 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -682,7 +682,7 @@ static int sd_tuning_rx_cmd(struct rtsx_usb_sdmmc *host,
>                 u8 opcode, u8 sample_point)
>  {
>         int err;
> -       struct mmc_command cmd = {0};
> +       struct mmc_command cmd = {};
>
>         err = sd_change_phase(host, sample_point, 0);
>         if (err)
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 111991e..891f7c6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2018,8 +2018,8 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode,
>                               unsigned long flags)
>  {
>         struct mmc_host *mmc = host->mmc;
> -       struct mmc_command cmd = {0};
> -       struct mmc_request mrq = {NULL};
> +       struct mmc_command cmd = {};
> +       struct mmc_request mrq = {};
>
>         cmd.opcode = opcode;
>         cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
> --
> 2.7.4
>
