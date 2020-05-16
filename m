Return-Path: <SRS0=UNP7=66=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DD2C433DF
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724902074D
	for <linux-mmc@archiver.kernel.org>; Sat, 16 May 2020 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t7KCRb5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgEPJbw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 16 May 2020 05:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726271AbgEPJbv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 16 May 2020 05:31:51 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BBCC061A0C
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2020 02:31:51 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id x27so3734878lfg.9
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2020 02:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw5ZGlzOigmoxAYV4x4A4iMQy22mBGsdaPL8wvxF5QM=;
        b=t7KCRb5TwUrTfVRpVMCSsYTE8qR41XD5OPFNCzDJaybzkjmd/aEYXW2Dm760AJncpW
         kKDj4VpllM1wONgXCCAnuPEVi7dMf0II9MkrwB0fYobAZ1Cgj/Nx8pNKb+SJRULLjdw7
         krOiimZzzs552Hem78FAc3JfYcKMo0xV07lcggx00oF7cc8zc0v33KCEB6xBq7b+M2B2
         WkHG3VaCcdGjeYcXElhGo8P6V1ObZqmcCPzNnTDTsMrDb+lsog+Pzceq+fbdLH5Mxihx
         nqk1Gx+m8S8CZgad7Ks6fTxZqy+SwxLfKRlOwyTYshUYWuaFECosb7AEaCTlyHQPBpyO
         U+0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw5ZGlzOigmoxAYV4x4A4iMQy22mBGsdaPL8wvxF5QM=;
        b=q91wCdLSWv4fNdK3CqtGEr6xcAuSNsI2Ywti74lqy4mWL9I0HTl1ImfoND6XPosUgF
         r0lcHbtcXcXQwvsoyzOFHOPfDCPAfoHPF32iLIATLOGw3R7Jw8tv6LyscxST04S+Bk+g
         Wxs3ZmAx0EHs5R+dL/T7iBGinPBslBLVIc7/zia95sHZPhpNJqaYH37x15JmPErgBG3R
         xeG3QYPdYUeXixvYkYJuv5Ice3qSdr2hlwdNiVfeLXC45l4WWcs9UfIXT/iIJwBN4HCT
         yBQQ8OACw8w5jPkMIBJ9fhBgo5NNn99bFrZR7kweEi6mTms5K8/jOq1aSs0yEQVrFyi7
         bCug==
X-Gm-Message-State: AOAM532RXkg1NKizRFAm7A31aH8HusCXTZEhE5oB5CYLy/y15b3IGvw5
        uSRd5yqD5Rjc968QJta2KaysR+HWHByppRe1DSrEWg==
X-Google-Smtp-Source: ABdhPJz7j1dAtngw1ehruxeHwygYvR9vtM+5f3OW8FaljuTwEA5jVPZN0jHyhtVp9k/N4n8mpXB8YePY25sk9H/UjPY=
X-Received: by 2002:ac2:5e70:: with SMTP id a16mr5248801lfr.77.1589621509582;
 Sat, 16 May 2020 02:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200508112902.23575-1-ulf.hansson@linaro.org>
In-Reply-To: <20200508112902.23575-1-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 16 May 2020 11:31:38 +0200
Message-ID: <CACRpkdbrOa4jZjPvYaJ1mO4M4UeZcrGLmq_GyqDfwv6mMfeiSg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: host: Drop redundant MMC_CAP_ERASE
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, May 8, 2020 at 1:29 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> The MMC_CAP_ERASE bit is no longer used by the mmc core as erase, discard
> and trim operations are now always supported. Therefore, drop the bit and
> move all mmc hosts away from using it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
