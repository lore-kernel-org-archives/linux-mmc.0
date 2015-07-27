From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [RFC PATCH] mmc: Kconfig: Add dependency on GPIOLIB for Arasan
 driver
Date: Mon, 27 Jul 2015 14:55:04 -0700
Message-ID: <55B6A8B8.3040404@broadcom.com>
References: <920802cde8579bdfad47baba85d85212735ed90e.1437745991.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:58681 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbbG0Vz1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2015 17:55:27 -0400
In-Reply-To: <920802cde8579bdfad47baba85d85212735ed90e.1437745991.git.michal.simek@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Weijun Yang <Weijun.Yang@csr.com>, Andrew Bresticker <abrestic@chromium.org>, Jean Delvare <jdelvare@suse.de>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>, addy ke <addy.ke@rock-chips.com>, Stephen Boyd <sboyd@codeaurora.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Georgi Djakov <gdjakov@mm-sol.com>, Kevin Hao <haokexin@gmail.com>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>

Hi Michal,

comment in line

On 15-07-24 06:53 AM, Michal Simek wrote:
> The patch "mmc: sdhci-of-arasan: Call OF parsing for MMC"
> (sha1: 16b23787fc709fe60c5d2bd05927b1a3da33d4e9) introduce new
> dependency on GPIOLIB which calls mmc_of_parse() ->
> mmc_gpiod_request_cd() (slot-gpio.c) which calls devm_gpiod_get_index()
> which returns -ENOSYS.
>
> Error log:
> sdhci-arasan ff160000.sdhci: parsing dt failed (4294967258)
> sdhci-arasan: probe of ff160000.sdhci failed with error -38
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> This problem is probably in all others drivers.
> This is one way how this can be solved.
> Maybe better way is to block return value for cd and wp.

It appears there is gpio code in sdhci.c as well.  This uses slot-gpio.

Perhaps a depends on needs to be added to MMC_SDHCI instead?

>
> ---
>   drivers/mmc/host/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index fd9a58e216a5..4b5854759cfc 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -120,6 +120,7 @@ config MMC_SDHCI_PLTFM
>   config MMC_SDHCI_OF_ARASAN
>   	tristate "SDHCI OF support for the Arasan SDHCI controllers"
>   	depends on MMC_SDHCI_PLTFM
> +	depends on GPIOLIB
>   	depends on OF
>   	help
>   	  This selects the Arasan Secure Digital Host Controller Interface
>

