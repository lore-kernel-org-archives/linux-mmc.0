From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH V3 0/3] Add support for using external dma in SDHCI
Date: Tue, 4 Dec 2018 16:06:10 +0530
Message-ID: <4871e35d-08e4-9199-08bc-f80f83349020@ti.com>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chunyan,

On 04/12/18 12:54 PM, Chunyan Zhang wrote:
> Currently the generic SDHCI code in the Linux kernel supports the SD
> standard DMA integrated into the host controller but does not have any
> support for external DMA controllers implemented using dmaengine meaning
> that custom code is needed for any systems that use a generic DMA
> controller with SDHCI which in practice means any SDHCI controller that
> doesn't have an integrated DMA controller so we should have this as a
> generic feature.
> 
> There are already a number of controller specific drivers that have dmaengine
> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
> in their specific driver for sending command with external dma using dmaengine
> framework, with this patchset, them will take advantage of the generic support.
> TI's omap controller is the case as an example.
> 
> Any comments are very appreciated.
> 

Following your comments, I added dmas in dra7.dtsi as shown in the patch
below.

https://pastebin.ubuntu.com/p/J4F3xWZv5c/

This time the MMC devices enumerate successfully but I see a bunch of

[  108.135736] omap-dma-engine 4a056000.dma-controller: t2_desc[10]
allocation failed

messages when I try to run a short ltp test.

https://pastebin.ubuntu.com/p/WvRSkxBPpv/

Thanks,
Faiz
