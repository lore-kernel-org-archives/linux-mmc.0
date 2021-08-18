Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A055C4320E
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 17:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A5B6102A
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 17:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhHRRDK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 13:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhHRRDI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 13:03:08 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6AC061292
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 10:02:30 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id k5so6063733lfu.4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 10:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2vHOG5+qPJN8jmWLiJvDNQKkDjgqpU1H4dy3yeyIjso=;
        b=Au8n84a7JWvuJ14AHkyWo/qNfD59revNzR2qD63XW35WEP23EtB498lh6OxNd16Z9b
         eOOOnNkZJxrwS+fEe9rkwSt23kqnEQiD6xQkPNbbMQACK/9OXDyuJvj7HfdgtxExn/D0
         ZITZmkSJru5ziMeIFuPVBcBt3pomvA4KfGuuTE3UbGOsbekOq1magbc3mgtUhUJSlyQJ
         pltChhGjfm8sgG404j8K4MI2ivd/JD9MgujF5CfifN4wmLw3c86Y+W7BiM1GU2JD+hbu
         EOjt6tEIAZ4M6cNLDk6LZ/oP/Gb79KZOwlt/bmXPivgHrP49JxyifWXizQpnVc/BAMui
         /E3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2vHOG5+qPJN8jmWLiJvDNQKkDjgqpU1H4dy3yeyIjso=;
        b=UcRcDNrrok8+mMeApAwaR2nAZjIMhVxCfGAUFIL2roKI90k0nuGIW4UZ8M29VsSNdd
         J097uB/31ZddSSSJOnkPYCX8LLpA0mpWKQu2ekGIHyKKeQ/EufQe0ux4A/u4YMTqVh7M
         5TK+7+I/uiaw1NTGQLzYTNR5EsvY2e7QbKyeutJFDtvbl4Eszz15KiBXZRexMKOlWt1E
         bEHA9Jdb6RU8M+vbvlD1/vNPTpqDodD3QqQemd6YiBQuS07OK9QnAvwwPks+JAphBMjP
         7/8XbTNzMObVljLf53+mO9v088pjOw/pdM3mxTqbHtwAuEz/hUwqbFzMdEiqGu552UM6
         hzNg==
X-Gm-Message-State: AOAM530aNQ6dT7fHc3C7fuDNNIJjDkZMm27y/b3DtzxIajrnPvsPPpx4
        R4doCp7Kb/rp67bgg1rTFRomEmYNfWMhkuIibx0=
X-Google-Smtp-Source: ABdhPJwMMcgiCQIM7qBkrZFh0rLz5MlcL1MzYBiSx/0c6BTFu8uu916TrnDAm+3gTNz24ay/ysQ1Kw4UNFbTkbUt69w=
X-Received: by 2002:a19:701a:: with SMTP id h26mr6917592lfc.443.1629306149104;
 Wed, 18 Aug 2021 10:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1> <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
In-Reply-To: <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 14:02:17 -0300
Message-ID: <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Paul,

On Wed, Aug 18, 2021 at 1:29 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Paul,
>
> On Wed, Aug 18, 2021 at 12:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> > I believe that you need this commit (and possibly some prerequsites):
> >
> > 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
> >
> > Adding Qais on CC for his thoughts.
>
> Thanks for the suggestion, but I am running 5.13.11, which already
> contains this commit.
>
> Any extra logs I should capture to help us understand the problem?

In case it helps, I followed your suggestion from:
https://lkml.org/lkml/2020/12/10/676

With the debug patch and suggested command line, I get the following log:
https://pastebin.com/raw/X96zKw7i

Thanks
