Return-Path: <SRS0=InOK=75=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74826C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C81B20B1F
	for <linux-mmc@archiver.kernel.org>; Tue, 16 Jun 2020 11:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLDmtLM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgFPLdj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPLdB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Jun 2020 07:33:01 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F22C08C5C4
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:01 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id y123so11210369vsb.6
        for <linux-mmc@vger.kernel.org>; Tue, 16 Jun 2020 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/vAVJjp69zCGfu41LDtOMCB58lEQWjfyqRSPeVREIo=;
        b=bLDmtLM0tpY7CA/XxYZ9cj3Eo62z+1HqDVIGM+e4+Yijh8gLEuXvFZUAI8GSTPUnGf
         +2Ik/hGUEunuJ6UPI+qu5t/SwZMk2EWfSaoG+tps64Bgmlc2eIPnLtaYM0BpNcDijo/p
         6J1MYloVG3DNthEPndm3zX1869wrRmFiu1TZhi3E6v+nhwbS4bEwsQ/x8FQAe6bC1uqX
         VdgaVpri3AH31hw1vawY1xx3JX4J8o8Hw+6Jbaq99da6brsBOkWloQQVJ1SKPSAe7C9t
         CyLTSWXXZ0lJ2eynCXqXb7M1xojhs0Eh2d5lSGvWhjR7/NFLD6EXHC8poFjegz4QJ6Y2
         W3Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/vAVJjp69zCGfu41LDtOMCB58lEQWjfyqRSPeVREIo=;
        b=JeG/YyeLlk5x3mL9bviSdYsyYEKzdUpTdek2VCVJUjNmT1EsYPz4x32A9l3v6/VeEw
         WhuH96iQUCV9Y7vw/JcZBJPCTNkA9avQZuTnQo+ifUouX84bez/ZVHztjE2IQO+DtPBO
         K/8WGi3lviX+ZezysTvQYDh0YzTgovdFoMetCTHTvmK9ix6l9b8ecpGM5RzjDxyQc51k
         hnjndzHRRCGcLJ5WhKzRzbCSOjkU7rJPmSfbunAk6XRZH3Wc1zTJsIug/Bfh6FWnIYWM
         IjP5UpRLLnqCoxVAy973PtSlcalVs9pITGy8gpp/ph8ZS/wH4aFiBXPNB/fDINcV5ISf
         c7CA==
X-Gm-Message-State: AOAM532Kps2vFUZ+fp8YqJhmqsQRLsy82lZo7g7tYDBqmApOZkpaYyji
        C171ntY9rzgtHZi2zjm7O63O8dsAzfd9eD+yPQezVg==
X-Google-Smtp-Source: ABdhPJwcvpVWgW+Rf8g0m9hT9CFIFnTJJ78Kf0RJ88HdnJnWDKBOQCHP4OA8iE9LZouDP09t2/VBUwIjP3Sf+alvmh0=
X-Received: by 2002:a05:6102:18e:: with SMTP id r14mr1174051vsq.200.1592307179824;
 Tue, 16 Jun 2020 04:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200605101222.10783-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200605101222.10783-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:32:23 +0200
Message-ID: <CAPDyKFrZHYeUa9ryen_F0uyrvvEDr_W+Q5xyOKt_YwyiaM+6cQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: renesas_sdhi: support manual calibration
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 5 Jun 2020 at 12:12, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Some R-Car Gen3 SoCs need corrections after they tuned to HS400. This
> series implements that. Please have a look at the patch descriptions for
> details. The origins were patches in the BSP from Takeshi Saito.
>
> Changes since RFC v3:
>
> * moved detection in probe() a bit to the front before calling into the
>   TMIO driver ensuring all fields are properly initialized
> * tested on Gen2 (R-Car H2), too; no regressions
>
> There is a branch for testing here (with the debug patch on top):
>
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-manual-calib
>
> Note: handling 'hs400_calib_table' in patch 2 uses some multidimensional
> array vs pointers judo. I think it is correct C this way but I am
> especially grateful for further review there.

Wolfram,

I tried applying this, but got some conflict. I guess you have based
this on some of the other series that's in the pipe. Maybe you can
give me some advice about the order or how to apply things?


Kind regards
Uffe



>
>
> Current test results:
> ---------------------
>
> An unaffected SDHI instance (no eMMC (R-Car H2) or no table (H3 ES2.0)):
>
> No calib table, so flag gets disabled during the reset in the beginning
> of the initialization. The same reset routine will be called when tuning
> fails.
>
>      kworker/0:0-3     [000] ....     2.799451: renesas_sdhi_reset_hs400_mode: ee100000.sd: calib table 00000000
>      kworker/0:0-3     [000] ....     2.799459: renesas_sdhi_hw_reset: ee100000.sd: reset! flag disabled
>
> An SDHI instance with a HS400 capable eMMC connected (R-Car M3-N):
>
> When preparing HS400 tuning, a calib table is found. So, (potential) old
> HS400 tuning gets reset and the manual adjustment gets disabled, the
> runtime flag (signalling new manual adjustment will be needed) is set:
>
>      kworker/1:2-139   [001] ....     4.028232: renesas_sdhi_reset_hs400_mode: ee140000.sd: calib table ffff800010c76ee8
>      kworker/1:2-139   [001] ....     4.028237: renesas_sdhi_reset_hs400_mode: ee140000.sd: adjustment disabled
>      kworker/1:2-139   [001] ....     4.028239: renesas_sdhi_prepare_hs400_tuning: ee140000.sd: flag enabled
>
> Lots of tuning CMDs:
>
>      kworker/0:1-21    [000] ....     4.028370: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028576: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028668: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028754: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028832: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028909: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.028989: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029065: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029149: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029228: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029302: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029378: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029453: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029532: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029612: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029694: renesas_sdhi_fixup_request: ee140000.sd: opcode 21, flag 1
>      kworker/0:1-21    [000] ....     4.029775: renesas_sdhi_fixup_request: ee140000.sd: opcode 6, flag 1
>
> First CMD13 after tuning discovered, enable adjustment, clear runtime
> flag, show replacement value:
>
>      kworker/0:1-21    [000] ....     4.030294: renesas_sdhi_fixup_request: ee140000.sd: opcode 13, flag 1
>      kworker/0:1-21    [000] ....     4.030299: renesas_sdhi_fixup_request: ee140000.sd: adjustment enabled, flag disabled
>      kworker/0:1-21    [000] ....     4.030300: renesas_sdhi_fixup_request: code 0 replacement 1
>
> And then checksumming a large file works without performance
> regressions. Retunes happen once occasionally and follow the above
> pattern exactly (with different replacement values, though).
>
> So, again a lot of text but I want interested parties to verify results.
>
> Looking forward to comments, although I won't complain if this is the
> final version ;)
>
> Thanks and kind regards,
>
>    Wolfram
>
>
> Wolfram Sang (2):
>   mmc: tmio: add generic hook to fixup after a completed request
>   mmc: renesas_sdhi: support manual calibration
>
>  drivers/mmc/host/renesas_sdhi.h      |   5 +
>  drivers/mmc/host/renesas_sdhi_core.c | 152 ++++++++++++++++++++++++++-
>  drivers/mmc/host/tmio_mmc.h          |   1 +
>  drivers/mmc/host/tmio_mmc_core.c     |   3 +
>  4 files changed, 159 insertions(+), 2 deletions(-)
>
> --
> 2.20.1
>
