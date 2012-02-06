From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 2/2]  mmc: sdhci-s3c: add platform data for the second capability
Date: Mon, 06 Feb 2012 06:19:33 -0500
Message-ID: <m239ao5hve.fsf@bob.laptop.org>
References: <4F2F86DA.6030106@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <4F2F86DA.6030106@samsung.com> (Jaehoon Chung's message of "Mon,
	06 Feb 2012 16:52:58 +0900")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, 'kgene kim' <kgene.kim@samsung.com>, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Feb 06 2012, Jaehoon Chung wrote:
> This patch is added host_caps2 in sdhci-s3c.c
> It's necessary that use the second capabilities.
> And removed the duplicated host_caps.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> Changelog v3:
> 	- based-on latest mmc-next tree
> Changelog v2:
> 	- remove the duplicated host_caps.
>
>  drivers/mmc/host/sdhci-s3c.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index d065e37..46b9782 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -521,9 +521,6 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
>  		host->mmc->caps = MMC_CAP_NONREMOVABLE;
>  
> -	if (pdata->host_caps)
> -		host->mmc->caps |= pdata->host_caps;
> -
>  	if (pdata->pm_caps)
>  		host->mmc->pm_caps |= pdata->pm_caps;
>  
> @@ -547,6 +544,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
>  	if (pdata->host_caps)
>  		host->mmc->caps |= pdata->host_caps;
>  
> +	if (pdata->host_caps2)
> +		host->mmc->caps2 |= pdata->host_caps2;
> +
>  	ret = sdhci_add_host(host);
>  	if (ret) {
>  		dev_err(dev, "sdhci_add_host() failed\n");

In case you'd rather merge both of these via the samsung-soc tree:

Acked-by: Chris Ball <cjb@laptop.org>

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
