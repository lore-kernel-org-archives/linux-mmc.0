From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl ACMDs
Date: Tue, 5 Apr 2011 18:04:55 -0500
Message-ID: <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
References: <alpine.DEB.2.00.1104051458350.25803@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:35501 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab1DEXE6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 19:04:58 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p35N5IFR002780
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 19:05:18 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p35N4auD002597
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 19:05:18 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so1148169wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 16:04:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104051458350.25803@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Tue, Apr 5, 2011 at 4:59 PM, John Calixto
<john.calixto@modsystems.com> wrote:
> Some ACMDs might actually damage the card. =A0This check ensures the
> caller has CAP_SYS_ADMIN before allowing such an activity.
>
> Signed-off-by: John Calixto <john.calixto@modsystems.com>
> ---
> =A0drivers/mmc/card/block.c | =A0 29 +++++++++++++++++++++++++++++
> =A01 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c2e107c..2ed8c57 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -31,6 +31,7 @@
> =A0#include <linux/mutex.h>
> =A0#include <linux/scatterlist.h>
> =A0#include <linux/string_helpers.h>
> +#include <linux/capability.h>
> =A0#include <linux/compat.h>
> =A0#include <linux/delay.h>
>
> @@ -205,6 +206,34 @@ static int mmc_blk_ioctl_acmd(struct block_devic=
e *bdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto acmd_done;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* The following ACMDs are known to be nondestructive=
=2E =A0They are used
> + =A0 =A0 =A0 =A0* by SD security applications (ref: SD Specification=
s, Part 1,
> + =A0 =A0 =A0 =A0* Physical Layer Simplified Specification, Version 3=
=2E01, Table 4-27).
> + =A0 =A0 =A0 =A0* Any other commands require CAP_SYS_ADMIN because t=
hey may destroy
> + =A0 =A0 =A0 =A0* the card.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 switch (sdic.opcode) {
> + =A0 =A0 =A0 case SD_APP_SD_STATUS:
> + =A0 =A0 =A0 case 18:
> + =A0 =A0 =A0 case 25:
> + =A0 =A0 =A0 case 26:
> + =A0 =A0 =A0 case 38:
> + =A0 =A0 =A0 case 43:
> + =A0 =A0 =A0 case 44:
> + =A0 =A0 =A0 case 45:
> + =A0 =A0 =A0 case 46:
> + =A0 =A0 =A0 case 47:
> + =A0 =A0 =A0 case 48:
> + =A0 =A0 =A0 case 49:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!capable(CAP_SYS_ADMIN)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EPERM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_done;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0cmd.opcode =3D sdic.opcode;
> =A0 =A0 =A0 =A0cmd.arg =3D sdic.arg;
> =A0 =A0 =A0 =A0cmd.flags =3D sdic.flags;
> --
> 1.7.4.1

Hi John,

Just to clarify, were the commands supposed to exclude commands that do=
 writes?

In MMC-land:
CMD18 is PROGRAM_CID (which is a once-in-a-lifetime operation).
CMD38 is erase
CMD25 is write_multiple_block - this can give a non-root user full
control over a disk, bypassing security.

You should definitely check if the the target device is MMC or SD.
Because the MMC and SD have slightly differing command sets.

A
