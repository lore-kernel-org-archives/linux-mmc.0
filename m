From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Internal error: Oops: 17 [#1] ARM
Date: Wed, 22 Jan 2014 16:41:00 +0000
Message-ID: <20140122164100.GE15937@n2100.arm.linux.org.uk>
References: <CACUGKYPXficVuqDgy6_Tnh9b-VOXDNK=+nqb6U5O6NpcZOGGpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACUGKYPXficVuqDgy6_Tnh9b-VOXDNK=+nqb6U5O6NpcZOGGpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Tobias <john.tobias.ph@gmail.com>
Cc: "<linux-arm-kernel@lists.infradead.org>" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "<linux-kernel@vger.kernel.org>" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jan 22, 2014 at 08:23:36AM -0800, John Tobias wrote:
> Hello all,
> 
> I am using 3.13-rc1 kernel on iMX6SL processor. My filesystem is in
> eMMC running SDR50.
> Is anyone here encountered these problem and if there's any existing
> patch that I can get?.

How reproducable is this?  I notice you're using 3.13-rc1 too, it could
be the bug has already been fixed in a later kernel version.  -rc1
kernels are really the "fresh after lots of new feature merging" kernels
which should always be expected to be rather buggy.

Linux kernel "release candidates" are not "we think this is going to be
a final kernel, please test it" but -rc1 marks the end of the new
feature merging and the beginning of the stablisation phase.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
