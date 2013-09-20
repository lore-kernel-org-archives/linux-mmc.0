From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-bcm-kona: Use sdhci_pltfm_unregister
 instead of open coded
Date: Fri, 20 Sep 2013 10:32:25 -0700
Message-ID: <523C86A9.7000504@broadcom.com>
References: <1379404772.12080.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:4626 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752982Ab3ITRcn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 20 Sep 2013 13:32:43 -0400
In-Reply-To: <1379404772.12080.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 13-09-17 12:59 AM, Axel Lin wrote:
> This avoid duplicated implementation and also fixes missing iounmap() and
> release_mem_region() calls in sdhci_bcm_kona_remove().
> sdhci_pltfm_init() calls request_mem_region() and ioremap(), thus we need to
> call the corresponding iounmap() and release_mem_region() calls in
> sdhci_bcm_kona_remove().
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>   drivers/mmc/host/sdhci-bcm-kona.c | 14 +-------------
>   1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
> index 85472d3..7a190fe 100644
> --- a/drivers/mmc/host/sdhci-bcm-kona.c
> +++ b/drivers/mmc/host/sdhci-bcm-kona.c
> @@ -316,19 +316,7 @@ err_pltfm_free:
>   
>   static int __exit sdhci_bcm_kona_remove(struct platform_device *pdev)
>   {
> -	struct sdhci_host *host = platform_get_drvdata(pdev);
> -	int dead;
> -	u32 scratch;
> -
> -	dead = 0;
> -	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> -	if (scratch == (u32)-1)
> -		dead = 1;
> -	sdhci_remove_host(host, dead);
> -
> -	sdhci_free_host(host);
> -
> -	return 0;
> +	return sdhci_pltfm_unregister(pdev);
>   }
>   
>   static struct platform_driver sdhci_bcm_kona_driver = {
Acked-by: Christian Daudt <csd@broadcom.com>

  Thanks !
    csd


