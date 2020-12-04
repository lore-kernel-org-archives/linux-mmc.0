Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E524AC4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D0622B40
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 15:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgLDPIm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:08:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDPIl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 10:08:41 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F7C061A4F
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 07:08:01 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f24so6944630ljk.13
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 07:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ugm6nci6pFkFE2fZ87+ANMj4imEPU508tEZXdZdhnMQ=;
        b=p10DaLJuegWL96xzPso5dt1qrw6xgzlmwOoM7oDf4usYdru+bxc+QbiI4MBs0YwHmi
         6oYgnLKlWYw1ZnKUnLeB7VKUYbBS+z/zYK3cEE1d0bQdYbpNY3CJeydIU/+NIpsbQMW5
         5iwMSzHgpA6DWxGvawABSI+IVSiyfjJI41HzjVKEB20clw9Zl5+2gkiTqPKtdHyuxDfl
         FG3bz3narKSAlfO9TG9AlBHkq7IZCnJrkybg+hhCXgXgw2fjHYLEB+UyYdial0Fwh5hS
         oYUAqoD6vY+TVj2LU5U7mJ7WDGKQhJXll4/P7SWUXLuCqwzgruZH0zLIrw+poQm498F3
         /HIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ugm6nci6pFkFE2fZ87+ANMj4imEPU508tEZXdZdhnMQ=;
        b=KdXIaND+n6I1DlhD9zx3NzA2jF+2wQW+uZFgZr3aZ1ZcmDkGLFc6nM5yuZkcCpmTGJ
         AjI5qAzhZyTRP8s39QQtUGN4smjmyrDWtW7b/ugfrE/SLLoAYa+G+hRC1B2C/EtLoMzt
         zh212n+1S1xnTMXdajmUZujXvqf7VkoURsmcGLDszGMyg5lINmw7UFbi0QFqB0yXhTta
         71YYEtV9NOQV5pvmbeexMqnM5bjse3yS4raKJUuDhc1oLcmxfUbmJ22bj9SYj4Bh/wqT
         /XN9fH5pWtkyvzSuZqqDbGIESPjLvO+aGZcTM3eglWFlvinaoa5Qe2JvQvlg3YWCLXWy
         2QLA==
X-Gm-Message-State: AOAM531d7n7N0efTtvBDJq0j2/HvksNJDJu2NmS1M8uLoxp22yWGY5+4
        3KdsFXVu42dHfwE+jQ7hzc7/vK4+RqZfDBs+ds6+tA==
X-Google-Smtp-Source: ABdhPJzHIwMUOmMN2sHISP7xlPGum+N6euE1+Z7nIc8dnisLvUyDzFd9N0UJu6A2WfrDU5SsPk6AJhpJ3zSMrsEzK6g=
X-Received: by 2002:a2e:80c3:: with SMTP id r3mr3574649ljg.391.1607094479850;
 Fri, 04 Dec 2020 07:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20201118063405.24906-1-wenbin.mei@mediatek.com>
 <CAPDyKFpHAWBtxLOOvvqmAYFAwCsV66s_LzzVJg-zfXH5QE++Ng@mail.gmail.com>
 <1606266655.11864.7.camel@mhfsdcap03> <CANMq1KBwtZNgkK5mEUdOk4sq05aXqQ59QsqYqapPqQr7DEWgMA@mail.gmail.com>
In-Reply-To: <CANMq1KBwtZNgkK5mEUdOk4sq05aXqQ59QsqYqapPqQr7DEWgMA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 16:07:22 +0100
Message-ID: <CAPDyKFruM-5MbsPGAt9zvZJFBdRiUuZcG3gphkBJV+y9-Z=VwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: Add system suspend/resume interface
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Wenbin Mei <wenbin.mei@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Dec 2020 at 02:29, Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> This causes a 0-day warning (on our chromeos-5.4 backports but I don't
> see why upstream would not be affected):
> https://groups.google.com/g/cros-kernel-buildreports/c/MfS3SInT5jg/m/Hkzxh_U7AwAJ
>
> Didn't look at the details of the config, but SET_SYSTEM_SLEEP_PM_OPS
> is a noop if CONFIG_PM_SLEEP is not set (while SET_RUNTIME_PM_OPS is
> noop-ed by CONFIG_PM).
>
> So I guess msdc_suspend/msdc_resume should be guarded by
> CONFIG_PM_SLEEP instead of CONFIG_PM.

Yep.

There is already a patch [1] in my queue for this. It uses the
_maybe_unused approach (Arnd prefers that and I don't mind).

[...]

Kind regards
Uffe

[1]
https://patchwork.kernel.org/project/linux-mediatek/patch/20201203222922.1067522-1-arnd@kernel.org/
