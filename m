From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: RFC: 32-bit __data_len and REQ_DISCARD+REQ_SECURE
Date: Wed, 28 Oct 2015 18:15:51 -0400
Message-ID: <x49pozyljvs.fsf@segfault.boston.devel.redhat.com>
References: <CANEJEGvXfg4O6KWBcQe4=o0ZxjehgGTBMBxNddanprBXQbr-Qg@mail.gmail.com>
	<CANEJEGtDr+BdP1s=EUpUSqcvWpQfkt+o_3zoXWHk7DdjH4j0Ow@mail.gmail.com>
	<CANEJEGukOKUgRJNPVaeEXpx-REzj8ooSfWdrnRMMCQr6EVaNqQ@mail.gmail.com>
	<CANEJEGvktCkVEbLaQoZqOFZY3F8o=Z41HwQxL=X4jh=-PdV3Fg@mail.gmail.com>
	<CANEJEGuwymF-v7rdep4h2eGcvCAzEVvaYtwHCim9UR5NLZPkbg@mail.gmail.com>
	<x49si55v04n.fsf@segfault.boston.devel.redhat.com>
	<CAPDyKFpXtio5m6V1M5QQcB1RNt4JtoDZ2qL2FqLDDNV4aODVAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752902AbbJ1WPx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 18:15:53 -0400
In-Reply-To: <CAPDyKFpXtio5m6V1M5QQcB1RNt4JtoDZ2qL2FqLDDNV4aODVAg@mail.gmail.com>
	(Ulf Hansson's message of "Wed, 21 Oct 2015 11:00:57 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Grant Grundler <grundler@chromium.org>, Jens Axboe <axboe@kernel.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Gwendal Grignou <gwendal@chromium.org>

Ulf Hansson <ulf.hansson@linaro.org> writes:

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

Thanks Ulf.  After reading all of the linked discussions, it's my
understanding that this is an emmc-specific issue that doesn't require
any block layer changes.  If that's wrong, please let me know.

Cheers,
Jeff
