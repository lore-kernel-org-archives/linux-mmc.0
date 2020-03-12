Return-Path: <SRS0=Im6a=45=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDCC4CECE
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872C2206E7
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Mar 2020 14:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PL0NMlFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgCLOHa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:07:30 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45676 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLOH2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2020 10:07:28 -0400
Received: by mail-vs1-f67.google.com with SMTP id x82so3720042vsc.12
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2020 07:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buBSO5k2b4C3kXNX/XPJLGtnWR4DhQhQeL2M9/aAXBc=;
        b=PL0NMlFZDgWMBsxgRB2pgKNVkX0QVKlDI0Zgo8PzJZAAqc8i0og3nDOyzEF9+WQtsw
         SC9zrMXfzEX+sEZ3IeFjJQZVBShaMrVOCy2podIC8PitQXH2UCd3sRPjKxbiK+kdwAJ8
         uga1GbAAMTawwtIWkMjWNKsKhaiEzxvbd2ningh9nfW8kluStifKW2zIib2FqduaatD5
         aEi2/9tviHac2S6Rn8F+elUSfTJUMvml6l9LH8mhHDrGWgogrDC57/vaZP5XvoFy+U4y
         WH92eQQiU3LyrEJAzS+mhy526Cg2yWgTtLo5T3AXeS949FRQuBZ0FSBNuU6U8XMeBb9q
         Ba1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buBSO5k2b4C3kXNX/XPJLGtnWR4DhQhQeL2M9/aAXBc=;
        b=ZN8RqR0ICSrFOZs4wMYOadblVDrei+qNs8E7GPvvOU0V+4WQM/JaF/v38lL39NV4v5
         iwKpnEQebrPuaxUrjfJwa2XsBDu1Ov6K9tGXXZl1oyCid08WI50TEk41+UNXnql2gz0c
         AuH5KSZ0UdTHbq0gbPknUQ11Xds22QnicEl3kk8lXvUGjZh5QDf7WpDJije6eXjvHTn8
         WS+ag0k7guHc2jg+3YAc82scoNnrGtjwRORQ/b7gZ6tPv/f7ZRANp0kOSeb51pJcbkJ7
         0mneQ521QPQUJWucx9ojBhw8HgTc0L3r800tvAu31t/dGJckDb/t7/34fSJlNb6lY5Q8
         wCIw==
X-Gm-Message-State: ANhLgQ3wBagJaHcqaZy0YDw+ndz1dJuH+YCd4o3HRTGLDGaMncQ1ogb3
        my+CX8fFFN6pD5fLI5CtibJTpqk3YlBEqFgs2omAyg==
X-Google-Smtp-Source: ADFU+vvKK/JxbKesCpiaMAfl5MC6dMr3G/EvpE0o1cQyilJQELyMRXAEvEhzVVgWT69tflBxzZwNt+1+f4g7iLxY3Ow=
X-Received: by 2002:a67:2ec6:: with SMTP id u189mr5576185vsu.200.1584022045458;
 Thu, 12 Mar 2020 07:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200306174413.20634-1-nsaenzjulienne@suse.de>
 <CAPDyKFp+XwGog_w+8Sv1hYA-Umi6Rt2LYR1fyMEEb9abdb9nGQ@mail.gmail.com> <a51badd7ba6fc1938a120b8a3b8a423ca9a3613b.camel@suse.de>
In-Reply-To: <a51badd7ba6fc1938a120b8a3b8a423ca9a3613b.camel@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 12 Mar 2020 15:06:47 +0100
Message-ID: <CAPDyKFprX9cLXxGQJ9E8H_A-PfWYyrL3SShuJi7-M1KobGWrEQ@mail.gmail.com>
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

On Thu, 12 Mar 2020 at 14:13, Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Ulf,
>
> On Thu, 2020-03-12 at 14:08 +0100, Ulf Hansson wrote:
> > On Fri, 6 Mar 2020 at 18:44, Nicolas Saenz Julienne
> > <nsaenzjulienne@suse.de> wrote:
> > > The series first cleans up a common pattern, which is ultimately needed
> > > to integrate the regulator with bcm2711's sdhci-iproc. It then
> > > introduces the relevant device-tree changes.
> > >
> > > ---
> > >
> > > Changes since v1:
> > >  - Use helper function istead of quirk
> > >  - Add GPIO label
> > >
> > > Nicolas Saenz Julienne (11):
> > >   mmc: sdhci: Introduce sdhci_set_power_and_bus_voltage()
> > >   mmc: sdhci: arasan: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: milbeaut: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: at91: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: pxav3: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: xenon: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: am654: Use sdhci_set_power_and_voltage()
> > >   mmc: sdhci: Unexport sdhci_set_power_noreg()
> > >   mmc: sdhci: iproc: Add custom set_power() callback for bcm2711
> > >   ARM: dts: bcm2711: Update expgpio's GPIO labels
> > >   ARM: dts: bcm2711: Add vmmc regulator in emmc2
> > >
> > >  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 13 ++++++++++++-
> > >  drivers/mmc/host/sdhci-iproc.c        | 17 ++++++++++++++++-
> > >  drivers/mmc/host/sdhci-milbeaut.c     | 13 +------------
> > >  drivers/mmc/host/sdhci-of-arasan.c    | 15 ++-------------
> > >  drivers/mmc/host/sdhci-of-at91.c      | 18 +-----------------
> > >  drivers/mmc/host/sdhci-pxav3.c        | 20 +-------------------
> > >  drivers/mmc/host/sdhci-xenon.c        | 20 +-------------------
> > >  drivers/mmc/host/sdhci.c              | 24 +++++++++++++++++++++---
> > >  drivers/mmc/host/sdhci.h              |  5 +++--
> > >  drivers/mmc/host/sdhci_am654.c        | 17 +++--------------
> > >  10 files changed, 61 insertions(+), 101 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Patch 1-4, 6, 9 applied for next, thanks!
>
> I think you meant to apply 1-4, 7 and 9. Patch 6 is one of the contentious
> ones.

Yes, that's what I did, but told you about 6. :-)

Thanks and sorry for the noise.

Kind regards
Uffe
