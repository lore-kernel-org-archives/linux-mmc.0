From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 04/15] mmc: sdhci: reset sdclk before setting high
 speed enable
Date: Fri, 6 May 2011 06:38:35 -0400
Message-ID: <BANLkTinKvDgo7ZqgUBqYXPxUN-Jr4-iNMg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-5-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1EFKig convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:38:36 -0400
Received: by vxi39 with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:38:35 -0700 (PDT)
In-Reply-To: <1304578151-1775-5-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> As per Host Controller spec v3.00, we reset SDCLK before setting
> High Speed Enable, and then set it back to avoid generating clock
> gliches. Before enabling SDCLK again, we make sure the clock is
> stable, so we use sdhci_set_clock().
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 27 ++++++++++++++++++++++++---
> =A01 files changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9f38317..309240c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1243,13 +1243,12 @@ static void sdhci_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl &=3D ~SDHCI_CTRL_HISPD;
>
> - =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> -
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_300) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u16 ctrl_2;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl_2 =3D sdhci_readw(host, SDHCI_HOS=
T_CONTROL2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_E=
NABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl=
, SDHCI_HOST_CONTROL1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We only need to set=
 Driver Strength if the
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * preset value enable=
 is not set.
> @@ -1261,8 +1260,30 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ctrl_2=
 |=3D SDHCI_CTRL_DRV_TYPE_C;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_writew(host, ctr=
l_2, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* According to SDHC =
Spec v3.00, if the Preset Value
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Enable in the Host=
 Control 2 register is set, we
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* need to reset SD C=
lock Enable before changing High
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Speed Enable to av=
oid generating clock gliches.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 clk;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int clock;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reset SD Clock Enabl=
e */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D sdhci_readw(hos=
t, SDHCI_CLOCK_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk &=3D ~SDHCI_CLOCK_C=
ARD_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, clk,=
 SDHCI_CLOCK_CONTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl=
, SDHCI_HOST_CONTROL1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Re-enable SD Clock *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clock =3D host->clock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clock =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_set_clock(host, c=
lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL1);
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Some (ENE) controllers go apeshit on some ios opera=
tion,
> --
> 1.7.1
>
>
