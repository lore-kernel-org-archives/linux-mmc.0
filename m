From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc_test: fix memory allocation segment limits
Date: Fri, 24 Sep 2010 22:15:48 +0100
Message-ID: <20100924211548.GA29362@void.printf.net>
References: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com> <20100923115129.18000.59696.sendpatchset@ahunter-work.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59172 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423Ab0IXVPu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 24 Sep 2010 17:15:50 -0400
Content-Disposition: inline
In-Reply-To: <20100923115129.18000.59696.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>

Hi Adrian,

On Thu, Sep 23, 2010 at 02:51:29PM +0300, Adrian Hunter wrote:
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Thu, 23 Sep 2010 12:55:15 +0300
> Subject: [PATCH 1/2] mmc_test: fix memory allocation segment limits
> 
> Correctly allocate memory to meet the host controller
> driver's maximum segment size and count limits.

Thanks very much, this fixes my problems.  I've pushed it to mmc-next.

Output below, just in case you're curious:

mmc_test mmc0:e624: Card claimed for testing.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 1. Basic write (no data verification)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 2. Basic read (no data verification)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 3. Basic write (with data verification)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 4. Basic read (with data verification)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 5. Multi-block write...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 6. Multi-block read...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 7. Power of two block writes...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 8. Power of two block reads...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 9. Weird sized block writes...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 10. Weird sized block reads...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 11. Badly aligned write...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 12. Badly aligned read...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 13. Badly aligned multi-block write...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 14. Badly aligned multi-block read...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 15. Correct xfer_size at write (start failure)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 16. Correct xfer_size at read (start failure)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 17. Correct xfer_size at write (midway failure)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 18. Correct xfer_size at read (midway failure)...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 19. Highmem write...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 20. Highmem read...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 21. Multi-block highmem write...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 22. Multi-block highmem read...
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 23. Best-case read performance...
mmc0: Transfer of 1024 sectors (512 KiB) took 0.033058904 seconds (15859 kB/s, 15487 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 24. Best-case write performance...
mmc0: Transfer of 1024 sectors (512 KiB) took 0.036752587 seconds (14265 kB/s, 13930 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 25. Best-case read performance into scattered pages...
mmc0: Transfer of 8 sectors (4 KiB) took 0.000796178 seconds (5144 kB/s, 5024 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 26. Best-case write performance from scattered pages...
mmc0: Transfer of 8 sectors (4 KiB) took 0.002371540 seconds (1727 kB/s, 1686 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 27. Single read performance by transfer size...
mmc0: Transfer of 1 sectors (0.5 KiB) took 0.000551456 seconds (928 kB/s, 906 KiB/s)
mmc0: Transfer of 2 sectors (1 KiB) took 0.000552924 seconds (1851 kB/s, 1808 KiB/s)
mmc0: Transfer of 4 sectors (2 KiB) took 0.000668650 seconds (3062 kB/s, 2991 KiB/s)
mmc0: Transfer of 8 sectors (4 KiB) took 0.000696796 seconds (5878 kB/s, 5740 KiB/s)
mmc0: Transfer of 16 sectors (8 KiB) took 0.001019670 seconds (8033 kB/s, 7845 KiB/s)
mmc0: Transfer of 32 sectors (16 KiB) took 0.001567431 seconds (10452 kB/s, 10207 KiB/s)
mmc0: Transfer of 64 sectors (32 KiB) took 0.002722948 seconds (12034 kB/s, 11751 KiB/s)
mmc0: Transfer of 128 sectors (64 KiB) took 0.004737135 seconds (13834 kB/s, 13510 KiB/s)
mmc0: Transfer of 256 sectors (128 KiB) took 0.008854402 seconds (14803 kB/s, 14456 KiB/s)
mmc0: Transfer of 512 sectors (256 KiB) took 0.016952058 seconds (15463 kB/s, 15101 KiB/s)
mmc0: Transfer of 1024 sectors (512 KiB) took 0.033126787 seconds (15826 kB/s, 15455 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 28. Single write performance by transfer size...
mmc0: Transfer of 1 sectors (0.5 KiB) took 0.001949055 seconds (262 kB/s, 256 KiB/s)
mmc0: Transfer of 2 sectors (1 KiB) took 0.002415603 seconds (423 kB/s, 413 KiB/s)
mmc0: Transfer of 4 sectors (2 KiB) took 0.002114501 seconds (968 kB/s, 945 KiB/s)
mmc0: Transfer of 8 sectors (4 KiB) took 0.001552827 seconds (2637 kB/s, 2575 KiB/s)
mmc0: Transfer of 16 sectors (8 KiB) took 0.001740555 seconds (4706 kB/s, 4596 KiB/s)
mmc0: Transfer of 32 sectors (16 KiB) took 0.002272057 seconds (7211 kB/s, 7042 KiB/s)
mmc0: Transfer of 64 sectors (32 KiB) took 0.003499233 seconds (9364 kB/s, 9144 KiB/s)
mmc0: Transfer of 128 sectors (64 KiB) took 0.005615027 seconds (11671 kB/s, 11397 KiB/s)
mmc0: Transfer of 256 sectors (128 KiB) took 0.009879663 seconds (13266 kB/s, 12955 KiB/s)
mmc0: Transfer of 512 sectors (256 KiB) took 0.173152083 seconds (1513 kB/s, 1478 KiB/s)
mmc0: Transfer of 1024 sectors (512 KiB) took 0.036976626 seconds (14178 kB/s, 13846 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 29. Single trim performance by transfer size...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 30. Consecutive read performance by transfer size...
mmc0: Transfer of 8192 x 1 sectors (8192 x 0.5 KiB) took 3.003465917 seconds (1396 kB/s, 1363 KiB/s)
mmc0: Transfer of 4096 x 2 sectors (4096 x 1 KiB) took 1.941040090 seconds (2160 kB/s, 2110 KiB/s)
mmc0: Transfer of 2048 x 4 sectors (2048 x 2 KiB) took 1.056346906 seconds (3970 kB/s, 3877 KiB/s)
mmc0: Transfer of 1024 x 8 sectors (1024 x 4 KiB) took 0.670899009 seconds (6251 kB/s, 6105 KiB/s)
mmc0: Transfer of 512 x 16 sectors (512 x 8 KiB) took 0.496233273 seconds (8452 kB/s, 8254 KiB/s)
mmc0: Transfer of 256 x 32 sectors (256 x 16 KiB) took 0.383516832 seconds (10936 kB/s, 10680 KiB/s)
mmc0: Transfer of 128 x 64 sectors (128 x 32 KiB) took 0.323005936 seconds (12985 kB/s, 12680 KiB/s)
mmc0: Transfer of 64 x 128 sectors (64 x 64 KiB) took 0.291171741 seconds (14404 kB/s, 14067 KiB/s)
mmc0: Transfer of 32 x 256 sectors (32 x 128 KiB) took 0.275758964 seconds (15210 kB/s, 14853 KiB/s)
mmc0: Transfer of 16 x 512 sectors (16 x 256 KiB) took 0.268021558 seconds (15649 kB/s, 15282 KiB/s)
mmc0: Transfer of 8 x 1024 sectors (8 x 512 KiB) took 0.264064314 seconds (15883 kB/s, 15511 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 31. Consecutive write performance by transfer size...
mmc0: Transfer of 8192 x 1 sectors (8192 x 0.5 KiB) took 11.873861873 seconds (353 kB/s, 344 KiB/s)
mmc0: Transfer of 4096 x 2 sectors (4096 x 1 KiB) took 6.859102388 seconds (611 kB/s, 597 KiB/s)
mmc0: Transfer of 2048 x 4 sectors (2048 x 2 KiB) took 3.290696395 seconds (1274 kB/s, 1244 KiB/s)
mmc0: Transfer of 1024 x 8 sectors (1024 x 4 KiB) took 1.475266866 seconds (2843 kB/s, 2776 KiB/s)
mmc0: Transfer of 512 x 16 sectors (512 x 8 KiB) took 0.822344533 seconds (5100 kB/s, 4980 KiB/s)
mmc0: Transfer of 256 x 32 sectors (256 x 16 KiB) took 0.545847885 seconds (7684 kB/s, 7503 KiB/s)
mmc0: Transfer of 128 x 64 sectors (128 x 32 KiB) took 0.414100853 seconds (10128 kB/s, 9891 KiB/s)
mmc0: Transfer of 64 x 128 sectors (64 x 64 KiB) took 0.340080041 seconds (12333 kB/s, 12044 KiB/s)
mmc0: Transfer of 32 x 256 sectors (32 x 128 KiB) took 0.305309179 seconds (13737 kB/s, 13415 KiB/s)
mmc0: Transfer of 16 x 512 sectors (16 x 256 KiB) took 0.287391903 seconds (14594 kB/s, 14252 KiB/s)
mmc0: Transfer of 8 x 1024 sectors (8 x 512 KiB) took 0.279981325 seconds (14980 kB/s, 14629 KiB/s)
mmc0: Result: OK
mmc0: Tests completed.
mmc0: Starting tests of card mmc0:e624...
mmc0: Test case 32. Consecutive trim performance by transfer size...
mmc0: Result: UNSUPPORTED (by card)
mmc0: Tests completed.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
