Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4541CC433B4
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF29610FC
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Apr 2021 07:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhDBHBk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Apr 2021 03:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBHBk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Apr 2021 03:01:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C1DC0613E6;
        Fri,  2 Apr 2021 00:01:39 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l4so6182622ejc.10;
        Fri, 02 Apr 2021 00:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=/PmquSqlYbfx7DEsufC6Nqc204Yj4qGP6NGI1oHOMyg=;
        b=UVjHlw8DD95PPamus6BQr8vsyW+BNeld1SU4q588DhE9lAcSSzszVHeAcwFw1HmEye
         X6vOUeYvquzjllcq4/RQ5+BqKWELIqLulXLQCN3yuziOYPiqoEkNNSFw+CIOSMwPJlvU
         YIjYfcQBVgj0pzkH1j9B8rN5erJRIY6JBs+nhlgURmLulkpuhab/BrWalR4KuHOps+ON
         VTQvm85ilQFcoYO5lTJrRjNnWg6LaLuhJGdolSq0WLWl+l6bUuF/C/E9LN1j+8KSz4P8
         TrwQ+OSQLbSBGU2qoDSTcKqMr7z9ahMmBkhGkZViL6mdgJrH92tP0rMVGQAcfBe4mjN4
         W9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=/PmquSqlYbfx7DEsufC6Nqc204Yj4qGP6NGI1oHOMyg=;
        b=h3osP8x9UphixEivo2yZTVFngpay4zkBscE6Rr9OW0R7ymiE/w8sQzwhC9aYC63rVl
         bjSHCrTQpoR+lTqe2vx9sS8BDPPms6xdymgA4g86x/Ot8yN4tcxi6HPRD1OAOzfAQBX3
         zsmSCr/xFRrZhlIBRlRuG/aVDoTDQ+qWEgQKFDuOWFw/7tXnXYQMR3yxTzmwPcSwnABm
         FsMr+YqtiXOnLmeAQHfDabOEFmlpfEF0r136cGDg2qp8O+PhlRPIM0IUH3OSk6X46v0+
         eB30qbqRLdfvw3N/mjGvf4XsAYXzdM7NqiXMwSiz+jMEeXbZiutEJalz9ZAApLFRjqk4
         xXvg==
X-Gm-Message-State: AOAM531rVpJzy2tFZpObkJ8rKZE/0ffvkR23DY9YF5euFWSCttIdynIX
        mlVir+d9LDrROYRlelIFQbQ=
X-Google-Smtp-Source: ABdhPJxqhbwwyZrM7Hcreibs8zUA3MiJ4cWLE2b0IDRb8A9GpXgVvQR2dknIS9c/bfj7f9FcB0/NCA==
X-Received: by 2002:a17:907:1119:: with SMTP id qu25mr12475081ejb.423.1617346898051;
        Fri, 02 Apr 2021 00:01:38 -0700 (PDT)
Received: from ubuntu-laptop (ip5f5bec5d.dynamic.kabel-deutschland.de. [95.91.236.93])
        by smtp.googlemail.com with ESMTPSA id r19sm4893699edp.52.2021.04.02.00.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 00:01:37 -0700 (PDT)
Message-ID: <69debceaa1b653516a00993d579533383574c715.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Let sanitize timeout
 readable/writable via sysfs
From:   Bean Huo <huobean@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bean Huo <beanhuo@micron.com>
Date:   Fri, 02 Apr 2021 09:01:37 +0200
In-Reply-To: <CAPDyKFryYbahsR4PzFg3JAtSDZr-=cB0+XpgVQ2YJgZgiy9OXg@mail.gmail.com>
References: <20210401132853.105448-1-huobean@gmail.com>
         <20210401132853.105448-2-huobean@gmail.com>
         <CAPDyKFryYbahsR4PzFg3JAtSDZr-=cB0+XpgVQ2YJgZgiy9OXg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2021-04-02 at 00:48 +0200, Ulf Hansson wrote:
> On Thu, 1 Apr 2021 at 15:29, Bean Huo <huobean@gmail.com> wrote:
> 
> > From: Bean Huo <beanhuo@micron.com>
> > As the density increases, the 4-minute timeout value for
> > sanitize is no longer feasible. At the same time, devices
> > of different densities have different timeout values, and it is
> > difficult to obtain a unified standard timeout value. Therefore,
> > it is better to let the user explicitly change  sanitize timeout
> > value according to the eMMC density on the board.
> 
> 
> This makes sense. The current timeout in the mmc core isn't good
> 
> enough. However, I think there is a better option than inventing a
> 
> sysfs node to allow userspace to specify the timeout.
> 
> 
> 
> First, we have the card quirks that the mmc core uses to allow us to
> 
> modify a common behaviour (in this case timeouts values for sanitize
> 
> operations). This can be used to enforce a specific timeout for the
> 
> eMMC card. I think this should take precedence over anything else.
> 
> 
> 
> Second, the ioctl command allows you to specify a specific command
> 
> timeout in the struct mmc_ioc_cmd (.cmd_timeout_ms). If this is
> 
> specified from user space we could forward it to mmc_santize() and
> use
> 
> that rather than the default MMC_SANITIZE_TIMEOUT_MS.
> 
> 
> 
> Would this satisfy your needs?
> 

Hi Ulf,
Add card quirk is diffcult since different card with different timeout.
I prefer to your second one. I will change this patch based on your
comments.

Thanks,
Bean

> 
> 
> Kind regards
> 
> Uffe

