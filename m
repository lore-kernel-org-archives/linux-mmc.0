From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 0/6] sdhci-esdhc-imx: 8bit mmc support
Date: Fri, 25 Jan 2013 07:47:23 +0100
Message-ID: <51022A7B.4040901@de.bosch.com>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:56195 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3AYHAt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jan 2013 02:00:49 -0500
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 26EFA8405A0
	for <linux-mmc@vger.kernel.org>; Fri, 25 Jan 2013 07:51:11 +0100 (CET)
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>

On 21.01.2013 12:02, Shawn Guo wrote:
> The series makes Auto CMD23 work for imx6q usdhc and then adds 8bit
> mmc support.
> 
> Sascha Hauer (2):
>   mmc: sdhci: rename platform_8bit_width to platform_bus_width
>   mmc: sdhci-esdhc-imx: support 8bit mode
> 
> Shawn Guo (4):
>   mmc: sdhci-esdhc-imx: separate transfer mode from command write for
>     usdhc
>   mmc: sdhci-esdhc-imx: manually reset MIX_CTRL for usdhc
>   mmc: sdhci-esdhc-imx: Auto CMD23 support for usdhc
>   mmc: dt: bus-width can be an optional property
> 
>  Documentation/devicetree/bindings/mmc/mmc.txt |    5 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c            |   98 +++++++++++++++++++++----
>  drivers/mmc/host/sdhci-pci.c                  |    4 +-
>  drivers/mmc/host/sdhci-pxav2.c                |    2 +-
>  drivers/mmc/host/sdhci-s3c.c                  |    8 +-
>  drivers/mmc/host/sdhci-tegra.c                |    4 +-
>  drivers/mmc/host/sdhci.c                      |    8 +-
>  drivers/mmc/host/sdhci.h                      |    2 +-
>  include/linux/platform_data/mmc-esdhc-imx.h   |    1 +
>  9 files changed, 101 insertions(+), 31 deletions(-)

Whole series:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Tested on i.MX6.

Thanks

Dirk
