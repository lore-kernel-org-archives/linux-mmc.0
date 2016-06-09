From: Lucas Stach <dev@lynxeye.de>
Subject: Re: [PATCH 03/12] mmc: tegra: restrict the voltage_switch()
 callback to the 1.8V case
Date: Thu, 09 Jun 2016 11:54:57 +0200
Message-ID: <1465466097.18807.7.camel@lynxeye.de>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
	 <1465456218-28354-4-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:42643 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751108AbcFIJzT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jun 2016 05:55:19 -0400
In-Reply-To: <1465456218-28354-4-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Am Donnerstag, den 09.06.2016, 09:10 +0200 schrieb Gregory CLEMENT:
> Given its name the voltage_switch() should be called for any
> voltage. However currently it is only called for the 1.8V case.
>=20
> That means that the current implementation of the callback could have
> made this assumption. In order to not adding a regression when the
> voltage_switch() function will be called for the other voltage
> targets,
> this patch ensure that the code of the current callback won't be
> executed
> for the other case than 1.8V.
>=20
This isn't necessary, it's fine to re-execute the pad calibration for
any voltage switch.

Regards,
Lucas

> Cc: Lucas Stach <dev@lynxeye.de>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> =C2=A0drivers/mmc/host/sdhci-tegra.c | 4 ++++
> =C2=A01 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-
> tegra.c
> index bcc0de47fe7e..01f58296125e 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -302,6 +302,10 @@ static void tegra_sdhci_voltage_switch(struct
> sdhci_host *host)
> =C2=A0	struct sdhci_tegra *tegra_host =3D
> sdhci_pltfm_priv(pltfm_host);
> =C2=A0	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host-
> >soc_data;
> =C2=A0
> +	/* initially this function was called only for the 1.8V case
> */
> +	if (host->mmc->ios.signal_voltage !=3D MMC_SIGNAL_VOLTAGE_180)
> +		return;
> +
> =C2=A0	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
> =C2=A0		tegra_host->pad_calib_required =3D true;
> =C2=A0}
