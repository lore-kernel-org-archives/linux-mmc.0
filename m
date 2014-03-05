From: Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [RFC PATCH 1/1] mmc-utils: Support-sending-eMMC-5.0-FFU
Date: Wed, 5 Mar 2014 09:55:58 -0800
Message-ID: <CAMHSBOUAJ+NobozOBdkewUndYC+juwR6TiR+gNoaNPOPhF4bXg@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE63F4970C7@SACMBXIP01.sdcorp.global.sandisk.com>
 <CANEJEGtrBR21P_KnGv5ZwAfwNA700gVmARU42J7N+cpmD4dKJA@mail.gmail.com>
 <CAGXu5j+Vb242CPMVrrW7DbDujPpTkPHh3ei1hpO7f-BbBJ9MdQ@mail.gmail.com> <282CEDFCBC30114F83C499CB8F2ED53337E59D62@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:50525 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946AbaCER4T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Mar 2014 12:56:19 -0500
Received: by mail-ve0-f176.google.com with SMTP id cz12so1396227veb.35
        for <linux-mmc@vger.kernel.org>; Wed, 05 Mar 2014 09:56:18 -0800 (PST)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53337E59D62@SACMBXIP02.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Kees Cook <keescook@chromium.org>, Grant Grundler <grundler@chromium.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>, Puthikorn Voravootivat <puthik@chromium.org>

On Wed, Mar 5, 2014 at 8:35 AM, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Kees,
>
> Thanks for your comment.
> Please see our response inline.
>
>
>> -----Original Message-----
>> From: keescook@google.com [mailto:keescook@google.com] On Behalf Of
>> Kees Cook
>> Sent: Saturday, March 01, 2014 1:21 AM
>> To: Grant Grundler
>> Cc: Avi Shchislowski; cjb@laptop.org; linux-mmc@vger.kernel.org; Alex
>> Lemberg; Gwendal Grignou; Puthikorn Voravootivat
>> Subject: Re: [RFC PATCH 1/1] mmc-utils: Support-sending-eMMC-5.0-FFU
>>
>> On Fri, Feb 28, 2014 at 2:39 PM, Grant Grundler <grundler@chromium.org>
>> wrote:
>> > Avi,
>> > Thanks for posting these - I look forward to seeing this functionality
>> > available in mmc-utils (and kernel as needed).
>> >
>> > Comments as usual inline.
>> >
>> > I've added Gwendal/Kees to CC to comment on security issues of this
>> > proposal. See notes below.
>> >
>> >
>> > On Sun, Feb 9, 2014 at 1:08 AM, Avi Shchislowski
>> > <Avi.Shchislowski@sandisk.com> wrote:
>> >>   The mmc-utils was modified to invoke eMMC5.0 Field Firmware Update
>> (FFU) process in mmc driver
>> >>   New command was add: "do_emmc50_ffu".
>> >>
>> >>   This patch depends on patch  mmc: Support-FFU-for-eMMC-v5.0
>> >> Committed by Avi Shchislowski <avi.shchislowski@sandisk.com>
>> >>
>> >>   FFU will be done in two steps. Two new IOCTL codes will be sent to the
>> driver in order to operate FFU code:
>> >>     1.  FFU_DWONLOAD_OP (sent in ffu_download_image() function)
>> >
>> > Any reason for the typo? DOWNLOAD maybe?
>> > Shouldn't that be MMC_FFU_DOWNLOAD_OP to match the proposed
>> kernel definition?
>> >
>> >>         2.  FFU_INSTALL_OP (sent in ffu_install() function)
>> >
>> > Ditto: MMC_FFU_INSTALL_OP
>> >
>> >>
>> >>
>> >> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
>> >> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
>> >>
>> >> diff --git a/mmc.c b/mmc.c
>> >> index 926e92f..a01852d 100644
>> >> --- a/mmc.c
>> >> +++ b/mmc.c
>> >> @@ -36,9 +36,9 @@ struct Command {
>> >>                                    if >= 0, number of arguments,
>> >>                                    if < 0, _minimum_ number of arguments */
>> >>         char    *verb;          /* verb */
>> >> -       char    *help;          /* help lines; from the 2nd line onward they
>> >> +       char    *help;          /* help lines; from the 2nd line onward they
>> >>                                     are automatically indented */
>> >> -        char    *adv_help;      /* advanced help message; from the 2nd line
>> >> +        char    *adv_help;      /* advanced help message; from the 2nd line
>> >
>> > Sorry, it's not obvious what changed here. Why is this included?
>> >
>> >>                                     onward they are automatically
>> >> indented */
>> >>
>> >>         /* the following fields are run-time filled by the program */ @@ -
>> 110,6 +110,11 @@ static struct Command commands[] = {
>> >>                 "Send Sanitize command to the <device>.\nThis will delete the
>> unmapped memory region of the device.",
>> >>           NULL
>> >>         },
>> >> +       { do_emmc50_ffu, -2,
>> >> +       "emmc50 ffu", "<image path> <device>\n"
>> >> +         "run eMMC 5.0 Field firmware update.\n.",
>> >
>> > Nit: This isn't "run". It's "download firmware to eMMC 5.0 compliant
>> device".
>> >
>> >> +         NULL
>> >> +       },
>> >>         { 0, 0, 0, 0 }
>> >>  };
>> >>
>> >> @@ -362,7 +367,7 @@ static int parse_args(int argc, char **argv,
>> >>                         matchcmd->verb, matchcmd->nargs);
>> >>                         return -2;
>> >>         }
>> >> -
>> >> +
>> >
>> > I'm going to ignore white space mangle on this patch and assume you'll
>> > ask if you need help using gmail to send patches using git send-email.
>> >
>> > But the above isn't white space mangle caused by email - it's part of
>> > this patch and I'm not seeing a difference in this <REDACTED> gmail
>> > editor.
>> >
>> >>          if (prepare_args( nargs_, args_, prgname, matchcmd )){
>> >>                  fprintf(stderr, "ERROR: not enough memory\\n");
>> >>                 return -20;
>> >> diff --git a/mmc.h b/mmc.h
>> >> index 9871d62..3be6db0 100644
>> >> --- a/mmc.h
>> >> +++ b/mmc.h
>> >> @@ -80,6 +80,14 @@
>> >>  #define BKOPS_ENABLE   (1<<0)
>> >>
>> >>  /*
>> >> + * sector size
>> >> +*/
>> >> +#define CARD_BLOCK_SIZE        512
>> >
>> > sector size is advertised by the device. It could be either 512 or 4K bytes.
>> No?
>> >
>> > "7.4.17 NUMBER_OF_FW_SECTORS_CORRECTLY_PROGRAMMED [305-302]
>> >
>> > The value is in terms of 512 Bytes or in multiple of eight 512Bytes
>> > sectors (4KBytes) depending on the value of the DATA_SECTOR_SIZE field."
>> >
>> > I don't think this should be hard coded to 512. And a few places I see
>> > hard coded with "<< 9" will likely need to take this into account.
>> >
>> >
>> >> +
>> >> +#define FFU_DWONLOAD_OP        302
>> >> +#define FFU_INSTALL_OP 303
>> >
>> > These should match kernel definitions (complete name and value).
>> >
>> >> +
>> >> +/*
>> >>   * EXT_CSD field definitions
>> >>   */
>> >>  #define EXT_CSD_HPI_SUPP               (1<<0)
>> >> diff --git a/mmc_cmds.c b/mmc_cmds.c
>> >> index b8afa74..24c4a6b 100644
>> >> --- a/mmc_cmds.c
>> >> +++ b/mmc_cmds.c
>> >> @@ -1163,3 +1163,112 @@ int do_sanitize(int nargs, char **argv)
>> >>
>> >>  }
>> >>
>> >> +static int ffu_download_image(int fw_fd, int mmc_fd) {
>> >> +       int ret = 0;
>> >> +       struct mmc_ioc_cmd mmc_ioc_cmd;
>> >> +       char data_buff[MMC_IOC_MAX_BYTES];
>> >> +       int file_size;
>> >
>> > This should be off_t type. See "man 2 lseek".
>> >
>> >> +       int size;
>> >
>> > This should be size_t type.  See "man 2 read".
>> >
>> >> +       int data_length;
>> >
>> > This should ssize_t type. See "man 2 read".
>> >
>> >> +
>> >> +       memset(data_buff, 0, sizeof(data_buff));
>> >> +       /* get file size */
>> >> +       file_size = lseek(fw_fd, 0, SEEK_END);
>> >
>> > I'm wondering why lseek would be preferred over fstat().
>> >
>> >> +       if (file_size < 0) {
>> >> +               ret =  -1;
>> >> +               perror("seek file error \n");
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       lseek(fw_fd, 0, SEEK_SET);
>> >> +       do {
>> >> +               size = (file_size > MMC_IOC_MAX_BYTES) ?
>> >> +                               MMC_IOC_MAX_BYTES : file_size;
>> >> +               /* Read FW data from file */
>> >> +               data_length = read(fw_fd, data_buff, size);
>> >> +               if (data_length == -1) {
>> >
>> > Should this test data_length < size ?
>> >
>> >> +                       ret = -1;
>> >> +                       goto exit;
>> >> +               }
>> >
>> > Gwendal and Kees (CC'd) would prefer to send the file name to the
>> > kernel as part of the ioctl and use existing udev mechanisms to
>> > request the firmware.
>>
>> Yes, please see Documentation/firmware_class/README for information on
>> the kernel internals, but I would much prefer the kernel do all the loading,
>> not userspace. The kernel driver can request the firmware
>> contents:
>>
>>          if(request_firmware(&fw_entry, $FIRMWARE, device) == 0)
>>                 copy_fw_to_device(fw_entry->data, fw_entry->size);
>>          release(fw_entry);
>>
>> and then send it to the device. Doing this from userspace means there is no
>> way to verify the firmware contents. Equally, the kernel should actively block
>> the MMC_FFU_DOWNLOAD_OP op, since it should be considered a sensitive
>> operation.
>
> Indeed this mechanism allows to download FW file directly to the driver, and not using IOCTL for this.
>
> But actually, eMMC5.0 spec does not requires any of FW file content to be verified by the host.
> The FW file should  be downloaded entirely and verified by eMMC device internally.

The point of using firmware_request() is the firmware image is not
sent within the IOCTL itself but provided by a well known daemon, in
this case udevd.
We can make udevd the gate keeper of firmware images [not only eMMC
devices, but wifi and 3g modems as well] and ensure that only approved
and well-known images are sent to the devices.

>
> Please let us know if you aware of other solutions, which are requires FW file verification in the host side.
>
> In the way that we have implemented FW download routine in the driver, the FW download process is blocked (using claim_host()) anyway,
> and prevents interruptions of this process by other IO requests.
>
>>
>> -Kees
>>
>> >
>> > This has some advantages for security which make it a lot harder to
>> > "plant" the hacked firmware on devices. I'll let Gwendal and Kees
>> > present the details of those ideas.
>> >
>> >> +               /* prepare and send ioctl */
>> >> +               memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
>> >> +               mmc_ioc_cmd.opcode =  FFU_DWONLOAD_OP;
>> >> +               mmc_ioc_cmd.blksz = CARD_BLOCK_SIZE;
>> >> +               mmc_ioc_cmd.blocks = data_length / mmc_ioc_cmd.blksz;
>> >> +               mmc_ioc_cmd.arg =  0;
>> >> +               mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> MMC_CMD_ADTC;
>> >> +               mmc_ioc_cmd.write_flag = 1;
>> >> +               mmc_ioc_cmd_set_data(mmc_ioc_cmd, data_buff);
>> >> +               ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
>> >> +               if (ret) {
>> >> +                       perror("ioctl FW download");
>> >> +                       goto exit;
>> >> +               }
>> >> +
>> >> +               file_size = file_size - size;
>> >> +               printf("firmware file loading, remaining:   %d\n", file_size);
>> >> +       } while (file_size > 0);
>> >> +
>> >> +exit:
>> >> +
>> >> +       return ret;
>> >> +}
>> >> +
>> >> +static int ffu_install(int mmc_fd)
>> >> +{
>> >> +       int ret;
>> >> +       struct mmc_ioc_cmd mmc_ioc_cmd;
>> >> +
>> >> +       memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
>> >> +       mmc_ioc_cmd.opcode = FFU_INSTALL_OP;
>> >> +       mmc_ioc_cmd.blksz = CARD_BLOCK_SIZE;
>> >> +       mmc_ioc_cmd.blocks = 0;
>> >> +       mmc_ioc_cmd.arg =  0;
>> >> +       mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
>> MMC_CMD_ADTC;
>> >> +       mmc_ioc_cmd.write_flag = 0;
>> >> +       ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
>> >> +       if (ret)
>> >> +               perror("ioctl install");
>> >> +
>> >> +       printf("ffu_install ret %d \n", ret);
>> >> +       return ret;
>> >> +}
>> >> +
>> >> +int do_emmc50_ffu(int nargs, char **argv) {
>> >> +       int fd, fw_fd, ret;
>> >> +       char *device;
>> >> +
>> >> +       CHECK(nargs != 3, "Usage: ffu <image path> </path/to/mmcblkX>
>> \n",
>> >> +                               exit(1));
>> >> +
>> >> +       device = argv[2];
>> >> +       fd = open(device, O_RDWR);
>> >> +       if (fd < 0) {
>> >> +               perror("open");
>> >> +               exit(1);
>> >> +       }
>> >> +
>> >> +       /* open eMMC5.0 firmware image file */
>> >> +       fw_fd = open(argv[1], O_RDONLY);
>> >> +       if (fw_fd < 0) {
>> >> +               perror("open eMMC5.0 firmware file");
>> >> +               ret = -1;
>> >
>> > Don't want to return the errno value?
>> >
>> >> +               goto exit;
>> >> +       }
>> >> +
>> >> +       ret = ffu_download_image(fw_fd, fd);
>> >> +       if (ret)
>> >> +               goto exit;
>> >> +
>> >> +       ret = ffu_install(fd);
>> >> +       if (ret)
>> >> +               goto exit;
>> >> +
>> >> +exit:
>> >> +       close(fd);
>> >> +       close(fw_fd);
>> >> +
>> >> +       return ret;
>> >> +}
>> >> diff --git a/mmc_cmds.h b/mmc_cmds.h
>> >> index f06cc10..77a6cb8 100644
>> >> --- a/mmc_cmds.h
>> >> +++ b/mmc_cmds.h
>> >> @@ -28,3 +28,5 @@ int do_sanitize(int nargs, char **argv);  int
>> >> do_status_get(int nargs, char **argv);  int do_enh_area_set(int
>> >> nargs, char **argv);  int do_write_reliability_set(int nargs, char
>> >> **argv);
>> >> +int do_emmc50_ffu(int nargs, char **argv);
>> >> +
>> >> --
>> >> 1.7.5.4
>> >>
>> >>
>> >> Avi Shchislowski | Staff Software Engineer, MCS Embedded  | SanDisk |
>> >> +972.09.763-2666| www.sandisk.com
>> >>
>> >
>> > cheers,
>> > grant
>>
>>
>>
>> --
>> Kees Cook
>> Chrome OS Security
>
>
>
