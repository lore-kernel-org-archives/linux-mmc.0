Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C0DC56202
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0093920872
	for <linux-mmc@archiver.kernel.org>; Thu, 26 Nov 2020 08:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgKZIQF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:16:05 -0500
Received: from mga01.intel.com ([192.55.52.88]:5989 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgKZIQF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 26 Nov 2020 03:16:05 -0500
IronPort-SDR: djNqZ9Ez0uOnbvfJI7YuH4dwDk5A/wGN2nK47z6HLgVzQZZWbq2UkKbeJzEvUnRzpwafZOSkLA
 umvjTANpGxwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="190405878"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="190405878"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2020 00:16:04 -0800
IronPort-SDR: QcoPPkU9kdeB9WhO1218zZHpdX/xJia32sThR+ii+Boj/0JCslPyHRqf69eYDdvKuVUOJZZaya
 q4Xy3cW+PBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="362721203"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga004.fm.intel.com with ESMTP; 26 Nov 2020 00:15:52 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH v3.1 09/27] mmc: sdhci: add UHS-II related definitions
 in headers
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201106022726.19831-10-takahiro.akashi@linaro.org>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <aa8b2aab-51c0-9757-276b-f36dd5d33679@intel.com>
Date:   Thu, 26 Nov 2020 10:15:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201106022726.19831-10-takahiro.akashi@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 6/11/20 4:27 am, AKASHI Takahiro wrote:
> Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci-uhs2.h | 210 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h      |  73 +++++++++++-
>  2 files changed, 282 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> 
> diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
> new file mode 100644
> index 000000000000..3b157df9c89c
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-uhs2.h
> @@ -0,0 +1,210 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller
> + *  Interface driver
> + *
> + * Header file for Host Controller UHS2 related registers and I/O accessors.
> + *
> + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> + */
> +#ifndef __SDHCI_UHS2_H
> +#define __SDHCI_UHS2_H
> +
> +#include <linux/bits.h>
> +
> +/*
> + * UHS-II Controller registers
> + * 0x74 preset in sdhci.h
> + * 0x80
> + * 0x84-0xB4
> + * 0xB8-0xCF
> + * 0xE0-0xE7
> + */
> +/* UHS2 */
> +#define SDHCI_UHS2_BLOCK_SIZE	0x80
> +#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz) \
> +	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
> +
> +#define SDHCI_UHS2_BLOCK_COUNT	0x84
> +
> +#define SDHCI_UHS2_CMD_PACKET	0x88
> +#define  SDHCI_UHS2_CMD_PACK_MAX_LEN	20
> +
> +#define SDHCI_UHS2_TRANS_MODE	0x9C
> +#define  SDHCI_UHS2_TRNS_DMA		BIT(0)
> +#define  SDHCI_UHS2_TRNS_BLK_CNT_EN	BIT(1)
> +#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT	BIT(4)
> +#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE	BIT(5)
> +#define  SDHCI_UHS2_TRNS_RES_R5		BIT(6)
> +#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	BIT(7)
> +#define  SDHCI_UHS2_TRNS_RES_INT_DIS	BIT(8)
> +#define  SDHCI_UHS2_TRNS_WAIT_EBSY	BIT(14)
> +#define  SDHCI_UHS2_TRNS_2L_HD		BIT(15)
> +
> +#define SDHCI_UHS2_COMMAND	0x9E
> +#define  SDHCI_UHS2_COMMAND_SUB_CMD	0x0004
> +#define  SDHCI_UHS2_COMMAND_DATA	0x0020
> +#define  SDHCI_UHS2_COMMAND_TRNS_ABORT	0x0040
> +#define  SDHCI_UHS2_COMMAND_CMD12	0x0080
> +#define  SDHCI_UHS2_COMMAND_DORMANT	0x00C0
> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_MASK	GENMASK(12,8)
> +#define  SDHCI_UHS2_COMMAND_PACK_LEN_SHIFT	8
> +
> +#define SDHCI_UHS2_RESPONSE	0xA0
> +#define  SDHCI_UHS2_RESPONSE_MAX_LEN	20
> +
> +#define SDHCI_UHS2_MSG_SELECT	0xB4
> +#define SDHCI_UHS2_MSG_SELECT_CURR	0x0
> +#define SDHCI_UHS2_MSG_SELECT_ONE	0x1
> +#define SDHCI_UHS2_MSG_SELECT_TWO	0x2
> +#define SDHCI_UHS2_MSG_SELECT_THREE	0x3
> +
> +#define SDHCI_UHS2_MSG		0xB8
> +
> +#define SDHCI_UHS2_DEV_INT_STATUS	0xBC
> +
> +#define SDHCI_UHS2_DEV_SELECT	0xBE
> +#define SDHCI_UHS2_DEV_SELECT_DEV_SEL_MASK	GENMASK(3,0)
> +#define SDHCI_UHS2_DEV_SELECT_INT_MSG_EN	BIT(7)
> +
> +#define SDHCI_UHS2_DEV_INT_CODE	0xBF
> +
> +#define SDHCI_UHS2_SW_RESET	0xC0
> +#define SDHCI_UHS2_SW_RESET_FULL	0x0001
> +#define SDHCI_UHS2_SW_RESET_SD		0x0002
> +
> +#define SDHCI_UHS2_TIMER_CTRL	0xC2
> +#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_SHIFT	4
> +
> +#define SDHCI_UHS2_ERR_INT_STATUS		0xC4
> +#define SDHCI_UHS2_ERR_INT_STATUS_EN		0xC8
> +#define SDHCI_UHS2_ERR_INT_SIG_EN		0xCC
> +#define SDHCI_UHS2_ERR_INT_STATUS_HEADER	BIT(0)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RES		BIT(1)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP	BIT(2)
> +#define SDHCI_UHS2_ERR_INT_STATUS_CRC		BIT(3)
> +#define SDHCI_UHS2_ERR_INT_STATUS_FRAME		BIT(4)
> +#define SDHCI_UHS2_ERR_INT_STATUS_TID		BIT(5)
> +#define SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER	BIT(7)
> +#define SDHCI_UHS2_ERR_INT_STATUS_EBUSY		BIT(8)
> +#define SDHCI_UHS2_ERR_INT_STATUS_ADMA		BIT(15)
> +#define SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT	BIT(16)
> +#define SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT	BIT(17)
> +#define SDHCI_UHS2_ERR_INT_STATUS_VENDOR	BIT(27)
> +#define SDHCI_UHS2_ERR_INT_STATUS_MASK	\
> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
> +#define SDHCI_UHS2_ERR_INT_STATUS_CMD_MASK	\
> +		(SDHCI_UHS2_ERR_INT_STATUS_HEADER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_FRAME |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_TID |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_RES_TIMEOUT)
> +/* CRC Error occurs during a packet receiving */
> +#define SDHCI_UHS2_ERR_INT_STATUS_DATA_MASK	\
> +		(SDHCI_UHS2_ERR_INT_STATUS_RETRY_EXP |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_CRC |		\
> +		SDHCI_UHS2_ERR_INT_STATUS_UNRECOVER |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_EBUSY |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_ADMA |	\
> +		SDHCI_UHS2_ERR_INT_STATUS_DEADLOCK_TIMEOUT)
> +
> +#define SDHCI_UHS2_SET_PTR	0xE0
> +#define   SDHCI_UHS2_GEN_SET_POWER_LOW		0x0001
> +#define   SDHCI_UHS2_GEN_SET_N_LANES_POS	8
> +#define   SDHCI_UHS2_GEN_SET_2L_FD_HD		0x0
> +#define   SDHCI_UHS2_GEN_SET_2D1U_FD		0x2
> +#define   SDHCI_UHS2_GEN_SET_1D2U_FD		0x3
> +#define   SDHCI_UHS2_GEN_SET_2D2U_FD		0x4
> +
> +#define   SDHCI_UHS2_PHY_SET_SPEED_POS		6
> +#define   SDHCI_UHS2_PHY_SET_HIBER_EN		BIT(12)
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_MASK	GENMASK(19,16)
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_SYN_POS	16
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_MASK	GENMASK(23,20)
> +#define   SDHCI_UHS2_PHY_SET_N_LSS_DIR_POS	20
> +
> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_MASK	GENMASK(15,8)
> +#define   SDHCI_UHS2_TRAN_SET_N_FCU_POS		8
> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_MASK	GENMASK(17,16)
> +#define   SDHCI_UHS2_TRAN_SET_RETRY_CNT_POS	16
> +
> +#define   SDHCI_UHS2_TRAN_SET_1_N_DAT_GAP_MASK	GENMASK(7,0)
> +
> +#define SDHCI_UHS2_HOST_CAPS_PTR	0xE2
> +#define  SDHCI_UHS2_HOST_CAPS_GEN_OFFSET	0
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DAP_MASK	GENMASK(3,0)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP_MASK	GENMASK(7,4)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_GAP(gap)	((gap) * 360)
> +#define SDHCI_UHS2_HOST_CAPS_GEN_GAP_SHIFT 4
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_MASK	GENMASK(13,8)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_LANE_SHIFT	8
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2L_HD_FD	1
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D1U_FD	2
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_1D2U_FD	4
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_2D2U_FD	8
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_ADDR_64	BIT(14)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BOOT		BIT(15)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_MASK	GENMASK(17,16)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_SHIFT	16
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_RMV	0
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB	1
> +#define    SDHCI_UHS2_HOST_CAPS_GEN_DEV_TYPE_EMB_RMV	2
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_MASK		GENMASK(21,18)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_NUM_DEV_SHIFT	18
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_MASK	GENMASK(23,22)
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_SHIFT	22
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_P2P		0
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_RING	1
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB		2
> +#define   SDHCI_UHS2_HOST_CAPS_GEN_BUS_TOPO_HUB_RING	3
> +
> +#define  SDHCI_UHS2_HOST_CAPS_PHY_OFFSET	4
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_REV_MASK		GENMASK(5,0)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_MASK		GENMASK(7,6)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_SHIFT		6
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_A		0
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_RANGE_B		1
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_MASK	GENMASK(19,16)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_SYN_SHIFT	16
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_MASK	GENMASK(23,20)
> +#define   SDHCI_UHS2_HOST_CAPS_PHY_N_LSS_DIR_SHIFT	20
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_OFFSET	8
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_LINK_REV_MASK	GENMASK(5,0)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_MASK		GENMASK(15,8)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_N_FCU_SHIFT		8
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_MASK	GENMASK(18,16)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_HOST_TYPE_SHIFT	16
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_MASK	GENMASK(31,20)
> +#define   SDHCI_UHS2_HOST_CAPS_TRAN_BLK_LEN_SHIFT	20
> +
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_OFFSET	12
> +#define  SDHCI_UHS2_HOST_CAPS_TRAN_1_N_DATA_GAP_MASK	GENMASK(7,0)
> +
> +#define SDHCI_UHS2_TEST_PTR	0xE4
> +#define  SDHCI_UHS2_TEST_ERR_HEADER	BIT(0)
> +#define  SDHCI_UHS2_TEST_ERR_RES	BIT(1)
> +#define  SDHCI_UHS2_TEST_ERR_RETRY_EXP	BIT(2)
> +#define  SDHCI_UHS2_TEST_ERR_CRC	BIT(3)
> +#define  SDHCI_UHS2_TEST_ERR_FRAME	BIT(4)
> +#define  SDHCI_UHS2_TEST_ERR_TID	BIT(5)
> +#define  SDHCI_UHS2_TEST_ERR_UNRECOVER	BIT(7)
> +#define  SDHCI_UHS2_TEST_ERR_EBUSY	BIT(8)
> +#define  SDHCI_UHS2_TEST_ERR_ADMA	BIT(15)
> +#define  SDHCI_UHS2_TEST_ERR_RES_TIMEOUT	BIT(16)
> +#define  SDHCI_UHS2_TEST_ERR_DEADLOCK_TIMEOUT	BIT(17)
> +#define  SDHCI_UHS2_TEST_ERR_VENDOR	BIT(27)
> +
> +#define SDHCI_UHS2_EMBED_CTRL	0xE6
> +#define SDHCI_UHS2_VENDOR	0xE8
> +
> +#endif /* __SDHCI_UHS2_H */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..d9d7a76cedc1 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -43,8 +43,27 @@
>  #define  SDHCI_TRNS_READ	0x10
>  #define  SDHCI_TRNS_MULTI	0x20
>  
> +/*
> + * Defined in Host Version 4.10.
> + * 1 - R5 (SDIO)
> + * 0 - R1 (Memory)
> + */
> +#define  SDHCI_TRNS_RES_TYPE		0x40
> +#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
> +#define  SDHCI_TRNS_RES_INT_DIS		0x0100
> +
>  #define SDHCI_COMMAND		0x0E
>  #define  SDHCI_CMD_RESP_MASK	0x03
> +
> +/*
> + * Host Version 4.10 adds this bit to distinguish a main command or
> + * sub command.
> + * CMD53(SDIO) - main command
> + * CMD52(SDIO) - sub command which doesn't have data block or doesn't
> + * indicate busy.
> + */
> +#define  SDHCI_CMD_SUB_CMD	0x04
> +
>  #define  SDHCI_CMD_CRC		0x08
>  #define  SDHCI_CMD_INDEX	0x10
>  #define  SDHCI_CMD_DATA		0x20
> @@ -60,11 +79,19 @@
>  
>  #define SDHCI_RESPONSE		0x10
>  
> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_OFFSET	0x10
> +#define  SDHCI_RESPONSE_CM_TRAN_ABORT_SIZE	4
> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_OFFSET	0x18
> +#define  SDHCI_RESPONSE_SD_TRAN_ABORT_SIZE	8

I would prefer to have all the UHS2 definitions in sdhci-uhs2.  If they
belong to an existing register, just put a comment saying what register.


> +
>  #define SDHCI_BUFFER		0x20
>  
>  #define SDHCI_PRESENT_STATE	0x24
>  #define  SDHCI_CMD_INHIBIT	0x00000001
>  #define  SDHCI_DATA_INHIBIT	0x00000002
> +
> +#define  SDHCI_DATA_HIGH_LVL_MASK	0x000000F0
> +
>  #define  SDHCI_DOING_WRITE	0x00000100
>  #define  SDHCI_DOING_READ	0x00000200
>  #define  SDHCI_SPACE_AVAILABLE	0x00000400
> @@ -80,6 +107,13 @@
>  #define   SDHCI_DATA_0_LVL_MASK	0x00100000
>  #define  SDHCI_CMD_LVL		0x01000000
>  
> +#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
> +#define  SDHCI_CMD_NOT_ISSUE_ERR	0x08000000
> +#define  SDHCI_SUB_CMD_STATUS		0x10000000
> +#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
> +#define  SDHCI_UHS2_LANE_SYNC		0x40000000
> +#define  SDHCI_UHS2_IF_DETECT		0x80000000
> +
>  #define SDHCI_HOST_CONTROL	0x28
>  #define  SDHCI_CTRL_LED		0x01
>  #define  SDHCI_CTRL_4BITBUS	0x02
> @@ -100,6 +134,11 @@
>  #define  SDHCI_POWER_300	0x0C
>  #define  SDHCI_POWER_330	0x0E
>  
> +/* VDD2 - UHS2 */
> +#define  SDHCI_VDD2_POWER_ON		0x10
> +#define  SDHCI_VDD2_POWER_180		0xA0
> +#define  SDHCI_VDD2_POWER_120		0x80
> +
>  #define SDHCI_BLOCK_GAP_CONTROL	0x2A
>  
>  #define SDHCI_WAKE_UP_CONTROL	0x2B
> @@ -110,7 +149,7 @@
>  #define SDHCI_CLOCK_CONTROL	0x2C
>  #define  SDHCI_DIVIDER_SHIFT	8
>  #define  SDHCI_DIVIDER_HI_SHIFT	6
> -#define  SDHCI_DIV_MASK	0xFF
> +#define  SDHCI_DIV_MASK		0xFF
>  #define  SDHCI_DIV_MASK_LEN	8
>  #define  SDHCI_DIV_HI_MASK	0x300
>  #define  SDHCI_PROG_CLOCK_MODE	0x0020
> @@ -139,6 +178,10 @@
>  #define  SDHCI_INT_CARD_REMOVE	0x00000080
>  #define  SDHCI_INT_CARD_INT	0x00000100
>  #define  SDHCI_INT_RETUNE	0x00001000
> +
> +/* Host Version 4.10 */
> +#define  SDHCI_INT_FX_EVENT	0x00002000
> +
>  #define  SDHCI_INT_CQE		0x00004000
>  #define  SDHCI_INT_ERROR	0x00008000
>  #define  SDHCI_INT_TIMEOUT	0x00010000
> @@ -152,6 +195,9 @@
>  #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
>  #define  SDHCI_INT_ADMA_ERROR	0x02000000
>  
> +/* Host Version 4.0 */
> +#define  SDHCI_INT_RESPONSE_ERROR	0x08000000
> +
>  #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
>  #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
>  
> @@ -178,6 +224,9 @@
>  #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
>  #define  SDHCI_AUTO_CMD_INDEX	0x00000010
>  
> +/* Host Version 4.10 */
> +#define  SDHCI_ACMD_RESPONSE_ERROR	0x0020
> +
>  #define SDHCI_HOST_CONTROL2		0x3E
>  #define  SDHCI_CTRL_UHS_MASK		0x0007
>  #define   SDHCI_CTRL_UHS_SDR12		0x0000
> @@ -186,6 +235,7 @@
>  #define   SDHCI_CTRL_UHS_SDR104		0x0003
>  #define   SDHCI_CTRL_UHS_DDR50		0x0004
>  #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
> +#define   SDHCI_CTRL_UHS_2		0x0007 /* UHS-2 */
>  #define  SDHCI_CTRL_VDD_180		0x0008
>  #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
>  #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
> @@ -194,9 +244,12 @@
>  #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
>  #define  SDHCI_CTRL_EXEC_TUNING		0x0040
>  #define  SDHCI_CTRL_TUNED_CLK		0x0080
> +#define  SDHCI_CTRL_UHS2_INTERFACE_EN	0x0100 /* UHS-2 */
> +#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
>  #define  SDHCI_CMD23_ENABLE		0x0800
>  #define  SDHCI_CTRL_V4_MODE		0x1000
>  #define  SDHCI_CTRL_64BIT_ADDR		0x2000
> +#define  SDHCI_CTRL_ASYNC_INT_EN	0x4000
>  #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
>  
>  #define SDHCI_CAPABILITIES	0x40
> @@ -217,11 +270,13 @@
>  #define  SDHCI_CAN_VDD_180	0x04000000
>  #define  SDHCI_CAN_64BIT_V4	0x08000000
>  #define  SDHCI_CAN_64BIT	0x10000000
> +#define  SDHCI_CAN_ASYNC_INT	0x20000000
>  
>  #define SDHCI_CAPABILITIES_1	0x44
>  #define  SDHCI_SUPPORT_SDR50	0x00000001
>  #define  SDHCI_SUPPORT_SDR104	0x00000002
>  #define  SDHCI_SUPPORT_DDR50	0x00000004
> +#define  SDHCI_SUPPORT_UHS2	0x00000008 /* UHS-2 support */
>  #define  SDHCI_DRIVER_TYPE_A	0x00000010
>  #define  SDHCI_DRIVER_TYPE_C	0x00000020
>  #define  SDHCI_DRIVER_TYPE_D	0x00000040
> @@ -230,19 +285,28 @@
>  #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
>  #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
>  #define  SDHCI_CAN_DO_ADMA3	0x08000000
> +#define  SDHCI_SUPPORT_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
> +#define  SDHCI_RSVD_FOR_VDD2    0x20000000 /* Rsvd for future VDD2 */
>  #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
>  
>  #define SDHCI_MAX_CURRENT		0x48
> +#define SDHCI_MAX_CURRENT_1		0x4C
>  #define  SDHCI_MAX_CURRENT_LIMIT	GENMASK(7, 0)
>  #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
>  #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
>  #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
> +#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
>  #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
>  
>  /* 4C-4F reserved for more max current */
>  
>  #define SDHCI_SET_ACMD12_ERROR	0x50
> +/* Host Version 4.10 */
> +#define SDHCI_SET_ACMD_RESPONSE_ERROR	0x20
>  #define SDHCI_SET_INT_ERROR	0x52
> +/* Host Version 4.10 */
> +#define SDHCI_SET_INT_TUNING_ERROR	0x0400
> +#define SDHCI_SET_INT_RESPONSE_ERROR	0x0800
>  
>  #define SDHCI_ADMA_ERROR	0x54
>  
> @@ -259,10 +323,16 @@
>  #define SDHCI_PRESET_FOR_SDR104        0x6C
>  #define SDHCI_PRESET_FOR_DDR50 0x6E
>  #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
> +
> +/* TODO: 0x74 is used for UHS2 in 4.10. How about HS400? */
> +/* UHS2 */
> +#define SDHCI_PRESET_FOR_UHS2  0x74
>  #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
>  #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
>  #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
>  
> +#define SDHCI_ADMA3_ADDRESS	0x78
> +
>  #define SDHCI_SLOT_INT_STATUS	0xFC
>  
>  #define SDHCI_HOST_VERSION	0xFE
> @@ -652,6 +722,7 @@ struct sdhci_ops {
>  	void	(*request_done)(struct sdhci_host *host,
>  				struct mmc_request *mrq);
>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
> +	void	(*dump_uhs2_regs)(struct sdhci_host *host);
>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> 

