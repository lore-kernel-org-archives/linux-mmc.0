From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC/RFT PATCH] mmc: core: activate pre-erased multiple write
 support for sd card
Date: Tue, 22 Aug 2017 11:05:56 +0200
Message-ID: <CAPDyKFp7RtUe69SqMmWrE5bK9Etr5ibAP5m_+1P-4N6o-uKCrA@mail.gmail.com>
References: <1502192699-9612-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:35099 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbdHVJF5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Aug 2017 05:05:57 -0400
Received: by mail-qt0-f175.google.com with SMTP id x36so25269636qtx.2
        for <linux-mmc@vger.kernel.org>; Tue, 22 Aug 2017 02:05:57 -0700 (PDT)
In-Reply-To: <1502192699-9612-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 8 August 2017 at 13:44, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> Per SD specification version 4.10, section 4.3.4, it says "pre-erased
> (ACMD23) will make a following Multiple Block Write operation faster
> compared to the same operation without preceding ACMD23". ACMD23 is
> mandatory for all sd cards and the spec also says "Command STOP_TRAN
> (CMD12) shall be used to stop the transmission in Write Multiple Block
> whether or not the preerase (ACMD23) feature is used."
>
> However current code only check to see if CMD23 is available. If not,
> it would fallback to open-ending mode. So this catch-all RFC patch
> is trying to activate ACMD23 support for SD cards when doing multiple
> write.
>
> I have been testing it for while with all different kinds of SD cards
> . But what makes me hesitate to submit a formal patch is that
>
> (1)
> If the SD card does support CMD23 as well as the host, then we don't
> use ACMD23 as I don't see *obvious* write performance boost for
> ACMD23 vs CMD23 when doing multiple write for most of the cards,
> although some of them do improve a little. So this makes me though that
> the behaviour of dealing with ACMD23 or CMD23 depends on the firmware
> designed.

Just so I get this right...

If the card supports CMD23, then you mean we are fine with the current
code as is?

However, if the card don't support CMD23, but ACMD23, $subject patch
*may* offer an improvement. Right?
That leads to yet another question. Are there many SD cards that don't
support CMD23 but ACMD23?

>
> (2)
> If enabling ACMD23 for SD cards, I did see a interesting thing that
> some of the cards fail to return to tran state even when the host
> fires CMD12 which meets the requirement of spec. When debugging, I saw
> these buggy cards was still in recv state and never changed. So I did
> some hack to trace the card status and fire CMD12 again if possible.
>
> (3)
> I test all of my SD cards at hand, and try to figure out if we benefit
> from ACMD23 vs open-ending multiple write. When using ACMD23, we fire
> extra ACMD23 which would lower the write performance theoretically,
> although I also didn't see any *obviuos* thoughput drop. The only
> visible benefit is that pre-erased multiple write is more 'stable'
> than open-ending multiple write, just as the same reason for why we
> prefer to use CMD23 instead of open-ending mode.

Overall, I wouldn't have any issues of enabling ACMD23 for SD cards -
if only it could be justified as providing an improved behavior.

I guess we will need more peoples opinion and help in test to understand better.

[...]

Kind regards
Uffe
