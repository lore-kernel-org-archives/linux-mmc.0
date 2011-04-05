From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v2 2/2] mmc: Check CAP_SYS_ADMIN for destructive ioctl ACMDs
Date: Tue, 5 Apr 2011 18:13:21 -0500
Message-ID: <BANLkTi=z=_kCgqPk3mRxXBwHibH_O61Jdw@mail.gmail.com>
References: <alpine.DEB.2.00.1104051458350.25803@peruna>
	<BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og108.obsmtp.com ([64.18.0.186]:59667 "EHLO
	exprod5og108.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab1DEXNZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 19:13:25 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p35NBflB023924
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 19:11:41 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p35NBdsR023906
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 5 Apr 2011 19:11:40 -0400 (EDT)
Received: by wyb34 with SMTP id 34so1155154wyb.15
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 16:13:22 -0700 (PDT)
In-Reply-To: <BANLkTi=xcPEJxophfymqF5+Nd=aF40H=FQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

On Tue, Apr 5, 2011 at 6:04 PM, Andrei Warkentin <andreiw@motorola.com>=
 wrote:
> On Tue, Apr 5, 2011 at 4:59 PM, John Calixto
> <john.calixto@modsystems.com> wrote:
>> Some ACMDs might actually damage the card. =A0This check ensures the
>> caller has CAP_SYS_ADMIN before allowing such an activity.
>>
>> Signed-off-by: John Calixto <john.calixto@modsystems.com>
>> ---
>> =A0drivers/mmc/card/block.c | =A0 29 +++++++++++++++++++++++++++++
>> =A01 files changed, 29 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
>> index c2e107c..2ed8c57 100644
>> --- a/drivers/mmc/card/block.c
>> +++ b/drivers/mmc/card/block.c
>> @@ -31,6 +31,7 @@
>> =A0#include <linux/mutex.h>
>> =A0#include <linux/scatterlist.h>
>> =A0#include <linux/string_helpers.h>
>> +#include <linux/capability.h>
>> =A0#include <linux/compat.h>
>> =A0#include <linux/delay.h>
>>
>> @@ -205,6 +206,34 @@ static int mmc_blk_ioctl_acmd(struct block_devi=
ce *bdev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto acmd_done;
>> =A0 =A0 =A0 =A0}
>>
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* The following ACMDs are known to be nondestructiv=
e. =A0They are used
>> + =A0 =A0 =A0 =A0* by SD security applications (ref: SD Specificatio=
ns, Part 1,
>> + =A0 =A0 =A0 =A0* Physical Layer Simplified Specification, Version =
3.01, Table 4-27).
>> + =A0 =A0 =A0 =A0* Any other commands require CAP_SYS_ADMIN because =
they may destroy
>> + =A0 =A0 =A0 =A0* the card.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 switch (sdic.opcode) {
>> + =A0 =A0 =A0 case SD_APP_SD_STATUS:
>> + =A0 =A0 =A0 case 18:
>> + =A0 =A0 =A0 case 25:
>> + =A0 =A0 =A0 case 26:
>> + =A0 =A0 =A0 case 38:
>> + =A0 =A0 =A0 case 43:
>> + =A0 =A0 =A0 case 44:
>> + =A0 =A0 =A0 case 45:
>> + =A0 =A0 =A0 case 46:
>> + =A0 =A0 =A0 case 47:
>> + =A0 =A0 =A0 case 48:
>> + =A0 =A0 =A0 case 49:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!capable(CAP_SYS_ADMIN)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D -EPERM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto acmd_done;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 }
>> +
>> =A0 =A0 =A0 =A0cmd.opcode =3D sdic.opcode;
>> =A0 =A0 =A0 =A0cmd.arg =3D sdic.arg;
>> =A0 =A0 =A0 =A0cmd.flags =3D sdic.flags;
>> --
>> 1.7.4.1
>
> Hi John,
>
> Just to clarify, were the commands supposed to exclude commands that =
do writes?
>
> In MMC-land:
> CMD18 is PROGRAM_CID (which is a once-in-a-lifetime operation).
> CMD38 is erase
> CMD25 is write_multiple_block - this can give a non-root user full
> control over a disk, bypassing security.
>
> You should definitely check if the the target device is MMC or SD.
> Because the MMC and SD have slightly differing command sets.
>
> A
>

Let me clarify, this is what the MMC spec says:


      The only effect of the APP_CMD is that if the command index of
the, immediately, following command
      has an ACMD overloading, the non standard version will used. If,
as an example, a card has a definition
      for ACMD13 but not for ACMD7 then, if received immediately after
APP_CMD command, Command 13
      will be interpreted as the non standard ACMD13 but, command 7 as
the standard CMD7.
      In order to use one of the manufacturer specific ACMD=92s the hos=
t will:
      * Send APP_CMD. The response will have the APP_CMD bit (new
status bit) set signaling
=2E..
=2E..
=2E..
      If a non valid command is sent (neither ACMD nor CMD) then it
will be handled as a standard
      MultiMediaCard illegal command error.

This means, since an MMC card doesn't support ACMD25 or ACMD38, these
will be executed as CMD25 or CMD38. I.e. - it's an attack vector.

A
