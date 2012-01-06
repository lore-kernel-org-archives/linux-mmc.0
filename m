From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 3/5 v3] ESDHC: Power management for ESDHC
Date: Fri, 6 Jan 2012 03:31:06 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11661240@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1324958792-16742-1-git-send-email-r66093@freescale.com>
	<m2lipppscs.fsf@bob.laptop.org> <20120103015453.GA3767@pengutronix.de>
 <m2fwfxo7pu.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:43497
	"EHLO VA3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755403Ab2AFDbL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Jan 2012 22:31:11 -0500
In-Reply-To: <m2fwfxo7pu.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jiang Yutang-B14898 <B14898@freescale.com>

And I have one question,
This group patches has five, and this version will only include 3/5, 4/5, 5/5.
Can I repost the 1/5 and 2/5? These two patches has no changes.

> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, January 03, 2012 10:12 AM
> To: Wolfram Sang
> Cc: Huang Changming-R66093; linux-mmc@vger.kernel.org; Huang Changming-
> R66093; Jiang Yutang-B14898
> Subject: Re: [PATCH 3/5 v3] ESDHC: Power management for ESDHC
> 
> Hi,
> 
> On Mon, Jan 02 2012, Wolfram Sang wrote:
> >> Wolfram, do you have time to look at this?  Looks like we need to
> expose
> >> suspend/resume hooks to -pltfm users for this use case -- I don't
> think
> >> any esdhc code should be in sdhci-pltfm.c.  (I don't mind writing the
> >> patch if you agree that that's the correct solution here.)
> >
> > I won't have time to look at it, but what you say sounds reasonable to
> me.
> 
> Thanks, Wolfram.  Jerry, does this patch give you the hook you need to
> handle this inside the driver instead of sdhci/sdhci-pltfm?
> 
> From: Chris Ball <cjb@laptop.org>
> Subject: [PATCH] mmc: sdhci: Add platform suspend/resume hooks.
> 
> Some platforms require saving/restoring registers across suspend/resume;
> this hook allows them to do that inside their driver.
> 
> Signed-off-by: Chris Ball <cjb@laptop.org>
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 384adda..3425c9a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2351,6 +2351,9 @@ int sdhci_suspend_host(struct sdhci_host *host)
>  {
>  	int ret;
> 
> +	if (host->ops->platform_suspend)
> +		host->ops->platform_suspend(host);
> +
>  	sdhci_disable_card_detection(host);
> 
>  	/* Disable tuning since we are suspending */
> @@ -2391,6 +2394,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>  	ret = mmc_resume_host(host->mmc);
>  	sdhci_enable_card_detection(host);
> 
> +	if (host->ops->platform_resume)
> +		host->ops->platform_resume(host);
> +
>  	/* Set the re-tuning expiration flag */
>  	if ((host->version >= SDHCI_SPEC_300) && host->tuning_count &&
>  	    (host->tuning_mode == SDHCI_TUNING_MODE_1))
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index a04d4d0..ae05a80 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -274,6 +274,8 @@ struct sdhci_ops {
>  	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
>  	int	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int
> uhs);
>  	void	(*hw_reset)(struct sdhci_host *host);
> +	void	(*platform_suspend)(struct sdhci_host *host);
> +	void	(*platform_resume)(struct sdhci_host *host);
>  };
> 
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


