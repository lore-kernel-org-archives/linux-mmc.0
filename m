Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFA21B12C2
	for <linux-mmc@vger.kernel.org>; Tue,  3 Sep 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360812; cv=none; b=EeQZ57+80cjcBoiR3Su0HHtnLYgTdfwSPV/cY8umS/eU9ihHqwLMVsFfodjyooEUV2Ko619QpFvEDZRe55gqmSTIS9gMtlJxSANLhKD8PLFmpDO1rXhOHPdLR8cFsu/qT2K/CgiJDLBL3xlUYGuIqdS7y3pX2VKrgVHG/u79khE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360812; c=relaxed/simple;
	bh=35bETK6TAmJWYfmnTp8wbqqrbESwXsyqZ0SEjnmMqbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcY6s6LQ5TbcSCILl0H9hJTRFG3LGWpDpvGetvKfzFhcXUh145fDXh0xNOH6TRz3sixx1KKFDrQjnl0BIGK3FP7x/gzadmKfxSvwIU+cmJtfKsfa2Y3doL+4CoHWjNxdtbXLmZMR9D5IR+rqHUgyi0ESiKsdfWzR6ZYIwrGlw74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=FFQHAwma; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FFQHAwma"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725360811; x=1756896811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=35bETK6TAmJWYfmnTp8wbqqrbESwXsyqZ0SEjnmMqbg=;
  b=FFQHAwmanHyBC2aWzwT7qHIEiFL1d+QI9pd9uSWOhubaTsKQR8uVT9p3
   C27kX1MLacr4HIzcbwINn95+kCUEhRi5rHh3LS0PGUKiShgoScdSCfZef
   QhgLtxbmBSzubKwDT7Tm7kqS+4Lii7pN4gduhDcYagLwzIzJjDrnSDW9z
   ySoStbpcwUXT3mMv1yUT6EPmwajfPLw1ety4s+O+H5F57/Uaif7GJvYdR
   g61N7WvOD3u3y8iOtq+/+lIy+Bar76J5G6248dZ1LOO2vet63kHKYePnH
   4GBIuIT5VlqAVrAnVAX/tK6w8TEajWgDfL7ElAKwL0ToTCCBNZ2cDmf0K
   g==;
X-CSE-ConnectionGUID: /R9tgWcgTNiXPzvfRCmhsw==
X-CSE-MsgGUID: 1ZeCCTR+RMKfOZqvqsH3Sw==
X-IronPort-AV: E=Sophos;i="6.10,198,1719849600"; 
   d="scan'208";a="25806211"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2024 18:53:30 +0800
IronPort-SDR: 66d6ddd4_+pveA9Eerto4qsgnmurrp38lj4fCtVTmNXIZq1lUXr8ltTd
 dE8MfDGJsrvnL4hKeBmdObk/O4EMLB8bUIAvboQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 02:58:44 -0700
WDCIronportException: Internal
Received: from avri-office.ad.shared (HELO avri-office.sdcorp.global.sandisk.com) ([10.45.31.142])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:53:28 -0700
From: Avri Altman <avri.altman@wdc.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Avri Altman <avri.altman@wdc.com>
Subject: [PATCH] Documentation: mmc: Add mmc-test doc
Date: Tue,  3 Sep 2024 13:51:51 +0300
Message-Id: <20240903105151.3581457-1-avri.altman@wdc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing documentation for mmc-test.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 Documentation/driver-api/mmc/index.rst    |   1 +
 Documentation/driver-api/mmc/mmc-test.rst | 287 ++++++++++++++++++++++
 2 files changed, 288 insertions(+)
 create mode 100644 Documentation/driver-api/mmc/mmc-test.rst

diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/driver-api/mmc/index.rst
index 7339736ac774..8188863e5959 100644
--- a/Documentation/driver-api/mmc/index.rst
+++ b/Documentation/driver-api/mmc/index.rst
@@ -10,4 +10,5 @@ MMC/SD/SDIO card support
    mmc-dev-attrs
    mmc-dev-parts
    mmc-async-req
+   mmc-test
    mmc-tools
diff --git a/Documentation/driver-api/mmc/mmc-test.rst b/Documentation/driver-api/mmc/mmc-test.rst
new file mode 100644
index 000000000000..924f87abcb77
--- /dev/null
+++ b/Documentation/driver-api/mmc/mmc-test.rst
@@ -0,0 +1,287 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+MMC Test Framework
+========================
+
+Overview
+========
+
+The MMC Test Framework (`mmc_test`) is designed to facilitate testing of MMC (MultiMediaCard) devices. It provides a set of tests and utilities to verify the functionality and performance of MMC devices.
+
+Initialization
+==============
+
+To use the ``mmc_test`` framework, follow these steps:
+
+1. **Enable the MMC Test Framework**:
+
+   Ensure that the ``CONFIG_MMC_TEST`` kernel configuration option is enabled. This can be done by configuring the kernel:
+
+   .. code-block:: none
+
+      make menuconfig
+
+   Navigate to:
+
+   Device Drivers  --->
+     <*> MMC/SD/SDIO card support  --->
+       [*]   MMC host test driver
+
+   Alternatively, you can enable it directly in the kernel configuration file:
+
+   .. code-block:: none
+
+      echo "CONFIG_MMC_TEST=y" >> .config
+
+   Rebuild and install the kernel if necessary.
+
+2. **Load the MMC Test Module**:
+
+   If the ``mmc_test`` framework is built as a module, you need to load it using ``modprobe``:
+
+   .. code-block:: none
+
+      modprobe mmc_test
+
+Binding the MMC Card for Testing
+================================
+
+To enable MMC testing, you need to unbind the MMC card from the ``mmcblk`` driver and bind it to the ``mmc_test`` driver. This allows the ``mmc_test`` framework to take control of the MMC card for testing purposes.
+
+1. Identify the MMC card:
+
+   .. code-block:: sh
+
+      ls /sys/bus/mmc/devices/
+
+   This will list the MMC devices, such as ``mmc0:0001``.
+
+2. Unbind the MMC card from the ``mmcblk`` driver:
+
+   .. code-block:: sh
+
+      echo 'mmc0:0001' > /sys/bus/mmc/drivers/mmcblk/unbind
+
+3. Bind the MMC card to the ``mmc_test`` driver:
+
+   .. code-block:: sh
+
+      echo 'mmc0:0001' > /sys/bus/mmc/drivers/mmc_test/bind
+
+After binding, you should see a line in the kernel log indicating that the card has been claimed for testing:
+
+.. code-block:: none
+
+   mmc_test mmc0:0001: Card claimed for testing.
+
+
+Usage - Debugfs Entries
+=======================
+
+Once the ``mmc_test`` framework is enabled, you can interact with the following debugfs entries located in ``/sys/kernel/debug/mmc0/mmc0:0001``:
+
+1. **test**:
+
+   This file is used to run specific tests. Write the test number to this file to execute a test.
+
+   .. code-block:: sh
+
+      echo <test_number> > /sys/kernel/debug/mmc0/mmc0:0001/test
+
+   The test result is indicated in the kernel log info. You can view the kernel log using the `dmesg` command or by checking the log file in `/var/log/`.
+
+   .. code-block:: sh
+
+      dmesg | grep mmc0
+
+   Example:
+
+   To run test number 4 (Basic read with data verification):
+
+   .. code-block:: sh
+
+      echo 4 > /sys/kernel/debug/mmc0/mmc0:0001/test
+
+   Check the kernel log for the result:
+
+   .. code-block:: sh
+
+      dmesg | grep mmc0
+
+2. **testlist**:
+
+   This file lists all available tests. You can read this file to see the list of tests and their corresponding numbers.
+
+   .. code-block:: sh
+
+      cat /sys/kernel/debug/mmc0/mmc0:0001/testlist
+
+   The available tests are listed in the table below:
+
++------+--------------------------------+---------------------------------------------+
+| Test | Test Name                      | Test Description                            |
++======+================================+=============================================+
+| 0    | Run all tests                  | Runs all available tests                    |
++------+--------------------------------+---------------------------------------------+
+| 1    | Basic write                    | Performs a basic write operation of a       |
+|      |                                | single 512-Byte block to the MMC card       |
+|      |                                | without data verification.                  |
++------+--------------------------------+---------------------------------------------+
+| 2    | Basic read                     | Same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 3    | Basic write                    | Performs a basic write operation of a       |
+|      | (with data verification)       | single 512-Byte block to the MMC card       |
+|      |                                | with data verification by reading back      |
+|      |                                | the written data and comparing it.          |
++------+--------------------------------+---------------------------------------------+
+| 4    | Basic read                     | Same for read                               |
+|      | (with data verification)       |                                             |
++------+--------------------------------+---------------------------------------------+
+| 5    | Multi-block write              | Performs a multi-block write operation of   |
+|      |                                | 8 blocks (each 512 bytes) to the MMC card.  |
++------+--------------------------------+---------------------------------------------+
+| 6    | Multi-block read               | Same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 7    | Power of two block writes      | Performs write operations with block sizes  |
+|      |                                | that are powers of two, starting from 1     |
+|      |                                | byte up to 256 bytes, to the MMC card.      |
++------+--------------------------------+---------------------------------------------+
+| 8    | Power of two block reads       | Same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 9    | Weird sized block writes       | Performs write operations with varying      |
+|      |                                | block sizes starting from 3 bytes and       |
+|      |                                | increasing by 7 bytes each iteration, up    |
+|      |                                | to 511 bytes, to the MMC card.              |
++------+--------------------------------+---------------------------------------------+
+| 10   | Weird sized block reads        | same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 11   | Badly aligned write            | Performs write operations with buffers      |
+|      |                                | starting at different alignments (0 to 7    |
+|      |                                | bytes offset) to test how the MMC card      |
+|      |                                | handles unaligned data transfers.           |
++------+--------------------------------+---------------------------------------------+
+| 12   | Badly aligned read             | same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 13   | Badly aligned multi-block write| same for multi-write                        |
++------+--------------------------------+---------------------------------------------+
+| 14   | Badly aligned multi-block read | same for multi-read                         |
++------+--------------------------------+---------------------------------------------+
+| 15   | Proper xfer_size at write      | intentionally create a broken transfer by   |
+|      | (Start failure)   		| modifying the MMC request in a way that it  |
+|      |				| will not perform as expected, e.g. use      |
+|      |				| MMC_WRITE_BLOCK  for a multi-block transfer |
++------+--------------------------------+---------------------------------------------+
+| 16   | Proper xfer_size at read       | same for read                               |
+|      | (Start failure)		|					      |
++------+--------------------------------+---------------------------------------------+
+| 17   | Proper xfer_size at write	| same for 2 blocks			      |
+|      | (Midway failure)               |					      |
++------+--------------------------------+---------------------------------------------+
+| 18   | Proper xfer_size at read       | same for read				      |
+|      | (Midway failure)		|				              |
++------+--------------------------------+---------------------------------------------+
+| 19   | Highmem write                  | use a high memory page                      |
++------+--------------------------------+---------------------------------------------+
+| 20   | Highmem read                   | same for read                               |
++------+--------------------------------+---------------------------------------------+
+| 21   | Multi-block highmem write      | same for multi-write                        |
++------+--------------------------------+---------------------------------------------+
+| 22   | Multi-block highmem read       | same for mult-read                          |
++------+--------------------------------+---------------------------------------------+
+| 23   | Best-case read performance     | Performs 512K sequential read (non sg)      |
++------+--------------------------------+---------------------------------------------+
+| 24   | Best-case write performance    | same for write                              |
++------+--------------------------------+---------------------------------------------+
+| 25   | Best-case read performance     | Same using sg				      |
+|      | (Into scattered pages)         |					      |
++------+--------------------------------+---------------------------------------------+
+| 26   | Best-case write performance    | same for write                              |
+|      | (From scattered pages)         |					      |
++------+--------------------------------+---------------------------------------------+
+| 27   | Single read performance        | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 28   | Single write performance       | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 29   | Single trim performance        | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 30   | Consecutive read performance   | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 31   | Consecutive write performance  | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 32   | Consecutive trim performance   | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 33   | Random read performance        | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 34   | Random write performance       | By transfer size                            |
++------+--------------------------------+---------------------------------------------+
+| 35   | Large sequential read          | Into scattered pages                        |
++------+--------------------------------+---------------------------------------------+
+| 36   | Large sequential write         | From scattered pages                        |
++------+--------------------------------+---------------------------------------------+
+| 37   | Write performance              | With blocking req 4k to 4MB                 |
++------+--------------------------------+---------------------------------------------+
+| 38   | Write performance              | With non-blocking req 4k to 4MB             |
++------+--------------------------------+---------------------------------------------+
+| 39   | Read performance               | With blocking req 4k to 4MB                 |
++------+--------------------------------+---------------------------------------------+
+| 40   | Read performance               | With non-blocking req 4k to 4MB             |
++------+--------------------------------+---------------------------------------------+
+| 41   | Write performance              | Blocking req 1 to 512 sg elems              |
++------+--------------------------------+---------------------------------------------+
+| 42   | Write performance              | Non-blocking req 1 to 512 sg elems          |
++------+--------------------------------+---------------------------------------------+
+| 43   | Read performance               | Blocking req 1 to 512 sg elems              |
++------+--------------------------------+---------------------------------------------+
+| 44   | Read performance               | Non-blocking req 1 to 512 sg elems          |
++------+--------------------------------+---------------------------------------------+
+| 45   | Reset test                     |                                             |
++------+--------------------------------+---------------------------------------------+
+| 46   | Commands during read           | No Set Block Count (CMD23)                  |
++------+--------------------------------+---------------------------------------------+
+| 47   | Commands during write          | No Set Block Count (CMD23)                  |
++------+--------------------------------+---------------------------------------------+
+| 48   | Commands during read           | Use Set Block Count (CMD23)                 |
++------+--------------------------------+---------------------------------------------+
+| 49   | Commands during write          | Use Set Block Count (CMD23)                 |
++------+--------------------------------+---------------------------------------------+
+| 50   | Commands during non-blocking   | Read - use Set Block Count (CMD23)          |
++------+--------------------------------+---------------------------------------------+
+| 51   | Commands during non-blocking   | Write - use Set Block Count (CMD23)         |
++------+--------------------------------+---------------------------------------------+
+
+Test Results
+============
+
+The results of the tests are logged in the kernel log. Each test logs the start, end, and result of the test. The possible results are:
+
+- **OK**: The test completed successfully.
+- **FAILED**: The test failed.
+- **UNSUPPORTED (by host)**: The test is unsupported by the host.
+- **UNSUPPORTED (by card)**: The test is unsupported by the card.
+- **ERROR**: An error occurred during the test.
+
+Example Kernel Log Output
+=========================
+
+When running a test, you will see log entries similar to the following in the kernel log:
+
+.. code-block:: none
+
+   [ 1234.567890] mmc0: Starting tests of card mmc0:0001...
+   [ 1234.567891] mmc0: Test case 4. Basic read (with data verification)...
+   [ 1234.567892] mmc0: Result: OK
+   [ 1234.567893] mmc0: Tests completed.
+
+In this example, test case 4 (Basic read with data verification) was executed, and the result was OK.
+
+
+Contributing
+============
+
+Contributions to the `mmc_test` framework are welcome. Please follow the standard Linux kernel contribution guidelines and submit patches to the appropriate maintainers.
+
+Contact
+=======
+
+For more information or to report issues, please contact the MMC subsystem maintainers.
-- 
2.25.1

