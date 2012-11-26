From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: sdhci-spear: Initialize sdhci clk to 50 MHz
Date: Mon, 26 Nov 2012 10:44:41 -0500
Message-ID: <87k3t89xna.fsf@octavius.laptop.org>
References: <fd576f198e6f3dc4031bb905247ed9c0a0b66a20.1352387305.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50257 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304Ab2KZPos (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 Nov 2012 10:44:48 -0500
In-Reply-To: <fd576f198e6f3dc4031bb905247ed9c0a0b66a20.1352387305.git.viresh.kumar@linaro.org>
	(Viresh Kumar's message of "Thu, 8 Nov 2012 20:39:09 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, spear-devel@list.st.com, Vipul Kumar Samar <vipulkumar.samar@st.com>

Hi,

On Thu, Nov 08 2012, Viresh Kumar wrote:
> From: Vipul Kumar Samar <vipulkumar.samar@st.com>
>
> SPEAr sdhci driver expects the clock to be set to 50 MHz for proper functioning.
> This patch sets clk to 50 MHz in probe.
>
> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/mmc/host/sdhci-spear.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
> index 6be89c0..fea8bf9 100644
> --- a/drivers/mmc/host/sdhci-spear.c
> +++ b/drivers/mmc/host/sdhci-spear.c
> @@ -146,6 +146,11 @@ static int __devinit sdhci_probe(struct platform_device *pdev)
>  		goto put_clk;
>  	}
>  
> +	ret = clk_set_rate(sdhci->clk, 50000000);
> +	if (ret)
> +		dev_dbg(&pdev->dev, "Error setting desired clk, clk=%lu\n",
> +				clk_get_rate(sdhci->clk));
> +
>  	if (np) {
>  		sdhci->data = sdhci_probe_config_dt(pdev);
>  		if (IS_ERR(sdhci->data)) {

Thanks, pushed to mmc-next for 3.8.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
