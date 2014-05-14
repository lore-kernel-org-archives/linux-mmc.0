From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Wed, 14 May 2014 08:08:20 -0700
Message-ID: <CAD=FV=XtELRaTxjHLRuHchWha9ku-i+ufdvfOAAmF1qkgno3nQ@mail.gmail.com>
References: <1399427558-8478-1-git-send-email-nsanders@chromium.org>
	<CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
	<CANEJEGt1-BYD2kaHJisQ=YBj6k4CJU5-7_bjW+M5TZ_yuMY_TQ@mail.gmail.com>
	<5285574.Jh25nVnT1D@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:50463 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbaENPIV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 11:08:21 -0400
Received: by mail-vc0-f171.google.com with SMTP id lc6so2603200vcb.2
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2014 08:08:20 -0700 (PDT)
In-Reply-To: <5285574.Jh25nVnT1D@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Grant Grundler <grundler@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Nick Sanders <nsanders@chromium.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>

Arnd,

On Wed, May 14, 2014 at 5:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I just stumbled over this thread. Looking at the callers of the
> execute_tuning() function, I see that all three come from non-atomic
> context. How about an add-on patch to turn the mdelay(1) into an
> msleep(1)? That would be much friendlier to other tasks running
> concurrently.

Even better if someone could tell us why the mdelay() was there to
begin with.  As I understand it Nick was confident that it wasn't
needed for eMMC.  He didn't _think_ it was needed for SD cards either
but it was safer to leave it there for SD cards since the delay wasn't
causing any known problems on them.

-Doug
