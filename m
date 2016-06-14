From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
Date: Tue, 14 Jun 2016 09:52:47 +0300
Message-ID: <575FA9BF.6070703@intel.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-10-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:7925 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751578AbcFNG5A (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 14 Jun 2016 02:57:00 -0400
In-Reply-To: <1465456218-28354-10-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

On 09/06/16 10:10, Gregory CLEMENT wrote:
> From: Victor Gu <xigu@marvell.com>
> 
> This path adds the driver for the Marvell Xenon eMMC host controller
> which supports eMMC 5.1, SD 3.0.
> 
> However this driver supports only up to eMMC 5.0 since the command queue
> feature is not included (yet) in the driver.
> 
> [gregory.clement@free-electrons.com:
>  - reformulate commit log
>  - overload the sdhci_set_uhs_signaling function instead of using a quirk
>  - fix a kconfig dependency
>  - remove dead code]
> 
> Signed-off-by: Victor Gu <xigu@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/mmc/host/Kconfig       |   10 +
>  drivers/mmc/host/Makefile      |    1 +
>  drivers/mmc/host/sdhci-xenon.c | 1164 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1175 insertions(+)
>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
> 

<SNIP>

> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
> new file mode 100644
> index 000000000000..43c06db95872
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-xenon.c

<SNIP>

> +static int sdhci_xenon_delay_adj_test(struct sdhci_host *host,
> +		struct mmc_card *card, unsigned int delay,
> +		bool invert, bool phase)
> +{
> +	int ret;
> +	struct mmc_card *oldcard;
> +
> +	sdhci_xenon_set_fix_delay(host, delay, invert, phase);
> +
> +	/*
> +	 * If the card is not yet associated to the host, we
> +	 * temporally do it
> +	 */
> +	oldcard = card->host->card;
> +	if (!oldcard)
> +		card->host->card = card;
> +	ret =  card_alive(card);

This looks like an abuse of bus_ops->alive().  You will need to get
agreement with Ulf how to handle this.  I will wait for Ulf's comments
before reviewing this patch set further.


> +	card->host->card = oldcard;
> +	if (ret) {
> +		pr_debug("Xenon failed when sampling fix delay %d, inverted %d, phase %d\n",
> +			 delay, invert, phase);
> +		return -EIO;
> +	}
> +
> +	pr_debug("Xenon succeeded when sampling fixed delay %d, inverted %d, phase %d\n",
> +		 delay, invert, phase);
> +	return 0;
> +}


