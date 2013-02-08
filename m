From: merez@codeaurora.org
Subject: Re: [PATCH v9 0/2] mmc: support packed command feature of eMMC4.5
Date: Fri, 8 Feb 2013 11:24:50 -0800
Message-ID: <3f8266829597251169e53b54f796f2b1.squirrel@www.codeaurora.org>
References: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:61032 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760228Ab3BHTYv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Feb 2013 14:24:51 -0500
In-Reply-To: <003001ce0440$04844b40$0d8ce1c0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Maya Erez' <merez@codeaurora.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, "'S, Venkatraman'" <svenkatr@ti.com>, 'Saugata Das' <saugata.das@linaro.org>, 'Namjae Jeon' <linkinjeon@gmail.com>, 'Arnd Bergmann' <arnd.bergmann@linaro.org>

Hi Seungwon Jeon,

Your findings on the packed reads are very interesting. Thanks for shar=
ing.

Regarding the write packing:
We tested the write packing feature on 4 different card vendors with
msm_sdcc controller, using the following benchmarks:
tiotest seq: 	tiotest -t 1 -d /data -f 800 -b $((512*1024)) -k 1 -k 3
tiotest rand:	tiotest -t 4 -d /data -f 800 -b 4096 -k 2 -k 0 -p -s 2012=
 -r
12500 -n 20
lmdd write: lmdd if=3Dinternal of=3D/data/push1 bs=3D128k count=3D2000 =
sync=3D1
iozone (many flushes): iozone -i0 -i2 -r4k =96s100m -O -o -I -f /data/f=
ile3
iozone:	iozone -i0 -i2 -r4k =96s100m -O -I -f /data/file3

Our conclusions are as follows:
- In case the card supports write packing in API level only, there is n=
o
improvement
- Some of cards benefit from the write packing for sequential scenarios
(~30% improvement)
- Some of the cards benefit from the write packing for random scenarios
(with tiotest we could even see doubling the performance with write
packing)

All the above tests were performed with HS-200.

The results were collected using the previous version of the patch.
I have a very busy week and I=92m not sure I will be able to test the n=
ew
version of the patch. I will make an effort to test it as soon as I hav=
e
some free time.

Thanks,
Maya

> This patch-set adds support of packed command feature for eMMC4.5 dev=
ices.
> Specially, packed write is introduced.
>
> Seeing the NAND flash, write is expensive operation including the blo=
ck
> management internally.
> Because write data cannot be overwritten on the NAND cell, additional
> operation is needed.
> Overhead of the management can be reduced with once large write size
> rather than several data of small size.
> That is when writing large amounts of data, eMMC gives a significant =
speed
> advantage.
> Packed write can help it by gathering the data. Actually we got the
> performance gain.
> For experiments, three eMMCs of different type from two vendor are us=
ed.
>
> Additionally, there is a interesting result for packed read.
> Packed read has been excluded from whole patch-set with a performance
> regression conclusively.
> I found the reason for this regression. As we know, asynchronous tran=
sfer
> improves the performance
> over than 20% for the read.  And I found that packed read actually gi=
ves
> performance gain of 2%
> only if asynchronous transfer is disabled. This shows that asynchrono=
us
> transfer is more effective
> than packed read although packed read is a bit useful.
>
> When several requests is packed for read, asynchronous transfer doesn=
't
> occur. That is packed read replaces
> asynchronous transfer. Choice of packed read equals to the abandonmen=
t of
> asynchronous transfer.
> This also means the abandonment of performance advantage. As a result=
,
> asynchronous transfer is currently
> best choice regarding the read.
>
> Changes in v9:
> 	- Rebase with the latest mmc.
> 	- Rework including reconstitution of data struct, on the whole.
> 	* Extend the number of blocks for packed header considering large se=
ctor
> (according to the eMMC 4.51)
> 	* Use flag of mmc_blk_data to identify permission of packed command.
> 	* Check the max commands strictly conforming to mandatory minimum va=
lues
> of spec.
> 	Note: These patch-set is dependant in the following patch.
> 	[PATCH 2/2] mmc: block: don't start new request when the card is rem=
oved
>
> Changes in v8:
> 	- Ensure the alignment of sector size for native 4KB sector
> 	  in command packing(from Subhash Jadavani)
> 	- Exclude packed read in this phase due to performance issue.
>
> Changes in v7:
> 	- Break the endless execution in some error handling(from Maya Erez)=
=2E
> 	- Change the condition for enabling packed command(from Subhash
> Jadavani).
> 	- Spilt the error related routine from mmc_blk_issue_rw_rq.
>
> Changes in v6:
> 	- Split the patch for packed read.
> 	- Remove the unnecessary code.
>
> Changes in v5:
> 	- Revert "Add a variable member in mmc_host for minimum number of pa=
cked
> entries".
> 	- Fix the partial packed command from failure index.
> 	- Clean an unnecessary parameter of mmc_blk_packed_hdr_wrq_prep
> 	- Clean warning of checkpatch.
>
> Changes in v4:
> 	- Add Data-tag as CMD23 argument for packed header.
> 	- Separate the capability of MMC_CAP2_PACKED_CMD into read and write=
=2E
> 	- Remove unncessary initial value.
>
> Changes in v3:
> 	- Add a variable member in mmc_host for minimum number of packed ent=
ries.
> 	  This value can be overridden by host.
> 	- Fix a handling of error sequence.
>
> Changes in v2:
> 	- Fix the packed read sequence and error handling.
> 	- Apply checking the exception status for all cases with
> 	  the comments from Maya Erez and Sahitya Tummala.
> 	- Fix preparing the packed list with the comment from Maya Erez and
> Venkatraman.
>
> Seungwon Jeon (2):
>       mmc: add packed command feature of eMMC4.5
>       mmc: support packed write command for eMMC4.5 device
>
> drivers/mmc/card/block.c   |  454
> ++++++++++++++++++++++++++++++++++++++++++--
> drivers/mmc/card/queue.c   |   96 +++++++++-
> drivers/mmc/card/queue.h   |   22 ++
> drivers/mmc/core/mmc.c     |   28 +++
> drivers/mmc/core/mmc_ops.c |    1 +
> include/linux/mmc/card.h   |    8 +
> include/linux/mmc/core.h   |    4 +
> include/linux/mmc/host.h   |    9 +
> include/linux/mmc/mmc.h    |   15 ++-
> 9 files changed, 618 insertions(+), 19 deletions(-)
>
> Thanks,
> Seungwon Jeon
> --
> 1.7.2.3
>
>
>


--=20
Maya Erez
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center, Inc. is a mem=
ber
of Code Aurora Forum, hosted by The Linux Foundation

