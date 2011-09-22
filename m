From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 1/3] arm/tegra: Move EN_VDD_1V05_GPIO to board-harmony.h
Date: Thu, 22 Sep 2011 17:32:58 +0100
Message-ID: <20110922163258.GD8072@n2100.arm.linux.org.uk>
References: <1316633620-13184-1-git-send-email-swarren@nvidia.com> <CAOesGMisOtEQpcS-hHi-3brpYzJr-UiB6b71c+bwkesPDk9iuA@mail.gmail.com> <20110922081140.GH17169@n2100.arm.linux.org.uk> <74CDBE0F657A3D45AFBB94109FB122FF1739554CBD@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF1739554CBD-C7FfzLzN0UxDw2glCA4ptUEOCMrvLtNR@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Colin Cross <ccross-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Erik Gilling <konkers-z5hGa2qSFaRBDgjK7y7TUQ@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 22, 2011 at 09:31:48AM -0700, Stephen Warren wrote:
> Russell King - ARM Linux wrote at Thursday, September 22, 2011 2:12 AM:
> > On Wed, Sep 21, 2011 at 01:16:49PM -0700, Olof Johansson wrote:
> > > Works for me. Or I could stage it in a topic branch that would be
> > > merged after Russell's GPIO tree.
> > 
> > Holding stuff off from being merged doesn't work.
> 
> Russell,
> 
> So I take it I should add the two ack'd patches to the ARM patch system,
> and have you pick them up?

That's a workable solution, yes.  I've done that with various other
gpio patches from people, and Grant seems happy with that.
