Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FB3C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Dec 2021 14:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352890AbhLXO2Z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Dec 2021 09:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352862AbhLXO2Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Dec 2021 09:28:25 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E6C061401
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 06:28:24 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id n7so15389162uaq.12
        for <linux-mmc@vger.kernel.org>; Fri, 24 Dec 2021 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gzvUmJjDoM/LnPbSY7JUae+gGZ41KvmFEWNsBT5Rvm0=;
        b=JaAZstiW//0UmA3pGcUfpkyiW7fkZwCkgO5Dm8CQHRZZedHyLRSpaMuKlBcthSwhPQ
         N6+uX5y51+s9TLDK3ockjWzhEBdMIcYmkFNsqKQdwhqZUuMLuPVMVSHrGp/ZrQ2oOsAg
         8gjkEt4TAazvZbsuItjSgqJdpf2p3yrAsU44H69kayIdxiLjA/Fgrtsf64lf8fSiAen0
         xHdU8FLw3RGJjC55hjmAtnlUXsLhI56Wn9SWH2LCfULKdtHf3qSpd7T5wzCTUmpHbMnk
         jrnpWFZZYaj2hCFCSnZ7PoMNBpe12Fp5XMh+Qh8jE6XC3f/pgnR3cafUJxatoysJ/j6E
         nWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gzvUmJjDoM/LnPbSY7JUae+gGZ41KvmFEWNsBT5Rvm0=;
        b=VIYSGZbS6inTDAoWlKxjQ/Z30wprkgfK2KdA9GWiWIGzON/90vI5o8CQa4DFvfgliV
         bg0MnJx4Zjp5Q1Aw8lBwRf5PDXR2K80mFHO0UJk+sJedzwBigXeYI4fl7ZZ8Awx0viTv
         ol5lJiVvfBzs6nKZ5aEUxgumyMSRWLC3YmDqNkRDiyAh0itRpZ/xRmCv8ks5zf4/FVPs
         pjPl6aDrRHiTyfgxcnivfhuq/3jhG8uMXHA7eDhkfbpPzUtM1eB+cxtBxX2oigLlqVKK
         rEGLJzT1N6B03wKxazo+jK7PkR+sgHLAWsLwM6L4ozH7veYyZjxHXrhhQQHYumDDe9Fw
         E2Fw==
X-Gm-Message-State: AOAM530dtFfOUkpV78Qyy1Eo8pNh4eT8Jcm91HQZuoaTCnWYMqnL4oqQ
        gK9VBbU0zDigM2mJiX+q4UN/6H2tpst8MWxAaX177/W7NPI=
X-Google-Smtp-Source: ABdhPJz8yhrLdmQaobJP1VG7GCpZHpnxfs3sosM5nNshpSKJP1YIZf5pGJcSLvLQc8XcHU1qHQ5ia8VSovUC5Kxl1io=
X-Received: by 2002:ab0:48cb:: with SMTP id y11mr1030742uac.0.1640356103650;
 Fri, 24 Dec 2021 06:28:23 -0800 (PST)
MIME-Version: 1.0
References: <f642ef4d-6027-eb2e-0257-1c4f13911aed@omp.ru>
In-Reply-To: <f642ef4d-6027-eb2e-0257-1c4f13911aed@omp.ru>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 24 Dec 2021 15:27:47 +0100
Message-ID: <CAOLZvyErUACdd8Tcv+tJC36DYS-C-PybwvMvgPs2aj2N8Q831A@mail.gmail.com>
Subject: Re: [PATCH] mmc: au1xmmc: propagate errors from platform_get_irq()
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Dec 23, 2021 at 7:45 PM Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> The driver overrides the error codes returned by platform_get_irq() to
> -ENODEV. Switch to propagating the error codes upstream.
>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

Sure, why not.
Tested-by: Manuel Lauss <manuel.lauss@gmail.com

Manuel
