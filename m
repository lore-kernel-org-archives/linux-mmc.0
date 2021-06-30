Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0EC11F69
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D65961476
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbhF3Wfz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhF3Wfz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 18:35:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED09C0617A8
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 15:33:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u25so5469281ljj.11
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmMtEYQ6S0dKzm7scFp5Sxf68YROktjdsnzfUYcQBhk=;
        b=kfMdn/+DiE/hYKtQAkcx10sknZqEoddTeQ2TYjIAmWwdYV1r1lE103QPLEZnYF8SDf
         u9K5Jjbm+bgxTRuEMiquhCkdWq7aR+JrLOsrY9tdiEKg06+Z6iHlBRzS38qiD+79xmfl
         1JhbpZ4AWGS+P1xRVIKzQVHmw4L5hllgkxHJUBzpEQWODX7SoxUxEhi45Fv1pp5wKf8w
         JXjz1wcacRYaCcyTkGHlt7xbm3xjZtApsWJRHC1nMnkx5BbIn38NssvV3hW7cTLstB0j
         OgK+MEjEPY8+G8QK4fMYlZO+UYGpi6ZahR8BX68caD0ZPw68IKT6/uolOPrZSkXHLExJ
         7HWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmMtEYQ6S0dKzm7scFp5Sxf68YROktjdsnzfUYcQBhk=;
        b=jKd+2WgBSn49w37j/wgWF0NrCiDbxDBfGCnVEdXTm2q4ZtSdLHubzgvNru5Kydb7Gx
         9g/TqG/fJi4AB3OExwKqeJBlus0ARMo4lbtBQMmqV62u5qGpT6b+iO14WeyjiOMvn4F4
         uaQxW83oldxx2cv9WhbcouWQdR/eVY9HzZLGtdYE1nqndL6xOg7iEQPu7z6xFaXI4jbs
         mhKW8wGc62WVpBsiXSKS7/MUcvnuVlzSEBDP89MtpB1eBXf9f4Nve4fT5BBqSe183aj+
         pm0nSguFX/aMAeFdmHoWVrYZCCDCcNhdT+Gm4lDzSsu3F9g2+7y/BPzox7ILLUrgkQyb
         govA==
X-Gm-Message-State: AOAM533OCrbgR9mfuCABzTyrb1KSJPxmVD2GX7Jk+y+dCRRBLVEkvY+1
        0GXDHXiLGfPdgf9b4NV6yjBspXyj+HWQe5iFk1bL0w==
X-Google-Smtp-Source: ABdhPJwaxyd1gEtex9L2Kwb+jljmlXTOSQeK34Yv94mrI1exRNPetLvXTw6m43nkszAjt8moy6LAYWiXdENRPig41ok=
X-Received: by 2002:a05:651c:603:: with SMTP id k3mr9455826lje.368.1625092402941;
 Wed, 30 Jun 2021 15:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210628232955.3327484-1-linus.walleij@linaro.org>
 <CAPDyKFpfJC=KAZ5dGAso2zcgBic4uCkOiDFQ0ZA5Zi7UDUeEug@mail.gmail.com>
 <CACRpkdY4kegTzeqPHNEd3=hOdqSXAvJq+LehLbf09mUybU0VfA@mail.gmail.com>
 <CAPDyKFoj47-4XuKbV6jYkJ2pesAfHK999vudWDGTQA-J5eQXrg@mail.gmail.com>
 <CACRpkdYX5RiUy7u_SeCqhytbyL1Ta9iVmx500uwAq8sNmW+3Ug@mail.gmail.com> <CAPDyKForEi09uyXL4nDn27bth+btEYAhzd6+YusMrRBygCdtEA@mail.gmail.com>
In-Reply-To: <CAPDyKForEi09uyXL4nDn27bth+btEYAhzd6+YusMrRBygCdtEA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Jul 2021 00:33:11 +0200
Message-ID: <CACRpkda7m6HnA7y9coYoXd9YFNjSzAfuYiLNURHe1geb8rF++Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add a card quirk for broken boot partitions
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>, phone-devel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>, newbyte@disroot.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jun 30, 2021 at 5:28 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> >         /* Handle busy detection on DAT0 if the variant supports it. */
> >         if (busy_resp && host->variant->busy_detect)
> >                 if (!host->ops->busy_complete(host, status, err_msk))
> >                         return;
> >
> > These seemed to be especially problematic to me.
>
> Yes, exactly. The IRQ based busy detection code gets disabled with my
> debug patch.
>
> It looks like there are some race conditions in the HW busy detection
> path for mmci, which gets triggered by this eMMC card.
(...)
> Although, it's more optimal to receive an IRQ when busy on DAT0 is
> de-asserted, rather than polling with ->card_busy(). Hence we also
> have MMC_CAP_WAIT_WHILE_BUSY.

Hmmmmm it kind of assumes that DAT0 will be de-asserted *before*
we get a command response, never after. I think that is what the card
is doing. If that is out-of-spec then we need to have a quirk like
this but if it is legal behaviour, we rather need to fix the mmci driver.

Yours,
Linus Walleij
