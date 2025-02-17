Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A62212FA2
	for <linux-mmc@vger.kernel.org>; Mon, 17 Feb 2025 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793497; cv=none; b=MPSigdWhx8s1q0/0UsnV+EPqYXSkxArsxq5ZgehapxSaDk4iTN6HeiZmkrpAgKZQziIk29g63RgC/H6cnxrrPg/dXeSW9Z4yDKvFgUVHoDKuMcln5oXefCb8eDhWSKiZQdDmmb3EDqQVg0dys5cDW5ePlOtJuZ5QzCU0QdZhitU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793497; c=relaxed/simple;
	bh=4K6gXcxJjr+/ELA0VBoOf+wv2Xuouq4wr3eDs5ggyJ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mziStNdJ9+yCYI9dUyRYUfHTKahvAIx1eAHfi9Ozfhj0mbvFvxnpShjmZLn30UDELTPARm8f6ndydpiFYHhhinankT938rqeiEUT+sQxhc2j8uwImMlRa8GRhO0oc/0x7br1MXbMANrclcIZi3Cfu+JvTEH62O2cSn/KHSOFBAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <l.stach@pengutronix.de>)
	id 1tjzlC-0003zP-JD; Mon, 17 Feb 2025 12:58:02 +0100
Message-ID: <ab721b4a96495516f5149e91f3e4764014e39ba6.camel@pengutronix.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: improve imx8mq emmc/sd read
 performance
From: Lucas Stach <l.stach@pengutronix.de>
To: ziniu.wang_1@nxp.com, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: imx@lists.linux.dev, s32@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de,  linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, haibo.chen@nxp.com,  kernel@pengutronix.de,
 festevam@gmail.com, linux-arm-kernel@lists.infradead.org
Date: Mon, 17 Feb 2025 12:58:01 +0100
In-Reply-To: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
References: <20250217110623.2383142-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org

Hi Luke,

Am Montag, dem 17.02.2025 um 19:06 +0800 schrieb ziniu.wang_1@nxp.com:
> From: Luke Wang <ziniu.wang_1@nxp.com>
>=20
> Compared with kernel 6.1, imx8mq eMMC/SD read performance drops by about
> 30% with kernel 6.6.
>=20
> The eMMC/SD read thread will be put to sleep until the hardware completes
> data transfer. Normally, the read thread will be woken up immediately
> when the data transfer is completed. However, due to a known ic bug, if
> imx8mq is in cpuidle, it will take a long time (about 500us) to exit
> cpuidle. As a result, the read thread cannot immediately read the next
> data block, affecting the read performance.
>=20
Is this really a problem with the upstream kernel? i.MX8MQ upstream
does not use the deeper PSCI idle states, but only uses WFI, so I doubt
that upstream is affected by this issue.

Regards,
Lucas

> Kernel 6.6 uses EEVDF as the new scheduler, which affects cpu scheduling
> and cpuidle behavior. With kernel 6.6, the cpu which the read thread
> resides has a greater probability in cpuidle (about 80%), while with
> kernel 6.1, the probability is only about 20-30%. For other platforms,
> this does not have a significant impact on read performance because the
> cpuidle exit time is very short (for example, imx93 is about 60us). But
> for imx8mq, this results in longer waits for the thread to be woken up
> while reading eMMC/SD, which drops performance.
>=20
> So for imx8mq, use the ESDHC_FLAG_PMQOS flag to request the cpu latency
> QoS constraint. This can prevent entering cpuidle during data transfer.
>=20
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-=
esdhc-imx.c
> index ff78a7c6a04c..b3bf9c171d46 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -337,6 +337,15 @@ static struct esdhc_soc_data usdhc_imx8mm_data =3D {
>  	.quirks =3D SDHCI_QUIRK_NO_LED,
>  };
> =20
> +static struct esdhc_soc_data usdhc_imx8mq_data =3D {
> +	.flags =3D ESDHC_FLAG_USDHC | ESDHC_FLAG_STD_TUNING
> +			| ESDHC_FLAG_HAVE_CAP1 | ESDHC_FLAG_HS200
> +			| ESDHC_FLAG_HS400 | ESDHC_FLAG_PMQOS
> +			| ESDHC_FLAG_STATE_LOST_IN_LPMODE
> +			| ESDHC_FLAG_BROKEN_AUTO_CMD23,
> +	.quirks =3D SDHCI_QUIRK_NO_LED,
> +};
> +
>  struct pltfm_imx_data {
>  	u32 scratchpad;
>  	struct pinctrl *pinctrl;
> @@ -381,6 +390,7 @@ static const struct of_device_id imx_esdhc_dt_ids[] =
=3D {
>  	{ .compatible =3D "fsl,imx7ulp-usdhc", .data =3D &usdhc_imx7ulp_data, }=
,
>  	{ .compatible =3D "fsl,imx8qxp-usdhc", .data =3D &usdhc_imx8qxp_data, }=
,
>  	{ .compatible =3D "fsl,imx8mm-usdhc", .data =3D &usdhc_imx8mm_data, },
> +	{ .compatible =3D "fsl,imx8mq-usdhc", .data =3D &usdhc_imx8mq_data, },
>  	{ .compatible =3D "fsl,imxrt1050-usdhc", .data =3D &usdhc_imxrt1050_dat=
a, },
>  	{ .compatible =3D "nxp,s32g2-usdhc", .data =3D &usdhc_s32g2_data, },
>  	{ /* sentinel */ }

