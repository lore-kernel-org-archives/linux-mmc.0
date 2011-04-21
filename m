From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Thu, 21 Apr 2011 17:11:15 +0800
Message-ID: <20110421091115.GH4024@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
 <20110417164830.GE17935@S2100-06.ap.freescale.net>
 <BANLkTimwvX633UaUoc4P4DD1xnpLbMTrZA@mail.gmail.com>
 <20110420140120.GF1965@S2100-06.ap.freescale.net>
 <BANLkTimzk89VC1Vti4CZ60TTJ20e2YpwNg@mail.gmail.com>
 <20110421062924.GB4024@S2100-06.ap.freescale.net>
 <BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:23376 "EHLO
	TX2EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab1DUJHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 05:07:20 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimq8_R-CJmryTvRWHZ+-2vqj-Y6cQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, linaro-kernel@lists.linaro.org, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Thu, Apr 21, 2011 at 10:46:18AM +0200, Per Forlin wrote:
> On 21 April 2011 08:29, Shawn Guo <shawn.guo@freescale.com> wrote:
> > On Wed, Apr 20, 2011 at 05:30:22PM +0200, Per Forlin wrote:
> > [...]
> >> Remove dma_map and dma_unmap from your host driver and run the tes=
ts
> >> (obviously nonblocking and blocking will have the same results). I=
f
> >> there is still no performance gain the cache penalty is very small=
 on
> >> your platform and therefore nonblocking doesn't improve things muc=
h.
> >> Please let me know the result.
> >>
> > Sorry, I could not understand. =A0What's the point to run the test =
when
> > the driver is even broken. =A0The removal of =A0dma_map_sg and
> > dma_unmap_sg makes mxs-mmc host driver broken.
> The point is only to get a measurement of the cost of handling
> dma_map_sg and dma_unmap_sg, this is the maximum time mmc nonblocking
> can save.
> The nonblocking mmc_test should save the total time of dma_map_sg and
> dma_unmap_sg, if the pre_req and post_req hooks are implemented
> correctly.
> Running without dma_map_sg and dma_unmap_sg will confirm if the
> pre_req and post_req hooks are implemented correctly.
>=20
With dma_map_sg and dma_unmap_sg removed, the mmc_test gave very low
numbers, though blocking and non-blocking numbers are same.  Is it
an indication that pre_req and post_req hooks are not implemented
correctly?  If yes, can you please help to catch the mistakes?

Thanks.

mc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 56.875013015 s=
econds (2
359 kB/s, 2304 KiB/s, 576.14 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 47.407562500 =
seconds (
2831 kB/s, 2764 KiB/s, 345.59 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 42.708718750 s=
econds (3
142 kB/s, 3068 KiB/s, 191.81 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 40.227125000 s=
econds (3
336 kB/s, 3258 KiB/s, 101.82 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 38.915750000 =
seconds (
3448 kB/s, 3368 KiB/s, 52.62 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 38.249562498=
 seconds
(3509 kB/s, 3426 KiB/s, 26.77 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 37.912342548 s=
econds (3
540 kB/s, 3457 KiB/s, 13.50 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 37.743876391 =
seconds (
3556 kB/s, 3472 KiB/s, 6.78 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 37.658104019=
 seconds
(3564 kB/s, 3480 KiB/s, 3.39 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 37.086429038 s=
econds (3
569 kB/s, 3486 KiB/s, 1.05 IOPS)
mmc0: Result: OK
mmc0: Test case 40. Read performance with none blocking req 4k to 4MB..=
=2E
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 56.732932555 s=
econds (2
365 kB/s, 2310 KiB/s, 577.58 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 47.342812500 =
seconds (
2835 kB/s, 2768 KiB/s, 346.07 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 42.673906250 s=
econds (3
145 kB/s, 3071 KiB/s, 191.96 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 40.208218750 s=
econds (3
338 kB/s, 3259 KiB/s, 101.86 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 38.906750000 =
seconds (
3449 kB/s, 3368 KiB/s, 52.63 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 38.244749999=
 seconds
(3509 kB/s, 3427 KiB/s, 26.77 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 37.909719946 s=
econds (3
540 kB/s, 3457 KiB/s, 13.50 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 37.741834105 =
seconds (
3556 kB/s, 3472 KiB/s, 6.78 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 37.657555456=
 seconds
(3564 kB/s, 3480 KiB/s, 3.39 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 37.086351431 s=
econds (3
569 kB/s, 3486 KiB/s, 1.05 IOPS)
mmc0: Result: OK
mmc0: Tests completed.

--=20
Regards,
Shawn

