From: Grant Grundler <grundler@chromium.org>
Subject: Re: [PATCH] mmc-utils: Support sending Samsung eMMC 4.5 FFU
Date: Mon, 7 Apr 2014 22:06:27 -0700
Message-ID: <CANEJEGvd70HN=MNJNQbJn49H=Q7-35bm_eE22a--f-PNdX5JuQ@mail.gmail.com>
References: <000301cf4ffe$7e1dbf80$7a593e80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:59093 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaDHFG2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Apr 2014 01:06:28 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so473496oag.12
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2014 22:06:27 -0700 (PDT)
In-Reply-To: <000301cf4ffe$7e1dbf80$7a593e80$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seunguk Shin <seunguk.shin@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, CPGS <cpgs@samsung.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, Puthikorn Voravootivat <puthik@chromium.org>

On Fri, Apr 4, 2014 at 5:07 AM, Seunguk Shin <seunguk.shin@samsung.com> wrote:
> This change adds support to invoke Samsung eMMC 4.5 field firmware update
> (ffu) process.
> New command was added: "emmc45 ffu".
>
> Samsung eMMC 4.5 FFU protocol is similar with eMMC 5.0 FFU without
> MODE_OPERATION.
> It uses the different EXT_CSD offset.
>
> This patch depends on patch mmc-utils: Support-sending-eMMC-v5.0 committed
> by Avi Shchislowski <avi.shchislowski@sandisk.com> and mmc: Support FFU for
> Samsung eMMC v4.5 committed by Seunguk Shin <seunguk.shin@samsung.com>
>
> ---
>  mmc.c      |  5 ++++
>  mmc.h      |  1 +
>  mmc_cmds.c | 87
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  1 +
>  4 files changed, 94 insertions(+)
>
> diff --git a/mmc.c b/mmc.c
> index 7234953..44aaf6d 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -115,6 +115,11 @@ static struct Command commands[] = {
>                 "run eMMC 5.0 Field firmware update.\n.",
>           NULL
>         },
> +       { do_emmc45_ffu, -2,
> +         "emmc45 ffu", "<image path> <device>\n"

I think this is a good starting point and I think we should adopt this
patch as-is. Partly because I want to see Seunguk's name _and_ email
address "permanently" recorded as the original author. I'm
particularly interested in making sure @samsung.com is listed as the
original author. :)

I understand this code depends on a patch that hasn't been accepted
yet. :) So effectively this might not matter:

Reviewed-by: Grant Grundler <grundler@chromium.org>


Sorry, I'll dump some more thoughts here:
I was originally thinking mmc-utils should be looking at the
ext_csd[CSD_REV] to determine which FFU method would be used.

But the kernel knows enough about the device (e.g. eMMC version and
MANFID) to select the right FFU method in the IOCTL calls. The user
space really only needs "upload this file for FFU".

Is there any reason we wouldn't want to "install" once the FFU has
successfully completed?

I reread Avi's previous patches and it's not explained why
FFU_INSTALL_OP should be a separate step for user space.
If not, the kernel will know when the FFU is complete and can perform
"install" automatically. I think it's a good idea to keep the kernel
internal implementation as two discrete steps though.

I'm reading "install" to mean issue some magic commands that will
trigger the new firmware to start executing on the device.

cheers,
grant

> +               "run eMMC 4.5 Field firmware update for samsung.\n.",
> +         NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index 19eaaba..ca4b70b 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -86,6 +86,7 @@
>
>  #define FFU_DWONLOAD_OP        302
>  #define FFU_INSTALL_OP 303
> +#define FFU_SAMSUNG45_OP       304
>
>  /*
>   * EXT_CSD field definitions
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index f667d10..17e50d8 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1271,3 +1271,90 @@ exit:
>         return ret;
>  }
>
> +static int ffu_execute(int fw_fd, int mmc_fd)
> +{
> +       int ret = 0;
> +       struct mmc_ioc_cmd mmc_ioc_cmd;
> +       char data_buff[MMC_IOC_MAX_BYTES];
> +       int file_size;
> +       int data_length;
> +
> +       memset(data_buff, 0, sizeof(data_buff));
> +       /* get file size */
> +       file_size = lseek(fw_fd, 0, SEEK_END);
> +       if (file_size < 0) {
> +               ret = -1;
> +               perror("seek file error \n");
> +               goto exit;
> +       }
> +
> +       lseek(fw_fd, 0, SEEK_SET);
> +
> +       if (file_size > MMC_IOC_MAX_BYTES) {
> +               ret = -1;
> +               perror("firmware file size error \n");
> +               goto exit;
> +       } else {
> +               /* Read FW data from file */
> +               data_length = read(fw_fd, data_buff, file_size);
> +               if (data_length == -1) {
> +                       ret = -1;
> +                       goto exit;
> +               }
> +               /* prepare and send ioctl */
> +               memset(&mmc_ioc_cmd, 0, sizeof(mmc_ioc_cmd));
> +               mmc_ioc_cmd.opcode = FFU_SAMSUNG45_OP;
> +               mmc_ioc_cmd.blksz = CARD_BLOCK_SIZE;
> +               mmc_ioc_cmd.blocks = (data_length + mmc_ioc_cmd.blksz - 1) /
> +                       mmc_ioc_cmd.blksz;
> +               mmc_ioc_cmd.arg = 0;
> +               mmc_ioc_cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 |
> MMC_CMD_ADTC;
> +               mmc_ioc_cmd.write_flag = 1;
> +               mmc_ioc_cmd_set_data(mmc_ioc_cmd, data_buff);
> +               ret = ioctl(mmc_fd, MMC_IOC_CMD, &mmc_ioc_cmd);
> +
> +               if (ret) {
> +                       perror("ioctl FW download");
> +                       goto exit;
> +               }
> +       }
> +
> +exit:
> +
> +       return ret;
> +}
> +
> +int do_emmc45_ffu(int nargs, char **argv)
> +{
> +       int fd, fw_fd, ret;
> +       char *device;
> +
> +       CHECK(nargs != 3, "Usage: ffu <image path> </path/to/mmcblkX> \n",
> +               exit(1));
> +
> +       device = argv[2];
> +       fd = open(device, O_RDWR);
> +       if (fd < 0) {
> +               perror("device open error \n");
> +               exit(1);
> +       }
> +
> +       /* open eMMC4.5 firmware image file */
> +       fw_fd = open(argv[1], O_RDONLY);
> +       if (fw_fd < 0) {
> +               perror("open eMMC4.5 firmware file");
> +               ret = -1;
> +               goto exit;
> +       }
> +
> +       ret = ffu_execute(fw_fd, fd);
> +       if (ret)
> +               goto exit;
> +
> +exit:
> +       close(fd);
> +       close(fw_fd);
> +
> +       return ret;
> +}
> +
> diff --git a/mmc_cmds.h b/mmc_cmds.h
> index 3ff3440..1ab9cd5 100644
> --- a/mmc_cmds.h
> +++ b/mmc_cmds.h
> @@ -29,3 +29,4 @@ int do_status_get(int nargs, char **argv);
>  int do_enh_area_set(int nargs, char **argv);
>  int do_write_reliability_set(int nargs, char **argv);
>  int do_emmc50_ffu(int nargs, char **argv);
> +int do_emmc45_ffu(int nargs, char **argv);
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
