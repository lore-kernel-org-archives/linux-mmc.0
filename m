From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Mon, 18 Apr 2011 00:48:31 +0800
Message-ID: <20110417164830.GE17935@S2100-06.ap.freescale.net>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
 <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:42157
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526Ab1DQQoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Apr 2011 12:44:54 -0400
Content-Disposition: inline
In-Reply-To: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org

On Mon, Apr 18, 2011 at 12:33:30AM +0800, Shawn Guo wrote:
> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> If not calling pre_req() before mxs_mmc_request(), request()
> will prepare the cache just like it did it before.
> It is optional to use pre_req() and post_req().
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mmc/host/mxs-mmc.c |   75 ++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 72 insertions(+), 3 deletions(-)
> 

Here is the result of mmc_test case 37 ~ 40, which are designed to see
the performance improvement introduced by non-blocking changes.

Honestly, the improvement is not so impressive.  Not sure if the patch
for mxs-mmc pre_req and post_req support was correctly produced.  So
please help review ...

mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 76.370031249 seconds (1
757 kB/s, 1716 KiB/s, 429.06 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 34.951875000 seconds (
3840 kB/s, 3750 KiB/s, 468.75 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 19.097406250 seconds (7
028 kB/s, 6863 KiB/s, 428.95 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 14.393937500 seconds (9
324 kB/s, 9106 KiB/s, 284.56 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 12.519875000 seconds (
10720 kB/s, 10469 KiB/s, 163.57 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 11.535156250 seconds 
(11635 kB/s, 11362 KiB/s, 88.77 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 11.165375000 seconds (1
2020 kB/s, 11739 KiB/s, 45.85 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 10.922375001 seconds (
12288 kB/s, 12000 KiB/s, 23.43 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 10.791811701 seconds 
(12436 kB/s, 12145 KiB/s, 11.86 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 10.723858316 seconds (1
2345 kB/s, 12055 KiB/s, 3.63 IOPS)
mmc0: Result: OK
mmc0: Test case 38. Write performance with none blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 75.940425898 seconds (1
767 kB/s, 1725 KiB/s, 431.49 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 34.650031250 seconds (
3873 kB/s, 3782 KiB/s, 472.84 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 18.854781250 seconds (7
118 kB/s, 6951 KiB/s, 434.47 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 14.183781250 seconds (9
462 kB/s, 9240 KiB/s, 288.78 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 12.349375000 seconds (
10868 kB/s, 10613 KiB/s, 165.83 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 11.373031250 seconds 
(11801 kB/s, 11524 KiB/s, 90.03 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 10.991343750 seconds (1
2211 kB/s, 11925 KiB/s, 46.58 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 10.759218749 seconds (
12474 kB/s, 12182 KiB/s, 23.79 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 10.628342707 seconds 
(12628 kB/s, 12332 KiB/s, 12.04 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 10.547394289 seconds (1
2551 kB/s, 12257 KiB/s, 3.69 IOPS)
mmc0: Result: OK
mmc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 23.516885650 seconds (5
707 kB/s, 5573 KiB/s, 1393.38 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 13.651000000 seconds (
9832 kB/s, 9601 KiB/s, 1200.20 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 9.048625000 seconds (14
832 kB/s, 14485 KiB/s, 905.33 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 6.589500000 seconds (20
368 kB/s, 19891 KiB/s, 621.59 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 5.292437500 seconds (2
5360 kB/s, 24765 KiB/s, 386.96 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 4.646156250 seconds (
28887 kB/s, 28210 KiB/s, 220.39 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 4.319437500 seconds (31
072 kB/s, 30344 KiB/s, 118.53 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 4.158187500 seconds (3
2277 kB/s, 31521 KiB/s, 61.56 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 4.076250000 seconds (
32926 kB/s, 32155 KiB/s, 31.40 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 3.966816444 seconds (33
373 kB/s, 32591 KiB/s, 9.83 IOPS)
mmc0: Result: OK
mmc0: Test case 40. Read performance with none blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 23.251465475 seconds (5
772 kB/s, 5637 KiB/s, 1409.28 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 13.411468750 seconds (
10007 kB/s, 9773 KiB/s, 1221.64 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.822875000 seconds (15
212 kB/s, 14855 KiB/s, 928.49 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 6.413406250 seconds (20
927 kB/s, 20437 KiB/s, 638.66 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 5.127875000 seconds (2
6174 kB/s, 25560 KiB/s, 399.38 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 4.486593750 seconds (
29915 kB/s, 29214 KiB/s, 228.23 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 4.178312500 seconds (32
122 kB/s, 31369 KiB/s, 122.53 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 4.010281250 seconds (3
3468 kB/s, 32683 KiB/s, 63.83 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 3.927437500 seconds (
34174 kB/s, 33373 KiB/s, 32.59 IOPS)
mmc0: Transfer of 39 x 6630 sectors (39 x 3315 KiB) took 3.823653744 seconds (34
623 kB/s, 33811 KiB/s, 10.19 IOPS)
mmc0: Result: OK
mmc0: Tests completed.

-- 
Regards,
Shawn

