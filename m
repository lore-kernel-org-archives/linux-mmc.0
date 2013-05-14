From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH V2 05/10] mmc: sdhi-pxav3: handle mmc_of_parse() errors
 during probe
Date: Tue, 14 May 2013 08:38:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1305140837540.32151@axis700.grange>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
 <1368479941-10084-6-git-send-email-gmbnomis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1368479941-10084-6-git-send-email-gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

There's a typo in the subject line - it's sdhci, not sdhi :)

Thanks
Guennadi

On Mon, 13 May 2013, Simon Baatz wrote:

> 
> Signed-off-by: Simon Baatz <gmbnomis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mmc/host/sdhci-pxav3.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 1ae358e..67ea388 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -252,7 +252,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	match = of_match_device(of_match_ptr(sdhci_pxav3_of_match), &pdev->dev);
>  	if (match) {
> -		mmc_of_parse(host->mmc);
> +		ret = mmc_of_parse(host->mmc);
> +		if (ret)
> +			goto err_of_parse;
>  		sdhci_get_of_property(pdev);
>  		pdata = pxav3_get_mmc_pdata(dev);
>  	} else if (pdata) {
> @@ -313,10 +315,11 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> +err_of_parse:
> +err_cd_req:
>  err_add_host:
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
> -err_cd_req:
>  err_clk_get:
>  	sdhci_pltfm_free(pdev);
>  	kfree(pxa);
> -- 
> 1.7.9.5
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
