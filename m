Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A527DC00140
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jul 2022 15:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbiGZPCH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiGZPCE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jul 2022 11:02:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0944DEE3
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 08:02:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w15so15023382lft.11
        for <linux-mmc@vger.kernel.org>; Tue, 26 Jul 2022 08:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M3eaKEqKki8qki5Qb9UhtHWwntPVhLRvYCUBCxNj9YQ=;
        b=AiM8g9yWAbkS9+J/TBFSAt7ymESNu9mLo+7HhBQMUsThEYK5XHpx+Li+LJM3yz1HKc
         JEWiCI6JYY8P1UzuKwqy6FhoeRBbYMV5IBV57aBJ6s1S/pxW+IuhcnRQ0ewsmwvLmigi
         wq/HR0UD9L4fZMIIJbl/tKUG91ZvQlJPeawXaeB9D/wTxRFnqBKyZ08jDYofYXTNH9Gr
         YBtRGSZtHDEDDMO0i9e7w0VmZhW+J1aKcfiPTdnpQ4sjdpfmTVbGdHvRglcLnXGeGQZQ
         wwacrfyXpYa4iunxNiOx25bH/6uG9psehXkQU9nWZfqQQ0zB3N1fN7XPoeVt+yJw4QO3
         xepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M3eaKEqKki8qki5Qb9UhtHWwntPVhLRvYCUBCxNj9YQ=;
        b=Vd8pOKUIu/ycKiM6wbNIt5djGs83QtBlmyzQP3q2AlK7xxXXrJHw6kqN/vWHn8beQE
         VzoquhI4/eQaj4+FKB8Q2R4zSOCDSdCl+NjgaPqEV45t48eMAjj31kF/w71TsaCAXN6y
         WklTxKQgFeveP0R2aAzb8r5IihI7c9N4XEOGAA1Z4nF2feAgJ7b1fz6qefN7RBH52612
         EHjX59p8q+QKFKYJv0c150FOJWLzhVkSf9lHspGDxGL71SPG5X7jAeIblB5c97FqRMSY
         wtCaU4qsxPMsu4Xj2JA4Onpw9CQKTkxdshA9K26IRIjyNYYPBCFICyWHtuZrq8/tOydY
         xqgQ==
X-Gm-Message-State: AJIora8oH5RKhJqxG/BxmQEu84mt50fOkr3YFHlR1VWbJJnTO5YfxAsP
        2KLsoj1DPuM03pVZAX2i3nbrNiByFY5ZKMZ7Q/BbJg==
X-Google-Smtp-Source: AGRyM1uvj3g/wzQqWfb045Pdx41ie7mPz5l6Yuz5unfLdcYSECshn91W4YKovkSvKEvnNaqiqHxlbfPutsUrJA3Wc+8=
X-Received: by 2002:a05:6512:32c5:b0:48a:af79:601e with SMTP id
 f5-20020a05651232c500b0048aaf79601emr501700lfg.373.1658847721311; Tue, 26 Jul
 2022 08:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220726062842.18846-1-axe.yang@mediatek.com>
In-Reply-To: <20220726062842.18846-1-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jul 2022 17:01:25 +0200
Message-ID: <CAPDyKFpX32bprQMVXo-CYkfB__UL99JVZQ9EKfOWFqA7yh3Mbg@mail.gmail.com>
Subject: Re: [PATCH v14 0/3] mmc: mediatek: add support for SDIO async IRQ
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 Jul 2022 at 08:28, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Changes in v14:
> - add sdio_irq_claimed() judgement condition around msdc irq and pinctrl
>   control in suspend|resume callback

Version 14, applied for next, thanks!

FYI; Since we are relying on an updated behaviour in the
pm_runtime_force_suspend|resume() helpers, which are queued as a patch
via Rafael's tree, I am going to withhold my pull-request for a few
days longer than usual, until Linus has picked up Rafael's
pull-request, for v5.20-rc1.

Kind regards
Uffe


>
> Changes in v13:
> - remove state_dat1 related description in mtk-sd.yaml
> - move device_init_wakeup() to probe stage
> - remove redundancy SDC_CFG_SDIOIDE bit control in msdc_runtime_suspend()
> - replace SDC_CFG_SDIOIDE control with __msdc_enable_sdio_irq() function to
>   disable sdio irq when sdio_irq_claimed() return true in msdc_runtime_resume()
> - restore to use pm_runtime_force_resume|suspend(), to avoid go out directly
>   in force resume, bump up runtime PM usage counter before force suspend.
>
> Changes in v12:
> - assign NULL to pins_eint directly instead of using kfree()
>
> Changes in v11:
> - remove '_irq' suffix in interrupts-names property
> - fix yaml example build error
> - refactor msdc_enable_sdio_irq(), free pins_eint if async irq is not supported
>
> Changes in v10:
> - add sample node for SDIO host which support wakeup interrupt in yaml
> - skip MMC_PM_WAKE_SDIO_IRQ check before enable SDIO async interrupt
> - add MMC_PM_KEEP_POWER check before SDIO eint pinstate parsing
> - use dev_pm_set_dedicated_wake_irq_reverse() to correct irq control sequence
> - set dedicated irq in msdc_enable_sdio_irq() rather than msdc_drv_probe()
> - remove unnecessary wake irq control, rpm/dpm system shall manage that
> - move wake irq/msdc irq control back to system suspend phase, use rpm_suspend
>   and rpm_resume to ensure irq control sequence:
>      disable msdc irq -> enable wake irq -> disable wake irq -> enable msdc irq
> - simplify variables, check pins_eint to know whether wakeup settings are managed
>
> Changes in v9:
> - remove pinctrl "state_dat1"
>
> Changes in v8:
> - remove maxItems property under pinctrl-names property
>
> Changes in v7:
> - add device_init_wakeup() to register SDIO host as wakeup source
>
> Changes in v6:
> - abandon cap-sdio-async-irq flag, use wakeup-source flag instead
> - extend interrupts and pinctrls in mediatek mmc host controller DT documents
> - add mmc_card_enable_async_irq() to access enable_async_irq flag
> - simplify wakeup irq implementation with dedicate wake up irq related interface
>
> Changes in v5:
> - resort variables to reversed xmas tree order
> - restore old copyright year range and add current year back
>
> Changes in v4:
> - add MMC_CAP2_SDIO_ASYNC_IRQ judge before lookup eint pinctrl
> - replace spin_lock_irqsave() variant with spin_lock() in eint irq handler
>
> Changes in v3:
> - correct abbreviations with capital letters in commit message
> - replace copyright year with 2022 in mtk-sd.c
> - remove unnessary pointer casting
> - adjust variable order to reversed xmas tree
> - remove a redundant blank line
> - refine if statement, following standard pattern
>
> Changes in v2:
> - change flag name from 'cap-sdio-async-int' to 'cap-sdio-async-irq'
> - change corresponding macro names from xxx_INT to xxx_IRQ
> - resort new member in msdc_host structure
> - refine function msdc_request_dat1_eint_irq()
> - rename msdc_{suspend,resume} function names, add suffix '_noirq'
> - add MMC_CAP2_NO_SDIO judgement before parse eint related pin setting
>
> Axe Yang (3):
>   dt-bindings: mmc: mtk-sd: extend interrupts and pinctrls properties
>   mmc: core: Add support for SDIO wakeup interrupt
>   mmc: mediatek: add support for SDIO eint wakup IRQ
>
>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 50 ++++++++++-
>  drivers/mmc/core/sdio.c                       | 14 +++
>  drivers/mmc/host/mtk-sd.c                     | 86 +++++++++++++++++--
>  include/linux/mmc/card.h                      |  8 +-
>  include/linux/mmc/sdio.h                      |  5 ++
>  5 files changed, 155 insertions(+), 8 deletions(-)
>
> --
> 2.25.1
>
>
