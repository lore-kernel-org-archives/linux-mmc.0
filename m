From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize
	latency
Date: Mon, 27 Jun 2011 11:42:52 +0200
Message-ID: <BANLkTinK88QT_7Zr2YF1sTAiM778Xp9rFQ@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
	<BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
	<20110623133702.GZ23234@n2100.arm.linux.org.uk>
	<BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTi=8Awu4Z3ESizE9WDEyWNw0r9N0ug@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Ball <cjb@laptop.org>, linaro-dev@lists.linaro.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 24 June 2011 10:58, Per Forlin <per.forlin@linaro.org> wrote:
> On 23 June 2011 15:37, Russell King - ARM Linux <linux@arm.linux.org.uk> =
wrote:
>> On Tue, Jun 21, 2011 at 11:26:27AM +0200, Per Forlin wrote:
>>> Here are the results.
>>
>> It looks like this patch is either a no-op or slightly worse. =A0As
>> people have been telling me that dsb is rather expensive, and this
>> patch results in less dsbs, I'm finding these results hard to believe.
>> It seems to be saying that dsb is an effective no-op on your platform.
>>
> The result of your patch depends on the number of sg-elements. With
> your patch there is only on DSB per list instead of element I can
> write a test to measure performance per number of sg-element in the
> sg-list. Fixed transfer size but vary the number of sg-elements in the
> list. This test may give a better understanding of the affect.
>
> I have seen performance gain if using __raw_write instead of writel.
> Writel test includes both the cost of DSB and the outer_sync, where
> outer_sync is more expensive one I presume.
>
>> So either people are wrong about dsb being expensive, the patch is
>> wrong, or there's something wrong with these results/test method.
>>
>> You do have an error in the ported patch, as that hasn't updated the
>> v7 cache cleaning code to remove the dsb() there, but that would only
>> affect the write tests.
>>
> I will fix that mistake
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..3fb51c5 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -228,7 +228,6 @@ ENTRY(v7_flush_kern_dcache_area)
        add     r0, r0, r2
        cmp     r0, r1
        blo     1b
-       dsb
        mov     pc, lr
 ENDPROC(v7_flush_kern_dcache_area)

>
> I'll come back with new numbers on Monday.
>
I have extended the test to measure bandwidth for various various
length of the sg list.

mmc_test without DSB patch:
mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 18.298817895
seconds (7334 kB/s, 7162 KiB/s, 1790.71 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 11.046417371
seconds (12150 kB/s, 11865 KiB/s, 1483.19 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.700345332
seconds (15426 kB/s, 15065 KiB/s, 941.57 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.428314416
seconds (18068 kB/s, 17644 KiB/s, 551.40 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.843811190
seconds (19611 kB/s, 19151 KiB/s, 299.24 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.548462043
seconds (20496 kB/s, 20015 KiB/s, 156.37 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.392456168
seconds (20996 kB/s, 20504 KiB/s, 80.09 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.278533955
seconds (21377 kB/s, 20876 KiB/s, 40.77 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.007019613
seconds (22343 kB/s, 21819 KiB/s, 21.30 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.975690092
seconds (22460 kB/s, 21934 KiB/s, 5.35 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 38. Write performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 18.006849673
seconds (7453 kB/s, 7279 KiB/s, 1819.75 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.744232260
seconds (12492 kB/s, 12199 KiB/s, 1524.91 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.378324787
seconds (16019 kB/s, 15644 KiB/s, 977.76 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.120544379
seconds (18849 kB/s, 18407 KiB/s, 575.23 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.551513699
seconds (20486 kB/s, 20006 KiB/s, 312.59 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.252501827
seconds (21466 kB/s, 20963 KiB/s, 163.77 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.102325404
seconds (21994 kB/s, 21479 KiB/s, 83.90 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.978148815
seconds (22451 kB/s, 21925 KiB/s, 42.82 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.873932398
seconds (22849 kB/s, 22314 KiB/s, 21.79 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.874753979
seconds (22846 kB/s, 22311 KiB/s, 5.44 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.897765402
seconds (6422 kB/s, 6272 KiB/s, 1568.01 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.921478271
seconds (10387 kB/s, 10143 KiB/s, 1267.96 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.111419678
seconds (13273 kB/s, 12962 KiB/s, 810.17 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.551544189
seconds (17773 kB/s, 17356 KiB/s, 542.40 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.958251954
seconds (19289 kB/s, 18836 KiB/s, 294.32 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.656890870
seconds (20162 kB/s, 19689 KiB/s, 153.82 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.504821778
seconds (20633 kB/s, 20149 KiB/s, 78.71 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.428955079
seconds (20877 kB/s, 20387 KiB/s, 39.81 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.391205311
seconds (21000 kB/s, 20508 KiB/s, 20.02 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.362468401
seconds (21095 kB/s, 20600 KiB/s, 5.02 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 40. Read performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.879326369
seconds (6428 kB/s, 6277 KiB/s, 1569.39 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.924346924
seconds (10384 kB/s, 10141 KiB/s, 1267.68 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.111450196
seconds (13273 kB/s, 12962 KiB/s, 810.17 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.498107909
seconds (17900 kB/s, 17480 KiB/s, 546.27 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.791412354
seconds (19762 kB/s, 19299 KiB/s, 301.55 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.284973145
seconds (21355 kB/s, 20854 KiB/s, 162.92 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 5.951568601
seconds (22551 kB/s, 22023 KiB/s, 86.02 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861846924
seconds (22896 kB/s, 22360 KiB/s, 43.67 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.818786662
seconds (23066 kB/s, 22525 KiB/s, 21.99 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.798608182
seconds (23146 kB/s, 22604 KiB/s, 5.51 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 41. Write performance blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.272007461
seconds (21399 kB/s, 20897 KiB/s, 40.81 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.282043489
seconds (21365 kB/s, 20864 KiB/s, 40.75 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.272643023
seconds (21397 kB/s, 20895 KiB/s, 40.81 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.229250295
seconds (21546 kB/s, 21041 KiB/s, 41.09 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.273985326
seconds (21392 kB/s, 20891 KiB/s, 40.80 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.290618193
seconds (21336 kB/s, 20836 KiB/s, 40.69 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.319313199
seconds (21239 kB/s, 20741 KiB/s, 40.51 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.395201864
seconds (20987 kB/s, 20495 KiB/s, 40.03 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 42. Write performance non-blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.932434164
seconds (22624 kB/s, 22094 KiB/s, 43.15 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.977142417
seconds (22455 kB/s, 21928 KiB/s, 42.82 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.992553748
seconds (22397 kB/s, 21872 KiB/s, 42.71 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.977783455
seconds (22452 kB/s, 21926 KiB/s, 42.82 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.974916543
seconds (22463 kB/s, 21937 KiB/s, 42.84 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.933075093
seconds (22621 kB/s, 22091 KiB/s, 43.14 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.988067716
seconds (22414 kB/s, 21888 KiB/s, 42.75 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.982299966
seconds (22435 kB/s, 21909 KiB/s, 42.79 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 43. Read performance blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.427185060
seconds (20882 kB/s, 20393 KiB/s, 39.83 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.428710938
seconds (20877 kB/s, 20388 KiB/s, 39.82 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.430084229
seconds (20873 kB/s, 20384 KiB/s, 39.81 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.432220459
seconds (20866 kB/s, 20377 KiB/s, 39.79 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.435882569
seconds (20854 kB/s, 20365 KiB/s, 39.77 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.441589356
seconds (20836 kB/s, 20347 KiB/s, 39.74 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.507446289
seconds (20625 kB/s, 20141 KiB/s, 39.33 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.645568847
seconds (20196 kB/s, 19723 KiB/s, 38.52 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 44. Read performance non-blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861175537
seconds (22899 kB/s, 22362 KiB/s, 43.67 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861267090
seconds (22899 kB/s, 22362 KiB/s, 43.67 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861328125
seconds (22898 kB/s, 22362 KiB/s, 43.67 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861419678
seconds (22898 kB/s, 22361 KiB/s, 43.67 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861480713
seconds (22898 kB/s, 22361 KiB/s, 43.67 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861602783
seconds (22897 kB/s, 22361 KiB/s, 43.67 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861999512
seconds (22896 kB/s, 22359 KiB/s, 43.67 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.862915039
seconds (22892 kB/s, 22356 KiB/s, 43.66 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.

mmc_test with DSB patch
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 18.068062451
seconds (7428 kB/s, 7254 KiB/s, 1813.58 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 11.099609390
seconds (12092 kB/s, 11808 KiB/s, 1476.08 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.677063074
seconds (15468 kB/s, 15105 KiB/s, 944.09 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.476867759
seconds (17951 kB/s, 17530 KiB/s, 547.82 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.819549471
seconds (19681 kB/s, 19220 KiB/s, 300.31 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.524749957
seconds (20570 kB/s, 20088 KiB/s, 156.94 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.395263629
seconds (20987 kB/s, 20495 KiB/s, 80.05 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.271362333
seconds (21401 kB/s, 20900 KiB/s, 40.82 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.057769872
seconds (22156 kB/s, 21637 KiB/s, 21.12 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.953065733
seconds (22545 kB/s, 22017 KiB/s, 5.37 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 38. Write performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 17.807667705
seconds (7537 kB/s, 7360 KiB/s, 1840.10 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.798034119
seconds (12429 kB/s, 12138 KiB/s, 1517.31 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.365875302
seconds (16043 kB/s, 15667 KiB/s, 979.21 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.169311773
seconds (18721 kB/s, 18282 KiB/s, 571.32 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.518709807
seconds (20589 kB/s, 20107 KiB/s, 314.17 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.232238768
seconds (21536 kB/s, 21031 KiB/s, 164.30 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.100677623
seconds (22000 kB/s, 21484 KiB/s, 83.92 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.984959516
seconds (22425 kB/s, 21900 KiB/s, 42.77 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.920165778
seconds (22671 kB/s, 22139 KiB/s, 21.62 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.844845626
seconds (22963 kB/s, 22425 KiB/s, 5.47 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.818960380
seconds (6446 kB/s, 6295 KiB/s, 1573.94 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.869567871
seconds (10429 kB/s, 10184 KiB/s, 1273.08 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.071319579
seconds (13326 kB/s, 13014 KiB/s, 813.39 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.574279785
seconds (17720 kB/s, 17304 KiB/s, 540.77 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.955871583
seconds (19295 kB/s, 18843 KiB/s, 294.42 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.655639650
seconds (20166 kB/s, 19693 KiB/s, 153.85 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.504333497
seconds (20635 kB/s, 20151 KiB/s, 78.71 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.428558349
seconds (20878 kB/s, 20389 KiB/s, 39.82 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.390869097
seconds (21001 kB/s, 20509 KiB/s, 20.02 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.362161563
seconds (21096 kB/s, 20601 KiB/s, 5.02 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 40. Read performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.820581694
seconds (6446 kB/s, 6295 KiB/s, 1573.82 IOPS, sg_len 1)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.883728027
seconds (10417 kB/s, 10173 KiB/s, 1271.68 IOPS, sg_len 1)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.078765870
seconds (13316 kB/s, 13004 KiB/s, 812.79 IOPS, sg_len 1)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.474670410
seconds (17956 kB/s, 17535 KiB/s, 547.98 IOPS, sg_len 1)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.766143799
seconds (19836 kB/s, 19371 KiB/s, 302.68 IOPS, sg_len 1)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.263549804
seconds (21428 kB/s, 20926 KiB/s, 163.48 IOPS, sg_len 1)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 5.948516846
seconds (22563 kB/s, 22034 KiB/s, 86.07 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.860290527
seconds (22902 kB/s, 22366 KiB/s, 43.68 IOPS, sg_len 1)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.817961291
seconds (23069 kB/s, 22528 KiB/s, 22.00 IOPS, sg_len 1)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.798411425
seconds (23147 kB/s, 22604 KiB/s, 5.51 IOPS, sg_len 1)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 41. Write performance blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.255558930
seconds (21455 kB/s, 20952 KiB/s, 40.92 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.286008096
seconds (21351 kB/s, 20851 KiB/s, 40.72 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.273094892
seconds (21395 kB/s, 20894 KiB/s, 40.80 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.274107614
seconds (21392 kB/s, 20890 KiB/s, 40.80 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.239166371
seconds (21512 kB/s, 21007 KiB/s, 41.03 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.263824503
seconds (21427 kB/s, 20925 KiB/s, 40.86 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.314788699
seconds (21254 kB/s, 20756 KiB/s, 40.53 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.385681206
seconds (21018 kB/s, 20525 KiB/s, 40.08 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 42. Write performance non-blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.977571877
seconds (22453 kB/s, 21927 KiB/s, 42.82 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.939239529
seconds (22598 kB/s, 22068 KiB/s, 43.10 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.976898254
seconds (22456 kB/s, 21929 KiB/s, 42.83 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.978546066
seconds (22449 kB/s, 21923 KiB/s, 42.81 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.978147794
seconds (22451 kB/s, 21925 KiB/s, 42.82 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.979031678
seconds (22448 kB/s, 21921 KiB/s, 42.81 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.939541986
seconds (22597 kB/s, 22067 KiB/s, 43.10 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.970123311
seconds (22481 kB/s, 21954 KiB/s, 42.88 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 43. Read performance blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.428588865
seconds (20878 kB/s, 20388 KiB/s, 39.82 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.428924562
seconds (20877 kB/s, 20387 KiB/s, 39.82 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.429901123
seconds (20873 kB/s, 20384 KiB/s, 39.81 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.431579590
seconds (20868 kB/s, 20379 KiB/s, 39.80 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.435455322
seconds (20855 kB/s, 20367 KiB/s, 39.77 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.441680908
seconds (20835 kB/s, 20347 KiB/s, 39.74 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.505981447
seconds (20629 kB/s, 20146 KiB/s, 39.34 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.638854980
seconds (20216 kB/s, 19743 KiB/s, 38.56 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 44. Read performance non-blocking req 1 to 512 sg elems...
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861053467
seconds (22899 kB/s, 22363 KiB/s, 43.67 IOPS, sg_len 1)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861083984
seconds (22899 kB/s, 22363 KiB/s, 43.67 IOPS, sg_len 8)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861022950
seconds (22900 kB/s, 22363 KiB/s, 43.67 IOPS, sg_len 16)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861022949
seconds (22900 kB/s, 22363 KiB/s, 43.67 IOPS, sg_len 32)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861236572
seconds (22899 kB/s, 22362 KiB/s, 43.67 IOPS, sg_len 64)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861358642
seconds (22898 kB/s, 22362 KiB/s, 43.67 IOPS, sg_len 128)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.861694337
seconds (22897 kB/s, 22360 KiB/s, 43.67 IOPS, sg_len 256)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.862884521
seconds (22892 kB/s, 22356 KiB/s, 43.66 IOPS, sg_len 512)
mmc0: Result: OK
mmc0: Tests completed.


Conclusion:
Working with mmc the relative cost of DSB is almost none. There seems
to be slightly higher number for mmc blocking requests with the DSB
patch compared to not having it.

Regards,
Per
