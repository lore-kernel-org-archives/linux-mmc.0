From: Nick Sanders <nsanders@chromium.org>
Subject: Re: [PATCH] mmc: sdhci: remove mdelay in eMMC tuning
Date: Wed, 7 May 2014 15:01:15 -0700
Message-ID: <CANvYXzicMyhS2eQ=+ziF=RNR1iP8-vbdyhTBe2jCbVbDDxE5sA@mail.gmail.com>
References: <1399427558-8478-1-git-send-email-nsanders@chromium.org> <CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:51194 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaEGWBg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 May 2014 18:01:36 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so2148726vcb.5
        for <linux-mmc@vger.kernel.org>; Wed, 07 May 2014 15:01:35 -0700 (PDT)
In-Reply-To: <CAPDyKFpsm_M2oY3OuVHZ-MCNezT6xwo-HPwfo1pxfrw5ySKfOg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>, Grant Grundler <grundler@chromium.org>, Doug Anderson <dianders@chromium.org>, Chang-Eun Choi-SSI <cu.choi@ssi.samsung.com>

On Wed, May 7, 2014 at 1:35 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Aha, so you are actually using "MMC_CAP_RUNTIME_RESUME" here - cool :-).
>
> I suppose those patches that enables the "cap" has not reached
> mainline yet. Any plans on sending them?

I am actually running 3.10, so MMC_CAP_RUNTIME_RESUME isn't used yet.
sdhci-acpi.c is enabling runtime pm for my device, and there are no
caps checks otherwise.
