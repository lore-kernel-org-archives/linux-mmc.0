From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
Date: Tue, 6 Nov 2018 13:51:17 +0100
Message-ID: <CAK8P3a2X4tbx_R-5VgfApF-UPmJ_XuzH3hO_uVAfffC6h8WrJw@mail.gmail.com>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org> <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be0a18e8-8ee6-4d4e-6dcc-6ba6e39033c9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 11/5/18, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 05/11/18 8:46 AM, Chunyan Zhang wrote:
>>
>> +	sdhci_switch_extdma(host, true);
>
> A number of devices using sdhci-omap supports ADMA. So switching to
> external
> DMA shouldn't be unconditional.
>
> IMHO sdhci.c should see if the device supports ADMA or SDMA. If not it
> should
> try switching to external DMA and if external DMA too is not supported, it
> should use PIO.

What's the reasoning for preferring ADMA/SDMA over external DMA if
both are supported?

I'd expect that if the external DMA for some reason is worse than
ADMA, we just wouldn't list it in the DT at all, but if it's listed and
ADMA also works, then the driver should try to use it before falling
back to ADMA.

       Arnd
