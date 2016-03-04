From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-tegra: Specify valid DMA mask
Date: Fri, 4 Mar 2016 15:43:56 +0900
Message-ID: <CAAVeFuLEXB1uLgzbvTy207z5Dh6LST7DvzTJ5Vtt1JeiStJztg@mail.gmail.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
 <10092864.HLRl1VM3vC@wuerfel> <CAAVeFuLqWcjAvCA4Stu=APFt0_jY6C=HiFfLiUnx=_W5Mj9gQg@mail.gmail.com>
 <1671523.8ABQgk2cvG@wuerfel> <CAAVeFuLN7SUM3rSgYXOut+2xgwHEzyY51c2tKP2fqKCRD7ZZXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuLN7SUM3rSgYXOut+2xgwHEzyY51c2tKP2fqKCRD7ZZXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 4, 2016 at 3:08 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Wed, Mar 2, 2016 at 8:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wednesday 02 March 2016 19:36:23 Alexandre Courbot wrote:
>>> On Wed, Mar 2, 2016 at 6:34 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> > On Tuesday 01 March 2016 13:32:44 Alexandre Courbot wrote:
>>> >> On T210, the sdhci controller can address more than 32 bits of address
>>> >> space. Failing to express this fact results in the use of bounce
>>> >> buffers and affects performance.
>>> >>
>>> >> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> >
>>> > I don't get this one. Why don't you just set the (SDHCI_USE_SDMA | SDHCI_USE_ADMA)
>>> > flags that are checked in the first patch?
>>>
>>> The test is against (!(host->flags & (SDHCI_USE_SDMA |
>>> SDHCI_USE_ADMA))), (see the '!') so it will be true (and the DMA mask
>>> will be set) if both flags are *not* set (why we set the mask to 64
>>> bits here in that case, I don't know).
>>>
>>> T210 is capable of SDMA, so we cannot use this condition for that
>>> purpose (maybe you missed the '!', in which case I understand why you
>>> were surprised).
>>
>> Ok, I see now that this code was just setting a fake mask in case
>> of PIO mode, which doesn't apply here. That in turn means that
>> your first patch is wrong though:
>>
>> For a device that is not DMA capable (neither SDMA nor ADMA
>> claimed to be supported), we should not call dma_set_mask_and_coherent()
>> because that is likely to fail as well. It's an ugly hack to
>> just override the mask in that case, and I'd say it requires
>> a comment explaining what is going on.
>
> Yeah, I'm not too sure what is the point of setting the fake mask to
> be honest, but you are definitely right that it is a contradiction to
> call a DMA function on a device that is not DMA-capable.

Ah, I finally got it - we are just setting it to the *address* of
host->dma_mask so the device's DMA mask does not end up being a NULL
pointer.

That actually changes things a bit. DMA-capable devices are clearly
expected to set the mask themselves, but the only one to do it is
host/mtk-sd.c. And dma_set_mask() is only called in dw_mmc and
sdhci-acpi's enable_dma callback.

This means most DMA-capable devices (including Tegra, but not only)
are simply left with no DMA setup at all.

Probably we can detect when the host did not do any DMA setup in the
probe function and attempt some sane defaults depending on what the
hardware says it is capable of?
