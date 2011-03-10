From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH V1] mx51 enchance the sd/mmc HW timing compatibility on
 mx51 boards.
Date: Thu, 10 Mar 2011 14:42:48 +0800
Message-ID: <20110310064247.GH2556@S2100-06.ap.freescale.net>
References: <1299737746-19324-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:13889 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752318Ab1CJGnK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 01:43:10 -0500
Content-Disposition: inline
In-Reply-To: <1299737746-19324-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, kernel@pengutronix.de, linux-mmc@vger.kernel.org, w.sang@pengutronix.de, eric.miao@linaro.org, eric@eukrea.com, avorontsov@ru.mvista.com, linuxzsc@gmail.com

On Thu, Mar 10, 2011 at 02:15:46PM +0800, Richard Zhu wrote:
> Some cards have the CRC errors in read on mx51 BBG board.
> Configure the eSDHC pad configurations to level up the
> compatibility to fix this issue.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> Tested-by: Shawn Guo <shawn.gsc@gmail.com>
> ---
>  arch/arm/plat-mxc/include/mach/iomux-mx51.h |   40 +++++++++++++-------------
>  1 files changed, 20 insertions(+), 20 deletions(-)
> 
This is a fix for the regression introduced by:

commit ee1ae4d7b1c9a8b73e232fa33dc733be59368ff6
Author: Sascha Hauer <s.hauer@pengutronix.de>
Date:   Wed Dec 15 09:56:35 2010 +0100

    ARM i.MX51: Full iomux support

    This iomux file has been constructed from the Freescale pinmux tool.
    It contains all pins from the tool, but the datasheet lists some
    configurations not present in the tool, these are not yet added.

Richard,

If there is v2, please change Tested-by as below.

Tested-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn

