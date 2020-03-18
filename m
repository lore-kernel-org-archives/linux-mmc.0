Return-Path: <SRS0=6IoW=5D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DCC10DCE
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 06:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3624F20724
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Mar 2020 06:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orY+w5pW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbgCRGxU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:53:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37184 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgCRGxU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Mar 2020 02:53:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id z25so32142196qkj.4;
        Tue, 17 Mar 2020 23:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JIUU945tjKWn7G+uWGg7eqG/veZ5KU9jtb/2ZLYG2SI=;
        b=orY+w5pWV/Z1rru//L4oMZleR46ybigSk519t/NT8ODjrzqN0iKGY3fsIKy0xLTzl5
         IdNL50paLXTeHOk1UkqSXfvvdBCttWbGLY1+X7t8IzKo0HiALm8kp44W1BnqEnyDq542
         8v5+DrK1CFN0pw+hyMwxOq+r34zRq9vYC93MaKCg0WbZYMgpPJIIMF+C5ceKrhzmFfk+
         JrLVTwwxaiaMGcz6A2a3hK0fS5Ll73JDzeAK6F22skgeKcrrBQj5jAfpfv0xM1vQzKe7
         /F7F8W4EY64HQtj8stzqxZjWxrfXm8F1VpP/7cwq6ksWlcsiwGEHMNX8nvBrCwQeIjsF
         vDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JIUU945tjKWn7G+uWGg7eqG/veZ5KU9jtb/2ZLYG2SI=;
        b=tT8ztU3VKy57TaHTQmNvI594aBtzwAov+nGacP+UvLheO9+iRaYZ2xka92QN/XQOyn
         WleAOG54Y3ekzzOPS+v8MsH+yl3CeenxkTeaWN4XIiX8CibmgoewRw4C3DPJWfk4sB6i
         8qwCU4Kc4wgDz5o3QADyP9j7LiKz7Mw6JyJbvUDU7rnV25Qj51rAjLkCYoYjKE6agDAE
         mcMc2yXVK+G1VpW7INKySJbW5YEhy/YwK/U4T0Y8wTOBDYx8594uPNnl861TY5KTOIvb
         phQ/quSmm7CWuLPMx6cgC433wU2wZiyQN3A/heZB/u+ZTLNuuiXwfImGFIQmuAOjlMbf
         SpOg==
X-Gm-Message-State: ANhLgQ0NVtIjtdOC434/aCZq26qjTEcTxEYn97cW1533PViGTQ/zzmis
        H8nN9rSmsCCM88GUAOD54oQpVlEqi9/1ZXat3Eg=
X-Google-Smtp-Source: ADFU+vtGP9Ty7kCO4ONv73Nr7zNugirXg12VP1u3w7C+Ufpy9fPM+R053oz02WmqvcBe3SLlJ4igFy4Zf9q7wIDZHqE=
X-Received: by 2002:a25:dc07:: with SMTP id y7mr3949038ybe.48.1584514399393;
 Tue, 17 Mar 2020 23:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1578560282.git.benchuanggli@gmail.com> <9f861920380df9d7a6d52c905fc47643eb25f33f.1578560282.git.benchuanggli@gmail.com>
 <add27a04-e018-d050-4d42-4fb5c532df8c@intel.com>
In-Reply-To: <add27a04-e018-d050-4d42-4fb5c532df8c@intel.com>
From:   Ben Chuang <benchuanggli@gmail.com>
Date:   Wed, 18 Mar 2020 14:53:08 +0800
Message-ID: <CACT4zj-M-BJKSwDNA7dRa88N8A4PBoX0GnMZiSMKum4GGiTiFA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/6] mmc: host: Add UHS-II support in host layer
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        greg.tu@genesyslogic.com.tw,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Mar 17, 2020 at 4:18 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 9/01/20 11:14 am, Ben Chuang wrote:
> > From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> >
> > Add UHS-II support in host layer
>
> Split host layer changes from sdhci changes.
>
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
>
> Drop "Reported-by: kbuild test robot <lkp@intel.com>"
>
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/Makefile                  |   1 +
> >  drivers/mmc/host/{sdhci.c => sdhci-core.c} | 276 ++++++--
> >  drivers/mmc/host/sdhci-milbeaut.c          |   4 +-
> >  drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
> >  drivers/mmc/host/sdhci-of-at91.c           |   4 +-
> >  drivers/mmc/host/sdhci-omap.c              |   2 +-
> >  drivers/mmc/host/sdhci-pci-core.c          |   4 +-
> >  drivers/mmc/host/sdhci-pxav3.c             |   4 +-
> >  drivers/mmc/host/sdhci-uhs2.c              | 751 +++++++++++++++++++++
> >  drivers/mmc/host/sdhci-uhs2.h              |  34 +
> >  drivers/mmc/host/sdhci-xenon.c             |   4 +-
> >  drivers/mmc/host/sdhci.h                   | 284 +++++++-
> >  drivers/mmc/host/sdhci_am654.c             |   4 +-
> >  include/linux/mmc/uhs2.h                   | 270 ++++++++
> >  14 files changed, 1583 insertions(+), 63 deletions(-)
> >  rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.c
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >  create mode 100644 include/linux/mmc/uhs2.h
>
> Please make sdhci-uhs2 a module and do not rename sdhci.c.
>
> References in sdhci.c to sdhci-uhs2.c will need to be enclosed by
> #if IS_REACHABLE(CONFIG_SDHCI_UHS2)
>
> Move all UHS-II definitions into sdhci-uhs2.h.  Things that are for V4 but
> not necessarily UHS-II can be in sdhci.h
>
> Make the set_power parameter change into a separate patch
>
> Fix all spelling mistakes
>
> Make comment style correct.
>
> Review all checkpatch warnings and checks (i.e. --strict option)
>
> If possible provide a link to a tree that contains the patches.
>
> Re-base on Ulf's next branch
>
> The patch set could use an overview of how UHS-II is different from regular SD.
>
> In other patches there are a bunch of memory allocations on the I/O path.
> That is a problem.  Memory needed should be allocated in advance.

Thanks for your comments and guidance.
There seems to be a lot of work to do. I will do my best to meet these.
