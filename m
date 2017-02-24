From: Anssi Hannula <anssi.hannula@bitwise.fi>
Subject: Re: [RFC PATCH 1/4] mmc: sdhci: add comment for get_timeout_clock
 callback
Date: Fri, 24 Feb 2017 16:00:45 +0200
Message-ID: <851f0dd1-09e5-b98e-0b89-7ce4c99fec1b@bitwise.fi>
References: <1487303780-234812-1-git-send-email-shawn.lin@rock-chips.com>
 <1487303780-234812-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.bitwise.fi ([109.204.228.163]:51808 "EHLO mail.bitwise.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751285AbdBXOAx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 24 Feb 2017 09:00:53 -0500
In-Reply-To: <1487303780-234812-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>

On 17.2.2017 5:56, Shawn Lin wrote:
> We need comment there to tell folks that we need this
> callback to return the timeout clock rate in KHz.

Good idea, except that currently in some cases it should return the rate
in MHz instead so the added comment is actually wrong.

Otherwise the patchset seems correct to me, and the timeout clock
situation would be better than before.


One option would be to just have the callback return Hz as that seems to
be the most obvious unit. The callback would probably have to be renamed
for that, though, to avoid any backporting etc. headaches later.


> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/sdhci.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index edf3adf..d5b4d57 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -547,6 +547,7 @@ struct sdhci_ops {
>  	int		(*enable_dma)(struct sdhci_host *host);
>  	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_min_clock)(struct sdhci_host *host);
> +	/* get_timeout_clock should return clk rate in KHz  */
>  	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
>  	unsigned int	(*get_max_timeout_count)(struct sdhci_host *host);
>  	void		(*set_timeout)(struct sdhci_host *host,


-- 
Anssi Hannula / Bitwise Oy
+358503803997

