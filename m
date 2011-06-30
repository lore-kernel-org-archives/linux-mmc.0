From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv3 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Thu, 30 Jun 2011 16:23:12 -0700
Message-ID: <87d3hudhun.fsf@ti.com>
References: <1309460700-25898-1-git-send-email-balajitk@ti.com>
	<1309460700-25898-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1309460700-25898-3-git-send-email-balajitk@ti.com> (Balaji
	T. K.'s message of "Fri, 1 Jul 2011 00:34:58 +0530")
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com
List-Id: linux-mmc@vger.kernel.org

Balaji T K <balajitk@ti.com> writes:

> add runtime pm support to HSMMC host controller
> Use runtime pm API to enable/disable HSMMC clock
> Use runtime autosuspend APIs to enable auto suspend delay
>
> Based on OMAP HSMMC runtime implementation by Kevin Hilman, Kishore Kadiyala
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Minor nit below...

[...]

> +static int omap_hsmmc_runtime_suspend(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host;
> +
> +	host = platform_get_drvdata(to_platform_device(dev));
> +	omap_hsmmc_context_save(host);
> +	dev_dbg(mmc_dev(host->mmc), "disabled\n");
> +
> +	return 0;
> +}
> +
> +static int omap_hsmmc_runtime_resume(struct device *dev)
> +{
> +	struct omap_hsmmc_host *host;
> +
> +	host = platform_get_drvdata(to_platform_device(dev));
> +	omap_hsmmc_context_restore(host);
> +	dev_dbg(mmc_dev(host->mmc), "host: enabled\n");

Minor: this has a 'host: ' prefix, where as the one in
.runtime_suspend() does not. 

> +
> +	return 0;
> +}
> +

Kevin
