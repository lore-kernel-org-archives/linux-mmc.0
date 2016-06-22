From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc-utils: Add Command Queue fields to Extended CSD
Date: Wed, 22 Jun 2016 12:26:26 +0200
Message-ID: <CAPDyKFopB5c5zzsoxU_+dLZ55kSpNhWA0zEQgusqLP+iVnWsEw@mail.gmail.com>
References: <1465547339-10557-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35678 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcFVKca (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 06:32:30 -0400
Received: by mail-lb0-f174.google.com with SMTP id o4so19904513lbp.2
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jun 2016 03:32:29 -0700 (PDT)
In-Reply-To: <1465547339-10557-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 10 June 2016 at 10:28, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Display Command Queue information when printing Extended CSD
> Example:
>
>         # mmc extcsd read /dev/mmcblk0 | grep CMDQ
>         Command Queue Support [CMDQ_SUPPORT]: 0x01
>         Command Queue Depth [CMDQ_DEPTH]: 16
>         Command Enabled [CMDQ_MODE_EN]: 0x01
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  mmc.h      | 3 +++
>  mmc_cmds.c | 9 +++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/mmc.h b/mmc.h
> index 8c77fd5572eb..a3d732c7215c 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -55,6 +55,8 @@
>  #define EXT_CSD_FFU_ARG_2              489     /* RO */
>  #define EXT_CSD_FFU_ARG_1              488     /* RO */
>  #define EXT_CSD_FFU_ARG_0              487     /* RO */
> +#define EXT_CSD_CMDQ_DEPTH             307     /* RO */
> +#define EXT_CSD_CMDQ_SUPPORT           308     /* RO */
>  #define EXT_CSD_NUM_OF_FW_SEC_PROG_3   305     /* RO */
>  #define EXT_CSD_NUM_OF_FW_SEC_PROG_2   304     /* RO */
>  #define EXT_CSD_NUM_OF_FW_SEC_PROG_1   303     /* RO */
> @@ -119,6 +121,7 @@
>  #define EXT_CSD_MODE_CONFIG            30
>  #define EXT_CSD_MODE_OPERATION_CODES   29      /* W */
>  #define EXT_CSD_FFU_STATUS             26      /* R */
> +#define EXT_CSD_CMDQ_MODE_EN           15      /* R/W */
>
>  /*
>   * WR_REL_PARAM field definitions
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 36276106b7bf..295d50541dee 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1723,6 +1723,15 @@ int do_read_extcsd(int nargs, char **argv)
>                 printf("eMMC Firmware Version: %s\n",
>                         (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
>         }
> +
> +       if (ext_csd_rev >= 8) {
> +               printf("Command Queue Support [CMDQ_SUPPORT]: 0x%02x\n",
> +                      ext_csd[EXT_CSD_CMDQ_SUPPORT]);
> +               printf("Command Queue Depth [CMDQ_DEPTH]: %u\n",
> +                      (ext_csd[EXT_CSD_CMDQ_DEPTH] & 0x1f) + 1);
> +               printf("Command Enabled [CMDQ_MODE_EN]: 0x%02x\n",
> +                      ext_csd[EXT_CSD_CMDQ_MODE_EN]);
> +       }
>  out_free:
>         return ret;
>  }
> --
> 1.9.1
>
