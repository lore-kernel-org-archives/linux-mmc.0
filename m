From: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCHv3 0/7] Add support for UHS-I on Exynos5422 odroid boards
Date: Fri, 21 Sep 2018 18:00:18 +0530
Message-ID: <CANAwSgT-1pz-NQMb68F7m0rAFNkpCOyFqFPf7-HbZe+92+sPPQ@mail.gmail.com>
References: <20180920175826.1284-1-linux.amoon@gmail.com> <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPdsAK1_9JRzq7_pVfDwBK6WGkFbYUsbcsujCh31Fzsz6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree <devicetree@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Krzysztof,

On Fri, 21 Sep 2018 at 16:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 20 Sep 2018 at 19:58, Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > This is series v3 since my previous patches we incomplete with driver
> > changes missing.
> >
> > These changes add UHS-I tuning for dw_mmc-exynos driver.
> > Some new patches are added to enhance the performace.
>
> Patches look like based on some older version of kernel tree (or
> current mainline) and probably they will not apply on my tree. The
> easiest is to base on top of linux-next or, for DTS patches, on my
> next/dt branch.
>
> Best regards,
> Krzysztof
>
Yes this patch is based on current mainline.
I will try to re-base on your next/dt branch and resend them.

Best Regards
-Anand
> >
> > Anand Moon (7):
> >   ARM: dts: exynos5422: Added UHS-I bus speed support
> >   ARM: dts: exynos5422: fix regulator min values of LDO13 for Odroid
> >     XU3/XU4
> >   ARM: dts: exynos5422: update maximum frequency for sdcard to 200MHz
> >   ARM: dts: exynos5422: use cd-gpio method to detect sd-card
> >   ARM: dts: exynos5422: use wp-gpio method to detect sd-card
> >   ARM: dts: exynos5422: update maximum frequency for emmc to 200MHz
> >   mmc: dw_mmc-exynos: Add tuning for sdr and ddr timing for USH-I mode
> >
> >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |  8 +++++++-
> >  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 +
> >  drivers/mmc/host/dw_mmc-exynos.c                   | 11 +++++++++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > --
> > 2.17.1
> >
