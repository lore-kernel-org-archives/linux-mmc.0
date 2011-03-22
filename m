From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH resend] mmc: Added ioctl to let userspace apps send
 ACMDs
Date: Tue, 22 Mar 2011 15:31:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1103221508420.30367@peruna>
References: <203F41F6E33F954E8E8B02559FDC906F7431FC48EA@modex01> <alpine.DEB.2.00.1103180927390.5267@peruna> <AANLkTimjssCz_U4xbSf+ecoM7RsjC3eGQBo2vabfyy=T@mail.gmail.com> <201103182026.48939.arnd@arndb.de> <AANLkTinKon=D445PEHP2CzeL7OUpf_4y8j0-GA2nmZPt@mail.gmail.com>
 <alpine.DEB.2.00.1103211129130.23727@peruna> <AANLkTimwnS74Ybo6XTLOVUs7pRZBv4+hDgS7i2bfj+HV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1948272867-1300833120=:30367"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:41943 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338Ab1CVWcJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Mar 2011 18:32:09 -0400
In-Reply-To: <AANLkTimwnS74Ybo6XTLOVUs7pRZBv4+hDgS7i2bfj+HV@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, cjb@laptop.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1948272867-1300833120=:30367
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 22 Mar 2011, Micha=B3 Miros=B3aw wrote:
> >> In this case, a process having access to one partition can disrupt
> >> other partitions on the same card even if it has no access to them in
> >> any other way.
> > This is true, but I can already wreak havoc on partitions for any block
> > device by opening up the block device node directly, seeking and
> > writing. =A0If I have write access to the block device, I can do whatev=
er
> > I want.
>=20
> You're talking about reverse case to what I described. Using a
> partition, you shouldn't be able to effect the device in a way that
> extends part this particular partition.
>=20

Ah - I see.  Sorry, I misread your comment.

> >> It is not that unusual on "normal systems" to give write access to
> >> some partition or device to unprivileged users. Database volumes are
> >> one example.
> > Are you talking about the device nodes themselves, or about access to
> > the mounted filesystems that live on those devices/partitions? =A0It se=
ems
> > like if you give unprivileged users write access to the raw block
> > device, you should expect a lot more trouble from
> > runaway/malicious/accidental writes than you would from
> > application-specific commands being sent via ioctl.
>=20
> I don't exactly see what's your point here. If you say that writes are
> less dangerous than ioctls, then I agree. Even now, for some block
> ioctls you need CAP_SYS_ADMIN because of that.
>=20

In general, I agree with your caution.  My point is that I'm not sure
this type of protection belongs in the kernel.  We use permissions and
"medium-privileged" role users all the time to marshal access to
sensitive files and devices.  This is a problem that has been solved in
userspace.  You don't let normal user "john" have the same access to
device nodes or even files and directories that you would for role user
"database", or role user "webserver".  (Actually, you probably shouldn't
let normal user "john" have access to anything - I hear he's trouble!)

John
---1463811328-1948272867-1300833120=:30367--
