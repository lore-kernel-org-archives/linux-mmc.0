From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Wed, 14 May 2014 15:17:08 -0500
Message-ID: <1400098628.23670.3.camel@linux-builds1>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
	 <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
	 <1399909697.16804.0.camel@linux-builds1> <5372F740.3020401@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2lp0207.outbound.protection.outlook.com ([207.46.163.207]:27219
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751118AbaENUTx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 14 May 2014 16:19:53 -0400
In-Reply-To: <5372F740.3020401@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On Wed, 2014-05-14 at 13:55 +0900, Jaehoon Chung wrote:
> Hi, Dinh.
> 
> On 05/13/2014 12:48 AM, Dinh Nguyen wrote:
> > On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
> >> Remove the "support-highspeed" property in dw-mmc.
> >> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> >>
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> ---
> >>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    1 -
> >>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    1 -
> >>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    3 ---
> >>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
> >>  arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
> >>  arch/arm/boot/dts/exynos4412-trats2.dts            |    2 +-
> >>  arch/arm/boot/dts/exynos5250-arndale.dts           |    4 ++--
> >>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +++---
> >>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 ++--
> >>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    4 ++--
> >>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 ++--
> >>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    3 ++-
> >>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    3 ++-
> >>  arch/arm/boot/dts/socfpga_vt.dts                   |    3 ++-
> >>  drivers/mmc/host/dw_mmc.c                          |    3 ---
> >>  15 files changed, 20 insertions(+), 25 deletions(-)
> >>
> > 
> > Should exynos5260-xyref5260.dts and exynos5420-peach-pit.dts also get
> > updated?
> 
> I didn't find them..? Is it included into dts folder.

Ah sorry, I tested this patch series against linux-next, which has these
2 patches.


81141a027c5d ARM: dts: add dts files for exynos5260-xyref5260 board
3528dd34b2d3 ARM: dts: Add exynos5420 peach-pit board support

Not sure if you want to fix those two boards up too, but just thought I
point them out to you.

Dinh

> 
> Best Regards,
> Jaehoon Chung
> > 
> > Dinh
> > 
> > 
> 


