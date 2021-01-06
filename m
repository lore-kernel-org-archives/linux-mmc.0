Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD83C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 18:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC3D2312F
	for <linux-mmc@archiver.kernel.org>; Wed,  6 Jan 2021 18:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725803AbhAFS5i (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 Jan 2021 13:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbhAFS5h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jan 2021 13:57:37 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4475DC06134C
        for <linux-mmc@vger.kernel.org>; Wed,  6 Jan 2021 10:56:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o19so8982184lfo.1
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jan 2021 10:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BkbT4Hus3vLbtvqvzcx0OaUHLOYXlMI/hIXqReOZJb8=;
        b=dt4rZYgQgX/X3Y7Cx9cO61ZXTsYyTgoKymYLrDIS9MhWn3O8v1VOr/jqAGQmcEodQj
         YjQGjSTGFZBJLAbUEs9hZPI9DnWrVeexaaQ9HgUidlA0sz7XGNHg5sIEfeIYPUkk769Z
         M+4JREGllltqWYBn8o2oElJu/b+x7MS3ekSRTMTn4UXcf6l7q6BQYUDesWbgh1BxWe5B
         8RqlfJnGvVZqTL0zeuJXjlRXnf4WJA3EESjHvUgtOtffWtVs+LIDF07dZArk9mlH6HRY
         /ALSf2e7U9leMo1WUfv3OebDLKeC8BC1XxKsJvRmif/RHF6URTWQ7AAIPe9CrGDttIpy
         ewtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BkbT4Hus3vLbtvqvzcx0OaUHLOYXlMI/hIXqReOZJb8=;
        b=eB8u4OHyLj3b+JAGxFn8W1qEHnTU4myr1Wn/HpGZvb09H/+x8rcXti38bBmEAJZm6b
         cw/v5/1P8lFWODDAt3mDxtL+jy1jZs1ApCYBLbvPrTJLZ3dQPlNJ03ziYqh9SfD6Si85
         HO8X1PrJz8CiupE6PZQajyy79GphkaEe4j/eurtzfq8X+8AYVfb2VoZBx5gRjg55rHo2
         CsHL8f8ya6O0ZOK9UaQ7zghoFo+Ri2YKxVH0U0q06Cj+FNNHQA+aFAFxa5jfcsoNtN3N
         iiOK4PnxkMZhlRSJJCYfOS0gjmrszb/iLOjBAL06WhVbu0lTMMdNIXORC3yfWYvCKPtY
         m/oQ==
X-Gm-Message-State: AOAM5324DEV8L/kfvPCRHBJrV8RI0A1/ophElFEyGmv86MSI8y3W5bwK
        fd0PHJQ7azT49IgEOQ/f+Dk18JQH7DjgGu9VadU=
X-Google-Smtp-Source: ABdhPJzT6CDI1ihHDV42x1k7PzDLUIJDHeJEmx05Fil+13kZnMYtnJhKQSKYPZjNsjD5pEtNKzScJvR7SNKi9oHsTcU=
X-Received: by 2002:a2e:bc05:: with SMTP id b5mr2618412ljf.444.1609959415759;
 Wed, 06 Jan 2021 10:56:55 -0800 (PST)
MIME-Version: 1.0
References: <CAOMZO5DMMCZPfwNbTaG8_iQhWg2K1XeO719nSA0Gsf2ywHy4jQ@mail.gmail.com>
 <20200205092653.GB2737@bogon.m.sigxcpu.org> <CAOMZO5AAzK0QprHpKHaFOANjspJKd_4YaoMqAoGYG4KftcyiYw@mail.gmail.com>
 <VI1PR04MB5040A046E5D93265AE636B29901C0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <VI1PR04MB504091C7991353F6092A8D91901A0@VI1PR04MB5040.eurprd04.prod.outlook.com>
 <CAOMZO5CkSSidzLUSBUvJNAio3SnmU-fisTbDCiLN9v1EjS+HHQ@mail.gmail.com>
 <5ad361195f2e191484c8a231be0f5a07@akkea.ca> <CAOMZO5BarV1=6rx9L_hkJJLUQSicwPNUO4HFKWAXSQ6n0N+Kzg@mail.gmail.com>
 <VI1PR04MB52942233A0BA6BCB692F281E90670@VI1PR04MB5294.eurprd04.prod.outlook.com>
 <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
In-Reply-To: <cd99776c0107833d69c9c7fc4c8d6ba1a41ea3d7.camel@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 6 Jan 2021 15:56:43 -0300
Message-ID: <CAOMZO5BzAw8CjvaOzH_Ynr2eapO1MViTOWN5yZ5i_BcAhv3tWA@mail.gmail.com>
Subject: Re: sdhci timeout on imx8mq
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>, Angus Ainslie <angus@akkea.ca>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Lucas,

On Tue, Jan 5, 2021 at 12:06 PM Lucas Stach <l.stach@pengutronix.de> wrote:

> The reference manual states about this situation: "For any clock, its
> source must be left on when it is kept on. Behavior is undefined if
> this rule is violated."
> And it seems this is exactly what's happening here: some kind of glitch
> is introduced in the nand_usdhc_bus clock, which prevents the SDHCI
> controller from working, even though the clock branch is properly
> enabled later on. On my system the SDHCI timeout and following runtime
> suspend/resume cycle on the nand_usdhc_bus clock seem to get it back
> into a working state.

I think your analysis is correct and I recall helping a customer with
a similar issue:
https://community.nxp.com/t5/i-MX-Processors/External-clock-that-provide-root-clock-for-SAI3-and-SPDIF/m-p/1019834

Regards,

Fabio Estevam
