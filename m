Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E61AC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Nov 2022 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiKYICO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Nov 2022 03:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiKYICN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Nov 2022 03:02:13 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40C3303C0
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2022 00:02:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id n7so5536736wrr.13
        for <linux-mmc@vger.kernel.org>; Fri, 25 Nov 2022 00:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b/LKGztIUmoZvCl21IN/IHkgxfyn5vXGQY0dQAMPjaE=;
        b=J23nhO4k13wm5q5qGnFX2KZMrWwBwHURhPryQXxw6gO0/AFUxf2WcWaAIbRsc4ySUG
         7LrikvjupA0/KHWQFv2IeTvQgy2AwyWO5HZ4i1wmKDK0espSoPG7IFEbY5fIwfghVt9u
         T6BPdo5f4E7+ZoE8bGvcJSuuDjJp3iQ8VdGe6HXtoDFj5u5V4tn5xdLKoblHXq06OkoH
         4CbmrC5VUpnCaYPBu7Fctn5TxaBhOvGe9+O88GOawpwbPtBzuPphF6jy1wEVabyLGbG2
         ENEvfbROYVOwoYtDc0o5CyCqn35OR2MwnTqR6LaI3pLO7zj5ecOg3yTx/m/KJkmPiiVu
         ap9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/LKGztIUmoZvCl21IN/IHkgxfyn5vXGQY0dQAMPjaE=;
        b=b+UtV76pprjp+KAueDKMFq0g8E1GnMnSGh3k3YQ8qvcoE59aS9W0OnMWc96iN0cWHc
         47dTFJY5gz2X5R1bJDtO6kS+cCmrpf6roRruOxcUw7BYF/WWEHnNtHMLocJcf7PIvXB2
         42TojEXTGbGSGyNb4fwgp4pUZCsbU/8zh8DJGEKkgSIliB+YE1AavF/VX6eZbzgHWJoe
         eR8eIh58hflw1RhRtTxBx+kSVyn0d3RxZjiaAiYkCrpcpsGno64NGCCdl2zmZloc1gCg
         u/BoM6xFdK8NrICXjtzbEaojLj8z7AVWPdkdl+qZ5pUZN0fEnbPUq091cET4muYmZHVt
         jk7A==
X-Gm-Message-State: ANoB5pmupDNMlwtMjBv9vTwDwsJWHXva1/hZBphLWqPZ8sEkvu1EgbnT
        pHhDcXh3TapA6WXJb4vxMmY=
X-Google-Smtp-Source: AA0mqf5QWY8UfVlgUfAM2SYiPHuriWL1OrveD+1I7uS1Vk6ae2Gi24h/YjzDmGM586XzoFoG++ytjQ==
X-Received: by 2002:adf:f086:0:b0:22e:3725:8acc with SMTP id n6-20020adff086000000b0022e37258accmr14338984wro.330.1669363329073;
        Fri, 25 Nov 2022 00:02:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0560001c1100b00236695ff94fsm3317635wrb.34.2022.11.25.00.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 00:02:08 -0800 (PST)
Date:   Fri, 25 Nov 2022 11:01:52 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     jiasheng@iscas.ac.cn
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] memstick/ms_block: Add check for alloc_ordered_workqueue
Message-ID: <Y4B2cIhw6DVSkvKD@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Jiasheng Jiang,

The patch cb713d1f69ae: "memstick/ms_block: Add check for
alloc_ordered_workqueue" from Nov 22, 2022, leads to the following
Smatch static checker warnings:

    drivers/memstick/core/ms_block.c:2143 msb_init_disk()
    warn: 'msb->io_queue' from alloc_workqueue() not released on lines: 2143.

    drivers/memstick/core/ms_block.c:2120 msb_init_disk()
    warn: missing error code here? 'alloc_workqueue()' failed. 'rc' = '0'

drivers/memstick/core/ms_block.c
    2078 static int msb_init_disk(struct memstick_dev *card)
    2079 {
    2080         struct msb_data *msb = memstick_get_drvdata(card);
    2081         int rc;
    2082         unsigned long capacity;
    2083 
    2084         mutex_lock(&msb_disk_lock);
    2085         msb->disk_id = idr_alloc(&msb_disk_idr, card, 0, 256, GFP_KERNEL);
    2086         mutex_unlock(&msb_disk_lock);
    2087 
    2088         if (msb->disk_id  < 0)
    2089                 return msb->disk_id;
    2090 
    2091         rc = blk_mq_alloc_sq_tag_set(&msb->tag_set, &msb_mq_ops, 2,
    2092                                      BLK_MQ_F_SHOULD_MERGE);
    2093         if (rc)
    2094                 goto out_release_id;
    2095 
    2096         msb->disk = blk_mq_alloc_disk(&msb->tag_set, card);
    2097         if (IS_ERR(msb->disk)) {
    2098                 rc = PTR_ERR(msb->disk);
    2099                 goto out_free_tag_set;
    2100         }
    2101         msb->queue = msb->disk->queue;
    2102 
    2103         blk_queue_max_hw_sectors(msb->queue, MS_BLOCK_MAX_PAGES);
    2104         blk_queue_max_segments(msb->queue, MS_BLOCK_MAX_SEGS);
    2105         blk_queue_max_segment_size(msb->queue,
    2106                                    MS_BLOCK_MAX_PAGES * msb->page_size);
    2107         blk_queue_logical_block_size(msb->queue, msb->page_size);
    2108 
    2109         sprintf(msb->disk->disk_name, "msblk%d", msb->disk_id);
    2110         msb->disk->fops = &msb_bdops;
    2111         msb->disk->private_data = msb;
    2112 
    2113         capacity = msb->pages_in_block * msb->logical_block_count;
    2114         capacity *= (msb->page_size / 512);
    2115         set_capacity(msb->disk, capacity);
    2116         dbg("Set total disk size to %lu sectors", capacity);
    2117 
    2118         msb->io_queue = alloc_ordered_workqueue("ms_block", WQ_MEM_RECLAIM);
    2119         if (!msb->io_queue)
--> 2120                 goto out_cleanup_disk;

Set error code.  Also this ->io_queue doesn't seem to be freed when we
unload the driver.

    2121 
    2122         INIT_WORK(&msb->io_work, msb_io_work);
    2123         sg_init_table(msb->prealloc_sg, MS_BLOCK_MAX_SEGS+1);
    2124 
    2125         if (msb->read_only)
    2126                 set_disk_ro(msb->disk, 1);
    2127 
    2128         msb_start(card);
    2129         rc = device_add_disk(&card->dev, msb->disk, NULL);
    2130         if (rc)
    2131                 goto out_cleanup_disk;

Needs to free msb->io_queue.

    2132         dbg("Disk added");
    2133         return 0;
    2134 
    2135 out_cleanup_disk:
    2136         put_disk(msb->disk);
    2137 out_free_tag_set:
    2138         blk_mq_free_tag_set(&msb->tag_set);
    2139 out_release_id:
    2140         mutex_lock(&msb_disk_lock);
    2141         idr_remove(&msb_disk_idr, msb->disk_id);
    2142         mutex_unlock(&msb_disk_lock);
    2143         return rc;
    2144 }

regards,
dan carpenter
