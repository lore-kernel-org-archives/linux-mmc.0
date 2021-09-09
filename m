Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8603EC433EF
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Sep 2021 14:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E716120E
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Sep 2021 14:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343846AbhIIOpo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbhIIOpj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2021 10:45:39 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7DC0613BA
        for <linux-mmc@vger.kernel.org>; Thu,  9 Sep 2021 07:29:08 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id c79so2681533oib.11
        for <linux-mmc@vger.kernel.org>; Thu, 09 Sep 2021 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Uewnba4bydmKa3lqhFnd5v1B5Pth3YS+e10RLbe5sI=;
        b=JCUVv/vBeiwic+npTsXLh9sti0X9A7NHtyaHaRQcHF7p26oHWW4C/7a9rVp38uCmm7
         ccdjj2Go5ankYGTKQeF6e1PRJZ2HwgGGZMPUmYIfxyfpSsBKI+/5vO1lEcCWlhMmCBJz
         CdLrAqg7UKbbRZkBzaqEJFkT3AQGiT1IpfsZq/xFPn0qeJdphJAZ9Qtv6WBUHu8BQQ3e
         xGK+U96rnyusIX3KEFn3vlLOay83jbRzKQlavzhSsPBLtN34PVdimmwIBcHXB9kQMJXr
         3VuVFpIpLxuiRh0Kc+pSHQwsfvrhabu+T2pm6Om4wHcjXeGfzAoMLHnqDVN1x97yrdmh
         dEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Uewnba4bydmKa3lqhFnd5v1B5Pth3YS+e10RLbe5sI=;
        b=M76b+AbwI420cAsAmppvuPoTEV8ArOktd5kx88nVHRsTplFHhW3m07BJxGpto6NLU5
         UQj1nL7RWymdks3ojVxynPTCAAlqNgaCtodJhhU4tr91i+SETfkAEIHKJklPX4SDlMp0
         xZZX70VcxNOTce8M5upZ/xVcp7QYt7E/4HP9zn1oG4Eyhhja+1hw/OZgFcTu1cTL3BBe
         MmaHridKq0/PLBVrx9PsjifSzHmGSCEgO7bU28jUyu9ce557mWyyKa56e2NGqyH0f+bq
         VHD9mJIOVyhI9SnU7goEqpAfcGt07pnKfbCcmSwI7bOkwqaA5p6fO1tTpWqpxP52gJwe
         bVpA==
X-Gm-Message-State: AOAM533vWfp4o30sI86INDmMAqdxRFbmXavjVWEb9VZEP+4nlVJ96uLT
        CsfQKzMRUl8nUYzEDrMqQPTNRam5LyDwrRspNiKzoQZPFaI=
X-Google-Smtp-Source: ABdhPJzvtGH9EkbUYCIm4oqqQau+jZGzViI+HymOmn/NK1RV6hIv/oaH8mC5xaVkaFB+s/g9blDEF+fdoftU+3/HAyE=
X-Received: by 2002:a54:4f03:: with SMTP id e3mr51495oiy.32.1631197747560;
 Thu, 09 Sep 2021 07:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210831110218.50723-1-jasonlai.genesyslogic@gmail.com>
In-Reply-To: <20210831110218.50723-1-jasonlai.genesyslogic@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Sep 2021 16:28:30 +0200
Message-ID: <CAPDyKFryg9RNpR3GDnG1ZGF+--445-WNdVo9z3n14KUCK01zoQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: add UHS-II related definitions in headers
To:     Jason Lai <jasonlai.genesyslogic@gmail.com>
Cc:     Takahiro Akashi <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 31 Aug 2021 at 13:02, Jason Lai <jasonlai.genesyslogic@gmail.com> wrote:
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> From: Jason Lai <jason.lai@genesyslogic.com.tw>
>
> All LINK layer messages, registers and SD-TRAN command packet described in
> 'Part 1 UHS-II Addendum Ver 1.01' are defined in
> include/linux/mmc/sd_uhs2.h
>
> drivers/mmc/core/sd_uhs2.h contains exported function prototype.
>
> Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
> ---
>  drivers/mmc/core/sd_uhs2.h  |  20 +++
>  include/linux/mmc/sd_uhs2.h | 269 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 289 insertions(+)
>  create mode 100755 drivers/mmc/core/sd_uhs2.h
>  create mode 100755 include/linux/mmc/sd_uhs2.h
>
> diff --git a/drivers/mmc/core/sd_uhs2.h b/drivers/mmc/core/sd_uhs2.h
> new file mode 100755
> index 000000000..743ec0157
> --- /dev/null
> +++ b/drivers/mmc/core/sd_uhs2.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  driver/mmc/core/sd_uhs2.h - UHS-II driver

Please don't specify the path to the file here, it doesn't add
anything. The same applies to all the other files you add in the
series.

> + *
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
> +
> +#define UHS2_PHY_INIT_ERR      1
> +
> +int mmc_attach_sd_uhs2(struct mmc_host *host)

To keep consistency with the other mmc_attach_* functions, please
leave this in core.h. As I suggested in patch2.

> +
> +#endif /* MMC_UHS2_H */
> diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
> new file mode 100755
> index 000000000..491718262
> --- /dev/null
> +++ b/include/linux/mmc/sd_uhs2.h
> @@ -0,0 +1,269 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  linux/drivers/mmc/host/sd_uhs2.h - UHS-II driver
> + *
> + * Header file for UHS-II packets, Host Controller registers and I/O
> + * accessors.
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef LINUX_MMC_UHS2_H
> +#define LINUX_MMC_UHS2_H
> +
> +struct mmc_request;
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
> +/*
> + * Per UHS2 spec, DCMD payload should be MSB first. There may be
> + * two types of data be assembled to MSB:
> + * 1. TLEN: Input block size for single read/write and number of blocks
> + * for multiple read/write to calculate TLEN as MSB first per spec.
> + * 2. SD command argument.
> + */
> +static inline u32 uhs2_dcmd_convert_msb(u32 input)
> +{
> +       u32 ret = 0;
> +
> +       ret = ((input & 0xFF) << 24) |
> +               (((input >> 8) & 0xFF) << 16) |
> +               (((input >> 16) & 0xFF) << 8) |
> +               ((input >> 24) & 0xFF);
> +       return ret;
> +}

Please stick to plain definitions and structures that are needed for
UHS-II. Drop functions from $subject patch - and if needed, add them
later, to simplify the review.

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
> +struct uhs2_host_caps {
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
> +};

In patch2 I added:

"struct sd_uhs2_caps     uhs2_caps;"

as a part of the struct mmc_host.

Please use and extend that instead.

> +
> +struct sd_uhs2_caps {
> +       u32     node_id;
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
> +};

This belongs as part of the struct mmc_card. Please have a look at
patch2 (where I have already prepared for this).

> +
> +enum uhs2_act {
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
> +#define   UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD     0x0
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
> --
> 2.32.0
>

Kind regards
Uffe
