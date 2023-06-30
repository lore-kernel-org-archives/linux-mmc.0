Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CACEB64DA
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Jun 2023 11:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjF3Ljt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Jun 2023 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjF3Ljr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jun 2023 07:39:47 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6981FE4
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jun 2023 04:39:46 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-c11e2b31b95so1627924276.3
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jun 2023 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688125186; x=1690717186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1FKTf+DGyDOz3jz745diWglkj41tR1A7OYRUqmfwWVU=;
        b=IHgMwUpDO+z5gKayJevAsmx1wAuhBNQ0APfLWDl9aERZDo+tPinvtptdcBaTvhoC/o
         psH8r4AXrig1oAxZBsrcaQcaT0UB6UfhkLtjJr2okK1+Oeh/JoYzLzEMAwqHUNVmocUV
         tL6RXjZPuC1kaQMKicZizjGU2kUTjC96sPWKSOD/gKibiuFMWDIffSdEUAaUkEHFJWll
         c8dWxzfcBtfL64ns4gn/rgen0Uw2xb0lyWYl4Hvg8ItW4QmhqFNyaHu/j+aJmievkHPD
         wSgSjNz/knO+O1ewUzfLG9AlBTIaIg+DXftiSEBcR9EJxWmLc/tFdpX/Zak90ICKupjy
         IYaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688125186; x=1690717186;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1FKTf+DGyDOz3jz745diWglkj41tR1A7OYRUqmfwWVU=;
        b=OnbxmWJMXCdUtiVVWuAdZijncZxY81BVaWbEYx2p+6CXCqZA1J2SKpLgFcA/AvG2c7
         Ha0UM5t16RGzSsj2L0qOTUtXct90nK6DjVQ3SBcWgpX78xT1reoq6vcnskKvSarrTMNe
         JTPyyuNyItmD2YlXdipl2XUCLiWkAM2RHQwSzH7e5Tg3+2jtNVXzBoZRira7YBmIcrfV
         WD6NimdIh00awf8b3b6BUQlkUv9RLfOh8yLKf6zTfWgDDn2qSzPqcYQhtHqXTCc5FuCs
         J7byrLacKCiywX5zY3FjJ5Mitszt2Smc4Eu7xWQeOjxC4oJKm6HDMMKyVYk9z6KKlg95
         u2Ig==
X-Gm-Message-State: ABy/qLapsDvHQWU1mkRweejBCizCLjI2imlruWwwceZ8csWJ7+vy+x1x
        J7QOAkuTgUryfXahKKmD7sw6VlZk1pEhZ8OzyowZRw==
X-Google-Smtp-Source: APBJJlFv6OWAbfmvCwTMpKnZcsHojIDzRR3gY5SY0YdYRaR4I3+/xAM9DQ4uWtCvWgJB6E9Lsyo8LxLkKQPCgvALJjY=
X-Received: by 2002:a5b:c05:0:b0:b8e:cb88:1b69 with SMTP id
 f5-20020a5b0c05000000b00b8ecb881b69mr931293ybq.34.1688125185916; Fri, 30 Jun
 2023 04:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230630055723.7673-1-jyanchou@realtek.com>
In-Reply-To: <20230630055723.7673-1-jyanchou@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 30 Jun 2023 13:39:09 +0200
Message-ID: <CAPDyKFp96N=nUS_8aLQcJyd0DZ+yce42xpHtzyPMn0y7hStjbg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Add Synopsys DesignWare mmc cmdq host driver
To:     Jyan Chou <jyanchou@realtek.com>
Cc:     adrian.hunter@intel.com, jh80.chung@samsung.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 30 Jun 2023 at 07:57, Jyan Chou <jyanchou@realtek.com> wrote:
>
> The difference between dw_mmc.c and dw_mmc_cqe.c is that
> we implemrnted cmdq feature, and we found out the difference
> between distint version of synopsys' data book and user guide.
>
> We add the mmc driver for the Synopsys DesignWare mmc cmdq host
> controller that can improve performance. Also, we add our
> Realtek mmc driver that make good use of it.
>
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> ---
>  drivers/mmc/host/cqhci-core.c     |    5 +
>  drivers/mmc/host/cqhci.h          |    2 +
>  drivers/mmc/host/dw_mmc_cqe-rtk.c | 1343 +++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe-rtk.h |  164 +++
>  drivers/mmc/host/dw_mmc_cqe.c     | 1821 +++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc_cqe.h     |  441 +++++++
>  6 files changed, 3776 insertions(+)
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe-rtk.h
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.c
>  create mode 100644 drivers/mmc/host/dw_mmc_cqe.h
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index b3d7d6d8d654..f4ddad62632a 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -514,6 +514,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
>                 return sg_count;
>         }
>
> +       if (cq_host->ops->setup_tran_desc) {
> +               cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
> +               return 0;
> +       }
> +
>         desc = get_trans_desc(cq_host, tag);
>
>         for_each_sg(data->sg, sg, sg_count, i) {
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
> index ba9387ed90eb..a3e56da6189d 100644
> --- a/drivers/mmc/host/cqhci.h
> +++ b/drivers/mmc/host/cqhci.h
> @@ -286,6 +286,8 @@ struct cqhci_host_ops {
>                                  u64 *data);
>         void (*pre_enable)(struct mmc_host *mmc);
>         void (*post_disable)(struct mmc_host *mmc);
> +       void (*setup_tran_desc)(struct mmc_data *data,
> +               struct cqhci_host *cq_host, u8 *desc, int sg_count);
>  #ifdef CONFIG_MMC_CRYPTO
>         int (*program_key)(struct cqhci_host *cq_host,
>                            const union cqhci_crypto_cfg_entry *cfg, int slot);
> diff --git a/drivers/mmc/host/dw_mmc_cqe-rtk.c b/drivers/mmc/host/dw_mmc_cqe-rtk.c
> new file mode 100644
> index 000000000000..577cb1f1ed70
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc_cqe-rtk.c
> @@ -0,0 +1,1343 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Realtek Semiconductor Corp.
> + *
> + */
> +
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/of_address.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include "dw_mmc_cqe.h"
> +#include "dw_mmc_cqe-rtk.h"
> +
> +#define LOWER_BIT_MASK         0x00ffffff
> +#define HIGH_BIT_MASK          0xff000000
> +
> +static void dw_mci_rtk_hs400_complete(struct mmc_host *mmc);
> +static int dw_mci_rtk_execute_tuning(struct dw_mci_slot *slot, u32 opcode);
> +
> +int dw_mci_rtk_write_protect_cmd(struct mmc_host *mmc, u32 args, bool is_wrtie_protect)
> +{
> +       struct mmc_request mrq = {};
> +       struct mmc_command cmd = {};
> +       int err = 0;
> +
> +       if (is_wrtie_protect)
> +               cmd.opcode = MMC_SET_WRITE_PROT;
> +       else
> +               cmd.opcode = MMC_CLR_WRITE_PROT;
> +
> +       cmd.arg = args;
> +       cmd.flags = MMC_CMD_AC|MMC_RSP_SPI_R1B | MMC_RSP_R1B;
> +       mrq.cmd = &cmd;
> +       mrq.data = NULL;
> +
> +       mmc_wait_for_req(mmc, &mrq);

This is not how the mmc subsystem works. Commands and protocol
specific things are managed by the core layer.

Please don't abuse the interfaces/APIs from the core. Just looking at
a few lines below, I noticed that there are more cases like this in
$subject patch, therefore I am stopping the review already at this
point. I am simply afraid that I will waste my time on this, sorry.

Next time, if you honestly want me to review this, please do your
homework and take care of the above before posting a new version.

[...]

Kind regards
Uffe
