Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75061C433EF
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Sep 2021 13:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E1A6054F
	for <linux-mmc@archiver.kernel.org>; Sun,  5 Sep 2021 13:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhIENIk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 5 Sep 2021 09:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbhIENIk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Sep 2021 09:08:40 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D303CC061575
        for <linux-mmc@vger.kernel.org>; Sun,  5 Sep 2021 06:07:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id w4so6446475ljh.13
        for <linux-mmc@vger.kernel.org>; Sun, 05 Sep 2021 06:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmzPpA+dcUgjZbxr1DCt/GuWMKRkFPIG7aUqTWmahn4=;
        b=hu6t/NPo+ndw6lu/D1S0qScqVt+TFIVdciS9z92uMh4Sd+JNV+RR/FXTXVditvrjXo
         7YKgCBYPV4U72+0hNVLkIIiGCMiQKkdQmDj91/1wPR0ysy3AluGpLolxwZ2T8rKsOygV
         U/ICerfrzU17COY9WGGUMwK2qso8D/gNXo+ClPG5hZ2e7d3J2rNWQJ0/HsM33Rb8Hol2
         DZ7BMs49GLb1hrFrLZRko3jGEwQh1h2OgP0bL+igQHykpSz1rdr9YkmF3uN9EieCsW4r
         zo7peyCCpAbx1Lhbp6eoEg8vSfqpT8ieOx6ywpTmmEUgKqO69FhRR3HOaDwBsVMOeV5K
         GVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmzPpA+dcUgjZbxr1DCt/GuWMKRkFPIG7aUqTWmahn4=;
        b=tcnlhaAaDZH5qu7FMQV8dbahs7vyQFE+yo2XQrurDhDThVPBFZjxq/2dbm9ExHWAwa
         TJ1g29UA0JpSVYqmCA+SQ5PbfC27YnDUy7EPtn0dvoSsQoLQ4jOE3FJCBGJpA15kFABW
         etIw12n+g4Coz4gWG0rENw5CMBRaMAdSzzALzUvUAuEd2cLfl7NwRcfFm/EE2E6TwRe6
         Vb1JGXOP7VHNUYMMARdpQn6Ws0GH+oiN2iooebx6Rz5fr0yXH0kDl151cNS3UtDvqlCD
         rIiRegX3MuzbrDvgFOUot7h+ms2DY8Ce6ZKkuk1PKEN51J/iyla2lqTALqaMmAVyH+BA
         y7IA==
X-Gm-Message-State: AOAM530hRU3CfEjGfL/3OqsP66RnHm1qEFD33EeIVTgeUOInoXL4Rb64
        rNVXYJamH546v5WRXYXmN3lbHyEP2KUHIQdGxdU=
X-Google-Smtp-Source: ABdhPJyd1NjeaO8/hR94rUQYh/Ok0eOzyvASBMNvgaN3v8pqiVt34WooRsQnseUNz2CQTNmsQiozvZ/Vp5OXOX6RMLM=
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr6577481lji.402.1630847255093;
 Sun, 05 Sep 2021 06:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5AAvZic-NFbYYSVfOxY-27QukXMX68f9eDmhbqAkBRKRw@mail.gmail.com>
 <20210818154358.GS4126399@paulmck-ThinkPad-P17-Gen-1> <CAOMZO5A7drx9yXWXKTh4VfV4QHNGCPbH_vxeb=NGDghAm98CXA@mail.gmail.com>
 <CAOMZO5BY7JeFQJkU--KGRfNLTUnUVjnfar+37SvReXyBt9QJfA@mail.gmail.com>
 <20210818175604.GX4126399@paulmck-ThinkPad-P17-Gen-1> <87czpqbq98.ffs@tglx>
 <877dfyaxpx.ffs@tglx> <CAOMZO5BnPEnF-HNM7vCzeUrRW7BsQ-hhm4fcVmO_QieKf6oJsw@mail.gmail.com>
 <87y28b9nyn.ffs@tglx>
In-Reply-To: <87y28b9nyn.ffs@tglx>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 5 Sep 2021 10:07:24 -0300
Message-ID: <CAOMZO5D7wejn3CvGEvFyRLeOqpdxBOD+-9dTV3xVoPQgWpqUzA@mail.gmail.com>
Subject: Re: NOHZ tick-stop error with ath10k SDIO
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Vasut <marex@denx.de>, qais.yousef@arm.com,
        Frederic Weisbecker <frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Thomas,

On Sun, Sep 5, 2021 at 10:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:

> Yes. This is correct. See above.

Thanks for your help. Appreciated.
