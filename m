From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH 0/4] mmc: core: Provide CMD5 awake and partial_init support
Date: Mon, 20 Feb 2017 12:39:21 +0100
Message-ID: <CAPDyKFrytpFeH5MCLO_GOrLE9YPbbVBTbrsROOF3G-iOu5a_HA@mail.gmail.com>
References: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:34121 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751436AbdBTLjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Feb 2017 06:39:22 -0500
Received: by mail-qk0-f174.google.com with SMTP id s186so92555088qkb.1
        for <linux-mmc@vger.kernel.org>; Mon, 20 Feb 2017 03:39:22 -0800 (PST)
In-Reply-To: <1487577792-12510-1-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Asutosh Das <asutoshd@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 20 February 2017 at 09:03, Ritesh Harjani <riteshh@codeaurora.org> wrote:
> As per JEDEC spec - CMD5 can be used to awake from sleep mode for emmc.
> This patch series provide CMD5(awake) + mmc_partial_init support to resume
> mmc card device. This is mainly to reduce the resume time.

I assume with "resume time" you don't mean "system PM resume time"?

The current approach we have for MMC is to postpone system PM resume
of the card until it's actually needed, thus via runtime PM instead.
Then the time it takes to re-initialize the eMMC don't affect the
system PM resume time at all.

Therefore I am wondering about how big of a problem this really is. Is
there a specific use case you are optimizing for?

>
> This was tested on db410c (emmc with HS200 mode) and MS8996 (emmc with HS400ES)
> based internal board. This patch reduced the resume time by ~50% on msm8996
> and ~11% on db410c.

The improved behaviour in percentage is very interesting, but I would
also like to see real numbers.

Moreover, I would like to know what kind of mechanism the
corresponding host drivers/controllers are using for card busy
detection?

>
> As of now this patch series provides a caps (MMC_CAP2_SLEEP_AWAKE) to enable this feature.
> Since there is no dependency on host platform for this, we can enable this feature by
> default as well. Thoughts?

I will look into the series in more detail, however we must not add a
corresponding DT binding for this as this isn't a HW configuration. I
guess what you need to know is that VCCQ stays powered on when the
card is a sleep, else waking up with CMD5 won't work
(MMC_CAP_FULL_PWR_CYCLE).

The current main concern I can think of, is whether the added
complexity to the wakeup path can be justified for the improved
behaviour.

>
>
> Ritesh Harjani (4):
>   Documentation: mmc: add mmc-sleep-awake
>   mmc: core: add mmc-sleep-awake caps
>   mmc: mmc: add support for CMD5 awake
>   mmc: core: Implement mmc_partial_init during resume
>
>  Documentation/devicetree/bindings/mmc/mmc.txt |   2 +
>  drivers/mmc/core/core.c                       |  13 +++
>  drivers/mmc/core/core.h                       |   1 +
>  drivers/mmc/core/host.c                       |   2 +
>  drivers/mmc/core/mmc.c                        | 160 ++++++++++++++++++++++++--
>  include/linux/mmc/card.h                      |   3 +
>  include/linux/mmc/host.h                      |   2 +
>  7 files changed, 176 insertions(+), 7 deletions(-)
>
> --
> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>

Kind regards
Uffe
