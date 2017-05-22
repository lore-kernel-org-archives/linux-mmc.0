From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Use mmc_send_status() and drop get_card_status()
Date: Mon, 22 May 2017 10:00:47 +0200
Message-ID: <CAPDyKFqK=POybzSRGpWq5wBVbecDOyFX_HLjv9a088HstQKQoA@mail.gmail.com>
References: <1495438722-22091-1-git-send-email-ulf.hansson@linaro.org> <888cba7c-df6f-7c24-ee26-d644f261781d@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f181.google.com ([209.85.216.181]:34838 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752191AbdEVIAt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 May 2017 04:00:49 -0400
Received: by mail-qt0-f181.google.com with SMTP id v27so95522783qtg.2
        for <linux-mmc@vger.kernel.org>; Mon, 22 May 2017 01:00:48 -0700 (PDT)
In-Reply-To: <888cba7c-df6f-7c24-ee26-d644f261781d@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Linus Walleij <linus.walleij@linaro.org>

On 22 May 2017 at 09:43, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 22/05/17 10:38, Ulf Hansson wrote:
>> There are no reason to why the mmc block device driver needs to implements
>> its own version of how to get the status of the card. Current it do so via
>> the static function get_card_status(). Let's instead drop that function and
>> convert to use mmc_send_status() as that is what everybody else is using.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/core/block.c   | 22 +++-------------------
>>  drivers/mmc/core/mmc_ops.c |  1 +
>>  2 files changed, 4 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index e973798..23a3254 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -127,7 +127,6 @@ MODULE_PARM_DESC(perdev_minors, "Minors numbers to allocate per device");
>>
>>  static inline int mmc_blk_part_switch(struct mmc_card *card,
>>                                     struct mmc_blk_data *md);
>> -static int get_card_status(struct mmc_card *card, u32 *status, int retries);
>>
>>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>>  {
>> @@ -385,7 +384,7 @@ static int ioctl_rpmb_card_status_poll(struct mmc_card *card, u32 *status,
>>               return -EINVAL;
>>
>>       do {
>> -             err = get_card_status(card, status, 5);
>> +             err = mmc_send_status(card, status);
>>               if (err)
>>                       break;
>>
>> @@ -885,21 +884,6 @@ static int mmc_sd_num_wr_blocks(struct mmc_card *card, u32 *written_blocks)
>>       return 0;
>>  }
>>
>> -static int get_card_status(struct mmc_card *card, u32 *status, int retries)
>> -{
>> -     struct mmc_command cmd = {};
>> -     int err;
>> -
>> -     cmd.opcode = MMC_SEND_STATUS;
>> -     if (!mmc_host_is_spi(card->host))
>> -             cmd.arg = card->rca << 16;
>> -     cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
>> -     err = mmc_wait_for_cmd(card->host, &cmd, retries);
>> -     if (err == 0)
>> -             *status = cmd.resp[0];
>> -     return err;
>> -}
>> -
>>  static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>>               bool hw_busy_detect, struct request *req, bool *gen_err)
>>  {
>> @@ -908,7 +892,7 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>>       u32 status;
>>
>>       do {
>> -             err = get_card_status(card, &status, 5);
>> +             err = mmc_send_status(card, &status);
>>               if (err) {
>>                       pr_err("%s: error %d requesting status\n",
>>                              req->rq_disk->disk_name, err);
>> @@ -1076,7 +1060,7 @@ static int mmc_blk_cmd_recovery(struct mmc_card *card, struct request *req,
>>        * we can't be sure the returned status is for the r/w command.
>>        */
>>       for (retry = 2; retry >= 0; retry--) {
>> -             err = get_card_status(card, &status, 0);
>> +             err = mmc_send_status(card, &status);
>
> That is not quite the same because mmc_send_status() does MMC_CMD_RETRIES
> retries.  That changes the value and meaning of prev_cmd_status_valid. i.e.
> the logic is considering whether the error bits in the status might have
> been cleared by the retry.

Right, I didn't really think that was of importance. Perhaps I was
comparing to earlier experiences we have had for mmc_switch(), as
there have always been re-tries in some paths but which never made any
sense.

Anyway, let me re-spin and export a function which allows the caller
to specify retries then.

>
>>               if (!err)
>>                       break;
>>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 78f75f0..ac4b694 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -76,6 +76,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
>>
>>       return 0;
>>  }
>> +EXPORT_SYMBOL_GPL(mmc_send_status);
>>
>>  static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
>>  {
>>
>

Thanks for reviewing.

Kind regards
Uffe
