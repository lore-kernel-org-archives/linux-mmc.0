Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FACC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD9B72222D
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 08:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KvJqMahN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgICILh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgICIKd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 04:10:33 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B34CC061249
        for <linux-mmc@vger.kernel.org>; Thu,  3 Sep 2020 01:10:32 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g16so624766uan.5
        for <linux-mmc@vger.kernel.org>; Thu, 03 Sep 2020 01:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t0hPUkXrts5hGV+gelozsNVJL831/qNHHpNikRUOxRI=;
        b=KvJqMahNGmcwZQvnzuao4zxMTJwrZ0aVd7RcYrE6hPpss6ABBzXgZfiKyN0Dc1xt3w
         d3AvbT3tUsr7G6i3EtAwWd+0XJ5MPlSy7K4kK/NeDlm6/Oo+WgIIiY7uz1D6RIs5kRTl
         dKWixy9q/3zuVRU3M/njOSPnnFTjXipSJ87wGBJtH7eiTaBcdN5ZUFQbWqAfd7QPVhU4
         FWG6f+ssqAmxHxYlswVTrkTyEBATxmqcTZ+YR/6XiBmCPeZOcSHKQUO12y6KiBnU5dUR
         2oEVUql1QDK9sCgoP2ChziQt2N+GXUK0rLFjOpZPxVz+l1LqejH6ftYDaJh35vQI3K+P
         LMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t0hPUkXrts5hGV+gelozsNVJL831/qNHHpNikRUOxRI=;
        b=VZpPOcr41i7WRt+xFmNI25xp8FLf8xPpfhsvQTlh3R4E6XO+Po2NwbECwymJPa187E
         ls8UdCoaRcmKQwfQCJX5ndd4pjXgXxwfHdeP4lEJm8apb0mVETWA/mQ37K0I7fTzVxeF
         qqkUwxOyjsXv0MVAE7zNn67A+o2HTJizmNWYRI9vwrfr/tq5mXj95s4izLHXGo0rIOsZ
         7h2RD5M/oH5e7Ng2ulIMYSFv32UMq+H4KnuuF+Kqxi2UfUPenKVYAGQC7rE8o+9wyBqC
         dR8w5tH7CS9pX3YAyyJlshEcgc10jQA2NjVZEO54Saz9QdJHJyptLwtOrsPunVIDIwaZ
         RYog==
X-Gm-Message-State: AOAM530byAo4x/vriI2MRzhg8cdQwjSHV76R3iVseDBN5makbSZ2j1ik
        3CGcZ7FQiFMMFW2RzD2LfoMXa8yV9sO3v7yoKyWAdg==
X-Google-Smtp-Source: ABdhPJyGFXf2GrcMm01qExZWSJ7jPtSw9m1PN/7SAvsSK9s1ZS20v0pF9sjrlhSxNVUE5hh22/OySMNemS1iIc0OoDQ=
X-Received: by 2002:a9f:2722:: with SMTP id a31mr381930uaa.100.1599120631644;
 Thu, 03 Sep 2020 01:10:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org> <20200902193658.20539-7-krzk@kernel.org>
 <d98f6b67-c0d0-f701-af24-b01f61c4580d@gmail.com>
In-Reply-To: <d98f6b67-c0d0-f701-af24-b01f61c4580d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Sep 2020 10:09:53 +0200
Message-ID: <CAPDyKFrp3GLLTjdSroyB9_QOcGM=JkFcsv3Chfgu2FSfATxGqg@mail.gmail.com>
Subject: Re: [RFT 06/11] mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Sep 2020 at 21:58, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
>
>
> On 9/2/2020 12:36 PM, Krzysztof Kozlowski wrote:
> > Only -ENOENT from devm_clk_get() means that clock is not present in
> > device tree.  Other errors have their own meaning and should not be
> > ignored.
> >
> > Simplify getting the clock which is in fact optional and also use
> > dev_err_probe() for handling deferred.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> This is actually an open coded version of devm_clk_get_optional(), so
> this is fine:

devm_clk_get_optional() treats -ENOENT specifically, so it's not an
exact open coded version. I think that's why Krzysztof prefered to get
it tested on HW.

>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!

I am queuing this up for next, without waiting for explicit tests .
There is time to get that from testing in linux-next anyway.

Kind regards
Uffe
