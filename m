From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: Dynamic MMC device naming vs. bootloaders
Date: Tue, 5 Apr 2011 12:07:46 +0530
Message-ID: <BANLkTik7fbz+QLZY8RH9wCkGQdU3hUNfNA@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:55033 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554Ab1DEGiH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 02:38:07 -0400
Received: by wwk4 with SMTP id 4so2394643wwk.1
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 23:38:06 -0700 (PDT)
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0493EB33AE@HQMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Stephen,

On Mon, Apr 4, 2011 at 11:09 PM, Stephen Warren <swarren@nvidia.com> wr=
ote:
> Chris et. al.,
>
> I'm working on an ARM system that contains at least two MMC/SD device=
s;
> specifically the board has an internal MMC device, and an SD card slo=
t,
> although the SoC has four MMC/SD hosts IIRC.
>
> The kernel's naming of these devices is dynamic. If the SD card is no=
t
> plugged in, the internal MMC is always known as mmcblock0. If the SD =
card
> is plugged in too, sometimes the internal MMC is mmcblk0 and sometime=
s it's
> mmcblk1. I assume this is timing related; 2.6.37 usually seemed to na=
me
> them "in order", whereas 2.6.38 usually seems to name them "backwards=
".
>
> This causes problems with the bootloader scripts I'm using, which ass=
umes
> that the internal MMC is always device 0 and the SD slot is always de=
vice 1,
> and hence provides kernel command-line argument root=3D/dev/mmcblk0p3=
 or
> root=3D/dev/mmcblk1p3 based on whether it booted from SD or internal =
MMC (SD
> is searched for a valid image first by the bootloader).

Just follow this thread which discusses the same but for OMAP4 controll=
er
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47853.html

One solution could be make your internal MMC always registered as
mmcblk0 and the
removable one as next device.

Regards,
Kishore
>
> This could be solved by naming the kernel MMC devices statically base=
d on
> the host controller, rather than dynamically based on the first avail=
able
> ID when the actual storage is detected. The patch below implements th=
is.
>
> Is this patch conceptually acceptable for the MMC driver? Obviously, =
a
> complete patch would need to also remove the dev_use structure etc.
>
> Another solution might be for the kernel command-line to specify the
> filesystem UUID, rather than a device node. However, this entails muc=
h more
> work for the bootloader. I'm not sure whether U-Boot can do this righ=
t now?
> And actually, the filesystem images I'm using don't always have a UUI=
D by
> dDefault IIRC.
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index bfc8a8a..5131b02 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -581,7 +581,7 @@ static struct mmc_blk_data *mmc_blk_alloc(struct =
mmc_card *card)
> =A0 =A0 =A0 =A0struct mmc_blk_data *md;
> =A0 =A0 =A0 =A0int devidx, ret;
>
> - =A0 =A0 =A0 devidx =3D find_first_zero_bit(dev_use, max_devices);
> + =A0 =A0 =A0 devidx =3D card->host->index;
> =A0 =A0 =A0 =A0if (devidx >=3D max_devices)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOSPC);
> =A0 =A0 =A0 =A0__set_bit(devidx, dev_use);
>
> Thanks for any feedback.
>
> --
> nvpublic
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
