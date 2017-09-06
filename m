From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: 4.13 on thinkpad x220: oops when writing to SD card
Date: Wed, 6 Sep 2017 10:20:35 +0200
Message-ID: <20170906082035.t76xm5umzincncwm@macchiaveli>
Reply-To: 6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, shawn.lin@rock-chips.com, pavel@ucw.cz, linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

> > Seems 4.13-rc4 was already broken for that but unfortuantely
> > I didn't
> > reproduce that. So maybe Seraphime can do git-bisect as he said "I 
> > get
> > it everytime" for which I assume it could be easy for him to find 
> > out
> > the problematic commit?

I can reliably reproduce it, although sometimes it needs some more work.
For example, I couldn't trigger it while writing less than 1 gigabyte
and sometimes I have to do it more than once. It helps if the machine is
doing something else in meantime, I do kernel builds.

> Another unrelated issue with mmc_init_request() is that
> mmc_exit_request()
> is not called if mmc_init_request() fails, which means 
> mmc_init_request()
> must free anything it allocates when it fails.

I'm running your patch for 45 minutes now, it looks like it's fixing the 
issue on 4.13 81a84ad3cb5711cec79.

P.S. Sorry about the formatting, have to fix my editor
