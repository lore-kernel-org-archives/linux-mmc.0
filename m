Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C664C4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 13:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CE66113D
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 13:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhHSNZk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbhHSNZk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 09:25:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B7C061575
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 06:25:03 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n6so11519869ljp.9
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 06:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qsef7nu2zlQE6kcZLASBKkTaAvwF0nwU8Y3JF2FJlO0=;
        b=U8Pt++pHtYK3qAuvgqBGVLnR2Zw8VnHFHMY1m4/+XLGUqaU5LcaxMghxDUL8bCdyQ1
         VZggZEjBIkBAdwiGiPwvRHC79hY65inKfFyWu+6EBJiDCF/rQa5Q0HlKyyCqpV6AoSNz
         HW7eP5qMl7J9tJfecNm6tV4aCvP2RX4Hp8/4vd92zi+e+0TuRag2nXNjjssefG/aZHZh
         yIj2MW+nkA+Ue8Spk1vFR4ESem3BYadkym2vFV0tPH8Jorolf7XAVa+dTpTOWOJFYRea
         vAW7GLNQj8gg/F2ZY3bYt5QfLw/p466oX/oPL7Y1ZqqEZ1O0kbQ/g7mlvCvDRMTS5sox
         RHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qsef7nu2zlQE6kcZLASBKkTaAvwF0nwU8Y3JF2FJlO0=;
        b=BS1FgOmjvweraaQlQpSqrFivwjT25KPbJOFh7/OOEFrpr9EN0HZIkexxT7C1P19em/
         JK/cdmJ8c+Mlnyi9aKip7jkI+vP74ck7YEpEHsqhSgzOZw/5xlyOqve9Bg/5xTLRPKgS
         MagmQbcP4znFzEeLQvzDsH1GYkX7um7wNsM138rGGw46O+pYyVpF5oOQYp1v/aWNgP2v
         tznJGM/sCwlYZ+tVvOiXxEAVJiJxRh3vjEB/s9Rjo6KOH+5x+NKrBQxAtAxT//htRsKc
         5xxcmyVbZ4FwJ99UXpL0XoWo1AkuQgP7ib2PQD6PqT3eHw037+B/+0iUKx3ZhGCHJxrB
         tgZQ==
X-Gm-Message-State: AOAM53007ptbyK0L/SbUQemk6biKuRdhO1fvujta7aJI+dwzbXcxbS/D
        VQo81ROcZHLDVLf9h3SulXb9PQtTQiFgVQvGHPo=
X-Google-Smtp-Source: ABdhPJz4OUPaOk2mOpJpgQ4f4/QnXdIXILZ/S9GUpHg0wY4tFfbM65VolOt0U/tztCWx0kOpjRZfJzAW+ZWPzL9y6dk=
X-Received: by 2002:a2e:8e8f:: with SMTP id z15mr5884085ljk.121.1629379502237;
 Thu, 19 Aug 2021 06:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1> <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com> <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 19 Aug 2021 10:24:51 -0300
Message-ID: <CAOMZO5Ag1uUx4BqS=+ZQwULSrkE=sNMyWgsWvPQ4xY16ac=zsQ@mail.gmail.com>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Paul,

On Wed, Aug 18, 2021 at 2:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> And it turns out that I am also seeing it in v5.14-rc2, just a lot less
> frequently than earlier.  I have seen three instances of handler #02
> (NET_TX_SOFTIRQ?) over the past month or so while you are seeing handler
> #08 (BLOCK_SOFTIRQ?), in case that makes a difference.
>
> Adding Frederic and Thomas on CC, though I believe Frederic is off
> the grid at the moment.

In my case, these errors are very easy to reproduce so if you need me
to collect any debug
info, just let me know.

Thanks!
