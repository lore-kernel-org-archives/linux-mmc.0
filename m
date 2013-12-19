From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Thu, 19 Dec 2013 09:22:02 +0100
Message-ID: <52B2ACAA.3000101@mentor.com>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org> <52B22906.4010704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:48624 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab3LSIWT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:22:19 -0500
In-Reply-To: <52B22906.4010704@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Dong Aisheng <dongas86@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

On 12/19/13 00:00, Stephen Warren wrote:
> On 12/18/2013 03:27 PM, Stephen Warren wrote:
>> From: Stephen Warren<swarren@nvidia.com>
>>
>> In mmc_do_calc_max_discard(), if only a single erase block can be
>> discarded within the host controller's timeout, don't allow discard
>> operations at all.
>>
>> Previously, the code allowed sector-at-a-time discard (rather than
>> erase-block-at-a-time), which was chronically slow.
>>
>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>> in qty == 1, which is immediately returned. This causes discard to
>> operate a single sector at a time, which is chronically slow. With this
>> patch in place, discard operates a single erase block at a time, which
>> is reasonably fast.
>
> Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
> host controllers specify maximum discard timeout", followed by:
>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> index 050eb262485c..35c5b5d86c99 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>          cmd.opcode = MMC_ERASE;
>>          cmd.arg = arg;
>>          cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>>          err = mmc_wait_for_cmd(card->host,&cmd, 0);
>>          if (err) {
>>                  pr_err("mmc_erase: erase error %d, status %#x\n",
>> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>          if (mmc_host_is_spi(card->host))
>>                  goto out;
>>
>> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card, arg, qty));
>>          do {
>>                  memset(&cmd, 0, sizeof(struct mmc_command));
>>                  cmd.opcode = MMC_SEND_STATUS;
>
> That certainly also seems to solve the problem on my board...

Personally I'd prefer this change.

Out of curiosity have you tried the approach I proposed as RFC with set
mmc_core.limit_erase_groups=0?

With best wishes,
Vladimir
