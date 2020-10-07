Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB8C4363D
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9576520870
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 11:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="risRhOIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgJGLcx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 07:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGLcx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2020 07:32:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88252C0613D2
        for <linux-mmc@vger.kernel.org>; Wed,  7 Oct 2020 04:32:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lw21so2437538ejb.6
        for <linux-mmc@vger.kernel.org>; Wed, 07 Oct 2020 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=UUAtMhUEk/jz98adLLh/kvHWU+87rtZfg/cfL1Bdfv4=;
        b=risRhOIo118pkONLYVu23luhqGeB5jDgqxnxSf8q8nSEGVRzYNHLnpk2xI4o3/akUU
         9iJ6UYN7xRVB6xO1iGDKwIVdnFC9+YmYxobpCvE1XSqJ+cvYrf+pTLuXxhKmXlWLlprA
         TTdRdlIfq520FIItzRxnEZWOQCMPmdw3K35VxMPxnCsDuXYDb9YGLQZhanD4WxwvJdHi
         mA7xkitMJo0Y4VP220+O5aYm7egOe1ATbMWxcjquK+uIBEYsd1S/wc51/Svfj0MgD2Ha
         fsebz/VLQU6nBgdx+OaKjCQScS41zAuJ2om5xUSZAOts9h6bfEIXRCCN+qU9UifNURbj
         aI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=UUAtMhUEk/jz98adLLh/kvHWU+87rtZfg/cfL1Bdfv4=;
        b=npufGbusgsO/vdgRGAkibxxcNgFzD3/Q/UJOlQK/ethu3t/IYBiAlGyaEt5CeZYwLd
         D60pCTyXT+/y5g6+5F3fIsWUGzMbQYNgIO5AtPQNRFtwUUiaIaDFH5L2dYVuZEYeE+Sj
         JNsaG7+T49BEUCRtnNPx98R3NIw6VhKpAnwJOgj2rrEECzKIcx0ic1uBbuq59KsPUils
         1jYdRcu7HfCY4IYlabnjbTH9o6099Sa/s91W+zcLxKdDih2jd/Lkh/FboKOzjyYsWP8t
         y7+7FtIVE3J7HHoVwZF45Ru0/juYQE4ivGpl3l66HtuHZoK2BqwtOdiST18EVKvz4qIg
         EEVw==
X-Gm-Message-State: AOAM531xoEVOUsW68KBedZfdGCiPDLE1avxlqEPrOClxHZRIDWR6G4fp
        ZZPLCFbmKU3acvV9FyprOUfj/Q==
X-Google-Smtp-Source: ABdhPJwevDhhFb3fbE81queKzB5zgztjuRr7Aq9efuwPUXqmp2hDPvc+PUbX3Xnkw0p65sb/EPunjQ==
X-Received: by 2002:a17:906:c1d4:: with SMTP id bw20mr2859064ejb.91.1602070370261;
        Wed, 07 Oct 2020 04:32:50 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id d59sm1247111edd.74.2020.10.07.04.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 04:32:49 -0700 (PDT)
References: <e4e6cc45-bc18-40ec-035e-fdb45b9a8f46@gmail.com> <87o8lf74j5.fsf@nanos.tec.linutronix.de>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brad Harper <bjharper@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] mmc: meson-gx: remove IRQF_ONESHOT
In-reply-to: <87o8lf74j5.fsf@nanos.tec.linutronix.de>
Date:   Wed, 07 Oct 2020 13:32:47 +0200
Message-ID: <1jy2ki1db4.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Tue 06 Oct 2020 at 17:33, Thomas Gleixner <tglx@linutronix.de> wrote:

> Brad,
>
> On Wed, Oct 07 2020 at 00:45, Brad Harper wrote:
>> I'm happy to test anything on a range of amlogic hardware with standard 
>> / rt and  multiple mmc devices.  Ill test Jerome's patch in next 24 
>> hours to report the results.
>
> please do not top-post and trim your replies.
>
>> On 6/10/2020 11:43 pm, Thomas Gleixner wrote:
>>>       We rather should make interrupts which need to have their primary
>>>       handler in hard interrupt context to set IRQF_NO_THREAD. That
>>>       should at the same time confirm that the primary handler is RT
>>>       safe.
>>>
>>>       Let me stare at the core code and the actual usage sites some more.
>
> So there are a few nasties in there and I faintly remember that there
> was an assumption that interrupts which are requested with both a
> primary and a secondary handler should quiesce the device interrupt in
> the primary handler if needed. OTOH, this also enforces that the primary
> handler is RT safe, which is after a quick scan of all the usage sites
> not a given and quite some of the users rely on IRQF_ONESHOT.
>
> The below untested patch should cure the problem and keep the interrupt
> line masked if requested with IRQF_ONESHOT.
>

With arm64 defconfig on Khadas vim3, no obvious regression. Looks good.

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

I did not test with RT. Brad, Could you let us know is Thomas's patch
works for you ? Thx
