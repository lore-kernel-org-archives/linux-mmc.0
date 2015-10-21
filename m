From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH 5/5] ARM: keystone: defconfig: Enable CAN support
Date: Tue, 20 Oct 2015 18:28:09 -0700
Message-ID: <5626EA29.7050608@oracle.com>
References: <1445377809-12516-1-git-send-email-fcooper@ti.com>
 <1445377809-12516-5-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:37326 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753192AbbJUB2l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2015 21:28:41 -0400
In-Reply-To: <1445377809-12516-5-git-send-email-fcooper@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, linux@arm.linux.org.uk, ssantosh@kernel.org, ulf.hansson@linaro.org, m-karicheri2@ti.com, grygorii.strashko@ti.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 10/20/2015 2:50 PM, Franklin S Cooper Jr wrote:
> Newer Keystone 2 devices support CAN. Enable CAN support as modules.
>
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
Again. Please shown me the usecases before adding config
option. DTS nodes have to be there.

>   arch/arm/configs/keystone_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
> index ed3e83e..e9bd825 100644
> --- a/arch/arm/configs/keystone_defconfig
> +++ b/arch/arm/configs/keystone_defconfig
> @@ -137,6 +137,9 @@ CONFIG_I2C_DAVINCI=y
>   CONFIG_SPI=y
>   CONFIG_SPI_DAVINCI=y
>   CONFIG_SPI_SPIDEV=y
> +CONFIG_CAN=m
> +CONFIG_CAN_C_CAN=m
> +CONFIG_CAN_C_CAN_PLATFORM=m
>   CONFIG_MMC=y
>   CONFIG_MMC_OMAP_HS=y
>   # CONFIG_HWMON is not set
>
