From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/2 v2] MMC:Add support MMCIF for SuperH
Date: Fri, 30 Apr 2010 12:51:37 +0900
Message-ID: <o2uaec7e5c31004292051yff981cebg3bd05e2684036ae4@mail.gmail.com>
References: <4BD7C240.5050800@renesas.com>
	 <20100427221705.1628375b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100427221705.1628375b.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, ben@decadent.org.uk, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Andrew,

Thanks for your review!

On Wed, Apr 28, 2010 at 11:17 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Wed, 28 Apr 2010 14:06:08 +0900 Yusuke Goda <yusuke.goda.sx@renesa=
s.com> wrote:
>
>> + =A0 =A0 time =3D wait_event_interruptible_timeout(host->intr_wait,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->wait_int =3D=3D 1 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->sd_error =3D=3D 1, h=
ost->timeout);
>> + =A0 =A0 if (host->wait_int !=3D 1 && (time =3D=3D 0 || host->sd_er=
ror !=3D 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return sh_mmcif_error_manage(host);
>
> wait_event_interruptible_timeout() will return early with -ERESTARTSY=
S
> if the calling process gets signalled (eg, ^C was hit).
>
> The driver uses wait_event_interruptible_timeout() rather a lot and t=
he
> two sites I looked at seem to handle the signal_pending() case
> correctly.
>
> But incorrectly handling signals with interruptible waits is a
> frequently-occurring error in drivers. =A0Did you deliberately cater =
for
> this case, and have you runtime tested it?

My plan is to use this driver on SH-Mobile ARM (sh7372), and I'd be
happy to fix up the driver to become a bit less non-standard wrt
blocking compared to the other MMC host drivers. Is it possible that
Goda-san fixes up whatever minor bits that need rework and that you
pick up at that point?

I'd like to rework the MMCIF blocking code and perhaps also add
dmaengine support as feature patches on top of Goda-sans work if
that's ok with you. Better PM is also on the TODO. Not sure if any of
these features will make it in time for the 2.6.35 merge window
though.

It would be very useful to have the MMCIF driver as-is in 2.6.35
mainline to begin with if possible. Or do you think the driver needs
to be reworked more before that can happen?

Thanks,

/ magnus
