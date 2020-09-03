Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF00C433E7
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E9A2145D
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRj9yZtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgICIL1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgICILH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:11:07 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6916C06125F
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:58 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id x203so1226418vsc.11
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlPhFv3k/5AArHDg0SRbTlfwKIdxAJ6WzF8fNhVRF3g=;
        b=xRj9yZtdnpoyoT5l03xzQyj7eOGOaUj2twdc5WiO5LJsQChratHnWLrVoCWDDlzPbR
         bjocUnImIRPEnoMdVmvq4fEiVagyZCcVEcr87/KldB4MfM427BhgYKTi9GzU3LzlN/Ao
         CgeY9QVRKlBUxNokoWALjzf1UoEjwjuXUIojQy6s6or8zHm82D0rrGb6HPfG7nrsx3m8
         +hBKneDFMnIwdXO+tFTnxchBkjkqRo9iSAsfWppdpTPNHbspvi+cqikvATVRBaY5dC4q
         NZanMrHfEYEQfFhdJXgE3Amq2U5zgKb5vgn5f5DKTnRKr9EDgQ4mDri1tgKjg8ngogfV
         PR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlPhFv3k/5AArHDg0SRbTlfwKIdxAJ6WzF8fNhVRF3g=;
        b=Q9skgOM2rQWN7WKTtAcQpNj7/ytts4aK5iSW4GJfj2bzNqbrAhgfq/zNxhbMgj0F/L
         EQEMecAwaLo8ozbWX7jFJDQWKb1bgsp05UuHImvTgwjaLovQwB4WLsbupyYM4ZK0Jxhw
         xDFegdOvkyUiSazVmHyk5z0QQOli4mpotjhgmythjEQtoX/BIrCcoGtO+hWq1XvHzZo4
         xmH54k0j09m4GbrNVvQYLeSIW1EbCYU/QOa2TNEMlgX2iUAgNnKynOmh+cv+584eUn72
         9v82xWAfiRTuXVN8oBSvMHNaLMr+AI9KS3KT/hF/OhGLENMXYIgVsjGmuuYfr4JbYpgr
         iDZg==
X-Gm-Message-State: AOAM533YTTrFRRM/X/Rz77EHJbZ4M5T+H8NaoPZqsVv1MUSP93YtrJpY
        1o6QuU2zL7GgiCO8ucgqz24HWAz3nHfN0JNoz0qRdtGRx5wNeg==
X-Google-Smtp-Source: ABdhPJwf/WJQ//nMEysTS3jgGT4ZxA8X0LItoOPOOazU5r3pmYl4mFta5eihz0jSXywclJ5FZHOaMWtpkjH3wL8R/aU=
X-Received: by 2002:a67:e197:: with SMTP id e23mr399268vsl.7.1599120657792;
 Thu, 03 Sep 2020 01:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200901150250.26236-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:10:20 +0200
Message-ID: <CAPDyKFr=7W3BG-ZXcOAWs3j-5W=mm7WrhcgyTQi8h3HmWe6iYA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] renesas_sdhi: fix hang when SCC loses its clock
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Sep 2020 at 17:03, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> This again took a while since v1 because the issue was so hard to
> trigger. But I finally found a way to inject the flaw, so this series
> could be tested and it fixes the issue.
>
> Changes since v1:
>         * introduce a new flag to MMC core indicating any kind of tuning
>           not only retune
>         * use the new flag to keep SCC flag active
>         * new patch 4, minor cleanup to MMC core
>
> A branch including the DEBUG patch can be found here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/new_manual_calib-for-5.10
>
> If you revert patch 3, you should have the SCC hang during boot again.
> For the record, let me copy some findings I mentioned in another thread:
>
> ===
> Interesting news: The hang comes from a code path I would have not
> expected. It is not because of accessing an SCC register, it is this
> line from renesas_sdhi_set_clock() which causes the issue:
>
> 186         sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
>
> I mean I can guess that the clock setting has something to do with the
> SCC, but I can't see the direct connection with the documentation I
> have.
> ===
>
> Tested on R-Car H3 ES2.0 and M3-N and patches based on mmc/next.
>
> Another hope this is gone for good now...
>
> Kind regards,
>
>    Wolfram
>
>
> Wolfram Sang (4):
>   mmc: core: when downgrading HS400, callback into drivers earlier
>   mmc: core: add a 'doing_init_tune' flag and a 'mmc_doing_tune' helper
>   mmc: renesas_sdhi: keep SCC clock active when tuning
>   mmc: core: simplify an expression
>
>  drivers/mmc/core/mmc.c               | 16 ++++++++++------
>  drivers/mmc/host/renesas_sdhi_core.c |  8 ++++++--
>  include/linux/mmc/host.h             |  6 ++++++
>  3 files changed, 22 insertions(+), 8 deletions(-)
>
> --
> 2.20.1
>

Applied for next, thanks!

Kind regards
Uffe
