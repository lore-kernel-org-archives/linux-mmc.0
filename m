Return-Path: <SRS0=DxaD=D4=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF7AC388F9
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E138522275
	for <linux-mmc@archiver.kernel.org>; Wed, 21 Oct 2020 14:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNcoqFBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442158AbgJUOAm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443164AbgJUN7o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Oct 2020 09:59:44 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE7AC0613CE
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 06:59:44 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id a8so517103vkm.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Oct 2020 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ETPXqGqhz4FoR2jqGnESRqk/O1YtdvjUy98y8vBYIyg=;
        b=PNcoqFBr2QmNR8VBB5HXw1x4r/oX+hSdR90BbtEGJugoBo/cOUKVpxhtOU8iQY8Mdd
         BOPTaUkMDINbi8JlxwlikOo/ibek0yTt8URk3tp8W63uCvRfDTtrm8cIgeIhWmdjTWJC
         bZ2ojIiCOjUdzR7nVqyqNedfS6VvkmcEscEancgNZHgBK9X9YcGfDGEMxtYi8ueUkU/7
         j8AnlIhhblkEN6Xb1JrZohJOGLTIOYf7PsFPv/Fp8qsT34EKV+3EYFZ4IphB4hpBZcRP
         biLLS6uW7C6MLU9VkVFydxZcECvE2j+NqMUCu+Jz/j702twBkEHTLnYamt22I86SD7Xs
         hvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ETPXqGqhz4FoR2jqGnESRqk/O1YtdvjUy98y8vBYIyg=;
        b=cCgwxy4Il9cRUyAHBD8tIPc/l8vgpTkeTy7A/8qec68A4SlOFvKmSRvz4ReRYDN63K
         lIyRyXzXDjTuBrqNyB9f9quk+Fp/Bfaqyu0KM2rsTXqfMNrddPj7UVVQQKzTTTiqgdxV
         /WvH+uike/T+Z+ySu3fgoJc3iOh+BVyn4xWj32gxHkyZ1bmcBT+Qq3VYeShk0HVHYetF
         OZWIqq8m48+XjblIB5k6F9ANklRMWEMjbIz1OScBFEK3HiFEQh/LfHa5tQVw4FDCqHOG
         es6mqNi3O1MpxYgFD6XoHKDjppNm+VcfZEE1uev/BqHLRTpFb/Zm9MC9Jc52WJLqzIvf
         HxEw==
X-Gm-Message-State: AOAM531EzLeVuYDwZzcXH7sVowMRAsBRA3lH5iY/rWR87VO0v8KaLh3m
        iJ2yWsvYCo+xb28GyX8UUGklHcxpnsrCzE+1X9FIDhkmuWJJ+A==
X-Google-Smtp-Source: ABdhPJx0Qf+FXMlE3INwyuBpRHcBSScY9+DCFf8tZ/3BUZpKtwuAfL/QyzclP3/k4MmVoaU917xLsOb1yFmlNRdjpP8=
X-Received: by 2002:a1f:9682:: with SMTP id y124mr1915391vkd.6.1603288783755;
 Wed, 21 Oct 2020 06:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <1600999052-13634-1-git-send-email-rui_feng@realsil.com.cn>
In-Reply-To: <1600999052-13634-1-git-send-email-rui_feng@realsil.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Oct 2020 15:59:07 +0200
Message-ID: <CAPDyKFpKG33OLzK+aRsGDgHiaz8XQn8__HWDU5-g=_z_cjNiiA@mail.gmail.com>
Subject: Re: [PATCH 2/3] misc: rtsx: Add SD Express mode support for RTS5261
To:     Rui Feng <rui_feng@realsil.com.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 25 Sep 2020 at 03:57, <rui_feng@realsil.com.cn> wrote:
>
> From: Rui Feng <rui_feng@realsil.com.cn>
>
> RTS5261 support legacy SD mode and SD Express mode.
> In SD7.x, SD association introduce SD Express as a new mode.
> This patch makes RTS5261 support SD Express mode.

Can you please add some more information about what changes are needed
to support SD Express? We have had some discussions about this at LKML
previously, perhaps you pick up some of that and fold it into this
commit message!?

>
> Signed-off-by: Rui Feng <rui_feng@realsil.com.cn>
> ---
>  drivers/misc/cardreader/rts5261.c  |  4 ++++
>  drivers/misc/cardreader/rts5261.h  | 23 -----------------------
>  drivers/misc/cardreader/rtsx_pcr.c |  5 +++++
>  include/linux/rtsx_pci.h           | 28 ++++++++++++++++++++++++++++
>  4 files changed, 37 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
> index 471961487ff8..536c90d4fd76 100644
> --- a/drivers/misc/cardreader/rts5261.c
> +++ b/drivers/misc/cardreader/rts5261.c
> @@ -738,8 +738,12 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
>  {
>         struct rtsx_cr_option *option = &pcr->option;
>         struct rtsx_hw_param *hw_param = &pcr->hw_param;
> +       u8 val;
>
>         pcr->extra_caps = EXTRA_CAPS_SD_SDR50 | EXTRA_CAPS_SD_SDR104;
> +       rtsx_pci_read_register(pcr, RTS5261_FW_STATUS, &val);
> +       if (!(val & RTS5261_EXPRESS_LINK_FAIL_MASK))
> +               pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
>         pcr->num_slots = 1;
>         pcr->ops = &rts5261_pcr_ops;
>
> diff --git a/drivers/misc/cardreader/rts5261.h b/drivers/misc/cardreader/rts5261.h
> index ebfdd236a553..8d80f0d5d5d6 100644
> --- a/drivers/misc/cardreader/rts5261.h
> +++ b/drivers/misc/cardreader/rts5261.h
> @@ -65,23 +65,6 @@
>  #define RTS5261_FW_EXPRESS_TEST_MASK   (0x01<<0)
>  #define RTS5261_FW_EA_MODE_MASK                (0x01<<5)
>
> -/* FW config register */
> -#define RTS5261_FW_CFG0                        0xFF54
> -#define RTS5261_FW_ENTER_EXPRESS       (0x01<<0)
> -
> -#define RTS5261_FW_CFG1                        0xFF55
> -#define RTS5261_SYS_CLK_SEL_MCU_CLK    (0x01<<7)
> -#define RTS5261_CRC_CLK_SEL_MCU_CLK    (0x01<<6)
> -#define RTS5261_FAKE_MCU_CLOCK_GATING  (0x01<<5)
> -/*MCU_bus_mode_sel: 0=real 8051 1=fake mcu*/
> -#define RTS5261_MCU_BUS_SEL_MASK       (0x01<<4)
> -/*MCU_clock_sel:VerA 00=aux16M 01=aux400K 1x=REFCLK100M*/
> -/*MCU_clock_sel:VerB 00=aux400K 01=aux16M 10=REFCLK100M*/
> -#define RTS5261_MCU_CLOCK_SEL_MASK     (0x03<<2)
> -#define RTS5261_MCU_CLOCK_SEL_16M      (0x01<<2)
> -#define RTS5261_MCU_CLOCK_GATING       (0x01<<1)
> -#define RTS5261_DRIVER_ENABLE_FW       (0x01<<0)
> -
>  /* FW status register */
>  #define RTS5261_FW_STATUS              0xFF56
>  #define RTS5261_EXPRESS_LINK_FAIL_MASK (0x01<<7)
> @@ -121,12 +104,6 @@
>  #define RTS5261_DV3318_19              (0x04<<4)
>  #define RTS5261_DV3318_33              (0x07<<4)
>
> -#define RTS5261_LDO1_CFG0              0xFF72
> -#define RTS5261_LDO1_OCP_THD_MASK      (0x07<<5)
> -#define RTS5261_LDO1_OCP_EN            (0x01<<4)
> -#define RTS5261_LDO1_OCP_LMT_THD_MASK  (0x03<<2)
> -#define RTS5261_LDO1_OCP_LMT_EN                (0x01<<1)
> -
>  /* CRD6603-433 190319 request changed */
>  #define RTS5261_LDO1_OCP_THD_740       (0x00<<5)
>  #define RTS5261_LDO1_OCP_THD_800       (0x01<<5)
> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index 37ccc67f4914..6e5c16b4b7d1 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -990,6 +990,11 @@ static irqreturn_t rtsx_pci_isr(int irq, void *dev_id)
>                 } else {
>                         pcr->card_removed |= SD_EXIST;
>                         pcr->card_inserted &= ~SD_EXIST;
> +                       if (PCI_PID(pcr) == PID_5261) {
> +                               rtsx_pci_write_register(pcr, RTS5261_FW_STATUS,
> +                                       RTS5261_EXPRESS_LINK_FAIL_MASK, 0);
> +                               pcr->extra_caps |= EXTRA_CAPS_SD_EXPRESS;
> +                       }
>                 }
>                 pcr->dma_error_count = 0;
>         }
> diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
> index 745f5e73f99a..cea8147e5992 100644
> --- a/include/linux/rtsx_pci.h
> +++ b/include/linux/rtsx_pci.h
> @@ -658,6 +658,24 @@
>  #define   PM_WAKE_EN                   0x01
>  #define PM_CTRL4                       0xFF47
>
> +#define RTS5261_FW_CFG0                        0xFF54
> +#define   RTS5261_FW_ENTER_EXPRESS     (0x01 << 0)
> +
> +#define RTS5261_FW_CFG1                        0xFF55
> +#define   RTS5261_SYS_CLK_SEL_MCU_CLK  (0x01 << 7)
> +#define   RTS5261_CRC_CLK_SEL_MCU_CLK  (0x01 << 6)
> +#define   RTS5261_FAKE_MCU_CLOCK_GATING        (0x01 << 5)
> +#define   RTS5261_MCU_BUS_SEL_MASK     (0x01 << 4)
> +#define   RTS5261_MCU_BUS_SEL_MASK     (0x01 << 4)
> +#define   RTS5261_MCU_CLOCK_SEL_MASK   (0x03 << 2)
> +#define   RTS5261_MCU_CLOCK_SEL_16M    (0x01 << 2)
> +#define   RTS5261_MCU_CLOCK_GATING     (0x01 << 1)
> +#define   RTS5261_DRIVER_ENABLE_FW     (0x01 << 0)
> +#define   RTS5261_MCU_CLOCK_SEL_MASK   (0x03 << 2)
> +#define   RTS5261_MCU_CLOCK_SEL_16M    (0x01 << 2)
> +#define   RTS5261_MCU_CLOCK_GATING     (0x01 << 1)
> +#define   RTS5261_DRIVER_ENABLE_FW     (0x01 << 0)

Looks like you screwed up a copy/paste. I am sure you don't want to
RTS5261_MCU_CLOCK_SEL_MASK twice, for example.

> +
>  #define REG_CFG_OOBS_OFF_TIMER 0xFEA6
>  #define REG_CFG_OOBS_ON_TIMER 0xFEA7
>  #define REG_CFG_VCM_ON_TIMER 0xFEA8
> @@ -701,6 +719,13 @@
>  #define   RTS5260_DVCC_TUNE_MASK       0x70
>  #define   RTS5260_DVCC_33              0x70
>
> +/*RTS5261*/
> +#define RTS5261_LDO1_CFG0              0xFF72
> +#define   RTS5261_LDO1_OCP_THD_MASK    (0x07 << 5)
> +#define   RTS5261_LDO1_OCP_EN          (0x01 << 4)
> +#define   RTS5261_LDO1_OCP_LMT_THD_MASK        (0x03 << 2)
> +#define   RTS5261_LDO1_OCP_LMT_EN      (0x01 << 1)
> +
>  #define LDO_VCC_CFG1                   0xFF73
>  #define   LDO_VCC_REF_TUNE_MASK                0x30
>  #define   LDO_VCC_REF_1V2              0x20
> @@ -741,6 +766,8 @@
>
>  #define RTS5260_AUTOLOAD_CFG4          0xFF7F
>  #define   RTS5260_MIMO_DISABLE         0x8A
> +/*RTS5261*/
> +#define   RTS5261_AUX_CLK_16M_EN               (1 << 5)
>
>  #define RTS5260_REG_GPIO_CTL0          0xFC1A
>  #define   RTS5260_REG_GPIO_MASK                0x01
> @@ -1191,6 +1218,7 @@ struct rtsx_pcr {
>  #define EXTRA_CAPS_MMC_HS200           (1 << 4)
>  #define EXTRA_CAPS_MMC_8BIT            (1 << 5)
>  #define EXTRA_CAPS_NO_MMC              (1 << 7)
> +#define EXTRA_CAPS_SD_EXPRESS          (1 << 8)
>         u32                             extra_caps;
>
>  #define IC_VER_A                       0
> --
> 2.17.1
>

Kind regards
Uffe
