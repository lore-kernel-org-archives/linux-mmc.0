From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT
 property for broken voltage quirk
Date: Wed, 05 Sep 2012 17:36:52 +0900
Message-ID: <50470F24.1010506@samsung.com>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
 <1346748609-11115-2-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35167 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab2IEIg7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Sep 2012 04:36:59 -0400
In-reply-to: <1346748609-11115-2-git-send-email-t.figa@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 09/04/2012 05:50 PM, Tomasz Figa wrote:
> Some boards use fixed voltage regulator for vmmc supply (e.g. for eMMC
> memories). MMC_CAP2_BROKEN_VOLTAGE must be enabled for them to operate
> correctly.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Chris Ball <cjb@laptop.org>
> CC: linux-mmc@vger.kernel.org
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc.txt | 1 +
>  drivers/mmc/host/sdhci-s3c.c                  | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> index 8a6811f..ecbde68 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
> @@ -16,6 +16,7 @@ Optional properties:
>  - wp-inverted: when present, polarity on the wp gpio line is inverted
>  - non-removable: non-removable slot (like eMMC)
>  - max-frequency: maximum operating clock frequency
> +- broken-voltage: vmmc regulator does not allow voltage control
>  
>  Example:
>  
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 445910e..39715b8 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -443,6 +443,9 @@ static int __devinit sdhci_s3c_parse_dt(struct device *dev,
>  	if (!ourhost->gpios)
>  		return -ENOMEM;
>  
> +	if (of_get_property(node, "broken-voltage", 0))
> +		pdata->host_caps2 |= MMC_CAP2_BROKEN_VOLTAGE;
> +
>  	/* get the card detection method */
>  	if (of_get_property(node, "broken-cd", 0)) {
>  		pdata->cd_type = S3C_SDHCI_CD_NONE;
> 

