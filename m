From: "Rizvi, Mohammad Faiz Abbas" <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/3] Add support for using external dma in SDHCI
Date: Wed, 28 Nov 2018 22:28:52 +0530
Message-ID: <5a45f520-03b0-3679-2175-a19681062bf6@ti.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
 <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>broonie@kernel.org
List-Id: linux-mmc@vger.kernel.org

+ Mark Brown

Chunyan,

On 11/21/2018 5:17 PM, Faiz Abbas wrote:
> Hi Chunyan,
> 
> On 12/11/18 12:56 PM, Chunyan Zhang wrote:
>> Currently the generic SDHCI code in the Linux kernel supports the SD
>> standard DMA integrated into the host controller but does not have any
>> support for external DMA controllers implemented using dmaengine meaning
>> that custom code is needed for any systems that use a generic DMA
>> controller with SDHCI which in practice means any SDHCI controller that
>> doesn't have an integrated DMA controller so we should have this as a
>> generic feature.
>>
>> There are already a number of controller specific drivers that have dmaengine
>> code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
>> in their specific driver for sending command with external dma using dmaengine
>> framework, with this patchset, them will take advantage of the generic support.
>> TI's omap controller is the case as an example.
>>
>> Any comments are very appreciated.
>>
> 
> This is great. It helps us move am335x and am43xx platforms to
> sdhci-omap. What platforms have you tested this on?
> 

Gentle ping on this. I tried testing these with an am335x-evm board. In 
their current condition, the card fails to enumerate altogether. The 
changes suggested by Adrian should fix this. Let me know when you post a v3.

Thanks,
Faiz
