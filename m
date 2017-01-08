From: =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 1/5] drivers: mmc: sunxi: fix A64
 calibration routine
Date: Sun, 8 Jan 2017 23:56:49 +0000
Message-ID: <95b2e25c-da97-4136-3c49-ff8ecf011c14@arm.com>
References: <1483398226-29321-1-git-send-email-andre.przywara@arm.com>
 <1483398226-29321-2-git-send-email-andre.przywara@arm.com>
 <20170105174725.kmr25iodjnjozqjm@lukather>
Reply-To: andre.przywara-5wv7dgnIgG8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDNZNK75ZIKRBTNDZPBQKGQE7E6SCMQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20170105174725.kmr25iodjnjozqjm@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 05/01/17 17:47, Maxime Ripard wrote:

Hi,

> On Mon, Jan 02, 2017 at 11:03:42PM +0000, Andre Przywara wrote:
>> The calibration facility in the A64 MMC block seems to have been
>> misunderstood: the result value is not the value to program into the
>> delay bits, but is the number of delay cells that result in a full clock
>> cycle delay. So this value has to be scaled by the desired phase, which
>> we still have to know and program.
>> Change the calibration routine to take a phase parameter and scale the
>> calibration value accordingly.
>> Also introduce sun50i-a64 delay parameters to store the required phase.
>> Looking at the BSP kernel the sample delay for anything below HS200 is
>> 0, so we go with that value.
>> Once the driver supports HS200 and faster modes, we can enter confirmed
>> working values in there.
>>
>> Signed-off-by: Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
> 
> Exactly how that works hasn't been confirmed, and the only thing that
> this patch actually do is... nothing, since the delay is always 0. If
> and when we get HS400 to work and we know for a fact how the
> calibration works, then we'll be able to use it. Until then, we can
> just clear those bits.

Fair enough, though I am a bit puzzled as what to do here now:

Dropping this patch here entirely causes the wrong calibration settings
to degrade the BananaPi eMMC performance by up to 50% (20 MB/s vs.
40MB/s in hdparm, and 25% longer execution time for a "find / -type f |
xargs md5sum > /dev/null" run). So this is not an option.

1) Shall I simply revert Icenowy's original patch that introduced the
calibration function? That should leave the values at their reset value
of 0.  But do we want to make sure that these values are set to 0 by
explicitly zeroing the bits?
Also I guess your HS-400 support will need to write some values in
there, so we will need some code later again?

2) Changing the calibration function to don't do any calibration really
and just write 0 into the delay bits seems like an option, but looks a
bit weird. Also I guess your faster transfer modes support will need to
write _something_, though I don't know what those values are and where
they will come from.

So I am leaning towards 1) for now, unless you send your MMC patches and
we at least merge the patch dealing with the calibration part for the
next release.

Any recommendations? I would love to see the MMC support go into 4.11.

Cheers,
Andre.
