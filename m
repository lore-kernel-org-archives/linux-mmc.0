From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: RE: MMC timeout issue on 4.6 kernel
Date: Tue, 4 Oct 2016 09:03:04 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C591CCBF88E@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0064.outbound.protection.outlook.com ([104.47.37.64]:39570
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752026AbcJDKgi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 4 Oct 2016 06:36:38 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi All,

With further debug, I am seeing the issue only with ADMA2, whereas SDMA and=
 PIO mode are working fine.
Can anyone help me on this issue?

Regards
Sai Krishna

> -----Original Message-----
> From: Sai Krishna Potthuri
> Sent: Saturday, October 01, 2016 1:59 PM
> To: 'linux-mmc@vger.kernel.org' <linux-mmc@vger.kernel.org>
> Cc: 'Ulf Hansson' <ulf.hansson@linaro.org>
> Subject: RE: MMC timeout issue on 4.6 kernel
>=20
> Hi,
>=20
> Any help
>=20
> Regards
> Sai Krishna
>=20
> > -----Original Message-----
> > From: Sai Krishna Potthuri
> > Sent: Monday, September 26, 2016 10:29 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Subject: MMC timeout issue on 4.6 kernel
> >
> > Hi,
> >
> > With 4.6 kernel, I am doing regression test on SD which does following =
things.
> > 1. Mount SD card.
> > 2. Read and write random 1MB data.
> > 3. Reboot the board.
> >
> > I am facing following error while reading the data from the SD card.
> >
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
> > 0x900, card status 0xb00
> > mmc0: tried to reset card
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
> > 0x900, card status 0xb00
> > mmcblk0: retrying using single block read
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response
> > 0x900, card status 0x0
> > blk_update_request: I/O error, dev mmcblk0, sector 8194
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 transferring data, sector 8195, nr 1, cmd response
> > 0x900, card status 0x0
> > blk_update_request: I/O error, dev mmcblk0, sector 8195 EXT2-fs
> (mmcblk0p1):
> > error: unable to read superblock
> > mmc0: Timeout waiting for hardware interrupt.
> > mmcblk0: error -110 transferring data, sector 16387, nr 61, cmd
> > response 0x900, card status 0xb00
> > mmc0: tried to reset card
> >
> > Getting this error once in a while in regression test after several run=
s.
> > I am not seeing this issue with 4.5 kernel.
> > Please let me know if anyone has seen this issue.
> >
> > Regards
> > Sai Krishna
