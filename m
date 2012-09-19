From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2 1/5] mmc: host: sdhci-s3c: Add broken-voltage DT property for broken voltage quirk
Date: Wed, 19 Sep 2012 01:42:01 -0400
Message-ID: <m38vc6k1qu.fsf@pullcord.laptop.org>
References: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
	<1346748609-11115-2-git-send-email-t.figa@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57331 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752901Ab2ISFln (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 19 Sep 2012 01:41:43 -0400
In-Reply-To: <1346748609-11115-2-git-send-email-t.figa@samsung.com> (Tomasz
	Figa's message of "Tue, 04 Sep 2012 10:50:05 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kyungmin.park@samsung.com, jy0922.shim@samsung.com, kgene.kim@samsung.com, thomas.abraham@linaro.org, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 04 2012, Tomasz Figa wrote:
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

Is there a reason we can't make this a property on the regulator instead?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
