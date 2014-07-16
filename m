From: Greg KH <greg@kroah.com>
Subject: char interface to sdio, chdio.c
Date: Tue, 15 Jul 2014 20:26:55 -0700
Message-ID: <20140716032655.GB30412@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Stephen.

I had some people ask me about a sdio userspace interface, and ran
across the chdio.c file as found in the MSM android kernel trees:

https://android.googlesource.com/kernel/msm/+/57b74303d6f033ab04be039379f6661337fb9279

Any reason why this hasn't been submitted upstream?  Or has it, and was
it rejected?

Also, what userspace code uses this?  Is there some android-specific
code somewhere that does a weird mix of sysfs and char control of the
hardware?  And what type of SDIO devices are controlled with this?

thanks,

greg k-h
