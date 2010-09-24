From: Peppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH (mmc-next) 1/3] mmc: add suspend/resume in the
 sdhci-pltfm driver
Date: Fri, 24 Sep 2010 07:54:53 +0200
Message-ID: <4C9C3D2D.1090302@st.com>
References: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:53028 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750880Ab0IXFzy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 01:55:54 -0400
In-Reply-To: <1285233266-5039-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Matt Fleming <matt@console-pimps.org>

Hello
I wonder if you could review the three patches I sent the mailing list:
especially the following ones:

mmc: add suspend/resume in the sdhci-pltfm driver
mmc: split the sdhci.h to help platforms that uses shdci-pltfm d.d.

These follow the advice discussed with Wolfram in the thread named:
  "[PATCH] mmc: add SDHCI driver for STM platforms (V2)."

I just noticed to have forgotten to put in cc Andrew and Matt (sorry).

In fact, I want to remove the stm driver and use the pltfm driver
instead of. To do that on my platforms, I need have the support provided
in these patches. This support could actually be useful for others.

Let me know.

Best Regards,
Peppe

On 09/23/2010 11:14 AM, Giuseppe CAVALLARO wrote:
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
> drivers/mmc/host/sdhci-pltfm.c | 22 ++++++++++++++++++++++
> 1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index e045e3c..89ea64b 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -165,6 +165,24 @@ static const struct platform_device_id sdhci_pltfm_ids[] = {
> };
> MODULE_DEVICE_TABLE(platform, sdhci_pltfm_ids);
> 
> +#ifdef CONFIG_PM
> +static int sdhci_pltfm_suspend(struct platform_device *dev, pm_message_t pm)
> +{
> + struct sdhci_host *host = platform_get_drvdata(dev);
> +
> + sdhci_suspend_host(host, pm);
> + return 0;
> +}
> +
> +static int sdhci_pltfm_resume(struct platform_device *dev)
> +{
> + struct sdhci_host *host = platform_get_drvdata(dev);
> +
> + sdhci_resume_host(host);
> + return 0;
> +}
> +#endif
> +
> static struct platform_driver sdhci_pltfm_driver = {
> .driver = {
> .name = "sdhci",
> @@ -173,6 +191,10 @@ static struct platform_driver sdhci_pltfm_driver = {
> .probe = sdhci_pltfm_probe,
> .remove = __devexit_p(sdhci_pltfm_remove),
> .id_table = sdhci_pltfm_ids,
> +#ifdef CONFIG_PM
> + .suspend = sdhci_pltfm_suspend,
> + .resume = sdhci_pltfm_resume,
> +#endif
> };
> 
> /*****************************************************************************\
> --
> 1.5.5.6
> 
