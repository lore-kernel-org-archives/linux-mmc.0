From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: vt8500: Remove erroneous __exitp in wmt_mci_driver
Date: Mon, 28 Jan 2013 16:23:30 -0500
Message-ID: <87boc980j1.fsf@laptop.org>
References: <1358057960-24540-1-git-send-email-linux@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35145 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754420Ab3A1VY2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Jan 2013 16:24:28 -0500
In-Reply-To: <1358057960-24540-1-git-send-email-linux@prisktech.co.nz> (Tony
	Prisk's message of "Sun, 13 Jan 2013 19:19:20 +1300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Prisk <linux@prisktech.co.nz>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, vt8500-wm8505-linux-kernel@googlegroups.com, linux-mmc@vger.kernel.org

Hi Tony,

On Sun, Jan 13 2013, Tony Prisk wrote:
> With the __devinit/__devexit attributes having been removed, this
> __exitp attribute causes an unused function warning and should be
> removed as well.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/mmc/host/wmt-sdmmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 154f0e8..c6d0015 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -1012,7 +1012,7 @@ static const struct dev_pm_ops wmt_mci_pm = {
>  
>  static struct platform_driver wmt_mci_driver = {
>  	.probe = wmt_mci_probe,
> -	.remove = __exit_p(wmt_mci_remove),
> +	.remove = wmt_mci_remove,
>  	.driver = {
>  		.name = DRIVER_NAME,
>  		.owner = THIS_MODULE,

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
