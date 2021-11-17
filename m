Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB1BC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 09:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2505861357
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 09:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbhKQJnT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhKQJmt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 04:42:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A05C0613B9
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 01:39:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id t26so5644611lfk.9
        for <linux-mmc@vger.kernel.org>; Wed, 17 Nov 2021 01:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nF18X5vZYkhk4OJypfVIyb8nEMJdnaXodq1rSCybrkw=;
        b=BgRwpgHdsbSu2DNjPc5pJIwJRAXhfmZsp7n/wVgitJw8w2DAv+eiPhlitYM6m0qsgQ
         SRQE+vGDduAAnSYxhq/WbKQoIvFmXrFEnqFsMEFwAWKPCjaWXlZKDckdbUvvJW7zwkIn
         G5tv75J38ZWRshTiWdFN1x29i5CNvMnXb8ewP/MUgq7zLR2IqCm2XlvcZnFNhy0pfaXa
         8NqkjyaZ8t5ZDXVee6E0y90BkH+gU4xSOXa00QMF5Zkgb1No+MMutAXuHigrJheNOK+B
         BkKwF5sov3tLrJ8NSnfY9wVXpLyDmBSdmJPi0E/QHVoHZdfzYXpsVb5wfwCR5qng1olA
         tNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nF18X5vZYkhk4OJypfVIyb8nEMJdnaXodq1rSCybrkw=;
        b=d6lCQC4Xmh1jUe2fZitJZLn9riwhtuqRAk/fRIR7MeFZDQwu90MQa3GveXc+cUjXv2
         28WBxSY4puDVfwPYapcLmjL56wlRFurJBQwDhB6Wezak/YYZ0XGlJAq3DhadSirf70q6
         /lhx7a8XWtyDzlDO+zt/QU/gHrYTFSr5aH4OD7CtAXE5VD6pdPuup5asMRWk5W2ssrKR
         N7jMTr2fJERw4gZQik1NP4aBWbChoyXoWg5sn2V7r4n8a13Q/nedU7FBUw4y3kE4CYpE
         nDUJViIUMDTetxi0+tl9k/dXfp59u3vY30KGdo2zTCOWdbdVf0pb6CA8woVRbLfZGCVH
         dqcA==
X-Gm-Message-State: AOAM532mtVgh7vQr0etCBQUNcC7dZM2w9Z5SIRUe6MNT/AVZDSH5JkOu
        xgdho2eLmsJ6B71l2qIDBMolDuSVTjaNXDoocj5Jx4UR9d8=
X-Google-Smtp-Source: ABdhPJy0GW6hOn54FO5eacU/9Yz2eW4F0WXc4CyM4/FqKHp7W2O9dNw3tlUdt6fjDP2QWxUzMMwePrVUIsb2PGDgH5M=
X-Received: by 2002:a05:6512:1113:: with SMTP id l19mr13953699lfg.184.1637141939557;
 Wed, 17 Nov 2021 01:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20211115082345.802238-1-adrian.hunter@intel.com>
 <CAPDyKFrADwgb_xeVDmdPETcFnbqRqvKKav_Gr+oGf-4E3Tfj6w@mail.gmail.com> <8a76ac63-48a8-e36c-5138-ad8b4cade179@intel.com>
In-Reply-To: <8a76ac63-48a8-e36c-5138-ad8b4cade179@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 17 Nov 2021 10:38:23 +0100
Message-ID: <CAPDyKFpsJ2tvtPqa_tPgKM9p8AG=9uZNfmHxO=vq87UoUz94Ag@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix ADMA for PAGE_SIZE >= 64KiB
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Bough Chen <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 16 Nov 2021 at 09:14, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 15/11/2021 16:54, Ulf Hansson wrote:
> > On Mon, 15 Nov 2021 at 09:24, Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> The block layer forces a minimum segment size of PAGE_SIZE, so a segment
> >> can be too big for the ADMA table, if PAGE_SIZE >= 64KiB. Fix by writing
> >> multiple descriptors, noting that the ADMA table is sized for 4KiB chunks
> >> anyway, so it will be big enough.
> >>
> >> Reported-and-tested-by: Bough Chen <haibo.chen@nxp.com>
> >> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Applied for next, thanks!
> >
> > Should we perhaps tag this for stable and/or queue it as a fix for v5.16?
>
> Could do.  I thought I would leave it up to Haibo Chen.

I have moved it to the fixes branch and added a stable tag. Haibo,
please tell me if you think that isn't needed.

[...]

Kind regards
Uffe
