From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2, 2/3] mmc: sdhci-of-esdhc: get SOC version and revision
 from GUTS_SVR
Date: Tue, 1 Sep 2015 19:23:42 -0500
Message-ID: <1441153422.4966.105.camel@freescale.com>
References: <1440667742-25424-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1on0138.outbound.protection.outlook.com ([157.56.110.138]:39781
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750889AbbIBAXw (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 1 Sep 2015 20:23:52 -0400
In-Reply-To: <1440667742-25424-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org

On Thu, 2015-08-27 at 17:29 +0800, Yangbo Lu wrote:
> @@ -24,6 +25,16 @@
>  
>  #define VENDOR_V_22  0x12
>  #define VENDOR_V_23  0x13
> +
> +/* Global Utility Registers */
> +#define GUTS_SVR             0xa4    /* System Version Register */
> +/* SOC version definition */
> +#define SVR_T4240            0x824000

Please do not redefine this stuff in each driver that needs to reference it.

-Scott

