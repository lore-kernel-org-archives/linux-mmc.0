From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: mmc sdhci mmcblk0: error -110 sending status command, retrying
Date: Sat, 11 Feb 2012 18:55:24 +0800
Message-ID: <CAAJw_Zu=M7R5cyVRmbd3Tz7MipgX_b5J4g5Z4m+SsiHP-3Uxgw@mail.gmail.com>
References: <CAAJw_ZsryUFFFRCKdd9sQ7_38hjpVq37b6hhZDX5=qz8x1B+EQ@mail.gmail.com>
	<m2pqdr2tyq.fsf@bob.laptop.org>
	<CAAJw_Zv4Hk_kfc33xsVcdi-0_C6tsf_FD3sUx1JPDX_fZZMzeQ@mail.gmail.com>
	<4F30E19B.9020503@intel.com>
	<CAAJw_Zth+QM8OhMEWweBBek8QNW_9CseHSDuB-LCGrvwuqfV2A@mail.gmail.com>
	<4F310529.4020101@intel.com>
	<CAAJw_ZsHwdvXuw+edXUfyGOSMOu5oUw3zX8nUryxJJiiZXzXKQ@mail.gmail.com>
	<CAAJw_Zup7Wg7FO95Z63e_sniu21gyzdCjcBNgsS0aw6MguDwLw@mail.gmail.com>
	<CAAJw_Zv6HkLLqEzNKRCfQ7EbMNEVe_hzbW+mHOnDAWLidOhMBQ@mail.gmail.com>
	<CAAJw_Zs7aET=vdy033bzuHwW==uS8AW78NSvD2L_hjU+Mzp-_w@mail.gmail.com>
	<4F31B789.9020509@samsung.com>
	<CAAJw_ZtnWYxGCm5Vm5CQ1GBLc=GU7AGiQKe_-9LJsbMW+YG-GQ@mail.gmail.com>
	<15D4F59C-7AFA-456E-8A5F-9E11EE9B9717@marvell.com>
	<CAAJw_Zs+Jz9WiJd6254Zkj+Y76w9W3CqZTgGrLYRRsjuxnqTyw@mail.gmail.com>
	<4B11A480-8122-4A0B-A0EE-E1E95477F985@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B11A480-8122-4A0B-A0EE-E1E95477F985@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <cjb@laptop.org>, Pierre Ossman <pierre@ossman.eu>, lkml <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arindam.nath@amd.com" <arindam.nath@amd.com>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, Feb 11, 2012 at 4:28 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On Feb 10, 2012, at 8:18 AM, Jeff Chua wrote:
>
>> On Thu, Feb 9, 2012 at 3:09 AM, Philip Rakity <prakity@marvell.com> =
wrote:
>>>
>>>
>>> Jeff,
>>>
>>> I think the sdhci.c clock setting code was changed a while ago. =A0=
 Maybe revert that mod and see what happens.
>>>
>>> The card is a 24MHz which is rather slow so I would be surprised if=
 that was it.
>>> The other option is the force enable the High Speed bit in the =A0c=
ontroller (used when speed is 25MHz or faster). =A0Will give the system=
 more time (in theory) to work.
>>
>> That's a good point to start looking. I poked around and by setting
>> host->ios.clock to 10000000 instead of 25000000, read from a 16GB ca=
rd
>> is no longer giving any error.
>>
>> I still don't dare to do any write. Already burn one 16GB SD and not
>> ready to trash another. I asked earlier but haven't got any reply as
>> to how to recover an SD that says "No medium found". Any chance of
>> recovering it?
>>
>> Here's what I did. If set too low (1000000) or too high (25000000),
>> random errors appeared.
>>
>> --- linux/drivers/mmc/core/core.c.org =A0 2012-02-10 23:57:49.000000=
000 +0800
>> +++ linux/drivers/mmc/core/core.c =A0 =A0 =A0 2012-02-10 23:53:59.00=
0000000 +0800
>> @@ -881,7 +881,7 @@
>> =A0 =A0 =A0 =A0if (hz > host->f_max)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hz =3D host->f_max;
>>
>> - =A0 =A0 =A0 host->ios.clock =3D hz;
>> + =A0 =A0 =A0 host->ios.clock =3D 10000000;
>> =A0 =A0 =A0 =A0mmc_set_ios(host);
>> }
>>
>>
>
> good news. =A0The other possibility but unlikely is that the timeout =
is too low for the card.
>
> There is a quirk for this.
>
> SDHCI_BROKEN_TIMEOUT_VAL
>
> my guess is that you will need to measure the clk pin and see if it m=
atches the frequency being programmed. =A0(could be less).
>
> a simple hack is to add a printk to set_ios() or set_clock() and prin=
t out the clock rate clock register (divider) and see if they match wha=
t you should be seeing.
> It is possible the bug is NOT in this area but in the platform code w=
here an incorrect base freq is being setup for the controller.

sdhci: Secure Digital Host Controller Interface driver
sdhci: Copyright(c) Pierre Ossman
sdhci-pci 0000:0d:00.0: SDHCI controller found [1180:e823] (rev 4)
Registered led device: mmc0::
mmc0: clock 0Hz busmode 1 powermode 0 cs 0 Vdd 0 width 0 timing 0
mmc0: SDHCI controller on PCI [0000:0d:00.0] using DMA
mmc0: clock 0Hz busmode 2 powermode 1 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 20 width 0 timing 0
mmc0: clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing 0
hz 25000000 min 16129 max 33000000 ios 400000
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 0 timing=
 0
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing=
 0
mmc0: new SDHC card at address b368
mmcblk0: mmc0:b368 H1109 14.9 GiB (ro)
mmcblk0: p1
mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 0
hz 10000000 min 16129 max 33000000 ios 0
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing=
 0
mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 0
hz 10000000 min 16129 max 33000000 ios 0
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing=
 0
mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 0
hz 10000000 min 16129 max 33000000 ios 0
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing=
 0
mmc0: clock 0Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing 0
hz 10000000 min 16129 max 33000000 ios 0
mmc0: clock 10000000Hz busmode 2 powermode 2 cs 0 Vdd 20 width 2 timing=
 0


Hope this helps. Also, I've tried setting hz to 20000000 but
encountered random errors.

Also, these are from dmesg ...

Detected 2790.999 MHz processor.
Calibrating delay loop (skipped), value calculated using timer
frequency.. 5581.99 BogoMIPS (lpj=3D27909990)
pci 0000:0d:00.0: [1180:e823] type 0 class 0x000880
pci 0000:0d:00.0: MMC controller base frequency changed to 50Mhz.
pci 0000:0d:00.0: reg 10: [mem 0xf1500000-0xf15000ff]
pci 0000:0d:00.0: supports D1 D2
pci 0000:0d:00.0: PME# supported from D0 D1 D2 D3hot D3cold


=2Econfig
CONFIG_NO_HZ=3Dy
CONFIG_HZ_100=3Dy



Thanks,
Jeff
