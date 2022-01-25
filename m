Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A93CC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jan 2022 17:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384164AbiAYRa1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384211AbiAYR3J (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2022 12:29:09 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9C9C06175F
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:07 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id z7so13553532ljj.4
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOdLoZb6zxcFKBR0egQ6Rt2GSJrFCeoRgvKzrW6EbSs=;
        b=kEwXPp2wyswluxqWFHtjE6AS/BWzcPasWFxcdiIgMYI5ieb5w3PUUoDfRks8ifV3za
         UHwV2auqRNPkVZDuFdUpvKEL5l0sozgeAriZT1x45J2xEPObOiMKNFDPnMBE1PCVzKjc
         0V/rpa9YrbKxrEC7XOiHfMRqwmP3r2//ncQV88QTANGvHml7dz959AMpssgQknqvXzaI
         dP6Zd6LoVm/cWHGsQR7yrfq21mKFPsaqZPiX28L6jCPuf/N9gWSyMtRZdWQikR3BxVrS
         WtdIiHtrCFQk4WvtI7tk/qf29L2GrLD0IB1cNCQpdpv6WXzo8WB2NU8hsbF1biv+x752
         TSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOdLoZb6zxcFKBR0egQ6Rt2GSJrFCeoRgvKzrW6EbSs=;
        b=BEqclzrhl3sdlj71ytf2hvMrFhpTGLo/kYHqz5mU5JQfNYcFw51smMxciJZFKwBdXO
         dOz+iMbl/gD+ews2LorL3vWIj/Ib0tg1mR+G9+2kwR+eouW61bOjPd5klKK4C79zPmA5
         dgISMZQ8dQew/DXXhDJTfRxpgAf3/Nh5LvgnTcyGb9/Co1VNCbP7E+e+2a/uZ+sTNo61
         ZXH/T0bdF5dUEVxB2X5ZSgKpeOOld3xmx4TINjBXxL0v9agoW4/rR7Bc4UAtsX1KfM5L
         gLVqXHieABng6RV2YMJcsY+J9zVvf9MmG0aLc4g0qCKmPH9unxa9JqGzZENh2kj80q+R
         FS3g==
X-Gm-Message-State: AOAM531GtvlaSGfGppWSuVCKQJTm4QLniQI3lfWx6GLWdZ3rNZYTuXp0
        G3eBkG+prkjfRSPoQ7PsYxQLfgSy2ui86+21dAErRw==
X-Google-Smtp-Source: ABdhPJzbfxMrOSdh4rN+u2oChAFzokN48rb112dQKUiMWvZ2mmPPYkoBnUZrGGSG+RwUe0yrMuBeitE6c315D3EWeEg=
X-Received: by 2002:a2e:9001:: with SMTP id h1mr10080525ljg.273.1643131745774;
 Tue, 25 Jan 2022 09:29:05 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211224112224epcas5p185573caf2548a464f9aac191c25d01f3@epcas5p1.samsung.com>
 <20211224111917.707440-1-shankar.ma@samsung.com> <20211224111917.707440-2-shankar.ma@samsung.com>
In-Reply-To: <20211224111917.707440-2-shankar.ma@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Jan 2022 18:28:29 +0100
Message-ID: <CAPDyKFqwz8cB1nqAotybYMpp7ioD6d_vQNVTQ0DWkTqKBHKvpQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Enhancement to do_status_get() function for detailed
 Response info
To:     Shankar Athanikar <shankar.ma@samsung.com>
Cc:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net,
        puneet.5@samsung.com, sumeet.paul@samsung.com,
        mohanraj.v@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Dec 2021 at 12:23, Shankar Athanikar <shankar.ma@samsung.com> wrote:
>
> This enhancement covers detailed status register decoding with ERROR/STATUS information when host sends CMD13(with SQS=0)
>
> Signed-off-by : shankar.ma@samsaung.com
> Reviewed-by: mohanraj.v@samsung.com

Please add proper names here and fix the S-o-B tag.

Additionally, you may run checkpatch to get more formatting details
about the patch.

> ---
>  mmc_cmds.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index 5e5e79e..f9f1d52 100644
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
> @@ -869,7 +871,68 @@ int do_status_get(int nargs, char **argv)
>         }
>
>         printf("SEND_STATUS response: 0x%08x\n", response);
> -
> +       if((response >> 31) & 0x01) printf("ERROR: ADDRESS_OUT_OF_RANGE\n");

Rather than having these magic numbers sprinkled across the code, can
you please add defines for them - and use those instead when
comparing.

Along the lines of what is being done for "R1_SWITCH_ERROR" already.

> +       if((response >> 30) & 0x01) printf("ERROR: ADDRESS_MISALIGN\n");
> +       if((response >> 29) & 0x01) printf("ERROR: BLOCK_LEN_ERROR\n");
> +       if((response >> 28) & 0x01) printf("ERROR: ERASE_SEQ_ERROR\n");
> +       if((response >> 27) & 0x01) printf("ERROR: ERASE_PARAM_ERROR\n");
> +       if((response >> 26) & 0x01) printf("ERROR: WP_VOILATION\n");
> +       if((response >> 25) & 0x01) printf("STATUS: DEVICE_IS_LOCKED\n");
> +       if((response >> 24) & 0x01) printf("ERROR: LOCK_UNLOCK_IS_FAILED\n");
> +       if((response >> 23) & 0x01) printf("ERROR: COM_CRC_ERROR\n");
> +       if((response >> 22) & 0x01) printf("ERROR: ILLEGAL_COMMAND\n");
> +       if((response >> 21) & 0x01) printf("ERROR: DEVICE_ECC_FAILED\n");
> +       if((response >> 20) & 0x01) printf("ERROR: CC_ERROR\n");
> +       if((response >> 19) & 0x01) printf("ERROR: ERROR\n");
> +       if((response >> 16) & 0x01) printf("ERROR: CID/CSD OVERWRITE\n");
> +       if((response >> 15) & 0x01) printf("ERROR: WP_ERASE_SKIP\n");
> +       if((response >> 13) & 0x01) printf("ERROR: ERASE_RESET\n");

Please add a newline here.

> +       state = (response >> 9)& 0xF;
> +       switch(state)
> +       {
> +               case 0:
> +                       str = "IDLE";
> +                       break;
> +               case 1:
> +                       str = "READY";
> +                       break;
> +               case 2:
> +                       str = "IDENT";
> +                       break;
> +               case 3:
> +                       str = "STDBY";
> +                       break;
> +               case 4:
> +                       str = "TRANS";
> +                       break;
> +               case 5:
> +                       str = "DATA";
> +                       break;
> +               case 6:
> +                       str = "RCV";
> +                       break;
> +               case 7:
> +                       str = "PRG";
> +                       break;
> +               case 8:
> +                       str = " DIS";

Whitespace.

> +                       break;
> +               case 9:
> +                       str = "BTST";
> +                       break;
> +               case 10:
> +                       str = "SLP" ;
> +                       break;
> +               default:
> +                       printf("Attention : Device state is INVALID: Kindly check the Response\n");
> +                       goto out_free;
> +       }

Please add a newline here.

> +       printf("DEVICE STATE: %s\n",str);
> +       if((response >> 8) & 0x01) printf("STATUS: READY_FOR_DATA\n");
> +       if((response >> 7) & 0x01) printf("ERROR: SWITCH_ERROR\n");
> +       if((response >> 6) & 0x01) printf("STATUS: EXCEPTION_EVENT\n");  /* Check EXCEPTION_EVENTS_STATUS field to understand what further actions are needed*/
> +       if((response >> 5) & 0x01) printf("STATUS: APP_CMD\n");
> +out_free:
>         close(fd);
>         return ret;
>  }
> --
> 2.25.1
>

Kind regards
Uffe
