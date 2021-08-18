Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B55C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9627C610A3
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 16:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbhHRQa3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhHRQaW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 12:30:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53769C06179A
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 09:29:47 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id n6so6115089ljp.9
        for <linux-mmc@vger.kernel.org>; Wed, 18 Aug 2021 09:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qgqSa92OM+F5OADrmwBCMMd9VmhpaXpJwL3HpzM4S6E=;
        b=MOed0Y72enm2pahFEHaeZQdzaAwi9bPKNlbd08GQmNE/Jcl2NRGCQAJJCpfnUE9WZF
         82j2Vlb/q6cPSh64eZeQQG+/y+TDwA65trtwadRcs+cl2ezo6gKP+DcyV+77M4pyEACm
         66r+7YNnoNqia3CWnfS0tHFhbZYlYq+k3S+6QBMnbxo/5QctqyK3Ha+ka3hufIC2ZWc2
         Y/EnpAqcRZh7Hve5DRU58dS+uQmEwnoU/nI99XD85w8pZ98mOf3E66+/l3HbRDpH3ig1
         zbgN6T6tJ/FIQCLawvZ2aVU2HNT8BCoIKcBMVK28V4xNspqdqX5dhx8e61O1oWMjZ80S
         kcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qgqSa92OM+F5OADrmwBCMMd9VmhpaXpJwL3HpzM4S6E=;
        b=EslQTHwixdULzvgEh+ytkJC+zp3mHukAQpyMaA+vD2YRD+xyoatauNOWuFe0ToNQp1
         VaC3Ef6i2D4h0Bp+nHpLBg3x1tcKWcc38t89IAAB6fJFvhKxQwnx1SruOwhKnhDAIOlH
         1RFfWyBBQB0pEebMp4NbvwKzy0AHN3gd41FNPvT6SjudYIOAj1F8XpYstHvMBT0wyZ9a
         p5KB+QM5mEirDwkqQzS2h9V5krOEDMiTATgIA6CJv4Iil4CyV77EQrTZldT6aHfcB4Mu
         gnKjnO/OkXUAcqeQlFnL+NLi4TR5k/noYT1ajBijQOcmmexjROK0jKK6rRaHFBqtnqmK
         3rvg==
X-Gm-Message-State: AOAM532DfOX9tsNF102meulysmKqpP8xecBMa6qBC436RJxKJDhZku96
        dS1A+vM1BN+wmg3M51qdqxVYCIJqaGPeeBPGvzM=
X-Google-Smtp-Source: ABdhPJx1g+saCOWCOfM5NYU4DJ7Dt4ExVh7bSSUiW4HstWXEbNYWkZEW0t+h6D338zqAa32vUsyF9EmlRmqauZ478pQ=
X-Received: by 2002:a2e:a370:: with SMTP id i16mr8765849ljn.444.1629304185737;
 Wed, 18 Aug 2021 09:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 18 Aug 2021 13:29:34 -0300
Message-ID: <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
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

On Wed, Aug 18, 2021 at 12:43 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> I believe that you need this commit (and possibly some prerequsites):
>
> 47c218dcae65 ("tick/sched: Prevent false positive softirq pending warnings on RT")
>
> Adding Qais on CC for his thoughts.

Thanks for the suggestion, but I am running 5.13.11, which already
contains this commit.

Any extra logs I should capture to help us understand the problem?

Thanks
