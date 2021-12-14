Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D8C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Dec 2021 13:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbhLNNho (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhLNNho (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Dec 2021 08:37:44 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D5C061574
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 05:37:43 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id p8so28357401ljo.5
        for <linux-mmc@vger.kernel.org>; Tue, 14 Dec 2021 05:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BTfX7MmVofZVFmyyrVss1X8OArcOhFUrIbn1uw/uUKM=;
        b=KPXnP6ConaH6T/UUMMeGzPxVOqTp0KmPXPnXYBS2DwlynaIsylEobJkzlHHiUT91Cm
         YXjciwSfFAucPxGRp4Ahe3H9N5gxqZ5MtS8E2IGY5382jXJwm7X5ERMK62Gsd1bBhttL
         0ibGhM+3E13G23QumytAX333Mlp0kYnN3VGuB1dRsKmpfo+v6PM8hEoabpYLdCeCfDS+
         hnyegtgI2YeRykNmlc7JQ4J2zOW/DkUxhyPE3SI9ArD1+NSJXCAvxTcZDKBATGKLCx/7
         hSPm8LvX7bbq8kxmx3akOJsU51p+PqtjWYNndTFdDyPBMcf6DUOw25tOw7DCCaG9wx/+
         9H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BTfX7MmVofZVFmyyrVss1X8OArcOhFUrIbn1uw/uUKM=;
        b=YRi3BbqIuauWMWa/eMWp46BXZFsFDDEiIEnQP4WDI4F6WO2vxN8IncHyswQ0Gq7AyP
         GJ1CHEbS9zErcleFUZWHBTuYSTvGzwYai3Vf7+NJcruzIFjtQI5D0AepB9HANpj/C5CY
         5Mhbg/fWwIMb6b/zBoZ+0iV/T+T1tapsHp5Zm8fEz3qqHAbSmyBqJzDnpGg0HcdwoALF
         o8jMt2tuRACpoRZp63103356ntP7wRW20Nqb5Xqs3bjyA/Z9s54/a49447SSEfIkB9JB
         S7Z+s6hOqgdTbPXri0n0XCldj7n49U0N249EZRiGEtZg2X/Gm8/e4XYswEbBDS6//EfG
         IlGA==
X-Gm-Message-State: AOAM530VrZyjaenmaoTJNTRB8vyiNfVhSastaEcY4qlHUg4S63T5P9JD
        EzRkKwweCoXjjf8ngOtkD+yLZKWH+xi69Odpja4vQQ==
X-Google-Smtp-Source: ABdhPJyL4CB1acgQNsr3tTInW0O6q2jRGUJ77E5cinzKJX5xM+6nUROmIyPX716mvfK1j4tl1994uUPQtDxKrAnTUOk=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr4869547ljn.463.1639489061698;
 Tue, 14 Dec 2021 05:37:41 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com> <20211203105103.11306-6-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20211203105103.11306-6-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Dec 2021 14:37:05 +0100
Message-ID: <CAPDyKFp2mv5Z+0e8ckKnhyE-XvGYcuda-z=vJoz0crnTVa9ZVw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: add UHS-II related definitions in headers
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     takahiro.akashi@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw, Jason.Lai@genesyslogic.com.tw,
        otis.wu@genesyslogic.com.tw, benchuanggli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Dec 2021 at 11:51, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> All LINK layer messages, registers and SD-TRAN command packet described in
> 'Part 1 UHS-II Addendum Ver 1.01' are defined in include/linux/mmc/sd_uhs2.h
>
> drivers/mmc/core/sd_uhs2.h contains exported function prototype.
>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/sd_uhs2.h  |  18 ++++
>  include/linux/mmc/card.h    |  30 +++++-
>  include/linux/mmc/core.h    |   4 +-
>  include/linux/mmc/host.h    |  27 ++++-
>  include/linux/mmc/sd_uhs2.h | 196 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 268 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/mmc/core/sd_uhs2.h
>  create mode 100644 include/linux/mmc/sd_uhs2.h
>
> diff --git a/drivers/mmc/core/sd_uhs2.h b/drivers/mmc/core/sd_uhs2.h
> new file mode 100644
> index 000000000..5bb5dc1d1
> --- /dev/null
> +++ b/drivers/mmc/core/sd_uhs2.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Header file for UHS-II packets, Host Controller registers and I/O
> + * accessors.
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef MMC_UHS2_H
> +#define MMC_UHS2_H
> +
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/host.h>

This is wrong, as these includes should instead be added into those
c-files that need them. Please drop this.

I noticed that you use struct mmc_host *host and struct mmc_request
*mrq, below. That can be done by forward declaring them, like this:
struct mmc_host;
struct mmc_request;

> +
> +#define UHS2_PHY_INIT_ERR      1

Please use common error codes, so drop this.

> +
> +int sd_uhs2_prepare_cmd(struct mmc_host *host, struct mmc_request *mrq);
> +
> +#endif /* MMC_UHS2_H */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 82b07eac1..4b2fda2e6 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -211,8 +211,36 @@ struct sd_ext_reg {
>  };
>
>  struct sd_uhs2_config {
> -       u32                     node_id;
> +       u32     node_id;

Please make the above change part of the patch that introduced "node_id".

>         /* TODO: Extend with more register configs. */

Looks like $subject patch is adding the register configs, so I assume
it would make sense to drop the TODO comment above, right?

> +       u32     dap;
> +       u32     gap;
> +       u32     n_fcu;
> +       u32     maxblk_len;
> +       u8      n_lanes;
> +       u8      dadr_len;
> +       u8      app_type;
> +       u8      phy_minor_rev;
> +       u8      phy_major_rev;
> +       u8      can_hibernate;
> +       u8      n_lss_sync;
> +       u8      n_lss_dir;
> +       u8      link_minor_rev;
> +       u8      link_major_rev;
> +       u8      dev_type;
> +       u8      n_data_gap;
> +
> +       u32     n_fcu_set;
> +       u32     maxblk_len_set;
> +       u8      n_lanes_set;
> +       u8      speed_range_set;
> +       u8      n_lss_sync_set;
> +       u8      n_lss_dir_set;
> +       u8      n_data_gap_set;
> +       u8      pwrctrl_mode_set;
> +       u8      max_retry_set;
> +
> +       u8      cfg_complete;
>  };
>
>  struct sdio_cccr {
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index ab19245e9..8ac4b0b52 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -1,7 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - *  linux/include/linux/mmc/core.h
> - */

It's okay to remove these lines. However, it should be a separate
patch - and please keep it outside of the UHS-II series, as it doesn't
belong here.

> +
>  #ifndef LINUX_MMC_CORE_H
>  #define LINUX_MMC_CORE_H
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 69f8c8a8f..ad6cccf67 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -96,7 +96,29 @@ struct mmc_clk_phase_map {
>  };
>
>  struct sd_uhs2_caps {
> -       /* TODO: Add UHS-II capabilities for the host. */
> +       u32     dap;
> +       u32     gap;
> +       u32     maxblk_len;
> +       u32     n_fcu;
> +       u8      n_lanes;
> +       u8      addr64;
> +       u8      card_type;
> +       u8      phy_rev;
> +       u8      speed_range;
> +       u8      can_hibernate;
> +       u8      n_lss_sync;
> +       u8      n_lss_dir;
> +       u8      link_rev;
> +       u8      host_type;
> +       u8      n_data_gap;
> +
> +       u32     maxblk_len_set;
> +       u32     n_fcu_set;
> +       u8      n_lanes_set;
> +       u8      n_lss_sync_set;
> +       u8      n_lss_dir_set;
> +       u8      n_data_gap_set;
> +       u8      max_retry_set;
>  };
>
>  struct mmc_host;
> @@ -145,7 +167,6 @@ struct mmc_host_ops {
>          */
>         int     (*uhs2_set_ios)(struct mmc_host *host, struct mmc_ios *ios);
>
> -

White space, please drop this change.

If this makes the code better, please change this in the patch that
introduced the code earlier in the series.

>         /*
>          * Return values for the get_ro callback should be:
>          *   0 for a read/write card
> @@ -421,7 +442,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>
> -       struct sd_uhs2_caps     uhs2_caps;      /* SD UHS-II capabilities */
> +       struct sd_uhs2_caps     uhs2_caps;      /* SD UHS-II host capabilities */

If you prefer "host capabilities" over plain "capabilities", that's fine by me.

However, please make this change as part of the patch that introduced
the code, earlier in the series.

>
>         int                     fixed_drv_type; /* fixed driver type for non-removable media */
>
> diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
> new file mode 100644
> index 000000000..5d12fb9d0
> --- /dev/null
> +++ b/include/linux/mmc/sd_uhs2.h
> @@ -0,0 +1,196 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Header file for UHS-II packets, Host Controller registers and I/O
> + * accessors.
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef LINUX_MMC_UHS2_H
> +#define LINUX_MMC_UHS2_H
> +
> +struct mmc_request;

Doesn't look like this is needed, please drop it.

> +
> +/* LINK Layer definition */
> +/* UHS2 Header */
> +#define UHS2_NATIVE_PACKET_POS 7
> +#define UHS2_NATIVE_PACKET     (1 << UHS2_NATIVE_PACKET_POS)
> +
> +#define UHS2_PACKET_TYPE_POS   4
> +#define UHS2_PACKET_TYPE_CCMD  (0 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_DCMD  (1 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_RES   (2 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_DATA  (3 << UHS2_PACKET_TYPE_POS)
> +#define UHS2_PACKET_TYPE_MSG   (7 << UHS2_PACKET_TYPE_POS)
> +
> +#define UHS2_DEST_ID_MASK      0x0F
> +#define UHS2_DEST_ID           0x1
> +
> +#define UHS2_SRC_ID_POS                12
> +#define UHS2_SRC_ID_MASK       0xF000
> +
> +#define UHS2_TRANS_ID_POS      8
> +#define UHS2_TRANS_ID_MASK     0x0700
> +
> +/* UHS2 MSG */
> +#define UHS2_MSG_CTG_POS       5
> +#define UHS2_MSG_CTG_LMSG      0x00
> +#define UHS2_MSG_CTG_INT       0x60
> +#define UHS2_MSG_CTG_AMSG      0x80
> +
> +#define UHS2_MSG_CTG_FCREQ     0x00
> +#define UHS2_MSG_CTG_FCRDY     0x01
> +#define UHS2_MSG_CTG_STAT      0x02
> +
> +#define UHS2_MSG_CODE_POS                      8
> +#define UHS2_MSG_CODE_FC_UNRECOVER_ERR         0x8
> +#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR       0x8
> +#define UHS2_MSG_CODE_STAT_RECOVER_ERR         0x1
> +
> +/* TRANS Layer definition */
> +
> +/* Native packets*/
> +#define UHS2_NATIVE_CMD_RW_POS 7
> +#define UHS2_NATIVE_CMD_WRITE  (1 << UHS2_NATIVE_CMD_RW_POS)
> +#define UHS2_NATIVE_CMD_READ   (0 << UHS2_NATIVE_CMD_RW_POS)
> +
> +#define UHS2_NATIVE_CMD_PLEN_POS       4
> +#define UHS2_NATIVE_CMD_PLEN_4B                (1 << UHS2_NATIVE_CMD_PLEN_POS)
> +#define UHS2_NATIVE_CMD_PLEN_8B                (2 << UHS2_NATIVE_CMD_PLEN_POS)
> +#define UHS2_NATIVE_CMD_PLEN_16B       (3 << UHS2_NATIVE_CMD_PLEN_POS)
> +
> +#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK       0xF00
> +#define UHS2_NATIVE_CCMD_MIOADR_MASK           0x0F
> +
> +#define UHS2_NATIVE_CCMD_LIOADR_POS            8
> +#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK       0x0FF
> +
> +#define UHS2_DCMD_DM_POS       6
> +#define UHS2_DCMD_2L_HD_MODE   (1 << UHS2_DCMD_DM_POS)
> +#define UHS2_DCMD_LM_POS       5
> +#define UHS2_DCMD_LM_TLEN_EXIST        (1 << UHS2_DCMD_LM_POS)
> +#define UHS2_DCMD_TLUM_POS     4
> +#define UHS2_DCMD_TLUM_BYTE_MODE       (1 << UHS2_DCMD_TLUM_POS)
> +#define UHS2_NATIVE_DCMD_DAM_POS       3
> +#define UHS2_NATIVE_DCMD_DAM_IO                (1 << UHS2_NATIVE_DCMD_DAM_POS)
> +
> +#define UHS2_RES_NACK_POS      7
> +#define UHS2_RES_NACK_MASK     (0x1 << UHS2_RES_NACK_POS)
> +
> +#define UHS2_RES_ECODE_POS     4
> +#define UHS2_RES_ECODE_MASK    0x7
> +#define UHS2_RES_ECODE_COND    1
> +#define UHS2_RES_ECODE_ARG     2
> +#define UHS2_RES_ECODE_GEN     3
> +
> +/* IOADR of device registers */
> +#define UHS2_IOADR_GENERIC_CAPS                0x00
> +#define UHS2_IOADR_PHY_CAPS            0x02
> +#define UHS2_IOADR_LINK_CAPS           0x04
> +#define UHS2_IOADR_RSV_CAPS            0x06
> +#define UHS2_IOADR_GENERIC_SETTINGS    0x08
> +#define UHS2_IOADR_PHY_SETTINGS                0x0A
> +#define UHS2_IOADR_LINK_SETTINGS       0x0C
> +#define UHS2_IOADR_PRESET              0x40
> +
> +/* SD application packets */
> +#define UHS2_SD_CMD_INDEX_POS          8
> +
> +#define UHS2_SD_CMD_APP_POS            14
> +#define UHS2_SD_CMD_APP                        (1 << UHS2_SD_CMD_APP_POS)
> +
> +struct uhs2_command {
> +       u16     header;
> +       u16     arg;
> +       u32     *payload;
> +       u32     payload_len;
> +       u32     packet_len;
> +};
> +
> +enum uhs2_act {

Perhaps uhs2_action is more clear?

> +       SET_CONFIG,
> +       ENABLE_INT,
> +       DISABLE_INT,
> +       SET_SPEED_B,
> +       CHECK_DORMANT,
> +       UHS2_SW_RESET,
> +};
> +
> +/* UHS-II Device Registers */
> +#define UHS2_DEV_CONFIG_REG    0x000
> +
> +/* General Caps and Settings registers */
> +#define  UHS2_DEV_CONFIG_GEN_CAPS      (UHS2_DEV_CONFIG_REG + 0x000)
> +#define   UHS2_DEV_CONFIG_N_LANES_POS  8
> +#define   UHS2_DEV_CONFIG_N_LANES_MASK 0x3F
> +#define   UHS2_DEV_CONFIG_2L_HD_FD     0x1
> +#define   UHS2_DEV_CONFIG_2D1U_FD      0x2
> +#define   UHS2_DEV_CONFIG_1D2U_FD      0x4
> +#define   UHS2_DEV_CONFIG_2D2U_FD      0x8
> +#define   UHS2_DEV_CONFIG_DADR_POS     14
> +#define   UHS2_DEV_CONFIG_DADR_MASK    0x1
> +#define   UHS2_DEV_CONFIG_APP_POS      16
> +#define   UHS2_DEV_CONFIG_APP_MASK     0xFF
> +#define   UHS2_DEV_CONFIG_APP_SD_MEM   0x1
> +
> +#define  UHS2_DEV_CONFIG_GEN_SET       (UHS2_DEV_CONFIG_REG + 0x008)
> +#define   UHS2_DEV_CONFIG_GEN_SET_N_LANES_POS  8
> +#define   UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD     0x0
> +#define   UHS2_DEV_CONFIG_GEN_SET_2D1U_FD      0x2
> +#define   UHS2_DEV_CONFIG_GEN_SET_1D2U_FD      0x3
> +#define   UHS2_DEV_CONFIG_GEN_SET_2D2U_FD      0x4
> +#define   UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE (0x1 << 31)
> +
> +/* PHY Caps and Settings registers */
> +#define  UHS2_DEV_CONFIG_PHY_CAPS      (UHS2_DEV_CONFIG_REG + 0x002)
> +#define   UHS2_DEV_CONFIG_PHY_MINOR_MASK       0xF
> +#define   UHS2_DEV_CONFIG_PHY_MAJOR_POS                4
> +#define   UHS2_DEV_CONFIG_PHY_MAJOR_MASK       0x3
> +#define   UHS2_DEV_CONFIG_CAN_HIBER_POS                15
> +#define   UHS2_DEV_CONFIG_CAN_HIBER_MASK       0x1
> +#define  UHS2_DEV_CONFIG_PHY_CAPS1     (UHS2_DEV_CONFIG_REG + 0x003)
> +#define   UHS2_DEV_CONFIG_N_LSS_SYN_MASK       0xF
> +#define   UHS2_DEV_CONFIG_N_LSS_DIR_POS                4
> +#define   UHS2_DEV_CONFIG_N_LSS_DIR_MASK       0xF
> +
> +#define  UHS2_DEV_CONFIG_PHY_SET       (UHS2_DEV_CONFIG_REG + 0x00A)
> +#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_POS    6
> +#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_A      0x0
> +#define   UHS2_DEV_CONFIG_PHY_SET_SPEED_B      0x1
> +
> +/* LINK-TRAN Caps and Settings registers */
> +#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS        (UHS2_DEV_CONFIG_REG + 0x004)
> +#define   UHS2_DEV_CONFIG_LT_MINOR_MASK                0xF
> +#define   UHS2_DEV_CONFIG_LT_MAJOR_POS         4
> +#define   UHS2_DEV_CONFIG_LT_MAJOR_MASK                0x3
> +#define   UHS2_DEV_CONFIG_N_FCU_POS            8
> +#define   UHS2_DEV_CONFIG_N_FCU_MASK           0xFF
> +#define   UHS2_DEV_CONFIG_DEV_TYPE_POS         16
> +#define   UHS2_DEV_CONFIG_DEV_TYPE_MASK                0x7
> +#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_POS      20
> +#define   UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK     0xFFF
> +#define  UHS2_DEV_CONFIG_LINK_TRAN_CAPS1       (UHS2_DEV_CONFIG_REG + 0x005)
> +#define   UHS2_DEV_CONFIG_N_DATA_GAP_MASK      0xFF
> +
> +#define  UHS2_DEV_CONFIG_LINK_TRAN_SET (UHS2_DEV_CONFIG_REG + 0x00C)
> +#define   UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN   0x200
> +#define   UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS 16
> +
> +/* Preset register */
> +#define  UHS2_DEV_CONFIG_PRESET                (UHS2_DEV_CONFIG_REG + 0x040)
> +
> +#define UHS2_DEV_INT_REG       0x100
> +
> +#define UHS2_DEV_STATUS_REG    0x180
> +
> +#define UHS2_DEV_CMD_REG       0x200
> +#define  UHS2_DEV_CMD_FULL_RESET       (UHS2_DEV_CMD_REG + 0x000)
> +#define  UHS2_DEV_CMD_GO_DORMANT_STATE (UHS2_DEV_CMD_REG + 0x001)
> +#define   UHS2_DEV_CMD_DORMANT_HIBER   (0x1 << 7)
> +#define  UHS2_DEV_CMD_DEVICE_INIT      (UHS2_DEV_CMD_REG + 0x002)
> +#define  UHS2_DEV_CMD_ENUMERATE                (UHS2_DEV_CMD_REG + 0x003)
> +#define  UHS2_DEV_CMD_TRANS_ABORT      (UHS2_DEV_CMD_REG + 0x004)
> +
> +#define UHS2_RCLK_MAX  52000000
> +#define UHS2_RCLK_MIN  26000000
> +
> +#endif /* LINUX_MMC_UHS2_H */

Kind regards
Uffe
