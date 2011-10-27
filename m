From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH]mmc: sdhci: use udelay instead of mdelay for some cases
Date: Thu, 27 Oct 2011 13:09:17 +0800
Message-ID: <CAGsJ_4ygh4Fy+_8t=auuGi_Jq2paHuWDR3pYw866GZ40NR8npQ@mail.gmail.com>
References: <20111027041851.GA18442@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43730 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab1J0FJj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Oct 2011 01:09:39 -0400
Received: by bkbzt19 with SMTP id zt19so2117565bkb.19
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2011 22:09:38 -0700 (PDT)
In-Reply-To: <20111027041851.GA18442@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Shawn.Dong" <shawn.dong.cx@gmail.com>
Cc: linux-mmc@vger.kernel.org

2011/10/27 Shawn.Dong <shawn.dong.cx@gmail.com>:
> sdhci_set_clock or sdhci_reset or sdhci_send_command may be used in
> critical region which is protected by spin_lock_irqsave. Thus, these
> functions will delay the responsing of the kernel interrupts.
>
> So in this case, using a mdelay will cause unnecessary latency. Our
> hardware, in most case will not cause 1ms to finish its job. Using
> udelay instead can reduce it.
>
> By default, sdhci_do_set_ios will need about 1ms to finish in my plat=
form.
> After using udelay instead, sdhci_do_set_ios only need a few microsec=
onds.
>
> Signed-off-by: Shawn.Dong <Shawn.dong.cx@gmail.com>

ACK, see my patch as well:
http://www.spinics.net/lists/linux-mmc/msg10257.html

> ---
> =C2=A0drivers/mmc/host/sdhci.c | =C2=A0 12 ++++++------
> =C2=A01 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6d8eea3..9314cd1 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -195,7 +195,7 @@ static void sdhci_reset(struct sdhci_host *host, =
u8 mask)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0host->clock =3D=
 0;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Wait max 100 ms */
> - =C2=A0 =C2=A0 =C2=A0 timeout =3D 100;
> + =C2=A0 =C2=A0 =C2=A0 timeout =3D 10000;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* hw clears the bit when it's done */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (sdhci_readb(host, SDHCI_SOFTWARE_RE=
SET) & mask) {
> @@ -206,7 +206,7 @@ static void sdhci_reset(struct sdhci_host *host, =
u8 mask)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout--;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->ops->platform_reset_exit)
> @@ -959,7 +959,7 @@ static void sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(host->cmd);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Wait max 10 ms */
> - =C2=A0 =C2=A0 =C2=A0 timeout =3D 10;
> + =C2=A0 =C2=A0 =C2=A0 timeout =3D 1000;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D SDHCI_CMD_INHIBIT;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((cmd->data !=3D NULL) || (cmd->flags &=
 MMC_RSP_BUSY))
> @@ -980,7 +980,7 @@ static void sdhci_send_command(struct sdhci_host =
*host, struct mmc_command *cmd)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout--;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mod_timer(&host->timer, jiffies + 10 * HZ)=
;
> @@ -1140,7 +1140,7 @@ static void sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_writew(host, clk, SDHCI_CLOCK_CONTRO=
L);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Wait max 20 ms */
> - =C2=A0 =C2=A0 =C2=A0 timeout =3D 20;
> + =C2=A0 =C2=A0 =C2=A0 timeout =3D 2000;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (!((clk =3D sdhci_readw(host, SDHCI_=
CLOCK_CONTROL))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0& SDHCI_CLOCK_=
INT_STABLE)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (timeout =3D=
=3D 0) {
> @@ -1150,7 +1150,7 @@ static void sdhci_set_clock(struct sdhci_host *=
host, unsigned int clock)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timeout--;
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mdelay(1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 udelay(10);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0clk |=3D SDHCI_CLOCK_CARD_EN;
> --
> 1.7.3.4

-barry
