From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Fri, 7 Jan 2011 01:40:23 +0200
Message-ID: <AANLkTi=LcHr8knjZJjFv-OgV1nnQj7WQNn_FzRx1EXsp@mail.gmail.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
 <1294175416-12358-3-git-send-email-ohad@wizery.com> <4D239AAF.6090202@csr.com>
 <AANLkTikKDkE8eoRct_DN++dRTZ8uEMqUKN2GZdCngRKQ@mail.gmail.com>
 <AANLkTinEWsYBqgchwbjT2ZnoVYPcibJDF2Jt3v1AysUt@mail.gmail.com> <4D23A794.8020106@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f194.google.com ([209.85.210.194]:39465 "EHLO
	mail-iy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab1AFXkn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Jan 2011 18:40:43 -0500
Received: by iyf40 with SMTP id 40so7602448iyf.1
        for <linux-mmc@vger.kernel.org>; Thu, 06 Jan 2011 15:40:43 -0800 (PST)
In-Reply-To: <4D23A794.8020106@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Jan 5, 2011 at 1:04 AM, David Vrabel <david.vrabel@csr.com> wro=
te:
> This would cause regressions on boards that aren't properly designed =
and
> have omitted the pull-up. =A0Are there boards like this?

I'm not sure there are.

All hosts shall provide pull-up resistors on all data lines DAT[3:0]
as described in section 6 of the SD physical specification. A board
that doesn't pull up DAT3, and instead relies on the card's internal
pull-up, sound very quirky to me.

So we might really be able to unconditionally disable the card's DAT3
internal pull-up. We can do that for cards that specifically want it,
or, we can even consider a bolder approach where we do that for all
the nonremovable SDIO cards (which therefore don't need the card
detection functionality anyway).

What do you think ?

Thanks,
Ohad.
