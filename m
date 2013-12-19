From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Thu, 19 Dec 2013 12:11:28 -0700
Message-ID: <52B344E0.5080009@wwwdotorg.org>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org> <52B22906.4010704@wwwdotorg.org> <52B2B5DF.1020702@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:40946 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631Ab3LSTLd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 14:11:33 -0500
In-Reply-To: <52B2B5DF.1020702@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Dong Aisheng <dongas86@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Vladimir Zapolskiy <vz@mleia.com>

On 12/19/2013 02:01 AM, Adrian Hunter wrote:
> On 19/12/13 01:00, Stephen Warren wrote:
>> On 12/18/2013 03:27 PM, Stephen Warren wrote:
>>> From: Stephen Warren <swarren@nvidia.com>
>>>
>>> In mmc_do_calc_max_discard(), if only a single erase block can be
>>> discarded within the host controller's timeout, don't allow discard
>>> operations at all.
>>>
>>> Previously, the code allowed sector-at-a-time discard (rather than
>>> erase-block-at-a-time), which was chronically slow.
>>>
>>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>>> in qty == 1, which is immediately returned. This causes discard to
>>> operate a single sector at a time, which is chronically slow. With this
>>> patch in place, discard operates a single erase block at a time, which
>>> is reasonably fast.
>>
>> Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
>> host controllers specify maximum discard timeout", followed by:
>>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>> index 050eb262485c..35c5b5d86c99 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>>         cmd.opcode = MMC_ERASE;
>>>         cmd.arg = arg;
>>>         cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>>>         err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>         if (err) {
>>>                 pr_err("mmc_erase: erase error %d, status %#x\n",
>>> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>>         if (mmc_host_is_spi(card->host))
>>>                 goto out;
>>>  
>>> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>>> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card, arg, qty));
>>>         do {
>>>                 memset(&cmd, 0, sizeof(struct mmc_command));
>>>                 cmd.opcode = MMC_SEND_STATUS;
>>
>> That certainly also seems to solve the problem on my board...
> 
> But large erases will timeout when they should have been split into smaller
> chunks.
> 
> A generic solution needs to be able to explain what happens when the host
> controller *does* timeout.

I thought the whole point of this discussion was that the timeout in the
first code segment above only applies to command submission, whereas
completion of the erase operation itself was determined by polling using
CMD13, which still uses mmc_erase_timeout(). As such, I don't /think/
that "large erases will timeout" here, unless I'm significantly
misunderstanding something?
