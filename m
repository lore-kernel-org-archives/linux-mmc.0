Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDB8C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 09:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbiKRJqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242001AbiKRJqA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 04:46:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9711E8FB2E
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:48 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id h14so4041911pjv.4
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 01:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=upqtDzREVNFWzOSbSX1ftaCYSrdTO3ZpSoBEWd/qpPI=;
        b=OdJ9QNLfo92ONr4j7OUL9e7Wtvjrx+AFDAaqM+c2pxL+99brrflyNS5dxuBlbubmXh
         h1GzLSgZdlO13W17jbgbs1cLQbihWSj/uxc6/ZneJZfDOl0FVCknvxOhoMSA3M1ZsiFf
         xlYcLupJoNgM0mYOJfk7SQTrZWfEPjiouVt7fTzpE5uGI+Vs5gVtTMt7En4NFQDmL8Al
         LL42nq/9AyMaxPyCz+ST9Q3nxdCZVwt+gzXSKGpob+EhwYWq/zOS2SPetgaS5DFr7+Lw
         SRlq/8WANtOe9sy49Vrtu9zKOMSkuH562DuPmIX3nHZ8ih4ouSSBRIjwhWG0LC3rdALc
         GjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=upqtDzREVNFWzOSbSX1ftaCYSrdTO3ZpSoBEWd/qpPI=;
        b=ClnokxzXkSCFyryNt8pZsmFb708Pe+UsLgZV3DLXFdfG74StzeK92j7ssSTFrepLur
         mdBHy9n9cCzrS7CGW2p6MspyaCR0ooP0837D+/K1E6vEeuKQphNZimZ0z2BSexwHevMw
         BA/1/NQskGu0pTotwB5LmA8vI74Ye6Gy/095fGXaGvzRXKfAv1bUYLVxuvXfN5p8a+pH
         b+PEe6eXwhsL578cZP0UMOqtjGFa9R++4w4GJ0/tqun7vDD4RbZFfZHF9uAop07I3AyD
         cImYQlfsPJeS6+wBB883nmVzY//K97SSiSGYv0eb5a68VAUXhhzbZ9ddULYttspATVxo
         vgPw==
X-Gm-Message-State: ANoB5pkKZFU57nF1PWTDDTgfZ29hApQJwLidFFfcXZi89vRjFrLFuzc8
        R+9pbr2WISxbyPxrmeEhB/496gUsI0Wb1SDbcz1DZA==
X-Google-Smtp-Source: AA0mqf6j3LXoyxeUZMTF6iHITcWrhRXx8OVPu1mlxYAL03w1XwW5tuUg5f0CkpAtVQaZZ+4oM3y+Ix2L1iPideudyl8=
X-Received: by 2002:a17:902:a503:b0:188:cca8:df29 with SMTP id
 s3-20020a170902a50300b00188cca8df29mr6800168plq.148.1668764748089; Fri, 18
 Nov 2022 01:45:48 -0800 (PST)
MIME-Version: 1.0
References: <20221102125430.28466-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221102125430.28466-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 10:45:10 +0100
Message-ID: <CAPDyKFoGhSWxOPXqDag-a=oCTqgLMz2C0=JZcZXm6X8r9cmaZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] mmc: tmio: further cleanups after kmap_atomic removal
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Nov 2022 at 13:54, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Thanks to Adrian's patches mentioned in patch 1 in this series, we can
> now simplify the TMIO driver a tad further to ease future refactoring.
> This is marked as RFC because testing the corner cases is not so easy so
> extra eyes for review are more than welcome.
>
> Thanks and happy hacking!
>
>    Wolfram
>
>
> Wolfram Sang (2):
>   mmc: tmio: remove tmio_mmc_k(un)map_atomic helpers
>   mmc: tmio: remove 'alignment_shift' from platform data
>
>  drivers/mmc/host/renesas_sdhi_core.c     |  1 -
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c | 10 +++++-----
>  drivers/mmc/host/tmio_mmc.h              | 11 -----------
>  drivers/mmc/host/tmio_mmc_core.c         | 13 +++++++------
>  include/linux/mfd/tmio.h                 |  1 -
>  5 files changed, 12 insertions(+), 24 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
