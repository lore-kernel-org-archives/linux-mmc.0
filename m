Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8003176F0;
	Sat, 16 Aug 2025 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755325267; cv=none; b=kwLruQLcqsYJOPbYC3BvM3EnZKxKP7XQgy/YSzaFhkYmK0M3Og7NkhbuV1ILY4klOX7MAktdGQopkDpkC33MJ01R7kdJQrm3l6vSZtb8LBAlKH4zR+sZ0WEJdtcUQOeu3Iyzef4vlwRpIPPdpbu/efzcFBYt7luuJN/eI8XDNd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755325267; c=relaxed/simple;
	bh=E6rmIOI7RTVHu4KWYJztJfgD4VXoH0nCUqR1F2Kpcf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRULmQfgXJypMbzbua+QA5eENq57MwBRlf6riMXb6U/4dJSOmv8e1PScJyFmhihpHy0JGABtIJl2/VKhIGYPv7dBr9XOP2jdxeq4Avhi82jcEaA5ZFdCyGBe7Z6ciNZfS88FYxdjuOGFkePoqwlLokjx5BsI413EyfpKEynodqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQOd5wrI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQOd5wrI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95428C4CEEF;
	Sat, 16 Aug 2025 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755325267;
	bh=E6rmIOI7RTVHu4KWYJztJfgD4VXoH0nCUqR1F2Kpcf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQOd5wrIlmd+0I4ODsdNmga5yxbcRhIT1qQrN49ZG6QiJy4Sll7UTNZzbMUoT/kla
	 lsTHfNNDR7G5MhXZ8veTKWt4NcpN0qaE4FCR2xL9MrBgINvS/6bBJEpx28HdMwONng
	 EE/Ctw2p6MHqG7jEuvwIBUiGxM+qdhI6fF3gn8/zt1ugiEsnEpJ1xihzO/FvljuJ4e
	 6g2k5/9X1iNIlTohy7SrqOvg/jacBsXwaTJCFRZOCb1QtdaHkK/fFAqcS83QX4o7YF
	 IPlyREOSBsCnvyN0otVbieFOQUCpNdKtzSfFQVumitxpfL+fBeWliVuY/SBFlsQQ8k
	 jkX3iG6AH0GEg==
Date: Sat, 16 Aug 2025 14:03:48 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHvv73vv70gTWlyb3Pvv73vv71hdw==?= <mirq-linux@rere.qmqm.pl>,
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
	Alexey Charkov <alchark@gmail.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Message-ID: <aKAfRFPJQM_EtAKF@xhacker>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-19-jszhang@kernel.org>
 <DU0PR04MB94962993C99F922CCF93FB6F9034A@DU0PR04MB9496.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB94962993C99F922CCF93FB6F9034A@DU0PR04MB9496.eurprd04.prod.outlook.com>

On Fri, Aug 15, 2025 at 03:23:56AM +0000, Bough Chen wrote:
> > -----Original Message-----
> > From: Jisheng Zhang <jszhang@kernel.org>
> > Sent: 2025Ò´8êÅ15ìí 9:34
> > To: Ulf Hansson <ulf.hansson@linaro.org>; Aubin Constans
> > <aubin.constans@microchip.com>; Nicolas Ferre
> > <nicolas.ferre@microchip.com>; Alexandre Belloni
> > <alexandre.belloni@bootlin.com>; Claudiu Beznea
> > <claudiu.beznea@tuxon.dev>; Manuel Lauss <manuel.lauss@gmail.com>;
> > Micha©© Miros©©aw <mirq-linux@rere.qmqm.pl>; Jaehoon Chung
> > <jh80.chung@samsung.com>; Krzysztof Kozlowski <krzk@kernel.org>; Alim
> > Akhtar <alim.akhtar@samsung.com>; Heiko Stuebner <heiko@sntech.de>;
> > Russell King <linux@armlinux.org.uk>; Chaotian Jing
> > <chaotian.jing@mediatek.com>; Matthias Brugger <matthias.bgg@gmail.com>;
> > AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>;
> > Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; Adrian Hunter <adrian.hunter@intel.com>; Kamal
> > Dasu <kamal.dasu@broadcom.com>; Al Cooper <alcooperx@gmail.com>;
> > Broadcom internal kernel review list
> > <bcm-kernel-feedback-list@broadcom.com>; Florian Fainelli
> > <florian.fainelli@broadcom.com>; Bough Chen <haibo.chen@nxp.com>; Michal
> > Simek <michal.simek@amd.com>; Eugen Hristev <eugen.hristev@linaro.org>;
> > Vignesh Raghavendra <vigneshr@ti.com>; Ben Dooks <ben-linux@fluff.org>;
> > Viresh Kumar <vireshk@kernel.org>; Orson Zhai <orsonzhai@gmail.com>;
> > Baolin Wang <baolin.wang@linux.alibaba.com>; Chunyan Zhang
> > <zhang.lyra@gmail.com>; Patrice Chotard <patrice.chotard@foss.st.com>;
> > Thierry Reding <thierry.reding@gmail.com>; Jonathan Hunter
> > <jonathanh@nvidia.com>; Chen-Yu Tsai <wens@csie.org>; Jernej Skrabec
> > <jernej.skrabec@gmail.com>; Samuel Holland <samuel@sholland.org>; Alexey
> > Charkov <alchark@gmail.com>
> > Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
> > 
> > Use the modern PM macros for the suspend and resume functions to be
> > automatically dropped by the compiler when CONFIG_PM or
> > CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> > 
> > This has the advantage of always compiling these functions in, independently of
> > any Kconfig option. Thanks to that, bugs and other regressions are subsequently
> > easier to catch.
> 
> Hi Jisheng,

Hi,

> 
> When I remove all the configs under Power management options I got the following build warning:
> 
> drivers/mmc/host/sdhci-esdhc-imx.c:2079:12: warning: ¡®sdhci_esdhc_resume¡¯ defined but not used [-Wunused-function]
>  2079 | static int sdhci_esdhc_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~
>   CC      drivers/mmc/host/cqhci-core.o
> drivers/mmc/host/sdhci-esdhc-imx.c:2017:12: warning: ¡®sdhci_esdhc_suspend¡¯ defined but not used [-Wunused-function]
>  2017 | static int sdhci_esdhc_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~

Hmm interesting, what's test toolchain? I tested this patch with gcc14
with below three combinations before sending out, no warnings at all:
PM + PM_SLEEP
PM only
!PM + ! PM_SLEEP

The sdhci_esdhc_suspend|resume are referenced by SYSTEM_SLEEP_PM_OPS.
The pm_sleep_ptr() macro does the tricky, when both PM and PM_SLEEP are
disabled, they are optimized out.

So can you plz kindly show your toolchain? I will check

Thanks
> 
> Regards
> Haibo Chen
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++----------
> >  1 file changed, 3 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index a040c0896a7b..a7a5df673b0f 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -1650,7 +1650,6 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host
> > *host)
> >  	}
> >  }
> > 
> > -#ifdef CONFIG_PM_SLEEP
> >  static void sdhc_esdhc_tuning_save(struct sdhci_host *host)  {
> >  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@ -1707,7
> > +1706,6 @@ static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
> >  		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
> >  	}
> >  }
> > -#endif
> > 
> >  static void esdhc_cqe_enable(struct mmc_host *mmc)  { @@ -2016,7
> > +2014,6 @@ static void sdhci_esdhc_imx_remove(struct platform_device
> > *pdev)
> >  		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
> >  }
> > 
> > -#ifdef CONFIG_PM_SLEEP
> >  static int sdhci_esdhc_suspend(struct device *dev)  {
> >  	struct sdhci_host *host = dev_get_drvdata(dev); @@ -2112,9 +2109,7 @@
> > static int sdhci_esdhc_resume(struct device *dev)
> > 
> >  	return ret;
> >  }
> > -#endif
> > 
> > -#ifdef CONFIG_PM
> >  static int sdhci_esdhc_runtime_suspend(struct device *dev)  {
> >  	struct sdhci_host *host = dev_get_drvdata(dev); @@ -2188,12 +2183,10
> > @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
> >  		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
> >  	return err;
> >  }
> > -#endif
> > 
> >  static const struct dev_pm_ops sdhci_esdhc_pmops = {
> > -	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> > -	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> > -				sdhci_esdhc_runtime_resume, NULL)
> > +	SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
> > +	RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
> > +sdhci_esdhc_runtime_resume, NULL)
> >  };
> > 
> >  static struct platform_driver sdhci_esdhc_imx_driver = { @@ -2201,7 +2194,7
> > @@ static struct platform_driver sdhci_esdhc_imx_driver = {
> >  		.name	= "sdhci-esdhc-imx",
> >  		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >  		.of_match_table = imx_esdhc_dt_ids,
> > -		.pm	= &sdhci_esdhc_pmops,
> > +		.pm	= pm_ptr(&sdhci_esdhc_pmops),
> >  	},
> >  	.probe		= sdhci_esdhc_imx_probe,
> >  	.remove		= sdhci_esdhc_imx_remove,
> > --
> > 2.50.0
> 
