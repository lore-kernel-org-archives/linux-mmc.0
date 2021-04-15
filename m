Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95745C433ED
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60CCD613BA
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDOMDk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbhDOMDi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:38 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD24C061574
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:15 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id d6so5788528vsm.8
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YkwjroPlHbqcNmJWRDqs861V15DKJFOnOt0FvUZN0wc=;
        b=U0byq/pvP64Pqt3eY0jYvQBkaMTMgBSMupiajU8dPcQc1So5sbX+Pb5PpszOHrnB6a
         FpDQEQxa+9amemH3bnvooAj6atRVX4rZytzxD9V6pp20rdvNTVTyULNgl21JsfKcsN4b
         TOHx4i3UsOaOj4xROEzIUpcNDSUuFNjeosU1OcUiHkdI2Kiachpb69NFSMSHSr61L7RH
         EVPaKnymfjNVGKityRj7FOSWcm4mTNfM9vqXqBbv/RnmM2F65NIPNX2Cd0WzQuvQMTU7
         WJmDBVy0ppt/lMMzN+FupoDywfpkY62hCCIPq0u/Ji1KWiwc6XVH4FZ7JgxgWNKWmmYX
         1DAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YkwjroPlHbqcNmJWRDqs861V15DKJFOnOt0FvUZN0wc=;
        b=E13UEkmoKtMpxYBunzzkHSNmQ8Dp+qmo+dC8/7Bq978TYm4u10zkT1LKAV7EuZmmkX
         cUn5RjYNOAkfpY8jB6As7QcpMq/zUHXWvHOyz3eZ2NitLzuEoYLdqYzAflckkRh4x2yn
         hPCM9ZLrf3OB6v7gGGjOAHrjwIPQfr8M/xWtrPIQLbb43hb+KVuskkWWaqr6Jhk9eXZu
         9WT5emlWq2Yn0cLzkq5UpGcl7zPdlEL75pkzX11bgvdXP0WeA41cSEGYJ1zlUYPExqUG
         GSo+3R6Cd6+SjNZP3Oo+E9cD7gVyOt86qLrEuX0T8b/Eoaw3oLnZLIFkZMNddUiayfiT
         uxtg==
X-Gm-Message-State: AOAM532Mb8Pm7LKPKzxrin+i1E1nQ0i2BMAd3D7cfWgi0F1pe4q/OCU9
        Rw9JqrofXQ4pG+cJepfMtf9YxFR91ySJ+xcFCV3Fcw==
X-Google-Smtp-Source: ABdhPJwiiPVdVZQgBlAWNpX73X2uQob6NdxDRuQSUywpkfNNJzX805N8Lqi4CF4gIaCgqpMAB2z934KH8DoUDzCfML4=
X-Received: by 2002:a67:cf41:: with SMTP id f1mr1713476vsm.42.1618488194599;
 Thu, 15 Apr 2021 05:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210414212236.346813-1-huobean@gmail.com>
In-Reply-To: <20210414212236.346813-1-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:37 +0200
Message-ID: <CAPDyKFqeCW9NOO1sqhOAUoLwS12AL_NAWeE5ukDenJLG2Dec3A@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Let sanitize not retry in case of timeout/failure
To:     Bean Huo <huobean@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 14 Apr 2021 at 23:22, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
>
> Bean Huo (2):
>   mmc: core: Add a retries parameter to __mmc_switch function
>   mmc: core: Let sanitize not retry in case of timeout/failure
>
>  drivers/mmc/core/mmc.c     | 22 +++++++++++-----------
>  drivers/mmc/core/mmc_ops.c | 11 ++++++-----
>  drivers/mmc/core/mmc_ops.h |  2 +-
>  3 files changed, 18 insertions(+), 17 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
