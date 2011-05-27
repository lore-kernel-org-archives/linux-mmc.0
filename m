From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH/RFC] mmc: sh_mmcif: maximize power saving
Date: Fri, 27 May 2011 18:51:01 +0900
Message-ID: <BANLkTinaDmLCvPB4_2konsomPYJhNFXzhg@mail.gmail.com>
References: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37914 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590Ab1E0JvD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 May 2011 05:51:03 -0400
In-Reply-To: <Pine.LNX.4.64.1105261524120.9307@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <damm@opensource.se>

Hi Guennadi,

On Thu, May 26, 2011 at 10:33 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch uses runtime PM to allow the system to power down the MMC
> controller, when the MMC closk is switched off.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> Patches have been submitted earlier for SDHCI to accomplish something
> similar, but they have complicated dependencies upon other different
> subsystems, especially on PCI. MMCIF is easier - it only exists in
> different SoCs, so, this change should also be easier to review, veri=
fy
> and test.

Nice to see improved Power Management for the MMCIF driver!

> @@ -901,8 +902,16 @@ static void sh_mmcif_set_ios(struct mmc_host *mm=
c, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (ios->clock)
> + =A0 =A0 =A0 if (ios->clock) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->power) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->set_pwr)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p->set_=
pwr(host->pd, ios->power_mode);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(&ho=
st->pd->dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sh_mmcif_sync_reset(hos=
t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sh_mmcif_clock_control(host, ios->cloc=
k);

You seem to be resetting the MMCIF block regardless if the power has
been cut or not. This may work well, but perhaps your code can be
improved to not reset when only clocks have been stopped? Resetting
when not needed will only result in unnecessary overhead. I believe
the Runtime PM suspend/resume callbacks can be used for determining if
the power has been cut or not.

Please make a V2 on top of Rafael's power domain control code later
when 2.6.40-rc has been released.

Thanks!

/ magnus
