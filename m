From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v2 0/2] mmc: host: sdhci-s3c: Add support for pinctrl
 interface
Date: Wed, 21 Nov 2012 11:40:49 +0100
Message-ID: <1589890.sTXgh0P5QK@amdc1227>
References: <1353076097-22498-1-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1353076097-22498-1-git-send-email-t.figa@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, cjb@laptop.org, ben-linux@fluff.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, tomasz.figa@gmail.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On Friday 16 of November 2012 15:28:15 Tomasz Figa wrote:
> This series intends to add support for pin configuration using pin
> control interface.
> 
> First patch cleans up GPIO requesting and freeing in the driver to
> simplify adding pin control support.
> 
> Second patch adds pin control support to the driver.
> 
> Changes since v1:
>  - fixed build error because of incorrect merge
> 
> Tomasz Figa (2):
>   mmc: host: sdhci-s3c: Use devm_gpio_request to request GPIOs
>   mmc: host: sdhci-s3c: Add support for pinctrl
> 
>  .../devicetree/bindings/mmc/samsung-sdhci.txt      | 20 ++++++---
>  drivers/mmc/host/sdhci-s3c.c                       | 52
> ++++++++-------------- 2 files changed, 32 insertions(+), 40
> deletions(-)

I know it's less than a week since I posted this series, but time is 
running out, while it would be nice to get this included in 3.8, because 
it's required for all Exynos4 boards using MMC.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
