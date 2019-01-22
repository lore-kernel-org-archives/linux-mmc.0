From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] dt-bindings: sdhci-omap: Add properties for using
 external dma
Date: Tue, 22 Jan 2019 15:50:10 +0530
Message-ID: <7231fba8-de0d-dd22-5ec8-d62d34c6495d@ti.com>
References: <20190121232057.GA30919@bogus>
 <20190122084706.11522-1-zhang.chunyan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122084706.11522-1-zhang.chunyan@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunyan Zhang <zhang.chunyan@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Chunyan,

+Rob Herring

On 22/01/19 2:17 PM, Chunyan Zhang wrote:
> sdhci-omap can support both external dma controller via dmaengine
> framework as well as ADMA which standard SD host controller
> provides.
> 
> Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---

Thanks for fixing this. However, this change should be part of the
series (with a change log and a version number). I will send this as a
part of my series after I get some Acks on the driver patches.

Thanks,
Faiz
