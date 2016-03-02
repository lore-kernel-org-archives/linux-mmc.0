From: Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Wed, 2 Mar 2016 19:36:23 +0900
Message-ID: <CAAVeFuLqWcjAvCA4Stu=APFt0_jY6C=HiFfLiUnx=_W5Mj9gQg@mail.gmail.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
 <1456806764-16467-3-git-send-email-acourbot@nvidia.com> <10092864.HLRl1VM3vC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <10092864.HLRl1VM3vC@wuerfel>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 2, 2016 at 6:34 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 01 March 2016 13:32:44 Alexandre Courbot wrote:
>> On T210, the sdhci controller can address more than 32 bits of address
>> space. Failing to express this fact results in the use of bounce
>> buffers and affects performance.
>>
>> Signed-off-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>
> I don't get this one. Why don't you just set the (SDHCI_USE_SDMA | SDHCI_USE_ADMA)
> flags that are checked in the first patch?

The test is against (!(host->flags & (SDHCI_USE_SDMA |
SDHCI_USE_ADMA))), (see the '!') so it will be true (and the DMA mask
will be set) if both flags are *not* set (why we set the mask to 64
bits here in that case, I don't know).

T210 is capable of SDMA, so we cannot use this condition for that
purpose (maybe you missed the '!', in which case I understand why you
were surprised).

>
>> @@ -289,6 +291,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra20 = {
>>       .pdata = &sdhci_tegra20_pdata,
>>       .nvquirks = NVQUIRK_FORCE_SDHCI_SPEC_200 |
>>                   NVQUIRK_ENABLE_BLOCK_GAP_DET,
>> +     .dma_mask = DMA_BIT_MASK(32),
>>  };
>
> Can you describe what the specific bug is in these controllers? Do you mean they
> support SDHCI_USE_SDMA or SDHCI_USE_ADMA in theory but you still have to prevent
> them from using high addresses?

Ok, I think you probably missed the '!' then. :)

>
>> @@ -353,6 +358,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
>>
>>  static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
>>       .pdata = &sdhci_tegra210_pdata,
>> +     .dma_mask = DMA_BIT_MASK(34),
>>  };
>>
>>  static const struct of_device_id sdhci_tegra_dt_match[] = {
>
> This one still completely weirds me out. What kind of odd limitation does
> the controller have in Tegra 210?
>
> Are there actually any machines with more than 16GB?

It is not a limitation of the controller - I am just limiting the mask
to the range of physical memory we can ever access on T210. My intent
here is to overcome the default 32-bit mask, not to limit the range,
so I could have set a 64-bit mask if not for my OCD. :P

But actually looking at how the various flags are interpreted in
sdhci_add_host(), I see the following:

    /*
     * It is assumed that a 64-bit capable device has set a 64-bit DMA mask
     * and *must* do 64-bit DMA.  A driver has the opportunity to change
     * that during the first call to ->enable_dma().  Similarly
     * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
     * implement.
     */
    if (caps[0] & SDHCI_CAN_64BIT)
        host->flags |= SDHCI_USE_64_BIT_DMA;

Since this relies on what the hardware declares being capable of and
is set on T210, I am very tempted to set a 64-bit dma_mask here and
call it a day, but the above comment seems to suggest that this should
have been done before.

If you think this is cool though, I will just do that and in
conjunction with patch 1 this will do the job nicely.
