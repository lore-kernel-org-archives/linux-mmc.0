Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1FCC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Jan 2022 14:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbiAXOla (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:41:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiAXOl3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2022 09:41:29 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84291C061401
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p27so50024799lfa.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2022 06:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXy37d4XDPWa6rl+fssLb79KAEtEH3NcZpEw3dhV2sc=;
        b=CYmOyiueadc7oPZC42g8yUASMCna1tx/Dqc57iAKHKguEipAC9PhRU8OJQ1S3WEw8Y
         lIsIN4unXm5UhxLvOjPndzHa8qNlpO8gMtFerpapyTfDKGK0flQvnWvGitoa9jOH6353
         lU3ZqPCqW9F1lUZHuPre4Kc/1+9ZpCRLbh5XQJm+EsshvUy66MnYtYW/Lds0p+nk/kQ8
         p0W8UlrWN8SpS1TmD6krCVdgV69NfoYIwxKj1syEl+aXJv+6UBv/TbKJ1bA1eccHrNCW
         hIryF+530Qtam0LXybnDvJcnQ0sijoZESQ3zkc1CbXlfzHvFRy+Fu3Amq5UCbgiI7bkP
         Pd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXy37d4XDPWa6rl+fssLb79KAEtEH3NcZpEw3dhV2sc=;
        b=EertSrTqwJEmPXfI1IfACOR/mWvhclko2jJYsdcbg9RrhIOAkbEYt3MDtxkHnC19EJ
         fZXr0EnS9DPfWxDEGvMthk6UJ2Jy3G//zBvLZB/Sl4v/vQqBxBi5jve9HhIMq/witTnS
         gAbr8G8SHPPYqOnvon+u+u+uAUlHj3aGE4xge6OfMI3TVmj3OeBiC03m9gpWvLFyiKaf
         yzM7Dyz0cvvo61fbxvmchZilalsPLaH8TDJga54MkoIZQKuPi4unyoWPUErLbX2UE89+
         R/QTseJCVKTJf27Qrj2zZURo2XpRRpjSpPyf34KSbfvaHnetRVTOsOHXKwsi46I9gqy2
         zMVA==
X-Gm-Message-State: AOAM530Tw6H+qB3P29i4CW5D5iH/ojl0YwGgy+ltmkKlkPX7Of40uGfx
        UXCygpatCMZ2AUMk1wc67vZ0hiCzIfX6nZfJPytmPA==
X-Google-Smtp-Source: ABdhPJypBPpHOmQGPutmK8yhtxPplmuDP64mDi+gR8RQXoiGgBHLdK+MDDFSYIxODnIFjvAlvqNcTQ1h40QgvhekwtU=
X-Received: by 2002:a2e:a233:: with SMTP id i19mr6265411ljm.16.1643035287561;
 Mon, 24 Jan 2022 06:41:27 -0800 (PST)
MIME-Version: 1.0
References: <20220113170300.3555651-1-gsomlo@gmail.com>
In-Reply-To: <20220113170300.3555651-1-gsomlo@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Jan 2022 15:40:51 +0100
Message-ID: <CAPDyKFrYiRYioSgS5Dy8YWKpp5xqFtgnez7g3598RB_oar+sbw@mail.gmail.com>
Subject: Re: [PATCH v14 0/3] mmc: Add LiteSDCard mmc driver
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, krakoczy@antmicro.com,
        mdudek@internships.antmicro.com, paulus@ozlabs.org, joel@jms.id.au,
        shorne@gmail.com, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        rdunlap@infradead.org, andy.shevchenko@gmail.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Jan 2022 at 18:03, Gabriel Somlo <gsomlo@gmail.com> wrote:
>
> Add support for the LiteX SD-Card device, LiteSDCard.
>
> LiteSDCard is a simple SD-Card interface available as part of the LiteX
> environment, used with various RISC-V and other FPGA based SoCs.
>
> New in v14:
> Documentation/devicetree/bindings/mmc/litex,mmc.yaml:
>   - add missing `vmmc-supply = ...` property to example section

This v14 series applied for next, thanks!

[...]

> Gabriel Somlo (3):
>   MAINTAINERS: co-maintain LiteX platform
>   dt-bindings: mmc: Add bindings for LiteSDCard
>   mmc: Add driver for LiteX's LiteSDCard interface
>
>  .../devicetree/bindings/mmc/litex,mmc.yaml    |  78 +++
>  MAINTAINERS                                   |   9 +-
>  drivers/mmc/host/Kconfig                      |  13 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/litex_mmc.c                  | 661 ++++++++++++++++++
>  5 files changed, 760 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
>  create mode 100644 drivers/mmc/host/litex_mmc.c
>

Kind regards
Uffe
