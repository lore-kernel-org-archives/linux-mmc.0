From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v3 3/5] OMAP4: hwmod data: enable HSMMC
Date: Thu, 24 Feb 2011 11:21:11 +0100
Message-ID: <4D663117.5080605@ti.com>
References: <1298483231-29622-1-git-send-email-kishore.kadiyala@ti.com> <1298483231-29622-4-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43553 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1BXKVT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 24 Feb 2011 05:21:19 -0500
In-Reply-To: <1298483231-29622-4-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "cjb@laptop.org" <cjb@laptop.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Gadiyar, Anand" <gadiyar@ti.com>

On 2/23/2011 6:47 PM, Kadiyala, Kishore wrote:
> From: Anand Gadiyar<gadiyar@ti.com>
>
> Enabling hsmmc hwmod for OMAP4
>
> Signed-off-by: Anand Gadiyar<gadiyar@ti.com>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> Cc: Benoit Cousson<b-cousson@ti.com>
> Cc: Paul Walmsley<paul@pwsan.com>
> CC: Kevin Hilman<khilman@deeprootsystems.com>

Acked-by: Benoit Cousson<b-cousson@ti.com>

> ---
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   10 +++++-----
>   1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 79a8601..dd39e75 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -5077,11 +5077,11 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>   	&omap44xx_mcspi4_hwmod,
>
>   	/* mmc class */
> -/*	&omap44xx_mmc1_hwmod, */
> -/*	&omap44xx_mmc2_hwmod, */
> -/*	&omap44xx_mmc3_hwmod, */
> -/*	&omap44xx_mmc4_hwmod, */
> -/*	&omap44xx_mmc5_hwmod, */
> +	&omap44xx_mmc1_hwmod,
> +	&omap44xx_mmc2_hwmod,
> +	&omap44xx_mmc3_hwmod,
> +	&omap44xx_mmc4_hwmod,
> +	&omap44xx_mmc5_hwmod,
>
>   	/* mpu class */
>   	&omap44xx_mpu_hwmod,

