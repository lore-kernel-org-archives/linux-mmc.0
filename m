From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH 0/5] mmc: add double buffering for mmc block requests
Date: Wed, 12 Jan 2011 19:24:21 +0100
Message-ID: <AANLkTi=c13d-hbrS565M8c1UOyv6vGh27yzWK3tt9AVD@mail.gmail.com>
References: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62192 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab1ALSYW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 13:24:22 -0500
In-Reply-To: <1294856043-13447-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev <linaro-dev@lists.linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@linaro.org>

I mistyped the linaro email in this patch series.

Sorry for the mess
/Per

On 12 January 2011 19:13, Per Forlin <per.forlin@linaro.org> wrote:
> Add support to prepare one MMC request while another is active on
> the host. This is done by making the issue_rw_rq() asynchronous.
> The increase in throughput is proportional to the time it takes to
> prepare a request and how fast the memory is. The faster the MMC/SD i=
s
> the more significant the prepare request time becomes. Measurements o=
n U5500
> and U8500 on eMMC shows significant performance gain for DMA on MMC f=
or large
> reads. In the PIO case there is some gain in performance for large re=
ads too.
> There seems to be no or small performance gain for write, don't have =
a good
> explanation for this yet.
>
> There are two optional hooks pre_req() and post_req() that the host d=
river
> may implement in order to improve double buffering. In the DMA case p=
re_req()
> may do dma_map_sg() and prepare the dma descriptor and post_req runs =
the
> dma_unmap_sg.
>
> The mmci host driver implementation for double buffering is not inten=
ded
> nor ready for mainline yet. It is only an example of how to implement
> pre_req() and post_req(). The reason for this is that the basic DMA s=
upport
> for MMCI is not complete yet. The mmci patches are sent in a separate=
 patch
> series "[FYI 0/4] arm: mmci: example implementation of double bufferi=
ng".
>
> Issues/Questions for issue_rw_rq() in block.c:
> * Is it safe to claim the host for the first MMC request and wait to =
release
> =A0it until the MMC queue is empty again? Or must the host be claimed=
 and
> =A0released for every request?
> * Is it possible to predict the result from __blk_end_request().
> =A0If there are no errors for a completed MMC request and the
> =A0blk_rq_bytes(req) =3D=3D data.bytes_xfered, will it be guaranteed =
that
> =A0__blk_end_request will return 0?
>
> Here follows the IOZone results for u8500 v1.1 on eMMC.
> The numbers for DMA are a bit to good here due to the fact that the
> CPU speed is decreased compared to u8500 v2. This makes the cache han=
dling
> even more significant.
>
> Command line used: ./iozone -az -i0 -i1 -i2 -s 50m -I -f /iozone.tmp =
-e -R -+u
>
> Relative diff: VANILLA-MMC-PIO -> 2BUF-MMC-PIO
> cpu load is abs diff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0random =A0random
> =A0 =A0 =A0 =A0KB =A0 =A0 =A0reclen =A0write =A0 rewrite read =A0 =A0=
reread =A0read =A0 =A0write
> =A0 =A0 =A0 =A051200 =A0 4 =A0 =A0 =A0 +0% =A0 =A0 +0% =A0 =A0 +0% =A0=
 =A0 +0% =A0 =A0 +0% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0-0.1 =A0 =A0-0=
=2E5 =A0 =A0-0.3 =A0 =A0-0.1 =A0 =A0-0.0
>
> =A0 =A0 =A0 =A051200 =A0 8 =A0 =A0 =A0 +0% =A0 =A0 +0% =A0 =A0 +6% =A0=
 =A0 +6% =A0 =A0 +8% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0-0.1 =A0 =A0-0=
=2E3 =A0 =A0-0.4 =A0 =A0-0.8 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 16 =A0 =A0 =A0+0% =A0 =A0 -2% =A0 =A0 +0% =A0=
 =A0 +0% =A0 =A0 -3% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0-0.2 =A0 =A0+0=
=2E0 =A0 =A0+0.0 =A0 =A0-0.2 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 32 =A0 =A0 =A0+0% =A0 =A0 +1% =A0 =A0 +0% =A0=
 =A0 +0% =A0 =A0 +0% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0+0.0 =A0 =A0-0=
=2E3 =A0 =A0+0.0 =A0 =A0+0.0 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 64 =A0 =A0 =A0+0% =A0 =A0 +0% =A0 =A0 +0% =A0=
 =A0 +0% =A0 =A0 +0% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0+0.0 =A0 =A0+0=
=2E0 =A0 =A0+0.0 =A0 =A0+0.0 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 128 =A0 =A0 +0% =A0 =A0 +1% =A0 =A0 +1% =A0 =
=A0 +1% =A0 =A0 +1% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.2 =A0 =A0+0=
=2E1 =A0 =A0-0.3 =A0 =A0+0.4 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 256 =A0 =A0 +0% =A0 =A0 +0% =A0 =A0 +1% =A0 =
=A0 +1% =A0 =A0 +1% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0-0.0 =A0 =A0+0=
=2E1 =A0 =A0+0.1 =A0 =A0+0.1 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 512 =A0 =A0 +0% =A0 =A0 +1% =A0 =A0 +2% =A0 =
=A0 +2% =A0 =A0 +2% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0+0.0 =A0 =A0+0=
=2E2 =A0 =A0+0.2 =A0 =A0+0.2 =A0 =A0+0.1
>
> =A0 =A0 =A0 =A051200 =A0 1024 =A0 =A0+0% =A0 =A0 +2% =A0 =A0 +2% =A0 =
=A0 +2% =A0 =A0 +3% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.1 =A0 =A0+0=
=2E2 =A0 =A0+0.5 =A0 =A0-0.8 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 2048 =A0 =A0+0% =A0 =A0 +2% =A0 =A0 +3% =A0 =
=A0 +3% =A0 =A0 +3% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0-0.2 =A0 =A0+0=
=2E4 =A0 =A0+0.8 =A0 =A0-0.5 =A0 =A0+0.2
>
> =A0 =A0 =A0 =A051200 =A0 4096 =A0 =A0+0% =A0 =A0 +1% =A0 =A0 +3% =A0 =
=A0 +3% =A0 =A0 +3% =A0 =A0 +1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.1 =A0 =A0+0=
=2E9 =A0 =A0+0.9 =A0 =A0+0.5 =A0 =A0+0.1
>
> =A0 =A0 =A0 =A051200 =A0 8192 =A0 =A0+1% =A0 =A0 +0% =A0 =A0 +3% =A0 =
=A0 +3% =A0 =A0 +3% =A0 =A0 +1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.2 =A0 =A0+1=
=2E3 =A0 =A0+1.3 =A0 =A0+1.0 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 16384 =A0 +0% =A0 =A0 +1% =A0 =A0 +3% =A0 =A0=
 +3% =A0 =A0 +3% =A0 =A0 +1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.1 =A0 =A0+1=
=2E0 =A0 =A0+1.3 =A0 =A0+1.0 =A0 =A0+0.5
>
> Relative diff: VANILLA-MMC-DMA -> 2BUF-MMC-MMCI-DMA
> cpu load is abs diff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0random =A0random
> =A0 =A0 =A0 =A0KB =A0 =A0 =A0reclen =A0write =A0 rewrite read =A0 =A0=
reread =A0read =A0 =A0write
> =A0 =A0 =A0 =A051200 =A0 4 =A0 =A0 =A0 +0% =A0 =A0 -3% =A0 =A0 +6% =A0=
 =A0 +5% =A0 =A0 +5% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0-0.2 =A0 =A0-0=
=2E6 =A0 =A0-0.1 =A0 =A0+0.3 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 8 =A0 =A0 =A0 +0% =A0 =A0 +0% =A0 =A0 +7% =A0=
 =A0 +7% =A0 =A0 +7% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.1 =A0 =A0+0=
=2E8 =A0 =A0+0.6 =A0 =A0+0.9 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 16 =A0 =A0 =A0+0% =A0 =A0 +0% =A0 =A0 +7% =A0=
 =A0 +7% =A0 =A0 +8% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0-0.0 =A0 =A0+0=
=2E7 =A0 =A0+0.7 =A0 =A0+0.8 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 32 =A0 =A0 =A0+0% =A0 =A0 +0% =A0 =A0 +8% =A0=
 =A0 +8% =A0 =A0 +9% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.1 =A0 =A0+0=
=2E7 =A0 =A0+0.7 =A0 =A0+0.3 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 64 =A0 =A0 =A0+0% =A0 =A0 +1% =A0 =A0 +9% =A0=
 =A0 +9% =A0 =A0 +9% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.0 =A0 =A0+0=
=2E8 =A0 =A0+0.7 =A0 =A0+0.8 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 128 =A0 =A0 +1% =A0 =A0 +0% =A0 =A0 +13% =A0=
 =A0+13% =A0 =A0+14% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.0 =A0 =A0+1=
=2E0 =A0 =A0+1.0 =A0 =A0+1.1 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 256 =A0 =A0 +1% =A0 =A0 +2% =A0 =A0 +8% =A0 =
=A0 +8% =A0 =A0 +11% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.3 =A0 =A0+0=
=2E0 =A0 =A0+0.7 =A0 =A0+1.5 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 512 =A0 =A0 +1% =A0 =A0 +2% =A0 =A0 +16% =A0=
 =A0+16% =A0 =A0+17% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.2 =A0 =A0+2=
=2E2 =A0 =A0+2.1 =A0 =A0+2.2 =A0 =A0+0.1
>
> =A0 =A0 =A0 =A051200 =A0 1024 =A0 =A0+1% =A0 =A0 +2% =A0 =A0 +20% =A0=
 =A0+20% =A0 =A0+20% =A0 =A0+1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.1 =A0 =A0+2=
=2E6 =A0 =A0+1.9 =A0 =A0+2.6 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 2048 =A0 =A0+0% =A0 =A0 +2% =A0 =A0 +22% =A0=
 =A0+22% =A0 =A0+21% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.3 =A0 =A0+2=
=2E3 =A0 =A0+2.9 =A0 =A0+2.1 =A0 =A0-0.0
>
> =A0 =A0 =A0 =A051200 =A0 4096 =A0 =A0+1% =A0 =A0 +2% =A0 =A0 +23% =A0=
 =A0+23% =A0 =A0+23% =A0 =A0+1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.1 =A0 =A0+2=
=2E0 =A0 =A0+3.2 =A0 =A0+3.1 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 8192 =A0 =A0+1% =A0 =A0 +5% =A0 =A0 +24% =A0=
 =A0+24% =A0 =A0+24% =A0 =A0+1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+1.4 =A0 =A0-0.0 =A0 =A0+4=
=2E2 =A0 =A0+3.0 =A0 =A0+2.8 =A0 =A0+0.1
>
> =A0 =A0 =A0 =A051200 =A0 16384 =A0 +1% =A0 =A0 +3% =A0 =A0 +24% =A0 =A0=
+24% =A0 =A0+24% =A0 =A0+2%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.0 =A0 =A0+0.3 =A0 =A0+3=
=2E4 =A0 =A0+3.8 =A0 =A0+3.7 =A0 =A0+0.1
>
> Here follows the IOZone results for u5500 on eMMC.
> These numbers for DMA are more as expected.
>
> Command line used: ./iozone -az -i0 -i1 -i2 -s 50m -I -f /iozone.tmp =
-e -R -+u
>
> Relative diff: VANILLA-MMC-DMA -> 2BUF-MMC-MMCI-DMA
> cpu load is abs diff
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0random =A0random
> =A0 =A0 =A0 =A0KB =A0 =A0 =A0reclen =A0write =A0 rewrite read =A0 =A0=
reread =A0read =A0 =A0write
> =A0 =A0 =A0 =A051200 =A0 128 =A0 =A0 +1% =A0 =A0 +1% =A0 =A0 +10% =A0=
 =A0+9% =A0 =A0 +10% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0+0.0 =A0 =A0+1=
=2E3 =A0 =A0+0.1 =A0 =A0+0.8 =A0 =A0+0.1
>
> =A0 =A0 =A0 =A051200 =A0 256 =A0 =A0 +2% =A0 =A0 +2% =A0 =A0 +7% =A0 =
=A0 +7% =A0 =A0 +9% =A0 =A0 +0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0+0.4 =A0 =A0+0=
=2E5 =A0 =A0+0.6 =A0 =A0+0.7 =A0 =A0+0.0
>
> =A0 =A0 =A0 =A051200 =A0 512 =A0 =A0 +2% =A0 =A0 +2% =A0 =A0 +12% =A0=
 =A0+12% =A0 =A0+12% =A0 =A0+1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.4 =A0 =A0+0.6 =A0 =A0+1=
=2E8 =A0 =A0+2.4 =A0 =A0+2.4 =A0 =A0+0.2
>
> =A0 =A0 =A0 =A051200 =A0 1024 =A0 =A0+2% =A0 =A0 +3% =A0 =A0 +14% =A0=
 =A0+14% =A0 =A0+14% =A0 =A0+0%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.3 =A0 =A0+0.1 =A0 =A0+2=
=2E1 =A0 =A0+1.4 =A0 =A0+1.4 =A0 =A0+0.2
>
> =A0 =A0 =A0 =A051200 =A0 2048 =A0 =A0+3% =A0 =A0 +3% =A0 =A0 +16% =A0=
 =A0+16% =A0 =A0+16% =A0 =A0+1%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.2 =A0 =A0+2=
=2E5 =A0 =A0+1.8 =A0 =A0+2.4 =A0 =A0-0.2
>
> =A0 =A0 =A0 =A051200 =A0 4096 =A0 =A0+3% =A0 =A0 +3% =A0 =A0 +17% =A0=
 =A0+17% =A0 =A0+18% =A0 =A0+3%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.1 =A0 =A0-0.1 =A0 =A0+2=
=2E7 =A0 =A0+2.0 =A0 =A0+2.7 =A0 =A0-0.1
>
> =A0 =A0 =A0 =A051200 =A0 8192 =A0 =A0+3% =A0 =A0 +3% =A0 =A0 +18% =A0=
 =A0+18% =A0 =A0+18% =A0 =A0+3%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0-0.1 =A0 =A0+0.2 =A0 =A0+3=
=2E0 =A0 =A0+2.3 =A0 =A0+2.2 =A0 =A0+0.2
>
> =A0 =A0 =A0 =A051200 =A0 16384 =A0 +3% =A0 =A0 +3% =A0 =A0 +18% =A0 =A0=
+18% =A0 =A0+18% =A0 =A0+4%
> =A0 =A0 =A0 =A0cpu: =A0 =A0 =A0 =A0 =A0 =A0+0.2 =A0 =A0+0.2 =A0 =A0+2=
=2E8 =A0 =A0+3.5 =A0 =A0+2.4 =A0 =A0-0.0
>
> Per Forlin (5):
> =A0mmc: add member in mmc queue struct to hold request data
> =A0mmc: Add a block request prepare function
> =A0mmc: Add a second mmc queue request member
> =A0mmc: Store the mmc block request struct in mmc queue
> =A0mmc: Add double buffering for mmc block requests
>
> =A0drivers/mmc/card/block.c | =A0337 ++++++++++++++++++++++++++++++--=
--------------
> =A0drivers/mmc/card/queue.c | =A0171 +++++++++++++++---------
> =A0drivers/mmc/card/queue.h | =A0 31 +++-
> =A0drivers/mmc/core/core.c =A0| =A0 77 +++++++++--
> =A0include/linux/mmc/core.h | =A0 =A07 +-
> =A0include/linux/mmc/host.h | =A0 =A08 +
> =A06 files changed, 432 insertions(+), 199 deletions(-)
>
>
