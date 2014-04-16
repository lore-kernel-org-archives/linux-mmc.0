From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
Date: Wed, 16 Apr 2014 05:56:34 -0700
Message-ID: <1397652994.30935.5.camel@joe-AO722>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
	 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Antoine =?ISO-8859-1?Q?T=E9nart?= <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, chris@printf.net, anton@enomsg.org, alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2014-04-16 at 14:40 +0200, Antoine T=E9nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin So=
Cs.
> This controller supports 3 sockets.

trivial notes:

> diff --git a/drivers/mmc/host/sdhci-berlin.c b/drivers/mmc/host/sdhci=
-berlin.c
[]
> +static struct sdhci_ops sdhci_berlin_ops =3D {
> +	.get_max_clock =3D sdhci_pltfm_clk_get_max_clock,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2_pdata =3D {
> +	.quirks	=3D SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_BROKEN_ADMA |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops =3D &sdhci_berlin_ops,
> +};
> +
> +static struct sdhci_pltfm_data sdhci_berlin2q_pdata =3D {
> +	.quirks	=3D SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
> +		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
> +		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
> +	.ops =3D &sdhci_berlin_ops,
> +};

Perhaps const?

> +static int sdhci_berlin_probe(struct platform_device *pdev)
> +{
[]
> +	host =3D sdhci_pltfm_init(pdev,
> +				(struct sdhci_pltfm_data *)device->data, 0);

Unnecessary cast?  Maybe:

	host =3D sdhci_pltfm_init(pdev, device->data, 0);

> +	if (IS_ERR(host))
> +		return PTR_ERR(host);
> +
> +	pltfm_host =3D sdhci_priv(host);
> +
> +	clk =3D devm_clk_get(dev, NULL);
> +	if (IS_ERR(clk)) {
> +		dev_err(dev, "could not get clock: %ld\n", PTR_ERR(clk));
> +		ret =3D PTR_ERR(clk);

PTR_ERR is an int.  Does this produce a compile warning?
Maybe reverse these lines and use ret?

		ret =3D PTR_ERR(clk);
		dev_err(dev, count not get clock: %d\n", ret);
