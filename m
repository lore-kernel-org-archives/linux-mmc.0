From: Angelo Dureghello <angelo70@gmail.com>
Subject: Re: davinci_mmc issues on kernel 3.17.0
Date: Thu, 20 Nov 2014 12:24:24 +0100
Message-ID: <546DCF68.6040100@gmail.com>
References: <546CAA0D.3090107@gmail.com> <546CB7D2.50903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:55130 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaKTLY1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 06:24:27 -0500
Received: by mail-wg0-f46.google.com with SMTP id x12so3407973wgg.19
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 03:24:26 -0800 (PST)
Received: from [192.168.0.2] (host15-234-dynamic.54-79-r.retail.telecomitalia.it. [79.54.234.15])
        by mx.google.com with ESMTPSA id es6sm2923254wjd.29.2014.11.20.03.24.25
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Nov 2014 03:24:25 -0800 (PST)
In-Reply-To: <546CB7D2.50903@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Sorry for the confusion,

i realized the card i use in the old kernel board is 8G, the one in 
kernel 3.17.0 is 4G,
so the size / inodes i see in mkfs or fdisk are correct.

I can confirm i have issues on the "write" part. With whatever FS,
if i format the card on PC, and then
fsck on the arm device board with kernel 3.17.0, fsck find no errors.
While if i mkfs on kernel 3.17.0 and then put the card on PC, it can't 
even be mounted,
and fsck gives errors.

I finally run mmc_test, in both PIO 4-bit and DMA 4-bit modes:

in PIO, all tests pass except 17
[root@barix boot]# echo 17 > /sys/kernel/debug/mmc0/mmc0\:0002/test
mmc0: Starting tests of card mmc0:0002...
mmc0: Test case 17. Correct xfer_size at write (midway failure)...
mmc0: Result: ERROR (-84)
mmc0: Tests completed

in DMA, test 17 fails too, and test 25 locks up.

[root@barix boot]# echo 17 > /sys/kernel/debug/mmc0/mmc0\:0002/test
mmc0: Starting tests of card mmc0:0002...
mmc0: Test case 17. Correct xfer_size at write (midway failure)...
mmc0: Result: ERROR (-84)
mmc0: Tests completed.

[root@barix boot]# echo 25 > /sys/kernel/debug/mmc0/mmc0\:0002/test
mmc0: Starting tests of card mmc0:0002...
mmc0: Test case 25. Best-case read performance into scattered pages...
edma-dma-engine edma-dma-engine.1: edma_prep_slave_sg: Failed to 
allocate slot


so seems i have some additional dma issue.

regards

