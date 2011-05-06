From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 10/15] mmc: sdhci: add support for programmable clock mode
Date: Fri, 6 May 2011 06:40:23 -0400
Message-ID: <BANLkTimByAEWKNYDEGNDrmMuH8uVSHhE_g@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-11-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab1EFKkX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:40:23 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:40:23 -0700 (PDT)
In-Reply-To: <1304578151-1775-11-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Host Controller v3.00 supports programmable clock mode as an optional
> feature. The support for this mode is indicated by non-zero value in
> bits 48-55 of the Capabilities register. If supported, the actual
> value of Clock Multiplier is one more than the value provided in the
> bit fields. We only set Clock Generator Select (bit 5) and SDCLK
> Frequency Select (bits 8-15) of the Clock Control register in case
> Preset Value Enable is not set, otherwise these fields are automatica=
lly
> set by the Host Controller based on the UHS mode selected. Also, sinc=
e
> the maximum and minimum clock frequency in this mode can be
> (Base Clock * Clock Mul) and (Base Clock * Clock Mul)/1024 respective=
ly,
> f_max and f_min have been recalculated to reflect this change.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 81 +++++++++++++++++++++++++++++=
+++++++--------
> =A0drivers/mmc/host/sdhci.h =A0| =A0 =A03 ++
> =A0include/linux/mmc/sdhci.h | =A0 =A01 +
> =A03 files changed, 70 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cb767a0..8ed2e1b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1013,8 +1013,8 @@ static void sdhci_finish_command(struct sdhci_h=
ost *host)
>
> =A0static void sdhci_set_clock(struct sdhci_host *host, unsigned int =
clock)
> =A0{
> - =A0 =A0 =A0 int div;
> - =A0 =A0 =A0 u16 clk;
> + =A0 =A0 =A0 int div =3D 0; /* Initialized for compiler warning */
> + =A0 =A0 =A0 u16 clk =3D 0;
> =A0 =A0 =A0 =A0unsigned long timeout;
>
> =A0 =A0 =A0 =A0if (clock =3D=3D host->clock)
> @@ -1032,14 +1032,45 @@ static void sdhci_set_clock(struct sdhci_host=
 *host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_300) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Version 3.00 divisors must be a mult=
iple of 2. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->max_clk <=3D clock)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (div =3D 2; div < S=
DHCI_MAX_DIV_SPEC_300; div +=3D 2) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((ho=
st->max_clk / div) <=3D clock)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if the Host Controller suppo=
rts Programmable Clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Mode.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->clk_mul) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16 ctrl;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* We need to figure =
out whether the Host Driver needs
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to select Programm=
able Clock Mode, or the value can
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* be set automatical=
ly by the Host Controller based on
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the Preset Value r=
egisters.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readw(ho=
st, SDHCI_HOST_CONTROL2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(ctrl & SDHCI_CTRL=
_PRESET_VAL_ENABLE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (di=
v =3D 1; div <=3D 1024; div++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if (((host->max_clk * host->clk_mul) /
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 div) <=3D clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Se=
t Programmable Clock Mode in the Clock
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Co=
ntrol register.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D=
 SDHCI_PROG_CLOCK_MODE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Version 3.00 divisor=
s must be a multiple of 2. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->max_clk <=3D =
clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div =3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (di=
v =3D 2; div < SDHCI_MAX_DIV_SPEC_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0div +=3D 2) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 if ((host->max_clk / div) <=3D clock)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 div >>=3D 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Version 2.00 divisors must be a pow=
er of 2. */
> @@ -1047,10 +1078,10 @@ static void sdhci_set_clock(struct sdhci_host=
 *host, unsigned int clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((host->max_clk / d=
iv) <=3D clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 div >>=3D 1;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 div >>=3D 1;
>
> - =A0 =A0 =A0 clk =3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> + =A0 =A0 =A0 clk |=3D (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
> =A0 =A0 =A0 =A0clk |=3D ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_=
LEN)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<< SDHCI_DIVIDER_HI_SHIFT;
> =A0 =A0 =A0 =A0clk |=3D SDHCI_CLOCK_INT_EN;
> @@ -2314,17 +2345,37 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->timeout_clk *=3D 1000;
>
> =A0 =A0 =A0 =A0/*
> + =A0 =A0 =A0 =A0* In case of Host Controller v3.00, find out whether=
 clock
> + =A0 =A0 =A0 =A0* multiplier is supported.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 host->clk_mul =3D (caps[1] & SDHCI_CLOCK_MUL_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_CLOCK_MUL_SHIFT;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case the value in Clock Multiplier is 0, then p=
rogrammable
> + =A0 =A0 =A0 =A0* clock mode is not supported, otherwise the actual =
clock
> + =A0 =A0 =A0 =A0* multiplier is one more than the value of Clock Mul=
tiplier
> + =A0 =A0 =A0 =A0* in the Capabilities Register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->clk_mul)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->clk_mul +=3D 1;
> +
> + =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 * Set host parameters.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mmc->ops =3D &sdhci_ops;
> + =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
> =A0 =A0 =A0 =A0if (host->ops->get_min_clock)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->ops->get_min_cloc=
k(host);
> - =A0 =A0 =A0 else if (host->version >=3D SDHCI_SPEC_300)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / SDHCI_MA=
X_DIV_SPEC_300;
> - =A0 =A0 =A0 else
> + =A0 =A0 =A0 else if (host->version >=3D SDHCI_SPEC_300) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->clk_mul) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D (host->m=
ax_clk * host->clk_mul) / 1024;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_max =3D host->ma=
x_clk * host->clk_mul;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->ma=
x_clk / SDHCI_MAX_DIV_SPEC_300;
> + =A0 =A0 =A0 } else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->f_min =3D host->max_clk / SDHCI_M=
AX_DIV_SPEC_200;
>
> - =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
> =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
>
> =A0 =A0 =A0 =A0/*
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b32fc32..0208164 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -101,6 +101,7 @@
> =A0#define =A0SDHCI_DIV_MASK =A0 =A0 =A0 =A00xFF
> =A0#define =A0SDHCI_DIV_MASK_LEN =A0 =A08
> =A0#define =A0SDHCI_DIV_HI_MASK =A0 =A0 0x300
> +#define =A0SDHCI_PROG_CLOCK_MODE 0x0020
> =A0#define =A0SDHCI_CLOCK_CARD_EN =A0 0x0004
> =A0#define =A0SDHCI_CLOCK_INT_STABLE =A0 =A0 =A0 =A00x0002
> =A0#define =A0SDHCI_CLOCK_INT_EN =A0 =A00x0001
> @@ -191,6 +192,8 @@
> =A0#define =A0SDHCI_DRIVER_TYPE_C =A0 0x00000020
> =A0#define =A0SDHCI_DRIVER_TYPE_D =A0 0x00000040
> =A0#define =A0SDHCI_USE_SDR50_TUNING =A0 =A0 =A0 =A00x00002000
> +#define =A0SDHCI_CLOCK_MUL_MASK =A00x00FF0000
> +#define =A0SDHCI_CLOCK_MUL_SHIFT 16
>
> =A0#define SDHCI_CAPABILITIES_1 =A0 0x44
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index b74c853..a88a799 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -117,6 +117,7 @@ struct sdhci_host {
>
> =A0 =A0 =A0 =A0unsigned int max_clk; =A0 /* Max possible freq (MHz) *=
/
> =A0 =A0 =A0 =A0unsigned int timeout_clk; =A0 =A0 =A0 /* Timeout freq =
(KHz) */
> + =A0 =A0 =A0 unsigned int clk_mul; =A0 /* Clock Muliplier value */
>
> =A0 =A0 =A0 =A0unsigned int clock; =A0 =A0 /* Current clock (MHz) */
> =A0 =A0 =A0 =A0u8 pwr; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Current vol=
tage */
> --
> 1.7.1
>
>
