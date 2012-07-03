From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 2/2] mmc: only support voltage (vdd) that regulator
 agree's with
Date: Tue, 3 Jul 2012 14:06:55 +0800
Message-ID: <20120703060655.GA10350@aarontestpc.amd.com>
References: <prakity@marvell.com>
 <1339183573-21688-1-git-send-email-prakity@marvell.com>
 <87pq8haeq0.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:35492
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754174Ab2GCGHH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jul 2012 02:07:07 -0400
Content-Disposition: inline
In-Reply-To: <87pq8haeq0.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: philipspatches@gmail.com, linux-mmc@vger.kernel.org, mark.brown314@gmail.com, Philip Rakity <prakity@marvell.com>

Hi Chris,

On Fri, Jun 29, 2012 at 07:19:19PM -0400, Chris Ball wrote:
> Hi,
> 
> On Fri, Jun 08 2012, philipspatches@gmail.com wrote:
> > From: Philip Rakity <prakity@marvell.com>
> >
> > If we are using a regulator the SD Host Controller and the
> > regulator should agree about the voltages supported.  Use
> > the common subset that is supported.
> >
> > Signed-off-by: Philip Rakity <prakity@marvell.com>
> 
> This breaks the build when CONFIG_REGULATOR=n -- I've applied what looks
> like the correct fix to me:
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index eae7c3c..caba999 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2832,51 +2832,53 @@ int sdhci_add_host(struct sdhci_host *host)
> +#ifdef CONFIG_REGULATOR
>  	/*
>  	 * According to SD Host Controller spec v3.00, if the Host System
>  	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
>  	 * the value is meaningful only if Voltage Support in the Capabilities
>  	 * register is set. The actual current value is 4 times the register
>  	 * value.
>  	 */
The above comments does not belong to regulator code, it should be
placed on top of the max_current_caps variable like this:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index caba999..f76736b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2845,13 +2845,6 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 #ifdef CONFIG_REGULATOR
-	/*
-	 * According to SD Host Controller spec v3.00, if the Host System
-	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
-	 * the value is meaningful only if Voltage Support in the Capabilities
-	 * register is set. The actual current value is 4 times the register
-	 * value.
-	 */
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
 			3300000);
@@ -2868,6 +2861,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 #endif /* CONFIG_REGULATOR */
 
+	/*
+	 * According to SD Host Controller spec v3.00, if the Host System
+	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
+	 * the value is meaningful only if Voltage Support in the Capabilities
+	 * register is set. The actual current value is 4 times the register
+	 * value.
+	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
 	if (!max_current_caps && host->vmmc) {
 		u32 curr = regulator_get_current_limit(host->vmmc);

Thanks,
Aaron

>  	if (host->vmmc) {
>  		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
>  			3300000);
>  		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
>  			caps[0] &= ~SDHCI_CAN_VDD_330;
>  		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
>  			3000000);
>  		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
>  			caps[0] &= ~SDHCI_CAN_VDD_300;
>  		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
>  			1800000);
>  		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
>  			caps[0] &= ~SDHCI_CAN_VDD_180;
>  	}
> +#endif /* CONFIG_REGULATOR */
> 
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

