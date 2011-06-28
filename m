From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Wed, 29 Jun 2011 00:47:00 +0300
Message-ID: <BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
 <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com> <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
 <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com> <BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
 <BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59077 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130Ab1F1VrV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 17:47:21 -0400
Received: by wwe5 with SMTP id 5so635700wwe.1
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 14:47:20 -0700 (PDT)
In-Reply-To: <BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Jun 28, 2011 at 11:59 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 28 June 2011 06:55, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Obviously the second hunk is necessary, but I'd like to know whether
>> the first one really is too or not. Can you please retest this without
>> that hunk (try to suspend/resume while the chip is powered off, and
>> again while it is powered on, but wol isn't used) ?
>
> Exactly which kernel should I run this test on?

Latest (isn't that what you've been working with all this time ?).

Thanks,
Ohad.
