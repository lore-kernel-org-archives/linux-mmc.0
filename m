Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6C4C4CECC
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 19:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3605206B8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 19:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="otJ/1Xsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD0Tow (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgD0Tow (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 15:44:52 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9EFC0610D5;
        Mon, 27 Apr 2020 12:44:51 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id s10so14454413edy.9;
        Mon, 27 Apr 2020 12:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VQcsbuP3pB8CDC+cItJJV21Dnh5PuIRR4nPKttHGjzE=;
        b=otJ/1XsxOtfHp14bHd8Kf93q9ptKtRm3hglsJawWMzxNHKYCD7z6ECVnscbS/vBVha
         Zs0kLO2wdbw68nXZrww0yrjzXzy++SVTTkfKjR+ovO1otx1+cGbTyeruo2DDg0bJrb2K
         /1lk1vT5EhWAFPpVmqCweZ7vf5ZgmEuzHwCe7focxGC0MWEXvhLb+q5NBFzpRnWcTNWh
         XEvqoHCsoVjLAMeFAwBsLrDGX41nzUvanE6tM370s5f4+IZl5CFfYCvEdjIv44JBjrK1
         q0YpwfJ50+lUfdzfPcXiUwiryMAQY8+BXLGb54Y/dLv/7ruwUlDi36CBtdHTZYZrvUf7
         u0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VQcsbuP3pB8CDC+cItJJV21Dnh5PuIRR4nPKttHGjzE=;
        b=GxksCuHzilDeMek4I5O0xxjEhBNgPQi1KiavkGqfh30BwqyQ7EetqwcABqvYC2jXkj
         A63r7AI3HYtYgjnAXXNWTdyBQEGscgc1XackiFdATymcliMpP2M8bkXW5I7NszcqeGZd
         ocs/Qhyr146aguf8zB+6caofWmD0VPDGin6Y+FaLqm01PpdwlR+NHbcGJje4krl+oDmr
         CJCBJCK/Q1JPtxHEGUUSxNo6unwAh0HCGubQZ/R2NDgZ5rttOgaA9zGjNjjy/P2AvDaN
         tOC6EFTozP//XezFaohkQD8zkFXk1yZDsMC4sJKIjGuDm34O35MjROEPQ59JKaHPsoLe
         p4DQ==
X-Gm-Message-State: AGi0PubIsjWHjadwQ9FhSKxA4lbkx9DxJIKE5PkJKLHordmCc6+2lWPb
        ATr/4D0WGCt7dYSuz9vnNu1AAMjCNHbHmVTz66w=
X-Google-Smtp-Source: APiQypKdvwLdxCF/E1pxaH6di+8W+pTb7+5wMbfJFWXAgXSq3W+jSu6jwARdIVsNAY136N7lf7NMNpJEjCTrQ7cHC7k=
X-Received: by 2002:a50:f61c:: with SMTP id c28mr18663659edn.365.1588016690108;
 Mon, 27 Apr 2020 12:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
 <20200328003249.1248978-4-martin.blumenstingl@googlemail.com> <CAPDyKFqsG4kyABmxn__gAbe4fBmuZ=4mdFpRaCL0ih7QZEhwzQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqsG4kyABmxn__gAbe4fBmuZ=4mdFpRaCL0ih7QZEhwzQ@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Apr 2020 21:44:39 +0200
Message-ID: <CAFBinCCr2yk5WOG_Y7E14ekpkOsyurkCfYBO0DOWg1MSjvxaTw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

thank you for looking into this!

On Mon, Apr 27, 2020 at 9:20 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
[...]
> > +static void meson_mx_sdhc_wait_cmd_ready(struct mmc_host *mmc)
> > +{
> > +       struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> > +       u32 stat, esta;
> > +       int ret;
> > +
> > +       ret = regmap_read_poll_timeout(host->regmap, MESON_SDHC_STAT, stat,
> > +                                      !(stat & MESON_SDHC_STAT_CMD_BUSY), 1,
> > +                                      100000);
>
> Please use defines for timeout values.
I'll take care of this here and all other places which you have found

[...]
> > +       if (cmd->data)
> > +               host->platform->set_pdma(mmc);
> > +
> > +       if (host->platform->wait_before_send)
> > +               host->platform->wait_before_send(mmc);
> > +
> > +       regmap_write(host->regmap, MESON_SDHC_SEND, send);
>
> Isn't there a configurable timeout to set for the command?
>
> I mean the driver sets mmc->max_busy_timeout to 30s in ->probe(), but
> can the timeout be configured to a lower value?
there's MESON_SDHC_CTRL_RX_TIMEOUT and MESON_SDHC_CTRL_RX_PERIOD
here's what the datasheet has to say about them:
- rx_timeout(cmd or wcrc Receiving Timeout, default 64)
- rc_period(Period between response/cmd and default next cmd,default
8) - I'm not even sure if this is related somehow

if you have a specific test-case for me to provoke these timeouts I
can try playing around with these values
otherwise we have to ask Jianxin and see whether he can get some
information about this from the internal team at Amlogic

[...]
> > +       mmc->caps |= MMC_CAP_ERASE | MMC_CAP_HW_RESET;
>
> Should you also set MMC_CAP_WAIT_WHILE_BUSY? It sounded like the
> driver supported this.
I can try setting it.
From our previous discussion (on the meson-mx-sdio driver) I have
learned that eMMC will be a good test-case for it ;-)

[...]
> FYI: I left out all comments related to the clock provider
> initialization. I think it makes better sense to review that code,
> after you have converted to use the devm_clk_hw_register() and avoid
> registering a separate driver for it.
yes, that makes sense
I expect the code to be easier since it'll be one big driver with the
next version (so no more platform device allocation, etc.)

> Other than the minor comments, this looks good to me.
great - it would be great if this could finally make it into v5.8


Martin
