From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] subtle pm_runtime_put_sync race and sdio functions
Date: Sun, 19 Dec 2010 00:03:06 +0100
Message-ID: <201012190003.06405.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:37891 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752019Ab0LRXEL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Dec 2010 18:04:11 -0500
In-Reply-To: <Pine.LNX.4.44L0.1012181547580.7965-100000@netrider.rowland.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>

On Saturday, December 18, 2010, Alan Stern wrote:
> On Sat, 18 Dec 2010, Ohad Ben-Cohen wrote:
> 
> > > Not so.  Even if a driver uses runtime PM correctly, there will still
> > > be times when someone else has increased the usage_count.  This happens
> > > during probing and during system resume, for example.
> > 
> > I'm aware of these two examples; normally we're good with them since
> > during probing we're not toggling the power, and during suspend/resume
> > the SDIO core is responsible for manipulating the power (and it does
> > so directly). Are there (or do you think there will be) additional
> > examples where this can happen ?
> 
> I can't think of any other examples.  But it's possible that more will 
> be added; there is no commitment to avoid this.

echo "on" > /sys/devices/.../power/control

from user space.  You can't possibly override that.

> > But this leads me to a real problem which we have encountered.
> > 
> > During system suspend, our driver is asked (by mac80211's suspend
> > handler) to power off its device. When this happens, the driver has no
> > idea that the system is suspending - regular driver code (responsible
> > to remove the wlan interface and stop the device) is being called.
> > Obviously pm_runtime_put_sync() won't power off the device at this
> > point, but later during suspend, when the SDIO core will suspend, the
> > device will be powered off and things would work as expected.
> 
> This descripion is very confusing.  You seem to be talking about two
> different "power down" operations (one carried out by the driver and
> one carried out by the SDIO core), where one of them really does remove
> power from the device and the other doesn't.  Or maybe one reduces the
> power to an intermediate level and the other reduces it a lot more.  I
> can't tell what you actually mean.
> 
> > That breaks when the suspend transition is cancelled (e.g. due to an
> > error) before SDIO core gets the chance to power off the device: the
> > driver will be asked (by mac80211's resume handler) to power up the
> > device and reinitialize it, but since the device was never powered
> > off, the driver will fail doing so because the device is quiescent (a
> > power cycle should have put him into a communicable state, but that
> > never happened in this scenario).
> 
> To summarize my understanding: After the device was suspended by the
> driver, the SDIO core may or may not have powered it off and back on.  
> The driver doesn't know, but it needs to know in order to resume the
> device.  Right?
> 
> Therefore the problem is that the SDIO core doesn't tell the driver 
> when it powers down the device.  That should be easy to fix -- just add 
> a flag in a shared structure that can be set when a power-down occurs.
> 
> > At that resume point the device is always on - whether the system
> > suspended successfully or not - and the driver can't tell whether the
> > device was indeed powered off beforehand or not. In addition, the
> > driver code that is going to fail is not a resume handler - it's just
> > regular driver code responsible for powering on the device and
> > reinitializing it (which is being called by mac80211's resume
> > handler).
> > 
> > One way to solve this is by allowing certain type of devices to keep
> > using runtime PM during system suspend transitions. Obviously this is
> > generally unsafe, but for certain drivers/devices, that use runtime PM
> > very accurately, synchronously and without being affected by children
> > devices, this may be helpful (and those drivers should be responsible
> > to make sure they are not racing with system suspend).
> 
> ...
> 
> > What do you think ?
> 
> I think it is a bad idea.  It's an attempt to complicate the PM core in 
> order to cover up a deficiency in the SDIO core.

I agree.

> > Otherwise, the driver will need to use some combination of both
> > runtime PM API and direct calls to the ->runtime_suspend() handler.
> 
> I don't see why.  Maybe it would help if you explained in more detail
> how the driver's runtime_suspend and runtime_resume routines get used.
> 
> > The end result will be the same, but it won't be pretty.
> 
> Or, it may not be as ugly as you think.  Hard for me to tell, without 
> knowing how it all hangs together.
> 
> > In addition, others with a similar problem might eventually show up,
> > so supporting this within the runtime PM framework itself will help
> > them too.
> 
> The underlying problem seems to be that the driver doesn't know what to
> do when it wants to resume the device, because it doesn't know what has
> happened while the device was suspended.  To put this another way, the
> SDIO core makes significant changes to the device's state without
> informing the driver.  This is a self-evident bug.  If the driver was
> told what had happened then it could simply do whatever was needed.
> 
> 
> > >>  if a context is willing to
> > >> synchronously suspend a device (either a driver using put_sync() or
> > >> the PM worker), what do we gain by deferring the idling of the parent
> > >> and not synchronously suspending as much ancestors as possible in the
> > >> same context ?
> > >
> > > We gain stack space (by not having a potentially lengthy sequence of
> > > nested calls), which is relatively unimportant
> > 
> > Agree, if that was a problem, resume wouldn't work too, since it is
> > completely symmetric.
> 
> It isn't.  The suspend path uses more stack space, since it involves 
> calling both the runtime_idle and runtime_suspend routines at each 
> step, whereas the resume path calls only the runtime_resume routine.
> 
> > >, and we gain latency.
> > > The latency may help in some situations; if the device is resumed again
> > > quickly enough then we may avoid suspending the parent entirely.
> > 
> > I guess it depends on the implementation, but if that parent cares
> > about wake-up latency, couldn't it set its ->runtime_idle() handler to
> > call pm_runtime_autosuspend() (and set autosuspend appropriately of
> > course) instead of pm_runtime_suspend() ?
> 
> Sure.
> 
> > This way it'd be both possible to suspend devices as fast as possible,
> > in a symmetric fashion to the way resume works, and also, if
> > subsystems care, they could use autosuspend to explicitly indicate the
> > period of inactivity that suits them and completely change this
> > behavior.
> 
> You are overlooking the fact that in our model, runtime suspend and
> resume are _not_ symmetric.  The runtime PM model is demand driven; it
> wants to keep devices at full power whenever they are needed and allows
> them to suspend only when they aren't needed (and hopefully aren't
> going to be needed in the near future).  In this model it is imperative
> not to delay resumes, but it often is a good idea to delay suspends.  
> That's why, for example, the API includes pm_schedule_suspend() and
> pm_runtime_autosuspend() but not pm_schedule_resume() or
> pm_runtime_autoresume().  It's also why there is a runtime_idle 
> callback but no runtime_needed callback.
> 
> > They would also gain deterministic and controllable behavior that we
> > can't guarantee when we rely on a context switch, because obviously
> > the latter yields different results for different platforms and
> > workloads (for the exact same subsystem).
> 
> Like I said before, it's a trade-off.  There are arguments for both 
> sides, and which is better is unclear.  Rafael has to make a judgment 
> call.

Well, I'll do it when I see a patch sent to me. :-)

Thanks,
Rafael
