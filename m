From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCHv4 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date: Wed, 26 Sep 2018 21:07:30 +0200
Message-ID: <20180926190730.GB6461@kozik-lap>
References: <20180922075238.884-1-linux.amoon@gmail.com>
 <20180922075238.884-2-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180922075238.884-2-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Sep 22, 2018 at 07:52:32AM +0000, Anand Moon wrote:
> This is series v4 since my previous patches were incomplete with driver
> changes missing.
> 
> v4 changes.
> squash cd-gpios and wp-gpio changes into single patch.
> change the subject prefix to "ARM: dts: exynos:"
> 
> These changes add UHS-I tuning for dw_mmc-exynos driver.
> 
> Rebased on Krzysztof branch next/dt
> [0] git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git 
> 

Except the one about CD and WP pins (where I replied), they look ok. It
would be nice if you get tested-by tags for them.

Best regards,
Krzysztof

> Anand Moon (6):
>   ARM: dts: exynos: Added UHS-I bus speed support
>   ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
>   ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos: Add CD and WP pins to Odroid XU3/XU4 SD card
>   ARM: dts: exynos: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
> 
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  8 ++++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 10 ++++++++--
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  4 files changed, 28 insertions(+), 2 deletions(-)
> 
> -- 
> 2.17.1
> 
