Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F866C12002
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA0561003
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Jul 2021 15:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238276AbhGUPFE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Jul 2021 11:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238980AbhGUPFE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jul 2021 11:05:04 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A1EC061575;
        Wed, 21 Jul 2021 08:45:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j73so2295915pge.1;
        Wed, 21 Jul 2021 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=teG+LurOZIg9Q9LM4TLdK2ZjAJcZFHHEl+srrKcW/+Y=;
        b=PqvSEfFLx4ubxnV97UYRdrbXX0iFW2Mam57QGZeIl7HGrUoZvBYgWxeDLmE9LshRwk
         OLmsGsTxZKFJgt1Xd0VubM5PLzgRcVrVpSW/Bks6WaSWpbt+rPrsbe1exFIuIGBGmfNj
         f93zGIy8U4R/ndf/s6gwM97iBiPjWap1Qxe8v3E6OcnZxy0It9MTrrtLsrUwR5hoRmGm
         e0yYEBIoKgJGtDi1GwfN2gcaJTzk/KLWgRZ0OGvgpW4Lza4em1R5ANk9KRkK/XifYI58
         /3k0jI95PNf4yCkqbP8gbEXlBCJ9WFRQ0mUXZIKwiSEOLYe/EQuaL0pQ6LdqMVMLyWwm
         lv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=teG+LurOZIg9Q9LM4TLdK2ZjAJcZFHHEl+srrKcW/+Y=;
        b=TH84Bz/MPjPWPrDk+MYvwGx35RK2bKCNt2z+CYMD0udVcZiwWOq5fapKR4bO7YnS0h
         xF00GPuGKz7YIYMfiAsAk9eSe7ChJPUfzwPMxSM1lhYWtSPK3kXFfb1q1TweeUaAlnNu
         Kq7N3ycbCoBKO6pmu2Pp+sVC0Tt7o627tMRE7Z8MFuASPkd6jbdyV9Xi6VEmhIDqfDEo
         dqM4CG14Fepb0CgM+xhXEB1d4CR9m273XNImFW52j8m7IGUjwYmvaOQxarhWA2BT3Sdu
         78l+ftSPFOwTKLeDYGtK4LDLYUgKlKfQHWwyF8K6OpFcnS9I5/2oHuLkqnv3NdpT0bg5
         oSpw==
X-Gm-Message-State: AOAM5319Dwbmir0YiyCwnsczsEMx9t2jjutJTLfyyJbw9PzBeQZkjith
        5cRdGaZAnEXxTBfOFqtxyqIh9P0DAUPEan4J8rU=
X-Google-Smtp-Source: ABdhPJxKFMFeSHs7BQ6U6M3uOBpNyZrn+gq4G9IJFgTVWlXxn5ZidPmHbZ9H46Il3RS7DpJqkKkb+QGEVqRergHYx2I=
X-Received: by 2002:aa7:8a04:0:b029:332:950e:d976 with SMTP id
 m4-20020aa78a040000b0290332950ed976mr37767197pfa.40.1626882340196; Wed, 21
 Jul 2021 08:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <mvmtukn6bmu.fsf@suse.de> <YPgwHcbK7XoXL/mD@smile.fi.intel.com>
 <mvmpmvb68cg.fsf@suse.de> <YPg3VS/Ure6VRsuJ@smile.fi.intel.com> <mvmlf5z66l9.fsf@suse.de>
In-Reply-To: <mvmlf5z66l9.fsf@suse.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Jul 2021 18:45:00 +0300
Message-ID: <CAHp75VeFKn=--PuF6deOp6H-j7z8PXgkXA5PeSftiK5LWX30Qw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_spi: add spi:mmc-spi-slot alias
To:     Andreas Schwab <schwab@suse.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jul 21, 2021 at 6:16 PM Andreas Schwab <schwab@suse.de> wrote:
> On Jul 21 2021, Andy Shevchenko wrote:
> > Can you explain what is the _practical_ issue here?
> The module is not loaded by udev.
>
> > What is your HW setup and what you are trying to do?
>
> Booting the HiFive board without having to force loading the mmc_spi
> module.

What is your DT excerpt for it?

-- 
With Best Regards,
Andy Shevchenko
