From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Mon, 12 May 2014 10:48:17 -0500
Message-ID: <1399909697.16804.0.camel@linux-builds1>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
	 <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0119.outbound.protection.outlook.com ([157.56.111.119]:43524
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755362AbaELQFl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 May 2014 12:05:41 -0400
In-Reply-To: <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
> Remove the "support-highspeed" property in dw-mmc.
> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |    1 -
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |    1 -
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |    3 ---
>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    2 +-
>  arch/arm/boot/dts/exynos4412-origen.dts            |    2 +-
>  arch/arm/boot/dts/exynos4412-trats2.dts            |    2 +-
>  arch/arm/boot/dts/exynos5250-arndale.dts           |    4 ++--
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi      |    6 +++---
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 ++--
>  arch/arm/boot/dts/exynos5420-arndale-octa.dts      |    4 ++--
>  arch/arm/boot/dts/exynos5420-smdk5420.dts          |    4 ++--
>  arch/arm/boot/dts/socfpga_arria5.dtsi              |    3 ++-
>  arch/arm/boot/dts/socfpga_cyclone5.dtsi            |    3 ++-
>  arch/arm/boot/dts/socfpga_vt.dts                   |    3 ++-
>  drivers/mmc/host/dw_mmc.c                          |    3 ---
>  15 files changed, 20 insertions(+), 25 deletions(-)
> 

Should exynos5260-xyref5260.dts and exynos5420-peach-pit.dts also get
updated?

Dinh

