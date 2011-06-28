From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Tue, 28 Jun 2011 22:54:56 +0100
Message-ID: <BANLkTimzgiXpb0v30KYsfvoPAb4iu2K5kw@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
	<BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
	<BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
	<BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
	<BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
	<BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com>
	<BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61194 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328Ab1F1Vy5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jun 2011 17:54:57 -0400
Received: by pzk9 with SMTP id 9so424153pzk.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jun 2011 14:54:56 -0700 (PDT)
In-Reply-To: <BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 28 June 2011 22:47, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Tue, Jun 28, 2011 at 11:59 PM, Daniel Drake <dsd@laptop.org> wrote:
>> On 28 June 2011 06:55, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> Obviously the second hunk is necessary, but I'd like to know whether
>>> the first one really is too or not. Can you please retest this without
>>> that hunk (try to suspend/resume while the chip is powered off, and
>>> again while it is powered on, but wol isn't used) ?
>>
>> Exactly which kernel should I run this test on?
>
> Latest (isn't that what you've been working with all this time ?).

latest linux-mmc.git ? Or linux-next? Or linus?

I'll apply the patch in this thread, and my patch titled "mmc: sdio:
reset card during power_restore" - anything else?

Too many patches floating around, just trying to be sure of what I'm doing!

Thanks,
Daniel
