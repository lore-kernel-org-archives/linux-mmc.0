Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCE198A1B
	for <linux-mmc@vger.kernel.org>; Thu,  5 Sep 2024 10:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531542; cv=none; b=IpDHZ8nIKow5NQ+2rMFR+7pTvxOFy0JZPn9CadkAaoMqXYtFQbiWwNqfKcCAlcnxcu7p4qp8fHPxecIDBSliJD5lSgQyGmVjx5i8fcu9au1D0gMLPYOZAB+eyKpIT32edinalvUuPad3sy79g8tO2VPbCo/+aq/9QHh1nGFrirQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531542; c=relaxed/simple;
	bh=sOhLvIMvzN71eGezoC1Bl1dW+QU8RVJNA3eXhu/CotA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvbSLf9y77miSS/TejdK3TheGsh2rMWEUmHZtNaMbbXu65psmzNObIIwafydI1vege03cw7K6S3dg3cIbMvciOIWi0IExv3lPiXpPaK26gyXuHCBcs0S+cBOFLSVHmH6A1PfEtB8sudk58CPTk9i1146heD2JHhFva292SXwDX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h45Dp25S; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h45Dp25S"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso634195276.2
        for <linux-mmc@vger.kernel.org>; Thu, 05 Sep 2024 03:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725531539; x=1726136339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EnB3vqWo5hghQZ+Rxhij6sESV/MpaOY1m0SBsy6W2qY=;
        b=h45Dp25SFU5aHxyAEe41dP3Fe8aAkIh+XyuOfrl5iQVrpyrvX+rVTcpszqPo2aR4vk
         88uSTYKxRO12m2bfDndT7sZDwq+lfn39SVHc5r7R08TKK7eOrUNa2BBU5yr4Fsam5wPJ
         zeddo/APGNgJSOyvSoyB2huAPvY0PXIrDE29yuG9XNE547fXQaO/VlMMvhrCU2Vfk5m3
         Ws/0wPZndvju7q2qbFFO7lIR+2W2ZnhzT/jt8XagQWZUS1KSN5pg2iEhNifF07pL3yxf
         xEVq3MXE7rtOuQ1/duLX7DWb0bT03baDg2LTGchmjYq53MlFgKfkh6vcdf7j1OP1cxTv
         W3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531539; x=1726136339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EnB3vqWo5hghQZ+Rxhij6sESV/MpaOY1m0SBsy6W2qY=;
        b=Lh9rjPkRQkr+ZeoaPXJdenECVSRvdWy5k8ufTxqpHOYT4fZNi83FGe2PMP2HRcDZoL
         tCcX6dUuoTgN3THuDZviAAt2G6EWWgiK59/87PJ6wjmOEjtEkeRNzErRKDh68jNo1vSS
         /Ppis7shrBdYkG+U9QUmNv0gBVS3VkB0Lj01+Nl69ejGqoldbfySBah7fNCTKc5uNl5C
         Cf70zW2Bz5FsZ+gSaf2UqFlEK4nhwgqtyf4b1ttE9SNTgkxKuPuhHRJgZytKBrPD4eN0
         kXiMFQdmoQ3vqNRo8BmAU/qyk3A3q+Y2mvQ5eYVcImTjNaEqPA5XoWqUh05WEfskZc4j
         OyEw==
X-Gm-Message-State: AOJu0YwQ1wr6KVbe2Xbt6nhZXom/Lh/jkzfY4EXwVlk964S3P0Tj7eN4
	MigU+Rz49iXQbAkE8dl8Cf9bTDMvzEQVOUcZ6rhbXzhBCjNgDM29gTv4irMAx0iL8AfLgaWFDA2
	Vr+EvASrr65r0G1gnuAofCicaYdC3xld/sDpeEuMMFZVGAOE4
X-Google-Smtp-Source: AGHT+IGa+iT6pISRa/fHRZD2ENXE0AxuTaCiyGDsunjZYkdi+Ta8baNTLX3BrCaogAiAmfqgsMu6RJPxuRgRZTJrU0k=
X-Received: by 2002:a05:6902:1881:b0:e1a:90d6:4122 with SMTP id
 3f1490d57ef6-e1d0e77d274mr7044994276.17.1725531538795; Thu, 05 Sep 2024
 03:18:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903133855.3589845-1-avri.altman@wdc.com>
In-Reply-To: <20240903133855.3589845-1-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 5 Sep 2024 12:18:22 +0200
Message-ID: <CAPDyKFqxoofJtafdb12tMJS44w1cw3k6-cNQnsDPYKSSvJ91YA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: mmc: Add mmc-test doc
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sept 2024 at 15:40, Avri Altman <avri.altman@wdc.com> wrote:
>
> Add missing documentation for mmc_test.
>
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Thanks for helping with documentation, it's certainly needed for
things related to the MMC subsystem.

Applied for next, thanks!

Kind regards
Uffe



>
> ---
> Changes in v2:
>  - Fix commit log (Christian)
>  - Elaborate the overview section (Christian & Adrian)
> ---
>  Documentation/driver-api/mmc/index.rst    |   1 +
>  Documentation/driver-api/mmc/mmc-test.rst | 299 ++++++++++++++++++++++
>  2 files changed, 300 insertions(+)
>  create mode 100644 Documentation/driver-api/mmc/mmc-test.rst
>
> diff --git a/Documentation/driver-api/mmc/index.rst b/Documentation/drive=
r-api/mmc/index.rst
> index 7339736ac774..8188863e5959 100644
> --- a/Documentation/driver-api/mmc/index.rst
> +++ b/Documentation/driver-api/mmc/index.rst
> @@ -10,4 +10,5 @@ MMC/SD/SDIO card support
>     mmc-dev-attrs
>     mmc-dev-parts
>     mmc-async-req
> +   mmc-test
>     mmc-tools
> diff --git a/Documentation/driver-api/mmc/mmc-test.rst b/Documentation/dr=
iver-api/mmc/mmc-test.rst
> new file mode 100644
> index 000000000000..1fe33eb43742
> --- /dev/null
> +++ b/Documentation/driver-api/mmc/mmc-test.rst
> @@ -0,0 +1,299 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +MMC Test Framework
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The `mmc_test` framework is designed to test the performance and reliabi=
lity of host controller drivers and all devices handled by the MMC subsyste=
m. This includes not only MMC devices but also SD cards and other devices s=
upported by the subsystem.
> +
> +The framework provides a variety of tests to evaluate different aspects =
of the host controller and device interactions, such as read and write perf=
ormance, data integrity, and error handling. These tests help ensure that t=
he host controller drivers and devices operate correctly under various cond=
itions.
> +
> +The `mmc_test` framework is particularly useful for:
> +
> +- Verifying the functionality and performance of MMC and SD host control=
ler drivers.
> +- Ensuring compatibility and reliability of MMC and SD devices.
> +- Identifying and diagnosing issues in the MMC subsystem.
> +
> +The results of the tests are logged in the kernel log, providing detaile=
d information about the test outcomes and any encountered issues.
> +
> +Note: whatever is on your card will be overwritten by these tests.
> +
> +Initialization
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To use the ``mmc_test`` framework, follow these steps:
> +
> +1. **Enable the MMC Test Framework**:
> +
> +   Ensure that the ``CONFIG_MMC_TEST`` kernel configuration option is en=
abled. This can be done by configuring the kernel:
> +
> +   .. code-block:: none
> +
> +      make menuconfig
> +
> +   Navigate to:
> +
> +   Device Drivers  --->
> +     <*> MMC/SD/SDIO card support  --->
> +       [*]   MMC host test driver
> +
> +   Alternatively, you can enable it directly in the kernel configuration=
 file:
> +
> +   .. code-block:: none
> +
> +      echo "CONFIG_MMC_TEST=3Dy" >> .config
> +
> +   Rebuild and install the kernel if necessary.
> +
> +2. **Load the MMC Test Module**:
> +
> +   If the ``mmc_test`` framework is built as a module, you need to load =
it using ``modprobe``:
> +
> +   .. code-block:: none
> +
> +      modprobe mmc_test
> +
> +Binding the MMC Card for Testing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +To enable MMC testing, you need to unbind the MMC card from the ``mmcblk=
`` driver and bind it to the ``mmc_test`` driver. This allows the ``mmc_tes=
t`` framework to take control of the MMC card for testing purposes.
> +
> +1. Identify the MMC card:
> +
> +   .. code-block:: sh
> +
> +      ls /sys/bus/mmc/devices/
> +
> +   This will list the MMC devices, such as ``mmc0:0001``.
> +
> +2. Unbind the MMC card from the ``mmcblk`` driver:
> +
> +   .. code-block:: sh
> +
> +      echo 'mmc0:0001' > /sys/bus/mmc/drivers/mmcblk/unbind
> +
> +3. Bind the MMC card to the ``mmc_test`` driver:
> +
> +   .. code-block:: sh
> +
> +      echo 'mmc0:0001' > /sys/bus/mmc/drivers/mmc_test/bind
> +
> +After binding, you should see a line in the kernel log indicating that t=
he card has been claimed for testing:
> +
> +.. code-block:: none
> +
> +   mmc_test mmc0:0001: Card claimed for testing.
> +
> +
> +Usage - Debugfs Entries
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Once the ``mmc_test`` framework is enabled, you can interact with the fo=
llowing debugfs entries located in ``/sys/kernel/debug/mmc0/mmc0:0001``:
> +
> +1. **test**:
> +
> +   This file is used to run specific tests. Write the test number to thi=
s file to execute a test.
> +
> +   .. code-block:: sh
> +
> +      echo <test_number> > /sys/kernel/debug/mmc0/mmc0:0001/test
> +
> +   The test result is indicated in the kernel log info. You can view the=
 kernel log using the `dmesg` command or by checking the log file in `/var/=
log/`.
> +
> +   .. code-block:: sh
> +
> +      dmesg | grep mmc0
> +
> +   Example:
> +
> +   To run test number 4 (Basic read with data verification):
> +
> +   .. code-block:: sh
> +
> +      echo 4 > /sys/kernel/debug/mmc0/mmc0:0001/test
> +
> +   Check the kernel log for the result:
> +
> +   .. code-block:: sh
> +
> +      dmesg | grep mmc0
> +
> +2. **testlist**:
> +
> +   This file lists all available tests. You can read this file to see th=
e list of tests and their corresponding numbers.
> +
> +   .. code-block:: sh
> +
> +      cat /sys/kernel/debug/mmc0/mmc0:0001/testlist
> +
> +   The available tests are listed in the table below:
> +
> ++------+--------------------------------+-------------------------------=
--------------+
> +| Test | Test Name                      | Test Description              =
              |
> ++=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> +| 0    | Run all tests                  | Runs all available tests      =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 1    | Basic write                    | Performs a basic write operati=
on of a       |
> +|      |                                | single 512-Byte block to the M=
MC card       |
> +|      |                                | without data verification.    =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 2    | Basic read                     | Same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 3    | Basic write                    | Performs a basic write operati=
on of a       |
> +|      | (with data verification)       | single 512-Byte block to the M=
MC card       |
> +|      |                                | with data verification by read=
ing back      |
> +|      |                                | the written data and comparing=
 it.          |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 4    | Basic read                     | Same for read                 =
              |
> +|      | (with data verification)       |                               =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 5    | Multi-block write              | Performs a multi-block write o=
peration of   |
> +|      |                                | 8 blocks (each 512 bytes) to t=
he MMC card.  |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 6    | Multi-block read               | Same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 7    | Power of two block writes      | Performs write operations with=
 block sizes  |
> +|      |                                | that are powers of two, starti=
ng from 1     |
> +|      |                                | byte up to 256 bytes, to the M=
MC card.      |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 8    | Power of two block reads       | Same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 9    | Weird sized block writes       | Performs write operations with=
 varying      |
> +|      |                                | block sizes starting from 3 by=
tes and       |
> +|      |                                | increasing by 7 bytes each ite=
ration, up    |
> +|      |                                | to 511 bytes, to the MMC card.=
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 10   | Weird sized block reads        | same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 11   | Badly aligned write            | Performs write operations with=
 buffers      |
> +|      |                                | starting at different alignmen=
ts (0 to 7    |
> +|      |                                | bytes offset) to test how the =
MMC card      |
> +|      |                                | handles unaligned data transfe=
rs.           |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 12   | Badly aligned read             | same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 13   | Badly aligned multi-block write| same for multi-write          =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 14   | Badly aligned multi-block read | same for multi-read           =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 15   | Proper xfer_size at write      | intentionally create a broken =
transfer by   |
> +|      | (Start failure)               | modifying the MMC request in a =
way that it  |
> +|      |                               | will not perform as expected, e=
.g. use      |
> +|      |                               | MMC_WRITE_BLOCK  for a multi-bl=
ock transfer |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 16   | Proper xfer_size at read       | same for read                 =
              |
> +|      | (Start failure)               |                                =
             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 17   | Proper xfer_size at write     | same for 2 blocks              =
             |
> +|      | (Midway failure)               |                               =
             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 18   | Proper xfer_size at read       | same for read                 =
                     |
> +|      | (Midway failure)              |                                =
             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 19   | Highmem write                  | use a high memory page        =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 20   | Highmem read                   | same for read                 =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 21   | Multi-block highmem write      | same for multi-write          =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 22   | Multi-block highmem read       | same for mult-read            =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 23   | Best-case read performance     | Performs 512K sequential read =
(non sg)      |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 24   | Best-case write performance    | same for write                =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 25   | Best-case read performance     | Same using sg                 =
                     |
> +|      | (Into scattered pages)         |                               =
             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 26   | Best-case write performance    | same for write                =
              |
> +|      | (From scattered pages)         |                               =
             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 27   | Single read performance        | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 28   | Single write performance       | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 29   | Single trim performance        | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 30   | Consecutive read performance   | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 31   | Consecutive write performance  | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 32   | Consecutive trim performance   | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 33   | Random read performance        | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 34   | Random write performance       | By transfer size              =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 35   | Large sequential read          | Into scattered pages          =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 36   | Large sequential write         | From scattered pages          =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 37   | Write performance              | With blocking req 4k to 4MB   =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 38   | Write performance              | With non-blocking req 4k to 4M=
B             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 39   | Read performance               | With blocking req 4k to 4MB   =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 40   | Read performance               | With non-blocking req 4k to 4M=
B             |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 41   | Write performance              | Blocking req 1 to 512 sg elems=
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 42   | Write performance              | Non-blocking req 1 to 512 sg e=
lems          |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 43   | Read performance               | Blocking req 1 to 512 sg elems=
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 44   | Read performance               | Non-blocking req 1 to 512 sg e=
lems          |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 45   | Reset test                     |                               =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 46   | Commands during read           | No Set Block Count (CMD23)    =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 47   | Commands during write          | No Set Block Count (CMD23)    =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 48   | Commands during read           | Use Set Block Count (CMD23)   =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 49   | Commands during write          | Use Set Block Count (CMD23)   =
              |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 50   | Commands during non-blocking   | Read - use Set Block Count (CM=
D23)          |
> ++------+--------------------------------+-------------------------------=
--------------+
> +| 51   | Commands during non-blocking   | Write - use Set Block Count (C=
MD23)         |
> ++------+--------------------------------+-------------------------------=
--------------+
> +
> +Test Results
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +The results of the tests are logged in the kernel log. Each test logs th=
e start, end, and result of the test. The possible results are:
> +
> +- **OK**: The test completed successfully.
> +- **FAILED**: The test failed.
> +- **UNSUPPORTED (by host)**: The test is unsupported by the host.
> +- **UNSUPPORTED (by card)**: The test is unsupported by the card.
> +- **ERROR**: An error occurred during the test.
> +
> +Example Kernel Log Output
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +When running a test, you will see log entries similar to the following i=
n the kernel log:
> +
> +.. code-block:: none
> +
> +   [ 1234.567890] mmc0: Starting tests of card mmc0:0001...
> +   [ 1234.567891] mmc0: Test case 4. Basic read (with data verification)=
...
> +   [ 1234.567892] mmc0: Result: OK
> +   [ 1234.567893] mmc0: Tests completed.
> +
> +In this example, test case 4 (Basic read with data verification) was exe=
cuted, and the result was OK.
> +
> +
> +Contributing
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Contributions to the `mmc_test` framework are welcome. Please follow the=
 standard Linux kernel contribution guidelines and submit patches to the ap=
propriate maintainers.
> +
> +Contact
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +For more information or to report issues, please contact the MMC subsyst=
em maintainers.
> --
> 2.25.1
>
