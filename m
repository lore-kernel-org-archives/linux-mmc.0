Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BF8C636D4
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Feb 2023 08:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjBAIT0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Feb 2023 03:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjBAITO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2023 03:19:14 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18E5EFA7
        for <linux-mmc@vger.kernel.org>; Wed,  1 Feb 2023 00:19:12 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id m199so21343808ybm.4
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2023 00:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+64qMYUS/9LKQSKQXuUu9URV5MQO5mnEzXLsozGZuwc=;
        b=XWbG/S1RDk8VgXptly9M72Hq2lxAP50GMzcjVoG9FOZ8AqmNbrUJCuW5f1ItVXcIBw
         j2FC21FSIrrLVyH5456kkpx9rEdoI25uwO+JZylNko+P7/OdsX28fFky+udGd6VkSKlW
         Bt5oah17IhBpncHnF7EgKyQHW6ciCOD0t3r+jYIaW0hDNNVQURQcdP1qCLefZ5d5Fh+j
         F4zRZp7D0tviaWavSBQI46Qxr8CKJJePIwGBrtVDDOhKQKKwWfnfBW2TWN4+zXJ4j1AP
         v37J/N1pcwyuCw7XWr/INe+eq8HMIwcr4adE0Wq6V39tMymR4kxiOy0VQKQNXTTrj8Oi
         7UgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+64qMYUS/9LKQSKQXuUu9URV5MQO5mnEzXLsozGZuwc=;
        b=AYpEMdz/zp7Py3osRT3YyZMtu/iR+QD/tLN6dibrwJsYuSFsufP9DNs/9tJOOCCQRD
         sU70rOa+fPskTsdx9b4dvUNiP092IKphTJ2apTwyMhQ5ThBL7WobzW/BQF9RlCP2eYbG
         ammyUocZM3nvM5BXVp+tl3mlWToVs5eB1xj3EZ74dBqBVTm7FtWA+P/m5m0l4RXQ3iYN
         AoF+vPUOO0lQfF6l8EJjKhX9OEKuv3Zwbpy23Qcl2ZP67zNsjY5RIYeLPoitPgYGm2wv
         uZ2X7rdV/6ErCTGcq0aMNXDM2Fj0gSzqR5etwFvDLZGRPp5YPvmgU1Rxus0j2locrofX
         aeLA==
X-Gm-Message-State: AO0yUKWDWpx3UNvtoLE6PBBagY0tOLD0TaMrT8reR0VaOXgLeEutGWza
        JaphT+OXW8h2szdJcefbc0Rv28cUhgmC0H/Ckw1/Ww==
X-Google-Smtp-Source: AK7set+DH3RZ68yOI7vMHe9szOffDyqgQ7KDz6Pee0wFzmgvjgQSDjzKmzZWDta15XaKVJWTZWtO8SBTvQDCjdVJqyk=
X-Received: by 2002:a25:9191:0:b0:7c0:acd2:6300 with SMTP id
 w17-20020a259191000000b007c0acd26300mr189458ybl.520.1675239551079; Wed, 01
 Feb 2023 00:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20230131084742.1038135-1-linus.walleij@linaro.org>
 <Y9jY2zsNbSCWluZG@infradead.org> <CACRpkda3mk8wkdxWQFev9PrK6bPsxR6qLJo_gXnK+_jaTCFfjg@mail.gmail.com>
 <Y9kVrh9VEz4/T76f@infradead.org> <CACRpkdbd73PEAaNYr2cz=pmw7guHK0-hiPCYXgpgQfy-d9TTTQ@mail.gmail.com>
 <Y9kvh42/T9rdqDH9@infradead.org>
In-Reply-To: <Y9kvh42/T9rdqDH9@infradead.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Feb 2023 09:18:59 +0100
Message-ID: <CACRpkdZ-r_toj3FWuxffSzmO=cDq2Og79R2t48-oAoCE0bT1sw@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Imply IOSCHED_BFQ
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 31, 2023 at 4:11 PM Christoph Hellwig <hch@infradead.org> wrote:
> On Tue, Jan 31, 2023 at 03:05:20PM +0100, Linus Walleij wrote:
> > To be clear, "works better" in this context means, solving a problem
> > for the interactive user, preventing random freezing of the UI on
> > resource-limited (memory, disk throughput) systems under high
> > I/O load.
>
> Which already has nothing to do with the mmc driver.  And the rest
> of your mail makes this even more clear.  You want bfq for interactive
> systems with little resources and really shitty storage device, which
> just happen to use mmc in your use case.

First time it helped me it was rotating rust actually, but yeah MMC/SD
is one of those.

> My use case for sd cards OTOH is extremely resource constrained systems
> where I absolutely do not want a bloated I/O scheduler.  In fact I'd
> love to be able to even compile the infrastructure for them away.

Hm I think you're mixing up different resource constraints here (that
your storage is slow does not mean your CPU is weak or that you have
little RAM) but I see your point.

What I think a lot of the debate is about is "abundance of resources"
systems vs "constrained resources" systems. Some are hard to keep
busy (such as MQ devices) other are hard to get access through
because of constant overload (such as MMC/SD-cards).

> In other words:  you want distro policy to use bfq for your use case,
> but that has no business being in the Kconfig.

Well *using* it is still the matter of a udev rule for an ordinary distro
as we have no mechanism to instruct the kernel to use any specific
scheduler with some subsystem. (I think we should have some hint
for that, for slow single channel devices for example.)

The Kconfig change is mainly about making it available for use,
for systems with MMC/SD-card drivers.

Yours,
Linus Walleij
