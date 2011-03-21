From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMD
Date: Mon, 21 Mar 2011 11:22:30 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103211003230.23727@peruna>
References: <201103172255.51442.arnd@arndb.de> <alpine.DEB.2.00.1103191849040.13315@peruna> <AANLkTim9PXg8UXMkDXUQ6W9pYp12U6MQ2AR+3ORk-uEX@mail.gmail.com> <201103211325.34785.arnd@arndb.de> <AANLkTikD07xreYEu4_=uQuw-+vi1TuQm5tmA4uWF82=n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-2003912157-1300729249=:23727"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:45265 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753344Ab1CUSWx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Mar 2011 14:22:53 -0400
In-Reply-To: <AANLkTikD07xreYEu4_=uQuw-+vi1TuQm5tmA4uWF82=n@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.1103211109520.23727@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>, John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, cjb@laptop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-2003912157-1300729249=:23727
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.1103211109521.23727@peruna>

On Mon, 21 Mar 2011, Andrei Warkentin wrote:

> 2011/3/21 Arnd Bergmann <arnd@arndb.de>:
> > On Sunday 20 March 2011, Micha=B3 Miros=B3aw wrote:
> >> 2011/3/20 John Calixto <john.calixto@modsystems.com>:
> >> > On Sat, 19 Mar 2011, Arnd Bergmann wrote:
> >> [...]
> >> >> > I expect for more general purposes, like your qemu passthrough ca=
se, you
> >> >> > would want to add a handler for cmd=3DSD_IOC_CMD?
> >> >> Yes, but I suspect that would mean blocking all other activity on t=
he
> >> >> same device, possibly with an ioctl for claiming the host for an
> >> >> extended period of time.
> >> > Sure. =A0And if the testing I described above shows that regular blo=
ck
> >> > operations are indeed negatively affected, then I'll have to impleme=
nt
> >> > that ioctl for claiming the host myself and you'll have a head start=
! :)
> >>
> >> This idea is scary. ;-) Just think what would happen if userspace made
> >> this sequence:
> >> 1. fd =3D open(dev)
> >> 2. ioctl(fd, claim host)
> >> 3. read(fd, ...)
> >>
> >> (if 3. is not convincing, replace it with any access to mounted
> >> filesystem from the same card.)
> >
> > I agree. If we allow such a command on a block device, that
> > should probably be mutually exclusive with normal read/write
> > access or mounting the block device, and it needs to be a
> > priviledged operation.
> >
>=20
> Chances are, the filesystem could be located on the device itself, so
> exclusive access isn't always possible. Right now you can 'dd' all
> over a block device
> even if a filesystem is mounted on it, so the ioctl shouldn't be any
> more restrictive than that. The contract on the ioctl should be that
> the rest of the sd/sdio stack is not confused
> over the card state, possibly resulting in the wrong operation. For
> example, I briefly skimmed the simplified SD physical layer spec, and
> I found nothing that said it was safe to assume a particular command
> set would always work while the card is in some particular function
> mode (set using SWITCH command, for example to put card into OTP,
> ASSD.) In fact, if you look at 4.3.12 of
> Part_1_Physical_Layer_Simplified_Specification_Ver3.01_Final_100518.pdf,
> it says right there that care must be shown as to what command system
> mode the card is in, as the commands may change meanings.
>=20
> I think you need to nail down what exactly is going to be sent across
> the IOCTL within the boundary of the simplified SD spec. If the
> security extensions involve putting the card into a mode where normal
> block/sdio/whatever functionality is impaired until the mode is
> exited, then the kernel should always have the ability to put the card
> back in normal mode, and restore your special mode when you do another
> related ioctl.
>=20

I think this is headed in the right direction.  Instead of creating
special cases for specific commands, I'd prefer to make the default case
be that the kernel should always be able to use the SD card as it
expects for normal storage operations.  Something to the effect of:

<pseudo>

    static int ioctl_expect_more =3D 0;  /* when true, some caller expects =
to send multiple cmds via ioctl */
    static int ioctl_cmd_source =3D 0;  /* by default, cmds do *not* come f=
rom ioctl */

    static int mmc_blk_ioctl(bdev, mode, cmd, arg)
    {

        ...

        mmc_claim_host(host);
        ioctl_cmd_source =3D 1;

        ioctl_expect_more =3D arg.expect_more;
        if (ioctl_expect_more) {
            save_preioctl_sd_state();
        }

        mmc_wait_for_req(host, mrq);

        ioctl_cmd_source =3D 0;
        mmc_release_host(host);

        ...
    }

    void mmc_wait_for_req(host, mrq)
    {

        ...

        if (ioctl_expect_more && !ioctl_cmd_source) {
            restore_preioctl_sd_state();
            ioctl_expect_more =3D 0;
        }

        ...

    }

</pseudo>

Secure ops, virtualization, and really anything that would use this
ioctl do not fit the 'normal' path for most users.  I think it's
appropriate to expect the applications that use this ioctl to be able to
handle interruptions in their SD command sequences.  I know that I
already need to be careful about this for secure ops.  And I would hope
that if you were using this ioctl to passthrough SD storage to your
virtualized guests, you would not expect it to be used concurrently as
the storage for your host rootfs as well.

John
---1463811328-2003912157-1300729249=:23727--
