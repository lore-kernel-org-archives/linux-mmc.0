From: Micka <mickamusset@gmail.com>
Subject: Re: SDCard & Cmd56
Date: Wed, 31 May 2017 09:26:37 +0200
Message-ID: <CAF+MRtmW5oAy=cB6cypweVCO2iJ-8cZkKbZNB2DFAeJ_8meP1g@mail.gmail.com>
References: <CAF+MRtkxdZ+u0rZ25QDhCWu6Tb8R8qcofxwzTOZiHsxreL2i8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36809 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbdEaH0j (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 May 2017 03:26:39 -0400
Received: by mail-wm0-f48.google.com with SMTP id 7so108954231wmo.1
        for <linux-mmc@vger.kernel.org>; Wed, 31 May 2017 00:26:38 -0700 (PDT)
In-Reply-To: <CAF+MRtkxdZ+u0rZ25QDhCWu6Tb8R8qcofxwzTOZiHsxreL2i8g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

I tried, but I got that:

[73462.880814] mmcblk0: error -110 sending status command, retrying
[73462.880875] mmcblk0: timed out sending r/w cmd command, card status 0xe0=
0
[73462.908904] mmcblk0: timed out sending r/w cmd command, card status 0x40=
0e00
[73462.999342] mmcblk0: timed out sending r/w cmd command, card status 0x40=
0e00
[73463.026402] mmcblk0: timed out sending r/w cmd command, card status 0x40=
0e00
[73463.052944] mmcblk0: timed out sending r/w cmd command, card status 0x40=
0e00
[73463.119002] mmc0: tried to reset card
[73497.951175] omap_hsmmc 48060000.mmc: __mmc_blk_ioctl_cmd: data error -11=
0
[73499.171563] mmcblk0: timed out sending r/w cmd command, card status 0x40=
0b00




Le mar. 30 mai 2017 =C3=A0 17:19, Micka <mickamusset@gmail.com> a =C3=A9cri=
t :
>
> Hi,
>
>
> I wanted to know if it's possible to send the CMD56 with the argument:
>
>
> [0] =E2=80=9C1=E2=80=9D (Read Mode)
> [1:7] =E2=80=9C0010 000=E2=80=9D
> (Index =3D 0x10)
> [8:31] All =E2=80=980=E2=80=99 (Reserved)
>
>
>
>
> The code:
>
>
> int ret =3D 0;
> struct mmc_ioc_cmd idata;
> memset(&idata, 0, sizeof(idata));
> memset(ext_csd, 0, sizeof(__u8) * 512);
> idata.write_flag =3D 0;
> idata.opcode =3D 56;
> idata.arg =3D 0x21;
> idata.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> idata.blksz =3D 512;
> idata.blocks =3D 1;
> mmc_ioc_cmd_set_data(idata, ext_csd);
>
>
>
> I want to get:
>
>
> byte[96-97] Endurance (Remain Life) (%)
>
>
>
>
> is it possible ?
