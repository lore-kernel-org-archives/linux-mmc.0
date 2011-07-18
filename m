From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Mon, 18 Jul 2011 04:53:11 +0300
Message-ID: <CAK=WgbZ9USpkF2DvikF9C_SQ5s0+QyVOBWvFjhWqLjajT-LU0g@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
 <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com> <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
 <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com> <BANLkTik9y_N18EtsUTznaaa188GNusfiSA@mail.gmail.com>
 <BANLkTinDzj4206zLK7i6K9k9vWjVC9hH0w@mail.gmail.com> <BANLkTi=O4hg=ig5WOSeCWA4x03_5kAJsXw@mail.gmail.com>
 <BANLkTimzgiXpb0v30KYsfvoPAb4iu2K5kw@mail.gmail.com> <BANLkTi=fwnNVwtxOo66k7M-4Jxu=3eD2xQ@mail.gmail.com>
 <CAGq3pz5hRQg72HMN6MyYccTisRAmfoqQmoDy5gvtiVwcjhTKhA@mail.gmail.com> <CAGq3pz52=sPGEX-8nj7cVuR5Xg=iE+mg6EcEES0DzWSmuY34bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56948 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755899Ab1GRBxc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jul 2011 21:53:32 -0400
Received: by wyg8 with SMTP id 8so1784541wyg.19
        for <linux-mmc@vger.kernel.org>; Sun, 17 Jul 2011 18:53:31 -0700 (PDT)
In-Reply-To: <CAGq3pz52=sPGEX-8nj7cVuR5Xg=iE+mg6EcEES0DzWSmuY34bA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Fri, Jul 8, 2011 at 6:38 PM, Daniel Drake <dsd@laptop.org> wrote:
> I tested vanilla and realised that this bug exists there too

I'm aware of it - it's caused (indirectly) by another PM core change,
which since then was already changed again in 3.1.

Btw sorry for not being responsive - I've been mostly offline lately
due to family getting bigger ;)

Thanks for pushing the patches forward.
