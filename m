Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D223BC433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Nov 2022 16:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbiKHQHc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Nov 2022 11:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiKHQHb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2022 11:07:31 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C5524090
        for <linux-mmc@vger.kernel.org>; Tue,  8 Nov 2022 08:07:30 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so13823611pji.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Nov 2022 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NAfXgkas9FkKHI/2z5E8BO22HCnzrVgue2pmy0gYg0=;
        b=sk7Y9PKa+w99R34+0MwjGhMzFTxMNAAlYcKPisL5RJ7MWZQyhALuxmFw8BuDRQCg10
         jhfK1WFvKFpeBsZlQn/8c8V4WPdRTARIL+kf7prcvz0hihXOh/5gysNVX1efI8V5PHuM
         fW/T1dqEHiNDsEEwj5pux0GNUg0uKt9TZfuhffhFpIIOlxRYrcYM2bFIKC9+1JAJBR4R
         vJ+5+S5Tt9sAtyW4p5zYlh+3oGH74c3DYrpUDKiDWV2VeaiPQU+2ZNvKhaO0WYKgtzuR
         kd5avGmkkkzccD1up9eDjq91QNVLdCWUUKi9a0fmowWsZ9yKYTvcKBNmji/muSm2ny33
         39Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NAfXgkas9FkKHI/2z5E8BO22HCnzrVgue2pmy0gYg0=;
        b=kFw6rxKoIGT7oSIw9eVYxLgqGjCnl002ORZF0fApL/6MjR3L6IkkOfvYKxEOv9EFkr
         hgthhjmqDcD79ynNSsCnuQGqDTYXDnVwg5CVi5In7ZUD3/6RuIcQL6aOSIRHszZxh9FG
         e/Tq1ePZwmIdBLDCA1rv7iiOV+P2ZK3pOXNlX0Z4wUB2JdQDj0wNCBeMafSH63EJadaD
         qt6V3Fdaq/eBV8vXMBnWLwmvF8QTkTY4/p8kW+h58ZYcdScMYPACE1yvMBpF1XBo1WlT
         551SBriJ92cVa/zjfB4SxO9+0jSMRTCPuXcHxXafO1rGog+t5GU19LGQYc0GJGXc7QbK
         9Dcw==
X-Gm-Message-State: ACrzQf1z9uPyCU/Ap9o/M9Km/z12uvcb1rePHcsBB8IdUfEqc84Xgr42
        K6MyGPHOUzcHO46ZbIPcfO30dY+1/qQMnxGsVTeOFQ==
X-Google-Smtp-Source: AMsMyM7oM3bXz5WVKW5DBKRfmc0AsQkBWvQNOKDtvc9Xfc+qlIYy0ceRnQLtvd1JvXN7+UzATdoAuNY9jQP7t2GZpgw=
X-Received: by 2002:a17:90a:a781:b0:214:2921:41ca with SMTP id
 f1-20020a17090aa78100b00214292141camr36678689pjq.118.1667923649937; Tue, 08
 Nov 2022 08:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 8 Nov 2022 10:07:19 -0600
Message-ID: <CAJe_ZhdKTM4kLvfHjNv4RozBFntxc2tBCWUuZ+dp567_ZqEFjA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: Add support for F_SDH30_E51
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Nov 2022 at 02:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This series adds support for F_SDH30_E51 IP and some additional functions,
> such as reset control, non-removable media, and quirks for broken timeout
> clock.
>
> Kunihiko Hayashi (4):
>   mmc: f-sdh30: Add reset control support
>   mmc: f-sdh30: Add support for non-removable media
>   mmc: f-sdh30: Add quirks for broken timeout clock capability
>   mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
>
For patches 1, 2 & 3
   Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Cheers.
