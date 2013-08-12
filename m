From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH 1/2] dw_mmc-pci: get resources from a proper BAR
Date: Mon, 12 Aug 2013 07:34:04 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2CD73D8@IN01WEMBXB.internal.synopsys.com>
References: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kiruna.synopsys.com ([198.182.44.80]:53350 "EHLO
	kiruna.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867Ab3HLHeM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 03:34:12 -0400
In-Reply-To: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>

Tested-by: Prabu Thangamuthu <Prabu.T@synopsys.com>

Regards,
Prabu Thangamuthu.

On 08/12/2013 04:15 PM, Andy Shevchenko wrote:
> There is a typo when the mapped space is from BAR 2, but BAR 0 is used
> instead.
> This patch fixes the typo.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-
> pci.c index b456b0c..7d148d6 100644
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
> --
> 1.8.4.rc1

