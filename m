From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCHv5 0/6] Add support for UHS-I on Exynos5422 odroid boards
Date: Mon, 8 Oct 2018 13:51:08 +0200
Message-ID: <CAPDyKFp-gnxqknz1ic5jrQ2G0M3X9rMVgj9sWeOiWOX+S7VODw@mail.gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anand Moon <linux.amoon@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 27 September 2018 at 16:07, Anand Moon <linux.amoon@gmail.com> wrote:
> This is series v4 since my previous patches were incomplete with driver
> changes missing.
>
> v5 changes.
> drop the cd-gpios wp-gpio gpio pin setting, just add the pinctrl
> configration to support write protect.
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
> Anand Moon (6):
>   ARM: dts: exynos: Added UHS-I bus speed support
>   ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
>   ARM: dts: exynos: update maximum frequency for sdcard to 200MHz
>   ARM: dts: exynos: Add pin configuration for SD write protect on Odroid
>     XU3/XU4
>   ARM: dts: exynos: update maximum frequency for emmc to 200MHz
>   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
>
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 +++++++
>  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 ++++++--
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
>  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
>  4 files changed, 25 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Anand,

I have applied the mmc patch for next, thanks!

In regards to the DTS changes, I assume the soc maintainers will pick
them up, but maybe you need to resend them separately.

Kind regards
Uffe
