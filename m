From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA
 devices
Date: Mon, 3 Dec 2018 19:28:03 +0530
Message-ID: <b771f900-cdd6-5cdf-c3ad-f8b034582439@ti.com>
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
 <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
 <f198a61f-40e8-973a-5541-a1bc1dc347de@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f198a61f-40e8-973a-5541-a1bc1dc347de@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 03/12/18 5:45 PM, Faiz Abbas wrote:
> Hi,
> 
>> +static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
>> +					    struct mmc_command *cmd)
>> +{
> 
> Please add a condition for data == NULL here. This was already pointed
> out by Adrian in v2.
> 
> My test with an am335x-evm failed with these patches. Looks like the
> very first SDIO commands failing.
> 
> https://pastebin.ubuntu.com/p/Y2RDjSKpgd/
> 
> Currently am335x-evm is using omap_hsmmc driver. I added the following
> patch to make it work with sdhci_omap.
> 
> https://pastebin.ubuntu.com/p/VTGrCbJxY3/
> 
> Will look deeper into this. Please ping if you need any more information.
> 

So I disabled DMA in the driver altogether and still got the same
messages on am335x-evm in PIO mode. Looks like something more is
required for it to be supported.

I instead shifted to a dra71-evm which supports both ADMA and external
DMA. Here is the log:

https://pastebin.ubuntu.com/p/mcJmgcjQsp/

The interface fundamentally works but it complains with the following error:

[3.111693] Failed to request TX DMA channel.


Thanks,
Faiz
