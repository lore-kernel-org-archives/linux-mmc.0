From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Check for timeout before checking mmc device state
Date: Mon, 11 May 2015 12:00:49 +0200
Message-ID: <CAPDyKFp0kdu7d_mXKJMDhu=Njjb46YEZKsk+fuAUqwf8sMe3DA@mail.gmail.com>
References: <1431052847-16270-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36539 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753404AbbEKKAu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:00:50 -0400
Received: by qku63 with SMTP id 63so83012784qku.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:00:49 -0700 (PDT)
In-Reply-To: <1431052847-16270-1-git-send-email-matt.bennett@alliedtelesis.co.nz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Bennett <matt.bennett@alliedtelesis.co.nz>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Johan Rudholm <johan.rudholm@axis.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 8 May 2015 at 04:40, Matt Bennett <matt.bennett@alliedtelesis.co.nz> wrote:
> On a system that has multiple devices on the mmc bus the host can
> block on the mutex that protects access to the bus. Some operations

What mutex are you referring to?

And why, exactly, does it prevent parallel requests on different cards
(devices)?

Kind regards
Uffe

> require the status of the device to be polled to see when the device
> finishes executing the previous command that was sent to it (if
> there is no busy detection in hardware). The current execution order
> to check the status is:
>
> LOOP
> {
>   1. Send command to device to retrieve the status (this can block).
>   2. Check we haven't exceeded the timeout value. If we have then
>      return an error.
>   3. If the device is no longer in the program state then exit the
>      loop and continue through the function.
> }
>
> If the send command blocks (and the timeout is exceeded) then the
> function returns (and prints) an error even though the device has
> likely left the programming state (due to the lengthy period of
> time while the bus is blocked). By moving the timeout check before
> retrieving the device status in the loop we better handle the case
> where the mmc bus has been blocked but the device has left the
> programming state.
>
> Signed-off-by: Matt Bennett <matt.bennett@alliedtelesis.co.nz>
> Cc: kuninori.morimoto.gx@renesas.com
> Cc: jh80.chung@samsung.com
> Cc: sboyd@codeaurora.org
> Cc: johan.rudholm@axis.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> ---
>  drivers/mmc/card/block.c   | 22 +++++++++++-----------
>  drivers/mmc/core/core.c    | 20 ++++++++++----------
>  drivers/mmc/core/mmc_ops.c | 14 +++++++-------
>  3 files changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 2c25271..0abefde 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -747,6 +747,17 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>         u32 status;
>
>         do {
> +               /*
> +                * Timeout if the device never becomes ready for data and never
> +                * leaves the program state.
> +                */
> +               if (time_after(jiffies, timeout)) {
> +                       pr_err("%s: Card stuck in programming state! %s %s\n",
> +                               mmc_hostname(card->host),
> +                               req->rq_disk->disk_name, __func__);
> +                       return -ETIMEDOUT;
> +               }
> +
>                 err = get_card_status(card, &status, 5);
>                 if (err) {
>                         pr_err("%s: error %d requesting status\n",
> @@ -766,17 +777,6 @@ static int card_busy_detect(struct mmc_card *card, unsigned int timeout_ms,
>                         break;
>
>                 /*
> -                * Timeout if the device never becomes ready for data and never
> -                * leaves the program state.
> -                */
> -               if (time_after(jiffies, timeout)) {
> -                       pr_err("%s: Card stuck in programming state! %s %s\n",
> -                               mmc_hostname(card->host),
> -                               req->rq_disk->disk_name, __func__);
> -                       return -ETIMEDOUT;
> -               }
> -
> -               /*
>                  * Some cards mishandle the status bits,
>                  * so make sure to check both the busy
>                  * indication and the card state.
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index c296bc0..6e56cb3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2047,6 +2047,16 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>
>         timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>         do {
> +               /* Timeout if the device never becomes ready for data and
> +                * never leaves the program state.
> +                */
> +               if (time_after(jiffies, timeout)) {
> +                       pr_err("%s: Card stuck in programming state! %s\n",
> +                               mmc_hostname(card->host), __func__);
> +                       err =  -EIO;
> +                       goto out;
> +               }
> +
>                 memset(&cmd, 0, sizeof(struct mmc_command));
>                 cmd.opcode = MMC_SEND_STATUS;
>                 cmd.arg = card->rca << 16;
> @@ -2060,16 +2070,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>                         goto out;
>                 }
>
> -               /* Timeout if the device never becomes ready for data and
> -                * never leaves the program state.
> -                */
> -               if (time_after(jiffies, timeout)) {
> -                       pr_err("%s: Card stuck in programming state! %s\n",
> -                               mmc_hostname(card->host), __func__);
> -                       err =  -EIO;
> -                       goto out;
> -               }
> -
>         } while (!(cmd.resp[0] & R1_READY_FOR_DATA) ||
>                  (R1_CURRENT_STATE(cmd.resp[0]) == R1_STATE_PRG));
>  out:
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 0ea042d..b30ed91 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -526,6 +526,13 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>         /* Must check status to be sure of no errors. */
>         timeout = jiffies + msecs_to_jiffies(timeout_ms);
>         do {
> +               /* Timeout if the device never leaves the program state. */
> +               if (time_after(jiffies, timeout)) {
> +                       pr_err("%s: Card stuck in programming state! %s\n",
> +                               mmc_hostname(host), __func__);
> +                       return -ETIMEDOUT;
> +               }
> +
>                 if (send_status) {
>                         err = __mmc_send_status(card, &status, ignore_crc);
>                         if (err)
> @@ -545,13 +552,6 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
>                         mmc_delay(timeout_ms);
>                         return 0;
>                 }
> -
> -               /* Timeout if the device never leaves the program state. */
> -               if (time_after(jiffies, timeout)) {
> -                       pr_err("%s: Card stuck in programming state! %s\n",
> -                               mmc_hostname(host), __func__);
> -                       return -ETIMEDOUT;
> -               }
>         } while (R1_CURRENT_STATE(status) == R1_STATE_PRG);
>
>         if (mmc_host_is_spi(host)) {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
