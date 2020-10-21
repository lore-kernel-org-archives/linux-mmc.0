Return-Path: <SRS0=DxaD=D4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA83DC55179
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A16C222C8
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 15:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GiK0rUGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443979AbgJUPE5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Oct 2020 11:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443970AbgJUPE4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2020 11:04:56 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C3C0613CF
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 08:04:54 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id w25so1404838vsk.9
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 08:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dzgLsgCTYOoyXtg4GLPym4wvQbbYONF/GbyEZFTSaRI=;
        b=GiK0rUGUM8Iyel1222R06KxkHEx7522HigzM2nIp1vrbHedtQk5DtzewghFTQ1uWh+
         8hpdIK2ci3EqOJ4aebheWDH7n9aFs9B7ZWMCq3Tj4kQtw5g8TvDtXcIRaiQMB0YH9AkM
         CEpWHMJb7ULIL2yBbPaDFTMtuufsrayLGDe6phmjJibM6RRtR+wnTGCidaqmeHcMOd9t
         +7OGKFXKzL5rIBYBjEmL9C2KHETastA/mjzEGbhWAT5xmEv2bCGitTLI4mlXPs997J0P
         qgNaHCRg9z6slTMZoJD/AWxEz9gJcZLCn6Bv/aKXSgM3a67rFDqsVIiGA9X5z/COp26z
         G8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dzgLsgCTYOoyXtg4GLPym4wvQbbYONF/GbyEZFTSaRI=;
        b=iCT2onVifpgNCP6UGgTIDE0MJD9znKRVPl3+1J+iKd42qZoOAjthd/b4AMO0CEn40m
         WPlqMgdldgqwv7SbeJK4zfMYlYmDQaarVpCZywENyjUIN+Kq02OvWm4o0Q0aEOS43Bh1
         g2L6Jv/4GTSX0rPJNVsA3a/ZE09SQBciZF5HkPQ1HGjnETKHNKKty+Z0d1U297QrvbR+
         29bYFLIgdxONoHFATRzesaj7RCSGQkqloRm4aNE7vpP+H7nb0+dpC7gxH5GXpMpCp/b4
         veaF3bwngtUw17fQokfCbHopE+z0UsXhACeqhPbfKAkh7pA9tLmPCyNpiqpX9fnkYk26
         b/mg==
X-Gm-Message-State: AOAM530ZT8CxQcZzgaWb4k8X9jPUcDX/JLTls/n59VkHsy1o1DTJvC3m
        uzK4YQGOgOwMuBV9skwl4sx6D7fCRDHzy8W7cqRZKg==
X-Google-Smtp-Source: ABdhPJz2gVsQSrOjXkKxkYZTLE6/2tB/tghJjnbhDN2I691tZxvmaTlSNyIz8WfNnfT2P9ZQ2XexnhLHUi78Mw0YJyA=
X-Received: by 2002:a67:8794:: with SMTP id j142mr2433640vsd.19.1603292694006;
 Wed, 21 Oct 2020 08:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201015231149.9333-1-michael@walle.cc> <CAPDyKFoMmsYhwvNDdprtWiY+EMjXQx5uFvn4+fHmCG8zj6aryQ@mail.gmail.com>
 <7051c929a585bf7b1f62561f0ea91193@walle.cc>
In-Reply-To: <7051c929a585bf7b1f62561f0ea91193@walle.cc>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Oct 2020 17:04:17 +0200
Message-ID: <CAPDyKFrLtYmPpVumSMr0TAqSWx8+vc2Hzhfw-14aiJudPw7xeA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: set timeout to max before tuning
To:     Michael Walle <michael@walle.cc>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yangbo Lu <yangbo.lu@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 16 Oct 2020 at 14:50, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-10-16 12:53, schrieb Ulf Hansson:
> > On Fri, 16 Oct 2020 at 01:12, Michael Walle <michael@walle.cc> wrote:
> >>
> >> On rare occations there is the following error:
> >>
> >>   mmc0: Tuning timeout, falling back to fixed sampling clock
> >>
> >> There are SD cards which takes a significant longer time to reply to
> >> the
> >> first CMD19 command. The eSDHC takes the data timeout value into
> >> account
> >> during the tuning period. The SDHCI core doesn't explicitly set this
> >> timeout for the tuning procedure. Thus on the slow cards, there might
> >> be
> >> a spurious "Buffer Read Ready" interrupt, which in turn triggers a
> >> wrong
> >> sequence of events. In the end this will lead to an unsuccessful
> >> tuning
> >> procedure and to the above error.
> >>
> >> To workaround this, set the timeout to the maximum value (which is the
> >> best we can do) and the SDHCI core will take care of the proper
> >> timeout
> >> handling.
> >>
> >> Signed-off-by: Michael Walle <michael@walle.cc>
> >
> > Sound like this should be tagged for stable, right?
>
> Yes, but I was unsure about that. I didn't find a lot of Fixes: tags in
> the history of this driver (eg. for errata etc.)
>
> I could repost a v2 with a fixes tag if you like.

If this is regression and you can point to a specific commit it fixes,
then please yes!

Kind regards
Uffe
