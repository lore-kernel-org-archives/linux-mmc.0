From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: moxart: fix probe logic
Date: Thu, 29 Jan 2015 17:01:04 +0000
Message-ID: <20150129170104.GD26493@n2100.arm.linux.org.uk>
References: <8340872.32GezMfzR1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:34634 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753079AbbA2RBO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 12:01:14 -0500
Content-Disposition: inline
In-Reply-To: <8340872.32GezMfzR1@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-kernel@lists.infradead.org, Jonas Jensen <jonas.jensen@gmail.com>

On Thu, Jan 29, 2015 at 05:15:31PM +0100, Arnd Bergmann wrote:
> @@ -586,10 +586,10 @@ static int moxart_probe(struct platform_device *pdev)
>  		goto out;
>  	}
>  
> -	clk = of_clk_get(node, 0);
> -	if (IS_ERR(clk)) {
> +	host->clk = of_clk_get(node, 0);
> +	if (IS_ERR(host->clk)) {
>  		dev_err(dev, "of_clk_get failed\n");
> -		ret = PTR_ERR(clk);
> +		ret = PTR_ERR(host->clk);
>  		goto out;
>  	}
>  
...
> @@ -677,6 +679,8 @@ static int moxart_probe(struct platform_device *pdev)
>  	return 0;
>  
>  out:
> +	if (host->clk)
> +		clk_put(host->clk);

Are you sure?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
