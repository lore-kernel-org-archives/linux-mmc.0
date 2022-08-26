Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19CCECAAD2
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Aug 2022 09:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343550AbiHZJR3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343515AbiHZJR1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2022 05:17:27 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C8D7426
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:24 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id n24so974826ljc.13
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=+BpRNGOnD2t6/Nb0ClGZalYmfiUntM7FnRymqB3IYUo=;
        b=zACeJX5EEz8JcYCvT1zsZkiIDCs04ymBFmkGyal0zemqEkc8vb01qLChnBWk01rg/u
         H6SDxQdCQcFEX/xxhNM0WjtbHqbS97W9UMvfH7FrR4p5IpwSayJPWImbtPF19Fnix8+N
         QpdbKFs07jtmCScNZyeIrONgS+PKcXB/I3DxDPavFtZKAIYY55BvZ2CWa/RH1l2mWO1A
         VGkaIgWdNDfpvya40UhxuIuUeGntS8mJFQ8IeAOyr54x/sdAp1eX1ULDOKkEsw9nw1lE
         KT686+Z5/TDYopyxgFX1Tnew5OUEO6FOp6S1xN5WnKYPNhi0CjvjfWInbSIxane+cw+A
         f69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=+BpRNGOnD2t6/Nb0ClGZalYmfiUntM7FnRymqB3IYUo=;
        b=Jhoac3wn8rnCE6kNujZ54jw6lkvi6TNOgNP4KKOWGxwysEm2tP3OCfG/wrTu3pmMwX
         pKBkTBeLJe9oE5YbflU0/3+CBhv9z4QFdyG9rZVENicILGqFdHtn/K+MotxTvvVv5JjR
         FCeA0M15Xh9XBF8zVqGqjHwzb9lwbCjbIIyb+J65zdhXKFT1YAI3/uwcWJeoDMtsilr2
         RXfu2hsz//O1z8qa0BlxXLNIGRvedRsGuOPqw1mhTuHEtUqMqYEenaEVEebJ5ob/qphy
         3DCKFdBR51UAheNVQx2VwCP/UM8c4DNVQcgSBSDs2MjBDgnGYIFPGTAr3K0G7OpyYsJX
         ZRjg==
X-Gm-Message-State: ACgBeo1odbP9p2cEpqhCNFeuHP0MatHHnQIljH3za0DKy26Uv81rOh9t
        +AhAGB3DNSvv+Yur2pysO0jSb3yV+OYA7HklZ3OJ+fz6YiI=
X-Google-Smtp-Source: AA6agR6r5i2Hp+b8Ll2uDys6t2rL9DioJI1dX49d9LHXzAak4CyXmbsxeSUVF5OVOEei9kMCe4EswKqFXarggYiho5E=
X-Received: by 2002:a2e:92ce:0:b0:261:e39e:2c1d with SMTP id
 k14-20020a2e92ce000000b00261e39e2c1dmr2008130ljh.273.1661505442384; Fri, 26
 Aug 2022 02:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220825074008.33349-1-jinpu.wang@ionos.com>
In-Reply-To: <20220825074008.33349-1-jinpu.wang@ionos.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 11:16:45 +0200
Message-ID: <CAPDyKFqgraY5DWiUxPSYfiGLj6KGa3-hhP6+c9R3aMQHz51k4w@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: Fix dma_map_sg error check
To:     Jack Wang <jinpu.wang@ionos.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Aug 2022 at 09:40, Jack Wang <jinpu.wang@ionos.com> wrote:
>
> Hi, all,
>
> While working on a bugfix on RTRS[1], I noticed there are quite a few other
> drivers have the same problem, due to the fact dma_map_sg return 0 on error,
> not like most of the cases, return negative value for error.
>
> I "grep -A 5 dma_map_sg' in kernel tree, and audit/fix the one I feel is buggy,
> hence this patchset. As suggested by Christoph Hellwig, I now send the patches per
> subsystem, this is for mmc subsystem.
>
> Thanks!
>
> [1] https://lore.kernel.org/linux-rdma/20220818105355.110344-1-haris.iqbal@ionos.com/T/#t
>
> Jack Wang (2):
>   mmc: meson-mx-sdhc: Fix error check for dma_map_sg
>   mmc: jz4740_mmc: Fix error check for dma_map_sg
>
>  drivers/mmc/host/jz4740_mmc.c        | 4 ++--
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>

The series, applied for next, thanks!

Kind regards
Uffe
