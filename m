Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D9C2BB1D
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E122076A
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUTXGkGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQNtd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:49:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40590 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQNta (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2020 09:49:30 -0400
Received: by mail-qt1-f194.google.com with SMTP id n5so17413870qtv.7;
        Tue, 17 Mar 2020 06:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMhZnwDq2qotNqPmQZZVrp6gVfefOgqlfj5FYdCn0kw=;
        b=dUTXGkGQKSMol7XycTuVd8DQ4L9zuSOham+JSFulc/UR+FEK2sbjrW7suHNtwgYHhm
         +Yab+P3ocuqosksvlhbzsmTlBCts7+5EoPklDLfcs+/QA95HsOWH9Y+WS/ls+vXPBCjE
         c1bAeqatXWBxEqHlMyetwqIEsZa4cm4vXQ2+wH/w3ar0FKhblPOFkd4e02xWelZy5+uh
         xe8/XQngc+RDk84yPAzAN8w9sd/4d8X5V0MmLXrVHRYV0UpLBAqEzsePbicAkiMx/N58
         zP7My8YsdmQSdKrYebbOzfu+/kklS2CDsQjczMJPbGo0eJ6yht7YB+YGXNMW7M/7+R9Z
         tqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMhZnwDq2qotNqPmQZZVrp6gVfefOgqlfj5FYdCn0kw=;
        b=sZ1QpBmGkmqKF1SAhEWVmRPGx20NgL+RxaoSrpPjNi+cjQmDzpiJRIdxt9h5Ankr9U
         biOMI4EeEqDJSHhWSrltrnebw9Fj6H3bNvq7j9HRvhUI5Z/DioyOZc26bpHkKWyS4VK+
         XBPTnLNexkpVcqFcykhRIGh6Mzy7/KsIIfY+zgt3Tn6BcVuGoxxclXb4gUaVjDDcsHPB
         fTA8d+62LdN4XF8J/hxvESnEuIWiwF5NhKyDb/Ikl9CY87Y2LnZ8Mb+yXCTiZME4Piq5
         VRijTc96kwsoqg6+U4XopQPDpNH30n6bJ3dWOf0X5X/TQhHnKb0GbXSj6KEgzGZl+KHM
         sWpw==
X-Gm-Message-State: ANhLgQ2Gvg8t9hS+vadaCk0roaO7DdSKNVbGtUGWPOEyekklwkymMB7R
        4083XM8eSPZy108k5BDKrE84OnJNtGzLbT0FzEY=
X-Google-Smtp-Source: ADFU+vtb0yCQKHay0Vu5IPwCYPeElhXD0FecD4QJ5mjHgrga4K1+37sKrB9jbbvkEybXIVoSc0GLRXBACRezHzwTzNU=
X-Received: by 2002:ac8:1add:: with SMTP id h29mr5566351qtk.258.1584452969030;
 Tue, 17 Mar 2020 06:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584428736.git.baolin.wang7@gmail.com> <7866e519-80ad-8678-6708-7726a53ea4f5@intel.com>
In-Reply-To: <7866e519-80ad-8678-6708-7726a53ea4f5@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 17 Mar 2020 21:49:17 +0800
Message-ID: <CADBw62q7q=wqKGBnLRA+npYLVZVXeMiFwGP-K1TLkG2GPCwLjg@mail.gmail.com>
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

On Tue, Mar 17, 2020 at 9:25 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 17/03/20 12:14 pm, Baolin Wang wrote:
> > This patch set introduces a new request_atomic() interface for the
> > MMC host controller, which is used to submit a request to host in
> > the atomic context, such as in the irq hard handler, to reduce the
> > request latency.
> >
> > Any comments are welcome. Thanks.
> >
> > Note: Adrian pointed out that it is not good if moving the polling of
> > inhibit bits in sdhci_send_command() into the interrupt context, but
> > now I have not found a better way to address Adrian's concern. Moveover
> > this is an unusual abnormal case and the original code has the same
> > problem, so I plan to create another patch set to talk about and fix
> > this issue.
>
> I tend to think the API requires the possibility for host controllers to
> return "busy", so that should be sorted out first.

If request_atomic() can return 'busy', the HSQ need queue a work to
dispatch this request to host again?

I am thinking if I can introduce a new flag to avoid polling the
status before sending commands, cause from the datasheet, I did not
see we should need do this if the command complete and transfer
complete interrupts are processed normally. At least on my platfrom, I
did not see the inhibit bits are set. If we meet this issue, I think
some abormal things are happened, we should give out errors. How do
you think?

> >
> > Changes from v1:
> >  - Re-split the changes to make them more clear suggested by Ulf.
> >  - Factor out the auto CMD23 checking into a separate function.
> >
> > Baolin Wang (3):
> >   mmc: host: Introduce the request_atomic() for the host
> >   mmc: host: sdhci: Implement the request_atomic() API
> >   mmc: host: sdhci-sprd: Implement the request_atomic() API
> >
> >  drivers/mmc/host/mmc_hsq.c    |  5 ++++-
> >  drivers/mmc/host/sdhci-sprd.c | 23 ++++++++++++++++++++---
> >  drivers/mmc/host/sdhci.c      | 27 +++++++++++++++++++--------
> >  drivers/mmc/host/sdhci.h      |  1 +
> >  include/linux/mmc/host.h      |  3 +++
> >  5 files changed, 47 insertions(+), 12 deletions(-)
> >
>


-- 
Baolin Wang
