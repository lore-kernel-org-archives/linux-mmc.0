From: Saugata Das <saugata.das@linaro.org>
Subject: Re: [PATCH 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
Date: Thu, 17 May 2012 16:37:10 +0530
Message-ID: <CAKLKtzfHSeCBAcoxWD64PhutQPQRGPr78qMbCjvA_vzLXc_B8w@mail.gmail.com>
References: <1337185615-17202-1-git-send-email-saugata.das@stericsson.com>
	<1337185615-17202-2-git-send-email-saugata.das@stericsson.com>
	<000001cd3401$8511cb80$8f356280$@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:44066 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284Ab2EQLHL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 May 2012 07:07:11 -0400
Received: by qcro28 with SMTP id o28so1110333qcr.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 May 2012 04:07:11 -0700 (PDT)
In-Reply-To: <000001cd3401$8511cb80$8f356280$@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: Saugata Das <saugata.das@stericsson.com>, linux-mmc@vger.kernel.org, venkat@linaro.org, patches@linaro.org, arnd.bergmann@linaro.org, lporzio@micron.com

On 17 May 2012 13:18, Subhash Jadavani <subhashj@codeaurora.org> wrote:
> Reviewed-by: Subhash Jadavani <subhashj@codeaurora.org>
>
> Sougata,
> There are additional blank lines before and after the
> do_disable_512B_emulation() function. You may want to remove them.

I have done that in the new version. Please check.


>
> Regards,
> Subhash
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Saugata Das
>> Sent: Wednesday, May 16, 2012 9:57 PM
>> To: linux-mmc@vger.kernel.org; venkat@linaro.org
>> Cc: patches@linaro.org; saugata.das@linaro.org; arnd.bergmann@linaro=
=2Eorg;
>> lporzio@micron.com
>> Subject: [PATCH 2/2] [MMC-4.5] [MMC UTIL] Disable emulation
>>
>> From: Saugata Das <saugata.das@linaro.org>
>>
>> In this patch, we add utility to disable emulation mode in the eMMC-=
4.5.
>> This is done to increase the data sector size to 4KB.
>>
>> Signed-off-by: Saugata Das <saugata.das@linaro.org>
>>
>> changes in v2:
>> =A0 =A0 =A0 Review rework based on comments from Subhash
>> ---
>> =A0mmc.c =A0 =A0 =A0| =A0 =A06 ++++++
>> =A0mmc.h =A0 =A0 =A0| =A0 10 ++++++++++
>> =A0mmc_cmds.c | =A0 51
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>> =A0mmc_cmds.h | =A0 =A01 +
>> =A04 files changed, 68 insertions(+), 0 deletions(-)
>>
>> diff --git a/mmc.c b/mmc.c
>> index c27fc24..ebc7ab2 100644
>> --- a/mmc.c
>> +++ b/mmc.c
>> @@ -65,6 +65,12 @@ static struct Command commands[] =3D {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Set the eMMC writeprotect status of <de=
vice>.",
>> =A0 =A0 =A0 =A0 NULL
>> =A0 =A0 =A0 },
>> + =A0 =A0 { do_disable_512B_emulation, -1,
>> + =A0 =A0 =A0 "disable 512B emulation", "<device>\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 "Set the eMMC data sector size to 4KB by d=
isabling emulation
>> <device>.",
>> + =A0 =A0 =A0 NULL
>> + =A0 =A0 },
>> +
>> =A0 =A0 =A0 { 0, 0, 0, 0 }
>> =A0};
>>
>> diff --git a/mmc.h b/mmc.h
>> index 3af36f1..34c31d3 100644
>> --- a/mmc.h
>> +++ b/mmc.h
>> @@ -35,6 +35,16 @@
>> =A0#define EXT_CSD_PART_SWITCH_TIME =A0 =A0 199
>> =A0#define EXT_CSD_BOOT_CFG =A0 =A0 =A0 =A0 =A0 =A0 179
>> =A0#define EXT_CSD_BOOT_WP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
173
>> +#define EXT_CSD_WR_REL_PARAM 166
>> +#define EXT_CSD_NATIVE_SECTOR_SIZE =A0 63 /* R */
>> +#define EXT_CSD_USE_NATIVE_SECTOR =A0 =A062 /* R/W */
>> +#define EXT_CSD_DATA_SECTOR_SIZE =A0 =A0 61 /* R */
>> +
>> +/*
>> + * WR_REL_PARAM field definitions
>> + */
>> +#define HS_CTRL_REL =A0(1<<0)
>> +#define EN_REL_WR =A0 =A0(1<<2)
>>
>> =A0/*
>> =A0 * EXT_CSD field definitions
>> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> index 4562cef..f0e64c9 100644
>> --- a/mmc_cmds.c
>> +++ b/mmc_cmds.c
>> @@ -168,6 +168,57 @@ int do_writeprotect_set(int nargs, char **argv)
>> =A0 =A0 =A0 return ret;
>> =A0}
>>
>> +
>> +int do_disable_512B_emulation(int nargs, char **argv) {
>> + =A0 =A0 __u8 ext_csd[512], native_sector_size, data_sector_size,
>> wr_rel_param;
>> + =A0 =A0 int fd, ret;
>> + =A0 =A0 char *device;
>> +
>> + =A0 =A0 CHECK(nargs !=3D 2, "Usage: mmc </path/to/mmcblkX>\n", exi=
t(1));
>> +
>> + =A0 =A0 device =3D argv[1];
>> +
>> + =A0 =A0 fd =3D open(device, O_RDWR);
>> + =A0 =A0 if (fd < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 perror("open");
>> + =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 ret =3D read_extcsd(fd, ext_csd);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Could not read EXT_CSD fr=
om %s\n", device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 wr_rel_param =3D ext_csd[EXT_CSD_WR_REL_PARAM];
>> + =A0 =A0 native_sector_size =3D ext_csd[EXT_CSD_NATIVE_SECTOR_SIZE]=
;
>> + =A0 =A0 data_sector_size =3D ext_csd[EXT_CSD_DATA_SECTOR_SIZE];
>> +
>> + =A0 =A0 if (native_sector_size &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 !data_sector_size &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 (wr_rel_param & EN_REL_WR)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D write_extcsd_value(fd,
>> EXT_CSD_USE_NATIVE_SECTOR, 1);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Could not=
 write 0x%02x to "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "EXT_CSD[%d] in %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 1, EXT_CSD_BOOT_WP, device);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf("MMC disable 512B emulation success=
ful\n"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Now reset=
 the device to switch to 4KB "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "native se=
ctor mode\n");
>> + =A0 =A0 } else if (native_sector_size && data_sector_size) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf("MMC already disabled 512B emulatio=
n mode\n");
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf("MMC does not support disabling 512=
B emulation
>> mode\n");
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +
>> =A0int do_read_extcsd(int nargs, char **argv) =A0{
>> =A0 =A0 =A0 __u8 ext_csd[512], ext_csd_rev, reg;
>> diff --git a/mmc_cmds.h b/mmc_cmds.h
>> index 66e9acb..56f46d7 100644
>> --- a/mmc_cmds.h
>> +++ b/mmc_cmds.h
>> @@ -19,3 +19,4 @@ int do_read_extcsd(int nargs, char **argv); =A0int
>> do_write_extcsd(int nargs, char **argv); =A0int do_writeprotect_get(=
int
> nargs,
>> char **argv); =A0int do_writeprotect_set(int nargs, char **argv);
>> +int do_disable_512B_emulation(int nargs, char **argv);
>> --
>> 1.7.4.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
> the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>
