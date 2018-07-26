From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 3/3] mmc: tegra: prevent ACMD23 on Tegra 3
Date: Thu, 26 Jul 2018 17:51:13 +0200
Message-ID: <7edc8c666dbbc0743221c86286ff583a@agner.ch>
References: <20180712073904.4705-1-stefan@agner.ch>
 <20180712073904.4705-3-stefan@agner.ch>
 <430c718d-9ede-d47a-44c0-b8e47e297720@gmail.com>
 <1553c44e99b96a813af129d1c4169222@agner.ch>
 <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <553f9ed6-8f7c-775b-d731-fd9732f74b07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Geis <pgwipeout@gmail.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org, thierry.reding@gmail.com, jonathanh@nvidia.com, marcel.ziswiler@toradex.com, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-tegra-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 26.07.2018 17:12, Peter Geis wrote:
> On 07/26/2018 10:47 AM, Stefan Agner wrote:
>> On 26.07.2018 15:56, Peter Geis wrote:
>>> On 07/12/2018 03:39 AM, Stefan Agner wrote:
>>>> It seems that SD3.0 advertisement needs to be set for higher eMMC
>>>> speed modes (namely DDR52) as well. The TRM states that the SD3.0
>>>> advertisement bit should be set for all controller instances, even
>>>> for those not supporting UHS-I mode...
>>>>
>>>> When specifying vqmmc-supply as a fixed 1.8V regulator on a Tegra
>>>> SD/MMC instance which is connected to a eMMC device, the stack
>>>> enables SD3.0. However, enabling it has consequences: If SDHCI 3.0
>>>> support is advertised the stack enables Auto-CMD23. Unfortunately
>>>> Auto-CMD23 seems not to work well with Tegra 3 currently. It leads
>>>> to regular warnings:
>>>>     mmc2: Got command interrupt 0x00010000 even though no command operation was in progress.
>>>>
>>>> It is not entirely clear why those errors happens. It seems that
>>>> a Linux 3.1 based downstream kernel which has Auto-CMD23 support
>>>> does not show those warnings.
>>>>
>>>> Use quirk SDHCI_QUIRK2_ACMD23_BROKEN to prevent Auto-CMD23 being
>>>> used for now. With this the eMMC works stable on high-speed mode
>>>> while still announcing SD3.0.
>>>>
>>>> This allows to use mmc-ddr-1_8v to enables DDR52 mode. In DDR52
>>>> mode read speed improves from about 42MiB/s to 72MiB/s on an
>>>> Apalis T30.
>>>>
>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>>>> ---
>>>>    drivers/mmc/host/sdhci-tegra.c | 10 +++++++++-
>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>>>> index 888a1ad511db..11c0b2069c7c 100644
>>>> --- a/drivers/mmc/host/sdhci-tegra.c
>>>> +++ b/drivers/mmc/host/sdhci-tegra.c
>>>> @@ -336,7 +336,15 @@ static const struct sdhci_pltfm_data sdhci_tegra30_pdata = {
>>>>    		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
>>>>    		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>>>>    	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
>>>> -		   SDHCI_QUIRK2_BROKEN_HS200,
>>>> +		   SDHCI_QUIRK2_BROKEN_HS200 |
>>>> +		   /*
>>>> +		    * Auto-CMD23 leads to "Got command interrupt 0x00010000 even
>>>> +		    * though no command operation was in progress."
>>>> +		    *
>>>> +		    * The exact reason is unknown, as the same hardware seems
>>>> +		    * to support Auto CMD23 on a downstream 3.1 kernel.
>>>> +		    */
>>>> +		   SDHCI_QUIRK2_ACMD23_BROKEN,
>>>>    	.ops  = &tegra_sdhci_ops,
>>>>    };
>>>>
>>>
>>> I finally got around to testing this on the Ouya (Tegra 3).
>>
>> Thanks for testing!
>>
>>>
>>> I found that the "Got command interrupt 0x00010000 even though no
>>> command operation was in progress." error occurred when the interface
>>> is unstable.
>>> I've had a lot of problems with sdmmc4 stability on the Ouya above 34
>>> Mhz, probably due to the fact that they are using the internal cmd and
>>> clock pull-up resistors, against the TRM's instruction.
>>> At 39Mhz, I saw the error this patch corrects.
>>> With the patch, the error went away, but the interface is still
>>> unstable under load.
>>
>> How does this instability manifest exactly?
>>
> 
> At the very edge of stability, you see write errors under heavy load.
> As clock rate increases, the write errors occur more frequently.
> At a certain point, you start getting read errors.
> Following that you get constant io errors during card probing.
> Eventually the emmc will fail to initialize, with errors 87 or 110.

What mode are you running at actually? E.g. what is the ios file saying?
cat /sys/kernel/debug/mmcX/ios

> 
> I've been tweaking the pull up/down values to try and improve the
> stability, but without access to anything but the TRM it's a lot of
> trial and error.
> 

Hm, maybe Marcel's recent fixes in our device tree are helpful?
https://lkml.org/lkml/2018/7/22/165

Also make sure to have a complete pinmux such that alternative pins for
sdmmc4 are *not* muxed as sdmmc4.

>>>
>>> Lowering down to 32Mhz, without the patch there are no errors.
>>
>> So the patch does not make it less stable right?
>>
> 
> No, it did not affect stability.
> Although I'd conduct some performance testing to check for degradation.
> Of course I'm nowhere near the limits of the controller, so it is
> doubtful I'd see a hit.

Ok, and this is with the complete patchset applied correct?

Btw, what device tree are you using? Ouya is not upstream as far as I
can tell?

--
Stefan

> 
>> --
>> Stefan
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-tegra" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
