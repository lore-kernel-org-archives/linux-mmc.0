From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v3 1/3] arm: dts: rk3288-tinker.dtsi: Fix SD card detection
Date: Tue, 12 Mar 2019 21:52:38 +0100
Message-ID: <4202578.jOHf0ez5fE@diego>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
 <50094675.5IylMcgSg6@phil>
 <4a1ad220-103d-543e-56d1-3c6d6ad906ec@davidjohnsummers.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <4a1ad220-103d-543e-56d1-3c6d6ad906ec-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: David Summers <beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi David,

Am Dienstag, 12. M=E4rz 2019, 21:34:00 CET schrieb David Summers:
> On 12/03/2019 14:22, Heiko Stuebner wrote:
> > Hi Jonas,
> > =

> > Am Samstag, 9. M=E4rz 2019, 16:39:21 CET schrieb David Summers:
> >> The Problem:
> >> =

> >> On ASUS Tinker Board S, when booting from the eMMC, and there is card
> >> in the sd slot, there are constant errors.
> >> =

> >> Also when warm reboot, uboot can not access the sd slot
> >> =

> >> Cause:
> >> =

> >> Identified by Robin Murphy @ ARM. The Card Detect on rk3288
> >> devices is pulled up by vccio-sd; so when the regulator powers this
> >> off, card detect gives spurious errors. A second problem, is during
> >> power down, vccio-sd apprears to be powered down. This causes a
> >> problem when warm rebooting from the sd card. This was identified by
> >> Jonas Karlman.
> >> =

> >> History:
> >> =

> >> A common fault on these rk3288 board, which impliment the reference
> >> design.
> >> =

> >> When this arose before:
> >> =

> >> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/2811=
53.
> >> html
> >> =

> >> And Ulf and Jaehoon clearly said this was a broken card detect design,
> >> which should be solved via polling
> >> =

> >> Solution:
> >> =

> >> Hence broken-cd is set as a property. This cures the errors. The
> >> powering down of vccio-sd during reboot is cured by adding
> >> regulator-boot-on.
> >> =

> >> This solutions has been fairly widely reviewed and tested.
> >> =

> >> Signed-off-by: David Summers <beagleboard-8lkWs+DogrrqRUWtDFdff/XRex20P6io@public.gmane.org>
> >> Reviewed by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >> Reviewed by: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
> > =

> > in v2, you gave a
> > Tested-by: Jonas Karlman <jonas-uIzNG4q0ceqzQB+pC5nmwQ@public.gmane.org>
> > it seems, which somehow transformed into a reviewed-by in v3.
> > =

> > V3 did change a bit in its approach - for the better, but do you approve
> > of adding that Reviewed-by above (and maybe also providing a Tested-by
> > for the new approach)?
> > =

> > Thanks
> > Heiko
> =

> Hi all,
> =

> Yes apologies for these signed-off lines etc wrong. Its still a learning
> experiment for me!
> =

> Both Robin and Jonas added a lot to Patch, as explained in the write up.
> Robin came up with the cause of the fault, and Jonas noticed a second
> fault. So the question is to give these two their due. I think what they
> both added was important.
> =

> Thanks Robin for the official "Reviewed-by".
> =

> Jonas tested the second version, which kept power on vccio-sd all the
> time, whereas v1 and v3 cured the problem with broken-cd. So although
> both fixed the problem, they way performed is different. So don't think
> I can say Jonas Tested-by v3.

We'll just give Jonas a bit more time to reply then :-) .


> As for the tested by "TheSaint @ ArchLinux Arm", he actually tested just
> above every single version of the patch, and a whole lot more before it
> was sent in - he is our ASUS Tinker Board user on arch. He doesn't
> really want his email in the open, but if push comes to shove he'll
> allow it. Question is do you need this for the Patch to pass?

No, that is not necessary. I'll just drop the line when applying.
In general for a tag to mean something we need the Name, but any
tags other than Signed-off-by are optional anyway.


> Heiko, I'm happy to change the sign off etc, and resent the patch (as
> v4). But would be the same patch. Think the question is what is best for
> you. Don't want to send unneeded email ... anyway let me know (private
> email?) and I'll do whatever is best for you.

No, re-sending just to correct tags is not necessary in _my_ case
as I generally just fix up the relevant lines myself when applying.
Just keep in mind, other maintainers may handle this differently :-) .


> P.S. Eventually I'll get better at these patches , alas the day job
> keeps me too busy - and I forget the rules :(

Really no problem, it's always a learning experience.
So don't worry too much :-) .


Heiko
