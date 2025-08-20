Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0B1F91C8;
	Wed, 20 Aug 2025 19:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.64.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718243; cv=none; b=YYnDAdKPQ5x2sTBpUoN1FpWHoo7RGVEntSIJapWxYHfkKIFpsuW1FyacSUgvZuRb7PHsro5MAwNKKm0Eb5kIbbH9rd4r72iTgAgI2cXz4VbWJTljKtjp9OE13tZWlc3yHadV17hhJq7DCFRk6zs4J8REaKwqRzcs36Xtftphc9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718243; c=relaxed/simple;
	bh=pQU/6XxX3lQh65+djipRIT43r4IzL9AGpiB4R9ey11k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1N2ERdMN2wD/EXmzfPjs5ABBT7Cfqy8Nsehd8YG72NHeItanD3AKpYVqD8YvtZ2uzal/hTE6x2XKFqTK92BHjXErprMIyqn+RcgpGchI344vogi0K1Jkv4dU34cMZ4H54eGNKYrfT7r6+xF+pnw2DdSb33TzNMOOBaT3btsxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl; spf=pass smtp.mailfrom=rere.qmqm.pl; dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b=P+INdoQE; arc=none smtp.client-ip=91.227.64.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rere.qmqm.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="P+INdoQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
	t=1755717711; bh=pQU/6XxX3lQh65+djipRIT43r4IzL9AGpiB4R9ey11k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+INdoQEfOpWX6hDuSz2wTSn/wFroLwFcYgXJxFayWsKndEtXE1ad7bmgTVq/gbOp
	 m49CCAPFRMtCPX2cmqi7DDQBJv5kGnkRBnV1BVE8n7m+rfaEKAWbf27rK2GoZD6/yo
	 p2Hd/zFDeTgwAnoaszU0i2AqyFqjLox9CkSkFw8Y/auxXw2B/6o/jEfi0TjdBdoWD0
	 GEW+Ruo+eOWG9UeXQrfRVBD7qaG2bIsjnqrVBMBpXjTpq4e2lxXH6wYdtDk8zT44SI
	 3lSS8apZLrJ1GIoS5SrILmobYSls1QAAHUEfuuI/6yvbrqb5S9RUEzxz92BluDKWb/
	 eRAwUMfs5yQAQ==
Received: from remote.user (localhost [127.0.0.1])
	by rere.qmqm.pl (Postfix) with ESMTPSA id 4c6bt33Rsgz1H;
	Wed, 20 Aug 2025 21:21:47 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 1.0.7 at mail
Date: Wed, 20 Aug 2025 21:21:46 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/38] mmc: cb710-mmc: use modern PM macros
Message-ID: <aKYgSkOc1U5Dio8w@qmqm.qmqm.pl>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-10-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250815013413.28641-10-jszhang@kernel.org>

On Fri, Aug 15, 2025 at 09:33:44AM +0800, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> At the same time, replace the platform_driver's .suspend and .resume
> usage with modern device_driver's .pm usage.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/cb710-mmc.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
> index 448d2f9159ea..31daec787495 100644
> --- a/drivers/mmc/host/cb710-mmc.c
> +++ b/drivers/mmc/host/cb710-mmc.c
> @@ -664,25 +664,25 @@ static const struct mmc_host_ops cb710_mmc_host = {
>  	.get_cd = cb710_mmc_get_cd,
>  };
>  
> -#ifdef CONFIG_PM
> -
> -static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_t state)
> +static int cb710_mmc_suspend(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>  
>  	cb710_mmc_enable_irq(slot, 0, ~0);
>  	return 0;
>  }
>  
> -static int cb710_mmc_resume(struct platform_device *pdev)
> +static int cb710_mmc_resume(struct device *dev)
>  {
> +	struct platform_device *pdev = to_platform_device(dev);
>  	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
>  
>  	cb710_mmc_enable_irq(slot, 0, ~0);
>  	return 0;
>  }
>  
> -#endif /* CONFIG_PM */
> +static DEFINE_SIMPLE_DEV_PM_OPS(cb710_mmc_pmops, cb710_mmc_suspend, cb710_mmc_resume);
>  
>  static int cb710_mmc_init(struct platform_device *pdev)
>  {
> @@ -767,13 +767,12 @@ static void cb710_mmc_exit(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver cb710_mmc_driver = {
> -	.driver.name = "cb710-mmc",
> +	.driver = {
> +		.name = "cb710-mmc",
> +		.pm = pm_sleep_ptr(&cb710_mmc_pmops),
> +	},
>  	.probe = cb710_mmc_init,
>  	.remove = cb710_mmc_exit,
> -#ifdef CONFIG_PM
> -	.suspend = cb710_mmc_suspend,
> -	.resume = cb710_mmc_resume,
> -#endif
>  };
>  
>  module_platform_driver(cb710_mmc_driver);
> -- 
> 2.50.0
> 

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
