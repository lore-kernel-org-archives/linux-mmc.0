Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B9C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 15:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiBQPjT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:39:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242583AbiBQPjT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:39:19 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90482B2E27
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o2so30099lfd.1
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEt/kcSWhMz01lc1dxzOC+Pbmlt2bKi0k0ph/WpfdEE=;
        b=BC64b2pVD2YKqCdRkJfaPBqcDp94GFiFruXeyFr+6xVVsNYRuPeTFQ1pHyj7Yu4dmJ
         w6CeqI6SHwAcyrA0hLWPoyMEalr4heTyJUby/67kUFX9rmbQr1WtiSORTEbXuePwDAti
         2lFc87cVjz3K0SCKWWAD+lKQkzVsKiV9UCUwCB6c95Im9U3xEUTn7pN+ySJdF27Oyj0x
         Ri1i/dTBGsfCnrp0JEOEP6ncJllqf32G4yEU//kheqchBKENRjE8wPK0vF+WsoFRK93R
         pLeVEeOmr0gvjdoqVywHOn8fWRK49TNm/aRoxOyopVwvnaBPYNVUc05IGrk/354IP8d4
         ZlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEt/kcSWhMz01lc1dxzOC+Pbmlt2bKi0k0ph/WpfdEE=;
        b=KBOiizbL28tOCFGef0lc3eTvIkOKcTctT+59AfRnxGrHbR1Dl85YgRPU9QUm7lwlYm
         JstP/ldfzU0WfK4wQU+2DFSeNb74XkH0Kv83oyKoghh5RgoXtVtkcs91sLcRaozdpVQy
         qC3PgTqTzoam+atVYOYhBqR1IbLH8LuO4eCSFZtsGjqMB1Bi1/sKUnfetAiOXrz9zrB0
         h4Yr8kUiiWf9PvDA/PctqwoN31n2XMneYC0ebjblAJ2b5amERRxRcwYkAE6Ks3xihNmH
         SWa6/43JjPUlk+JlsmId66nAAx8zHrSMsi4pQnXBGcttLywG0g6Au3m1+DEzhbMKLVF1
         2q4Q==
X-Gm-Message-State: AOAM530dZD8Z2xskhki5Va7E6bGtPreR6gEvEMRkAkzLp9E1mp3WfvE1
        XcO4v/dG+0QkfW+GfzD2LwHHfWBrBnr8fEBD+xSK5Q==
X-Google-Smtp-Source: ABdhPJwZ/2tlY9PZQOaUOQaCRB8jjd7rLd+4kFZzZ4UlPuU5xY3ovFM28WvGshxw97KwOIjOUpRhu8Vh4uDdrLaZokU=
X-Received: by 2002:ac2:5de4:0:b0:443:5b80:d4c4 with SMTP id
 z4-20020ac25de4000000b004435b80d4c4mr2412510lfq.373.1645112341995; Thu, 17
 Feb 2022 07:39:01 -0800 (PST)
MIME-Version: 1.0
References: <CGME20220211120808epcas5p31f6a3bf93945f34d23840ed9e455f8ab@epcas5p3.samsung.com>
 <20220211120449.195052-1-shankar.ma@samsung.com>
In-Reply-To: <20220211120449.195052-1-shankar.ma@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:38:25 +0100
Message-ID: <CAPDyKFqN=7-nWSggUO9o1Wrs2yoSbbNOabG7yNXn-bCWVxhang@mail.gmail.com>
Subject: Re: [PATCH v2] Enhancement to do_status_get() function for detailed
 Response info
To:     Shankar Athanikar <shankar.ma@samsung.com>
Cc:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net,
        puneet.5@samsung.com, sumeet.paul@samsung.com,
        akhilesh.j@samsung.com,
        Mohan Raj Veerasamy <mohanraj.v@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Feb 2022 at 14:53, Shankar Athanikar <shankar.ma@samsung.com> wrote:
>
> This enhancement covers detailed status register decoding with
> ERROR/STATUS information when host sends CMD13(with SQS=0)
>
> Signed-off-by: Shankar Athanikar <shankar.ma@samsung.com>
> Reviewed-by: Mohan Raj Veerasamy <mohanraj.v@samsung.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
> change log V1 -> V2
>
> 1. Added #defines for R1 Response device status fields.
> 2. Code cleanup and addressed Review comments from Ulf
> Hansson<ulf.hansson@linaro.org>.
> ---
>  mmc.h      | 22 ++++++++++++++
>  mmc_cmds.c | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 1 deletion(-)
>
> diff --git a/mmc.h b/mmc.h
> index e9766d7..193dfee 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -44,6 +44,28 @@
>                                               [1] Discard Enable
>                                               [0] Identify Write Blocks for
>                                               Erase (or TRIM Enable)  R1b */
> +
> +#define R1_OUT_OF_RANGE         (1 << 31)       /* er, c */
> +#define R1_ADDRESS_ERROR        (1 << 30)       /* erx, c */
> +#define R1_BLOCK_LEN_ERROR      (1 << 29)       /* er, c */
> +#define R1_ERASE_SEQ_ERROR      (1 << 28)       /* er, c */
> +#define R1_ERASE_PARAM          (1 << 27)       /* ex, c */
> +#define R1_WP_VIOLATION         (1 << 26)       /* erx, c */
> +#define R1_CARD_IS_LOCKED       (1 << 25)       /* sx, a */
> +#define R1_LOCK_UNLOCK_FAILED   (1 << 24)       /* erx, c */
> +#define R1_COM_CRC_ERROR        (1 << 23)       /* er, b */
> +#define R1_ILLEGAL_COMMAND      (1 << 22)       /* er, b */
> +#define R1_CARD_ECC_FAILED      (1 << 21)       /* ex, c */
> +#define R1_CC_ERROR             (1 << 20)       /* erx, c */
> +#define R1_ERROR                (1 << 19)       /* erx, c */
> +#define R1_CID_CSD_OVERWRITE    (1 << 16)       /* erx, c, CID/CSD overwrite */
> +#define R1_WP_ERASE_SKIP        (1 << 15)       /* sx, c */
> +#define R1_CARD_ECC_DISABLED    (1 << 14)       /* sx, a */
> +#define R1_ERASE_RESET          (1 << 13)       /* sr, c */
> +#define R1_READY_FOR_DATA       (1 << 8)        /* sx, a */
> +#define R1_EXCEPTION_EVENT      (1 << 6)        /* sr, a */
> +#define R1_APP_CMD              (1 << 5)        /* sr, c */
> +
>  /*
>   * EXT_CSD fields
>   */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index f024079..94916d2 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -848,6 +848,8 @@ int do_status_get(int nargs, char **argv)
>         __u32 response;
>         int fd, ret;
>         char *device;
> +       const char *str;
> +       __u8 state;
>
>         if (nargs != 2) {
>                 fprintf(stderr, "Usage: mmc status get </path/to/mmcblkX>\n");
> @@ -869,7 +871,90 @@ int do_status_get(int nargs, char **argv)
>         }
>
>         printf("SEND_STATUS response: 0x%08x\n", response);
>
> +       if (response & R1_OUT_OF_RANGE)
> +               printf("ERROR: ADDRESS_OUT_OF_RANGE\n");
> +       if (response & R1_ADDRESS_ERROR)
> +               printf("ERROR: ADDRESS_MISALIGN\n");
> +       if (response & R1_BLOCK_LEN_ERROR)
> +               printf("ERROR: BLOCK_LEN_ERROR\n");
> +       if (response & R1_ERASE_SEQ_ERROR)
> +               printf("ERROR: ERASE_SEQ_ERROR\n");
> +       if (response & R1_ERASE_PARAM)
> +               printf("ERROR: ERASE_PARAM_ERROR\n");
> +       if (response & R1_WP_VIOLATION)
> +               printf("ERROR: WP_VOILATION\n");
> +       if (response & R1_CARD_IS_LOCKED)
> +               printf("STATUS: DEVICE_IS_LOCKED\n");
> +       if (response & R1_LOCK_UNLOCK_FAILED)
> +               printf("ERROR: LOCK_UNLOCK_IS_FAILED\n");
> +       if (response & R1_COM_CRC_ERROR)
> +               printf("ERROR: COM_CRC_ERROR\n");
> +       if (response & R1_ILLEGAL_COMMAND)
> +               printf("ERROR: ILLEGAL_COMMAND\n");
> +       if (response & R1_CARD_ECC_FAILED)
> +               printf("ERROR: DEVICE_ECC_FAILED\n");
> +       if (response & R1_CC_ERROR)
> +               printf("ERROR: CC_ERROR\n");
> +       if (response & R1_ERROR)
> +               printf("ERROR: ERROR\n");
> +       if (response & R1_CID_CSD_OVERWRITE)
> +               printf("ERROR: CID/CSD OVERWRITE\n");
> +       if (response & R1_WP_ERASE_SKIP)
> +               printf("ERROR: WP_ERASE_SKIP\n");
> +       if (response & R1_ERASE_RESET)
> +               printf("ERROR: ERASE_RESET\n");
> +
> +       state = (response >> 9) & 0xF;
> +       switch (state) {
> +       case 0:
> +               str = "IDLE";
> +               break;
> +       case 1:
> +               str = "READY";
> +               break;
> +       case 2:
> +               str = "IDENT";
> +               break;
> +       case 3:
> +               str = "STDBY";
> +               break;
> +       case 4:
> +               str = "TRANS";
> +               break;
> +       case 5:
> +               str = "DATA";
> +               break;
> +       case 6:
> +               str = "RCV";
> +               break;
> +       case 7:
> +               str = "PRG";
> +               break;
> +       case 8:
> +               str = "DIS";
> +               break;
> +       case 9:
> +               str = "BTST";
> +               break;
> +       case 10:
> +               str = "SLP";
> +               break;
> +       default:
> +               printf("Attention : Device state is INVALID: Kindly check the Response\n");
> +               goto out_free;
> +       }
> +
> +       printf("DEVICE STATE: %s\n", str);
> +       if (response & R1_READY_FOR_DATA)
> +               printf("STATUS: READY_FOR_DATA\n");
> +       if (response & R1_SWITCH_ERROR)
> +               printf("ERROR: SWITCH_ERROR\n");
> +       if (response & R1_EXCEPTION_EVENT)
> +               printf("STATUS: EXCEPTION_EVENT\n");  /* Check EXCEPTION_EVENTS_STATUS fields for further actions */
> +       if (response & R1_APP_CMD)
> +               printf("STATUS: APP_CMD\n");
> +out_free:
>         close(fd);
>         return ret;
>  }
>
> --
> 2.25.1
