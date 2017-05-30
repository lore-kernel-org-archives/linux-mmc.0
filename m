From: Micka <mickamusset@gmail.com>
Subject: SDCard & Cmd56
Date: Tue, 30 May 2017 17:19:28 +0200
Message-ID: <CAF+MRtkxdZ+u0rZ25QDhCWu6Tb8R8qcofxwzTOZiHsxreL2i8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35920 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdE3PTa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 May 2017 11:19:30 -0400
Received: by mail-wm0-f50.google.com with SMTP id 7so94775522wmo.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 May 2017 08:19:29 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,


I wanted to know if it's possible to send the CMD56 with the argument:


[0] =E2=80=9C1=E2=80=9D (Read Mode)
[1:7] =E2=80=9C0010 000=E2=80=9D
(Index =3D 0x10)
[8:31] All =E2=80=980=E2=80=99 (Reserved)




The code:


int ret =3D 0;
struct mmc_ioc_cmd idata;
memset(&idata, 0, sizeof(idata));
memset(ext_csd, 0, sizeof(__u8) * 512);
idata.write_flag =3D 0;
idata.opcode =3D 56;
idata.arg =3D 0x21;
idata.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
idata.blksz =3D 512;
idata.blocks =3D 1;
mmc_ioc_cmd_set_data(idata, ext_csd);



I want to get:


byte[96-97] Endurance (Remain Life) (%)




is it possible ?
