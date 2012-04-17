From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: sdhci-spear: Add clk_{un}prepare() support
Date: Tue, 17 Apr 2012 16:32:53 +0530
Message-ID: <006f01cd1c89$a52f7320$ef8e5960$@codeaurora.org>
References: <f0a8be5938e41e3c9dc6ab07fffe03900885ca7f.1334655823.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:42531 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab2DQLC6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Apr 2012 07:02:58 -0400
In-Reply-To: <f0a8be5938e41e3c9dc6ab07fffe03900885ca7f.1334655823.git.viresh.kumar@st.com>
Content-language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Viresh Kumar' <viresh.kumar@st.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, spear-devel@list.st.com, viresh.linux@gmail.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Viresh Kumar
> Sent: Tuesday, April 17, 2012 3:14 PM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; spear-devel@list.st.com;
> viresh.linux@gmail.com; Viresh Kumar
> Subject: [PATCH] mmc: sdhci-spear: Add clk_{un}prepare() support
> 
> clk_{un}prepare is mandatory for platforms using common clock framework.
> Since this driver is used by SPEAr platform, which supports common clock
> framework, add clk_{un}prepare() support for it.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> ---
>  drivers/mmc/host/sdhci-spear.c |   22 ++++++++++++++++++++--
>  1 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-spear.c
b/drivers/mmc/host/sdhci-spear.c
> index 62c9730..78ca787 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -154,10 +154,16 @@ static int __devinit sdhci_probe(struct
> platform_device *pdev)
>  		goto err;
>  	}
> 
> +	ret = clk_prepare(sdhci->clk);


It's better to use clk_prepare_enable() helper function if you are doing
enable immediately after prepare.

> +	if (ret) {
> +		dev_dbg(&pdev->dev, "Error preparing clock\n");
> +		goto put_clk;
> +	}
> +
>  	ret = clk_enable(sdhci->clk);
>  	if (ret) {
>  		dev_dbg(&pdev->dev, "Error enabling clock\n");
> -		goto put_clk;
> +		goto unprepare_clk;
>  	}
> 
>  	if (np) {
> @@ -275,6 +281,8 @@ free_host:
>  	sdhci_free_host(host);
>  disable_clk:
>  	clk_disable(sdhci->clk);
> +unprepare_clk:
> +	clk_unprepare(sdhci->clk);
>  put_clk:
>  	clk_put(sdhci->clk);
>  err:
> @@ -297,6 +305,7 @@ static int __devexit sdhci_remove(struct
> platform_device *pdev)
>  	sdhci_remove_host(host, dead);
>  	sdhci_free_host(host);
>  	clk_disable(sdhci->clk);
> +	clk_unprepare(sdhci->clk);
>  	clk_put(sdhci->clk);
> 
>  	return 0;
> @@ -310,8 +319,10 @@ static int sdhci_suspend(struct device *dev)
>  	int ret;
> 
>  	ret = sdhci_suspend_host(host);
> -	if (!ret)
> +	if (!ret) {
>  		clk_disable(sdhci->clk);
> +		clk_unprepare(sdhci->clk);

clk_disable_unprepare() helper function can be used.

> +	}
> 
>  	return ret;
>  }
> @@ -322,9 +333,16 @@ static int sdhci_resume(struct device *dev)
>  	struct spear_sdhci *sdhci = dev_get_platdata(dev);
>  	int ret;
> 
> +	ret = clk_prepare(sdhci->clk);
> +	if (ret) {
> +		dev_dbg(dev, "Error preparing clock\n");
> +		return ret;
> +	}
> +
>  	ret = clk_enable(sdhci->clk);
>  	if (ret) {
>  		dev_dbg(dev, "Resume: Error enabling clock\n");
> +		clk_unprepare(sdhci->clk);
>  		return ret;
>  	}
> 
> --
> 1.7.9
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body
> of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

