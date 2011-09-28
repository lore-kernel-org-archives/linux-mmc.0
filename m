From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] mmc: mmci: Change vdd_handler to a generic ios_handler
Date: Wed, 28 Sep 2011 07:34:05 +0200
Message-ID: <CACRpkdZpbs06Gi27dpVearp1zV6Xi-8-88E1GJmRca3u_N1zbg@mail.gmail.com>
References: <1317123753-29902-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39465 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab1I1FeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Sep 2011 01:34:07 -0400
Received: by pzk1 with SMTP id 1so19437949pzk.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2011 22:34:06 -0700 (PDT)
In-Reply-To: <1317123753-29902-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

On Tue, Sep 27, 2011 at 1:42 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:

> The purpose of the vdd_handler does not make sense. We remove it
> and use a generic approach instead. A new ios_handler is added, the
> purpose of which e.g. can be to control GPIO pins to a levelshifter.
>
> Previously the vdd_handler was also used for making additional
> changes to the power register bits. This option is superfluous and is
> therefore removed.
>
> Adaptaptions from the old vdd_handler to the new ios_handler is done for
> mach-ux500 board, which was the only one using the vdd_handler.

I've tried to undestand (by reading the data sheets I have) what the
purpose of the original 4 power bits handled by the mechanism that
nobody really use is, and I'm still lost.

I'm guessing it was some feature intended to control e.g. a
regulator of some kind by routing them off-chip (since mixed-signal
chips rarely have MMC controllers inside...) and most designers
already have their own regulator designs so it made no sense
for anyone to actually implement it that way.

If some vendor would actually start using these bits for the
intended purpose I guess we could adapt. (The pirate driver
msm_sdcc.c does not seem to use these bits either BTW.)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
