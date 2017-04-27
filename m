From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 07/16] mmc: sdhci-msm: Add get_min_clock() and
 get_max_clock() callback
Date: Thu, 27 Apr 2017 11:03:08 +0200
Message-ID: <CAPDyKFoHeuEpD3BmtTjsHEjz+w1dj0uD-OM3PokPpnTjNJ562A@mail.gmail.com>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <1479710246-26676-8-git-send-email-riteshh@codeaurora.org> <20170426214443.GA32019@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35527 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754419AbdD0JDK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Apr 2017 05:03:10 -0400
Received: by mail-qk0-f178.google.com with SMTP id f76so21953832qke.2
        for <linux-mmc@vger.kernel.org>; Thu, 27 Apr 2017 02:03:09 -0700 (PDT)
In-Reply-To: <20170426214443.GA32019@hector.attlocal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Pramod Gurav <pramod.gurav@linaro.org>, jeremymc@redhat.com, "# 4.0+" <stable@vger.kernel.org>

+Greg
-trimmed cc

On 26 April 2017 at 23:44, Andy Gross <andy.gross@linaro.org> wrote:
> On Mon, Nov 21, 2016 at 12:07:17PM +0530, Ritesh Harjani wrote:
>> This add get_min_clock() and get_max_clock() callback
>> for sdhci-msm. sdhci-msm min/max clocks may be different
>> hence implement these callbacks.
>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> This patch needs to be picked up for stable as 4.9 is currently broken w.r.t.
> MMC on Qualcomm platforms.
>
> Fixes: d84be51d1c1d ("mmc: sdhci-msm: Enable few quirks")
>
> Regards,
>
> Andy Gross

I did a quick investigation around this.

So for some reason Greg decided to pick up the original commit,
a0e3142869d2 ("mmc: sdhci-msm: Enable few quirks"), for 4.9 stable
[1], even if that patch wasn't sent or tagged for stable.
It was a mistake, as simple as that - and I should also have spotted
it when Greg posted his stable-review series, sorry.

For clarification, the original commit a0e3142869d2 ("mmc: sdhci-msm:
Enable few quirks"), is present in 4.10 together with $subject patch.
So the regression is present only in 4.9 stable.

Greg, can you pick up @subject patch for stable according to Andy's
suggestion or you want some of us to re-post it to stable?

Kind regards
Uffe

[1]
https://www.spinics.net/lists/stable/msg167259.html
