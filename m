Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C453C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 14 Jan 2022 03:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238934AbiANDBV (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Jan 2022 22:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbiANDBV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Jan 2022 22:01:21 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A52EC061574
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2022 19:01:21 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id g14so20497604ybs.8
        for <linux-mmc@vger.kernel.org>; Thu, 13 Jan 2022 19:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oH0gUBb3QDrNsal3W2+Ys6ZDI/In6DtlTK3KPAg2Wlk=;
        b=Y856G4E9FsP6ZxEU8laekcuDjxH+3nlxv2a4l0rtfK9AQlilAb89c3vXpk/NryMFq1
         2vDTM9EwenflHhHA8Cskb0NhmKOiWgDBf2Dr7cZ/x/ixFU0XzlG1YHYP5igsh+sjBShw
         kIbQyv/64wZrlDODGvSr6oq/aszho6+BZew/YB6BuinHshSI1+e04de7/C2saCRB/02z
         Gc/KnzeKw6oPBDr8zNAqkU6QqrKy5vsL/FSgTjL9W/rdezKVf2W/4mXQ7k/qQQnf35Gd
         2LNgsF6YMYvzsphW9Yn5JZ0vypeuEDNKhY7BlHpheM5XWVAhZan0jW/IhkPDeY4kLjAc
         ouxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oH0gUBb3QDrNsal3W2+Ys6ZDI/In6DtlTK3KPAg2Wlk=;
        b=v9PCSymD6asIj5zOUQJxnHgx7LSB0PEUNSM+egGVBMgPrL81hm4eL/W9+/K38AOPoY
         1mzK4lrEhiJ4T5fZly7vC46rfc9GQ8Um+Kp0iu9EuOCjlAVeecJ+BQ39my5fBu2sto3O
         4b0uIEYlT3w+gszdrd4vkDyPXH3pKYoLpKyUIrxmf42kc+kJqs/raZK9nEvJBwyBUbar
         AhTdEUmPxzc9ZAWkW2R5EfNRIcZKuH5M4SIKniTqlN7xpJLEiwuYFLzCyvv5bgqSsM0K
         hFxhvGBs04Qn5ZPIPB02LGoTDgqqf7K8X5I+Zz0P/KnIefeRpCa5X+TIKY+Xhg0Neos3
         uu7Q==
X-Gm-Message-State: AOAM532jzebXGyDrjunlcDk3bUX1FyG0dfi6PIz3sBaC+Q5izYjFXdDk
        p6hAuXp0mDw3PmemayFY38y0Way2jbdX8YnnMpWwvZP79/g=
X-Google-Smtp-Source: ABdhPJxgRFpe022hgP0TBmI0+Jq6JCN70LVDObPZAk3yiBYFULgatIvE4XRsKekFuYQiW0VO/MetjlXzEpydKuQ4YVg=
X-Received: by 2002:a25:cc87:: with SMTP id l129mr11129324ybf.144.1642129280352;
 Thu, 13 Jan 2022 19:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
 <20211203105103.11306-6-jasonlai.genesyslogic@gmail.com> <CAPDyKFp2mv5Z+0e8ckKnhyE-XvGYcuda-z=vJoz0crnTVa9ZVw@mail.gmail.com>
 <CAG0XXUFXTHh-tbLG1WQ8-AtNUtTykPzj4sFUK0PT9aigy-S0Lw@mail.gmail.com>
In-Reply-To: <CAG0XXUFXTHh-tbLG1WQ8-AtNUtTykPzj4sFUK0PT9aigy-S0Lw@mail.gmail.com>
From:   Lai Jason <jasonlai.genesyslogic@gmail.com>
Date:   Fri, 14 Jan 2022 11:01:09 +0800
Message-ID: <CAG0XXUEEqou0OkavO-_GeaCmjYNTpzWr=YDBh91V3QKe0JvLSw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: add UHS-II related definitions in headers
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw,
        =?UTF-8?B?6I6K5pm66YeP?= <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 6, 2022 at 4:37 PM Lai Jason
<jasonlai.genesyslogic@gmail.com> wrote:
>
> On Tue, Dec 14, 2021 at 9:37 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 3 Dec 2021 at 11:51, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
> > >
> > > From: Jason Lai <jason.lai@genesyslogic.com.tw>
> > >
> > > All LINK layer messages, registers and SD-TRAN command packet described in
> > > 'Part 1 UHS-II Addendum Ver 1.01' are defined in include/linux/mmc/sd_uhs2.h
> > >
> > > drivers/mmc/core/sd_uhs2.h contains exported function prototype.
> > >
> > > Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/core/sd_uhs2.h  |  18 ++++
> > >  include/linux/mmc/card.h    |  30 +++++-
> > >  include/linux/mmc/core.h    |   4 +-
> > >  include/linux/mmc/host.h    |  27 ++++-
> > >  include/linux/mmc/sd_uhs2.h | 196 ++++++++++++++++++++++++++++++++++++
> > >  5 files changed, 268 insertions(+), 7 deletions(-)
> > >  create mode 100644 drivers/mmc/core/sd_uhs2.h
> > >  create mode 100644 include/linux/mmc/sd_uhs2.h
> > >

[...]

> > > diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
> > > new file mode 100644
> > > index 000000000..5d12fb9d0
> > > --- /dev/null
> > > +++ b/include/linux/mmc/sd_uhs2.h
> > > @@ -0,0 +1,196 @@

[...]

> > > +enum uhs2_act {
> > > +        SET_CONFIG,
> > > +        ENABLE_INT,
> > > +        DISABLE_INT,
> > > +        SET_SPEED_B,
> > > +        CHECK_DORMANT,
> > > +        UHS2_SW_RESET,
> > > +};
> >
> > Perhaps uhs2_action is more clear?

In order to integrate all UHS2 host callback functions into a single function:
uhs2_host_operation(host, uhs2_action). I add 5 actions to
uhs2_action{}:
        enum uhs2_action {
                SET_CONFIG,
                ENABLE_INT,
                DISABLE_INT,
                SET_SPEED_B,
                CHECK_DORMANT,
                SW_RESET,
                SET_REGISTER,    // callback function: uhs2_set_reg(host, act)
                DETECT_INIT,     // callback function: uhs2_detect_init(host)
                DISABLE_CLK,     // callback function: uhs2_disable_clk(host)
                ENABLE_CLK,      // callback function: uhs2_enable_clk(host)
                POST_ATTACH_SD   // callback function: uhs2_post_attach_sd(host)
        };
Do you prefer to add prefix "UHS2_" to each action in uhs2_action?

 kind regards,
 Jason Lai
>

[...]

> >
> > Kind regards
> > Uffe
