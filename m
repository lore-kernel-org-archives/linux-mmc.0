Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C07C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388041AbiDUN5q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387966AbiDUN5p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:57:45 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323721165
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:54:55 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p10so8822590lfa.12
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWBtjZ/u41ciVQ8eqRCZfXpmvt0679NfHMhFgpCEUzs=;
        b=DrQFE5Ue2oD2fxauVOiZjO38io8f/v9u+jZfZKC3DiT6Yio76/QDFFy1r54tpiCKLU
         Bae9C0+AEwzoqhKVPBCK+f1FurOag5SZMFfXfdcnyGTdIQgetZtHZvWsnhuArW/lQzj8
         iLe5SO5aZU7Mbbt7NvcFhtSITQq3ccbZRcuClitErSEXhvL9K0JsDbHWtil4IqmO2Jxz
         2TGrTY6+AQBZW000oXexntBGLo6jFLA0c5ElqwS5gen/ZnoVNmu1kP9WJfq4tDq1SnS3
         b2vZJrqq0U+ZUEhU4kWzTMd7AxkNDG4MME6dh3vdC6kt2hdaBMoqHlr2pUJ5inzKKfar
         ZSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWBtjZ/u41ciVQ8eqRCZfXpmvt0679NfHMhFgpCEUzs=;
        b=I4wSs6/qQUVhN7YZ5aqsoJBjfVbnclVxyx+Q91vcV+/BOiESuL6fE6w3berbsVb5DJ
         Clapv0/n6uvG8sOPUjBi6aXyBu85sFag2UtZiNLRtKHPbOLLTp81J6FwMpiqOCfCjZkM
         nH8VO+yESK1zCiPR7WPW52L75J2f1JOg7+iW1IOnxKLfH9L0UbfCqbwW2dCTxOexijwT
         7KDq6kkh2P6rnMs0YJLTUTeqxNqiIL8rj6r7MxHvjb83Cnf+M5iaaJsPppYX1UJ222jM
         7E8aPI0FMny1aelOHM0MzCmLOrbmGqrP+S77aIBIIHxQZAQ+9zqgzmgZHtxIEmJyonJa
         9zog==
X-Gm-Message-State: AOAM5338MJyoUHNMoh2QsVEKCffb/JW7fNELeBN10FuNXmlEfHTZouK9
        jV0yqcyBJ6FhIQNMnT6I0B+jf1PGyt3bbyBI74njqg==
X-Google-Smtp-Source: ABdhPJyPHSxcjMeoCqMPg/92niGB+5z9ocJsA4qd+sVPE7MSHNmj+16//1nBcKkS1oBD5MwwcxOtT5be7Js74qB5Lc0=
X-Received: by 2002:a19:505d:0:b0:46d:167e:b9df with SMTP id
 z29-20020a19505d000000b0046d167eb9dfmr18737298lfj.184.1650549293450; Thu, 21
 Apr 2022 06:54:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220411153753.50443-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220411153753.50443-1-aidanmacdonald.0x0@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:16 +0200
Message-ID: <CAPDyKFpuD1m68SRuCYj0q+KU2Ua1Jt+f3upbLavs8x4HS0-szA@mail.gmail.com>
Subject: Re: [PATCH] mmc: jz4740: Apply DMA engine limits to maximum segment size
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, linux-mips@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 11 Apr 2022 at 17:37, Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Do what is done in other DMA-enabled MMC host drivers (cf. host/mmci.c) and
> limit the maximum segment size based on the DMA engine's capabilities. This
> is needed to avoid warnings like the following with CONFIG_DMA_API_DEBUG=y.
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 21 at kernel/dma/debug.c:1162 debug_dma_map_sg+0x2f4/0x39c
> DMA-API: jz4780-dma 13420000.dma-controller: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> CPU: 0 PID: 21 Comm: kworker/0:1H Not tainted 5.18.0-rc1 #19
> Workqueue: kblockd blk_mq_run_work_fn
> Stack : 81575aec 00000004 80620000 80620000 80620000 805e7358 00000009 801537ac
>         814c832c 806276e3 806e34b4 80620000 81575aec 00000001 81575ab8 09291444
>         00000000 00000000 805e7358 81575958 ffffffea 8157596c 00000000 636f6c62
>         6220646b 80387a70 0000000f 6d5f6b6c 80620000 00000000 81575ba4 00000009
>         805e170c 80896640 00000001 00010000 00000000 00000000 00006098 806e0000
>         ...
> Call Trace:
> [<80107670>] show_stack+0x84/0x120
> [<80528cd8>] __warn+0xb8/0xec
> [<80528d78>] warn_slowpath_fmt+0x6c/0xb8
> [<8016f1d4>] debug_dma_map_sg+0x2f4/0x39c
> [<80169d4c>] __dma_map_sg_attrs+0xf0/0x118
> [<8016a27c>] dma_map_sg_attrs+0x14/0x28
> [<804f66b4>] jz4740_mmc_prepare_dma_data+0x74/0xa4
> [<804f6714>] jz4740_mmc_pre_request+0x30/0x54
> [<804f4ff4>] mmc_blk_mq_issue_rq+0x6e0/0x7bc
> [<804f5590>] mmc_mq_queue_rq+0x220/0x2d4
> [<8038b2c0>] blk_mq_dispatch_rq_list+0x480/0x664
> [<80391040>] blk_mq_do_dispatch_sched+0x2dc/0x370
> [<80391468>] __blk_mq_sched_dispatch_requests+0xec/0x164
> [<80391540>] blk_mq_sched_dispatch_requests+0x44/0x94
> [<80387900>] __blk_mq_run_hw_queue+0xb0/0xcc
> [<80134c14>] process_one_work+0x1b8/0x264
> [<80134ff8>] worker_thread+0x2ec/0x3b8
> [<8013b13c>] kthread+0x104/0x10c
> [<80101dcc>] ret_from_kernel_thread+0x14/0x1c
>
> ---[ end trace 0000000000000000 ]---
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/jz4740_mmc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index 7ab1b38a7be5..b1d563b2ed1b 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -247,6 +247,26 @@ static int jz4740_mmc_acquire_dma_channels(struct jz4740_mmc_host *host)
>                 return PTR_ERR(host->dma_rx);
>         }
>
> +       /*
> +        * Limit the maximum segment size in any SG entry according to
> +        * the parameters of the DMA engine device.
> +        */
> +       if (host->dma_tx) {
> +               struct device *dev = host->dma_tx->device->dev;
> +               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> +
> +               if (max_seg_size < host->mmc->max_seg_size)
> +                       host->mmc->max_seg_size = max_seg_size;
> +       }
> +
> +       if (host->dma_rx) {
> +               struct device *dev = host->dma_rx->device->dev;
> +               unsigned int max_seg_size = dma_get_max_seg_size(dev);
> +
> +               if (max_seg_size < host->mmc->max_seg_size)
> +                       host->mmc->max_seg_size = max_seg_size;
> +       }
> +
>         return 0;
>  }
>
> --
> 2.35.1
>
