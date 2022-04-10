Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E171C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 10 Apr 2022 15:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiDJPZM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 10 Apr 2022 11:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPZL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Apr 2022 11:25:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C2F17075;
        Sun, 10 Apr 2022 08:23:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E5D9CE0B4E;
        Sun, 10 Apr 2022 15:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3B8C385A1;
        Sun, 10 Apr 2022 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649604177;
        bh=ulUg6T6rrbt/EfbXOkU1Ef5NyiEsXklwdnANBmyHwnU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z+MIwtLoYfW/PkpuFbpFgmte8APDEpCPLOsocEKBWi5prjSmAjyGB6lO7eTL0Xx2z
         DnU21iSp77gz615YWOcDeYBR6Pmp+uEds1xTiSlovD3cxER77TzVZFGcrslenoOzD4
         vq3fvTiEAXq/AhO8yhCLHkhuxtisoWdSJwyzvQZw5/yNidyVZOXuvBEc0hxxUo0v2G
         SLHTAO6ynFIFqWBM6dH2IjdIHEmsx7kh6e0/S4+ikmCLMqYUEFECyJg+fLyChJiNbv
         4wDbmMzWq6wNMLifePGBeZGQpNczY8KmPFvI+5PWVuzejpdQaio2Untk6AZrOPByDL
         gt90y5jf3XP3g==
Received: by mail-pg1-f172.google.com with SMTP id s137so9306060pgs.5;
        Sun, 10 Apr 2022 08:22:57 -0700 (PDT)
X-Gm-Message-State: AOAM532rdMbeagthwhdyI5WIkI0yXuqx16TcGhqQb4RKcHFmPhzEjpYU
        KvWeh6+Z/B8sYhrHgwZWHbiX3pfS1V0EB3jACuI=
X-Google-Smtp-Source: ABdhPJzGtnaWz59gOYXMnLlmEDIkfUFWhgLEYdvgIGgLs8MbiEJgqcMz0UwJhgS3ApBj8wO1RoEkv0GyccBaij6mAlE=
X-Received: by 2002:a63:ce45:0:b0:399:1124:fbfe with SMTP id
 r5-20020a63ce45000000b003991124fbfemr23656981pgi.542.1649604177314; Sun, 10
 Apr 2022 08:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220402193942.744737-1-aford173@gmail.com> <20220402193942.744737-2-aford173@gmail.com>
 <a66f17c6-cec6-3eb8-92df-9990d74dd122@linaro.org> <CAHCN7x+mm_oXdkzXOTEQwjCFfDB99p2JG8zZzydbL5_pUVJqCQ@mail.gmail.com>
In-Reply-To: <CAHCN7x+mm_oXdkzXOTEQwjCFfDB99p2JG8zZzydbL5_pUVJqCQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sun, 10 Apr 2022 17:22:46 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdhuzHA1Vi53JE+nFDB1Tj823fx8s+ffx3mPvztWtbXdw@mail.gmail.com>
Message-ID: <CAJKOXPdhuzHA1Vi53JE+nFDB1Tj823fx8s+ffx3mPvztWtbXdw@mail.gmail.com>
Subject: Re: [PATCH V3 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Adam Ford <aford173@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 10 Apr 2022 at 16:36, Adam Ford <aford173@gmail.com> wrote:
> > Instead of comment use (I think on the same level as items):
> >
> > deprecated: true
>
> I have tried various combinations of where to place "deprecated" and
> whether or not to use a hyphen, but I always get syntax errors.  Do
> you have an example of this I can see?

Some simple example:
Documentation/devicetree/bindings/arm/arm,cci-400.yaml

More complex:
Documentation/devicetree/bindings/arm/gemini.yaml

Best regards,
Krzysztof
