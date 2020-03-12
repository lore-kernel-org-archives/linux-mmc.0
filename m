Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FACC10DCE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CFA0206BE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 13:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NeWi4sT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgCLNJN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:09:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:37258 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbgCLNJM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 09:09:12 -0400
Received: by mail-ua1-f65.google.com with SMTP id h32so2080089uah.4
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyzsKuloOrXeAT1eDgIMEyFoe/19CJB+RPiJ8KPwQIw=;
        b=NeWi4sT4tcbOtVyLPuM+OlmGb0SVww73M2/R4+x0yevjrTcctku9ZniQ0wxvDpbhJ3
         I4R/OYEqZArLPzoutN66dWfc7JJ37NZL/mNx9nxoeLvvnrgJEWcc1CXVMf+zn3Au+w3U
         okoA4mIsV2nkwV65aXMAwIswdl64TXCOqmu4YYKwjkzos3miKzEHnZ+GpHOuYx7uLGaE
         zHIWyCppm77BMtgL6QzXZ1Hmzbggl/6H03ugd/cIfkOT8qbVLz6/gLHeUuFfSjA9Xeoa
         MPG4tdiKgMXWO+eh5rsKNsC90o+9x14NA86uN0lqIQ3Mf/DoxgdetNVvKcjGiJ0mRcBA
         R3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyzsKuloOrXeAT1eDgIMEyFoe/19CJB+RPiJ8KPwQIw=;
        b=K/LbY5XJ7nl60c2kKY5LbqB0zERiWGGKGOXQxZJbsv8EHeFU2YMrvSjB/2l6Ju1fUO
         EQVl9ZbBK4ussqDzs5bXbE++Xe1XdVeSIAJyYo+qxR2ldqOlIpq9lntCcBAsKeDkGWN1
         5L0BGO+LNHGGMEAkAyrWrz54rx3fDqRt+job+0VUDLF7GWInnTaJA4D5bjt+mkFaBTeP
         hGu8gDpqlPM53Y+o8qrJSrNU5JmGVsan7mvmFGiHzmkBSOUF/K7HxwdTWjo3COfKhA2y
         bQUmhiYxId0ysknc1y68peOrBhED123vi5q0UuhJGFT8BOMBqZ+KSirYuVcwlgKMy68Q
         vt1Q==
X-Gm-Message-State: ANhLgQ1Ywyt/F44ALa5su/JRtOcoH6fBkG5ngoMYrMIix2x08adQLhJa
        DllDPiZNXIL9EK9faILAwjbiUx5hokvI6makJc+JmA==
X-Google-Smtp-Source: ADFU+vvpfThPEsySr4RvSlP6UPDA5AYK/x2Ak/VHoJ9GoNUgCMWeZ+k5a42yKU7sePemyrIkQzJo3xMLVDtx8jEJPkw=
X-Received: by 2002:ab0:7381:: with SMTP id l1mr4821390uap.104.1584018547554;
 Thu, 12 Mar 2020 06:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
In-Reply-To: <20200306174413.20634-1-nsaenzjulienne@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 14:08:31 +0100
Message-ID: <CAPDyKFp+XwGog_w+8Sv1hYA-Umi6Rt2LYR1fyMEEb9abdb9nGQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] Raspbery Pi 4 vmmc regulator support
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        phil@raspberrypi.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Mar 2020 at 18:44, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> The series first cleans up a common pattern, which is ultimately needed
> to integrate the regulator with bcm2711's sdhci-iproc. It then
> introduces the relevant device-tree changes.
>
> ---
>
> Changes since v1:
>  - Use helper function istead of quirk
>  - Add GPIO label
>
> Nicolas Saenz Julienne (11):
>   mmc: sdhci: Introduce sdhci_set_power_and_bus_voltage()
>   mmc: sdhci: arasan: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: at91: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: pxav3: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: xenon: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: am654: Use sdhci_set_power_and_voltage()
>   mmc: sdhci: Unexport sdhci_set_power_noreg()
>   mmc: sdhci: iproc: Add custom set_power() callback for bcm2711
>   ARM: dts: bcm2711: Update expgpio's GPIO labels
>   ARM: dts: bcm2711: Add vmmc regulator in emmc2
>
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 13 ++++++++++++-
>  drivers/mmc/host/sdhci-iproc.c        | 17 ++++++++++++++++-
>  drivers/mmc/host/sdhci-milbeaut.c     | 13 +------------
>  drivers/mmc/host/sdhci-of-arasan.c    | 15 ++-------------
>  drivers/mmc/host/sdhci-of-at91.c      | 18 +-----------------
>  drivers/mmc/host/sdhci-pxav3.c        | 20 +-------------------
>  drivers/mmc/host/sdhci-xenon.c        | 20 +-------------------
>  drivers/mmc/host/sdhci.c              | 24 +++++++++++++++++++++---
>  drivers/mmc/host/sdhci.h              |  5 +++--
>  drivers/mmc/host/sdhci_am654.c        | 17 +++--------------
>  10 files changed, 61 insertions(+), 101 deletions(-)
>
> --
> 2.25.1
>

Patch 1-4, 6, 9 applied for next, thanks!

Kind regards
Uffe
