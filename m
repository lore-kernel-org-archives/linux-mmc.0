Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFE4C433E7
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7632071B
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0KHXRDt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBJEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgIBJEE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:04:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7491BC06124F
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:04:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id q13so2148721vsj.13
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hFnfq76GlnsUYLxeV0fKqnYc2qmykFYSJOcJXdU/GGk=;
        b=N0KHXRDtwYgxVI4n0o099cYfeLkcI4F7PipVrxLx0iYnKFfBhKor9MYqScRo5TyAbK
         rV4KCiPzj2lt4a3gg2qucLoNE57VSPmACia+ffSBqz7/DGBHgfRbcclvWl09zsAHllDq
         GO7AGWM5jyTOwqUP4gUF5qtUPvXUCHp4434AYzgEQdZCLPbRtImYmg13LihPzeC+/1br
         PwZzDfr/O+ubvpD/LEWEoKocxSm9drxEQM+tB7XVHS/ytNH26cuRFe4URiXue8deNKdq
         cahqc04wc7/PAnFAbgEm5vcUtOUAyYyQAqN2c7MAloeaIGTkACYLdKz/KHv39nDDo45E
         yXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFnfq76GlnsUYLxeV0fKqnYc2qmykFYSJOcJXdU/GGk=;
        b=NGCu6giqowG9HClsI41Y+TpqKJWa+P2P4VT2CW9YtTx/WYbBvczxkafBLm8udcsseA
         8ReCtOp0ncYz2zSwNhVreX8v4BGvhdblwAzSUoOFZUXTOaeTJoTMT1ULUm/ZogryxUvS
         J/I8EDgVJlxNBlKgheX9YgqLMbHWEh03ge4ASxQqWUF6OccDZwPog4lvtOSMfUJhxhGO
         pZDaHzLkvtmgE73uHQtkICBCkQvcsOc1BFE5RBiPCaK7Fn06f73hCrJFzOY4paNtuM+6
         /odi2OxMkRhPauquw/9dbCLtG+/FMtX6ZaPKJwVHqkpELYQj/Pogo/+Up6u1B+sHoiT5
         LJaw==
X-Gm-Message-State: AOAM532mHJaswg+2j2L0iY01BplHXGS7A4E++A52DbphHU00tiaE54Ia
        VweAt0HQVrFYbwRzsR2X2OzpMqiirMJ9nLA1LLfIuQX3YARWpA==
X-Google-Smtp-Source: ABdhPJxvNkCHqkXeW6+ncgi9B+yO4U+7Pipy1zHbUW8fR1FyXHaqe/R4OuugY6ftNvPRbMGxAdOqpJOUH7HNDNC0i9M=
X-Received: by 2002:a67:b44a:: with SMTP id c10mr4492088vsm.35.1599037443576;
 Wed, 02 Sep 2020 02:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com> <20200901085004.2512-2-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200901085004.2512-2-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:27 +0200
Message-ID: <CAPDyKFoMcxxm5=tNmn8b9xU+xRYUchz5pXOMZQUed8gR9G-Hrw@mail.gmail.com>
Subject: Re: [PATCH mmc-next v4 2/2] mmc: allow setting slot index via device
 tree alias
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Sep 2020 at 10:50, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As with GPIO, UART and others, allow specifying the device index via the
> aliases node in the device tree.
>
> On embedded devices, there is often a combination of removable (e.g.
> SD card) and non-removable MMC devices (e.g. eMMC).
> Therefore the index might change depending on
>
> * host of removable device
> * removable card present or not
>
> This makes it difficult to hardcode the root device, if it is on the
> non-removable device. E.g. if SD card is present eMMC will be mmcblk1,
> if SD card is not present at boot, eMMC will be mmcblk0.
>
> Alternative solutions like PARTUUIDs do not cover the case where multiple
> mmcblk devices contain the same image. This is a common issue on devices
> that can boot both from eMMC (for regular boot) and SD cards (as a
> temporary boot medium for development). When a firmware image is
> installed to eMMC after a test boot via SD card, there will be no
> reliable way to refer to a specific device using (PART)UUIDs oder
> LABELs.
>
> The demand for this feature has led to multiple attempts to implement
> it, dating back at least to 2012 (see
> https://www.spinics.net/lists/linux-mmc/msg26586.html for a previous
> discussion from 2014).
>
> All indices defined in the aliases node will be reserved for use by the
> respective MMC device, moving the indices of devices that don't have an
> alias up into the non-reserved range. If the aliases node is not found,
> the driver will act as before.
>
> This is a rebased and cleaned up version of
> https://www.spinics.net/lists/linux-mmc/msg26588.html .
>
> Based-on-patch-by: Sascha Hauer <s.hauer@pengutronix.de>
> Link: https://lkml.org/lkml/2020/8/5/194
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v4:
> - minor adjustments to commit message
>
> v3:
> - remove unneeded mmcblock changes
> - remove most helper functions to simplify code
> - extended commit message
>
> v2:
> - fix missing symbols for modular mmcblock
>
>
>
>  drivers/mmc/core/host.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index c8fae6611b73..96b2ca1f1b06 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -376,6 +376,20 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
>  }
>  EXPORT_SYMBOL(mmc_of_parse_voltage);
>
> +/**
> + * mmc_first_nonreserved_index() - get the first index that is not reserved
> + */
> +static int mmc_first_nonreserved_index(void)
> +{
> +       int max;
> +
> +       max = of_alias_get_highest_id("mmc");
> +       if (max < 0)
> +               return 0;
> +
> +       return max + 1;
> +}
> +
>  /**
>   *     mmc_alloc_host - initialise the per-host structure.
>   *     @extra: sizeof private data structure
> @@ -387,6 +401,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>  {
>         int err;
>         struct mmc_host *host;
> +       int alias_id, min_idx, max_idx;
>
>         host = kzalloc(sizeof(struct mmc_host) + extra, GFP_KERNEL);
>         if (!host)
> @@ -395,7 +410,16 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
>         /* scanning will be enabled when we're ready */
>         host->rescan_disable = 1;
>
> -       err = ida_simple_get(&mmc_host_ida, 0, 0, GFP_KERNEL);
> +       alias_id = of_alias_get_id(dev->of_node, "mmc");
> +       if (alias_id >= 0) {
> +               min_idx = alias_id;
> +               max_idx = alias_id + 1;
> +       } else {
> +               min_idx = mmc_first_nonreserved_index();
> +               max_idx = 0;
> +       }
> +
> +       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
>         if (err < 0) {
>                 kfree(host);
>                 return NULL;
> --
> 2.17.1
>
