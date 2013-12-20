From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Fri, 20 Dec 2013 09:17:39 +0200
Message-ID: <52B3EF13.8060806@intel.com>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org> <52B22906.4010704@wwwdotorg.org> <52B2B5DF.1020702@intel.com> <52B344E0.5080009@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B344E0.5080009-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 19/12/13 21:11, Stephen Warren wrote:
> On 12/19/2013 02:01 AM, Adrian Hunter wrote:
>> On 19/12/13 01:00, Stephen Warren wrote:
>>> On 12/18/2013 03:27 PM, Stephen Warren wrote:
>>>> From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> In mmc_do_calc_max_discard(), if only a single erase block can be
>>>> discarded within the host controller's timeout, don't allow discard
>>>> operations at all.
>>>>
>>>> Previously, the code allowed sector-at-a-time discard (rather than
>>>> erase-block-at-a-time), which was chronically slow.
>>>>
>>>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>>>> in qty == 1, which is immediately returned. This causes discard to
>>>> operate a single sector at a time, which is chronically slow. With this
>>>> patch in place, discard operates a single erase block at a time, which
>>>> is reasonably fast.
>>>
>>> Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
>>> host controllers specify maximum discard timeout", followed by:
>>>
>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>> index 050eb262485c..35c5b5d86c99 100644
>>>> --- a/drivers/mmc/core/core.c
>>>> +++ b/drivers/mmc/core/core.c
>>>> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>>>         cmd.opcode = MMC_ERASE;
>>>>         cmd.arg = arg;
>>>>         cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>>>>         err = mmc_wait_for_cmd(card->host, &cmd, 0);
>>>>         if (err) {
>>>>                 pr_err("mmc_erase: erase error %d, status %#x\n",
>>>> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
>>>>         if (mmc_host_is_spi(card->host))
>>>>                 goto out;
>>>>  
>>>> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>>>> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card, arg, qty));
>>>>         do {
>>>>                 memset(&cmd, 0, sizeof(struct mmc_command));
>>>>                 cmd.opcode = MMC_SEND_STATUS;
>>>
>>> That certainly also seems to solve the problem on my board...
>>
>> But large erases will timeout when they should have been split into smaller
>> chunks.
>>
>> A generic solution needs to be able to explain what happens when the host
>> controller *does* timeout.
> 
> I thought the whole point of this discussion was that the timeout in the
> first code segment above only applies to command submission, whereas
> completion of the erase operation itself was determined by polling using
> CMD13, which still uses mmc_erase_timeout(). As such, I don't /think/
> that "large erases will timeout" here, unless I'm significantly
> misunderstanding something?

Setting cmd_timeout_ms to zero just makes the sdhci driver choose the
highest timeout.

Currently the sdhci driver does not have a facility to disable the timeout,
and, as I noted in another thread, masking the "Data Timeout Error Status
Enable" and "Data Timeout Error Signal Enable" bits did not work for me.
What Ulf is suggesting is to change the response type from R1B to R1.

But there is also a need to avoid polling when it is not necessary and to
make it periodic.

Ulf said he is working on a patch to doing something similar with mmc_switch.
