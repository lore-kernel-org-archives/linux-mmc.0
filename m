Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4B3C77B60
	for <linux-mmc@archiver.kernel.org>; Thu, 23 Mar 2023 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjCWMOl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 23 Mar 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCWMON (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Mar 2023 08:14:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD6726C2C
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:53 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5445009c26bso391112097b3.8
        for <linux-mmc@vger.kernel.org>; Thu, 23 Mar 2023 05:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NUhHXs8R1NOZ/R53KEOol5IeNGSDhjZDeG5ZzuZqONw=;
        b=BGIMIGWqvwYafgFF8A9+5+Zg698xXFfNsuHAXSn4dk37zJwIvhFx9dOOJ2qKU1WsOp
         s8p97JWF2o99XXKLYT8bjps7bFfyKI1KmpZi6WKZClT7q/ZV2uDCf3fv+szsrp96gU0/
         wGMgBDvT9hXwGJWt88UAVlzcEw9pnIhVHBPKxDsE/IWf1X2omZld81b3m9ARCM8w6AIt
         9hUKxj0nlVZGzkWPuS1AEOMOv4fctKFKM4dAQPThBmrd1SKNyEWR51k6aiSOZhD5rOAL
         LJueHPvXD7VyWEX2hWKquuoy4et+SX7Tr+xTv6lvCI2ANYJxIBz82C1oybkX05Zmj6DM
         MJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573632;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUhHXs8R1NOZ/R53KEOol5IeNGSDhjZDeG5ZzuZqONw=;
        b=fzu5cwywNNLOJuZaoHdxKlkuco5r9vLYWejzbOWa9CUIfCLtiDDLWVoVTSYck8nbU0
         8bgz3QN6z2aci3ZzQORrphwD2d1zE/5c4yPXbR9KwrHkM0UKI6Y5EPDB/Jem4McRSAHh
         BFEp8PBp3DpPCwnBK4tUmGjbxK0O+m6mqLkvAROthfSpgjCGj0erpCzCCQKcDMQNBP4y
         9Tad/5XXGHX7iLyhDmBXxeUXDYJFZ/b6cWaxGYOXSJOaCSVb7/wEdH9usuBt/bZ1P/IT
         4R/nCrBcuPhQduOQD+ZJTnrr7zOqqXuKfetTd3nLTcS01qju4ZHXRhMgNgWT1I7tMEvm
         Comg==
X-Gm-Message-State: AAQBX9cKg0R+ofkmlkZ4ujvEfYO4Xl1gaD2BEFd2pVGvQPyW/pfgY9Vl
        PX9T7lcIScgq9pyt5vjtU7b4npGX+R3eINPMFkQzbA==
X-Google-Smtp-Source: AKy350aoc3BnCD04/g3SIKEUr1A1baWFs1iFl/gJRxPCQoD99WPcXJEwWkaMbtO98JIhZVQG6NvsFgcVGi3qiNHQdz4=
X-Received: by 2002:a81:b307:0:b0:544:6828:3c09 with SMTP id
 r7-20020a81b307000000b0054468283c09mr1833488ywh.0.1679573632392; Thu, 23 Mar
 2023 05:13:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230317064729.24407-1-yuzhe@nfschina.com>
In-Reply-To: <20230317064729.24407-1-yuzhe@nfschina.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:16 +0100
Message-ID: <CAPDyKFqzz_w3jwn_jSexFP15cNeym=rac3KcTbsoPo2OeiSGaw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: remove unnecessary (void*) conversions
To:     Yu Zhe <yuzhe@nfschina.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Mar 2023 at 07:48, Yu Zhe <yuzhe@nfschina.com> wrote:
>
> Pointer variables of void * type do not require type cast.
>
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c  | 2 +-
>  drivers/mmc/core/host.c     | 2 +-
>  drivers/mmc/core/mmc_test.c | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index fe6808771bc7..2c97b94aab23 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -246,7 +246,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(mmc_err_state, mmc_err_state_get, NULL, "%llu\n");
>
>  static int mmc_err_stats_show(struct seq_file *file, void *data)
>  {
> -       struct mmc_host *host = (struct mmc_host *)file->private;
> +       struct mmc_host *host = file->private;
>         const char *desc[MMC_ERR_MAX] = {
>                 [MMC_ERR_CMD_TIMEOUT] = "Command Timeout Occurred",
>                 [MMC_ERR_CMD_CRC] = "Command CRC Errors Occurred",
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 096093f7be00..76900f67c782 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -590,7 +590,7 @@ EXPORT_SYMBOL(mmc_alloc_host);
>
>  static void devm_mmc_host_release(struct device *dev, void *res)
>  {
> -       mmc_free_host(*(struct mmc_host **)res);
> +       mmc_free_host(res);
>  }
>
>  struct mmc_host *devm_mmc_alloc_host(struct device *dev, int extra)
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 156d34b2ed4d..0f6a563103fd 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3045,7 +3045,7 @@ static LIST_HEAD(mmc_test_file_test);
>
>  static int mtf_test_show(struct seq_file *sf, void *data)
>  {
> -       struct mmc_card *card = (struct mmc_card *)sf->private;
> +       struct mmc_card *card = sf->private;
>         struct mmc_test_general_result *gr;
>
>         mutex_lock(&mmc_test_lock);
> @@ -3079,8 +3079,8 @@ static int mtf_test_open(struct inode *inode, struct file *file)
>  static ssize_t mtf_test_write(struct file *file, const char __user *buf,
>         size_t count, loff_t *pos)
>  {
> -       struct seq_file *sf = (struct seq_file *)file->private_data;
> -       struct mmc_card *card = (struct mmc_card *)sf->private;
> +       struct seq_file *sf = file->private_data;
> +       struct mmc_card *card = sf->private;
>         struct mmc_test_card *test;
>         long testcase;
>         int ret;
> --
> 2.11.0
>
