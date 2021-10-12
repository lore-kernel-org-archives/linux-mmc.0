Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734D6C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5993560238
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJLRo1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbhJLRo0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2021 13:44:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FB2C061570;
        Tue, 12 Oct 2021 10:42:24 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y12so2563303eda.4;
        Tue, 12 Oct 2021 10:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PQJ19sfXSUAL086edUdLoT09BoBIfIKIU6q87eukG+4=;
        b=azsbS62tIN7g4mUG5ncni/SX9HVYBaLarqPOL6aus9VelEiHVOXj5rFzhypr74M7o2
         e5vbb8xajqBTRrsSLLJPGv21jInnPPDalJvQa93Zn8bwQHb31OuMOQ/FXwl8rIlYUPW5
         yrtof/2qszWcMJ83M7L5ykWU5hswa6PGBzpRolUd98w+P4zVLB1awPEE3tqQBSkJkWE9
         f3QNWRAqqg+68XVlwtDK4HWWJA3HCkDqCfkPurKdnXIDC1uFCN6WSRtOy04Sd8VoY4W+
         rdVryN2K20xvtflaX77vrWG+OspEAgPaqix3N1r8m/9GD+HR2wmASPy9/xYXBmupEl07
         r1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PQJ19sfXSUAL086edUdLoT09BoBIfIKIU6q87eukG+4=;
        b=a79WF7OaejL5WtM6lo4x3NlwlJrtMXOtZX+KOt6y4+E5FZYcUREuJB/2KDIQhb6Az4
         X7JKcFz6H+PL1Lt3KuzfQ7y5pts7LT0gq61lKQWrxWnDnUztocdZEwF4JbLYvCq14n5k
         RCo3zW+xRJQ352Ew7HodtyUXdUmrkur2FDrVk9MPnctiM7e3FLXzDBZjsQ8jpK+gT3gp
         /INWRQO7bOD7DEmgyqrywpf0E9F5fLOnmSlYaqKYDXhW1urUZU4UKZmJEQECZAUZQoCR
         F7rvlQk0ig7chvF5WT7SLCdpzbGL5ut+svPRCPn9JERJZfhK7cD14PVv/+BjojFx1dN3
         DKOg==
X-Gm-Message-State: AOAM530gXgaIh8//awXGGUqhe8Ia/zhzfeb+iY2SbIp0IngAOKyb912K
        7aSFO/97Bg9pwp+mhSHhwEdKmdFEOLoGHMGi0Pw=
X-Google-Smtp-Source: ABdhPJw4jmlO8sy6C1IGKFwdfyNPWF9nDTQ2RBdB1gQAxKMue3XJ0n28BZM+XnO+4DBKtHM+YWgdOA9fstbbB69/Qqo=
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr5499636ejb.356.1634060543536;
 Tue, 12 Oct 2021 10:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211005102430.63716-1-andriy.shevchenko@linux.intel.com>
 <YV8jfavX/W9T25YX@smile.fi.intel.com> <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
In-Reply-To: <CAHQZ30BbXA0GEuzUy68=W94ArMiO=3Sbg-HQNqUdtSTcvWOF0A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Oct 2021 23:41:36 +0300
Message-ID: <CAHp75Ve1Uy=U8wuU4rG5OU5NNr7xcmhQmGBPCm-vJSCWih2MqA@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] mmc: sdhci-pci: Add some CD GPIO related quirks
To:     Raul Rangel <rrangel@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 8, 2021 at 1:29 AM Raul Rangel <rrangel@chromium.org> wrote:
>
> It looks like you were previously using the `cd-gpios` DT property to
> determine this.

No, it's not the case. The case is that we switched from hard coded
stuff (board files) to ACPI.

> It also sounds like you switched from DT to ACPI so
> you lost the ability to use this field?
>
> Can you not use something like the following:
> https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.10/drivers/mmc/host/sdhci-acpi.c;l=945

No. It won't work. Anything like this won't work.

The problem here is on PCB level due to different uSD connectors ()
being use: one is Active High, the other is Active Low for CD signal.

...

> > > Any comments, hints, advice are welcome!

-- 
With Best Regards,
Andy Shevchenko
