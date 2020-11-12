Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0280DC2D0A3
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 12:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EE020872
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 12:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="t5Ae5vgE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgKLMCL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKLMCE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Nov 2020 07:02:04 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9170C0613D4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 04:02:03 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d17so7968846lfq.10
        for <linux-mmc@vger.kernel.org>; Thu, 12 Nov 2020 04:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=14Jg7fRrUNjbh+scNrkVvkCbyMn1CNVg4Z+2y6X2BtY=;
        b=t5Ae5vgEMQ6JnmH2rCQUblx68b3fBE7apqv1Mnw8O7XZ4FPZZT7rqrPnLNykqzkJG9
         EndUEdWLmyee+ezylrBTb9T52dp2kSeyRvbAjD7qq6VhMNdXu4eAMbpkVYArAaoAbSmJ
         di5S1oWaBR0SaywJlREGohzhZAEzbe2gluBsxGURVmwW1R6dad9+dIZjwmokn22lBj+H
         mdkbs5ZafQXrUi4pv5iXm6TXhQOTqQddM7tMbzIDmgEEJojARMABnafF4tAiizdKeh8q
         iwJo/ttrCktjf7JjQFeeB00B8SEXntjfkGRspjuVGDsYlGSTmlqtx5ZCcs/mMRKprDs3
         +HBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=14Jg7fRrUNjbh+scNrkVvkCbyMn1CNVg4Z+2y6X2BtY=;
        b=IVv39CahcUXzy57jmt+71xI0gKqIuVObO6r1Q3hoJuUwhkfhgcRw0xVBQvHWQNBG8V
         2AqeQyUVodudgycppxvLZsjXoOOitTapqM2y6jPxc8N4vtnghP/A7p3VLFrymQxYXfkG
         OxnyIrL0BY+ADB0n0gDjlPhNxArKnkIGHSxWo5R2trFoeVDE6NwFYYCh7ElaSeTUf0gK
         +oobM6H7JD1beyqCLUDoC7CyK0TVAV7rmk5y1ww1RC2nvsB1vl3M4W6oePRfFVhhgX3V
         HELVjtPl6rZnR1fvR5b9rLFRovdO8adbpHy+Ov79kUFDRphH4GgWVh6mdBCvgiDjvfN/
         qspQ==
X-Gm-Message-State: AOAM530NrW71C2FXKUbcByLlHbhfGZ0X3D0JxIBhOS6OSftBHjo2at8J
        LILzUrzUrEgkL5hYlPJmhBu+9HTKOscBwg==
X-Google-Smtp-Source: ABdhPJz1mpmGtDKnFxBpeMtCpHVKA1s6nzVg/BcEYmJvQoGAzlRaLjD7u//vdhJNVRxj+W8qze7/Ig==
X-Received: by 2002:a19:85c6:: with SMTP id h189mr7077308lfd.451.1605182522412;
        Thu, 12 Nov 2020 04:02:02 -0800 (PST)
Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id g6sm533483lfb.291.2020.11.12.04.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:02:01 -0800 (PST)
Date:   Thu, 12 Nov 2020 13:02:00 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 0/3] mmc: renesas_sdhi: refactor SCC reset
Message-ID: <20201112120200.GA1491229@oden.dyn.berto.se>
References: <20201110162151.37622-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201110162151.37622-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-11-10 17:21:48 +0100, Wolfram Sang wrote:
> So, after some preparations, we can take the next step and improve
> resetting the SCC. Patch #1 is a fix requested by the BSP team to be
> more robust in case the firmware did something unexpected before.
> Patches #2 and #3 are cleanups made possible after patch #1.
> 
> Patches have been tested on a Renesas Salvator-XS (R-Car M3-N) and a
> Renesas Lager (R-Car H2) board.
> 
> A note to Shimoda-san: I did not forget that the BSP team also suggested
> to use the SRCR3 register for a reset in probe(). However, it appears
> there is more to discuss there. This is why I decided to send out this
> series first because we want to have it anyhow. I'll send the SRCR3
> RFC-patch later this week.
> 
> This series depends on the just sent out series "[RFC PATCH 0/4] mmc:
> renesas_sdhi: reset SCC only when available". A branch (with some more
> extras) can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tap_en_v2

For the whole series,

Tested-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> All the best,
> 
>    Wolfram
> 
> 
> Wolfram Sang (3):
>   mmc: renesas_sdhi: clear TAPEN when resetting, too
>   mmc: renesas_sdhi: merge the SCC reset functions
>   mmc: renesas_sdhi: remove superfluous SCLKEN
> 
>  drivers/mmc/host/renesas_sdhi_core.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> -- 
> 2.28.0
> 

-- 
Regards,
Niklas Söderlund
