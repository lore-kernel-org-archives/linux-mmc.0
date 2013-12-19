From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] mmc: core: don't return 1 for max_discard
Date: Thu, 19 Dec 2013 11:26:49 +0100
Message-ID: <CAPDyKFoiGzspgrtRwXruPqOODxbfKA4AAZHj_VF8H7rpwm7eTQ@mail.gmail.com>
References: <1387405663-14253-1-git-send-email-swarren@wwwdotorg.org>
	<52B22906.4010704@wwwdotorg.org>
	<52B2B5DF.1020702@intel.com>
	<52B2B8F7.1000905@mentor.com>
	<52B2BF95.302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52B2BF95.302-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dong Aisheng <dongas86-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 19 December 2013 10:42, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On 19/12/13 11:14, Vladimir Zapolskiy wrote:
>> On 12/19/13 10:01, Adrian Hunter wrote:
>>> On 19/12/13 01:00, Stephen Warren wrote:
>>>> On 12/18/2013 03:27 PM, Stephen Warren wrote:
>>>>> From: Stephen Warren<swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>>
>>>>> In mmc_do_calc_max_discard(), if only a single erase block can be
>>>>> discarded within the host controller's timeout, don't allow discard
>>>>> operations at all.
>>>>>
>>>>> Previously, the code allowed sector-at-a-time discard (rather than
>>>>> erase-block-at-a-time), which was chronically slow.
>>>>>
>>>>> Without this patch, on the NVIDIA Tegra Cardhu board, the loops result
>>>>> in qty == 1, which is immediately returned. This causes discard to
>>>>> operate a single sector at a time, which is chronically slow. With this
>>>>> patch in place, discard operates a single erase block at a time, which
>>>>> is reasonably fast.
>>>>
>>>> Alternatively, is the real fix a revert of e056a1b5b67b "mmc: queue: let
>>>> host controllers specify maximum discard timeout", followed by:
>>>>
>>>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>>>>> index 050eb262485c..35c5b5d86c99 100644
>>>>> --- a/drivers/mmc/core/core.c
>>>>> +++ b/drivers/mmc/core/core.c
>>>>> @@ -1950,7 +1950,6 @@ static int mmc_do_erase(struct mmc_card *card,
>>>>> unsigned int from,
>>>>>          cmd.opcode = MMC_ERASE;
>>>>>          cmd.arg = arg;
>>>>>          cmd.flags = MMC_RSP_SPI_R1B | MMC_RSP_R1B | MMC_CMD_AC;
>>>>> -       cmd.cmd_timeout_ms = mmc_erase_timeout(card, arg, qty);
>>>>>          err = mmc_wait_for_cmd(card->host,&cmd, 0);
>>>>>          if (err) {
>>>>>                  pr_err("mmc_erase: erase error %d, status %#x\n",
>>>>> @@ -1962,7 +1961,7 @@ static int mmc_do_erase(struct mmc_card *card,
>>>>> unsigned int from,
>>>>>          if (mmc_host_is_spi(card->host))
>>>>>                  goto out;
>>>>>
>>>>> -       timeout = jiffies + msecs_to_jiffies(MMC_CORE_TIMEOUT_MS);
>>>>> +       timeout = jiffies + msecs_to_jiffies(mmc_erase_timeout(card,
>>>>> arg, qty));
>>>>>          do {
>>>>>                  memset(&cmd, 0, sizeof(struct mmc_command));
>>>>>                  cmd.opcode = MMC_SEND_STATUS;
>>>>
>>>> That certainly also seems to solve the problem on my board...
>>>
>>> But large erases will timeout when they should have been split into smaller
>>> chunks.
>>>
>>> A generic solution needs to be able to explain what happens when the host
>>> controller *does* timeout.
>>
>> Please correct me, but if Data Timeout Error is disabled, then this is not
>> an issue for most of the host controllers.
>
> That is a very good point.  My experience with SDHCI was that masking the
> "Data Timeout Error Status Enable" and "Data Timeout Error Signal Enable
> " bits did not disable the timeout i.e. the host controller would not
> deliver a TC interrupt if the erase exceeded the timeout.
>
> What happens on your board?
>

I posted a response yesterday for "[PATCH] mmc: core: don't decrement
qty when calculating max_discard", related to this. Please have a
look.

I think the interesting case to consider here is how we can handle
busy detection timeouts that is bigger than what the host hw can
support.

Option 1)
Should we tell the host to disable the timeout in this case? That
potentially means hanging forever - if the card misbehaves. Like
omap_hsmmc does for erase commands. Maybe that is an okay limitation?

Option 2)
Use a R1 response instead if R1B to prevent the host from doing busy
detection. Then rely on the CMD13 to poll for completion instead.
Obviously we can then stop polling after some selected timeout is the
card don't complete it's operations.

Would be very interesting to know what option you prefer!?

Kind regards
Uffe
