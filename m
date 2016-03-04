From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Fri, 4 Mar 2016 15:08:02 +0900
Message-ID: <CAAVeFuLN7SUM3rSgYXOut+2xgwHEzyY51c2tKP2fqKCRD7ZZXg@mail.gmail.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
 <10092864.HLRl1VM3vC@wuerfel> <CAAVeFuLqWcjAvCA4Stu=APFt0_jY6C=HiFfLiUnx=_W5Mj9gQg@mail.gmail.com>
 <1671523.8ABQgk2cvG@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:35242 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbcCDGIX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Mar 2016 01:08:23 -0500
In-Reply-To: <1671523.8ABQgk2cvG@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Mar 2, 2016 at 8:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 March 2016 19:36:23 Alexandre Courbot wrote:
>> On Wed, Mar 2, 2016 at 6:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tuesday 01 March 2016 13:32:44 Alexandre Courbot wrote:
>> >> On T210, the sdhci controller can address more than 32 bits of address
>> >> space. Failing to express this fact results in the use of bounce
>> >> buffers and affects performance.
>> >>
>> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> >
>> > I don't get this one. Why don't you just set the (SDHCI_USE_SDMA | SDHCI_USE_ADMA)
>> > flags that are checked in the first patch?
>>
>> The test is against (!(host->flags & (SDHCI_USE_SDMA |
>> SDHCI_USE_ADMA))), (see the '!') so it will be true (and the DMA mask
>> will be set) if both flags are *not* set (why we set the mask to 64
>> bits here in that case, I don't know).
>>
>> T210 is capable of SDMA, so we cannot use this condition for that
>> purpose (maybe you missed the '!', in which case I understand why you
>> were surprised).
>
> Ok, I see now that this code was just setting a fake mask in case
> of PIO mode, which doesn't apply here. That in turn means that
> your first patch is wrong though:
>
> For a device that is not DMA capable (neither SDMA nor ADMA
> claimed to be supported), we should not call dma_set_mask_and_coherent()
> because that is likely to fail as well. It's an ugly hack to
> just override the mask in that case, and I'd say it requires
> a comment explaining what is going on.

Yeah, I'm not too sure what is the point of setting the fake mask to
be honest, but you are definitely right that it is a contradiction to
call a DMA function on a device that is not DMA-capable.

>
>> >> @@ -289,6 +291,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
>> >>       .pdata = &sdhci_tegra20_pdata,
>> >>       .nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
>> >>                   NVQUIRK_ENABLE_BLOCK_GAP_DET,
>> >> +     .dma_mask = DMA_BIT_MASK(32),
>> >>  };
>> >
>> > Can you describe what the specific bug is in these controllers? Do you mean they
>> > support SDHCI_USE_SDMA or SDHCI_USE_ADMA in theory but you still have to prevent
>> > them from using high addresses?
>>
>> Ok, I think you probably missed the '!' then. :)
>
> I missed the larger context of that check too, but I think I've got it now.
>
>> >> @@ -353,6 +358,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>> >>
>> >>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>> >>       .pdata = &sdhci_tegra210_pdata,
>> >> +     .dma_mask = DMA_BIT_MASK(34),
>> >>  };
>> >>
>> >>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>> >
>> > This one still completely weirds me out. What kind of odd limitation does
>> > the controller have in Tegra 210?
>> >
>> > Are there actually any machines with more than 16GB?
>>
>> It is not a limitation of the controller - I am just limiting the mask
>> to the range of physical memory we can ever access on T210. My intent
>> here is to overcome the default 32-bit mask, not to limit the range,
>> so I could have set a 64-bit mask if not for my OCD. :P
>>
>> But actually looking at how the various flags are interpreted in
>> sdhci_add_host(), I see the following:
>>
>>     /*
>>      * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
>>      * and *must* do 64-bit DMA.  A driver has the opportunity to change
>>      * that during the first call to ->enable_dma().  Similarly
>>      * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
>>      * implement.
>>      */
>>     if (caps[0] & SDHCI_CAN_64BIT)
>>         host->flags |= SDHCI_USE_64_BIT_DMA;
>>
>> Since this relies on what the hardware declares being capable of and
>> is set on T210, I am very tempted to set a 64-bit dma_mask here and
>> call it a day, but the above comment seems to suggest that this should
>> have been done before.
>
> Right, that sounds good, that also makes it independent of the specific
> Tegra SoC, right?

Yes - it would just be a 2-liner that should set things properly for
all 64-bit capable controllers.

>> If you think this is cool though, I will just do that and in
>> conjunction with patch 1 this will do the job nicely.
>
> as mentioned above, I now have doubts about patch 1, why do you still
> need this now?

We would not need patch 1 anymore.

Let me send this and see if it looks better.

Thanks,
Alex.
