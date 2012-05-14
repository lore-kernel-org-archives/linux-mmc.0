From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [RFC 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Mon, 14 May 2012 20:55:30 +0530
Message-ID: <CAKLKtzedRuxtCbfFswe1efaOXD_26OKdPkCMVNFMHJMdnC3-Qw@mail.gmail.com>
References: <1336574901-26579-1-git-send-email-saugata.das@stericsson.com>
	<1336574901-26579-2-git-send-email-saugata.das@stericsson.com>
	<4FB0E0F7.3010601@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:59437 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756892Ab2ENPZb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 May 2012 11:25:31 -0400
Received: by qabj40 with SMTP id j40so4812132qab.1
        for <linux-mmc@vger.kernel.org>; Mon, 14 May 2012 08:25:30 -0700 (PDT)
In-Reply-To: <4FB0E0F7.3010601@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, patches@linaro.org

On 14 May 2012 16:09, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> On 5/9/2012 8:18 PM, Saugata Das wrote:
>>
>> From: Saugata Das<saugata.das@linaro.org>
>>
>> In this patch, we add utility to disable emulation mode in the eMMC-=
4.5.
>> This is done to increase the data sector size to 4KB.
>>
>> Signed-off-by: Saugata Das<saugata.das@linaro.org>
>> ---
>> =A0mmc.c =A0 =A0 =A0| =A0 =A06 ++++++
>> =A0mmc.h =A0 =A0 =A0| =A0 =A02 ++
>> =A0mmc_cmds.c | =A0 42 ++++++++++++++++++++++++++++++++++++++++++
>> =A0mmc_cmds.h | =A0 =A01 +
>> =A04 files changed, 51 insertions(+), 0 deletions(-)
>>
>> diff --git a/mmc.c b/mmc.c
>> index c27fc24..43b95aa 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -65,6 +65,12 @@ static struct Command commands[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Set the eMMC writeprotect status of<=
device>.",
>> =A0 =A0 =A0 =A0 =A0NULL
>> =A0 =A0 =A0 =A0},
>> + =A0 =A0 =A0 { do_disable_emulation, -1,
>
> can we add good name? which emulation we are disabling? It's 512B emu=
lation
> mode, we are disabling.
>

Ok

>> + =A0 =A0 =A0 =A0 "disable emulation", "<device>\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Set the eMMC data sector size to 4KB =
by disabling
>> emulation<device>.",
>> + =A0 =A0 =A0 =A0 NULL
>> + =A0 =A0 =A0 },
>> +
>> =A0 =A0 =A0 =A0{ 0, 0, 0, 0 }
>> =A0};
>>
>> diff --git a/mmc.h b/mmc.h
>> index 3af36f1..a2050fa 100644
>> --- a/mmc.h
>> +++ b/mmc.h
>> @@ -35,6 +35,8 @@
>> =A0#define EXT_CSD_PART_SWITCH_TIME =A0 =A0 =A0199
>> =A0#define EXT_CSD_BOOT_CFG =A0 =A0 =A0 =A0 =A0 =A0 =A0179
>> =A0#define EXT_CSD_BOOT_WP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 173
>> +#define EXT_CSD_NATIVE_SECTOR_SIZE =A0 =A0 63 /* R */
>> +#define EXT_CSD_NATIVE_SECTOR =A062 /* R/W */
>
> Can we name this as EXT_CSD_USE_NATIVE_SECTOR?
>

Ok

>>
>> =A0/*
>> =A0 * EXT_CSD field definitions
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 4562cef..2713ccd 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -168,6 +168,48 @@ int do_writeprotect_set(int nargs, char **argv)
>> =A0 =A0 =A0 =A0return ret;
>> =A0}
>>
>> +
>> +int do_disable_emulation(int nargs, char **argv)
>> +{
>> + =A0 =A0 =A0 __u8 ext_csd[512], native_sector_size;
>> + =A0 =A0 =A0 int fd, ret;
>> + =A0 =A0 =A0 char *device;
>> +
>> + =A0 =A0 =A0 CHECK(nargs !=3D 2, "Usage: mmc</path/to/mmcblkX>\n", =
exit(1));
>> +
>> + =A0 =A0 =A0 device =3D argv[1];
>> +
>> + =A0 =A0 =A0 fd =3D open(device, O_RDWR);
>> + =A0 =A0 =A0 if (fd< =A00) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror("open");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 ret =3D read_extcsd(fd, ext_csd);
>> + =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Could not read EXT_CS=
D from %s\n",
>> device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 native_sector_size =3D ext_csd[EXT_CSD_NATIVE_SECTOR_S=
IZE];
>> +
>> + =A0 =A0 =A0 if (native_sector_size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D write_extcsd_value(fd, EXT_CSD=
_NATIVE_SECTOR, 1);
>
> Just curious, how are we going to power cycle the device after settin=
g the
> USE_NATIVE_SECTOR? because DATA_SECTOR_SIZE won't be changed to 4K un=
til we
> explicitly power cycle after setting this field.
>

I will add a "printf" instructing the user to power cycle the eMMC at
the end of the switch.

>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Could=
 not write 0x%02x to "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "EXT_C=
SD[%d] in %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 1, EXT=
_CSD_BOOT_WP, device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf("MMC does not support 4KB nativ=
e sector\n");
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 return ret;
>> +}
>> +
>> +
>> =A0int do_read_extcsd(int nargs, char **argv)
>> =A0{
>> =A0 =A0 =A0 =A0__u8 ext_csd[512], ext_csd_rev, reg;
>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>> index 66e9acb..dd107d5 100644
>> --- a/mmc_cmds.h
>> +++ b/mmc_cmds.h
>> @@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv);
>> =A0int do_write_extcsd(int nargs, char **argv);
>> =A0int do_writeprotect_get(int nargs, char **argv);
>> =A0int do_writeprotect_set(int nargs, char **argv);
>> +int do_disable_emulation(int nargs, char **argv);
>
>
