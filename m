From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: improve card removal check in sdhci_card_event()
Date: Thu, 27 Jun 2013 11:37:36 -0400
Message-ID: <87k3lfo98f.fsf@octavius.laptop.org>
References: <1370778564-32695-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:60278 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab3F0Phk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 27 Jun 2013 11:37:40 -0400
In-Reply-To: <1370778564-32695-1-git-send-email-shawn.guo@linaro.org> (Shawn
	Guo's message of "Sun, 9 Jun 2013 19:49:24 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de

Hi Shawn,

On Sun, Jun 09 2013, Shawn Guo wrote:
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
> ---
>  drivers/mmc/host/sdhci.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c81c2a2..eadb3ad 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2066,8 +2066,7 @@ static void sdhci_card_event(struct mmc_host *mmc)
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	/* Check host->mrq first in case we are runtime suspended */
> -	if (host->mrq &&
> -	    !(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT)) {
> +	if (host->mrq && !sdhci_do_get_cd(host)) {
>  		pr_err("%s: Card removed during transfer!\n",
>  			mmc_hostname(host->mmc));
>  		pr_err("%s: Resetting controller.\n",

Thanks, pushed to mmc-next for 3.11, sorry for the delay.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
