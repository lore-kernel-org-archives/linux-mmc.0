From: Grant Grundler <grundler@chromium.org>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Wed, 21 Oct 2015 10:06:40 -0700
Message-ID: <CANEJEGtkus69nYum=NFqrZq3tbhLumiygsq-SK3KkJrVm6npJQ@mail.gmail.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
	<CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
	<CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com>
	<CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
	<CANEJEGuwymF-v7rdep4h2eGcvCAzEVvaYtwHCim9UR5NLZPkbg@mail.gmail.com>
	<x49si55v04n.fsf@segfault.boston.devel.redhat.com>
	<CAPDyKFpXtio5m6V1M5QQcB1RNt4JtoDZ2qL2FqLDDNV4aODVAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f182.google.com ([209.85.160.182]:34486 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbJURGm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2015 13:06:42 -0400
Received: by ykdr3 with SMTP id r3so55991855ykd.1
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2015 10:06:41 -0700 (PDT)
In-Reply-To: <CAPDyKFpXtio5m6V1M5QQcB1RNt4JtoDZ2qL2FqLDDNV4aODVAg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jeff Moyer <jmoyer@redhat.com>, Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>

On Wed, Oct 21, 2015 at 2:00 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
....
>>>> To put a few more numbers on the "chunk size vs perf":
>>>>  1EG (512KB) -> 44K commands -> ~20 minutes
>>>> 32EG (16MB) -> 1375 commands -> ~1 minute
>>>> 128EG (64MB) -> 344 commands -> ~30 seconds
>>>> 8191EG (~4GB) -> 6 commands -> 2 seconds + ~8 seconds mkfs
>>>> (I'm assuming times above include about 6-10 seconds of mkfs as part
>>>> of writing a new file system)
>>>>
>>>> This is with only ~300MB of data written to the partition. I'm fully
>>>> aware that times will vary depending on how much data needs to be
>>>> migrated (and in this case very little or none). I'm certain the
>>>> difference will only get worse for the smaller the "chunk size" used
>>>> to Secure Erase due to repeated data migration.
....
> I am not sure if this issue is the same as been discussed earlier on
> the mmc list regarding "discard/erase".
>
> Anyway, there have been several attempts to fix bugs related to this.
> One of these discussion kind of pointed out a viable solution, but
> unfortunate no patches that adopts that solution have been posted yet.
>
> You might want to read up on this.
> https://www.mail-archive.com/linux-mmc@vger.kernel.org/msg23643.html
> http://linux-mmc.vger.kernel.narkive.com/Wp31G953/patch-mmc-core-don-t-return-1-for-max-discard
>
> So this is an old issue, which should have been fixed long long long time ago...

Agreed. :)  I'll read the references but hope that Gwendal (or someone
on Android Team?) can follow up on this shorter term. I've moved to a
different team (Google Onhub) and currently have a whole new set of
(wireless) issues to deal with. :(

At some point I expect I'll be circling back to mmc issues - storage
keeps following me like a hungry puppy where ever I go. /o\

thank you!
grant
