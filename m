Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84537C388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 11:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A992074B
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Nov 2020 11:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rj4QLbP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgKKLp6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 06:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgKKLpn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2020 06:45:43 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFE1C061A04
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2020 03:45:39 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id d191so402946vka.13
        for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2020 03:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W2LROEDqwB/YAfpZuvnNBx/s/n4ussPUTp1SoV848WE=;
        b=Rj4QLbP7hQUGidksqh3Sz+Mz1awLgghgywmgmq9iaGhu6djYI966xmN5JUcRmcYrq/
         Woc2NSWg8j33913hx6Vmfrrzuym6+skblcbvL41IiQFacYFt1SjAs/nslFk+g3W36u4V
         5Z4diCxFrS93BVrqJ7SDLPJfjdeswkTya8vvZmjaKgR3zhBTTE1EhWuFIHUSn9N1wPo1
         iX4p8Jc2fBB3F1mpe8ZqM6XFLIoz2+OX+tvgiLg3x8tn5z0hkeUvi4fzbnv3qjZga/O9
         dv9NoC5jp/yLI8jF8N3x1Yw2xoMv3ppOhpBWH3CIkWAXgT5hobFLAqPh/q8PjOiT3/Eo
         yovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W2LROEDqwB/YAfpZuvnNBx/s/n4ussPUTp1SoV848WE=;
        b=Rgc/Z4swS8IJDTezgPBmXTtimQd7gM70MdGeEJjpvL3pe0XV3ojXDscC076bWXZeEX
         uOVtYOHZ/wOUknDvukZdE8SVglwuQTsmYcxeJ7IYaIIWtG5j1OONuNLsGgbarxjFmAbQ
         AfUJD7yQYunQrHNSA7bjoIiC/WEuUSeq3t5WkrpAaAEFjnwyJWdadagQAxkjDvgVlJ70
         l8Eo1fKGZmd2qAEqR34o8b2GUJDQiYOp5BrR/wv+cUQmC8WfRyPqfbk5pWqY2+hQxvFm
         fmVVpi4fnMx3uioM/KjiyydQj6KUIq4DS99FEQWjurlbzPashknUZCLB+45MBQC5BPPo
         ezVA==
X-Gm-Message-State: AOAM530XLfoW/VnALuxvTNAPCJ8ykv0MFuPeiSKeA11rXCwS11olXlJP
        bvh2aqFjthCjuatLhOpI4IxHISZq8KUgWN6zf9iuTw==
X-Google-Smtp-Source: ABdhPJy49vZO4pNDp6JtJUn+KdVv0aND0NyO3da5g+cVxXyOVmgGe9S4bf/F/v98cY0CP0i1NrbPCyiERv3WhWMkEBU=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr13053486vka.15.1605095138861;
 Wed, 11 Nov 2020 03:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20201104234427.26477-1-digetx@gmail.com> <20201104234427.26477-2-digetx@gmail.com>
In-Reply-To: <20201104234427.26477-2-digetx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Nov 2020 12:45:02 +0100
Message-ID: <CAPDyKFpYeLjeYan74QdtWxtLhZZT-855Rd21sFHBkQXZg78D5g@mail.gmail.com>
Subject: Re: [PATCH v1 01/30] dt-bindings: host1x: Document OPP and voltage
 regulator properties
To:     Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Chen <Peter.Chen@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-pwm@vger.kernel.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Nov 2020 at 00:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> Document new DVFS OPP table and voltage regulator properties of the
> Host1x bus and devices sitting on the bus.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../display/tegra/nvidia,tegra20-host1x.txt   | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> index 34d993338453..0593c8df70bb 100644
> --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
> @@ -20,6 +20,18 @@ Required properties:
>  - reset-names: Must include the following entries:
>    - host1x
>
> +Optional properties:
> +- operating-points-v2: See ../bindings/opp/opp.txt for details.
> +- core-supply: Phandle of voltage regulator of the SoC "core" power domain.
> +
> +For each opp entry in 'operating-points-v2' table of host1x and its modules:
> +- opp-supported-hw: One bitfield indicating:
> +       On Tegra20: SoC process ID mask
> +       On Tegra30+: SoC speedo ID mask
> +
> +       A bitwise AND is performed against the value and if any bit
> +       matches, the OPP gets enabled.
> +
>  Each host1x client module having to perform DMA through the Memory Controller
>  should have the interconnect endpoints set to the Memory Client and External
>  Memory respectively.
> @@ -45,6 +57,8 @@ of the following host1x client modules:
>    - interconnect-names: Must include name of the interconnect path for each
>      interconnect entry. Consult TRM documentation for information about
>      available memory clients, see MEMORY CONTROLLER section.
> +  - core-supply: Phandle of voltage regulator of the SoC "core" power domain.
> +  - operating-points-v2: See ../bindings/opp/opp.txt for details.
>

As discussed in the thread for the cover-letter.

We already have DT bindings for power-domains (providers and
consumers). Please use them instead of adding SoC specific bindings to
each peripheral device.

[...]

Kind regards
Uffe
