From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Tue, 28 Jun 2011 21:59:00 +0100
Message-ID: <BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
	<BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
	<BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
	<BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
	<BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45420 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab1F1U7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 16:59:00 -0400
Received: by pvg12 with SMTP id 12so339981pvg.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 13:59:00 -0700 (PDT)
In-Reply-To: <BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 28 June 2011 06:55, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Obviously the second hunk is necessary, but I'd like to know whether
> the first one really is too or not. Can you please retest this without
> that hunk (try to suspend/resume while the chip is powered off, and
> again while it is powered on, but wol isn't used) ?

Exactly which kernel should I run this test on?

Thanks,
Daniel
