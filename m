From: Daniel Drake <dsd@laptop.org>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Wed, 6 Jul 2011 16:53:03 +0100
Message-ID: <CAGq3pz5hRQg72HMN6MyYccTisRAmfoqQmoDy5gvtiVwcjhTKhA@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
	<BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com>
	<BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
	<BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
	<BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
	<BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com>
	<BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
	<BANLkTimzgiXpb0v30KYsfvoPAb4iu2K5kw@mail.gmail.com>
	<BANLkTi=fwnNVwtxOo66k7M-4Jxu=3eD2xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f52.google.com ([209.85.161.52]:40057 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754Ab1GFPxF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 11:53:05 -0400
Received: by fxd18 with SMTP id 18so217356fxd.11
        for <linux-mmc@vger.kernel.org>; Wed, 06 Jul 2011 08:53:04 -0700 (PDT)
In-Reply-To: <BANLkTi=fwnNVwtxOo66k7M-4Jxu=3eD2xQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On 28 June 2011 23:04, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Wed, Jun 29, 2011 at 12:54 AM, Daniel Drake <dsd@laptop.org> wrote:
>> Too many patches floating around, just trying to be sure of what I'm doing!
>
> Ok, let's start from fresh :)
>
> Let's take 3.0-rc5, it already includes our work:
>
> 297c7f2 mmc: sdio: fix runtime PM path during driver removal
> c6e633a mmc: sdio: reset card during power_restore
>
> Then apply these hunks:

Thanks, done. Sorry for the delay in getting to this.

Unfortunately something is still weird, this is possibly a case that
we missed before.

Even if I just do the simplistic test of booting, and then suspending
(without loading the libertas driver), things go wrong:
http://dev.laptop.org/~dsd/20110706/dmesg.txt

I added printk's in mmc_power_save_host and mmc_power_restore_host.
The strange thing is that it tries to resume mmc1 even though it is
powered down and there is no available driver, and also that it then
tries to power it down again (but it is already off).

Daniel
