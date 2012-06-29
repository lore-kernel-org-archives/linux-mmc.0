From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: only support voltage (vdd) that regulator agree's with
Date: Fri, 29 Jun 2012 19:19:19 -0400
Message-ID: <87pq8haeq0.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1339183573-21688-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33620 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2F2XT0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jun 2012 19:19:26 -0400
In-Reply-To: <1339183573-21688-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Fri, 8 Jun 2012 12:26:13
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, aaron.lu@amd.com, mark.brown314@gmail.com, Philip Rakity <prakity@marvell.com>

Hi,

On Fri, Jun 08 2012, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> If we are using a regulator the SD Host Controller and the
> regulator should agree about the voltages supported.  Use
> the common subset that is supported.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

This breaks the build when CONFIG_REGULATOR=n -- I've applied what looks
like the correct fix to me:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eae7c3c..caba999 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2832,51 +2832,53 @@ int sdhci_add_host(struct sdhci_host *host)
+#ifdef CONFIG_REGULATOR
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
 	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
 	 * the value is meaningful only if Voltage Support in the Capabilities
 	 * register is set. The actual current value is 4 times the register
 	 * value.
 	 */
 	if (host->vmmc) {
 		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
 			3300000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
 			caps[0] &= ~SDHCI_CAN_VDD_330;
 		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
 			3000000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
 			caps[0] &= ~SDHCI_CAN_VDD_300;
 		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
 			1800000);
 		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
 			caps[0] &= ~SDHCI_CAN_VDD_180;
 	}
+#endif /* CONFIG_REGULATOR */

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
