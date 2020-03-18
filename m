Return-Path: <SRS0=6IoW=5D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD793C5ACD6
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 07:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E13D20768
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 07:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvNwNyny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgCRHfa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Mar 2020 03:35:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40472 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCRHf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2020 03:35:29 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so25781654ljj.7;
        Wed, 18 Mar 2020 00:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k7ojDd8bH4rHuUROHL8yQ33iky3lTQUOUIq9HFOqbw0=;
        b=fvNwNynyOikKBbNMPLWFivb8+f/I6G7r6/sGEbmTWHGmzpQjeP9wsYYAXLZOy0ELEs
         uQxerWZnBTiM6a9jVTPHhErJlqLNLYHgux/6v9CSDe9kf1nez6AXTEiyIlPDWkyT4pYr
         bQuatnuTbQSpLCEqyTaJeltoOLQ6fNNUCh9YOnaErd5yfyvoIBHRhsg5geZ5yd54bYun
         0KXbm6R18BztDKMtycbA4Xd04h/VK2yJh/A9Pcfe5LRneZXcwA2Sz5iYx0MDHKstqVx4
         oxyyrUVcF9wRb5FplwuzoHbs2aqwGM3m0P1Kqcp8TLCLHROj2YlHxbw11gR7/Q8FqApB
         +CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k7ojDd8bH4rHuUROHL8yQ33iky3lTQUOUIq9HFOqbw0=;
        b=TvgfDkQ1myW+0N9bsvhBEEefZP1oK5euf/hW2XPx3StBZvHCaECckJO+6JJ5d8ZnGX
         PETUynC4ph6m7gdl10RFKnEvGNMQeiZuasZYp164X6i8A6WxMlMoQ8u6/JPKhu2yA4Ve
         R6lW7jQhwYEon/fystqrFN0NMvkipBqz2Jk5nhhCE3X1OzQgpiIEM9eCgfNvk4bKzO14
         r8tPSOYbZcuqGK0WW7xG2sMikDWTWGaCVXfJq65D4Ib5c6H99g4j3JULr8iBDhvywaxK
         nU9FOm+joHqgajRXOb1JZgb46i9SbSZ1bmKtyesNzeOqgJ9WZ3trZgH4qppQQx4Mo7ot
         hDYg==
X-Gm-Message-State: ANhLgQ1LT84SLVNxnhHMeHHp0xTbZa3TjgRw1QBL513hU1RwYap2B1Tp
        Hg1eGUNVyWFUZqMN6Oha1ZFu2bfIX4xUAK11YdE=
X-Google-Smtp-Source: ADFU+vtpXx/uYsdmeJhw5fEuthwiRX9xrXySvD7fu+K1NVi3etsAr/tIqptomf57tOeij/3UfqnMGqSKp4p5gwy/kXs=
X-Received: by 2002:a2e:8059:: with SMTP id p25mr1565366ljg.196.1584516927469;
 Wed, 18 Mar 2020 00:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584428736.git.baolin.wang7@gmail.com> <7866e519-80ad-8678-6708-7726a53ea4f5@intel.com>
 <CADBw62q7q=wqKGBnLRA+npYLVZVXeMiFwGP-K1TLkG2GPCwLjg@mail.gmail.com> <ce622b0c-6ec0-10c8-f71f-fa2bba8b4a66@intel.com>
In-Reply-To: <ce622b0c-6ec0-10c8-f71f-fa2bba8b4a66@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 18 Mar 2020 15:35:15 +0800
Message-ID: <CADBw62pAm2h5m2Hz4uXHv6m0W3RpA7BoegwBHc+s2RK6spF_3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Introduce the request_atomic() for the host
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 17, 2020 at 11:07 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 17/03/20 3:49 pm, Baolin Wang wrote:
> > On Tue, Mar 17, 2020 at 9:25 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 17/03/20 12:14 pm, Baolin Wang wrote:
> >>> This patch set introduces a new request_atomic() interface for the
> >>> MMC host controller, which is used to submit a request to host in
> >>> the atomic context, such as in the irq hard handler, to reduce the
> >>> request latency.
> >>>
> >>> Any comments are welcome. Thanks.
> >>>
> >>> Note: Adrian pointed out that it is not good if moving the polling of
> >>> inhibit bits in sdhci_send_command() into the interrupt context, but
> >>> now I have not found a better way to address Adrian's concern. Moveover
> >>> this is an unusual abnormal case and the original code has the same
> >>> problem, so I plan to create another patch set to talk about and fix
> >>> this issue.
> >>
> >> I tend to think the API requires the possibility for host controllers to
> >> return "busy", so that should be sorted out first.
> >
> > If request_atomic() can return 'busy', the HSQ need queue a work to
> > dispatch this request to host again?
>
> Sounds reasonable
>
> >
> > I am thinking if I can introduce a new flag to avoid polling the
> > status before sending commands, cause from the datasheet, I did not
> > see we should need do this if the command complete and transfer
> > complete interrupts are processed normally. At least on my platfrom, I
> > did not see the inhibit bits are set. If we meet this issue, I think
> > some abormal things are happened, we should give out errors. How do
> > you think?
>
> For the atomic path, some kind of warning would be ok.

OK. I will try in next version. Thanks.

> >
> >>>
> >>> Changes from v1:
> >>>  - Re-split the changes to make them more clear suggested by Ulf.
> >>>  - Factor out the auto CMD23 checking into a separate function.
> >>>
> >>> Baolin Wang (3):
> >>>   mmc: host: Introduce the request_atomic() for the host
> >>>   mmc: host: sdhci: Implement the request_atomic() API
> >>>   mmc: host: sdhci-sprd: Implement the request_atomic() API
> >>>
> >>>  drivers/mmc/host/mmc_hsq.c    |  5 ++++-
> >>>  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
> >>>  drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
> >>>  drivers/mmc/host/sdhci.h      |  1 +
> >>>  include/linux/mmc/host.h      |  3 +++
> >>>  5 files changed, 47 insertions(+), 12 deletions(-)
> >>>
> >>
> >
> >
>


-- 
Baolin Wang
