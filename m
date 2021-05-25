Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C68BC47084
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 07:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 592566141D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 May 2021 07:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhEYH50 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 May 2021 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhEYH5Z (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 May 2021 03:57:25 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94244C061574;
        Tue, 25 May 2021 00:55:54 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id eb9so15548944qvb.6;
        Tue, 25 May 2021 00:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yl4OCRlRmcAtp5Couav0LI2ZiZLwzvAGoLktfuL2BPk=;
        b=AZs9vA371763Gt7PV8In9Cx/J9OiUAch5VP0Sc2PnnEWWKI08ikfd74b21FiQi4joK
         0sz79A9TnJGs2gvhDQVg+fmWnlBgL2GFBnsuS6S/h1zbC02JbK6CR0432QCsDm7SkF8g
         UXDaV8qyfYeb5ErooVY6JkwTj+M5LdtBxAQ3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yl4OCRlRmcAtp5Couav0LI2ZiZLwzvAGoLktfuL2BPk=;
        b=CbdPMy/dp/GbAXpfhxpoSriSh8eS0wGRCFEqeAbCN/CDlrAPTOHP/KAO44nUFGuK2z
         zqxGQsGNSpZmePNt0LkVRooSwrdhO23cqplysNYYiAE7ubbyfqNUsWKtuZBja1BYxmtX
         udfi31Pmzqx72MnAJGzq9xV8LYQAwc7La/12uQrHNIMZNHHKGqVmMU3hvQq8OMwO9j2O
         29y/KQIc0qRXGvrkydSQvaMm0vnvUNushryL1WQWcj9RapE6hwwe1ODFcUAXO4Y8ACQY
         bkuGykOr0HN1UbWSO91qH5p+jEpNQxypMn0dR0I/+ZGXsQ+QofQUJWObhtYKBWS2B6eU
         +5vA==
X-Gm-Message-State: AOAM5313Pu3j4yvptJ9d0PmGdQChtxpCM1g+eDWN1l1lvUYfH1Os3wH3
        4WGnqavlvqVLjxkuC0p4kytaPBU5Q0oqTA54XrI=
X-Google-Smtp-Source: ABdhPJxi5BWYfe16W3K0oHvA+q/LdZiEoyQtjgpmU0M0/vawIdezpEoM84VyVuPMltZpChZ6PxBTLvdvGvuScxGL3IE=
X-Received: by 2002:ad4:5fcb:: with SMTP id jq11mr35355630qvb.61.1621929353765;
 Tue, 25 May 2021 00:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210524073308.9328-1-steven_lee@aspeedtech.com>
In-Reply-To: <20210524073308.9328-1-steven_lee@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 25 May 2021 07:55:41 +0000
Message-ID: <CACPK8XcfvUQD5xwb=2Va5Sr+bmaWfJMZkh61HK1=J1qLYc84zQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] mmc: sdhci-of-aspeed: Support toggling SD bus signal
To:     Steven Lee <steven_lee@aspeedtech.com>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        Hongwei Zhang <Hongweiz@ami.com>,
        Ryan Chen <ryan_chen@aspeedtech.com>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 May 2021 at 07:33, Steven Lee <steven_lee@aspeedtech.com> wrote:
>
> AST2600-A2 EVB has the reference design for enabling SD bus
> power and toggling SD bus signal voltage between 3.3v and 1.8v by
> GPIO regulators.
> This patch series adds sdhci node and gpio regulators in a new dts file
> for AST2600-A2 EVB.
> The description of the reference design of AST2600-A2 EVB is added
> in the new dts file.
>
> This patch also include a helper for updating AST2600 sdhci capability
> registers.

The device trees look good:

Reviewed-by: Joel Stanley <joel@jms.id.au>

I've applied patches 1-3 to the aspeed tree for v5.14. I made a little
fix to patch 3 as it needed to add the new device tree to the
makefile.

When I was testing on my A2 EVB I saw this:

[    1.436219] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 192 for 9 degrees of phase compensation at 1562500Hz,
clamping to tap 15
[    1.450913] sdhci-aspeed 1e750100.sdhci: Requested out of range
phase tap 963 for 45 degrees of phase compensation at 1562500Hz,
clamping to tap 15

Do you know what is happening there?

Cheers,

Joel
