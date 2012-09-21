From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Fri, 21 Sep 2012 12:08:49 -0400
Message-ID: <m3y5k3e4tq.fsf@pullcord.laptop.org>
References: <1348223135-6435-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36564 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2IUQIj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Sep 2012 12:08:39 -0400
In-Reply-To: <1348223135-6435-1-git-send-email-r66093@freescale.com>
	(r66093@freescale.com's message of "Fri, 21 Sep 2012 18:25:35 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Shaohui Xie <Shaohui.Xie@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Kumar Gala <galak@kernel.crashing.org>

Hi,

On Fri, Sep 21 2012, r66093@freescale.com wrote:
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -143,6 +143,35 @@ static void esdhc_of_resume(struct sdhci_host *host)
>  }
>  #endif
>  
> +static const u32 non_cmd23_processor_table[] = {
> +	/* P1020 Dual/Single core */
> +	0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
> +	/* P1021 Dual/Single core */
> +	0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
> +	/* P1022 Dual/Single core */
> +	0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
> +	/* P1024 Dual/Single core */
> +	0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
> +	/* P1025 Dual/Single core */
> +	0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
> +	/* P4080 and P4040 */
> +	0x820000, 0x820800, 0x820100, 0x820900

I don't see how this method improves on either of the previous two we've
discussed.  If anything, Kumar's suggested method seems better than this
one:  it detected the MMC IP revision, which I'd expect to be more
reliable than building a list of which SoCs contain that IP.

Why is this better than using DT or detecting the MMC revision?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
