From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 13/22] mmc: omap_hsmmc: fix few bugs when set the clock divisor
Date: Thu, 5 May 2011 15:53:45 +0300
Message-ID: <BANLkTikwqcgcy2dnD=2_DGUQM=0a1JtfoA@mail.gmail.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
	<1304596282-4095-14-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:43438 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483Ab1EEMxq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 08:53:46 -0400
In-Reply-To: <1304596282-4095-14-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

On Thu, May 5, 2011 at 2:51 PM, Adrian Hunter <adrian.hunter@nokia.com>=
 wrote:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
>
> There are two pieces of code which similar, but not the same. Each of=
 them
> contains a bug.
>
> The SYSCTL register should be read before write in the
> omap_hsmmc_context_restore() to remain the state of the reserved bits=
=2E
>
> Before set the clock divisor and DTO bits the value from the SYSCTL r=
egister
> should be masked properly. We were lucky to have no problems with DTO=
 bits. So,
> make sure we have clear DTO bits properly in the omap_hsmmc_set_ios()=
=2E
>
> Additionally get rid of msleep(1). The actual time rare higher than 3=
0us on
> OMAP 3630.
>
> The result pieces of code are split to omap_hsmmc_set_clock() functio=
n.
>
> Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 59 +++++++++++++++++++--------=
-------------
> =A01 files changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index ae6d204..3c76911 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -619,6 +619,32 @@ static u16 calc_divisor(struct mmc_ios *ios)
> =A0 =A0 =A0 =A0return dsor;
> =A0}
>
> +static void omap_hsmmc_set_clock(struct omap_hsmmc_host *host)
> +{
> + =A0 =A0 =A0 struct mmc_ios *ios =3D &host->mmc->ios;
> + =A0 =A0 =A0 unsigned long regval;
> + =A0 =A0 =A0 unsigned long timeout;
> +
> + =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "Set clock to %uHz\n", ios-=
>clock);
> +
> + =A0 =A0 =A0 omap_hsmmc_stop_clock(host);
> +
> + =A0 =A0 =A0 regval =3D OMAP_HSMMC_READ(host->base, SYSCTL);
> + =A0 =A0 =A0 regval =3D regval & ~(CLKD_MASK | DTO_MASK);
> + =A0 =A0 =A0 regval =3D regval | (calc_divisor(ios) << 6) | (DTO << =
16);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, SYSCTL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host->base, SYSCTL) | I=
CE);
> +
> + =A0 =A0 =A0 /* Wait till the ICS bit is set */
> + =A0 =A0 =A0 timeout =3D jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> + =A0 =A0 =A0 while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) !=3D=
 ICS
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && time_before(jiffies, timeout))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;

Since you are busywaiting now, cpu_relax() is advisable I guess.
