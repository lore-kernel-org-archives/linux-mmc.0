Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2860C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 16:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbhKWQNd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbhKWQNd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 11:13:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBED4C061714
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 08:10:24 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y16so28558562ioc.8
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=BBzlLrTrS/IeOvojVG6B2YAMmVNucDgXMCrBKUQHp3A=;
        b=KM9m/9NO16jrFQdtSOl7VuCSuvSZnB0mKzK6rU/bX1rphB9E6lzkSgXDh98JB1wXiT
         jN8i5gQJ04SZpipP/jqEUSJs8hZVP2kl4oH6rUEuy4hiE0LVCtJzlqKjRcodnFw30AiK
         3Dr3YQ3kZk3fxDHP7R3lg3zLIG0VxbQos3Ac9OoObyFe3b9kZZ8C97gsHsJjAW2BIxwq
         UxxRgHSkcvj6Od6dIRNmLO3ysIjIGdJRa4IcCF++BlNZKlCFKWZpRJa5AESVI7y/0rov
         UPjGSFN6LS7XZEkH4aS0UFRyyGqYxrtYD9bxy6SCJ6/K1RbF694f6ZK6qK/UtpkpZbgK
         UJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=BBzlLrTrS/IeOvojVG6B2YAMmVNucDgXMCrBKUQHp3A=;
        b=xXQikt/zdRZy86s4nGtsWJ88wCuZN3m96blmD+Nz1O19ByHMkjT3GY0kiceOrgxBvi
         u0BzyX79tx3kxBKwhDkXC64+1EqzuU6eBmKcVyB4/sTVJm+t7yQD63FoGCTnTgGWimLB
         qN4f8InRS/julV9Ro9PgzH7JRxQXWdFBX7k2wGVx6fP4TbV1/78Q2ybKlmDIKL6CXrQu
         7TZIp1vQ66GAXzhEadwisveo5nmv/iOUcDu86enateVFJy5p1iea6BdVUOupzwGvSsxg
         6GzDfgF5LiejTKk2gZeO018E3adu4RRx8+gXvojhQibe3tivnor/oeTWBS+RiDcw80SU
         +mkA==
X-Gm-Message-State: AOAM531SqLENDiDFGdlJ9fDrt8dUYErcaTQbgKQ6tdH8nc9XZhBmUxmE
        /I0KuGQpoflhkVeulq0f+WDyDg==
X-Google-Smtp-Source: ABdhPJz026wQv9Aw2uRTbLzf/nFtsrGS58vFhx0zbszKyXiSWAlSuNrIsMrQqy/FSQgRny8ysi2nUw==
X-Received: by 2002:a5e:8a41:: with SMTP id o1mr7092945iom.131.1637683824237;
        Tue, 23 Nov 2021 08:10:24 -0800 (PST)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id a13sm7538001ilc.34.2021.11.23.08.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:10:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
In-Reply-To: <20211122130625.1136848-1-hch@lst.de>
References: <20211122130625.1136848-1-hch@lst.de>
Subject: Re: cleanup and simplify the gendisk flags
Message-Id: <163768382336.322883.1673932002776910278.b4-ty@kernel.dk>
Date:   Tue, 23 Nov 2021 09:10:23 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Nov 2021 14:06:11 +0100, Christoph Hellwig wrote:
> Ho Jens,
> 
> the gendisk flags have been a complete mess for a while.  This series
> tries to untangle them as much as easily possible.
> 
> Diffstat:
>  block/bdev.c                       |    5 --
>  block/blk.h                        |    1
>  block/genhd.c                      |   41 +++++++----------
>  block/ioctl.c                      |   31 ++-----------
>  block/partitions/core.c            |   24 ++++------
>  drivers/block/amiflop.c            |    1
>  drivers/block/ataflop.c            |    1
>  drivers/block/brd.c                |    1
>  drivers/block/drbd/drbd_main.c     |    1
>  drivers/block/floppy.c             |    1
>  drivers/block/loop.c               |    9 +--
>  drivers/block/n64cart.c            |    2
>  drivers/block/null_blk/main.c      |    1
>  drivers/block/paride/pcd.c         |    3 -
>  drivers/block/paride/pf.c          |    1
>  drivers/block/pktcdvd.c            |    2
>  drivers/block/ps3vram.c            |    1
>  drivers/block/rbd.c                |    6 --
>  drivers/block/sunvdc.c             |   17 +++----
>  drivers/block/swim.c               |    1
>  drivers/block/swim3.c              |    2
>  drivers/block/virtio_blk.c         |    1
>  drivers/block/xen-blkback/xenbus.c |    2
>  drivers/block/xen-blkfront.c       |   26 ++++-------
>  drivers/block/z2ram.c              |    1
>  drivers/block/zram/zram_drv.c      |    1
>  drivers/cdrom/gdrom.c              |    1
>  drivers/md/dm.c                    |    1
>  drivers/md/md.c                    |    5 --
>  drivers/mmc/core/block.c           |    4 -
>  drivers/mtd/ubi/block.c            |    1
>  drivers/scsi/sd.c                  |    1
>  drivers/scsi/sr.c                  |    6 +-
>  include/linux/genhd.h              |   85 +++++++++----------------------------
>  34 files changed, 104 insertions(+), 183 deletions(-)
> 
> [...]

Applied, thanks!

[01/14] block: move GENHD_FL_NATIVE_CAPACITY to disk->state
        (no commit info)
[02/14] block: move GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE to disk->event_flags
        (no commit info)
[03/14] block: remove GENHD_FL_CD
        (no commit info)
[04/14] block: remove a dead check in show_partition
        (no commit info)
[05/14] block: merge disk_scan_partitions and blkdev_reread_part
        (no commit info)
[06/14] block: rename GENHD_FL_NO_PART_SCAN to GENHD_FL_NO_PART
        (no commit info)
[07/14] block: remove the GENHD_FL_HIDDEN check in blkdev_get_no_open
        (no commit info)
[08/14] null_blk: don't suppress partitioning information
        (no commit info)
[09/14] mmc: don't set GENHD_FL_SUPPRESS_PARTITION_INFO
        (no commit info)
[10/14] block: remove GENHD_FL_SUPPRESS_PARTITION_INFO
        (no commit info)
[11/14] block: remove GENHD_FL_EXT_DEVT
        (no commit info)
[12/14] block: don't set GENHD_FL_NO_PART for hidden gendisks
        (no commit info)
[13/14] block: cleanup the GENHD_FL_* definitions
        (no commit info)
[14/14] sr: set GENHD_FL_REMOVABLE earlier
        (no commit info)

Best regards,
-- 
Jens Axboe


