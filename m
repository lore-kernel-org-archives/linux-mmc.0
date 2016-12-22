From: arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [v1] mmc: host: dw_mmc-pci:- Handle return NULL error from
 pcim_iomap_table
Date: Thu, 22 Dec 2016 22:42:49 +0530
Message-ID: <7735ce5d-643a-1e8a-1f13-0ea24cc4b65b@gmail.com>
References: <1482408409-13404-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34946 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762052AbcLVRM7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Dec 2016 12:12:59 -0500
In-Reply-To: <1482408409-13404-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Ignore this change. Sorry for noise.

Thanks
-Arvind

On Thursday 22 December 2016 05:36 PM, Arvind Yadav wrote:
> Here, If pcim_iomap_table will fail. It will return NULL.
> Kernel can run into a NULL-pointer dereference.
> This error check will avoid NULL pointer dereference.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/mmc/host/dw_mmc-pci.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index ab82796..f42d302 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -61,6 +61,8 @@ static int dw_mci_pci_probe(struct pci_dev *pdev,
>   		return ret;
>   
>   	host->regs = pcim_iomap_table(pdev)[PCI_BAR_NO];
> +	if (!host->regs)
> +		return -ENOMEM;
>   
>   	pci_set_master(pdev);
>   

