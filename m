From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 0/5] mmc: mxcmmc: add mpc512x support
Date: Fri, 12 Apr 2013 15:14:16 -0400
Message-ID: <87bo9jblyv.fsf@octavius.laptop.org>
References: <1365456489-13152-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41889 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504Ab3DLTOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 12 Apr 2013 15:14:20 -0400
In-Reply-To: <1365456489-13152-1-git-send-email-agust@denx.de> (Anatolij
	Gustschin's message of "Mon, 8 Apr 2013 23:28:04 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Sascha Hauer <s.hauer@pengutronix.de>, Markus Pargmann <mpa@pengutronix.de>

Hi,

On Mon, Apr 08 2013, Anatolij Gustschin wrote:
> The SDHC controller on mpc512x is compatible with i.MX31 SDHC
> controller, the existing MMC host driver can be used on
> mpc512x with some modifications, the patch series extends
> the existing driver. It is based on the following v3 mxcmmc DT
> support patch:
>
>    https://patchwork.kernel.org/patch/2368631
>
> Changes in v3 series are mentioned in each patch
>
> Anatolij Gustschin (5):
>   mmc: mxcmmc: fix race conditions for host->req and host->data access
>   mmc: mxcmmc: add mpc512x SDHC support
>   mmc: mxcmmc: use slot-gpio API for write-protect detection
>   mmc: mxcmmc: constify mxcmci_devtype
>   mmc: mxcmmc: enable DMA support on mpc512x
>
>  arch/powerpc/boot/dts/mpc5121.dtsi |    2 +
>  drivers/mmc/host/Kconfig           |   10 +-
>  drivers/mmc/host/mxcmmc.c          |  209 ++++++++++++++++++++++++++----------
>  3 files changed, 159 insertions(+), 62 deletions(-)

Thanks, all pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
