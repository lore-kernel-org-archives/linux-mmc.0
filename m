Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D206AC77B7E
	for <linux-mmc@archiver.kernel.org>; Tue,  2 May 2023 14:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbjEBOct (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 May 2023 10:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbjEBOcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 May 2023 10:32:48 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07001731
        for <linux-mmc@vger.kernel.org>; Tue,  2 May 2023 07:32:46 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-55a1462f9f6so26388957b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 May 2023 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683037966; x=1685629966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K/9S8w6sFTa6GILgNFmzXECaTf8pY2QzuFGmdKo49z4=;
        b=a8CrsUqqNJYwZQY5NqHO+zTZgByfW4d3Lrn9Jel6hRpXgWKf8OojeG4VUSRHufngr2
         4rHtISOzhxfAs6ALWX9O67ywsIf2V7YXomA1JiI+wkmnJWwcqz8h/Nf9IZNuuV5OyAsa
         BD7HvBQH+hwMRE3K8OBIn9BucC9bLHqI3LEEG+SfO0/z00/Ghg3/LM70xuAEcngllUeG
         shUX3J/MTUMVnOPirMy5pYrK+63JiVJneyF5UBvKnuz66MpV5wiGIlA2WaQ8Kvv4+cWx
         ysqOKg7KXT7OR3lK6ual5T+Ez6SeFH03ZA0ogtXUgp9f3apwnnnsktu3wnOf8/ny0lH4
         Bf5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683037966; x=1685629966;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/9S8w6sFTa6GILgNFmzXECaTf8pY2QzuFGmdKo49z4=;
        b=ikBTi7tDPruEDKt88e1Ksfs4IkXSErafclvV3LuO/UkjsdyQ2ckJA2osh5kEsIunwG
         gWqf7lSIUtdw4fKfPo49BCo1xvwjx7LZwfgfGk67CunccTwCMsW0+aJ7MrPdO0WInOR+
         1NTacNhjMIemAUXDpdf/x4HqHQS2X+2hBMWj/X91hXY16sAJ+zkYTBngFAV4xmXE3uNw
         WiociysOmB+oFiIgIofIxbahXyfODZd5Fe9cNR63jxOKNLOK/G7vJNnfJuVLEXmC3/lk
         21J9wrY2nvU6DbOv5Xy2r5ZMVLAQKLeEuv6ZeogVh7IJuOU8PMUs32ah5PgZ7r3euMx8
         nZqw==
X-Gm-Message-State: AC+VfDwSyJWTN0rsTLMtegHF8tzGBybr+/8bw8M4/rFI4QoZiz2qqPd/
        LTqhMpntbYRerWbBxwhblVmB1VGO09bQVcV0Nx0DUrOX8JlDRQAX
X-Google-Smtp-Source: ACHHUZ57QZAKiVlS6+m+c+PabgA/MZ6dCvjvFla7z07yFMRPlsbaxoIormzWW9l7qPXy3Be7dkx+nUZD4pct+GWh04g=
X-Received: by 2002:a0d:d444:0:b0:55a:a9b6:6da with SMTP id
 w65-20020a0dd444000000b0055aa9b606damr1215123ywd.11.1683037965902; Tue, 02
 May 2023 07:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <59c17ada35664b818b7bd83752119b2d@hyperstone.com>
In-Reply-To: <59c17ada35664b818b7bd83752119b2d@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 May 2023 16:32:10 +0200
Message-ID: <CAPDyKFoUbzjYyQCe5P48cqo5GrGwmjDWdbddnqWjskO8qyB4Zw@mail.gmail.com>
Subject: Re: [PATCHv2] mmc: block: ensure error propagation for non-blk
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 26 Apr 2023 at 18:59, Christian Loehle <CLoehle@hyperstone.com> wrote:
>
> Requests to the mmc layer usually come through a block device IO.
> The exceptions are the ioctl interface, RPMB chardev ioctl
> and debugfs, which issue their own blk_mq requests through
> blk_execute_rq and do not query the BLK_STS error but the
> mmcblk-internal drv_op_result. This patch ensures that drv_op_result
> defaults to an error and has to be overwritten by the operation
> to be considered successful.
>
> The behavior leads to a bug where the request never propagates
> the error, e.g. by directly erroring out at mmc_blk_mq_issue_rq if
> mmc_blk_part_switch fails. The ioctl caller of the rpmb chardev then
> can never see an error (BLK_STS_IOERR, but drv_op_result is unchanged)
> and thus may assume that their call executed successfully when it did not.
>
> While always checking the blk_execute_rq return value would be
> advised, let's eliminate the error by always setting
> drv_op_result as -EIO to be overwritten on success (or other error)
>
> Fixes: 614f0388f580 ("mmc: block: move single ioctl() commands to block requests")
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> v2: Adopted Adrians suggestions to set the error before calling
>         and rewrote commit message
>  drivers/mmc/core/block.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 672ab90c4b2d..0ff294f07465 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -266,6 +266,7 @@ static ssize_t power_ro_lock_store(struct device *dev,
>                 goto out_put;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_BOOT_WP;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(req, false);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         blk_mq_free_request(req);
> @@ -653,6 +654,7 @@ static int mmc_blk_ioctl_cmd(struct mmc_blk_data *md,
>         idatas[0] = idata;
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idatas;
>         req_to_mmc_queue_req(req)->ioc_count = 1;
>         blk_execute_rq(req, false);
> @@ -724,6 +726,7 @@ static int mmc_blk_ioctl_multi_cmd(struct mmc_blk_data *md,
>         }
>         req_to_mmc_queue_req(req)->drv_op =
>                 rpmb ? MMC_DRV_OP_IOCTL_RPMB : MMC_DRV_OP_IOCTL;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = idata;
>         req_to_mmc_queue_req(req)->ioc_count = n;
>         blk_execute_rq(req, false);
> @@ -2808,6 +2811,7 @@ static int mmc_dbg_card_status_get(void *data, u64 *val)
>         if (IS_ERR(req))
>                 return PTR_ERR(req);
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_CARD_STATUS;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         blk_execute_rq(req, false);
>         ret = req_to_mmc_queue_req(req)->drv_op_result;
>         if (ret >= 0) {
> @@ -2846,6 +2850,7 @@ static int mmc_ext_csd_open(struct inode *inode, struct file *filp)
>                 goto out_free;
>         }
>         req_to_mmc_queue_req(req)->drv_op = MMC_DRV_OP_GET_EXT_CSD;
> +       req_to_mmc_queue_req(req)->drv_op_result = -EIO;
>         req_to_mmc_queue_req(req)->drv_op_data = &ext_csd;
>         blk_execute_rq(req, false);
>         err = req_to_mmc_queue_req(req)->drv_op_result;
> --
> 2.37.3
>
>
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
