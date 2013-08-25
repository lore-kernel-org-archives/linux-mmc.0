From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] dw_mmc-pci: get resources from a proper BAR
Date: Sun, 25 Aug 2013 00:02:48 -0400
Message-ID: <87k3jaquxj.fsf@octavius.laptop.org>
References: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41662 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755544Ab3HYEC4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 25 Aug 2013 00:02:56 -0400
In-Reply-To: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com> (Andy
	Shevchenko's message of "Thu, 8 Aug 2013 13:44:57 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>

Hi Andy,

On Thu, Aug 08 2013, Andy Shevchenko wrote:
> There is a typo when the mapped space is from BAR 2, but BAR 0 is used instead.
> This patch fixes the typo.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index b456b0c..7d148d6 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -59,7 +59,7 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	host->regs = pcim_iomap_table(pdev)[0];
> +	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
>  
>  	ret = dw_mci_probe(host);
>  	if (ret)

Thanks, pushed to mmc-next for 3.12.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
