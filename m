From: <ext-denis.2.karpov@nokia.com>
Subject: RE: [PATCH RFC] mmc : omap_hsmmc : Save and restore the sysc across
 reset
Date: Mon, 16 Jan 2012 13:11:46 +0000
Message-ID: <5E7C2FE2AE03DF4CA6AC500032BF8F77C1762A@008-AM1MPN1-072.mgdnok.nokia.com>
References: <1326713587-26463-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50875 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab2APNL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2012 08:11:57 -0500
In-Reply-To: <1326713587-26463-1-git-send-email-shubhrajyoti@ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: shubhrajyoti@ti.com, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

ext Shubhrajyoti D wrote on=A02012-01-16:
> The commit 11dd62:[omap_hsmmc: context save/restore support]
>=20
> does a reset and restores AUTOIDLE settings.
> This patch saves the register does a reset and restores
> the same configuration.
=2E..
>  	if (pdata->get_context_loss_count) {
> @@ -700,6 +700,7 @@ static int omap_hsmmc_context_restore(struct omap=
_hsmmc_host
> *host)
>  		&& time_before(jiffies, timeout))
>  		;
> +	sysc =3D OMAP_HSMMC_READ(host->base, SYSCONFIG);
>  	/* Do software reset */
>  	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, SOFTRESET);
>  	timeout =3D jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> @@ -707,8 +708,7 @@ static int omap_hsmmc_context_restore(struct omap=
_hsmmc_host
> *host)
>  		&& time_before(jiffies, timeout))
>  		;
> -	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
> -			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, sysc);

The meaning of the code is to restore the register context after it was=
 lost during transition into low power consumption state. SW reset is n=
eeded to bring all the registers in a consistent state before reconfigu=
ring some of them.=20

Saving and restoring the SYSCONFIG register across SW reset is not need=
ed.=20

Also re-configuring AUTOIDLE feature is not necessary since SYSCONFIG r=
eset value has is 1 already, according to TRM. I guess it was done to m=
ake things more explicit.

Denis
