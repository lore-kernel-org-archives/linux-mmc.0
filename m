From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/4] mmc: sdhci: Fix recovery from tuning timeout
Date: Wed, 30 Nov 2016 12:17:22 +0200
Message-ID: <aa7368ef-4711-4b03-c9cb-df09344f2cb5@intel.com>
References: <1480497614-3501-1-git-send-email-adrian.hunter@intel.com>
 <1480497614-3501-3-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFqz36hsJxVJpNcH-Y+gzTOfewPiV3w4LApQOdrQiKLNtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:10555 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756826AbcK3KWY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 30 Nov 2016 05:22:24 -0500
In-Reply-To: <CAPDyKFqz36hsJxVJpNcH-Y+gzTOfewPiV3w4LApQOdrQiKLNtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Dan O'Donovan <dan@emutex.com>

On 30/11/16 12:06, Ulf Hansson wrote:
> On 30 November 2016 at 10:20, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> Clearing the tuning bits should reset the tuning circuit. However there is
>> more to do. Reset the command and data lines for good measure, and then
>> for eMMC ensure the card is not still trying to process a tuning command by
>> sending a stop command.
>>
>> Note the JEDEC eMMC specification says the stop command (CMD12) can be used
>> to stop a tuning command (CMD21) whereas the SD specification is silent on
>> the subject with respect to the SD tuning command (CMD19). Considering that
>> CMD12 is not a valid SDIO command, the stop command is sent only when the
>> tuning command is CMD21 i.e. for eMMC. That addresses cases seen so far
>> which have been on eMMC.
>>
>> Note that this replaces the commit fe5fb2e3b58f ("mmc: sdhci: Reset cmd and
>> data circuits after tuning failure") which is being reverted for v4.9+.
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> Tested-by: Dan O'Donovan <dan@emutex.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  drivers/mmc/host/sdhci.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index e761fe2aa99e..1d72a51287d4 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2095,7 +2095,27 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>>                         ctrl &= ~SDHCI_CTRL_EXEC_TUNING;
>>                         sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
>>
>> +                       sdhci_do_reset(host, SDHCI_RESET_CMD);
>> +                       sdhci_do_reset(host, SDHCI_RESET_DATA);
>> +
>>                         err = -EIO;
>> +
>> +                       if (cmd.opcode != MMC_SEND_TUNING_BLOCK_HS200)
>> +                               goto out;
>> +
>> +                       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>> +                       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>> +
>> +                       spin_unlock_irqrestore(&host->lock, flags);
>> +
>> +                       memset(&cmd, 0, sizeof(cmd));
>> +                       cmd.opcode = MMC_STOP_TRANSMISSION;
>> +                       cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> +                       cmd.busy_timeout = 50;
>> +                       mmc_wait_for_cmd(mmc, &cmd, 0);
> 
> No, please don't add more hacks to send commands internally from sdhci.
> 
> Maybe even before you start fix the problems for tuning, perhaps you
> try to clean up the current code when sending CMD21/19 in
> sdhci_execute_tuning()?
> 
> Moreover, according to the change log above, it seems like a generic
> thing to send CMD12 to abort tuning. In such case, we could either
> make the core deal with it in the error path - or we could implement a
> "mmc_abort_tuning()" function, host drivers may call when needed.

I am not sure a cleanup would apply cleanly to stable trees.  It would be
nicer to have these patches for stable and then a cleanup on top.  Would
that be acceptable?

