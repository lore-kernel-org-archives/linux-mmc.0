From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: subtle pm_runtime_put_sync race and sdio functions
Date: Sat, 11 Dec 2010 09:50:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1012110937100.10743-100000@netrider.rowland.org>
References: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikJr+0kVPE4aSwPjZWRfA3gRSNgGwzQdSwRpo_5@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-mmc@vger.kernel.org, Ido Yariv <ido@wizery.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, 11 Dec 2010, Ohad Ben-Cohen wrote:

> On Fri, Dec 10, 2010 at 7:24 PM, Alan Stern <stern@rowland.harvard.edu> w=
rote:
> >> On Friday, December 10, 2010, Ohad Ben-Cohen wrote:
> >> > When pm_runtime_put_sync() returns, the _put operation is completed,
> >> > and if needed (zero usage_count, children are ignored or their count
> >> > is zero, ->runtime_idle() called pm_runtime_suspend(), no
> >> > runtime_error, no disable_depth, etc...) the device is powered down.
> >> >
> >> > This behavior is sometimes desirable and even required: drivers may
> >> > call pm_runtime_put_sync() and rely on PM core to synchronously power
> >> > down the device.
> >
> > That would be a mistake. =A0The "sync" in pm_runtime_put_sync means that
> > _if_ a runtime_suspend call occurs, the call will occur synchronously.
> > It does not guarantee that a runtime_suspend call will occur.
> =

> This is clear; that's why I explicitly mentioned that all the
> conditions are met in the very beginning of my description.

But you can never _know_ that all the conditions are met.  Therefore =

relying on them is not safe.

> >> > This is usually all good, but when we combine this requirement with
> >> > logical sub-devices that cannot be power-managed on their own (e.g.
> >> > SDIO functions), things get a bit racy, since their parent is not
> >> > suspended synchronously (the sub-device is rpm_suspend()'ed
> >> > synchronously, but its parent is pm_request_idle()ed, which is
> >> > asynchronous in nature).
> >> >
> >> > Since drivers might rely on pm_runtime_put_sync() to synchronously
> >> > power down the device,
> >
> > Drivers should never do this.
> =

> Think of a device which you have no way to reset other than powering
> it down and up again.
> =

> If that device is managed by runtime PM, the only way to do that is by
> using put_sync() followed by a get_sync(). Sure, if someone else
> increased the usage_count of that device this won't work, but then of
> course it means that the driver is not using runtime PM correctly.

Not so.  Even if a driver uses runtime PM correctly, there will still =

be times when someone else has increased the usage_count.  This happens =

during probing and during system resume, for example.

If you need a way to power down the device unconditionally then you =

must bypass the runtime-PM framework.

> > What if the device's usage_count was larger than 1? =A0Then
> > pm_runtime_put_sync() wouldn't cause a suspend in any case.
> >
> > It sounds like the reinitialization is done at the wrong time. It
> > should occur when the parent is resumed, since we are assuming the
> > parent controls the device's power. =A0Then if the device doesn't get
> > powered down because the parent's suspend was cancelled, there would be
> > no reinitialization and nothing would go wrong.
> =

> This can't always be done; sometimes the driver _must_ know if the
> power was taken down or not, because it completely reset the device's
> state: after powering the device down and up, you might need to load
> it a new firmware, reconfigure it, notify the stack above you about
> this event, etc..

So tell the driver whenever the device gets powered down.  Then the
driver will never have to guess.

> After reseting the device, the driver will behave completely
> different. If it chose to power the device down, it must be able to do
> that deterministically.
> =

> Naturally this is only possible if runtime PM is used very accurately,
> without letting random entities increasing the device's usage count
> behind the driver's back.

There is no way to prevent it.  The PM core does this already.

> You could say "don't use runtime PM" of course, but the device belongs
> to the MMC bus, which does employ runtime PM, for all the good
> reasons: runtime PM provided it the entire plumbing required to
> achieve power control of its devices. Not using runtime PM would
> basically mean duplicating big parts of runtime PM's code into
> SDIO/MMC core (reference counts, locking, device hierarchy, exposed
> API, etc..).

If the driver is careful, it can power a device down and back up
without ever telling the PM core, by calling the runtime_suspend and
runtime_resume methods directly.  You'll have to figure out whether =

this sort of approach can solve your problem.

> > I don't like this change quite so much. =A0It can give rise to unbounded
> > nested suspend sequences: we suspend the device, then call the parent's
> > runtime_idle routine which suspends the parent, then we call the
> > grandparent's runtime_idle routine, etc.
> =

> Yes, that's why I thought this might not be desirable, but I wasn't
> quite sure why would it be wrong;

It isn't _wrong_; that's why I said I wouldn't NAK it.

>  if a context is willing to
> synchronously suspend a device (either a driver using put_sync() or
> the PM worker), what do we gain by deferring the idling of the parent
> and not synchronously suspending as much ancestors as possible in the
> same context ?

We gain stack space (by not having a potentially lengthy sequence of =

nested calls), which is relatively unimportant, and we gain latency.  =

The latency may help in some situations; if the device is resumed again =

quickly enough then we may avoid suspending the parent entirely.

Alan Stern
