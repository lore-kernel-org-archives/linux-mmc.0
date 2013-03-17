From: Chris Ball <cjb@laptop.org>
Subject: When bus width detection procedure takes place, kernel cannot lock on correct bus width
Date: Sun, 17 Mar 2013 08:07:20 -0400
Message-ID: <87ip4qdybr.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50888 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755911Ab3CQMH3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 17 Mar 2013 08:07:29 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: elad.yi@gmail.com
Cc: linux-mmc@vger.kernel.org, Philip Rakity <prakity@nvidia.com>

Hi Elad, I'm forwarding your bug report to the linux-mmc@ list.

- Chris.


I've been working on a bringup of an new board in Harmonic Inc.
This board uses Sandisk iNand eMMC flash.
I've noticed that the mmc driver keeps detecting 1 bit width although HW
supports 4 bit, looked into it, and found the problem. In line 571 at mmc.c:
There is:
    /* only compare read only fields */
    err = !((card->ext_csd.raw_partition_support ==
            bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
        (card->ext_csd.raw_erased_mem_count ==
            bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
        (card->ext_csd.rev ==
            bw_ext_csd[EXT_CSD_REV]) &&
        (card->ext_csd.raw_ext_csd_structure ==
                ...

The problem is that raw_partition_support is not the same when setting width of
4 bits instead of 1 bit, and shouldn't be compared at all although it is read
only.
this should be changed to:
    /* only compare read only fields */
    err = !((card->ext_csd.raw_erased_mem_count ==
            bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
        (card->ext_csd.rev ==
            bw_ext_csd[EXT_CSD_REV]) &&
        (card->ext_csd.raw_ext_csd_structure ==
                ...

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
