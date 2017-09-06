From: Seraphime Kirkovski <kirkseraph@gmail.com>
Subject: 4.13 on thinkpad x220: oops when writing to SD card
Date: Wed, 6 Sep 2017 09:08:07 +0200
Message-ID: <20170906070807.4a4t6udmlbmsaab3@macchiaveli>
Reply-To: 6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>, linux-mmc@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, O@macchiaveli
List-Id: linux-mmc@vger.kernel.org

To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Pavel Machek <pavel@ucw.cz>,
	linux-mmc@vger.kernel.org,
	kernel list <linux-kernel@vger.kernel.org>
Bcc: 
Subject: Re: 4.13 on thinkpad x220: oops when writing to SD card
Reply-To: 
In-Reply-To: <6689241f-a4d8-7a3e-9f0b-482b034e5710@intel.com>

Hi,

> > Seems 4.13-rc4 was already broken for that but unfortuantely 
> > I didn't
> > reproduce that. So maybe Seraphime can do git-bisect as he said "I get
> > it everytime" for which I assume it could be easy for him to find out
> > the problematic commit?

I can reliably reproduce it, although sometimes it needs some more work.
For example, I couldn't trigger it while writing less than 1 gigabyte
and sometimes I have to do it more than once. It helps if the machine is
doing something else in meantime, I do kernel builds.

> Another unrelated issue with mmc_init_request() is that 
> mmc_exit_request()
> is not called if mmc_init_request() fails, which means mmc_init_request()
> must free anything it allocates when it fails.

Will try the patch and report back soon.
