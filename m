From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [PATCH 1/2] Add the GPIO Write Protection Solution on i.MX51
 BBG board
Date: Wed, 20 Oct 2010 12:24:13 +0200
Message-ID: <20101020102413.GE2691@jasper.tkos.co.il>
References: <1287568828-22563-1-git-send-email-r65037@freescale.com>
 <1287568828-22563-2-git-send-email-r65037@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:43159 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855Ab0JTKZL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 20 Oct 2010 06:25:11 -0400
Content-Disposition: inline
In-Reply-To: <1287568828-22563-2-git-send-email-r65037@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <r65037@freescale.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric@eukrea.com, w.sang@pengutronix.de

Hi Richard,

On Wed, Oct 20, 2010 at 06:00:27PM +0800, Richard Zhu wrote:
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c      |   16 ++++++++++++++--
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |    8 +++++---
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 476bfe4..5a69cda 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -34,6 +34,8 @@
>  #include "devices-imx51.h"
>  #include "devices.h"
>  
> +#define BABBAGE_SDHCI1_WP	(0*32 + 1)	/* GPIO_1_1 */
> +#define BABBAGE_SDHCI2_WP	(0*32 + 5)	/* GPIO_1_5 */

Please mention in the subject of this patch that this "write protection" is 
related to the SDHCI device.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
