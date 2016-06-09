From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 03/12] mmc: tegra: restrict the voltage_switch() callback to the 1.8V case
Date: Thu, 09 Jun 2016 14:27:16 +0200
Message-ID: <8737omo8d7.fsf@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
	<1465456218-28354-4-git-send-email-gregory.clement@free-electrons.com>
	<1465466097.18807.7.camel@lynxeye.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:55041 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751322AbcFIM1Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2016 08:27:24 -0400
In-Reply-To: <1465466097.18807.7.camel@lynxeye.de> (Lucas Stach's message of
	"Thu, 09 Jun 2016 11:54:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <dev@lynxeye.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Hi Lucas,
=20
 On jeu., juin 09 2016, Lucas Stach <dev@lynxeye.de> wrote:

> Am Donnerstag, den 09.06.2016, 09:10 +0200 schrieb Gregory CLEMENT:
>> Given its name the voltage_switch() should be called for any
>> voltage. However currently it is only called for the 1.8V case.
>>=20
>> That means that the current implementation of the callback could hav=
e
>> made this assumption. In order to not adding a regression when the
>> voltage_switch() function will be called for the other voltage
>> targets,
>> this patch ensure that the code of the current callback won't be
>> executed
>> for the other case than 1.8V.
>>=20
> This isn't necessary, it's fine to re-execute the pad calibration for
> any voltage switch.

Thanks for your feedback, so I can remove this patch from the series.

Gregory

>
> Regards,
> Lucas
>
>> Cc: Lucas Stach <dev@lynxeye.de>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>> =C2=A0drivers/mmc/host/sdhci-tegra.c | 4 ++++
>> =C2=A01 file changed, 4 insertions(+)
>>=20
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci=
-
>> tegra.c
>> index bcc0de47fe7e..01f58296125e 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -302,6 +302,10 @@ static void tegra_sdhci_voltage_switch(struct
>> sdhci_host *host)
>> =C2=A0	struct sdhci_tegra *tegra_host =3D
>> sdhci_pltfm_priv(pltfm_host);
>> =C2=A0	const struct sdhci_tegra_soc_data *soc_data =3D tegra_host-
>> >soc_data;
>> =C2=A0
>> +	/* initially this function was called only for the 1.8V case
>> */
>> +	if (host->mmc->ios.signal_voltage !=3D MMC_SIGNAL_VOLTAGE_180)
>> +		return;
>> +
>> =C2=A0	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
>> =C2=A0		tegra_host->pad_calib_required =3D true;
>> =C2=A0}

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
