Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B74C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Apr 2022 15:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352393AbiDZPjg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Apr 2022 11:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352402AbiDZPiu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Apr 2022 11:38:50 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AF15703
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 08:35:42 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e12so4800664ybc.11
        for <linux-mmc@vger.kernel.org>; Tue, 26 Apr 2022 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQZiXIxdmiSHbCLJF1D/j7DSaBPKECeHRKKl9HR5UoM=;
        b=gIVAOUhxi9y7Yo2xEP1k3yvfEjLLjCtl0ov47OXgb2YCXUDGXxTF49I30qX40KpVIm
         PWJB2dxCEcNfr6k05ghawsu1qtRmlx9cTvrJrx+rnVihvgKCMR8vBZPwk9e0VEt8q+4U
         NjXgq3Q2vrQYiUVZiAB7lOASwk5Zh83hQ9PxdcAVsBLhCV47LWDcuUvzbm7kXsdD1m3N
         W1lajCBO/M0wsQhg0lxIM7FhiARI0aiGYKWoHDYAFXy4fhJn5JRqpCiCJdeG8u2kO8cO
         cPEt+wBCbojy4fJI+skhC/N9MI11C5v1WHRb3WYHJ8jC8vP8TGcNI/J1Tbu79wD82rUH
         YAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQZiXIxdmiSHbCLJF1D/j7DSaBPKECeHRKKl9HR5UoM=;
        b=KVqAtCJS7kpkKXEIseZL2Fx6/OGtaU4gA8rnL1g98pMF3zfdL3tVmZeTzpGk5ReW3b
         mQuS2LwtukKbxAQMA3gA7d9eTg5XYTue+jqYfH/3BIQRW51md4ht0tkyMXuhjEgtZL2x
         BT2VUvulIqlJGSHNjq96BxE2blWMkU9180QMziOmeUH8w5/VpSMO9PIWIj81MyYvOrOa
         S6I2Mcgzp8i8TSC4Ok28/rXi8Vquawo2wZxrghWtLDqK/PX8h7wT4HtWQ2D7vulWemui
         XzhDBRzRmLfl0Ckl1+Sti7O1oXZBPARzR0qj66x1XfhHCmFYiIpFtnTnYw0wwMRgzR69
         BzLg==
X-Gm-Message-State: AOAM532OSFpggdFVlUkzgz30OO9oDCrMjcARfgAvgiX/ax9kf6uQD7J8
        T1KnoUfv7MqvE69yqOgBUJ2PeMF3QYmf7w6wWPCi9A==
X-Google-Smtp-Source: ABdhPJxfB1kY9NVGiRey7y5jAZNb0HTOXTxJRiyMxZf+112Opk8r9k1XvSYnyKCCkyl+dnyJaWo3Zer8qmQsHZmSOI4=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr8726230ybm.533.1650987341152; Tue, 26
 Apr 2022 08:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220423221623.1074556-1-huobean@gmail.com> <20220423221623.1074556-3-huobean@gmail.com>
 <CAPDyKFrksB_kgrnmcay+ub0nDfmPVZfw-zJihop5N8_6qUqrug@mail.gmail.com>
In-Reply-To: <CAPDyKFrksB_kgrnmcay+ub0nDfmPVZfw-zJihop5N8_6qUqrug@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 26 Apr 2022 17:35:29 +0200
Message-ID: <CACRpkdb-snMG8Aabq_oa43_UQx1CVccQteRa8_Ur6OHDKFAc2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: Allows to override the timeout value
 for ioctl() path
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bean Huo <huobean@gmail.com>, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        beanhuo@micron.com, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 26, 2022 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Sun, 24 Apr 2022 at 00:16, Bean Huo <huobean@gmail.com> wrote:
> >
> > From: Bean Huo <beanhuo@micron.com>
> >
> > Occasionally, user-land applications initiate longer timeout values for certain commands
> > through ioctl() system call. But so far we are still using a fixed timeout of 10 seconds
> > in mmc_poll_for_busy() on the ioctl() path, even if a custom timeout is specified in the
> > userspace application. This patch allows custom timeout values to override this default
> > timeout values on the ioctl path.
> >
> > Cc: stable <stable@vger.kernel.org>
> > Signed-off-by: Bean Huo <beanhuo@micron.com>
>
> Applied for next, thanks!
>
> Linus, I interpreted your earlier reply as a reviewed-by tag, so I
> have added that. Please tell me, if you want me to drop it.

That's fine, sorry for being unclear!

Yours,
Linus Walleij
