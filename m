Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223E4C6FD18
	for <linux-mmc@archiver.kernel.org>; Fri, 31 Mar 2023 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjCaMoX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 31 Mar 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCaMoV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 31 Mar 2023 08:44:21 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8B1F79B
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 05:43:54 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i6so27243530ybu.8
        for <linux-mmc@vger.kernel.org>; Fri, 31 Mar 2023 05:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680266626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d8wUcVZufaGcIMkEEh5Kyyy9hNa4NEI3tlGV4NFbfOA=;
        b=dOYhn1Pv4R1vbnTkOa99isSC9HUFcbFyWXhXVBsjf5bUyLWeOxyByjakyAilvTZTC1
         5JSKVUNDPGvDSRB03FKdq4BZK/hztXF7/qdghNdiQ6noa3NYPLm+PbAt6P5cNtYGcbof
         PCT2vUMAUBKwSZf7bxmL1he8vAGPYTHj8LZWlia4SfQkKiFDrbNR9lOPGDdQRpYAlp9e
         Eo6Bd4Pc1uCZzgcg4lPPOYwZ0KD0HExGiHadyGawrhpCgq5zbM8iRHI4uainN3m6MDSH
         +fLw7P1golGEwTXGc2TmFZFyJ5vjVRTrYDJgXEgQnctl5Hc1z57/tXXvCIv9gk9P6C3c
         8/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680266626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d8wUcVZufaGcIMkEEh5Kyyy9hNa4NEI3tlGV4NFbfOA=;
        b=e94sNCmNwbLVk5/zG6dOoa0QtCoCbYowHDEKQuQ4pzIifwSGGonZofE2gtSskTelkB
         MUl55tLvlFNOBbrIg1yvPLPkXJ6d8cyYzTU8f6or+4KqRXERn3p/ZKRZdImON0SxY7OV
         6U4KMC8UH0j3n/Z/ASMOwWZtweY3zY6Hvstrjnb4rpcSo9VehynSSXaciYfHQhI1YWBE
         uKfGZLoP/+a72nOmz1zGlK0KG3ah3QCKG9MdUVxBS6ZbwQPql03afBO6qlkb+4pDdfe1
         8piTAw6joU76yjEoYaULGZytCoOzhViUUp8lEMRNO6DgymVXbQuyG/cM4hxPTNmSPCcx
         nsgg==
X-Gm-Message-State: AAQBX9ePrx73gTHn6Da9O+/CZjoDMzoa02QCDVqvYtlpVhpm1q3eNa5C
        pCUu44eJQn8JYDo+SYSpBALK4lU9pxfM6I7oee/LV72iYcPoOuJv
X-Google-Smtp-Source: AKy350bFUOgDXgmIhpH3HEs+a3adie/r2r+Fz9iEPH6HVz++8tVbnwb4WPPXtaN83foxwOjKDtGmQsn3jTViuZa3pFs=
X-Received: by 2002:a25:1185:0:b0:a27:3ecc:ffe7 with SMTP id
 127-20020a251185000000b00a273eccffe7mr4970550ybr.3.1680266626404; Fri, 31 Mar
 2023 05:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
In-Reply-To: <ZCTOMVjW+pnZVGsQ@snowbird>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 31 Mar 2023 14:43:10 +0200
Message-ID: <CAPDyKFrcdJuyA9B-JDReacT2z1ircDoY4oTXZQ8AVFk6UEFYsw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 30 Mar 2023 at 01:48, Dennis Zhou <dennis@kernel.org> wrote:
>
> When using dm-verity with a data partition on an emmc device, dm-verity
> races with the discovery of attached emmc devices. This is because mmc's
> probing code sets up the host data structure then a work item is
> scheduled to do discovery afterwards. To prevent this race on init,
> let's inline the first call to detection, __mm_scan(), and let
> subsequent detect calls be handled via the workqueue.

In principle, I don't mind the changes in $subject patch, as long as
it doesn't hurt the overall initialization/boot time. Especially, we
may have more than one mmc-slot being used, so this needs to be well
tested.

Although, more importantly, I fail to understand how this is going to
solve the race condition. Any I/O request to an eMMC or SD requires
the mmc block device driver to be up and running too, which is getting
probed from a separate module/driver that's not part of mmc_rescan().

Kind regards
Uffe

>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> ---
> Sigh.. fix missing static declaration.
>
>  drivers/mmc/core/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 368f10405e13..fda7ee57dee3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
>  }
>  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
>
> -void mmc_rescan(struct work_struct *work)
> +static void __mmc_rescan(struct mmc_host *host)
>  {
> -       struct mmc_host *host =
> -               container_of(work, struct mmc_host, detect.work);
>         int i;
>
>         if (host->rescan_disable)
> @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
>                 mmc_schedule_delayed_work(&host->detect, HZ);
>  }
>
> +void mmc_rescan(struct work_struct *work)
> +{
> +       struct mmc_host *host =
> +               container_of(work, struct mmc_host, detect.work);
> +
> +       __mmc_rescan(host);
> +}
> +
>  void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
>         }
>
>         mmc_gpiod_request_cd_irq(host);
> -       _mmc_detect_change(host, 0, false);
> +       host->detect_change = 1;
> +       __mmc_rescan(host);
>  }
>
>  void __mmc_stop_host(struct mmc_host *host)
> --
> 2.40.0
>
