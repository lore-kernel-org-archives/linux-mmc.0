From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v9 00/16] mmc: sdhci-msm: Add clk-rates, DDR, HS400 support
Date: Wed, 23 Nov 2016 09:32:10 +0100
Message-ID: <CAPDyKFrSFwBv-uA4Ov_1a2wxpiGZFBDN5wKGn+r63Y9H-UcLYQ@mail.gmail.com>
References: <1479710246-26676-1-git-send-email-riteshh@codeaurora.org>
 <CAPDyKFrRbf0+G5K=-jsaevAGbTqhTAss2zJv3QdiyCrv0BG-zA@mail.gmail.com> <20161123050038.GD16531@hector.attlocal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37009 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbcKWIcN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2016 03:32:13 -0500
Received: by mail-wm0-f50.google.com with SMTP id t79so11966947wmt.0
        for <linux-mmc@vger.kernel.org>; Wed, 23 Nov 2016 00:32:12 -0800 (PST)
In-Reply-To: <20161123050038.GD16531@hector.attlocal.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: Ritesh Harjani <riteshh@codeaurora.org>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Lin <shawn.lin@rock-chips.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, David Brown <david.brown@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Georgi Djakov <georgi.djakov@linaro.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Asutosh Das <asutoshd@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Venkat Gopalakrishnan <venkatg@codeaurora.org>, Rajendra Nayak <rnayak@c>

On 23 November 2016 at 06:00, Andy Gross <andy.gross@linaro.org> wrote:
> On Mon, Nov 21, 2016 at 11:06:13AM +0100, Ulf Hansson wrote:
>> On 21 November 2016 at 07:37, Ritesh Harjani <riteshh@codeaurora.org> wrote:
>> > Hi,
>> >
>> > This is v9 version of the patch series which adds support for MSM8996.
>> > Adds HS400 driver support as well.
>> > These are tested on internal msm8996 & db410c HW.
>> >
>> > The patch series is ready. Do we think we can apply these
>> > patches for next now?
>>
>> I guess the DTS changes can be picked up by Andy, so they can go via arm-soc?
>
> Yeah I'll pick up the DTS change and the Documentation change.

Andy, I would rather like to pick the DT Documentation change via my
mmc tree. Just because I normally do that.

This one:
[PATCH v9 05/16] dt-bindings: sdhci-msm: Add xo value

Kind regards
Uffe
