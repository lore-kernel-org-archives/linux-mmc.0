From: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: RE: MMC timeout issue on 4.6 kernel
Date: Sat, 1 Oct 2016 08:29:19 +0000
Message-ID: <4FF8F58FAA9D5D4193D4E554E4352C591CCB4FDF@XAP-PVEXMBX02.xlnx.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn3nam01on0056.outbound.protection.outlook.com ([104.47.33.56]:55552
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750800AbcJAKhZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 1 Oct 2016 06:37:25 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Hi,

Any help

Regards
Sai Krishna

> -----Original Message-----
> From: Sai Krishna Potthuri
> Sent: Monday, September 26, 2016 10:29 PM
> To: linux-mmc@vger.kernel.org
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Subject: MMC timeout issue on 4.6 kernel
>
> Hi,
>
> With 4.6 kernel, I am doing regression test on SD which does following th=
ings.
> 1. Mount SD card.
> 2. Read and write random 1MB data.
> 3. Reboot the board.
>
> I am facing following error while reading the data from the SD card.
>
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response 0x=
900,
> card status 0xb00
> mmc0: tried to reset card
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response 0x=
900,
> card status 0xb00
> mmcblk0: retrying using single block read
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 8194, nr 2, cmd response 0x=
900,
> card status 0x0
> blk_update_request: I/O error, dev mmcblk0, sector 8194
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 8195, nr 1, cmd response 0x=
900,
> card status 0x0
> blk_update_request: I/O error, dev mmcblk0, sector 8195 EXT2-fs (mmcblk0p=
1):
> error: unable to read superblock
> mmc0: Timeout waiting for hardware interrupt.
> mmcblk0: error -110 transferring data, sector 16387, nr 61, cmd response
> 0x900, card status 0xb00
> mmc0: tried to reset card
>
> Getting this error once in a while in regression test after several runs.
> I am not seeing this issue with 4.5 kernel.
> Please let me know if anyone has seen this issue.
>
> Regards
> Sai Krishna


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.

