From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: replacing hardcoded value for runtime PM suspend
Date: Thu, 13 Oct 2016 09:36:00 +0200
Message-ID: <CAPDyKFo=xUkGvqghr3zFB_anvzVQDJgkjFziveceQ+jpjjxdbQ@mail.gmail.com>
References: <1472739890-3384-1-git-send-email-alex.lemberg@sandisk.com>
 <1472739890-3384-2-git-send-email-alex.lemberg@sandisk.com>
 <cc6129e7-5250-8c2e-73e0-1134e2a7146d@rock-chips.com> <2D82096E-231C-43BA-801D-381F8191F26C@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qt0-f176.google.com ([209.85.216.176]:33536 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbcJMHoQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Oct 2016 03:44:16 -0400
Received: by mail-qt0-f176.google.com with SMTP id s49so32980536qta.0
        for <linux-mmc@vger.kernel.org>; Thu, 13 Oct 2016 00:44:15 -0700 (PDT)
In-Reply-To: <2D82096E-231C-43BA-801D-381F8191F26C@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>

On 4 September 2016 at 15:30, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote=
:
> Hi Shawn,
>
> On 9/2/16, 10:39 AM, "Shawn Lin" <shawn.lin@rock-chips.com> wrote:
>
>>Hi
>>
>>On 2016/9/1 22:24, alex lemberg wrote:
>>> Add MMC_AUTOSUSPEND_DELAY_MS define
>>
>>I'm thinking should we expose it to userspace
>>via sysfs, since I don't know why it should be 3ms, not 4ms, 5ms, etc.
>
> Agree, we can consider exposing it to the user space.
> The exposure to the user space is less critical to the current
> patchset, but we can do it as a =E2=80=9Cfollow-up change=E2=80=9D once i=
ts approved.

No need for that, is already available for user-space. :-)

Each device with runtime PM autosuspend enabled, allows userspace to
change the delay via the "autosuspend_delay_ms" sysfs file.

Kind regards
Uffe
