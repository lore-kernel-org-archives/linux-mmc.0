From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: improve card removal check in
 sdhci_card_event()
Date: Fri, 14 Jun 2013 20:43:39 +0800
Message-ID: <20130614124338.GC4489@S2101-09.ap.freescale.net>
References: <1370778564-32695-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:36103
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752579Ab3FNMm7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jun 2013 08:42:59 -0400
Content-Disposition: inline
In-Reply-To: <1370778564-32695-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, kernel@pengutronix.de

On Sun, Jun 09, 2013 at 07:49:24PM +0800, Shawn Guo wrote:
> The following error randomly appears on an imx6q board where gpio is
> used to implement card-detection when mounting EXT4 rootfs during boot.
> 
> mmc1: Card removed during transfer!
> mmc1: Resetting controller.
> mmcblk0: unknown error -123 sending read/write command, card status 0x900
> end_request: I/O error, dev mmcblk0, sector 106744
> EXT4-fs error (device mmcblk0p2): ext4_find_entry:1312: inode #5011: comm swapper/0: reading directory lblock 0
> 
> It turns out that the error message comes from the card removal check
> in function sdhci_card_event().  While we have a well implemented
> function sdhci_do_get_cd() handling all the possible cases of
> CD, the current code only checks controller internal CD case.  That
> causes problem for other CD cases like gpio on above imx6q board.
> 
> Improve the check by using sdhci_do_get_cd() to cover all possible CD
> cases, so that above error on the imx6q board gets fixed.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Chris,

Are you fine with the patch?

Shawn

