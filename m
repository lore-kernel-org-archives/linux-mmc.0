From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: MMC performance degradation due to too many requests
Date: Tue, 15 May 2018 20:41:02 +0530
Message-ID: <3e2c96fa-273e-192f-1caf-788de7659592@ti.com>
References: <0ea1d2bf-fa0f-4b3d-556a-5dca5afbf2a9@ti.com>
 <CACRpkdaZ5G=gBHNwf7YMLEBOqC2UrO+YLrz09H4h8HWYN=av4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdaZ5G=gBHNwf7YMLEBOqC2UrO+YLrz09H4h8HWYN=av4w@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On Tuesday 15 May 2018 06:09 PM, Linus Walleij wrote:
> On Mon, May 14, 2018 at 1:30 PM, Faiz Abbas <faiz_abbas@ti.com> wrote:
> 
>> Also, I see many times the number of interrupts for mmc1 in 4.14.
> (...)
>> I also printed out the size of the DMA transfers in the omap_hsmmc
>> driver during the dd command. I see that the maximum size of the dma
>> transfer has decreased from 1 MB to 256kB between 4.13 and 4.14.
> 
> This seems like my fault for removing the bounce buffer.
> (The name bounce buffer is misleading, I suspect the right
> term for what is was doing was "merge buffer" or something,
> coalescing physically consecutive requests.)
> 
> commit de3ee99b097dd51938276e3af388cd4ad0f2750a
> "mmc: Delete bounce buffer handling"
> should be the culprit.

I don't think so. I checked out to the commit before that and see that
the interrupts are still too high.

> 
> The bounce buffer only makes any performance impact if the
> host DMA controller is unable to handle scatter-gather lists
> so the number of segments is set down to 1.
> 
> Can you verifty that:
> - mmc->max_segs == 1

No. It is 64 in v4.14. It was 1024 in v4.13.

v4.14
https://pastebin.ubuntu.com/p/4wXB2jb6zw/

v4.13
https://pastebin.ubuntu.com/p/dpd6kb4YJY/


> - You were previously enabling CONFIG_MMC_BLOCK_BOUNCE

Yes.

Regards,
Faiz
