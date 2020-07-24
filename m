Return-Path: <SRS0=uUZJ=BD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF3D3C433E4
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCBDB20767
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Jul 2020 12:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EuAwwFRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgGXMoU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgGXMoT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Jul 2020 08:44:19 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3D9C0619D3
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 05:44:19 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id x205so4802370vsc.11
        for <linux-mmc@vger.kernel.org>; Fri, 24 Jul 2020 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FGHawDNNHiCHWgrOxcXKqCSMD7oEiI1UqCmKADBljuU=;
        b=EuAwwFRWeuUdb4vF35T0sjuH5dKD0BasNwv6q+tQLoNCduhL0GWSu7acttBEE3iv1H
         bjK3j7nBVDXvHpMygDOgB/y1hWSgES61TVbuJCpr5iBiZuBSSEwo+9b0oVR3jhDxAtRx
         UNKAU8CRfgMVR0ZeNRGN4w0yIX6LkRxIiFL/Xsme9m/0kt5bdvN7Rk6byC9Swb+auhbI
         c2TD/rY5ENrsNnfZmnuh8zJ0mfiuK/2aYSEB4m9eqy4IQJcfXr+UtbMp5rlsNxmnRs6d
         fjwfLn9fg2+ssivzVRjo8yVs4khRFeKgUgX6O8zn/chNccrgLUnT2x/QoJkUFzgauZ1y
         onMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FGHawDNNHiCHWgrOxcXKqCSMD7oEiI1UqCmKADBljuU=;
        b=MVQzj079tWDidJwo6IeAao6YaNLcV7O6Cjy3dKb99p0QauwZhvZskDtL5I/efM9/EK
         PTOmX8c5OkrXQJ+OY4CZVI9fUCb3o89O3mpyBl6RMvbTEB/djAZI7oMhK0Njej7vKN1p
         oiTJpxNhBhWAiqIxWD6140X3FC3IrIEpaepZL9KWHgzzyU6yQ7han1v9ZGas8Dfm1+Xt
         rGQjUt9RSM+HiM4Oo53JB4gA46tmT6Sdb7bK5eOXL9mcre/YtL0t1ahRa2z0Y/gbsJto
         tP10IRPAkO2O+oaV5n2UiF3noIrY5PmcYZr8v5J/RGQzjNIT6irRnbf/VTcNa+ZyhF+C
         x5eA==
X-Gm-Message-State: AOAM533demGRaQzEab6oTWk7p4iYKmwV3ZPyeebfyIpfqTg/itCcD86V
        /F6DDD8XOrzSJzGhuP1d88pQ5nDDiK5Rvkj73zyrGeMW6SM=
X-Google-Smtp-Source: ABdhPJycLPobdqjIlIM9BjxmDXvzoDmUte/V7P4h0bRLVGruk4z8NXmk6DXEi6GUkT4hQpVU32Ou5Bq/2mmkmEW1tWU=
X-Received: by 2002:a67:f98c:: with SMTP id b12mr7556870vsq.34.1595594658333;
 Fri, 24 Jul 2020 05:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200618141326.25723-1-lars.povlsen@microchip.com>
 <20200618141326.25723-3-lars.povlsen@microchip.com> <aee90bbf-f0ff-b0cb-b10a-9a2f3bb6acca@intel.com>
 <87wo2vkbns.fsf@soft-dev15.microsemi.net> <CAPDyKFpozhFSzWEM6s8cdeG+8JGX00YyFSzeXZxCsY7Efn0aeQ@mail.gmail.com>
 <87zh7pf8sg.fsf@soft-dev15.microsemi.net>
In-Reply-To: <87zh7pf8sg.fsf@soft-dev15.microsemi.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 24 Jul 2020 14:43:41 +0200
Message-ID: <CAPDyKFpzxPnVFwrPiG738_HpKnypvZev5r874k5WVgL8GEXHJg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] sdhci: sparx5: Add Sparx5 SoC eMMC driver
To:     Lars Povlsen <lars.povlsen@microchip.com>
List-Id: <soc.lore.kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, SoC Team <soc@kernel.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Jul 2020 at 13:32, Lars Povlsen <lars.povlsen@microchip.com> wrote:
>
>
> Ulf Hansson writes:
>
> > On Wed, 22 Jul 2020 at 13:54, Lars Povlsen <lars.povlsen@microchip.com> wrote:
> >>
> >>
> >> Adrian Hunter writes:
> >>
> >> > On 18/06/20 5:13 pm, Lars Povlsen wrote:
> >> >> This adds the eMMC driver for the Sparx5 SoC. It is based upon the
> >> >> designware IP, but requires some extra initialization and quirks.
> >> >>
> >> >> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
> >> >
> >> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >> >
> >>
> >> Adrian,
> >>
> >> Thanks for the ack. I was expecting to see this in linux-next, anything
> >> holding it back?
> >>
> >> pinctrl and hwmon drivers have been merged.
> >>
> >> Thanks,
> >
> > Hi Lars,
> >
> > Looks like you got some feedback on the DT patch (patch1/3) from Rob.
> > I didn't find that you have addressed them and therefore I am holding
> > back on the $subject patch as well.
> >
>
> Uffe, thank you for responding.
>
> The automated checker complains about the inclusion of a header file
> (#include <dt-bindings/clock/microchip,sparx5.h>) in the example. The
> header file itself is part of the "parent" patch series sent to arm-soc,
> but is needed to make the example complete.
>
> I e-mailed Rob about how to handle this, but never got a reply.
>
> Can you suggest how to deal with this? I have checked the schema with
> dt_binding_check manually - with the header file in place.

I see, thanks for clarifying.

When this kind of dependy happens, we have a couple of options.

1. Wait for a new rc to have the dependent changes included.
2. Share the changes between maintainers's git trees, through
immutable branches.

Looks like 1) would be easiest here. So, I suggest you re-post the
series when v5.9-rc1 is out.

>
> I can of course remove the include and associated properties, but that
> will make the example incomplete and irrelevant.

No, that doesn't sound right.

[...]

Kind regards
Uffe
