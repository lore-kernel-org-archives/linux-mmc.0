From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
Date: Mon, 19 Nov 2018 17:32:25 +0100
Message-ID: <CAPDyKFpomN9KyX5u8C9-gBwBNm-sdfHwxbDVYD0hs73WFJR53A@mail.gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
 <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com> <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
 <44e1a97e-0446-283f-72f7-fd8d39a74b0f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <44e1a97e-0446-283f-72f7-fd8d39a74b0f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Arnd Bergmann <arnd@arndb.de>, Chunyan Zhang <zhang.chunyan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 9 November 2018 at 06:27, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Hi Arnd,
>
> On 06/11/18 6:21 PM, Arnd Bergmann wrote:
>> On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> On 05/11/18 8:46 AM, Chunyan Zhang wrote:
>>>>
>>>> +   sdhci_switch_extdma(host, true);
>>>
>>> A number of devices using sdhci-omap supports ADMA. So switching to
>>> external
>>> DMA shouldn't be unconditional.
>>>
>>> IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
>>> should
>>> try switching to external DMA and if external DMA too is not supported, it
>>> should use PIO.
>>
>> What's the reasoning for preferring ADMA/SDMA over external DMA if
>> both are supported?
>
> Generally from our experiments we've found ADMA gives better throughput than
> DMA. I have to ascertain the actual reasons for that.
>>
>> I'd expect that if the external DMA for some reason is worse than
>> ADMA, we just wouldn't list it in the DT at all, but if it's listed and
>> ADMA also works, then the driver should try to use it before falling
>> back to ADMA.
>
> I would agree that for newer dtbs. However if you consider omap_hsmmc, external
> DMA bindings are already added in dt. If we try to switch to sdhci-omap with
> the same bindings, systems with older dtbs will use external DMA and give
> lesser throughput.

I was under the impression that the internal DMA (for old versions) is
rather poor.

However, in the end this is a software policy decision of what to use.
I have no strong opinion, so feel free to pick what you think makes
best sense.

Maybe Adrian also have some thoughts?

Kind regards
Uffe
