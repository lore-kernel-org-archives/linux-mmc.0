From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 0/4 v7] mmc: tmio, sdhi: provide multiple irq handlers
Date: Wed, 24 Aug 2011 18:47:40 +0900
Message-ID: <CANqRtoSg2+9sVmBU0H5Si4-faqqeYvXoyCpjqs1tvx_mmLSZGQ@mail.gmail.com>
References: <1313740642-18307-1-git-send-email-horms@verge.net.au>
	<20110824053711.GB17212@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110824053711.GB17212@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 24, 2011 at 2:37 PM, Simon Horman <horms@verge.net.au> wrot=
e:
> On Fri, Aug 19, 2011 at 04:57:18PM +0900, Simon Horman wrote:
>> The SDHI driver already supports making use of up to three interrupt
>> sources.
>>
>> This series breaks up the existing interrupt handler into three hand=
lers,
>> one for card access, one for card detect interrupts, and one for SDI=
O
>> interrupts. =A0A cover-all handler, which makes use of these new bro=
ken-out
>> handlers is provided for for the case where there is only one interr=
upt
>> source.
>>
>> This series also wires up the broken-out irq handlers in the SDHI dr=
iver
>
> Magnus, Guennadi,
>
> when you get a chance could I get an ack or otherwise on these change=
s.

Hi Simon,

Your latest revision of SDHI patches looked very good, thanks for your =
effort!

I prefer to give acks to each of the patches individually if possible,
but I'm a bit confused by all the versions floating around. So for
now, please add my acked-by for all patches in this series.

In the future, please consider a) including version number in the
subject of the patch email and b) including a list of all the patches
(including version) in [PATCH 0/...]. That will make it easier to
track down each individual patch.

Thank you!

/ magnus
