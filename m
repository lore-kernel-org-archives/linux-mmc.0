Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC040C6FD19
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Mar 2023 12:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCPMAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Mar 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjCPMAm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2023 08:00:42 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771D11BAC7
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2023 05:00:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id fd25so973389pfb.1
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2023 05:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678968028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rSfQj6qf5hqbbH6Yb4RUUM/hOgsbRlJUqWzSs+3HciA=;
        b=ppaBvSf/JMf+Z5eP3oeLfjKnDqPp+DUlDSEkXau1n5yr51mR+tdtfQl9T5S8ZU1Xle
         kHxYR/UIbuUpD8sZhCCay8PX5MWvTcP1q/IF1pPluAOptBBNtEi7SN84wtPynC67gXLJ
         oQXeOjUyCvu3rUcyCfcfyAsG0vZQfZfTMsUOez6ox5Lj5wOWZ7/P51jL8qg3dGQ6vHv1
         rsNcnWzJnizSTSZIKNIOtfTFXQj08Smu0aGEbTVVUGNO6T10+tgcbFoHLEAj7tOjEmCq
         vEytrfNMYr0v2rx3HmKSsfKqdgBSTdVD3dwLjDRAnnGOTLl/7t41FjH50ppTmSecUavt
         w5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678968028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rSfQj6qf5hqbbH6Yb4RUUM/hOgsbRlJUqWzSs+3HciA=;
        b=0VyAzVuEFm8hLs2mks9Hg8W7P/ZiM5AcfEg9JIYrSDasxUtkGATVf/qV8malPfZ5wx
         F1JaheIV6Pa1IeiJbeqTfR2xKjUSxm1OiQrizmJlrBmenBOrtu64Z143PpV8frf+r4Av
         FfdQSZqZvViYKQenV+fcvu3QKH0ZCGO/UIl9JtxntwLHhsSpfhuE9QGTTxyelm09sq34
         jj1MiVMlkZ0tafCLkbQ7T8Sd4pE405PtW+fZmSHC69qfvpUduLJ/YiL1mhvcJunH/ol4
         wHnFONUSsUJgyNK8/PS93k8e/SwneDmNmyqB0HK5h8iTEXqo2i+94+Mpn5h5cBJUhYMj
         eL0Q==
X-Gm-Message-State: AO0yUKW/iyt8g6HRKfgAkUZgZUdrHxbGKM9nVdU8bw9dDuxpL1+W0bd1
        OxP0B3j4eYfPmzwHNjciOVcPO4j+9IQWHpZUgRjbLg==
X-Google-Smtp-Source: AK7set9aAHWHhqsF8oIo2aM2SwH0P3/Rrctj8ihSNGbBLFeGDpf00ov6GVeTMhDk9tyc15DJR6TeTsmwsczapFdmxng=
X-Received: by 2002:a65:5208:0:b0:50b:188d:25bb with SMTP id
 o8-20020a655208000000b0050b188d25bbmr778758pgp.5.1678968027838; Thu, 16 Mar
 2023 05:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr> <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
 <b6971cd6-80f2-522a-64fb-82b126500010@free.fr> <1jcz5axc8j.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jcz5axc8j.fsf@starbuckisacylon.baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 16 Mar 2023 12:59:51 +0100
Message-ID: <CAPDyKFqYK2bEbkZ7A=t-VYwmgSYJUGxm2Ew5-7CFeO741fB-_w@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Mar 2023 at 16:31, Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Wed 15 Mar 2023 at 11:20, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> > On 14/03/2023 20:45, Heiner Kallweit wrote:
> >
> >> On 14.03.2023 18:24, Marc Gonzalez wrote:
> >>
> >>> With the default power-up delay, on small kernels, the host probes
> >>> too soon, and mmc_send_io_op_cond() times out.
> >>
> >> Looking at mmc_power_up() and how power_delay_ms is used
> >> I wonder what you mean with "host probes too soon".
> >
> > Hello Heiner,
> >
> > Thanks for your interest in my patch! :)
> >
> > I should have added a link to the thread that led to the patch.
> > https://patchwork.kernel.org/project/linux-wireless/patch/c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr/
> > Start at "I have run into another issue."
> >
> > Basically, I have an S905X2-based board.
> > I built a small kernel for it (with only a few drivers), that boots really fast.
> >
> > mmc2 (SDIO controller hooked to WiFi chip) would not probe at all,
> > unless I added lots of printks.
> > Basically, calling mmc_send_io_op_cond() too soon after the controller
> > has been reset leads to the CMD5 request timing out.
> >
> >
>
> I tend to agree with Heiner here.
> This patch is backing a contraint only reported on your design in the
> driver of every AML SoC supported, for every MMC controller.
>
> I think you should look first in your vmmc and vqmmc regulators and
> their setup times.
>
> "fixed-regulator" have properties which might be interesting to you,
> like
>  * startup-delay-us
>  * off-on-delay-us

If the problem is regulator specific, this would be the correct thing to do.

Although, if the problem is pwrseq specific, like that we need a delay
after enabling the clock and asserting the GPIO enable pin for the
WiFi chip, then we have the "post-power-on-delay-ms" of the pwrseq
node to play with instead.

>
> >> Are you sure that the additional delay is needed for the Amlogic MMC
> >> block IP in general? Or could it be that your issue is caused by
> >> a specific regulator and you need to add a delay there?
> >
> > The eternal question...
> >
> > I have only one type of board. (Actually, I have a reference design
> > that is slightly different, so I should test on that one as well.)
> >
> > In vendor kernels, they add delays to the WiFi drivers.
> > Maybe they have run into the issue, and they're just fixing the symptom?
> >
> > Default value for ios.power_delay_ms is 10 ms.
> > msleep(ios.power_delay_ms) is called twice in mmc_power_up().
> > So raising the delay from 10 to 20 adds 20 ms
> > to the latency of initializing SDIO/SD/MMC controllers.
> >
> > Would you be willing to test if the problem manifests on your board?
> >
> > Regards
>

Kind regards
Uffe
