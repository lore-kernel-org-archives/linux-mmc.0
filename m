From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] [PATCH v4 1/1] mmc: Support of DUAL BUFFER DESC[ring]
 mode for dw_mmc
Date: Wed, 11 Jan 2012 16:57:22 +0530
Message-ID: <CANYdXnq6EhLx43uaBDVfZ8NcQMLoPiPHFKawyWUcvqo6oM0zDg@mail.gmail.com>
References: <1317123568-5203-1-git-send-email-shashidharh@vayavyalabs.com>
	<4E8BBD76.9020001@samsung.com>
	<CANYdXnpe0prpdJcYpi3yVqCecugwZ1999c2u2u6ffjXjSeCDnw@mail.gmail.com>
	<m2obwt8ju2.fsf@bob.laptop.org>
	<CAFbHwiSahkGOd4EfYiKY-T9Segn9Nn4qSMA591SFRmMmKY67VQ@mail.gmail.com>
	<CANYdXnqviDqYb9Rq0O-48P6f+v6NSg8j8-H7XYU+ccNx_P17zw@mail.gmail.com>
	<CANYdXnpdHVWFbXnSR2wGVOF4zKMxxmEMTfC+1x10NCpvmPNXDQ@mail.gmail.com>
	<20111119013435.GA19582@balrog>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:60523 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756275Ab2AKL1X convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 Jan 2012 06:27:23 -0500
Received: by obbup16 with SMTP id up16so718716obb.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 Jan 2012 03:27:23 -0800 (PST)
In-Reply-To: <20111119013435.GA19582@balrog>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: James Hogan <james@albanarts.com>
Cc: Will Newton <will.newton@gmail.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Philip Rakity <prakity@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>, Kyungmin Park <kyungmin.park@samsung.com>, Matt Fleming <matt@console-pimps.org>, linux-mmc@vger.kernel.org, Sandeep Pendharkar <sandeep@vayavyalabs.com>, Rayagond Kokatanur <rayagond@vayavyalabs.com>

Hi James,
=C2=A0 Sorry for delay in getting the performance numbers since there w=
as
some issue with the Hardware.
Even though the Dual Buffer Patch does not improve the performance
considerably for Read operations, but for the write operations, I
found the improvement in speed of upto 200 KiB/s.
Please find the numbers for the tests with considerable improvement as =
below :-

Best Case Write Test:-
Chain Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.034517837 seconds
(3797 kB/s, 3708 KiB/s, 28.97 IOPS, sg_len 32)

Dual Buffer Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.033325325 seconds
(3933 kB/s, 3840 KiB/s, 30.00 IOPS, sg_len 32


Best Case Write Test for scattered Memory:-
Chain Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.035052520 seconds
(3739 kB/s, 3651 KiB/s, 28.52 IOPS, sg_len 32

Dual Buffer Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.033113106 seconds
(3958 kB/s, 3865 KiB/s, 30.19 IOPS, sg_len 32)


Single Write by Transfer Size:-
Chain Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.034675358 seconds
(3779 kB/s, 3691 KiB/s, 28.83 IOPS, sg_len 32)

Dual Buffer Mode:-
Transfer of 1 x 256 sectors (1 x 128 KiB) took 0.033575460 seconds
(3903 kB/s, 3812 KiB/s, 29.78 IOPS, sg_len 32)

Write performance blocking req 1 to 512 sg elems:-
Chain Mode:-
Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 38.029996867
seconds (3529 kB/s, 3446 KiB/s, 26.92 IOPS, sg_len 256)

Dual Buffer:-
Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 37.489874739
seconds (3580 kB/s, 3496 KiB/s, 27.31 IOPS, sg_len 256)

Write performance non-blocking req 1 to 512 sg elems:-
Chain Mode:-
Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 38.057999074
seconds (3526 kB/s, 3444 KiB/s, 26.90 IOPS, sg_len 256
Dual Buffer:-
Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 37.489499346
seconds (3580 kB/s, 3496 KiB/s, 27.31 IOPS, sg_len 256


On Sat, Nov 19, 2011 at 7:04 AM, James Hogan <james@albanarts.com> wrot=
e:
>
> Hi Shashidhar,
>
> On Mon, Nov 14, 2011 at 09:32:25PM +0530, Shashidhar Hiremath wrote:
> > Hi Will,
> >
> > Just following up since i did not see any response from you on my
> > earlier mail.. In previous mail, im not sure whether i gave you eno=
ugh
> > context/background.. So here it goes (apologies in advance if this
> > turns out to be a =C2=A0lengthy mail...):
> >
> > 1>At Vayavya Labs, our work is to make sure that drivers for SNPS
> > designware IP is available in kernel.org. One of the
> > mandates/requirements from SNPS is that the driver submitted to
> > kernel.org should support all the features/configurations of the IP=
=2E
> > The bigger picture being that once this is done, SNPS customers don=
t
> > have to write code for any specific feature/configuration since it =
is
> > already available in the driver and they can start using it
> > immediately...
> > 2>As such, it is required that code for dual descriptors be also
> > present in the driver submitted to kernel.org.. In future there, th=
ere
> > could be some person wanting to use this feature of the IP..
> > 3>Also note that in kconfig, there does not have to be a choice
> > between this mode and chained mode since the default will always be
> > chained mode. STM Ethernet MAC driver already has such a kind of
> > support.. If this is not acceptable, do you feel the code should be
> > wrapped in some totally different preprocessor directive with comme=
nts
> > in the driver explaining the same?
> > 4>With regards to your points on performance, I am open to look at =
it
> > and see where we can make improvements in the driver (if any... if =
its
> > a hardware thing, there is not much we can do)
>
> Can I suggest you try running mmc_test with and without the dual
> descriptor mode. It has a bunch of performance tests in it.
>
> Cheers
> James
>
> >
> > Do let me know your views.
> >
> > best regards
> > --Shashidhar Hiremath
> >
> > On Fri, Nov 4, 2011 at 12:36 PM, Shashidhar Hiremath
> > <shashidharh@vayavyalabs.com> wrote:
> > > Hi Will,
> > > =C2=A0 I agree with you that it should not be merged =C2=A0unless=
 it improves
> > > the performance. But I still feel that there might be some reason=
 for
> > > which the IP Vendor has provided an additional feature. So will t=
his
> > > not be a good feature to have as it will help in IP Validation fo=
r
> > > different modes.
> > > =C2=A0As far as the Kconfig option is concerned, the user need no=
t always
> > > modify it since the default case will still be Chained Mode. Also=
 Such
> > > Kconfig options for selecting mode is already =C2=A0used for stmm=
ac
> > > Ethernet Drivers.
> > >
> > > On Thu, Nov 3, 2011 at 8:48 PM, Will Newton <will.newton@gmail.co=
m> wrote:
> > >> On Thu, Nov 3, 2011 at 12:35 PM, Chris Ball <cjb@laptop.org> wro=
te:
> > >>> Hi,
> > >>>
> > >>> On Thu, Nov 03 2011, Shashidhar Hiremath wrote:
> > >>>> Hi Chris,
> > >>>> =C2=A0 Can this patch be accepted by criteria that its an addi=
tional
> > >>>> feature supported by the hardware and hence good to have the s=
upport
> > >>>> in the driver.Also note the patch has been tested.
> > >>>
> > >>> I think Will and James should make the call on that.
> > >>>
> > >>> My own opinion is that it's not usually a good idea to merge co=
de that
> > >>> increases complexity for no performance gain; if the feature is=
 actually
> > >>> important, someone should find a way to finish it and measure a
> > >>> performance gain (the gain can be in any of bandwidth, memory, =
or
> > >>> lower CPU utilization) with it, to prove that the change is wor=
thwhile.
> > >>
> > >> I'm inclined to agree. I don't want to feel like I am blocking
> > >> inclusion of anyone's hard work, but unless there is a clear adv=
antage
> > >> for one option over the other I can't see a good reason for merg=
ing
> > >> it. At present it adds a question to the Kconfig that is pretty =
much
> > >> impossible for the user to answer (do I turn this feature on or =
off?
> > >> what is the advantage of choosing each option?).
> > >>
> > >
> > >
> > >
> > > --
> > > regards,
> > > Shashidhar Hiremath
> > >
> >
> >
> >
> > --
> > regards,
> > Shashidhar Hiremath
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.=
html




--
regards,
Shashidhar Hiremath
