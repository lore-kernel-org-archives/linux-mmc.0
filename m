From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 18 Dec 2010 16:07:26 +0100
Message-ID: <201012181607.26628.rjw@sisk.pl>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com> <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org> <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37435 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756246Ab0LRPIY (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Dec 2010 10:08:24 -0500
In-Reply-To: <AANLkTi=32bqipN5U00La-B7JSgTC1bHgMev=xUSF6kRN@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Saturday, December 18, 2010, Ohad Ben-Cohen wrote:
> Hi Alan,
> 
> Sorry for the belated response,
> 
> On Sat, Dec 11, 2010 at 4:50 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> Think of a device which you have no way to reset other than powering
> >> it down and up again.
> >>
> >> If that device is managed by runtime PM, the only way to do that is by
> >> using put_sync() followed by a get_sync(). Sure, if someone else
> >> increased the usage_count of that device this won't work, but then of
> >> course it means that the driver is not using runtime PM correctly.
> >
> > Not so.  Even if a driver uses runtime PM correctly, there will still
> > be times when someone else has increased the usage_count.  This happens
> > during probing and during system resume, for example.
> 
> I'm aware of these two examples; normally we're good with them since
> during probing we're not toggling the power, and during suspend/resume
> the SDIO core is responsible for manipulating the power (and it does
> so directly). Are there (or do you think there will be) additional
> examples where this can happen ?
> 
> But this leads me to a real problem which we have encountered.
> 
> During system suspend, our driver is asked (by mac80211's suspend
> handler) to power off its device. When this happens, the driver has no
> idea that the system is suspending - regular driver code (responsible
> to remove the wlan interface and stop the device) is being called.

That's where the problem is.  If there's a difference, from the driver's
point of view, between suspend and some other operation, there should be a
way to tell the driver what case it actually is dealing with.

BTW, what would you do in that case if the runtime PM of the device were
disabled by user space by writing "on" to the device's
/sys/devices/.../power/control file?

Rafael
