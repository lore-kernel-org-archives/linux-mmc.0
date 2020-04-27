Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97758C55199
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1B52084D
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j0X8ISUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgD0QqU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgD0QqS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 12:46:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D03C03C1A8
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2020 09:46:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f13so21311507wrm.13
        for <linux-mmc@vger.kernel.org>; Mon, 27 Apr 2020 09:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=K+g8CFmqfjmYJhrJrB84iQ9ane1MJeR/rniO7Hj0TcQ=;
        b=j0X8ISUfitBA/7pgF+7wgu8pr3DqkIkyLmpu2c7JYW1hSgdSSbqKuFseYFmFzggSq4
         YBiGPvcexHTHn523bsRBKfW9983b4IPLe9iYFu6seqdh6a+UMOwsLAsEdK3HDE5DC9Wd
         HCEwqdEC0m97fG2KxiGGXEPQtnRb2knFsV5KNAlmha64oKZiHul0yB/9FKB94Veevpez
         g40O8b8Jc23aooitCnmdv5VCoJhzPZwGIzS3hm5EqF3fV3qM/yXIK8mZWUK+eRkE+cMv
         q/97FOTCOwZ5ZJ3W2cRDwsU7yltn850rt7KXhyoV72KoqiqWSPLq/6tBCRXm4ElrWdni
         gI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=K+g8CFmqfjmYJhrJrB84iQ9ane1MJeR/rniO7Hj0TcQ=;
        b=XNDMrt53gCahnN9ViXJUwyr+JmGCT1ohTtw8K6fVYognDJ0TwYGhPvvGSZ9xcg/aYZ
         P54zufNdQYNPS5kOAT41Jl9ndf4K7BFtkL2MZYzag/MeBmF1raemh7FsY+ctx8SDPaoL
         XPslccVHgnoHmJaXmV140e0uo60qA7CSVGXUZ3YMOSP9e15swE5B87PPHwNKncZCnZfN
         pgziXry6QzXNsmSB+mspvutOcDG74BkpJblGhfBmsdFvrD95rVgSwifrxHB664zyembv
         GEJ/0N3TqovSYqDONzfvk+B6NglQAWyRKrzCzQIsqCiEJ4IrYSppvC6HXGC13bqa7EeN
         d3jg==
X-Gm-Message-State: AGi0PuZM2S1G9wF4+SHp0C7toY7QEwt/RiBK3n+jrioNwfQsXF8ZIHTi
        2P0IXEQrFZI2hZaOUxKFLDjuEFLOl1w=
X-Google-Smtp-Source: APiQypIeEHjLe+6L+bZvcDi8pabn6zUvT6/Fw3vHzATYAOxTOerhsjaw3lgm9cNww142ONc10a58tA==
X-Received: by 2002:a5d:4292:: with SMTP id k18mr26970411wrq.137.1588005975964;
        Mon, 27 Apr 2020 09:46:15 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id n7sm15664278wmd.11.2020.04.27.09.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:46:14 -0700 (PDT)
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com> <1jblnd2tp3.fsf@starbuckisacylon.baylibre.com> <CAFBinCDzNw6nV3oBJs6C0sssW61GERBXq39DCM22BT9zS8M31A@mail.gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        linux-arm-kernel@lists.infradead.org, lnykww@gmail.com
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
In-reply-to: <CAFBinCDzNw6nV3oBJs6C0sssW61GERBXq39DCM22BT9zS8M31A@mail.gmail.com>
Date:   Mon, 27 Apr 2020 18:46:12 +0200
Message-ID: <1j8sig3mi3.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Mon 27 Apr 2020 at 18:23, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> Hi Jerome,
>
> On Mon, Apr 27, 2020 at 10:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
> [...]
>> > Changes since v3 at [3]:
>> > - split the clock bits into a separate clock controller driver because
>> >   of two reasons: 1) it keeps the MMC controller driver mostly clean of
>> >   the clock bits
>>
>> If the register is in the MMC controller register space and the MMC
>> driver is the driver using these clocks, it is where the clocks belong.
>> I don't get why it could be an issue ?
>>
>> Is the clock block is shared with another device, like on the Gx family ?
> no, it is not shared with another device (to my knowledge).
>
>> > 2) the pure clock controller can use
>> >   devm_clk_hw_register() (instead of devm_clk_register(), which is
>> >   deprecated) and the MMC controller can act as a pure clock consumer.
>>
>> Why can't you use devm_clk_hw_register in an MMC driver ?
>> Unless I missed something, it is provided by clk-provider.h, which can be
>> included by any driver.
> indeed, I could use devm_clk_hw_register in the MMC driver.
> Ulfs concern was that a lot of code was needed for managing the clocks
> and I agree with him. so this is my way of keeping those details away
> from the MMC driver and have two separate drivers which are better to
> understand overall.

Martin, Ulf,

I understand that CCF code might seems verbose and I'm happy to help
review it if necessary but I don't think every driver out there should
register some kind of fake clock controller driver everytime they wish
to use CCF API.

Yes the it might make the driver code cleaner but the overall
architecture is harder to follow.

CCF was made so driver from any subsystem *may* use it. Creating a
controller for a single register is overkill. The HW architecture of
this particular device does not justify it.

>
>
> Martin

