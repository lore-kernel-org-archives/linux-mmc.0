From: Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH 1/5] ARM: Keystone: Enable PINCTRL for Keystone ARCH
Date: Thu, 22 Oct 2015 10:20:29 -0400
Message-ID: <5628F0AD.4030506@ti.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41533 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757758AbbJVOUx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 22 Oct 2015 10:20:53 -0400
In-Reply-To: <1445377809-12516-1-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 10/20/2015 05:50 PM, Franklin S Cooper Jr wrote:
> From: Franklin Cooper <fcooper@ti.com>
>
> Unlike other Keystone 2 devices, newer Keystone 2 SOCs may utilize
> pinmuxing which requires PINCTRL to be enabled. Therefore, enable
> PINCTRL for all Keystone 2 devices.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>   arch/arm/mach-keystone/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
> index ea955f6db..7a432ee 100644
> --- a/arch/arm/mach-keystone/Kconfig
> +++ b/arch/arm/mach-keystone/Kconfig
> @@ -11,6 +11,7 @@ config ARCH_KEYSTONE
>   	select ZONE_DMA if ARM_LPAE
>   	select MIGHT_HAVE_PCI
>   	select PCI_DOMAINS if PCI
> +	select PINCTRL
>   	help
>   	  Support for boards based on the Texas Instruments Keystone family of
>   	  SoCs.
>
Have the Newer SoC base port is sent to the list? Please add these along 
with that series, not now.

-- 
Murali Karicheri
Linux Kernel, Keystone
