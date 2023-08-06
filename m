Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D484C41513
	for <linux-mmc@archiver.kernel.org>; Sun,  6 Aug 2023 20:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjHFUof (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 6 Aug 2023 16:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjHFUof (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Aug 2023 16:44:35 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE231713
        for <linux-mmc@vger.kernel.org>; Sun,  6 Aug 2023 13:44:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d075a831636so4311093276.3
        for <linux-mmc@vger.kernel.org>; Sun, 06 Aug 2023 13:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691354673; x=1691959473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wI6YCUXogiyHKAZj5fEeBvGfkgZpTozFy1IwjbVYrU=;
        b=lHdpwkEK6FPtL8KD5epPve/3UKd2VMRAvY507u8XgqckRU69zSmqlh9tVChKPsRGpU
         I8kqIlhFETfn5VTPVJS51/sPjUWtkZe5kj65PRwDgoq7FPJeZNAdNt/I4qgpUnngAIhY
         19+nJg4xEWIu2aRHnM47vD4GvDzKGTwBbW+gFl62woEDd5Kj2dYPiMo2BuW5al0jdZP3
         KcK/6d8DRE8WEIGA195EV14ouxuqN3xcLbJ0oPPx5wzBbxAg1ZPDzjJ2v0crnqEvaW4x
         k7QPIDNsUUZdGhR2eUnikM6tIsCQq8USeb/AQswXrEe1xKWa/rKc+mBeDvVfxR/w2Jvo
         jSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691354673; x=1691959473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wI6YCUXogiyHKAZj5fEeBvGfkgZpTozFy1IwjbVYrU=;
        b=erFr9uembHd34nco4ALV2M+hMKW5ANAo5qbTKg4OqkEATESGVDSlPl6pyO4ppa7i6B
         EARCnXsOwATeOjlD2JsRzhhtoWMFDXsl/q5FQ1RQSpcsEIxXAUgVP9FRrF2F8Qcty++m
         ixCXDClHjHjkWMCNmYW4ym3ih1c+Xpw8TcwFcjva7lOlX0VDvKPhkYWYmUDw+17mp6xO
         rWojkOfZ0zLddRy5mkdiRe9JmJRTk4Xgoq6ZZV+2B0HjIcUOfceh+QRehK9PNS4W5VLi
         LzY+oVA+7p8HdLYpkZIDq0ZnxOh3g7Jb0Si0CsDvpiZiKZjz84xXPK2jaCcUj4zhNmEB
         PfRA==
X-Gm-Message-State: AOJu0Yw5v7cUGHYXKY1NKgEFeI/5q4+4Fa4xyY1OKmVjqyj09g+ZV4oF
        v3U2FUqhao/XSgu7XeW1HoURVU1VTc1YYfLIu2eHaw==
X-Google-Smtp-Source: AGHT+IH+SxeDZa3CS+VvMm3nn79tkiiMcdWIMM1zA3LZ+hP44KT5SAPBtDrABDbUrxBu9fq/MsHBL1jrAuopwtrHYU0=
X-Received: by 2002:a25:b0a8:0:b0:d0b:7ad2:6426 with SMTP id
 f40-20020a25b0a8000000b00d0b7ad26426mr7131022ybj.18.1691354672912; Sun, 06
 Aug 2023 13:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZM+IlctTTQLs7Qg9@lenoch>
In-Reply-To: <ZM+IlctTTQLs7Qg9@lenoch>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 6 Aug 2023 22:44:21 +0200
Message-ID: <CACRpkdZmd-nb21Cx-jp-CDRjW4VQRV=c4MekHxS3h2p3HsDwZQ@mail.gmail.com>
Subject: Re: (Octeon) MMC performance degradation due to too many requests
To:     Ladislav Michl <oss-lists@triops.cz>
Cc:     Robert Richter <rric@kernel.org>, linux-mmc@vger.kernel.org,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Aug 6, 2023 at 1:48=E2=80=AFPM Ladislav Michl <oss-lists@triops.cz>=
 wrote:

> How do we get there?
> ff4143ccff31 ("MIPS: Octeon: cavium_octeon_defconfig: Enable Octeon MMC")
> enabled MMC driver, but left MMC_BLOCK_BOUNCE disabled, although driver
> performace depends on it.

Ooops.

> c3dccb74be28 ("mmc: core: Delete bounce buffer Kconfig option")
> Added MMC_CAP_NO_BOUNCE_BUFF to the caps, based on assumption it should
> be there as MMC_BLOCK_BOUNCE is disabled in defconfig
> de3ee99b097d ("mmc: Delete bounce buffer handling")
> finally removed all bounce buffer handling as almost nothing needs that.
>
> Sadly, 70XX SoC cannot do SG, so it suffers a lot. Strangely enough,
> above patches are either authored or suggested by Cavium's employees.
>
> So, given the number of affected SoC and before cooking driver specific
> solution, are we sure we indeed do not want some generic one?

So you are talking about something along the lines of:

commit bd9b902798ab14d19ca116b10bde581ddff8f905
Author: Linus Walleij <linus.walleij@linaro.org>
Date:   Mon Jan 29 00:44:53 2018 +0100

    mmc: sdhci: Implement an SDHCI-specific bounce buffer

?

Yeah I guess that if this is needed by more than one driver it
should be made into a library, or say a piece of code turned on by
a config option that the dependent drivers select.

Interested in the job? :D

Yours,
Linus Walleij
