Return-Path: <SRS0=tDFP=7W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445A6C433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2061D207C3
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Jun 2020 10:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SErILUCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFIKko (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgFIKkn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2020 06:40:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F8DC05BD1E
        for <linux-mmc@vger.kernel.org>; Tue,  9 Jun 2020 03:40:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so10137336pgn.5
        for <linux-mmc@vger.kernel.org>; Tue, 09 Jun 2020 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3UsjebrWE+zrWS8YlEPV6Ibi3biWDPWRYrxveaEEHf0=;
        b=SErILUCcAPmqEI8XAD7STTWqL+k5Up6AWkY1DnFs3rFZonLHbxEQetW6D1d6Sdia1G
         pqumlKH8M4CePTrDDbIDaapRofYJcv2GiRlZdIrWFL6xkKlADS3ddUCQuD0qz4NFJIgd
         DE+gAaPcQ+87Oopen6CtUlzfYVq4aHYFVZuC/e9emcx36yixGTZnaZgbzEXwKo6uBRhw
         lyfJbqnDtXLe56hkE7rD1aDrdGp5sZWHiOiwJMn8IyVQd8Uepr8aXfsrHDPfO2CnsPNd
         GDs5aoz2feNddXjuWPf7OKX6u6oNoEs6ZFEjGQ/8TnUiKRQ5jIcavRh56TD5VBKR4QN8
         WhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3UsjebrWE+zrWS8YlEPV6Ibi3biWDPWRYrxveaEEHf0=;
        b=Ks5uqWdZXU0A/L3hxFYGEZAByGNdrOP/fZ9IsVg8tsU6+CqcTVn4JzaL27NCjh/ceG
         /EqOLD69tj4jIUTk+YmZTAoqE3dBaiLe8Li1TwbQHGvFv0Br24Zc1MxmGyLtPO1UC9j5
         L0047pJdSFDda6NlU0leY5blV1+0Biea/MTQ9SGQJluR+SraOByLECxPz0+WUu01MHoZ
         zUEy7BQyNwaiUi5pWfNKCbxqsjVNBUUzAkBFCjQTCuRGDsI5wjdH7LOIW9cTWnzh/zAF
         xZRPRF3n3a2nZxXePK1s9bo7XLwg1o7M0mx/lJCmV8opaA1Y4/RFDuHUCkwdsMxFRC5M
         b24A==
X-Gm-Message-State: AOAM533DYv8BkPzgsISaBof/hQ1jrFC5L65IlvKq51RKAJb1LfdzCNYH
        qfHTWw3ZFoqyRtgycueputY=
X-Google-Smtp-Source: ABdhPJxeca+nrKAwNANXQ4LwjTNwyqVLGn9wDEiicCKjy5LprqpvTF4y3/x80OZjobt/Pag5gqZOCQ==
X-Received: by 2002:aa7:8f25:: with SMTP id y5mr25098316pfr.82.1591699241635;
        Tue, 09 Jun 2020 03:40:41 -0700 (PDT)
Received: from localhost ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id x17sm2246516pjr.29.2020.06.09.03.40.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Jun 2020 03:40:41 -0700 (PDT)
Date:   Tue, 9 Jun 2020 18:40:32 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        huyue2@yulong.com, zhangwen@yulong.com
Subject: Re: [PATCH] mmc: sdio: Fix 1-bit mode for SD-combo cards during
 suspend
Message-ID: <20200609184032.00001199.zbestahu@gmail.com>
In-Reply-To: <CAPDyKFr+NKoQVLqK9J-gmW9E7pwfZKeJQ8JEdx792jDA1kYKiA@mail.gmail.com>
References: <20200609081431.6376-1-zbestahu@gmail.com>
        <CAPDyKFr+NKoQVLqK9J-gmW9E7pwfZKeJQ8JEdx792jDA1kYKiA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 9 Jun 2020 12:01:42 +0200
Ulf Hansson <ulf.hansson@linaro.org> wrote:

> On Tue, 9 Jun 2020 at 10:14, Yue Hu <zbestahu@gmail.com> wrote:
> >
> > From: Yue Hu <huyue2@yulong.com>
> >
> > Commit 6b5eda369ac3 ("sdio: put active devices into 1-bit mode during
> > suspend") disabled 4-bit mode during system suspend. After this patch,
> > commit 7310ece86ad7 ("mmc: implement SD-combo (IO+mem) support") used
> > new sdio_enable_4bit_bus() instead of sdio_enable_wide() to support
> > SD-combo cards, also for card resume. However, no corresponding support
> > added during suspend. That is not correct. Let's fix it.  
> 
> I believe the change makes sense to me.
> 
> However, the commit 6b5eda369ac3 that you refer to is from v2.6.34,
> which is more than ten years ago. That makes me wonder, are these
> cards really being used?

Current code logic will switch to 1-bit/4-bit mode in suspend/resume.

> 
> Did you test this with a combo card?

No, i have no real environment to test it. I'm just reading the code.
Obviously, sdio_disable_wide() used in suspend is for SDIO cards only.
However, sdio_enable_4bit_mode() used in resume is for SD-combo cards.
We should also add the support in suspend to avoid the potential issue.

Thank you.

> 
> >
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/mmc/core/sdio.c | 23 ++++++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index ebb387a..2d2ae35 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -285,6 +285,27 @@ static int sdio_disable_wide(struct mmc_card *card)
> >         return 0;
> >  }
> >
> > +static int sdio_disable_4bit_bus(struct mmc_card *card)
> > +{
> > +       int err;
> > +
> > +       if (card->type == MMC_TYPE_SDIO)
> > +               goto out;
> > +
> > +       if (!(card->host->caps & MMC_CAP_4_BIT_DATA))
> > +               return 0;
> > +
> > +       if (!(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4))
> > +               return 0;
> > +
> > +       err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_1);
> > +       if (err)
> > +               return err;
> > +
> > +out:
> > +       return sdio_disable_wide(card);
> > +}
> > +
> >
> >  static int sdio_enable_4bit_bus(struct mmc_card *card)
> >  {
> > @@ -960,7 +981,7 @@ static int mmc_sdio_suspend(struct mmc_host *host)
> >         mmc_claim_host(host);
> >
> >         if (mmc_card_keep_power(host) && mmc_card_wake_sdio_irq(host))
> > -               sdio_disable_wide(host->card);
> > +               sdio_disable_4bit_bus(host->card);
> >
> >         if (!mmc_card_keep_power(host)) {
> >                 mmc_power_off(host);
> > --
> > 1.9.1
> >  
> 
> Kind regards
> Uffe

