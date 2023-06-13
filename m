Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865F8C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 12:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbjFMMNd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjFMMNc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 08:13:32 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33336CE
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:13:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc4114d44a8so3520615276.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658410; x=1689250410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9TP9yVbXYrWbM9qiIbP7E6bmeYF95/za+6yxa/EUie0=;
        b=HTGCAMk9XvnDW+PLeQoW1zebFPqJjEr6sJiboeyA9JwL3z2266O8X7wCsW+XJmTGrk
         8O7Kz83tTBh+eAJfBWW2oP3lOzQ6msp2ajDE7yLexioTSfhFJ5jSwszXz+8/TZJAjiaF
         U63Hi5iGuVevTjHL3KVYc6CtMDiTK0iKvuoNPOABNST725CB/FMiMF4+1Vq+JnPTdkCL
         Mr3iH/UrK9Dqn/0mnFz6YZymY1p2O0KQl6Oiigw5qVH+Y6dP7bWSGczUwopkkKU4CJMJ
         GtDGsMNxFSGLPCKLZDLkZsKa4n6i0vW9/u+B/svDXxVWWXJlXhJDtZfFNZvIX4/YGNlm
         0Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658410; x=1689250410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9TP9yVbXYrWbM9qiIbP7E6bmeYF95/za+6yxa/EUie0=;
        b=dx5N4QNLiEWu8d4fRt7iPPy69Cw9G+6gTl0xKB3Lu2yxZMkZr7WKaGdlKgjDB9+zXp
         6PMXtkksFmI+eMv7Ga/EVTRegclApi2AxnYE7y8B6gsS42FKz6K42SiT2QmJ50Q82b7C
         HZtYA+PB5N7o5lca5RVJF46OX9JbY/7kdVfQhomcvi+T4PMUOZW5K+tISJjdDMG3Ge4d
         WCZBYG+FMlCrPLrcFZhVWFpbrBxsvBma6+grN740VUcHim8eZeZj7420M0OA+Lrt/YgA
         KGTthObaXZhMvpzSBqttykhOG796p6oq+IFfk3f5/XraXl5eI+soeGMaN/3aFmSxYTJH
         3Few==
X-Gm-Message-State: AC+VfDyY5MYHtMu1G/ElpFZCBdr2YAwqB/yqsGAPiy+QZqsKX53LnK11
        30tvyk1XFTFmjU2BsHT8Qif3/xJY324Hcmit79pMkw==
X-Google-Smtp-Source: ACHHUZ6WCI15IGB0NY3kTubXSVzuNUUjrrS8z1t+kakxDoYryk6lKbhtbQQHoY1hW8MOyJ+x+0XbDbp5OStKvRjLZ/k=
X-Received: by 2002:a25:a148:0:b0:bb3:9255:33e9 with SMTP id
 z66-20020a25a148000000b00bb3925533e9mr1125606ybh.53.1686658410228; Tue, 13
 Jun 2023 05:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230612143730.210390-1-ulf.hansson@linaro.org> <1b1edc4e-a318-4d55-c99e-eb9a47f9833f@foss.st.com>
In-Reply-To: <1b1edc4e-a318-4d55-c99e-eb9a47f9833f@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 14:12:54 +0200
Message-ID: <CAPDyKFpS3PCD5VBmBYN0fy_HqVGMWc-w2A8z_ciDABF9x4oK5g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: Set PROBE_PREFER_ASYNCHRONOUS
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Vasut <marex@denx.de>, Dennis Zhou <dennis@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 13 Jun 2023 at 13:43, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> On 6/12/23 16:37, Ulf Hansson wrote:
> > All mmc host driver should have enabled the asynchronous probe option, but
> > it seems like we missed to set it for mmci, so let's do that now.
> >
> > Fixes: 21b2cec61c04 ("mmc: Set PROBE_PREFER_ASYNCHRONOUS for drivers that existed in v4.4")
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >   drivers/mmc/host/mmci.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> > index f2b2e8b0574e..97a77eefb11a 100644
> > --- a/drivers/mmc/host/mmci.c
> > +++ b/drivers/mmc/host/mmci.c
> > @@ -2455,6 +2455,7 @@ static struct amba_driver mmci_driver = {
> >       .drv            = {
> >               .name   = DRIVER_NAME,
> >               .pm     = &mmci_dev_pm_ops,
> > +             .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >       },
> >       .probe          = mmci_probe,
> >       .remove         = mmci_remove,
>
> Hi Ulf,
>
> I've tested that on a STM32MP eval board.
> It boots OK.
>
> Just a warning for other users of this updated driver: if there are
> several MMC devices on the board, we can no more rely on the order of probe.
> For example, this board has an SD-card and an eMMC. Before this patch
> mmc0 was the SD-card, mmc1 the eMMC. Now the order has changed on the
> boot I've tested.
> It shouldn't be an issue, as filesystems use UUIDs. Maybe for some tools
> or tests.

Note that the order was not guaranteed even before. It was mostly due
to luck, in that case.

UUIDs is preferred, but we also have the mmc aliases that can be used
in DT. This allows us to specify a specific index for the mmc-host
(which always becomes the same id for the later detected block
device).

>
> Anyway, the patch is OK for me.
> You can add my:
> Tested-by: Yann Gautier <yann.gautier@foss.st.com>

Thanks a lot!

Kind regards
Uffe
