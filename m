Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79751C433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521F16128C
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbhEKK6a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhEKK6W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:58:22 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3FC061760
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:15 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id j128so9980444vsc.5
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B87i3Oa6xMCU9YtCHJvcY9CfMfp14jmlxZEy1wOAtO8=;
        b=qoVNtKHlb34ZCkHkI5bASg5apG9Td2/enRlbvfW/GfadtXg+xAde42utpjilMCWisK
         ZF4Youv0ZFdCv8cIYgVV/qp4ODYiXgAgGngo3w3wPAvuls6fKFOP5Uu5P/RGeRubBvRE
         lgyozLkgvZ0U70JdWMPR7+Ge1cK7350ka2M7xqOBDzWB2bClNxiNpaX2b9tt9k6ZK4GT
         DDfkmTKJFxNpEYt59hL6fyk9L6Gtt++nz/qGdH3qf/Sddrg81Vn8D/R9TmIG/7QWCFNX
         ti2kzqesbuQlrHjigc5QjiMPj+pUV71RPeGkR0LFqjRBX9/H71oje970CMxfyz/x4/tC
         +1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B87i3Oa6xMCU9YtCHJvcY9CfMfp14jmlxZEy1wOAtO8=;
        b=CqrQvu4VOCwIWnQCVd9sAD/kLJRghELFhYLNaVqAeR6oQ3YgmR106ErDVlkjvlCGP+
         1QpNvykTpyxxdvhFsZFei1V8hKGsQl8gIGf2Qv5uHYmwG5Srh12I8mUO4rhQdizyhkS5
         P4CWwZK4+Wu2aB5x7wDwreq+2OFhZrpfw7uBdjSR8zKeY4hNE49W0NIT504Kd1OS0KZC
         IYgHqxGfCNDf/727nERsQn3hJ9LmKrs9mBoUh20MtUlIoX4EoySS3TG6AfCq/19sC5R6
         urSCSmiZFUzgJQY9G7gWJ5Q9u7csdFTqdBsuO91wxIkzGycV8Rb8+E6utt0mBmpb9F9F
         t0Pg==
X-Gm-Message-State: AOAM5329qO2NYDvFnT5kKN9GVZNxyqMnsLM2f+WUbTuDXuoPNVBiwJSU
        Vaj0G7e9AjAACnOjvp8M+10ViWnIsFkixuBQ9hg+7A==
X-Google-Smtp-Source: ABdhPJz+PiEzDQL3eclDugXhEH4Et/OShZWE5XPY9Y5wuzjF0QenUZi8BQTWG6efS/ZDfiab8yHeeRd/wIv9FcQ1PEQ=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr24494399vsg.34.1620730634292;
 Tue, 11 May 2021 03:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210504203209.361597-1-huobean@gmail.com>
In-Reply-To: <20210504203209.361597-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 May 2021 12:56:37 +0200
Message-ID: <CAPDyKFq-9G9M0HZjdBgCbrfPJTvq35eqy4NazsJeG8PH5YioPw@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: block: Disable CMDQ on the ioctl path
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Michael Brunner <Michael.Brunner@kontron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 May 2021 at 22:32, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> According to the eMMC Spec:
> "When command queuing is enabled (CMDQ Mode En bit in CMDQ_MODE_EN
> field is set to =E2=80=981=E2=80=99) class 11 commands are the only metho=
d through
> which data transfer tasks can be issued. Existing data transfer
> commands, namely CMD18/CMD17 and CMD25/CMD24, are not supported when
> command queuing is enabled."
> which means if CMDQ is enabled, the FFU commands will not be supported.
> To fix this issue, just simply disable CMDQ on the ioctl path, and
> re-enable CMDQ once ioctl request is completed.
>
> Tested-by: Michael Brunner <Michael.Brunner@kontron.com>
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Applied for next and by adding a fixes/stable tag, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/block.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 689eb9afeeed..21fb99883b1e 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1004,6 +1004,11 @@ static void mmc_blk_issue_drv_op(struct mmc_queue =
*mq, struct request *req)
>
>         switch (mq_rq->drv_op) {
>         case MMC_DRV_OP_IOCTL:
> +               if (card->ext_csd.cmdq_en) {
> +                       ret =3D mmc_cmdq_disable(card);
> +                       if (ret)
> +                               break;
> +               }

This should have a "fallthrough;" statement. No need for a respin, I
have amended the change this time.

>         case MMC_DRV_OP_IOCTL_RPMB:
>                 idata =3D mq_rq->drv_op_data;
>                 for (i =3D 0, ret =3D 0; i < mq_rq->ioc_count; i++) {
> @@ -1014,6 +1019,8 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *=
mq, struct request *req)
>                 /* Always switch back to main area after RPMB access */
>                 if (rpmb_ioctl)
>                         mmc_blk_part_switch(card, 0);
> +               else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
> +                       mmc_cmdq_enable(card);
>                 break;
>         case MMC_DRV_OP_BOOT_WP:
>                 ret =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_=
BOOT_WP,
> --
> 2.25.1
>

Kind regards
Uffe
