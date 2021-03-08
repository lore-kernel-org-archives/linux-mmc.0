Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF044C433DB
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 17:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 849FB65230
	for <linux-mmc@archiver.kernel.org>; Mon,  8 Mar 2021 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhCHRGo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHRGc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 12:06:32 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272BC06174A
        for <linux-mmc@vger.kernel.org>; Mon,  8 Mar 2021 09:06:32 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id 101so3570204uag.1
        for <linux-mmc@vger.kernel.org>; Mon, 08 Mar 2021 09:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDoWGmrOVl7rZdkrxzmJVcDoBJy5ua5BZTw4puY4Qyg=;
        b=I7Jme62a0xK9QZW4vukdWqx4TkwVilI3Wsj9LDBwHJsWLZl4qkrlMdzsGlaJBIjjnf
         8lHS9qE8m/OAHPyq0z9tC4j7Q/oqXm9YvK2qy5IwAb95PxqJdm7xwHJXbK2A3jfzCt0q
         5drmEStirEJiibwu6kAv1dV3OpUBw0Eaw7zsIMue+dlGjmyMweieXY6YLyuP4qoWO6jG
         6hfkcAYSPJBEg05p/m97uTafFHnY9JXeKzits65ytWherOTZPGEvh9FOTQl6WRtbyfNN
         Fvrh6qKsGK//Mza4VQHdlvzP5fG/l7tGKvg2+fQbxf6gLGKZAKhGihFYtrLVSCbJtkp6
         5dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDoWGmrOVl7rZdkrxzmJVcDoBJy5ua5BZTw4puY4Qyg=;
        b=WmJ3SKMRNeLkG1ClMj3Ubue0h4VOL777hvOpoHPfePlZZMyl3BIypUgYSFMXniIZ6E
         V6Ho6naLdD7kNGanyJtpPAjBcpj1/lROArgJ+KiD8mk26Ih+HoHuZPQcpv2r5lVmzr8K
         0h4VcefnNf8mfYzddyKixZjIGpwP6LfCph3B1y6PvSPb4icfgFMItfhjlhuk+qZEnWKv
         BAH+U/MIVkJ6s5WPLz+/5l7WHM7cCuO3t1nzOPtdp2e5yYGlzNj1F0WDzTxzEwwOx+Ft
         a0dO6FtVh6gbKYmXWXG1aMnpf9imMoA/dKK9S5ZdMdkECxJG+AKiChbYcEujrNCRQAcD
         dYOQ==
X-Gm-Message-State: AOAM530ria2exyIkBacTjKkTHcH3TW/oR0Y+ClKckDDzkLISOoGVS9To
        plw6if4K+xo3vOhHUFdyXY6A8sVADI3FWGQ0/Bs9hw==
X-Google-Smtp-Source: ABdhPJzK17GUzESGEXSQjhpoFBU4DHSGlHEfTnjfLiT+vZ/vt+UXKhfSK/1wa2pKucQngc0w/nxL+dsMKigC2hTuly0=
X-Received: by 2002:a9f:3546:: with SMTP id o64mr14117245uao.129.1615223190563;
 Mon, 08 Mar 2021 09:06:30 -0800 (PST)
MIME-Version: 1.0
References: <20210215003249.GA12303@lupo-laptop>
In-Reply-To: <20210215003249.GA12303@lupo-laptop>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 8 Mar 2021 18:05:53 +0100
Message-ID: <CAPDyKFqy5z3a5sCXM8BCrhWQgNCUuOGc4VoOBqVwXnHZSdQaxQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
To:     Luca Porzio <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Zhan Liu <zliua@micron.com>, Luca Porzio <lporzio@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 15 Feb 2021 at 01:33, Luca Porzio <porzio@gmail.com> wrote:
>
> cmdq_en attribute in sysfs now can now be written.
> When 0 is written:
>   CMDQ is disabled and kept disabled across device reboots.
> When 1 is written:
>   CMDQ mode is instantly reneabled (if supported).
>
> Signed-off-by: Luca Porzio <lporzio@micron.com>
> Signed-off-by: Zhan Liu <zliua@micron.com>
> ---
>  drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++---------
>  include/linux/mmc/card.h |   1 +
>  2 files changed, 118 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c

[...]

> +static ssize_t cmdq_en_store(struct device *dev, struct device_attribute *attr,
> +                                const char *buf, size_t count)
> +{
> +       struct mmc_card *card = mmc_dev_to_card(dev);
> +       struct mmc_host *host = card->host;
> +       unsigned long enable;
> +       int err;
> +
> +       if (!card || kstrtoul(buf, 0, &enable))
> +               return -EINVAL;
> +       if (!card->ext_csd.cmdq_support)
> +               return -EOPNOTSUPP;
> +
> +       enable = !!enable;
> +       if (enable == card->ext_csd.cmdq_en)
> +               return count;
> +
> +       mmc_get_card(card, NULL);

This means adding a new path for when the host needs to get locked
(claimed), which is the opposite direction of what we have been
working on for SD/eMMC during the last couple of years.

Please have a look at mmc_blk_issue_drv_op(), where you can find how
these kinds of requests are being funneled through the mmc block
device layer instead. This is the preferred option.

That said, I am actually wondering if we perhaps could manage the
enable/disable of CQE "automagically" for FFU, along the lines of what
we do for RPMB already. In fact, maybe the best/easiest approach is to
*always* disable CQE when there is a request being received through
the mmc ioctl interface. Of course, then if we disabled CQE we should
also re-enable it when the ioctl request has been completed.

What do you think?

> +       card->force_disable_cmdq = !enable;
> +       err = mmc_cmdq_setup(host, card);
> +       mmc_put_card(card, NULL);
> +
> +       if (err)
> +               return err;
> +       else
> +               return count;
> +}
> +
> +static DEVICE_ATTR_RW(cmdq_en);
> +
>

[...]

Kind regards
Uffe
