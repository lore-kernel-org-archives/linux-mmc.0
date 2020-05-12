Return-Path: <SRS0=7kHn=62=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A14C54E8D
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 07:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB76218AC
	for <linux-mmc@archiver.kernel.org>; Tue, 12 May 2020 07:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="c/AU81xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgELHJN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 May 2020 03:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728525AbgELHJM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 May 2020 03:09:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B2AC061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2020 00:09:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h4so20493743wmb.4
        for <linux-mmc@vger.kernel.org>; Tue, 12 May 2020 00:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ne4G1hw7iuZLuKwIvm4TOsEkgQyVcIP6lOJe9NG9OX0=;
        b=c/AU81xdLryWPyTaVh0+eW0JsKLbkkiWgEN20UkCWXLyadejFKrluqrbp8vt2dQyQX
         Q75VgyKXGQuVcsPkfs60ki1+4JY/BvC3BK38fko2EvEXHYClK1B3oLQ/brM1S/ZydJr0
         /i1t81irAJaH4BkX9o3oIZoq1eiUg5QUbtazxL/OqXBKPFrPWsIqlPNg0Db6a7wTkSji
         eaQCMIiYzTmzCVSvqYKOwTeOuWZmLBO1b0+xVhEUl0tKJtE5k2wEyl9MnbPXLAUhpLSz
         UlWsQmoTfk6f1C3So6RcyBMhQvFjTub6Ap8yp0Mk0DQDrZQgMLfsb7H1J+GrzJx99h6O
         QbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ne4G1hw7iuZLuKwIvm4TOsEkgQyVcIP6lOJe9NG9OX0=;
        b=Vf3JtPA+KK0McMjVo5O1JxGO5EgEeLWmOOGsTgADzcsyG6X+D2i5XiNFhSWJQAtwZ/
         UPhCW9E9y1Jjhd2YAkEDwdKAbhYsPxF/jElQjLEezi9TXgpRj+X8EsulQTApnUwi0m8u
         rxvVzngSEB4Pr/lsNZpKDP2nGwy+te6Cf8fWOSblB2nx5C7qya+LEpcKgDvzzTjYTP4l
         CEnSBZS+0t4zYV7OVP/c9ybY27E9x9i+2ezdMWER4DpVzHdUUHhwd/HHEAKshxXIUbOK
         CVF3FxN6Ru54rsfQFnj5drGWjFXY7M/fuMihHnXaNTwj8p/diMlbbfiX62XpZYzQ5q7+
         zD3w==
X-Gm-Message-State: AGi0PuaoBdOcCPfijojuXKANGg6y3PWmNEbOe8UAgN/8+Og/svPKq9As
        Ln5uNzf3zfgOosTokHCa69f5fg==
X-Google-Smtp-Source: APiQypL3S59Ppn7G1AX6lM0+lpoyv3dcIFbr+mUAxlZbBRTqgnNBSaJUmfVNj9b+buv6l1BlzJK5vg==
X-Received: by 2002:a05:600c:2c0f:: with SMTP id q15mr38502498wmg.185.1589267350798;
        Tue, 12 May 2020 00:09:10 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id i17sm30353895wml.23.2020.05.12.00.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 00:09:09 -0700 (PDT)
References: <20200428210229.703309-1-martin.blumenstingl@googlemail.com> <20200428210229.703309-3-martin.blumenstingl@googlemail.com> <1jlfmdi9uw.fsf@starbuckisacylon.baylibre.com> <CAPDyKFoEh8qKYFONo1SHnvwhDwjUa5bMnnT1Kbu8=4rd=T-8Kg@mail.gmail.com> <1jh7x1i3hj.fsf@starbuckisacylon.baylibre.com> <CAPDyKFq_USCNNps3s4+C_1hriycrxtRMKJvnPFcP59CZmLXbGw@mail.gmail.com> <1j1rnygye6.fsf@starbuckisacylon.baylibre.com> <CAFBinCAPGwb4YKJvUSyvzSC7hpVO0z-Ju_pBWx-06QzYXc0orw@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
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
In-reply-to: <CAFBinCAPGwb4YKJvUSyvzSC7hpVO0z-Ju_pBWx-06QzYXc0orw@mail.gmail.com>
Date:   Tue, 12 May 2020 09:09:08 +0200
Message-ID: <1j1rnpfx4b.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Sun 10 May 2020 at 22:52, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Tue, May 5, 2020 at 6:05 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> > 2. Keep the existing approach, with devm_clk_get(). I am fine with
>> > this as well, we can always switch to 1) later on.
>>
>> I have a problem with this approach.
>> The dt-bindings would include "#clock-cells = <1>" for a device that
>> does not actually provide and only needs it has a temporary work around.
>> Those bindings are supposed to be stable ...
> actually I don't see a problem here because this specific MMC
> controller has a clock controller built into it.

Clock controller is a bit exagerated. It's an MMC controller with a
composite input clock and a couple of gates. A fairly common setup.

Also the property does not indicate a "clock controller" (or any number
of clock hosted by the device) but the ability to provide clocks out of
the device.

This device does not actually provide clock externally. Your provider
is just meant to be used internally. It is a work around using DT for
something missing in CCF.

IHMO, it is not such a big deal but since the binding are supposed to be
stable, I'm just pointing out that it is not great.

> Rob also didn't see any problem with this when he reviewed the dt-bindings

Again the bindings would be fine if the component was actually providing
the clocks, AFAIU.

>
>> I have proposed 2 other short term solutions, let's see how it goes
> since I was also curious how this turns out I first implemented your
> suggestion to use a similar clk_hw registration style as
> dwmac-meson8b.
> That made the code easier to read - thank you for the suggestion!
>
> On top of that I switched from clk_hw_onecell_data to directly
> accessing "clk_hw.clk".
> Unfortunately the diffstat is not as great as I hoped, it saves 21
> lines (11 in the driver code, 6 in the soc.dtsi, 5 in the dt-bindings)
> Once devm_clk_hw_get_clk() is implemented 8 lines have to be added
> again for error checking.
> I attached the patch for the drivers/mmc/host/meson-mx-sdhc* parts if
> you are curious (it'll apply only on top of my github branch, not on
> this series).

Diffstat was not my concern, TBH

>
> Please let me know if you want me to submit an updated series where I
> directly access "clk_hw.clk"

I'd be happy if you did

> to get the "struct clk" or if I should
> keep clk_hw_onecell_data.
> If it's the former then I'll also add a TODO comment for the
> conversion to devm_clk_hw_get_clk() so it's easy to find.
>

Perfect !

>
> Regards,
> Martin

