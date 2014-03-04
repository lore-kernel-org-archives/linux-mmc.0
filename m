From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci: add quirk for broken write protect detection
Date: Tue, 04 Mar 2014 22:06:31 +0200
Message-ID: <53163247.8000904@gmail.com>
References: <1393759200-22819-1-git-send-email-eli.billauer@gmail.com>
 <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <74003aec-1707-4f43-b947-df148d573fa1@TX2EHSMHS038.ehs.local>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?U8O2cmVuIEJyaW5rbWFubg==?= <soren.brinkmann@xilinx.com>
Cc: chris@printf.net, michal.simek@xilinx.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-mmc@vger.kernel.org

Hello S=C3=B6ren,

wp-inverted solves the practical problem indeed, and fools the driver=20
into thinking that the card has an inverted write protection sensor, an=
d=20
the logic zero that it finds in the hardware register means that the=20
card isn't write protected.

I'm insisting on this patch, because I think that the device tree shoul=
d=20
describe the hardware as it is, and not fool the driver into behaving=20
the way we want it to. These tricks always bite back later on.

Regards,
    Eli

On 04/03/14 21:26, S=C3=B6ren Brinkmann wrote:
> Hi Eli,
>
> On Sun, 2014-03-02 at 01:20PM +0200, Eli Billauer wrote:
>   =20
>> The write protection signal is absent on a board based upon Xilinx' =
Zynq
>> processor ("ZyBo"). This leads the kernel to think that the MicroSD =
card is
>> write protected, and causes a kernel panic during boot, as root fail=
s to
>> mount RW.
>>     =20
> I talked to some people here at Xilinx. According to them, you have t=
he
> option to pin out the WP signal, which would mean the board needs to
> tie/connect the signal properly. Or, if you select to not pin out the=
 WP
> signal, it should be tied to 0 within the chip.
> Currently, I have some doubts that is the case, since Mike reported t=
he
> same issue, but would you mind double checking?
> In theory the signal should default to logic zero which would at most
> require to add the, already existing, 'wp-inverted' quirk when using
> micro-sd on Zynq.
>
> 	Thanks,
> 	S=C3=B6ren
>
>
>
>   =20
