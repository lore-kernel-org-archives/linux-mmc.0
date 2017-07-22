From: Shaobo <shaobo@cs.utah.edu>
Subject: Potentially invalid memory accesses in file drivers/mmc/core/block.c
Date: Fri, 21 Jul 2017 19:37:43 -0600
Message-ID: <003501d30289$89f86990$9de93cb0$@Domain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rio.cs.utah.edu ([155.98.64.241]:51137 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbdGVBoB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jul 2017 21:44:01 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, axboe@fb.com, geert@linux-m68k.org

Hi there,

My name is Shaobo He and I am a graduate student at University of Utah. 
I am using a static analysis tool to search for null pointer 
dereferences and came across a couple of potentially invalid memory 
accesses in the file drivers/mmc/core/block.c: in function 
`force_ro_store`, function `mmc_blk_get` can return a NULL pointer. 
However, there are a couple of conditions that can make the error path 
infeasible. I was wondering if you could confirm this. Especially if the 
condition `dev_to_disk(dev)->private_data && 
dev_to_disk(dev)->private_data->usage != 0` serves as a reasonable 
precondition of function `force_ro_store`.

Please let me know if it makes sense. I am looking forward to your 
reply.

Best,
Shaobo
