Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF557C6FD1D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 15:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjCOPbf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCOPbf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 11:31:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C21CAF2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 08:31:28 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p16so12836260wmq.5
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 08:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1678894286;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HAuSI8fbf7EjZnoEFKw9ekptMB+UHMwvd5cIIOc8Nq0=;
        b=kVC3ewfF9E9iXAXtUnrnDJjZ84FVvmCPd0CzgEsXl/0VH3ZIw76/aZDK3CcqX+BWXj
         GvIYyXIcob1C28cz+e0yDEnsMV4wFL1X2i/HIthW9va8ef4oSFk//DaP9Zou/Fbnc4dw
         +ElKez+J8IKzFJHf9OS2hUOpm+Sg3ZCpdOjDnHajtK+cnb9nwyURW5HPNvTYVkSOTCFe
         tDOAAKj4CdfBI9bJlwN6tJ2y1HaKQTcO/1RudRnS9MFhCjt5iuRfUWYJ7TmgL7sQPXPx
         Wh7am538u5wgqUT4hsTgbDITsosO9JTKmBHfC+RE1PVgipClplyouiqI9C3aCbP97+y2
         kwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678894286;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAuSI8fbf7EjZnoEFKw9ekptMB+UHMwvd5cIIOc8Nq0=;
        b=4zd3Z8F67juDnkJlr1CAGlAI+bjVYBHEHitttW1NWqrcBVaAXw51KK2UKhI8LI7+QG
         tP1ftiBufNqvwq8sjoJ/A4mmMFlhCQB1ui11zvDT0ZlQcOSnWDMkb/B6RlCJDF1wccH7
         WZVu1lBysky7hVwgZC+MOVVxY4RwVmqi4cPqy1mc+lL8kB1ppHhMLy5fqSxEVc4Ou/YO
         19oWycx7rFNLDbvmgaWKAyKgv9Iqyq4IWqxKBSfYE/ydZo4FaMOHkwnFZ7q97iLQiAwm
         TxI0eIJ3XOgUBYIywN3/fWRnOPpS5fpfwLsS4yXe7H4aS1q21oKo/Tg+/P//8fQULDtZ
         MH+w==
X-Gm-Message-State: AO0yUKXZRveiQZgWCoKUGTLOz+3S0hFVSu0a/xTR1CBehP3vAqa9HRMV
        RMjHCG7D8a67v/pUtgfFyH7VBg==
X-Google-Smtp-Source: AK7set//NBBiirSk/SotcHjXSzOBy6juc2x591Eu3xI+gLXsnPeVz8IBxWAd/Pnyw6ynhUCofUt15Q==
X-Received: by 2002:a05:600c:5408:b0:3ea:ecc2:daab with SMTP id he8-20020a05600c540800b003eaecc2daabmr20277290wmb.3.1678894286579;
        Wed, 15 Mar 2023 08:31:26 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c4e4400b003e8f0334db8sm2315660wmq.5.2023.03.15.08.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 08:31:26 -0700 (PDT)
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
 <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
 <b6971cd6-80f2-522a-64fb-82b126500010@free.fr>
User-agent: mu4e 1.8.13; emacs 28.2
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
Date:   Wed, 15 Mar 2023 16:27:19 +0100
In-reply-to: <b6971cd6-80f2-522a-64fb-82b126500010@free.fr>
Message-ID: <1jcz5axc8j.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Wed 15 Mar 2023 at 11:20, Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:

> On 14/03/2023 20:45, Heiner Kallweit wrote:
>
>> On 14.03.2023 18:24, Marc Gonzalez wrote:
>> 
>>> With the default power-up delay, on small kernels, the host probes
>>> too soon, and mmc_send_io_op_cond() times out.
>> 
>> Looking at mmc_power_up() and how power_delay_ms is used
>> I wonder what you mean with "host probes too soon".
>
> Hello Heiner,
>
> Thanks for your interest in my patch! :)
>
> I should have added a link to the thread that led to the patch.
> https://patchwork.kernel.org/project/linux-wireless/patch/c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr/
> Start at "I have run into another issue."
>
> Basically, I have an S905X2-based board.
> I built a small kernel for it (with only a few drivers), that boots really fast.
>
> mmc2 (SDIO controller hooked to WiFi chip) would not probe at all,
> unless I added lots of printks.
> Basically, calling mmc_send_io_op_cond() too soon after the controller
> has been reset leads to the CMD5 request timing out.
>
>

I tend to agree with Heiner here.
This patch is backing a contraint only reported on your design in the
driver of every AML SoC supported, for every MMC controller.

I think you should look first in your vmmc and vqmmc regulators and
their setup times.

"fixed-regulator" have properties which might be interesting to you,
like
 * startup-delay-us
 * off-on-delay-us

>> Are you sure that the additional delay is needed for the Amlogic MMC
>> block IP in general? Or could it be that your issue is caused by
>> a specific regulator and you need to add a delay there?
>
> The eternal question...
>
> I have only one type of board. (Actually, I have a reference design
> that is slightly different, so I should test on that one as well.)
>
> In vendor kernels, they add delays to the WiFi drivers.
> Maybe they have run into the issue, and they're just fixing the symptom?
>
> Default value for ios.power_delay_ms is 10 ms.
> msleep(ios.power_delay_ms) is called twice in mmc_power_up().
> So raising the delay from 10 to 20 adds 20 ms
> to the latency of initializing SDIO/SD/MMC controllers.
>
> Would you be willing to test if the problem manifests on your board?
>
> Regards

