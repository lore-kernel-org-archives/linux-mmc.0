Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99D1C64EC4
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Feb 2023 23:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBQXdh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Feb 2023 18:33:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBQXdg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2023 18:33:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354285B749
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 15:33:34 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id co2so9608433edb.13
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2023 15:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kohlschutter-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyCJnKBF9xRPdrA0sJ4+bBFcoXE8pttkRG4G6fKGnFE=;
        b=pS0niakP0qYCqC2MJLnyALz2ZjW/72UI2Q4X0R+oTZAADhujSy/JgqH0txQkKRhuLX
         BMpivIJKHI7oAqy0pJRNq2ORgzZ07Pmdu3bbFO5GxlNvfXWJQB+G4trABc8lyzIxzxE/
         wiZOHmBunQ+4fG3qFe9PKaMmF7bHw3xkrH6SjcyqFyQxSyt1tXHstytima8HK9jybguG
         E4MYux0/t2MjH9dwkkqky+iaf9iksgxrHo8Stg96FM1BwbgsEkg3/EiHKNkdguxBXKZE
         lYeu3/V0n+UUUZ8tWb6cqbQg9YddNZ0YWD5xoNcHfQw/N3+j64lo9lGVhnYeYTeFf4IF
         ut0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VyCJnKBF9xRPdrA0sJ4+bBFcoXE8pttkRG4G6fKGnFE=;
        b=KeNM63QWot5fW2wN7x8JLTZNA90vnZfERsGBKPvH7e0jF61/kga9DE3lqoFQTaEzvI
         fTVFTKH4j0IDsB1TjTkUMgh84W9CLoj2UeKbnZLu5cDYgA6WK0hN9uxSbqRHCxOLHbWr
         ci9ca36dEFsSmignJkxK+Xx04Gorta4EvDxVc3rs4ylanLOuV2IgXgq5eguuKRMWlj5B
         hut9ioOtxipYqqn2npAOiyLZsF7gslcenWhDltKlBAFKCh0pGz/8yTXXACEqRm2lz2if
         s2jqTx0Amphuk2cs//i6GWIpiDCdM1VwJ5u3zY+4vPDy1fUzWucSV9ewGYGcJximKBpp
         HQeA==
X-Gm-Message-State: AO0yUKWbx8GrEbdhZdqPUbyq/Mb/yaQS4NkQUSXKpsaYmJg/95zN3HzH
        82gLI1NWztlM5gtSPuKOmZDJYA==
X-Google-Smtp-Source: AK7set+ai0x5njq0qyzxAuo61bXFMSNmeHD/E8IxRrIgjbWcMCG+iNki7n/CF54Mtu1zwb8knZU28A==
X-Received: by 2002:a05:6402:4491:b0:4a3:43c1:843e with SMTP id er17-20020a056402449100b004a343c1843emr6785727edb.18.1676676812552;
        Fri, 17 Feb 2023 15:33:32 -0800 (PST)
Received: from smtpclient.apple (ip5f58e70e.dynamic.kabel-deutschland.de. [95.88.231.14])
        by smtp.gmail.com with ESMTPSA id b16-20020a50b410000000b004adc66c5193sm1437407edh.88.2023.02.17.15.33.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Feb 2023 15:33:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH v5] regulator: core: Resolve supply name earlier to
 prevent double-init
From:   =?utf-8?Q?Christian_Kohlsch=C3=BCtter?= 
        <christian@kohlschutter.com>
In-Reply-To: <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
Date:   Sat, 18 Feb 2023 00:33:20 +0100
Cc:     Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?utf-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rockchip@lists.infradead.org, m.reichl@fivetechno.de,
        robin.murphy@arm.com, vincent.legoll@gmail.com, wens@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B6E001E2-9BCD-420A-B0F6-1495DE46955E@kohlschutter.com>
References: <932DEB17-70FB-4416-80B3-C48A7C31848F@kohlschutter.com>
 <20220825212842.7176-1-christian@kohlschutter.com>
 <CAGETcx__Ez8i9O2O30-Q1R00xOqBjkKMCwt37_AGAQjNvZqpdg@mail.gmail.com>
To:     Saravana Kannan <saravanak@google.com>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 18. Feb 2023, at 00:22, Saravana Kannan <saravanak@google.com> wrote:
>=20
> On Thu, Aug 25, 2022 at 2:28 PM Christian Kohlsch=C3=BCtter
> <christian@kohlschutter.com> wrote:
>>=20
>> Previously, an unresolved regulator supply reference upon calling
>> regulator_register on an always-on or boot-on regulator caused
>> set_machine_constraints to be called twice.
>>=20
>> This in turn may initialize the regulator twice, leading to voltage
>> glitches that are timing-dependent. A simple, unrelated configuration
>> change may be enough to hide this problem, only to be surfaced by
>> chance.
>=20
> In your case, can you elaborate which part of the constraints/init
> twice caused the issue?
>=20
> I'm trying to simplify some of the supply resolving code and I'm
> trying to not break your use case.
>=20
> -Saravana

Here's a write-up of my use case, and how we got to the solution:
https://kohlschuetter.github.io/blog/posts/2022/10/28/linux-nanopi-r4s/

