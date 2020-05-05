Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9FEC47254
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 16:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 235A42073B
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 16:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pCbw8Q2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgEEQF4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 12:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgEEQF4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 12:05:56 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19277C061A10
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 09:05:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id y4so3172002wrm.11
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=njl+I1KZR8dAJRFqU7HOVFmyMwpktP+Payzdk7cqiZo=;
        b=pCbw8Q2Djt96EsEtPl4Xwf9WOgp+W7CXvZgaxdqcpirmNYjSYs2lAQfYP/qBeN/imW
         qVMnYbtAIPWG5WvEXKrE3XH56YcQ5PblSP5dxSicG19C+Fm9IHnOwcV3lDboZ/rahDZX
         KaV7vV6svD+bncNQN5UeWvAx1zaJqLFE+x33f58dhDIhxEQ+WgOKmPKT3J6RZ8o0i06h
         kf7BZ1v3yDpTlV6C7mQTqSZbNF8qq3GoMgdq9JlBFZzbejBN6FDDzVfxn08kDc2K1pZP
         dwfSr/9J/i1UZKnhFzYWvndqFjCsIHYjOlxrqmpfh+pStSpfhfIEGQUBA5z85DMujbZr
         MQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=njl+I1KZR8dAJRFqU7HOVFmyMwpktP+Payzdk7cqiZo=;
        b=JOA+SYrZy/5m5RNhB4FDtSaJQWaHMDBvIZ0I5QdpHg8i+HcMnaLrsnjYEpKqs2WOMl
         t18zEz4wpCGhQvDPzBKea0L/bWE797qvr3Crv2JHU5Beo+VkfhTN71pu7oe7LwrML71p
         nA9UaJtSUeDZZ1DSkktKGkE93eMTrnl1WfNtRKmqsmLAxith/3DeqEcgqCzmJRAwsn3x
         rfZEZO/zNzaSqBDxH96ODmowD3oAE75zhD2p73sMhjKjCiLr0K2z+QhQVqm5IrkLAcur
         pG1YrHTqpxuPc1YRpcVPna5ujciMxYveiGin5iSV3CVKAaTG9yeDVll9Ebn8BH3jz1X+
         oc2A==
X-Gm-Message-State: AGi0PubC5i64sZkj30KnJksQgxE6hgB8iLYyqS03cspLsldUQa0Pkulp
        jrxyKL3BcTyDlxebovvDIM+PVQ==
X-Google-Smtp-Source: APiQypLoB4fjwTQJDOAaK7x/BgWoRefOlMYzgeBPm4DGbTUjdPo8UYmkhAaAStq6Y7TclKEt1oNfMQ==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr4240620wrt.270.1588694754820;
        Tue, 05 May 2020 09:05:54 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id l19sm4636869wmj.14.2020.05.05.09.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 09:05:54 -0700 (PDT)
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com> <20200428210229.703309-3-martin.blumenstingl@googlemail.com> <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com> <CAPDyKFoEh8qKYFONo1SHnvwhDwjUa5bMnnT1Kbu8=4rd=T-8Kg@mail.gmail.com> <1jh7x1i3hj.fsf@starbuckisacylon.baylibre.com> <CAPDyKFq_USCNNps3s4+C_1hriycrxtRMKJvnPFcP59CZmLXbGw@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        "linux-mmc\@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yinxin_1989@aliyun.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v6 2/2] mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host
In-reply-to: <CAPDyKFq_USCNNps3s4+C_1hriycrxtRMKJvnPFcP59CZmLXbGw@mail.gmail.com>
Date:   Tue, 05 May 2020 18:05:53 +0200
Message-ID: <1j1rnygye6.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Tue 05 May 2020 at 10:17, Ulf Hansson <ulf.hansson@linaro.org> wrote:

> [...]
>
>> >> > +
>> >> > +     return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
>> >> > +                                        onecell_data);
>> >>
>> >> I think registering a provider for a module that does not provide clocks
>> >> to any other device is a bit overkill.
>> >>
>> >> I understand the matter is getting the per-user clk* pointer.
>> >> Since this is the module registering the clock, you can use clk_hw->clk
>> >> to get it.
>> >>
>> >> Once you have the clk* of the leaf clocks, you don't even need to keep
>> >> track of the clk_hw* since you are using devm_
>> >>
>> >> Afterward, we should propably discuss with Stephen if something should
>> >> be added in CCF to get a struct clk* from struct clk_hw*.
>> >>
>> >
>> > [...]
>> >
>> > Hmm.
>> >
>> > I am not sure the above is a good idea, at all. Unless, I am
>> > misunderstanding your point, which may be the case.
>> >
>> > I think above "shortcuts" could lead to abuse of the clock framework
>> > and its internal data structures. When going forward, this could make
>> > it unnecessary harder to maintain the clock framework.
>> >
>> > I know, it's not my responsibility, but from my experience with MMC
>> > and SDIO interfaces, is that those have been too easy abuse - since
>> > most of the data structures and interfaces have been exported. Now,
>> > it's hard to roll back that, if you see what I mean.
>>
>> Indeed, it worth clarifying this first.
>>
>> With clk_register deprecated in favor of clk_hw_register, we are likely
>> to see that case rise elsewhere.
>>
>
> So, according to the separate discussion [1], I think we can let
> Martin decide what option to implement at this point.
>
> 1. Implement the "clk_hw_get_clk()" approach. The preferred option,
> but requires wider changes of the clock subsystem as well.
>
> 2. Keep the existing approach, with devm_clk_get(). I am fine with
> this as well, we can always switch to 1) later on.

I have a problem with this approach.
The dt-bindings would include "#clock-cells = <1>" for a device that
does not actually provide and only needs it has a temporary work around.
Those bindings are supposed to be stable ...

I have proposed 2 other short term solutions, let's see how it goes

>
> [...]
>
> Kind regards
> Uffe
>
> [1]
> https://www.spinics.net/lists/linux-clk/msg48373.html

