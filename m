From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [PATCH] omap: hsmmc: fix ocr mask usage
Date: Thu, 26 May 2011 16:15:39 +0530
Message-ID: <BANLkTimySE+Lo2p-_4D_cagfVemHMiyGhQ@mail.gmail.com>
References: <1298268437-17989-1-git-send-email-gadiyar@ti.com>
	<AANLkTi=n98uzQ_VgJfGmqdRCZmb=cdoQunB2SN97NrjF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:58581 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751981Ab1EZKpk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 26 May 2011 06:45:40 -0400
Received: by mail-vx0-f182.google.com with SMTP id 34so584333vxc.13
        for <linux-mmc@vger.kernel.org>; Thu, 26 May 2011 03:45:39 -0700 (PDT)
In-Reply-To: <AANLkTi=n98uzQ_VgJfGmqdRCZmb=cdoQunB2SN97NrjF@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-mmc@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>, Madhusudhan Chikkature <madhu.cr@ti.com>

On Mon, Feb 21, 2011 at 9:40 PM, Kishore Kadiyala
<kishorek.kadiyala@gmail.com> wrote:
> On Mon, Feb 21, 2011 at 11:37 AM, Anand Gadiyar <gadiyar@ti.com> wrot=
e:
>> The OMAP HSMMC driver uses an ocr_mask to determine the
>> list of voltages supported by the card. It populates this
>> mask based on the list of voltages supported by the
>> regulator that supplies the voltage.
>>
>> Commit 64be97822b (omap4 hsmmc: Update ocr mask for MMC2 for
>> regulator to use) passed a fixed ocr_mask from the OMAP4 SDP
>> board file to limit the voltage to 2.9-3.0 Volts, and updated
>> the driver to use this mask if provided, instead of using the
>> regulator's supported voltages.
>>
>> However the commit is buggy - the ocr_mask is overridden
>> by the regulator's capabilities anyway. Fix this.
>>
>> (The bug shows up when a system-wide suspend is attempted
>> on the OMAP4 SDP/Blaze platforms. The eMMC card comes up
>> at 3V, but drops to 1.65V after the system resumes).
>>
>> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
>
> Tested this patch on OMAP4430SDP & OMAP4 Blaze.
>
> Tested-by: =A0Kishore Kadiyala <kishore.kadiyala@ti.com>
>
Acked-by: Balaji T K <balajitk@ti.com>

Can you this patch be queued?

>> Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>> Tony, Chris,
>>
>> This is only a partial fix. It fixes the obvious bug introduced
>> in the commit I noted above, however it is not the final
>> fix. I'm not convinced the way the regulators are handled
>> in this driver is correct - I'm still studying the code and
>> will come up with a proper fix later.
>>
>> However, this does fix a real bug and I believe the bug is
>> obvious. Would be nice to get this into the -rc series if
>> we still can.
>>
>> - Anand
>>
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A01 -
>> =A01 file changed, 1 deletion(-)
>>
>> Index: linux-2.6/drivers/mmc/host/omap_hsmmc.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-2.6.orig/drivers/mmc/host/omap_hsmmc.c
>> +++ linux-2.6/drivers/mmc/host/omap_hsmmc.c
>> @@ -413,7 +413,6 @@ static int omap_hsmmc_reg_get(struct oma
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retur=
n -EINVAL;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).ocr_mask =3D mmc_regula=
tor_get_ocrmask(reg);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Allow an aux regulator */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D regulator_get(host->dev, "vmm=
c_aux");
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
