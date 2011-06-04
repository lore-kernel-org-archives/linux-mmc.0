From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sat, 4 Jun 2011 13:33:00 +0300
Message-ID: <BANLkTinQ_H6eseqHkcmc7MUa+d4cdxwr_g@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com> <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57509 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755821Ab1FDKdV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Jun 2011 06:33:21 -0400
Received: by wwa36 with SMTP id 36so2404691wwa.1
        for <linux-mmc@vger.kernel.org>; Sat, 04 Jun 2011 03:33:20 -0700 (PDT)
In-Reply-To: <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sat, Jun 4, 2011 at 1:18 PM, Daniel Drake <dsd@laptop.org> wrote:
> Digging further, in the pm_runtime_get_sync() call we reach
> rpm_resume() in drivers/base/power where we hit:
>
> =A0 =A0 =A0 =A0else if (dev->power.disable_depth > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D -EAGAIN;
>
> Not sure what this means. Any thoughts?

It means runtime PM is disabled for your device.

Which doesn't make sense, assuming you had MMC_CAP_POWER_OFF_CARD
configured (if you didn't, you wouldn't end up calling runtime PM api
at all).

If you post your entire diff, I might be able to spot what's wrong.

As a side note, if the additional CMD5 arg=3D0 fixes both sd8686's and
b43's issues, we might consider removing MMC_CAP_POWER_OFF_CARD
entirely. But let's not rush with that yet.
