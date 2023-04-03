Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE83C76196
	for <linux-mmc@archiver.kernel.org>; Mon,  3 Apr 2023 10:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjDCKUl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 3 Apr 2023 06:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjDCKU0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Apr 2023 06:20:26 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A93191E8
        for <linux-mmc@vger.kernel.org>; Mon,  3 Apr 2023 03:19:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-544f7c176easo542125177b3.9
        for <linux-mmc@vger.kernel.org>; Mon, 03 Apr 2023 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680517196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lp0BLLQBN2ilvTYYIEzYJ9tUjSW7GVxv76XWWf0QlS8=;
        b=KSTQFALdpnJKwLuP2+1MoVvtPpkWH4ZtlCH/c/StL08N808VQLQ6SItATE78O/v/bx
         ZAMW8ZFbIhmKrVAuA2TOPVtjIJWyEjPJfWzOYWSLmuCSb3QSv5nFwP959O08oSN4yB3U
         ieEtKF47rdiIsIfe+sYTZwE89ixi+M8W6KTG7Hqw5MLO7lINPSObB+skqQ3+WfrBkZ96
         4jaeqFdl1Pt1UXo9bzlTEhKr7Uk31xl6nD5Zy6mrAKAsINjTKpIp4837zuDoxcQ0OJLQ
         g5Mek6PfiD7sJyZcUSTM7unX7Fz5wmc8J7KrTigSmzWF3zrqLJD6BgNRz9csepUHtfZa
         ow+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lp0BLLQBN2ilvTYYIEzYJ9tUjSW7GVxv76XWWf0QlS8=;
        b=nmetywyXYg7TKWUparrrLP2YrcpxH2edTB0fZms+nMLACFbgd6QTGtBuc0DaUecQXf
         qGkg2xV0ttqP2YwAaannloEVElXh30mQYtztcjpzd3mLetaUm0EH5BwkkqSPXbWaoqPY
         3SrouGdo0r3KgbzJIwRxsGuyX9U6njJ8ByJ/kfE7Moznq/n+1ibxuixv5j21v4tZsjIu
         q8DfX1NPkMCiDbrVRh4owFY1+qlGjdt2KRkO+ovCan4t3+EJ6O3orRCy2V+P4Z9yaDYX
         x/nRyLIl/1Ayew4R7bKXuXdoya34qZHa4gPDwK4Abbmj5u41ryuEbZeFR6sXgrc0dSZk
         n/Nw==
X-Gm-Message-State: AAQBX9fNJDAeY2WEtML+CdoqvQlE309igY7z6WzKkFeNzAYuVduBcrfe
        lC1t4CkUW5psqG8ktWHbYNTFSrjdEQFG+7i8RBFNjQ==
X-Google-Smtp-Source: AKy350YhYZogXzDxm0DJvq1IhseeXwZR9g1D2sSXkhm/gaY9yXhaLqgbV9jqE2ZDjwUhxJR3X9vU1oHpkKtzj96/3H0=
X-Received: by 2002:a81:ac46:0:b0:533:8f19:4576 with SMTP id
 z6-20020a81ac46000000b005338f194576mr17541978ywj.0.1680517196473; Mon, 03 Apr
 2023 03:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
In-Reply-To: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 3 Apr 2023 12:19:20 +0200
Message-ID: <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com>
Subject: Re: sdhci_am654 and runtime-pm issues
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 1 Apr 2023 at 15:16, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> I looked at the sdhci_am654's probe function and concerning runtime-pm
> this is at least unconvential:
>
> It does
>
>         clk_xin =3D devm_clk_get(dev, "clk_xin");
>         if (IS_ERR(clk_xin))
>                 ...
>
>         /* Clocks are enabled using pm_runtime */
>         pm_runtime_enable(dev);
>         ret =3D pm_runtime_resume_and_get(dev);
>         ...
>
> I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but I
> thought it is to be used the other way around, i.e. put the device in
> operational state and then runtime-pm cares to suspend the device under
> some conditions (e.g. CONFIG_PM being enabled).
>
> With CONFIG_PM unset the driver is broken for sure, as then
> pm_runtime_enable() and pm_runtime_resume_and_get() have no effect. So
> the clk stays off.

In principle, you are correct. I wouldn't recommend the above pattern
in general, but it doesn't mean that it can't work.

Some platforms are selecting "PM" from some of their toplevel Kconfig,
as they simply can't work without it. That means that the code you
refer to above, doesn't have to be broken.

[...]

Kind regards
Uffe
