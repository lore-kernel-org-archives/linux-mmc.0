From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: core: use card pointer as the first parameter of execute_tuning()
Date: Fri, 30 Jan 2015 17:08:36 -0800
Message-ID: <CAD=FV=UUGzQm7rdzsTHaKSA=ywONz5VzVubEsT4bz7TPm0smfA@mail.gmail.com>
References: <1422271175-19445-1-git-send-email-addy.ke@rock-chips.com>
	<1422271175-19445-2-git-send-email-addy.ke@rock-chips.com>
	<CAPDyKFp=5epMggHu0+u_LU7ETujcoeP2xOpB7iD6JF2bs8BnEA@mail.gmail.com>
	<CAD=FV=X9x0gW5TyLi4ERm8nxixQB__Y=5bRAtOax-_w+T33rCg@mail.gmail.com>
	<CAPDyKFqjG=yxDcwnk4jbXMZ05hMkWR2x37uVpRNd_11-eB4G7w@mail.gmail.com>
	<CAD=FV=VQg+sQUpgbKw7Zz=-f+jPM=6O-+3gUpohWhj8JeSPu6Q@mail.gmail.com>
	<CAPDyKFqjY-Sn2mNqjy1FH3RPFuJSfhTX_esQDao1Yb4qumHYcg@mail.gmail.com>
	<CAD=FV=XCBebTzWpNPn9GaTRU3O1BMurhoTDWcXHYXBChBRnOjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:42571 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757391AbbAaBIo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jan 2015 20:08:44 -0500
Received: by mail-ie0-f181.google.com with SMTP id rp18so7161113iec.12
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2015 17:08:43 -0800 (PST)
In-Reply-To: <CAD=FV=XCBebTzWpNPn9GaTRU3O1BMurhoTDWcXHYXBChBRnOjQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, "tgih.jun@samsung.com" <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>

Hi,

On Thu, Jan 29, 2015 at 4:13 PM, Doug Anderson <dianders@chromium.org> wrote:
> I still don't exactly have a warm fuzzy about using the send_status()
> command like this, but it seems to work (actually, I should verify
> that myself--I've been taking Addy's word that his solution works).

So I finally started up a stress test.  I picked Addy's patch and
reverted my big fat delay.  Result was that Addy's patch doesn't seem
to hurt but once I revert my big fat delay then I seem to start
getting failures.  :(  I think it's actually on a different SD card
than the one that was originally causing failures, FWIW.

As usual with these kinds of tests, I'd like to test this a whole lot
more since it only reproduces sometimes, but unfortunately I'm going
to be unavailable for a few weeks starting from today, so I'm not sure
I'm not sure I can do more debugging / testing than what I've already
done...

...but unless using send_status allows us to remove the delay (or
unless there's some other justification for it) then it seems like we
should just drop this series...
