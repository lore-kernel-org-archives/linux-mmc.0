From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Enabling MMC BKOPs in kernel based on host caps
Date: Wed, 12 Oct 2016 09:58:51 +0200
Message-ID: <CAPDyKFqCg6kuTHhuMNmtZcL6+8wOTky+_8SsvedcPbPcaaoohA@mail.gmail.com>
References: <1475491384-15818-1-git-send-email-rk@ti.com> <74289549-5576-c4fc-5270-8820c8654bc5@rock-chips.com>
 <dfcdad0d-0780-0641-cb0a-46557334fa16@ti.com> <4cf40ed6-85c1-a879-ef7a-ff9d5c9b24fe@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34400 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754381AbcJLH6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Oct 2016 03:58:54 -0400
Received: by mail-wm0-f54.google.com with SMTP id c78so2086165wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Oct 2016 00:58:53 -0700 (PDT)
In-Reply-To: <4cf40ed6-85c1-a879-ef7a-ff9d5c9b24fe@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ravikumar <a0131654@ti.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ravikumar Kattekola <rk@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 12 October 2016 at 09:09, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 05/10/16 14:55, Ravikumar wrote:
>> Hi Shawn,
>>
>>
>> On Wednesday 05 October 2016 03:07 PM, Shawn Lin wrote:
>>> Hi Ravikumar,
>>>
>>> + Alex,
>>>
>>> =E5=9C=A8 2016/10/3 18:43, Ravikumar Kattekola =E5=86=99=E9=81=93:
>>>> Hi all,
>>>>     I=E2=80=99ve seen an eMMC failure due to pending background operat=
ions on a
>>>> certain OMAP device since bkops enable bit was not set.
>
> It is not clear what you are talking about. BKOPS_EN is
> one-time-programmable so you can just set when the device is provisioned.
>
> However BKOPS_EN does not really enable background operations.  It is an
> indication from the host to the card about whether the card may delay
> maintenance operations.  The definition is:
>
> "This field allows the host to indicate to the device if it is expected t=
o
> periodically manually start background operations by writing to the
> BKOPS_START field."
>
> Currently the kernel does not do periodic background operations, so havin=
g
> the kernel set BKOPS_EN would not make sense - even if it wasn't
> one-time-programmable.

Agree!

However, in cases when the BKOPS_EN bit has been set (in one way or
the other), this do becomes a problem as we currently only supports
urgent background operations.
Perhaps we should print a warning when BKOPS_EN is set during card
initialization, as this isn't currently supported.

>
>>>> Further investigation showed me that someone already posted patch to
>>>> enable Background operations in kernel  based on a host capability che=
ck
>>>> (Caps2 & BK_OPS_EN)
>>>> but was turned down quoting that it should be enabled from user space
>>>> using mmc-utils.
>>>>
>>>> Enabling this would add one additional check for exception event in th=
e
>>>> response R1 or R1B (only on hosts that explicitly set BK_OPS_EN in cap=
s2).
>>>> But not enabling this could lead to a system failure especially when t=
he
>>>> Filesystem is on eMMC and the card stops responding due to pending
>>>> critical bkops.
>
> Yes the kernel only does urgent background operations if BKOPS_EN is set.
> You seem to be suggesting that the cards are violating the specification =
by
> delaying maintenance operations even though they are not allowed to becau=
se
> BKOPS_EN is not set.  Is that the case?
>

If this is the case, the solution would probably be to actually set
the BKOPS_EN bit from the kernel, perhaps via using a card quirk.

Although, to do that, we first need to add proper background
operations support. I guess that is what Alex intends to do here [1].

[...]

[1]
http://www.spinics.net/lists/linux-mmc/msg38952.html

Kind regards
Uffe
