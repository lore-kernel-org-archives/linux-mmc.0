From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [RFC PATCH 4/4] mmc: sdhci-of-arasan: overwrite enhanced strobe
 callback
Date: Thu, 3 Mar 2016 12:02:28 +0100
Message-ID: <56D819C4.9080703@xilinx.com>
References: <1456972557-7994-1-git-send-email-shawn.lin@rock-chips.com>
 <1456972613-8159-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0047.outbound.protection.outlook.com ([104.47.36.47]:47312
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751572AbcCCLCh (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Mar 2016 06:02:37 -0500
In-Reply-To: <1456972613-8159-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Michal Simek <michal.simek@xilinx.com>, soren.brinkmann@xilinx.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 3.3.2016 03:36, Shawn Lin wrote:
> Currently sdhci-arasan 5.1 can support enhanced strobe function,
> but considering the potential requirement in the future for other
> version IP, we don't limit it just for "arasan,sdhci-5.1". Add
> cap-enhanced-strobe in DT to enable the function if we'r sure our
> controller can support it.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 1e4b5e0..31f3494 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -24,7 +24,9 @@
>  #include "sdhci-pltfm.h"
>  
>  #define SDHCI_ARASAN_CLK_CTRL_OFFSET	0x2c
> +#define SDHCI_ARASAN_VENDOR_REGISTER	0x78

I was checking our register map and we even don't have this register
listed as reserved.
It looks like that this will be related to certain SoC and different SoC
can use it different location.
That's why I think this feature and setup should be related to certain
SoC specific compatible string.

Thanks,
Michal

