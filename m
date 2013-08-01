From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc-socfpga: Staticize
 dw_mci_socfpga_probe()
Date: Thu, 1 Aug 2013 11:18:55 -0500
Message-ID: <1375373935.26434.1.camel@linux-builds1>
References: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:20908
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752480Ab3HAQSl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Aug 2013 12:18:41 -0400
In-Reply-To: <004d01ce8e80$91d50d20$b57f2760$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>

Hi,

On Thu, 2013-08-01 at 15:30 +0900, Jingoo Han wrote:
> dw_mci_socfpga_probe() is used only in this file.
> Fix the following sparse warning:
> 
> drivers/mmc/host/dw_mmc-socfpga.c:116:5: warning: symbol 'dw_mci_socfpga_probe' was not declared. Should it be static?
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-socfpga.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
> index 14b5961..35aebb8 100644
> --- a/drivers/mmc/host/dw_mmc-socfpga.c
> +++ b/drivers/mmc/host/dw_mmc-socfpga.c
> @@ -113,7 +113,7 @@ static const struct of_device_id dw_mci_socfpga_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
>  
> -int dw_mci_socfpga_probe(struct platform_device *pdev)
> +static int dw_mci_socfpga_probe(struct platform_device *pdev)
>  {
>  	const struct dw_mci_drv_data *drv_data;
>  	const struct of_device_id *match;

This looks good but do you care to fix the other sparse warnings for
dw_mmc-pltfm.c too?

drivers/mmc/host/dw_mmc-pltfm.c:58:24: warning: incorrect type in
argument 1 (different address spaces)
drivers/mmc/host/dw_mmc-pltfm.c:58:24:    expected void const *ptr
drivers/mmc/host/dw_mmc-pltfm.c:58:24:    got void [noderef]
<asn:2>*regs
drivers/mmc/host/dw_mmc-pltfm.c:59:36: warning: incorrect type in
argument 1 (different address spaces)
drivers/mmc/host/dw_mmc-pltfm.c:59:36:    expected void const *ptr
drivers/mmc/host/dw_mmc-pltfm.c:59:36:    got void [noderef]
<asn:2>*regs
drivers/mmc/host/dw_mmc-pltfm.c:36:5: warning: symbol
'dw_mci_pltfm_register' was not declared. Should it be static?
drivers/mmc/host/dw_mmc-pltfm.c:94:1: warning: symbol
'dw_mci_pltfm_pmops' was not declared. Should it be static?

Dinh


