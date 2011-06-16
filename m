From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v2] omap: hsmmc: fix ocr mask usage
Date: Thu, 16 Jun 2011 16:45:33 +0530
Message-ID: <BANLkTima4vQureH6q4j58MxfbSOprZ0bmw@mail.gmail.com>
References: <1308047399-8537-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44175 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751612Ab1FPLPf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 07:15:35 -0400
Received: by mail-bw0-f52.google.com with SMTP id 24so1839879bwj.11
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2011 04:15:33 -0700 (PDT)
In-Reply-To: <1308047399-8537-1-git-send-email-sourav.poddar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, tony <tony@atomide.com>, "madhu.cr" <madhu.cr@ti.com>, "kishore.kadiyala" <kishore.kadiyala@ti.com>, cjb <cjb@laptop.org>, gadiyar <gadiyar@ti.com>

On Tue, Jun 14, 2011 at 3:59 PM, Sourav Poddar <sourav.poddar@ti.com> w=
rote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> The OMAP HSMMC driver uses an ocr_mask to determine the
> list of voltages supported by the card. It populates this
> mask based on the list of voltages supported by the
> regulator that supplies the voltage.
>
> Commit 64be97822b (omap4 hsmmc: Update ocr mask for MMC2 for
> regulator to use) passed a fixed ocr_mask from the OMAP4 SDP
> board file to limit the voltage to 2.9-3.0 Volts, and updated
> the driver to use this mask if provided, instead of using the
> regulator's supported voltages.
>
> However the commit is buggy - the ocr_mask is overridden
> by the regulator's capabilities anyway. Fix this.
>
> (The bug shows up when a system-wide suspend is attempted
> on the OMAP4 SDP/Blaze platforms. The eMMC card comes up
> at 3V, but drops to 1.65V after the system resumes).
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Acked-by: Balaji T K <balajitk@ti.com>
> Tested-by: =A0Kishore Kadiyala <kishore.kadiyala@ti.com>
> Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> ---
> =A0v2: Rebase to latest kernel(Linux 3.0-rc3)
> =A0v1: https://patchwork.kernel.org/patch/576871/
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 5b2e215..8707bcd 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -429,7 +429,6 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_h=
ost *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).ocr_mask =3D mmc_regulat=
or_get_ocrmask(reg);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allow an aux regulator */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D regulator_get(host->dev, "vmmc=
_aux");
> --
Acked-by: Venkatraman S <svenkatr@ti.com>

Hi Chris,
  Can you please queue it for the next rc ?
Thanks and regards,
Venkat.
