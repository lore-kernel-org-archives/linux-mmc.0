From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v6 00/11] mmc: use nonblock mmc requests to minimize latency
Date: Tue, 21 Jun 2011 11:26:27 +0200
Message-ID: <BANLkTimfxrcKWLZJmVC+1zL27th7j4uzEA@mail.gmail.com>
References: <1308518257-9783-1-git-send-email-per.forlin@linaro.org>
	<20110621075319.GN26089@n2100.arm.linux.org.uk>
	<BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:56373 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755155Ab1FUJ03 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 05:26:29 -0400
Received: by qwk3 with SMTP id 3so1180435qwk.19
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jun 2011 02:26:28 -0700 (PDT)
In-Reply-To: <BANLkTikOA3G0Gt4Cxua3EDnAzbFKLAk6Yw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-dev@lists.linaro.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

On 21 June 2011 10:09, Per Forlin <per.forlin@linaro.org> wrote:
> On 21 June 2011 09:53, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> On Sun, Jun 19, 2011 at 11:17:26PM +0200, Per Forlin wrote:
>>> How significant is the cache maintenance over head?
>>
>> Per,
>>
>> Can you measure how much difference this has before and after your
>> patch set please?
> Absolutely, I can run the mmc_tests to get the measurement. The cache
> affect is greater the faster the flash memory is. Currently I only
> have access to a SD card (20 MiB/S). By the end of this week I can run
> on eMMC (45 MiB/s) if this will be needed.
>
Russel,

Here are the results.

mmc_test results without your DSB patch:
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 17.907140069
seconds (7495 kB/s, 7319 KiB/s, 1829.88 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.977203519
seconds (12226 kB/s, 11940 KiB/s, 1492.54 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.618723194
seconds (15572 kB/s, 15207 KiB/s, 950.48 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.452392708
seconds (18010 kB/s, 17587 KiB/s, 549.62 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.839447152
seconds (19624 kB/s, 19164 KiB/s, 299.43 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.533447450
seconds (20543 kB/s, 20061 KiB/s, 156.73 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.355529943
seconds (21118 kB/s, 20623 KiB/s, 80.55 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.227417019
seconds (21552 kB/s, 21047 KiB/s, 41.10 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.047821091
seconds (22192 kB/s, 21672 KiB/s, 21.16 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.983120236
seconds (22432 kB/s, 21906 KiB/s, 5.34 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 38. Write performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 17.004930158
seconds (7892 kB/s, 7707 KiB/s, 1926.97 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.397338972
seconds (12908 kB/s, 12606 KiB/s, 1575.78 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.127319360
seconds (16514 kB/s, 16127 KiB/s, 1007.95 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.061096329
seconds (19008 kB/s, 18562 KiB/s, 580.07 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.503535845
seconds (20637 kB/s, 20153 KiB/s, 314.90 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.222897631
seconds (21568 kB/s, 21062 KiB/s, 164.55 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.082733285
seconds (22065 kB/s, 21548 KiB/s, 84.17 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.928009056
seconds (22641 kB/s, 22110 KiB/s, 43.18 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.891113751
seconds (22783 kB/s, 22249 KiB/s, 21.72 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.878531233
seconds (22831 kB/s, 22296 KiB/s, 5.44 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.904750140
seconds (6420 kB/s, 6269 KiB/s, 1567.49 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.929870605
seconds (10380 kB/s, 10137 KiB/s, 1267.14 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.115753174
seconds (13268 kB/s, 12957 KiB/s, 809.82 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.533538819
seconds (17816 kB/s, 17398 KiB/s, 543.70 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.937011718
seconds (19348 kB/s, 18894 KiB/s, 295.22 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.638824464
seconds (20217 kB/s, 19743 KiB/s, 154.24 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.489288330
seconds (20682 kB/s, 20198 KiB/s, 78.89 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.414489746
seconds (20924 kB/s, 20433 KiB/s, 39.90 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.376800426
seconds (21047 kB/s, 20554 KiB/s, 20.07 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.348991821
seconds (21140 kB/s, 20644 KiB/s, 5.04 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 40. Read performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.906376527
seconds (6419 kB/s, 6269 KiB/s, 1567.36 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.929779053
seconds (10380 kB/s, 10137 KiB/s, 1267.15 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.119873047
seconds (13262 kB/s, 12951 KiB/s, 809.49 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.501770019
seconds (17891 kB/s, 17472 KiB/s, 546.00 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.797882080
seconds (19744 kB/s, 19281 KiB/s, 301.27 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.293121338
seconds (21327 kB/s, 20827 KiB/s, 162.71 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 5.952606200
seconds (22547 kB/s, 22019 KiB/s, 86.01 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.862152101
seconds (22895 kB/s, 22359 KiB/s, 43.66 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.818847175
seconds (23066 kB/s, 22525 KiB/s, 21.99 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.798218390
seconds (23148 kB/s, 22605 KiB/s, 5.51 IOPS)
mmc0: Result: OK
mmc0: Tests completed.


mmc_test results with your DSB patch:
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 37. Write performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 17.912285550
seconds (7493 kB/s, 7317 KiB/s, 1829.35 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.992614823
seconds (12209 kB/s, 11923 KiB/s, 1490.45 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.670936194
seconds (15479 kB/s, 15116 KiB/s, 944.76 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.448752639
seconds (18018 kB/s, 17596 KiB/s, 549.89 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.837432905
seconds (19629 kB/s, 19169 KiB/s, 299.52 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.510650765
seconds (20615 kB/s, 20131 KiB/s, 157.28 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.343047841
seconds (21159 kB/s, 20663 KiB/s, 80.71 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.275632327
seconds (21387 kB/s, 20885 KiB/s, 40.79 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.051895663
seconds (22177 kB/s, 21658 KiB/s, 21.15 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.992395203
seconds (22398 kB/s, 21873 KiB/s, 5.34 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 38. Write performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 17.019586188
seconds (7886 kB/s, 7701 KiB/s, 1925.31 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 10.377655096
seconds (12933 kB/s, 12630 KiB/s, 1578.77 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 8.172790531
seconds (16422 kB/s, 16037 KiB/s, 1002.35 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.069458097
seconds (18985 kB/s, 18540 KiB/s, 579.39 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.498779387
seconds (20652 kB/s, 20168 KiB/s, 315.13 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.220800166
seconds (21575 kB/s, 21069 KiB/s, 164.60 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.040708413
seconds (22218 kB/s, 21698 KiB/s, 84.75 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.946899457
seconds (22569 kB/s, 22040 KiB/s, 43.04 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.927886710
seconds (22641 kB/s, 22111 KiB/s, 21.59 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.878386087
seconds (22832 kB/s, 22297 KiB/s, 5.44 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 39. Read performance with blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.829314216
seconds (6443 kB/s, 6292 KiB/s, 1573.16 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.875244140
seconds (10424 kB/s, 10180 KiB/s, 1272.51 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.073059082
seconds (13324 kB/s, 13012 KiB/s, 813.25 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.550659181
seconds (17775 kB/s, 17359 KiB/s, 542.46 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.942535401
seconds (19332 kB/s, 18879 KiB/s, 294.99 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.645233154
seconds (20197 kB/s, 19724 KiB/s, 154.09 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 6.495941164
seconds (20661 kB/s, 20177 KiB/s, 78.81 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 6.421081542
seconds (20902 kB/s, 20412 KiB/s, 39.86 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 6.383514604
seconds (21025 kB/s, 20532 KiB/s, 20.05 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 6.355718936
seconds (21117 kB/s, 20622 KiB/s, 5.03 IOPS)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:80ca...
mmc0: Test case 40. Read performance with non-blocking req 4k to 4MB...
mmc0: Transfer of 32768 x 8 sectors (32768 x 4 KiB) took 20.832669187
seconds (6442 kB/s, 6291 KiB/s, 1572.91 IOPS)
mmc0: Transfer of 16384 x 16 sectors (16384 x 8 KiB) took 12.884582520
seconds (10416 kB/s, 10172 KiB/s, 1271.59 IOPS)
mmc0: Transfer of 8192 x 32 sectors (8192 x 16 KiB) took 10.076812745
seconds (13319 kB/s, 13007 KiB/s, 812.95 IOPS)
mmc0: Transfer of 4096 x 64 sectors (4096 x 32 KiB) took 7.471252441
seconds (17964 kB/s, 17543 KiB/s, 548.23 IOPS)
mmc0: Transfer of 2048 x 128 sectors (2048 x 64 KiB) took 6.765075684
seconds (19839 kB/s, 19374 KiB/s, 302.73 IOPS)
mmc0: Transfer of 1024 x 256 sectors (1024 x 128 KiB) took 6.259826661
seconds (21441 kB/s, 20938 KiB/s, 163.58 IOPS)
mmc0: Transfer of 512 x 512 sectors (512 x 256 KiB) took 5.948974608
seconds (22561 kB/s, 22032 KiB/s, 86.06 IOPS)
mmc0: Transfer of 256 x 1024 sectors (256 x 512 KiB) took 5.860260010
seconds (22903 kB/s, 22366 KiB/s, 43.68 IOPS)
mmc0: Transfer of 128 x 2048 sectors (128 x 1024 KiB) took 5.817993397
seconds (23069 kB/s, 22528 KiB/s, 22.00 IOPS)
mmc0: Transfer of 32 x 8192 sectors (32 x 4096 KiB) took 5.798185906
seconds (23148 kB/s, 22605 KiB/s, 5.51 IOPS)
mmc0: Result: OK
mmc0: Tests completed.

In case I did any mistakes applying your patch manually. Here is your
dsb patch on top of 3.0-rc4.
diff --git a/arch/arm/include/asm/dma-mapping.h
b/arch/arm/include/asm/dma-mapping.h
index 4fff837..ad14c2b 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -115,6 +115,11 @@ static inline void __dma_page_dev_to_cpu(struct
page *page, unsigned long off,
 		___dma_page_dev_to_cpu(page, off, size, dir);
 }

+static inline void __dma_sync(void)
+{
+       dsb();
+}
+
 /*
  * Return whether the given device DMA address mask can be supported
  * properly.  For example, if your device can only drive the low 24-bits
@@ -378,6 +383,7 @@ static inline dma_addr_t dma_map_single(struct
device *dev, void *cpu_addr,
 	BUG_ON(!valid_dma_direction(dir));

 	addr = __dma_map_single(dev, cpu_addr, size, dir);
+	__dma_sync();
 	debug_dma_map_page(dev, virt_to_page(cpu_addr),
 			(unsigned long)cpu_addr & ~PAGE_MASK, size,
 			dir, addr, true);
@@ -407,6 +413,7 @@ static inline dma_addr_t dma_map_page(struct
device *dev, struct page *page,
 	BUG_ON(!valid_dma_direction(dir));

 	addr = __dma_map_page(dev, page, offset, size, dir);
+	__dma_sync();
 	debug_dma_map_page(dev, page, offset, size, dir, addr, false);

 	return addr;
@@ -431,6 +438,7 @@ static inline void dma_unmap_single(struct device
*dev, dma_addr_t handle,
 {
 	debug_dma_unmap_page(dev, handle, size, dir, true);
 	__dma_unmap_single(dev, handle, size, dir);
+	__dma_sync();
 }

 /**
@@ -452,6 +460,7 @@ static inline void dma_unmap_page(struct device
*dev, dma_addr_t handle,
 {
 	debug_dma_unmap_page(dev, handle, size, dir, false);
 	__dma_unmap_page(dev, handle, size, dir);
+	__dma_sync();
 }

 /**
@@ -498,6 +507,7 @@ static inline void
dma_sync_single_range_for_device(struct device *dev,
 		return;

 	__dma_single_cpu_to_dev(dma_to_virt(dev, handle) + offset, size, dir);
+	__dma_sync();
 }

 static inline void dma_sync_single_for_cpu(struct device *dev,
diff --git a/arch/arm/mm/cache-fa.S b/arch/arm/mm/cache-fa.S
index 1fa6f71..6eeb734 100644
--- a/arch/arm/mm/cache-fa.S
+++ b/arch/arm/mm/cache-fa.S
@@ -179,8 +179,6 @@ fa_dma_inv_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
@@ -197,8 +195,6 @@ fa_dma_clean_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0	
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
@@ -212,8 +208,6 @@ ENTRY(fa_dma_flush_range)
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0	
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
diff --git a/arch/arm/mm/cache-v4wb.S b/arch/arm/mm/cache-v4wb.S
index f40c696..523c0cb 100644
--- a/arch/arm/mm/cache-v4wb.S
+++ b/arch/arm/mm/cache-v4wb.S
@@ -194,7 +194,6 @@ v4wb_dma_inv_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
@@ -211,7 +210,6 @@ v4wb_dma_clean_range:
 	add	r0, r0, #CACHE_DLINESIZE
 	cmp	r0, r1
 	blo	1b
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
diff --git a/arch/arm/mm/cache-v6.S b/arch/arm/mm/cache-v6.S
index 73b4a8b..7a842dd 100644
--- a/arch/arm/mm/cache-v6.S
+++ b/arch/arm/mm/cache-v6.S
@@ -239,8 +239,6 @@ v6_dma_inv_range:
 	strlo	r2, [r0]			@ write for ownership
 #endif
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
@@ -262,8 +260,6 @@ v6_dma_clean_range:
 	add	r0, r0, #D_CACHE_LINE_SIZE
 	cmp	r0, r1
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
@@ -290,8 +286,6 @@ ENTRY(v6_dma_flush_range)
 	strlob	r2, [r0]			@ write for ownership
 #endif
 	blo	1b
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
 	mov	pc, lr

 /*
diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..18dcef6 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -257,7 +257,6 @@ v7_dma_inv_range:
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_clean_range)

@@ -293,7 +291,6 @@ ENTRY(v7_dma_flush_range)
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b
-	dsb
 	mov	pc, lr
 ENDPROC(v7_dma_flush_range)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 82a093c..ff85283 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -97,6 +97,7 @@ static struct page *__dma_alloc_buffer(struct device
*dev, size_t size, gfp_t gf
 	memset(ptr, 0, size);
 	dmac_flush_range(ptr, ptr + size);
 	outer_flush_range(__pa(ptr), __pa(ptr) + size);
+	__dma_sync();

 	return page;
 }
@@ -572,6 +573,7 @@ int dma_map_sg(struct device *dev, struct
scatterlist *sg, int nents,
 		if (dma_mapping_error(dev, s->dma_address))
 			goto bad_mapping;
 	}
+	__dma_sync();
 	debug_dma_map_sg(dev, sg, nents, nents, dir);
 	return nents;

@@ -602,6 +604,7 @@ void dma_unmap_sg(struct device *dev, struct
scatterlist *sg, int nents,

 	for_each_sg(sg, s, nents, i)
 		__dma_unmap_page(dev, sg_dma_address(s), sg_dma_len(s), dir);
+	__dma_sync();
 }
 EXPORT_SYMBOL(dma_unmap_sg);

@@ -626,6 +629,7 @@ void dma_sync_sg_for_cpu(struct device *dev,
struct scatterlist *sg,
 		__dma_page_dev_to_cpu(sg_page(s), s->offset,
 				      s->length, dir);
 	}
+	__dma_sync();

 	debug_dma_sync_sg_for_cpu(dev, sg, nents, dir);
 }
@@ -652,6 +656,7 @@ void dma_sync_sg_for_device(struct device *dev,
struct scatterlist *sg,
 		__dma_page_cpu_to_dev(sg_page(s), s->offset,
 				      s->length, dir);
 	}
+	__dma_sync();

 	debug_dma_sync_sg_for_device(dev, sg, nents, dir);
 }
-- 
1.7.4.1
