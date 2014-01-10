From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv9 4/4] ARM: socfpga_defconfig: enable SD/MMC support
Date: Fri, 10 Jan 2014 12:49:09 +0900
Message-ID: <52CF6DB5.7080903@samsung.com>
References: <1389303079-19808-1-git-send-email-dinguyen@altera.com>
 <1389303079-19808-5-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54587 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800AbaAJDtB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2014 22:49:01 -0500
In-reply-to: <1389303079-19808-5-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, mturquette@linaro.org
Cc: zhangfei.gao@linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 01/10/2014 06:31 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Enables the dw_mmc driver for SOCFPGA.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
> v9: none
> v8: none
> v7: none
> v6: none
> v5: Add dw_mmc driver into socfpga_defconfig
> v4: none
> v3: none
> v2: none
> ---
>  arch/arm/configs/socfpga_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
> index 4e1ce21..8fff96ba 100644
> --- a/arch/arm/configs/socfpga_defconfig
> +++ b/arch/arm/configs/socfpga_defconfig
> @@ -82,3 +82,5 @@ CONFIG_DEBUG_INFO=y
>  CONFIG_ENABLE_DEFAULT_TRACERS=y
>  CONFIG_DEBUG_USER=y
>  CONFIG_XZ_DEC=y
> +CONFIG_MMC=y
> +CONFIG_MMC_DW=y
> 

