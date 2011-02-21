From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] omap: hsmmc: fix ocr mask usage
Date: Mon, 21 Feb 2011 21:40:46 +0530
Message-ID: <AANLkTi=n98uzQ_VgJfGmqdRCZmb=cdoQunB2SN97NrjF@mail.gmail.com>
References: <1298268437-17989-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51580 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459Ab1BUQLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 11:11:08 -0500
Received: by wyb38 with SMTP id 38so1263485wyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 08:11:06 -0800 (PST)
In-Reply-To: <1298268437-17989-1-git-send-email-gadiyar@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-mmc@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, Chris Ball <cjb@laptop.org>

On Mon, Feb 21, 2011 at 11:37 AM, Anand Gadiyar <gadiyar@ti.com> wrote:
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

Tested this patch on OMAP4430SDP & OMAP4 Blaze.

Tested-by:  Kishore Kadiyala <kishore.kadiyala@ti.com>

> Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> Tony, Chris,
>
> This is only a partial fix. It fixes the obvious bug introduced
> in the commit I noted above, however it is not the final
> fix. I'm not convinced the way the regulators are handled
> in this driver is correct - I'm still studying the code and
> will come up with a proper fix later.
>
> However, this does fix a real bug and I believe the bug is
> obvious. Would be nice to get this into the -rc series if
> we still can.
>
> - Anand
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 -
> =A01 file changed, 1 deletion(-)
>
> Index: linux-2.6/drivers/mmc/host/omap_hsmmc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/mmc/host/omap_hsmmc.c
> +++ linux-2.6/drivers/mmc/host/omap_hsmmc.c
> @@ -413,7 +413,6 @@ static int omap_hsmmc_reg_get(struct oma
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
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
