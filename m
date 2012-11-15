From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v8 2/2] mmc: support packed write command for eMMC4.5 device
Date: Thu, 15 Nov 2012 19:05:28 +0900
Message-ID: <002901cdc318$bd9c7030$38d55090$%jun@samsung.com>
References: <c990a66b72acaaf514c4ff2cbbcd6236.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45018 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992967Ab2KOKFb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Nov 2012 05:05:31 -0500
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MDI0077RXCLEC10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Nov 2012 19:05:30 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MDI00IXRXD5XZ40@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 15 Nov 2012 19:05:29 +0900 (KST)
In-reply-to: <c990a66b72acaaf514c4ff2cbbcd6236.squirrel@www.codeaurora.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: merez@codeaurora.org, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>

Hi Maya,

Thanks to remind it.
I'm struggling with something. I didn't check more since v8.

Hi Chris,

As we know, nand flash write is slower than read, because write is cost=
ly operation.
Write operation need block erase operation. Of course, if there is free=
 block to write, erase will not happen.
In worst case, write operation may include copy exiting data as well as=
 block erase block.
So, in the block management of nand, several data of small size is disa=
dvantageous for write.
That is when writing large amounts of data, eMMC give it a significant =
speed advantage.
Packed write can help it by gathering the data. Actually we got the per=
formance gain.

There are several bus speed mode. Such as HS200 mode, clock speed is up=
 to 200MHz.
However, with little or no effect for write performance. ASYNC transfer=
 patch is the same.
I think packed wrtie is a candidate which can improve write performance=
 just now.

If you want to find the write improvement, you need to check the follow=
ing two parameters.
	/sys/block/mmcblk0/queue/max_hw_sectors_kb
	/sys/block/mmcblk0/queue/max_sectors_kb
'max_hw_sectors_kb' is maximum size which host controller can gather in=
 device driver.
If this size is large enough, performance effect may not be shown notic=
eably.

Thanks,
Seungwon Jeon
On Wednesday, November 14, 2012, merez@codeaurora.org wrote:
> Hi Chris,
>=20
> The amount of improvement from the packed commands, as from any other
> eMMC4.5 feature, depends on several parameters:
> 1. The card support of this feature. If the card supports only the fe=
ature
> interface, then you'll see no improvement when using the feature.
> 2. The benchmark tool used. Since the packed command preparation is
> stopped due to a FLUSH request, a benchmark that issues many FLUSH
> requests can result in a small amount of packing and you will see no
> improvement.
>=20
> You can use the following patch to get the packed commands statistics=
:
> http://marc.info/?l=3Dlinux-mmc&m=3D134374508625826&w=3D2
> With this patch you will be able to see the amount of packing and wha=
t
> caused the packed preparation to stop.
>=20
> We tested the packed commands feature with SanDisk cards and got
> improvement of 30% when using lmdd and tiotest. We don't use iozone f=
or
> sequential tests but if you'll send me the exact command that you use=
 we
> can try it as well.
>=20
> It is true that packed commands can cause degradation of read in
> read-write collisions. However, it is only nature that when having lo=
nger
> write request a read request has to wait for a longer time and its la=
tency
> will increase. I believe that it is not our duty to decide if this is=
 a
> reason to exclude this feature. Everyone should take its own decision=
 if
> he wants to benefit from the write improvement, while risking the
> read-write collisions scenarios.
> eMMC4.5 introduces the HPI and stop transmission to overcome the
> degradation of read latency due to write (regardless of the packed
> commands).
> The packing control is our own enhancement that we believe can also b=
e
> used to overcome this degradation. It is tunable and requires a speci=
fic
> enabling, so it can be the developer=92s decision whether to use it o=
r not.
> Since it is not a standard feature we can discuss separately if it sh=
ould
> be accepted or not and what is the best way to use it.
>=20
> Packed commands is not the only eMMC4.5 feature that can cause degrad=
ation
> in specific scenarios. If we will look at the cache feature, it cause=
s
> degradation by almost a half in random operations when FLUSH is being
> used.
> When using the following iozone command when cache is enabled, you wi=
ll
> see degradation in the iozone results:
> ./data/iozone -i0 -i2 -r4k -s50m -O -o -I -f /data/mmc0/file3
> However, cache support was accepted regardless of this degradation an=
d it
> is the developer=92s responsibility to decide if to use this feature =
or not.
>=20
> To summarize, all eMMC4.5 features that were added are tunable and
> disabled by default.
> I believe that when someone would enable a certain feature he will do=
 all
> the required testing for determining if he can benefit from this feat=
ure
> or not in his own environment.
>=20
> Thanks,
> Maya
>=20
> On Tue, November 13, 2012 6:54 pm, Chris Ball wrote:
> > Hi Maya,
> >
> > On Sun, Nov 04 2012, merez@codeaurora.org wrote:
> >> Packed commands is a mandatory eMMC4.5 feature and is supported by=
 all
> the card vendors.
> >
> > We're still only talking about using packed writes, though, right?
> >
> >> It wa proven to be beneficial for eMMC4.5 cards and harmless for n=
on
> eMMC4.5 cards.
> >
> > My understanding is that write packing causes a regression in read
> performance that can be tuned/fixed by your num_wr_reqs_to_start_pack=
ing
> tunable (and read packing causes a read regression with current eMMC =
4.5
> cards).  Is that wrong?
> >
> >> I don't see a point to hold it back while it can be enabled or
> >> disabled by a flag and most of the code it adds is guarded in spec=
ific
> functions and is not active when packed commands is disabled.
> >
> > Earlier in the thread I wrote:
> >
> >>> * I still don't have a good set of representative benchmarks show=
ing
> >>>   what kind of performance changes come with this patchset. It se=
ems
> like we've had a small amount of testing on one controller/eMMC part
> combo from Seungwon, and an entirely different test from Maya, and
> the results aren't documented fully anywhere to the level of
> describing what the hardware was, what the test was, and what the
> results were before and after the patchset.
> >
> > I still feel this way.  I'm worried that we might be merging code t=
hat
> works well on your controller/card but causes large regressions for
> everyone else.  I don't want to handle this by making a tunable that
> everyone has to tune for their system, because I don't think anyone w=
ill
> tune it.  I don't think that shipping a capability that will probably
> lead to performance regressions if you turn it on is a good idea.
> >
> > I'm in a better position to help now, though -- I have some motherb=
oards
> with Marvell SoCs and a socketed eMMC slot, and I have eMMC 4.5 parts
> from Sandisk and Toshiba.  So I can try to help work out how
> > generalizable your results are across other controllers and cards.
> >
> > So far I've only tried the Sandisk part, but it didn't show any wri=
te
> improvement with write packing.  I've verified that the switch comman=
d
> to turn on packed_event_en happens and succeeds, and that the caps ar=
e
> set correctly, so I'm not sure what's wrong yet.  With iozone I get:
> >
> >                        KB  reclen   write rewrite
> > Unpacked writes:    10240    8192   17250   16794
> > Packed writes:      10240    8192   16930   17353
> >
> > I'll try the Toshiba part next, and I'll start using lmdd as well a=
s
> iozone.  Any ideas on why I might not be seeing improvements with
> Sandisk?
> >
> > I'm not opposed to merging packed write support in principle, I jus=
t
> want to be convinced that we're not causing regressions for most user=
s
> who turn it on.  (And more than that, I want to see that it leads to
> improvements that make it worth adding the code complexity for.)
> >
> > Thanks,
> >
> > - Chris.
> > --
> > Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> > One Laptop Per Child
> >
>=20
>=20
> --
> QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a m=
ember
> of Code Aurora Forum, hosted by The Linux Foundation
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

