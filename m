Return-Path: <SRS0=4vPn=2G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AFBC2D0CF
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE4206D3
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Dec 2019 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMYNmrDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfLPICQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:02:16 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:44454 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfLPICQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2019 03:02:16 -0500
Received: by mail-vk1-f195.google.com with SMTP id y184so1357391vkc.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2019 00:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Ep2QCdJlKr+TyNg9ZznUSUSlsgcyTzmJiAJ0k9iPPA=;
        b=mMYNmrDrg5AxzSc6pcHqwBFxyjG3hWU63y04GsqBzyQQ+dBj0dN+Ez+m6I8vh+dLTN
         IjadAfi9yJTIE6MtqNbP3E7p0SfuC6oT8+dlXkOgrlwk12oayA2jRypbB1/W/Ub8DOyy
         3e/gwiDXBB1k5F4IJyDfGTjAec9HRkbS9c1ihZIi1tJ4l7Mf7YfewJQIOvV6c30GnsNm
         c+aBlMs5ZH7dwOh2Y/nfPI9guIL2XweoUUP+dgy0zpuE02Krj4s83kwujHdwW0VEj9G8
         D5BbeFybH/lFY3xugIroYY3YFkQ6hYBdX/MxLzq8JuJdc9fTHcdfdOQa44I15MulIE60
         MSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Ep2QCdJlKr+TyNg9ZznUSUSlsgcyTzmJiAJ0k9iPPA=;
        b=NDXb5VggWzXY8AfHIfe7QI3WaHT92r39UHHIOJc6Fvcdo6C6WsevGaijT7ykVMkixl
         O4yd/oIUaNksmbVuRY5a2vYLGF8Rwy1ONHG1ydlgBKm8ZJSNknlUPW9mcT1HQxTZE++e
         JpU29ege0UOk2queRwwwdpztq7+GHNoYitexPUCEYRuSeKTLTJ7rQJAo+tHMFmBQRsUv
         u6yssZdl+wj7TVctGIhUoV7k4C3J2D3OjbdseEPglZtVRPZ8UQwtbWUTKE3B1+sIT/9L
         mZtbX1GXxq6VMnS8pD0r9sxJbB60v9ZocY6jrTtPc52MK5U+LYq3j3hmOBwJWJdTPNly
         mlYA==
X-Gm-Message-State: APjAAAWBDDmsg8NAd2EBzYhNHQj6UbtHfeHDRkLwX60wlMyT2+26ID4n
        2Q81GzMxKZF/agaxMwsNeRV57G22ksaM74vvw7Hhfw==
X-Google-Smtp-Source: APXvYqzBnQzdKrEWuj834Usnxn0YZfnxNBxusbpjzzcPns+vYb7S0z8Y+JeuAdw9b6S2rwCqoYtfAhOzeEmRmO6d6jk=
X-Received: by 2002:a1f:7288:: with SMTP id n130mr24095211vkc.46.1576483335271;
 Mon, 16 Dec 2019 00:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20191206170821.29711-1-ulf.hansson@linaro.org> <20191206170821.29711-2-ulf.hansson@linaro.org>
In-Reply-To: <20191206170821.29711-2-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 09:02:04 +0100
Message-ID: <CACRpkdZmuvRbLrud86Jd-8w4pBx5u8L+TvNpWAOtyAvNw6OFnA@mail.gmail.com>
Subject: Re: [PATCH 1/9] pinctrl: core: Add pinctrl_select_default_state() and
 export it
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 6, 2019 at 6:08 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> It has turned out that some mmc host drivers, but perhaps also others
> drivers, needs to reset the pinctrl into the default state
> (PINCTRL_STATE_DEFAULT). However, they can't use the existing
> pinctrl_pm_select_default_state(), as that requires CONFIG_PM to be set.
> This leads to open coding, as they need to look up the default state
> themselves and then select it.
>
> To avoid the open coding, let's introduce pinctrl_select_default_state()
> and make it available independently of CONFIG_PM. As a matter of fact, this
> makes it more consistent with the behaviour of the driver core, as it
> already tries to looks up the default state during probe.
>
> Going forward, users of pinctrl_pm_select_default_state() are encouraged to
> move to pinctrl_select_default_state(), so the old API can be removed.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

I have put this patch on an immutable branch so that you can pull it into your
tree:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-pinctrl-default-state

I also pulled this immutable branch into my "devel" branch for v5.6.

I think other subsystems may need the same kind of stuff and I might need
to change code around here so I need to apply it to my tree.

Yours,
Linus Walleij
