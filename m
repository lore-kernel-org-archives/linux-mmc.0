From: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Subject: Re: [PATCH] MMC: omap_hsmmc: enable interface clock before calling mmc_host_enable()
Date: Wed, 8 Dec 2010 10:29:34 -0600
Message-ID: <AANLkTikMerO+FFsCJkiX7xa5m51zmKhQbikHDxT8GPK8@mail.gmail.com>
References: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:34426 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab0LHQ3f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 8 Dec 2010 11:29:35 -0500
In-Reply-To: <alpine.DEB.2.00.1012071624270.13430@utopia.booyaka.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, linux-mmc@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tero Kristo <Tero.Kristo@nokia.com>, linux-omap@vger.kernel.org

On Tue, Dec 7, 2010 at 5:27 PM, Paul Walmsley <paul@pwsan.com> wrote:
>
> In the OMAP HSMMC driver, the code path entered via mmc_host_enable()=
 can
> include register accesses to the HSMMC IP block. =A0For this to work,=
 both
> the device interface clock and functional clock need to be enabled be=
fore
> mmc_host_enable() is called. =A0However, omap_hsmmc_probe() calls
> mmc_host_enable() before enabling the device interface clock. =A0This=
 can
> crash the kernel with:
>
> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa09c0=
14
>
> Fix by calling mmc_host_enable() after the device interface clock is
> enabled.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> Cc: Adrian Hunter <adrian.hunter@nokia.com>
> Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Tero Kristo <Tero.Kristo@nokia.com>
> ---
Acked-by: Madhusudhan Chikkature <madhu.cr@ti.com>

> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A06 +++---
> =A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 5d46021..58a2c5e 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2101,14 +2101,14 @@ static int __init omap_hsmmc_probe(struct pla=
tform_device *pdev)
> =A0 =A0 =A0 =A0/* we start off in DISABLED state */
> =A0 =A0 =A0 =A0host->dpm_state =3D DISABLED;
>
> - =A0 =A0 =A0 if (mmc_host_enable(host->mmc) !=3D 0) {
> + =A0 =A0 =A0 if (clk_enable(host->iclk) !=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->iclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->fclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (clk_enable(host->iclk) !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_host_disable(host->mmc);
> + =A0 =A0 =A0 if (mmc_host_enable(host->mmc) !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->iclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->iclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_put(host->fclk);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err1;
> --
> 1.7.2.3
>
>
