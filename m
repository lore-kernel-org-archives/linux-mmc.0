Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C4CEB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Jul 2023 09:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbjGNJaw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 14 Jul 2023 05:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235825AbjGNJav (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Jul 2023 05:30:51 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1963B2D68
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2023 02:30:29 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-577497ec6c6so16776867b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 14 Jul 2023 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689327028; x=1691919028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GH8CMfUmOJpE9gd+H4iroJkL0rclNflkWxyF8IZniXk=;
        b=qZcg/XDOZUtXrelRLc7puAIjVSD3iBp0U1/g5G206gLcehHc367RZBkCxbaGui+NM6
         wlBYFarEg+zCiHhyGNYb+r4Isv2bIeBc8YgUUVfq/ZuDC9QHcf3cbNFd+b/tl+i9OQEE
         dGmTMqc1LwhcB6tqP3GNtm1Jk6yw2af81K04PXRLurAwpdUYIJYQ3Y5Vg1Db6grWKzeT
         56s6Sn9uNDK1RrUScx4COgDq6MONtsFZ4cHRyfw6Zl/JFdpA287iMt415MxZI0HTfMk5
         fz1lOiuhxOmqFvIKqTd4AXLY0wa9FEF7NeleZdLDVfXKjV3gXrMMzo5da0kkrrkghZEd
         OzlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689327028; x=1691919028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GH8CMfUmOJpE9gd+H4iroJkL0rclNflkWxyF8IZniXk=;
        b=DQ8yvriXuymJkXJYvFh2Qa3LkMa+FZuCo0DBTpksb/Vy4xqsaqrWDXY6FSjKnF9u1X
         p0TM736loSlBj8xvMVA8Pebqjki3uvJfKHXEk0SpuVzHL/GDREYhNZy9Hf4srYFm47gy
         L+PrxYM1AwnytA34iqoxgdV/VA+0bv12LKjDW3kNt06iF/SgChSNd1q6XsZXmhPY8/6T
         /JDRkdznlwWS3bsKsXtHtmQS9k67+v6nl78CNxP8tb1p0jHtAkIo8jTbl13ZW6416+uP
         dB/122sbaMx3xTBHPmoZ4D6LrtOvsIbKO2vzQeU2uDzw06AzMKwdFUWZZqkQ0XrFOPB2
         mGRQ==
X-Gm-Message-State: ABy/qLbpZqNAV1J1NSR8Uo4aP/d7S14yESN6U1+nQ692PQUIcdcg8FgU
        I94+m3N72kVrk0qXcrDIQ0wHWqNck3rwQmt6dZqpg7fRSZFP9CBv
X-Google-Smtp-Source: APBJJlH8CHYvCTHYliOCwpjaigKPnVgpNrviUs/vl8GFAGDUWHSsn9TtL2Eq7hDSncWlE/IfF9KUyKouChuPJhF+9CE=
X-Received: by 2002:a81:4757:0:b0:54f:9cd0:990 with SMTP id
 u84-20020a814757000000b0054f9cd00990mr4245400ywa.18.1689327028459; Fri, 14
 Jul 2023 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230630004533.26644-1-hayashi.kunihiko@socionext.com>
 <CAPDyKFqJU3VwXJJDQPWvNBDz1+gSjYxFJBST3s8mpJoh7-c9-Q@mail.gmail.com> <1d924f9a-54b7-e70b-304c-284e5bf90b59@socionext.com>
In-Reply-To: <1d924f9a-54b7-e70b-304c-284e5bf90b59@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jul 2023 11:29:52 +0200
Message-ID: <CAPDyKFrp0pOr4xr_zEC8bheL61Oys5FCKzFV3Q1XFoXi7Gi7jg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-f-sdh30: Replace with sdhci_pltfm
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Jul 2023 at 13:38, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Ulf,
>
> On 2023/07/13 20:06, Ulf Hansson wrote:
> > On Fri, 30 Jun 2023 at 02:45, Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> >>
> >> Even if sdhci_pltfm_pmops is specified for PM, this driver doesn't apply
> >> sdhci_pltfm, so the structure is not correctly referenced in PM functions.
> >> This applies sdhci_pltfm to this driver to fix this issue.
> >>
> >> - Call sdhci_pltfm_init() instead of sdhci_alloc_host() and
> >>    other functions that covered by sdhci_pltfm.
> >> - Move ops and quirks to sdhci_pltfm_data
> >> - Replace sdhci_priv() with own private function sdhci_f_sdh30_priv().
> >>
> >> Fixes: 87a507459f49 ("mmc: sdhci: host: add new f_sdh30")
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Applied for next, thanks!
> >
> > Or maybe this should go for fixes and have a stable tag too?
>
> Thank you for applying!
> I think this should be applied to the stable branch if possible.

Alright, I have moved the patch to fixes and added a stable tag, thanks!

Kind regards
Uffe
