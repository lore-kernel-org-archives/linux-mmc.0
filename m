From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/4] mmc: tmio: Add tuning support
Date: Wed, 10 Aug 2016 15:10:32 +0200
Message-ID: <20160810131032.GA1741@katana>
References: <1469592803-13842-1-git-send-email-horms+renesas@verge.net.au>
 <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469592803-13842-3-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

> +static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +	struct tmio_mmc_host *host = mmc_priv(mmc);
> +	unsigned int num;
> +	int i, ret = 0;
> +	bool *tap;
> +
> +	if (!host->init_tuning || !host->select_tuning)

Check host->prepare_tuning, too?

> +		/* Tuning is not supported */
> +		goto out;
> +
> +	num = host->init_tuning(host);
> +	if (!num)
> +		/* Tuning is not supported */
> +		goto out;
> +
> +	tap = kmalloc(num * 2 * sizeof(*tap), GFP_KERNEL);
> +	if (!tap) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	/* Issue CMD19 twice for each tap */
> +	for (i = 0; i < 2 * num; i++) {
> +		if (host->prepare_tuning)
> +			host->prepare_tuning(host, i % num);
> +
> +		ret = mmc_send_tuning(mmc, opcode, NULL);
> +		if (ret && ret != -EILSEQ)
> +			goto err_free;
> +		tap[i] = (ret != 0);
> +
> +		mdelay(1);
> +	}
> +
> +	ret = host->select_tuning(host, tap, num * 2);
> +
> +err_free:
> +	kfree(tap);
> +out:
> +	if (ret < 0) {
> +		dev_warn(&host->pdev->dev, "Tuning procedure failed\n");
> +		tmio_mmc_hw_reset(mmc);
> +	} else {
> +		host->mmc->retune_period = 0;
> +	}
> +
> +	return ret;
> +

Unnecessary blank line
