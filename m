From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Sun, 12 Dec 2010 14:03:52 +0000
Message-ID: <AANLkTinMYeWNLu8e7xyBTvjmeFMsJ5sDGtsCesu04d4K@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
	<AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
	<20101209160157.GA28586@void.printf.net>
	<AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com>
	<20101211192320.GA24430@void.printf.net>
	<AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
	<20101212135224.GA31812@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20101212135224.GA31812@void.printf.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Sun, Dec 12, 2010 at 1:52 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi Will,
>
> On Sun, Dec 12, 2010 at 10:57:44AM +0000, Will Newton wrote:
>> > drivers/mmc/host/dw_mmc.c: In function =91dw_mci_pull_data64=92:
>> > drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of func=
tion =91__raw_readq=92
>> >
>> > because arch/arm doesn't implement raw versions of these 64-bit ac=
cesses.
>> > I'm surprised that this driver hasn't been compiled on ARM before!=
 =A0What
>>
>> That particular bit of code has been added since it was last built f=
or
>> arm. Our architecture can do 64bit accesses so we implement readq.
>> Unfortunately there doesn't seem to be a sane way to conditionalize
>> code for architectures that have or don't have readq, so I suspect
>> I'll have to just remove that branch of the if statement for now.
>
> (Russell, thanks for the excellent explanation.)
>
> Other drivers (MTD, gpio/basic_mmio_gpio.c, fs/fuse, pcm_oss.c)
> conditionalize uses of {read,write}q on BITS_PER_LONG >=3D 64, so
> something like this:

I don't think that's going to work, BITS_PER_LONG isn't equivalent to
"can do 64bit IO accesses", at least it isn't on our architecture. x86
is in the same situation it would appear, although x86 does explicitly
#define readq so it may be possible to #ifdef on that?
