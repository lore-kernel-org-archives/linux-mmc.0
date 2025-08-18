Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FA52FF676;
	Mon, 18 Aug 2025 08:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755507234; cv=none; b=qhoTPq/SiZGkRywIg//mBhGBUL21sEKAGe4r2crWKlb4IeDmXORAWH+m2T/YFduVSLszNrwRraWS+l35c6fVkZ/I4Iyqa9RNG5xFrSdLxKvXE+GibrRQbFlZVZt3QIl1HUTD5Bs5A6DqlscUXr+6OBStVLda89mEzWNtwVG+B3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755507234; c=relaxed/simple;
	bh=MtKHVTRgAjbDyX8G+Zck3VIj7UUL290UxStBgxla5g4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RlLr+1E1olCIBnTqrGF/gAshCtbw3AfaoENNc8MiKTTsYGx192wyDCq4Cd5M85K0PbqLzgArubGKYF9vwZIg3xfCFpEfgaVmQPmd4DVU7sO12rewecRTYEsBPL2pHdikLcHhCVNRvBlYsDeYOY0zC+D/slmCVu7g3o5KUwVzsI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DgwNCSNz; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DgwNCSNz"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8CiOp007548;
	Mon, 18 Aug 2025 10:52:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	QcYJ3ZllQHKrlOVK3ksRdOd0b+QUjL79qHjWMDwhUsI=; b=DgwNCSNzbyaN8heo
	UU0xEchAk1DxJIRpl0CzfVISfbQtCSubvQveObKKpQ39+zrGh2SzAA83ma4r4Bzu
	sg8CW/A0C9ETidDc/OYRkgZCDRQ2kdvaqGmu3dsbfXJCTylmllfFUMZcowUUmLoG
	wXmEYOjEX7qPoJU+VgYsSnJcdC2hIXCndPDws8D10b2VIjXZ/XXoSRN5LmByqdoM
	KeVCQF0jwydnIBhqWMkVrh3gvo7ONl6tcF2hk27BOWPvG93yve1xDVMYyE0iiEqt
	JNJkMJN8zCo5keUJ5Wq2zMvJis4Hi+JSRT7Qhg6DRV/J8anfWb0ujr+sOz70o7Y5
	FWPHSw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48jhb1nqkk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Aug 2025 10:52:31 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 17ABB400AA;
	Mon, 18 Aug 2025 10:49:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 08E79715825;
	Mon, 18 Aug 2025 10:49:25 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 10:49:22 +0200
Message-ID: <5fa9ef87-0184-427b-8d64-aae2715d1663@foss.st.com>
Date: Mon, 18 Aug 2025 10:49:21 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/38] mmc: sdhci-st: use modern PM macros
To: Jisheng Zhang <jszhang@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Aubin Constans <aubin.constans@microchip.com>,
        Nicolas Ferre
	<nicolas.ferre@microchip.com>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?=
	<mirq-linux@rere.qmqm.pl>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        "Krzysztof
 Kozlowski" <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "Heiko
 Stuebner" <heiko@sntech.de>,
        Russell King <linux@armlinux.org.uk>,
        "Chaotian
 Jing" <chaotian.jing@mediatek.com>,
        Matthias Brugger
	<matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team"
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>,
        Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper
	<alcooperx@gmail.com>,
        "Broadcom internal kernel review list"
	<bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Michal
 Simek" <michal.simek@amd.com>,
        Eugen Hristev <eugen.hristev@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Ben Dooks <ben-linux@fluff.org>,
        Viresh Kumar <vireshk@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        "Baolin
 Wang" <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter
	<jonathanh@nvidia.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec
	<jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "Alexey
 Charkov" <alchark@gmail.com>
CC: <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-28-jszhang@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250815013413.28641-28-jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_03,2025-08-14_01,2025-03-28_01



On 8/15/25 03:34, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/sdhci-st.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

> 
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 9157342ff7a4..bf6685805137 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -445,7 +445,6 @@ static void sdhci_st_remove(struct platform_device *pdev)
>  	reset_control_assert(rstc);
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int sdhci_st_suspend(struct device *dev)
>  {
>  	struct sdhci_host *host = dev_get_drvdata(dev);
> @@ -492,9 +491,8 @@ static int sdhci_st_resume(struct device *dev)
>  
>  	return sdhci_resume_host(host);
>  }
> -#endif
>  
> -static SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
>  
>  static const struct of_device_id st_sdhci_match[] = {
>  	{ .compatible = "st,sdhci" },
> @@ -509,7 +507,7 @@ static struct platform_driver sdhci_st_driver = {
>  	.driver = {
>  		   .name = "sdhci-st",
>  		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> -		   .pm = &sdhci_st_pmops,
> +		   .pm = pm_sleep_ptr(&sdhci_st_pmops),
>  		   .of_match_table = st_sdhci_match,
>  		  },
>  };
