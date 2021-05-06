Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B36CC433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19AA46113E
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbhEFM4Q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 08:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbhEFM4O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 08:56:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4897C061574
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 05:55:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n138so7644386lfa.3
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 05:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wqkbdKsOdWjTK7WgnVxR1G7Gje4G1wMYFsQzSKPfbAo=;
        b=WZ7v02+KE4wO7unCZvbfDLWFG1BRsiNeeiqwWtqYzNOqQASTg2Nx2XeJHesK7+D3i8
         2JQfF4stnA2fdQBg2FnNMBkVC/kF+kk/n7Ux2nNLiHXhJI8qVoCcSAjc8GHrDgI8yghv
         xGJDjI1jaRfOPqkXEJft2jPTJukttHcTAS6A0PvGYzKYNMLvUCUpMOIEwjn5ZbM7hktj
         Hs8saBV8RonqMxpUkZMPrdRzH+Ly0qzK/W6sz5FanvYdM38165f8sGdp+TsJtCtIFRcT
         pQc3QrChiZoCSOug9HHoE0ZWPCh2msWrev/R2BMiqXMy9GjDFcKTN+aUSnWaTYQI8CtR
         oseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wqkbdKsOdWjTK7WgnVxR1G7Gje4G1wMYFsQzSKPfbAo=;
        b=HJU5oAyLRlLNzFew/QC72tMFFw7ePA8VsLEu2jewxW3x3aA/kMHwPohPHaiizVk/KR
         jrcXJp/ZscyfUXgpGj4lCm4ljmD8ZsIZ3n1r3mpScxfG1L1Gi50VdaNqpxCxbn3kGRzi
         s615s6blV/KiQ3QQ/+gjfPSYf2fw8HOmdK4lv6FgEbIOApveEg8dCqh/VpXjVFCz0Ikg
         SRDPLHurOkXQnlON6cHNWnxZAcm03N95BmIQsZqbr0hEVx9q0W3Z+kmxBaUA8odaavuA
         KQeRlY5sRov/7ytSTpGoxPBSlbh6NS7mlAsZchOebP1LBpFDN9+1WHAC5hCPJZwc46Li
         /8wA==
X-Gm-Message-State: AOAM532pP4z5vbyXmJMbpvu3ew7sWhMUECPIStsENjVaAPSsglx+g2Cl
        wv4ml2CrXr2QlvwanMsxf0nn2gKJYvh/puBQtJVu+g==
X-Google-Smtp-Source: ABdhPJwkS8PxjjDr2n5hfY2szPG9nSo1a5AJ4gvyeQ22qeS/fiE1q1FlxvsZwPnrHxg063ycasrTZYc3jhQ0K8KX3ds=
X-Received: by 2002:a05:6512:149:: with SMTP id m9mr2640542lfo.157.1620305713264;
 Thu, 06 May 2021 05:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-6-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-6-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:55:01 +0200
Message-ID: <CACRpkdY2fScL3jvKoyR1m3+Yxj2=Nj3PPGm1cAqyn3kBS78aow@mail.gmail.com>
Subject: Re: [PATCH 05/11] mmc: core: Enable eMMC sleep commands to use HW
 busy polling
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> After the eMMC sleep command (CMD5) has been sent, the card start signals
> busy on the DAT0 line, which can be monitored to understand when it's
> allowed to proceed to power off the VCC regulator.
>
> When MMC_CAP_WAIT_WHILE_BUSY isn't supported by the host the DAT0 line
> isn't being monitored for busy completion, but instead we are waiting a
> fixed period of time. The time corresponds to the sleep timeout that is
> specified in the EXT_CSD register of the eMMC card. This is many cases
> suboptimal, as the timeout corresponds to the worst case scenario.
>
> To improve the situation add support for HW busy polling through the
> ->card_busy() host ops, when the host supports this.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
