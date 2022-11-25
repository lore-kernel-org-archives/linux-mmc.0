Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF685C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Nov 2022 12:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKYMC1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Nov 2022 07:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKYMC0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2022 07:02:26 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053331F93
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2022 04:02:24 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id a1-20020a17090abe0100b00218a7df7789so7514040pjs.5
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2022 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rA7jP7DElPEidVByHnf5wE7T1KK+zH9PCClJosnrZb0=;
        b=Q4itDm8eMoY3Z7onnN9UDYJexlhjMsGcsqqpzOXWIaXyN2oQyWZ/4ut0q6KzOWfhxN
         RVf1e/cFyffAFHc/Nek1T2ouOyR6k9YmpiupAb4Q6cbMXZLCon32Lr1Jzo7o9/UVE4TM
         UqZ5ZY7ZoxSYMLYeq7nyQDn9VFJcJbu3UGMYNzLTAsKfSu+IE3wpKbjf/wOK9VNuPDzT
         14tINsJPO2H+mdRNkQWD+rdWdWp/gvdw+juRhGHpcJz3YNSFbWfm/y0XfVglCzkwmEBf
         CcZAxVpo5UucdmKHchjVV+y6XS8HZOf887Ci6SVjZuQGMaKKi095vKSFlkHGgewDMbNu
         ePHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rA7jP7DElPEidVByHnf5wE7T1KK+zH9PCClJosnrZb0=;
        b=8AgoLr84/2XGtDpjP4oDmb45ECwNsGZBRZzbE+ltIdXVUl725C7RlNbU7RxhhsEM7w
         MtAhqYX0cSgtT4/7cc/myeIpgrKUCq4HyvvjFc4ct8HomHSFPKJ+ExYj2SaPs2ViASQu
         L+S/ALsjejGkGdGEjfHgqWdg1h+tkIW2KcynSwrofY3DxdnSvXlNAJoRCYHIcsfAXHKU
         yCycu2IwlWgHpXz0Mx9WJ4jFmIYUA4VQMPwXBFUeAdPaceCpRrGqOFG+iqWZGraj/0pL
         73g+m9PftMNmb0xfB/8rJyXqhpnvrfH1XyIE/SBXjVaiHF5UrcZYbmZFJ6IGPo9FQyZP
         fv0g==
X-Gm-Message-State: ANoB5pndKgcq8tambPM118XaH8hheGCylFsFNGGNUoCbOBNt3CnCW6gZ
        LWlA3iK7zYgYd6NHgQqxdaX+5nj4u94VmtxHYvT5zA==
X-Google-Smtp-Source: AA0mqf7cFB6agKaKGSFfWKi/sVlJDT6bBUOneDv91yFf+vofRFlu/o0biAXbanZW5J4ZacSIqOiv4Lr4bvM239rExF0=
X-Received: by 2002:a17:90b:1d45:b0:218:6db5:fd98 with SMTP id
 ok5-20020a17090b1d4500b002186db5fd98mr41482120pjb.164.1669377744386; Fri, 25
 Nov 2022 04:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20221124170649.63851-1-adrian.hunter@intel.com> <20221124170649.63851-2-adrian.hunter@intel.com>
In-Reply-To: <20221124170649.63851-2-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Nov 2022 13:01:47 +0100
Message-ID: <CAPDyKFoie+qmoJ=szfFRpAvSBOtYO0OKjM+0aiCdkTUsb3zpEw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: sdhci: Fix voltage switch delay
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Sarthak Garg <quic_sartgarg@quicinc.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Prabu Thangamuthu <prabu.t@synopsys.com>,
        Manjunath M B <manjumb@synopsys.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Hu Ziji <huziji@marvell.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris <briannorris@chromium.org>,
        Wenchao Chen <wenchao.chen@unisoc.com>,
        Chevron Li <chevron.li@bayhubtech.com>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Nov 2022 at 18:07, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Commit 20b92a30b561 ("mmc: sdhci: update signal voltage switch code")
> removed voltage switch delays from sdhci because mmc core had been
> enhanced to support them. However that assumed that sdhci_set_ios()
> did a single clock change, which it did not, and so the delays in mmc
> core, which should have come after the first clock change, were not
> effective.
>
> Fix by avoiding re-configuring UHS and preset settings when the clock
> is turning on and the settings have not changed. That then also avoids
> the associated clock changes, so that then sdhci_set_ios() does a single
> clock change when voltage switching, and the mmc core delays become
> effective.
>
> To do that has meant keeping track of driver strength (host->drv_type),
> and cases of reinitialization (host->reinit_uhs).
>
> Note also, the 'turning_on_clk' restriction should not be necessary
> but is done to minimize the impact of the change on stable kernels.
>
> Fixes: 20b92a30b561 ("mmc: sdhci: update signal voltage switch code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

[...]

> @@ -2335,6 +2362,18 @@ void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         host->ops->set_bus_width(host, ios->bus_width);
>
> +       /*
> +        * Special case to avoid multiple clock changes during voltage
> +        * switching.
> +        */
> +       if (!reinit_uhs &&
> +           turning_on_clk &&
> +           host->timing == ios->timing &&
> +           host->version >= SDHCI_SPEC_300 &&
> +           (host->preset_enabled || host->drv_type == ios->drv_type) &&
> +           (host->preset_enabled || !sdhci_preset_needed(host, ios->timing)))

This caught my eyes, as it looks a bit messy. Not sure if it's
possible to simplify, but the last two lines could be replaced with:

(host->preset_enabled ||
(host->drv_type == ios->drv_type && !sdhci_preset_needed(host, ios->timing))))

But, I am not sure that really helps...

[...]

Kind regards
Uffe
