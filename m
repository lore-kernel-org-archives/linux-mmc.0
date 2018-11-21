From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v2 0/3] Add support for using external dma in SDHCI
Date: Wed, 21 Nov 2018 17:17:12 +0530
Message-ID: <fb8a9eb6-82a1-1299-489f-9fed4ee48a02@ti.com>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chunyan,

On 12/11/18 12:56 PM, Chunyan Zhang wrote:
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

This is great. It helps us move am335x and am43xx platforms to
sdhci-omap. What platforms have you tested this on?

Thanks,
Faiz
