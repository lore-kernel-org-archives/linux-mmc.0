From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] [mmc-omap] Add support for 16-bit and 32-bit registers
Date: Wed, 18 Nov 2009 13:09:22 -0800
Message-ID: <6cb013310911181309w6e21b8e9o62fad1a80f300c08@mail.gmail.com>
References: <1258255495.4209.3.camel@runt> <20091118184152.GA6865@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20091118184152.GA6865@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 18, 2009 at 10:41 AM, Ladislav Michl
<Ladislav.Michl@seznam.cz> wrote:
> On Sat, Nov 14, 2009 at 07:24:55PM -0800, Cory Maccarrone wrote:
>> The omap850 and omap730 use 16-bit registers instead of 32-bit, requ=
iring
>> a modification of the register addresses in the mmc-omap driver. =C2=
=A0To
>> make this as portable as possible, I made the following changes:
>
> Hmm, I would not trade portability anyone currently needs for complex=
ity...

Agreed, this solution is more complicated than it probably needs to be.

>
>> * Moved register address offsets from drivers/mmc/host/omap.c to
>> =C2=A0 drivers/mmc/host/omap.h
>> * Implemented a lookup table for 16-bit and 32-bit register offsets
>> * Added a reg_size field in the mmc_omap_host structure
>> * Added code in mmc_omap_probe() to populate the reg_size
>> =C2=A0 field based on processor in use
>> * Added inline function to return the register offset based on
>> =C2=A0 the register size and register name
>> * Modified mmc-omap driver to use the new inline function to call ou=
t
>> =C2=A0 register names
>
> All this could be probably done by making register definition an inde=
x and
> shifting it left by one or two depending on CPU. No lookup table need=
ed.

Ah, good point, I hadn't considered that.  I'll rework my
implementation to do that and resubmit.

>
>> This change should allow the omap7xx-series of processors to correct=
ly
>> utilize the MMC driver.
>
> Did you test it? It does not work on 5910, see here:
> http://thread.gmane.org/gmane.linux.kernel.mmc/649

Not sure why it wouldn't work on the 5910.  I tested it on my device,
and it works properly for me, but then I don't have an omap-based
device that uses 32-bit register definitions.  I'm confused at the
post you have above though...Is that with my patch, or is that with
something else?  It seems to reference the status of current git,
which I don't think this patch shouldn't be in.

- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
