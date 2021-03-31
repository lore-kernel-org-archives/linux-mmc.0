Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995CEC433C1
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A12461606
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 09:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhCaJbK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 05:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234553AbhCaJbA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 05:31:00 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF0C061574
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:31:00 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id u144so4196697vkb.13
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 02:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B206DLBs5pNzOwU/8DxV6d6XKC69s62Sja9FabTzXRo=;
        b=rd5DW/59utrI6rSPrKyItHnZ8jcE7fbzh9HSRXXS+BFXi6Uzs9L3FSenKBvw4p/DmM
         WZjqXbOYlMzcgJZGa5lQmfNGtRqkgX0UtFoL3RV2cn1HzKuI5/3ew6783VTrfTK3zHcr
         gfthtb2mIrkLucKN9IShoh/R/To/dTaMGl32A8yDorl7xw8xXRJ7goDshqoYlOqAK6iA
         YRIMC43MfLQMY2CJgmDyfeJgKKUbplul9i+bDorUKe9BLt1SsEVwJByDahBaObXU2E8M
         tKMVw3TtxABveMyyRhB1KP+OwFBdTQUYsq0vBWiDMLjMKiHXRSTHcTntkKJgVc0PL8VS
         BR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B206DLBs5pNzOwU/8DxV6d6XKC69s62Sja9FabTzXRo=;
        b=FNGyve3oYJPMMIpQydb3FzTNeY8JBDEj2SRdO27x078QxTHeTXx/uVebcn4wIpKLDY
         wyzY0GfeS5mINIZ7nXlW6fnGTKZmn9WHKuXXoPiT0I4QAPDtJi//NqufAxVUc/WsVXAl
         ry9UQiw5gAGsCpEskXGXgYKIy/5a2ApLVfSkbARVah7FStLRRq14DsYSl5Lpn6Mlb13r
         9BhkX1sDxFQDwZn5iDDN9jxRNmpAxmKzk+MooxrV1cxBQ80xTupYwcCbbQW5/bVS76IX
         CY6yBVbI/5QuS2WNDWZLpj2lw+ZMv0W8SvBE1zIsRl8f5p+ZVVYd2X6PMUBKEwIMU92g
         KlFw==
X-Gm-Message-State: AOAM533tl0/lSHR2G2UUX+HXALBviTARv2PbvjfR5iZgPtB1a33Ew6A8
        oB2hWh3YNFneiRUx/YydIRsxwUlDRZ0y/Uuq9b+NmA==
X-Google-Smtp-Source: ABdhPJzFbprNq/7lspfkQH7+GKX9EQmI1MVogRrAG3+QjqvUOu0V1N8mI6de1OSSr9hdfTgjuHGrSuxzjwpwvt7RMok=
X-Received: by 2002:a1f:2a95:: with SMTP id q143mr1010157vkq.8.1617183059626;
 Wed, 31 Mar 2021 02:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210324164408.14722-1-huobean@gmail.com> <CAPDyKFq8oMH-qga_d+EP2T1xbCbq7PHK=ZkrUp0JaWmdcHYvRg@mail.gmail.com>
 <7a774027-ad2c-21bf-8cb0-eaa92a76bad7@oracle.com>
In-Reply-To: <7a774027-ad2c-21bf-8cb0-eaa92a76bad7@oracle.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 11:30:23 +0200
Message-ID: <CAPDyKFqva-50WytCMRfaFALf_Cy9xoce8pHBBTX7XXirqRKkqQ@mail.gmail.com>
Subject: Re: [External] : Re: [PATCH v2] mmc-utils: Add eMMC erase command support
To:     kimito.sakata@oracle.com
Cc:     Bean Huo <huobean@gmail.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, rkamdar@micron.com,
        Chris Ball <chris@printf.net>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Mar 2021 at 23:36, <kimito.sakata@oracle.com> wrote:
>
>
>
> On 3/30/2021 6:39 AM, Ulf Hansson wrote:
> > On Wed, 24 Mar 2021 at 17:45, Bean Huo <huobean@gmail.com> wrote:
> >> From: Kimito Sakata <kimito.sakata@oracle.com>
> >>
> >> we have been using this erase feature for a while, but it is
> >> still not merged into the upstream mmc-utils. Especially, for
> >> the customer, every time when they update the mmc-utils, they
> >> should re-install this patch again, let's try to make this
> >> erase command upstreamed in the mmc-utils.
> >>
> >> Co-developed-by: Bean Huo <beanhuo@micron.com>
> >> Signed-off-by: Bean Huo <beanhuo@micron.com>
> >> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
> >> ---
> >>
> >> Hi Ulf,
> >> Please help us review this mmc-utils patch, and if agree, it is
> >> possible to make it merged in the official mmc-utils.
> >>
> >> Changelog:
> >>
> >> V1--V2:
> >>      1. refactor Kimito's original patch
> >>      2. change to use MMC_IOC_MULTI_CMD
> >>      3. add checkup if eMMC devie supports secure erase/trim
> >>
> >> ---
> >>   mmc.c      |   8 ++++
> >>   mmc.h      |  13 +++++-
> >>   mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>   mmc_cmds.h |   1 +
> >>   4 files changed, 156 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mmc.c b/mmc.c
> >> index 50c9c9e..cb29a65 100644
> >> --- a/mmc.c
> >> +++ b/mmc.c
> >> @@ -215,6 +215,14 @@ static struct Command commands[] = {
> >>                  "Run Field Firmware Update with <image name> on <device>.\n",
> >>            NULL
> >>          },
> >> +       { do_erase, -4,
> >> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
> >> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
> >> +               "NOTE!: This will delete all user data in the specified region of the device\n"
> >> +               "<type> must be: legacy | discard | secure-erase | "
> >> +               "secure-trim1 | secure-trim2 | trim \n",
> >> +       NULL
> >> +       },
> >>          { 0, 0, 0, 0 }
> >>   };
> >>
> >> diff --git a/mmc.h b/mmc.h
> >> index 648fb26..90b7fb5 100644
> >> --- a/mmc.h
> >> +++ b/mmc.h
> >> @@ -34,7 +34,15 @@
> >>   #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
> >>   #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
> >>   #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
> >> -
> >> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
> >> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
> >> +#define MMC_ERASE              38    /* ac   [31] Secure request
> >> +                                             [30:16] set to 0
> >> +                                             [15] Force Garbage Collect request
> >> +                                             [14:2] set to 0
> >> +                                             [1] Discard Enable
> >> +                                             [0] Identify Write Blocks for
> >> +                                             Erase (or TRIM Enable)  R1b */
> >>   /*
> >>    * EXT_CSD fields
> >>    */
> >> @@ -61,6 +69,7 @@
> >>   #define EXT_CSD_CACHE_SIZE_2           251
> >>   #define EXT_CSD_CACHE_SIZE_1           250
> >>   #define EXT_CSD_CACHE_SIZE_0           249
> >> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
> >>   #define EXT_CSD_BOOT_INFO              228     /* R/W */
> >>   #define EXT_CSD_HC_ERASE_GRP_SIZE      224
> >>   #define EXT_CSD_HC_WP_GRP_SIZE         221
> >> @@ -177,6 +186,8 @@
> >>   #define EXT_CSD_REV_V4_2               2
> >>   #define EXT_CSD_REV_V4_1               1
> >>   #define EXT_CSD_REV_V4_0               0
> >> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> >> +#define EXT_CSD_SEC_ER_EN              (1<<0)
> >>
> >>
> >>   /* From kernel linux/mmc/core.h */
> >> diff --git a/mmc_cmds.c b/mmc_cmds.c
> >> index fb37189..17986e3 100644
> >> --- a/mmc_cmds.c
> >> +++ b/mmc_cmds.c
> >> @@ -2435,6 +2435,141 @@ int do_cache_dis(int nargs, char **argv)
> >>          return do_cache_ctrl(0, nargs, argv);
> >>   }
> >>
> >> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> >> +{
> >> +#ifndef MMC_IOC_MULTI_CMD
> > In kernel v4.4 we added the multi cmd support, which is quite some
> > time ago. So, I think it's time to drop these ifdef hackary from the
> > userland tool. At least, we shouldn't need it for new kinds of
> > features that we add.
> Ulf
> Do you want us to take out the  MMC_IOC_MULTI_CMD ifdef and resubmit?

Yes, please.

Moreover, we should probably also remove all the other #ifndef
MMC_IOC_MULTI_CMD hacks that we currently have in the code. But that's
a separate patch.

> Kimito
>
> >
> >> +       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> >> +                       " support, needed by erase.\n");
> >> +       return -ENOTSUP;
> >> +#else
> >> +       int ret = 0;
> >> +       struct mmc_ioc_multi_cmd *multi_cmd;
> >> +
> > [...]

Kind regards
Uffe
