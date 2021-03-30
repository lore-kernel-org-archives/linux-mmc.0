Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C167EC433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877D260232
	for <linux-mmc@archiver.kernel.org>; Tue, 30 Mar 2021 12:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC3MlE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 30 Mar 2021 08:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhC3Mke (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Mar 2021 08:40:34 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95F6C061574
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 05:40:29 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id b10so3529974vkl.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Mar 2021 05:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ds9FcSwlZjBZpH9IKWHIFU6+52grFgxZjLxM5xeEai4=;
        b=kycPUh9gERxIS9VVd1JTnFLFmwacCi9RG4tgzXnGEvOHG5/Wj4NeJvuuee3Fq51H7v
         1i/u3FJg6tVjzf05Dl/Qf+PXzvSZaNkPBSP+jIjwqHjyYgZYwTjDqZ4vCM8ptp4SD2YP
         vaYVRUBQL9aUMMqN+9wmYMHbz7/iVAvx92lsiRMynIHpp+pELBOMDvwBjILXjlxOqkIX
         nntQkXYPY3j5KBOYiglldqwhZGDQBS+Gr3vefX+zL9mHIxOxynxedfBZUb4SbDpbgptU
         S1udQ/FFvaHIhN6S5sWkpLX+WVQUpjhtbQL18Kc5ETyT4hentypjDt834ECREGHYgaxO
         xaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ds9FcSwlZjBZpH9IKWHIFU6+52grFgxZjLxM5xeEai4=;
        b=tcN0A2ggVOSpyF04pPvH9voRXZ5jLGfyOV5/F1GIqBRkgP2BDcz3thRJh3dgoqBV9x
         YYFE2Cy6Fh7KD7QGNywRf2ApP66XyLXWDQybo1hJz0iMkMRqgByBxDdui55Ph8VTYyFd
         Y3341qO1cIpXd7CrZI+eC1rDeCBGRCdwtkbQc/X3tL3txGfmotkcpTHq6hBv0NBlXJJl
         FK3UrnjcOFxMDo2DwrenYZEUf+jfFSpN8zyVPT3USbMaumEvpCjvABgCOXy9DrMSMxjc
         zVdZtlV14CDM+h0B8gVKo39jwA/mrYVTZNQFumzU2XFtbUKEmEPmRKUWfpiXGlzlJHwS
         6PVw==
X-Gm-Message-State: AOAM533L+jR8FDaXEtclSXN/O64fJnQZF1e62l0jljPdinUh5q3JmCNZ
        izrq+JxVN91ct4hOHQgRF/0goprDXLiz6I8wmng7uw==
X-Google-Smtp-Source: ABdhPJxdkzPQGDmDBvfHDM0xSvUYMmxPRr7+ve+WKJNrhMwwu1yHaRETfUFF/45wrmqjq/v/XaLbRVxMuiAXGcD+evk=
X-Received: by 2002:a1f:b689:: with SMTP id g131mr17319299vkf.6.1617108028858;
 Tue, 30 Mar 2021 05:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210324164408.14722-1-huobean@gmail.com>
In-Reply-To: <20210324164408.14722-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 30 Mar 2021 14:39:52 +0200
Message-ID: <CAPDyKFq8oMH-qga_d+EP2T1xbCbq7PHK=ZkrUp0JaWmdcHYvRg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Add eMMC erase command support
To:     Bean Huo <huobean@gmail.com>
Cc:     "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        kenny.gibbons@oracle.com, kimito.sakata@oracle.com,
        rkamdar@micron.com, Chris Ball <chris@printf.net>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 24 Mar 2021 at 17:45, Bean Huo <huobean@gmail.com> wrote:
>
> From: Kimito Sakata <kimito.sakata@oracle.com>
>
> we have been using this erase feature for a while, but it is
> still not merged into the upstream mmc-utils. Especially, for
> the customer, every time when they update the mmc-utils, they
> should re-install this patch again, let's try to make this
> erase command upstreamed in the mmc-utils.
>
> Co-developed-by: Bean Huo <beanhuo@micron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> Reviewed-by: Kenneth Gibbons <kenny.gibbons@oracle.com>
> ---
>
> Hi Ulf,
> Please help us review this mmc-utils patch, and if agree, it is
> possible to make it merged in the official mmc-utils.
>
> Changelog:
>
> V1--V2:
>     1. refactor Kimito's original patch
>     2. change to use MMC_IOC_MULTI_CMD
>     3. add checkup if eMMC devie supports secure erase/trim
>
> ---
>  mmc.c      |   8 ++++
>  mmc.h      |  13 +++++-
>  mmc_cmds.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |   1 +
>  4 files changed, 156 insertions(+), 1 deletion(-)
>
> diff --git a/mmc.c b/mmc.c
> index 50c9c9e..cb29a65 100644
> --- a/mmc.c
> +++ b/mmc.c
> @@ -215,6 +215,14 @@ static struct Command commands[] = {
>                 "Run Field Firmware Update with <image name> on <device>.\n",
>           NULL
>         },
> +       { do_erase, -4,
> +       "erase", "<type> " "<start address> " "<end address> " "<device>\n"
> +               "Send Erase CMD38 with specific argument to the <device>\n\n"
> +               "NOTE!: This will delete all user data in the specified region of the device\n"
> +               "<type> must be: legacy | discard | secure-erase | "
> +               "secure-trim1 | secure-trim2 | trim \n",
> +       NULL
> +       },
>         { 0, 0, 0, 0 }
>  };
>
> diff --git a/mmc.h b/mmc.h
> index 648fb26..90b7fb5 100644
> --- a/mmc.h
> +++ b/mmc.h
> @@ -34,7 +34,15 @@
>  #define MMC_SET_WRITE_PROT     28    /* ac   [31:0] data addr   R1b */
>  #define MMC_CLEAR_WRITE_PROT   29    /* ac   [31:0] data addr   R1b */
>  #define MMC_SEND_WRITE_PROT_TYPE 31   /* ac   [31:0] data addr   R1  */
> -
> +#define MMC_ERASE_GROUP_START  35    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE_GROUP_END    36    /* ac   [31:0] data addr   R1  */
> +#define MMC_ERASE              38    /* ac   [31] Secure request
> +                                             [30:16] set to 0
> +                                             [15] Force Garbage Collect request
> +                                             [14:2] set to 0
> +                                             [1] Discard Enable
> +                                             [0] Identify Write Blocks for
> +                                             Erase (or TRIM Enable)  R1b */
>  /*
>   * EXT_CSD fields
>   */
> @@ -61,6 +69,7 @@
>  #define EXT_CSD_CACHE_SIZE_2           251
>  #define EXT_CSD_CACHE_SIZE_1           250
>  #define EXT_CSD_CACHE_SIZE_0           249
> +#define EXT_CSD_SEC_FEATURE_SUPPORT    231
>  #define EXT_CSD_BOOT_INFO              228     /* R/W */
>  #define EXT_CSD_HC_ERASE_GRP_SIZE      224
>  #define EXT_CSD_HC_WP_GRP_SIZE         221
> @@ -177,6 +186,8 @@
>  #define EXT_CSD_REV_V4_2               2
>  #define EXT_CSD_REV_V4_1               1
>  #define EXT_CSD_REV_V4_0               0
> +#define EXT_CSD_SEC_GB_CL_EN           (1<<4)
> +#define EXT_CSD_SEC_ER_EN              (1<<0)
>
>
>  /* From kernel linux/mmc/core.h */
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index fb37189..17986e3 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2435,6 +2435,141 @@ int do_cache_dis(int nargs, char **argv)
>         return do_cache_ctrl(0, nargs, argv);
>  }
>
> +static int erase(int dev_fd, __u32 argin, __u32 start, __u32 end)
> +{
> +#ifndef MMC_IOC_MULTI_CMD

In kernel v4.4 we added the multi cmd support, which is quite some
time ago. So, I think it's time to drop these ifdef hackary from the
userland tool. At least, we shouldn't need it for new kinds of
features that we add.

> +       fprintf(stderr, "mmc-utils has been compiled without MMC_IOC_MULTI_CMD"
> +                       " support, needed by erase.\n");
> +       return -ENOTSUP;
> +#else
> +       int ret = 0;
> +       struct mmc_ioc_multi_cmd *multi_cmd;
> +

[...]

Kind regards
Uffe
