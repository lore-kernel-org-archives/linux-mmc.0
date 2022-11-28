Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43777C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Nov 2022 14:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiK1OrQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Nov 2022 09:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiK1Oq2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Nov 2022 09:46:28 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CC2338B
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 06:45:58 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso14262351pjt.0
        for <linux-mmc@vger.kernel.org>; Mon, 28 Nov 2022 06:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uwypJt2pbpSnqaKUhdNDX85hjjGPSY5lq4no+chAH5o=;
        b=qul9P9dsfRtS9FnYBq7V5iw0GxgW7CKYp54Fy3P1Vk5Nd2VET1yvFKB0J+Ar/sj//c
         CD2Q2M/ILzO0aHzSLAVgJLkX3h1mPjjXLKT1CIVMKN93jPC17JZFH0Kbr05F4zGEsvCP
         /mEAkd/g13Zc2Q0+cowFCVQ7ZNVXt8bOoCzrj5fY4QMwUBRwCTuHuMMDrCidjpbhe2YY
         5Yj62W2dcuZ6qd4h2EutIP8ajhZQsjHulo1pwwZpdgzaQM/U0gDVkWfPOvXiMbx1gnnC
         x9LqCYKW60nKernwO701tWvnQvUH+3jwIrvqAkKsxkSkpRtvCBk/GG6VSNGoOOatYZ31
         QKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uwypJt2pbpSnqaKUhdNDX85hjjGPSY5lq4no+chAH5o=;
        b=DG1XpKt2Rj/2HsEG8Zoh/IxNupfwfV9ecZfwWZQmH86WSPwU/IpCr4mrxe5dM5f49/
         458m4vQiRtxyDjStJpUIAOWfyCR252tUK/Y3IplpKDbV9qy0Fn3VGRC2xhf5sr2j1i94
         XU8tV/Ca0u6bj83Y0Pci6QhjD0nDDv+WjS8khjBSSsPXnkNc9WzelGVTn3nNTPbfYOzw
         Tq5rItPnOegtrukEua6T6oWAS5HiKfPDyZKqLxCzng2+NhrXlT6T1n9UB5lNe2YruZP6
         rJQAmQClpB0XQ0n1NohD53d9ul2SbosZ4TGvaILpIE5hZaWFnQ2YMNMZ3LVDEQILcsa5
         SF4w==
X-Gm-Message-State: ANoB5pkpGej704JtK+j2hIpR5LkWZUd87UgTg+bZgBMclyUuAN90grZ8
        cXI0QzK8CzwOaS/2KPXsr+AX84foId5Nj2h717fPTA==
X-Google-Smtp-Source: AA0mqf756alfu+nTXdTTkBPWyoMGiQ9mwf5aNy25bxEi+CfvaZPb5QO4hJK021Dwz3VP0X0XqTeqGY8WeSl/7cX8eDM=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr53464933pjq.202.1669646758244; Mon, 28
 Nov 2022 06:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20221126012558.34374-1-jiasheng@iscas.ac.cn> <Y4HH5Ch1ABrRzN5/@kadam>
In-Reply-To: <Y4HH5Ch1ABrRzN5/@kadam>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Nov 2022 15:45:21 +0100
Message-ID: <CAPDyKFq+wYbRNtDmhMzU+5_LUXsqyw7O=-1BqhJN_j26HF++AQ@mail.gmail.com>
Subject: Re: [PATCH v2] memstick/ms_block: Add check for alloc_ordered_workqueue
To:     Dan Carpenter <error27@gmail.com>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, maximlevitsky@gmail.com,
        oakad@yahoo.com, christophe.jaillet@wanadoo.fr, axboe@kernel.dk,
        hare@suse.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 26 Nov 2022 at 09:01, Dan Carpenter <error27@gmail.com> wrote:
>
> On Sat, Nov 26, 2022 at 09:25:58AM +0800, Jiasheng Jiang wrote:
> > As the alloc_ordered_workqueue may return NULL pointer,
> > it should be better to add check for the return
> > value.
> > Moreover, the msb->io_queue should be freed if error occurs later.
> >
> > Fixes: 0ab30494bc4f ("memstick: add support for legacy memorysticks")
> > Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> > ---
> > Changelog:
> >
> > v1 -> v2:
> >
> > 1. Assign error number to rc if alloc_ordered_workqueue fails.
> > 2. Free msb->io_queue if error occurs later.
> > ---
>
> My other question about this driver, not really directed to you but to
> anyone on the list is where the final destroy_workqueue(msb->io_queue)
> is when we unload the driver.

Good point, it's simply missing somewhere in the path of the
->remove() callback.

Kind regards
Uffe
