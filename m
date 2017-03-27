From: "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [v2, 4/7] mmc: sdhci: add a quirk to restore delay in tuning
Date: Mon, 27 Mar 2017 08:05:58 +0000
Message-ID: <DB6PR0401MB25364664A5A3D9BE8A80C19FF8330@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <1488529129-23560-1-git-send-email-yangbo.lu@nxp.com>
 <1488529129-23560-5-git-send-email-yangbo.lu@nxp.com>
 <878da006-5b83-a9d9-6136-07d8f07ea65f@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve1eur01on0050.outbound.protection.outlook.com ([104.47.1.50]:33712
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751640AbdC0IGW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 27 Mar 2017 04:06:22 -0400
In-Reply-To: <878da006-5b83-a9d9-6136-07d8f07ea65f@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Xiaobo Xie <xiaobo.xie@nxp.com>

Hi Adrian,

Thanks a lot for your suggestion.
I have sent out the new version patch-set.

Please help to review :)


Best regards,
Yangbo Lu

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Thursday, March 23, 2017 3:04 PM
> To: Y.B. Lu; linux-mmc@vger.kernel.org; ulf.hansson@linaro.org; Rob
> Herring; Mark Rutland; Catalin Marinas; Will Deacon
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Xiaobo Xie
> Subject: Re: [v2, 4/7] mmc: sdhci: add a quirk to restore delay in tuning
>=20
> On 03/03/17 10:18, Yangbo Lu wrote:
> > There was a mdelay between tuning cycles which is removed since eMMC
> > spec didn't require that. However it's observed that eSDHC needed this
> > delay for HS200 successful tuning. Maybe it's also needed for some
> > other controllers. This patch is to add a quirk to fix it.
> >
> > Fixes: 197160d52e85 ("mmc: sdhci: remove mdelay in eMMC tuning")
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
>=20
> I would prefer to do something like this:
>=20
> ---
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Thu, 23 Mar 2017 08:54:06 +0200
> Subject: [PATCH] mmc: sdhci: Control the delay between tuning commands
>=20
> The delay between tuning commands for SD cards is not part of the
> specification. A driver that needs it probably needs it for eMMC too,
> whereas most drivers would probably like to set it to 0. Make it a host
> member (host->tuning_delay) that defaults to the existing behaviour.
> Drivers can set it to zero to eliminate the delay, or set it to a
> positive value to always have a delay.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/sdhci.c | 11 ++++++++---  drivers/mmc/host/sdhci.h |  1
> +
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> a33102fc800b..2fc33485df1d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2100,9 +2100,9 @@ static void __sdhci_execute_tuning(struct
> sdhci_host *host, u32 opcode)
>  			break;
>  		}
>=20
> -		/* eMMC spec does not require a delay between tuning cycles
> */
> -		if (opcode =3D=3D MMC_SEND_TUNING_BLOCK)
> -			mdelay(1);
> +		/* Spec does not require a delay between tuning cycles */
> +		if (host->tuning_delay > 0)
> +			mdelay(host->tuning_delay);
>  	}
>=20
>  	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
> @@ -2164,6 +2164,9 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32
> opcode)
>=20
>  	host->mmc->retune_period =3D tuning_count;
>=20
> +	if (host->tuning_delay < 0)
> +		host->tuning_delay =3D opcode =3D=3D MMC_SEND_TUNING_BLOCK;
> +
>  	sdhci_start_tuning(host);
>=20
>  	__sdhci_execute_tuning(host, opcode);
> @@ -3108,6 +3111,8 @@ struct sdhci_host *sdhci_alloc_host(struct device
> *dev,
>  	host->cqe_ier     =3D SDHCI_CQE_INT_MASK;
>  	host->cqe_err_ier =3D SDHCI_CQE_INT_ERR_MASK;
>=20
> +	host->tuning_delay =3D -1;
> +
>  	return host;
>  }
>=20
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
> 35b41da0a636..b0f416fc9548 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -538,6 +538,7 @@ struct sdhci_host {
>  #define SDHCI_TUNING_MODE_1	0
>  #define SDHCI_TUNING_MODE_2	1
>  #define SDHCI_TUNING_MODE_3	2
> +	int			tuning_delay;	/* Delay (ms) between tuning
> commands */
>=20
>  	unsigned long private[0] ____cacheline_aligned;  };
> --
> 1.9.1
>=20
>=20

