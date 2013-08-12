From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH 2/2] dw_mmc-pci: enable bus-mastering mode
Date: Mon, 12 Aug 2013 07:34:16 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2CD73E4@IN01WEMBXB.internal.synopsys.com>
References: <1375958698-10569-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1375958698-10569-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from us02smtp2.synopsys.com ([198.182.60.77]:34548 "EHLO
	alvesta.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904Ab3HLHeV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Aug 2013 03:34:21 -0400
In-Reply-To: <1375958698-10569-2-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Prabu Thangamuthu <Prabu.T@synopsys.com>, Seungwon Jeon <tgih.jun@samsung.com>

Tested-by: Prabu Thangamuthu <Prabu.T@synopsys.com>

Regards,
Prabu Thangamuthu.

On 08/12/2013 04:15 PM, Andy Shevchenko wrote:
> This patch enables bus-mastering mode for MMC controller to allow IDMAC
> transfers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mmc/host/dw_mmc-pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-
> pci.c index 7d148d6..f70546a 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -61,6 +61,8 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
> 
>  	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
> 
> +	pci_set_master(pdev);
> +
>  	ret = dw_mci_probe(host);
>  	if (ret)
>  		return ret;
> --
> 1.8.4.rc1

