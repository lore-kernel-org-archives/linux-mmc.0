From: Jon Pry <jonpry@gmail.com>
Subject: [BUG] sdhci-acpi/adma/64-bit/3.17 data corruption
Date: Thu, 16 Oct 2014 11:26:00 -0400
Message-ID: <CA+3xLx7Munmd7y_9er8s6vOvdwrhFsCeNyE=Q=edK=TKN4R_1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:52116 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196AbaJPP0D (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Oct 2014 11:26:03 -0400
Received: by mail-vc0-f171.google.com with SMTP id hy10so2855187vcb.16
        for <linux-mmc@vger.kernel.org>; Thu, 16 Oct 2014 08:26:02 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

    Be forewarned, this is probably the worst bug report ever, but the
nature of the problem is making it difficult to learn anything more
about. Issue is also very serious, causing continuous and unreported
corruption of the entire filesystem. My platform is ASUS T100 using
Intel Baytrail-T aka VLV. Which is using the sdhci-acpi driver.

Some background:

    I started messing with the eMMC trying to get it to work
correctly. This doesn't work out-of-the-box do to various timeout
problems. There are non-mainline patches available for these issues.
The one most relevant is to use pm_qos to prevent device from hitting
C3 while transfers are in progress. There are at least 2 versions of
the patch running around. The intel authored one that inserts pm_qos
into mmc/core and an android one that uses runtime-pm hooks and auto
idle for the same purpose. The intel one has commit message like "ADMA
error unreproducible with this patch". I've found that is not exactly
true, it is just much less frequent. I guess they did not try very
hard. The runtime-pm version however does seem to eliminate the
timeout errors.

   So at this point I have an eMMC setup that will run indefinitely.
Don't have to worry about system hangs after transferring 1GB or so.
I started getting the feeling that my data was being corrupted though.
To verify this i would run debsum -c, and sure enough on every run, a
different list of corrupted files would show up, with the previous
files being magically fixed. We are talking error rates of about 5 to
100 per 10GB. Not sure if these errors are bits/bytes/sectors/blocks
or what, but they are present for sure.

   No errors show up in dmesg, that is until the filesystem eventually
gets so trashed that ext4 starts catching it. Seeing as how mmc has
data crc, and no errors were found, I suspected that actual transfer
to/from emmc was flawless and somehow things were getting messed up
after rx. First thing was to run memtest, but everything was fine. I
then disabled ADMA in sdhc-acpi via quirk, causing a switch to SDMA,
and bam, errors all gone.

   It has been reported by one of my minions that there is no data
corruption on 32bit build of the same kernel. It is unclear to me if
this is a specific issue with VLV hardware, or general issue with
64bit ADMA. Also not clear if issue is specific to 3.17. It will be
hard to bisect since my patches only fit on top of 3.17.

   I already have a fix that works for me. I'm writing this so that if
others get similar issues there will be another data point to help
determine the root cause and/or breadth of the issue.

Cheers,

Jon Pry
