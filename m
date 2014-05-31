From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v5 11/13] mmc: mmci: add explicit clk control
Date: Sat, 31 May 2014 13:29:45 +0100
Message-ID: <20140531122945.GA20736@n2100.arm.linux.org.uk>
References: <1401469918-26817-1-git-send-email-srinivas.kandagatla@linaro.org> <1401470080-27277-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:40488 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756382AbaEaMbS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 31 May 2014 08:31:18 -0400
Content-Disposition: inline
In-Reply-To: <1401470080-27277-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: srinivas.kandagatla@linaro.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linus.walleij@linaro.org

On Fri, May 30, 2014 at 06:14:40PM +0100, srinivas.kandagatla@linaro.org wrote:
> @@ -1325,6 +1329,18 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	if (!ios->clock && variant->pwrreg_clkgate)
>  		pwr &= ~MCI_PWR_ON;
>  
> +	if ((host->variant->explicit_mclk_control) &&
> +	    (ios->clock != host->clock_cache)) {

Please explain what use these parens have (or just get rid of them as
they're completely unnecessary - they do nothing for readability.)

In fact, additional useless parens result in readability being harmed.

If you don't know the C precedence rules and as a result feel the need
to litter your code with additional parens, then you really shouldn't
be touching C code in the first place. :)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
