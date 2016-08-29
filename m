From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Add SDHCI_QUIRK2_BROKEN_64_BIT_DMA
Date: Mon, 29 Aug 2016 11:40:51 -0400
Message-ID: <CAOGqxeVZBkfMX7wj9V=RhDV+V7hUyVVMUuGgepkN6yGc9B9xLg@mail.gmail.com>
References: <20160808015803.2528-1-jaedon.shin@gmail.com> <501206D1-D60B-4BA7-99C0-C38065C3AE9E@gmail.com>
 <7edcef69-d364-8845-a677-3827a50f4da1@gmail.com> <5229438.Oa2AiqCmJN@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34226 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933012AbcH2Pkx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Aug 2016 11:40:53 -0400
Received: by mail-qk0-f182.google.com with SMTP id t7so141658810qkh.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Aug 2016 08:40:53 -0700 (PDT)
In-Reply-To: <5229438.Oa2AiqCmJN@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc <linux-mmc@vger.kernel.org>

On Mon, Aug 29, 2016 at 5:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday, August 27, 2016 12:56:10 PM CEST Florian Fainelli wrote:
>>
>> Finally, Arnd's suggestions of using "dma-ranges" is fine, but I do not
>> think we quite need this here because we really need to advertise the
>> right set of capabilities based on the generation/version of the
>> controller deployed in specific chips.
>
> To be more specific here, I think that without the dma-ranges property
> you should never be able to set a dma-mask larger than the 32-bit
> mask, so if you have machines that are capable of high DMA, you
> should definitely add the property in the bus, even if that is
> currently ignored.
>
> I've suggested a patch before, but I believe both ARM and MIPS ignore
> this at the moment, and just allow drivers to set arbitrary masks
> even when the bus does not have a dma-ranges property, and that
> is a bug.


I think there's some confusion over the core issue so let be summarize.
The SDHCI host controller CAPABILITIES register bit 28 indicates if
the host controller hardware can support 64 bit addresses using the
larger 96 bit DMA descriptors. We currently don't have any SoCs that
have this support, even our current 64bit ARM SoCs don't support this,
though there are future ARM SoCs that will have this support. The bug
is that a few MIPS based SoCs had this bit incorrectly set even though
the hardware did not support it and this caused the driver to use the
larger DMA descriptors which crashed the driver. All we're trying to
fix here is a simple SDHCI host controller hardware bug where a CAPs
bit is a 1 where it should be a 0. Our future 64 ARM chips that do
support 64bit addressing should be the only chips with this bit set.


Al
