Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB6AC07545
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Oct 2023 11:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjJXLZX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJXLZW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Oct 2023 07:25:22 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E1128
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 04:25:20 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5a7db1f864bso41993257b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Oct 2023 04:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698146720; x=1698751520; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W3UfpP4J7uXkfybYJ75D6cLNOi2hAo82Hvjm6Aix/n8=;
        b=RMb9wirlvICOQzOQDbOPe2GVt5xFfHq0Z69ce1goRF1Zdmifv64UwkuAMV33bUk28U
         sPJz5gb3ZyhuA7E7bEPmOrz+7bck1HhtimY07Y7hOL8Y/f3Kwnm8uvXdA3rtxo7eq83R
         ggfYcdFpb8usQqB+AQcae1NixR7wDMNlBscJ3ICEIA+tVtwRIlL8e/m8xJ4feX+kmlwz
         ACvfxi28dANFDiJDC/EsGixrBSpeLVvFokP3873zrSg7JxOJGyXl6hTLAyM/nFoX290a
         wutstG6dkSmV+/K9HqkKUwD4OHBcBvjXctHRsmTKq3njQIEBkgvpH5ZEqnPejzaoYDvP
         Annw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698146720; x=1698751520;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W3UfpP4J7uXkfybYJ75D6cLNOi2hAo82Hvjm6Aix/n8=;
        b=kLkkXk87ObeHKWz1LOQJqmVzMAwY3msvMFTZ5uZNLuu9n0Yj+9dhHlU/wx07tbqfGT
         spuhHTnPHjHCbhat4Cn3K6NxYvA+6TVNqW0YBExt5viW8mAlXMC5E4DJT2r/M5L6yZrM
         6PF2Vkvz9K53Bjb51397DFj6lad/bjI8qXCrm28K5QqGlQ1I8pKvhBNdJLLSDH/mj1NO
         F7lSEi/XDDHxowPBgrbI7CVFE3MmIvXT92QlFLZl+IsPMTFB4UrKBCTlO4T7uCTf6xzX
         pPwXuRpYX9IQVYkjDFzeFyxrQtyZy5sB21QzOclcMsxdwDE21ZaCERZGT1ZnMdCK26mx
         GDgw==
X-Gm-Message-State: AOJu0YxizUhXQKpRkF7eNht/uPWy3rUcVob8xYCJwFyQKEScXkDZlNg1
        kJGl7QDSZDapv/LvWxPAIR6p/hWuj3AwUMnP8Jo54j6hoWS9M2POGMA=
X-Google-Smtp-Source: AGHT+IGOBkQGtnjgV2jByRdc96fgTohO7yJV20KFfnoXsatovmxzsYctA9qDFqc518LV7wKM+/TeKzoRmEYZx+B8cSg=
X-Received: by 2002:a05:690c:ed6:b0:5a7:b10c:4772 with SMTP id
 cs22-20020a05690c0ed600b005a7b10c4772mr16544215ywb.19.1698146720061; Tue, 24
 Oct 2023 04:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231023132128.1871269-1-avri.altman@wdc.com>
In-Reply-To: <20231023132128.1871269-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Oct 2023 13:24:43 +0200
Message-ID: <CAPDyKFoPbyOT2Do+PhqVp5921U4-_=9S61c3xwRefpL3ERBdNA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: host: Disable auto-cmd12 during ffu
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Daniil Lunev <dlunev@google.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 23 Oct 2023 at 15:23, Avri Altman <avri.altman@wdc.com> wrote:
>
> Field Firmware Update (ffu) may use close-ended or open ended sequence.
> Each such sequence is comprised of a write commands enclosed between 2
> switch commands - to and from ffu mode.
>
> Some platforms generate auto command error interrupt when it shouldn't,
> e.g. auto-cmd12 while in close-ended ffu sequence.  I encountered  this
> issue while testing fwupd (github.com/fwupd/fwupd) on HP Chromebook x2,
> a qualcomm based QC-7c, code name - strongbad. Instead of a quirk, make
> sure it disable auto-cmd12 while close-ended ffu is in progress.

Two questions:

*) Is this problem limited to FFU? What about other regular
close-ended writes through the mmc ioctl? Do those have problems too -
and if so, do we care about fixing them?

**) I suspect this problem is common to those mmc host drivers that
have the auto-cmd12 feature. With the approach taken in the $subject
series, each and every host driver would need to make adoptions too. I
think we should try to fix this in the core, solely, instead.
Something along the lines of how we manage rpmb requests, where we add
on and "mrq.sbc" for the write/read request. Would this work, you
think?

Kind regards
Uffe

>
> v1->v2:
>  - Attend Adrian's suggestions
>
> Avri Altman (2):
>   mmc: core: Mark close-ended ffu in progress
>   mmc: host: msm: Disable auto-cmd12 during ffu
>
>  drivers/mmc/core/block.c     | 34 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-msm.c | 26 ++++++++++++++++++++++++++
>  include/linux/mmc/host.h     |  1 +
>  include/linux/mmc/mmc.h      |  1 +
>  4 files changed, 62 insertions(+)
>
> --
> 2.42.0
>
