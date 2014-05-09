From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
Date: Fri, 09 May 2014 16:55:36 +0100
Message-ID: <536CFA78.9050609@codethink.co.uk>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com> <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:54169 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756796AbaEIPzn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 May 2014 11:55:43 -0400
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?B?QW50b2luZSBUw6luYXJ0?= <antoine.tenart@free-electrons.com>, sebastian.hesselbarth@gmail.com, chris@printf.net, anton@enomsg.org
Cc: alexandre.belloni@free-electrons.com, zmxu@marvell.com, jszhang@marvell.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 16/04/14 13:40, Antoine T=C3=A9nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin So=
Cs.
> This controller supports 3 sockets.

[snip]

> +
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
> +
> +static const struct of_device_id sdhci_berlin_of_match_table[] =3D {
> +	{
> +		.compatible =3D "marvell,berlin2-sdhci",
> +		.data =3D &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible =3D "marvell,berlin2cd-sdhci",
> +		.data =3D &sdhci_berlin2_pdata,
> +	},
> +	{
> +		.compatible =3D "marvell,berlin2q-sdhci",
> +		.data =3D &sdhci_berlin2q_pdata,
> +	},
> +	{}

I think the hardware names should be used instead of the
quirks the hardware has (broken wp / broken adma)



--=20
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
