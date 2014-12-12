From: Doug Anderson <dianders@chromium.org>
Subject: Re: regression on rk3288 with - mmc: dw_mmc: Remove old card detect infrastructure
Date: Fri, 12 Dec 2014 15:54:15 -0800
Message-ID: <CAD=FV=VfnXHpZiTMh8+WHyEQ=N0cVNrDLLjmU+xC1ne-uYbuEQ@mail.gmail.com>
References: <8867707.LK6gZlxufx@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:48858 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbaLLXyQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Dec 2014 18:54:16 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so4098717vcb.29
        for <linux-mmc@vger.kernel.org>; Fri, 12 Dec 2014 15:54:15 -0800 (PST)
In-Reply-To: <8867707.LK6gZlxufx@phil>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On Fri, Dec 12, 2014 at 12:22 PM, Heiko St=C3=BCbner <heiko@sntech.de> =
wrote:
> Hi,
>
> when trying linux-next for 20141210 on my rk3288 eval board I got err=
ors
> when ejecting sd cards. Especially a timeout for a command and follow=
ing
> this an rcu stall which essentially stops everything [0].
>
> My way to reproduce the issue is:
> - boot into an initramfs
> - insert card
> - remove card
> - boom
>
> It happens 100% of the time on the first removal of the card.
>
>
> Bisecting the issue brought me to
>
> first bad commit
> 6130e7a9c34d01afbd4e7e215846d1f2d70333bb
> mmc: dw_mmc: Remove old card detect infrastructure
>
> and indeed if I revert this one, card ejection works again - also mul=
tiple
> times in a row. Affected machine is a rk3288-evb-rk808 board which
> currently uses the internal card-detect mechanism of the dw_mmc and
> relevant git history (--oneline) is:
>
> 864de9b Revert "mmc: dw_mmc: Remove old card detect infrastructure"
> 5bd48e0 ARM: dts: Bump SD card pin drive strength up on rk3288-evb
> 12fd072 Add linux-next specific files for 20141210
> ...
>
>
> I'll try to dig deeper, but if anybody has ideas beforehand I would a=
lso
> be very glad.

I tried to reproduce this on the same board on 20141211.  I have a
different bootloader, but I hope that doesn't matter?

git describe
next-20141211-1-gf8afbb8

$ git log --oneline next-20141211~..
f8afbb8 FROMLIST: ARM: dts: Bump SD card pin drive strength up on rk328=
8-evb
291ca61 Add linux-next specific files for 20141211


In inserted 3 different cards into the SD card slots (a micro UHS, an
older micro one, and a full sized UHS).  I inserted / ejected each one
several times.

Could it be a different set of kernel config options?  That's about
the best guess I can come up with...
