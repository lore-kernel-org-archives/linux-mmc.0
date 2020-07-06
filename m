Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URI_HEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B23C433E0
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 13:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E322070C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 13:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z1kRN5FG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgGFNRh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgGFNRg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 09:17:36 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692E8C08C5DF
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 06:17:36 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s20so13169411vsq.5
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 06:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/aHB6znSrR8BPwCLwuSQEuDjMcKr7HpM9fzYrfr9Lls=;
        b=Z1kRN5FGQUmhzvjJqlhPaYkAiQFP7M8cqiBCnuhEwP8WR4X4QlhYBoAHjzK7RMpLzq
         3UWVWqbj4vSr5aTZJHb0T6xWckIaoUwpKHZRPln6N8W+XIYAlA0V8Qig98IwRg9bwYm0
         N5rSdckRHH2ozqrwO/06ZrODxmyTbBjLKALjxH9nsKjLNAqSBwSchYyoDhUje+S4Skd+
         TPT5hmEQX+P1ub4AUSOF/klFXUjUz1FSpcQXBBmu9IVhJe4drQuxY6TJW4KOfCI1XZjV
         5EcHTp+TzCrmoefEJcSivZK/MRdtonVR+Ia9DBiLLmH0kNXSTHoKV+dgozyvjnR9+UPr
         ba0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/aHB6znSrR8BPwCLwuSQEuDjMcKr7HpM9fzYrfr9Lls=;
        b=FmwTaPrw+40KKVCk88l4h8RZdl55PC8jrZid9bKC5vwUkb0H4tTPudrr2UsjjTsiAS
         iWNBawUOJX7VD3//CRYjm+S7aN474ySvTBuKJVCR4CNDZlqDtXmO8VUFoff6UlndOWf0
         j+tRv5rKnbkPw17Y+B7GjrnelMnfkaV57TajY6eCMB1GcJT4jJ4WbrbEm+hRsrPXyQ48
         ra7lPlojlG3dQFHdm2+ydqsS+fZHgNVjGB/r+X2UXwfddjoQMBZ0BIFRoBMOf63X+mLA
         HS/sSLpE3tY3XqOFIxyPkXy5QKfQ0TKsrFEG+V9rCwTVW2tNA8brgHDVwSiyFfPkUvah
         yQhA==
X-Gm-Message-State: AOAM532Y0HEdgnbW+bBQVQA9K1ZB3v/hmfuHSw0WMpx9F2HfvrlgAxmw
        mvpcSUX+EkdcySwnJpOfyY1S6E/Z0tdniRoMGt5fUA==
X-Google-Smtp-Source: ABdhPJynWuA+T7eHRKr24+OF+y1WgQl4X8QhJJGe9b4BUfYDCxSTBL24IRJDgX2ULPXOMSZR+UZgsWHUgsDNTZ4/Bx4=
X-Received: by 2002:a67:ca03:: with SMTP id z3mr28797268vsk.34.1594041455639;
 Mon, 06 Jul 2020 06:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <1590044466-28372-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY2PR01MB36921D805C79B829563698D6D8B70@TY2PR01MB3692.jpnprd01.prod.outlook.com>
 <20200602125131.GA1318@ninjato> <TY2PR01MB36926A830866FEA2C49735E0D8890@TY2PR01MB3692.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB36926A830866FEA2C49735E0D8890@TY2PR01MB3692.jpnprd01.prod.outlook.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 15:16:59 +0200
Message-ID: <CAPDyKFpzZG-LFbCDZYZx7J9sH536dcyHvoatCD4F-AvzM1kaZw@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: tmio and renesas_sdhi_internal_dmac: fix dma unmapping
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Jun 2020 at 04:52, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Hi Wolfram-san,
>
> > From: wsa+renesas@sang-engineering.com, Sent: Tuesday, June 2, 2020 9:52 PM
> >
> > Hi Shimoda-san,
> >
> > thanks for the patches and for providing a test case. I was not able to
> > reproduce the issue, though. I'll explain...
>
> Thank you for trying to reproduce the issue!
>
> > > Note that this patch series is tested by using additional debug code [1],
> > > because there is difficult to reproduce this issue. Before apply patch,
> > > When I enabled CONFIG_DMA_API_DEBUG and CONFIG_DMA_API_DEBUG_SG,
> > > I observed lacking dma unmapping on /sys/kernel/debug/dma-api/dump.
> > > And then I confirmed the patch can fix the issue.
> >
> > So, I have this debug patch applied on top of mmc/next. I have the above
> > CONFIG_ symbols enabled. I have _not_ applied your three patches which
> > fix the issue. I mounted the eMMC and read a large file. I see the
> > injected timeouts happening:
> >
> > [   94.079560] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for SD bus idle
> > [   94.088668] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for SD bus idle
> > [   94.097727] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for SD bus idle
> > [   94.106768] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for SD bus idle
> > [   94.115848] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for SD bus idle
> > [   99.300589] renesas_sdhi_internal_dmac ee140000.sd: timeout waiting for hardware interrupt (CMD13)
> >
> > But I do not see any output from the DMA debug system about a missing
> > unmapping. I expected that, though, because your fixes are not applied.
> > The testfile could even be correctly checksummed after reading, just
> > awfully slow, of course.
>
> I'm sorry, I should have shared my log. My test case is:
> - Use dd command as background.
> - Read /sys/kernel/debug/dma-api/dump while the dd command is running.
> --> "ee140000.sd" lines are increased gradually.

[...]

Just wanted to check if this is ready to go or more tests are needed?

Kind regards
Uffe
