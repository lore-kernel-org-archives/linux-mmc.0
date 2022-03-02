Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE8EC433EF
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Mar 2022 11:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240717AbiCBLfe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Mar 2022 06:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239895AbiCBLfd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Mar 2022 06:35:33 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF52299694
        for <linux-mmc@vger.kernel.org>; Wed,  2 Mar 2022 03:34:50 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l12so1801982ljh.12
        for <linux-mmc@vger.kernel.org>; Wed, 02 Mar 2022 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jk/kyV1GLxWOeF6Q9fh0NKxfKT7911e8jRHc7/h85W8=;
        b=pyLW304YtYPCtMvRo2/e1WNmsRPQvhp2e1XDgqMPZlRnwdOc6UJufV599LDH1IXlKZ
         BfE0B7r8teLF1tIoJshUoYVOOzKG/oK6uyOLRm/WZ4Z49/VVQK/G680A8ADN3P6vXS8V
         0SMgE2WqihcpiU14qL/wFXteGveVRQ6U6EMXY0Sd7j4r90SLkEFtw3DtjDMvdvCcduVg
         jEsrJX8p9iuemmRkcsZAEtTln9noZl3eLaX88r4RPyoof28AR1yxg7oCH+6m14Jfek12
         2ldG2moeAgKrMhkGzLYmqSOrjbZMMKDUXjSM1cPjdid0x9sYUjqdte6e02gxvfsG7LxA
         kFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jk/kyV1GLxWOeF6Q9fh0NKxfKT7911e8jRHc7/h85W8=;
        b=bHoigZztQG+jsAXvqXSIAMeH9MrUL5SfYJvh3T0SQ8aeEK+TV09oJJ5ffu7iM5BUSd
         myM5e7kSTWX+cVp7mdxLS3WzqayyHHTFlYfWj6e3uACc3sFyzkaYbrNcj9sEQpAOvH94
         ePOHuRB35ndhwHkJgLxihJ7zq3tVRLw4bktdLyDfqpWL5b2q1JICFvoswQWXIV41LUq4
         yLtEPn1KgBQw8DXIGOe8gr6T7XIM1BqYJHSBYVsOL/g0X1rxbU/e6vUOekF/80ZJCEyp
         NaCEjZBvpePbK5AYlKBoSlLonRVNQHJnvsftHL36grSrQF1G6Yq3IH/J0jIV9jAayE6E
         fiLQ==
X-Gm-Message-State: AOAM530PJ43zTq4X1xXGIH3rCXZO2Q3fATFEi9qsd3Kb1gcLmI4jlbpU
        m0M41PQ0/OLSVsM1jO9AzbhDYuY+cNfaXKhAJHJFCrEyCsU=
X-Google-Smtp-Source: ABdhPJz6V1qwnDI6lZX9QgPe+WFHQPCPir7L0W08RpKrIxDAoCdDoWNUsQw7hLQyKs5Va9bM6ldL5n0zYBJ1B4A7LZs=
X-Received: by 2002:a2e:9c94:0:b0:233:82df:a3b8 with SMTP id
 x20-20020a2e9c94000000b0023382dfa3b8mr20356385lji.229.1646220889153; Wed, 02
 Mar 2022 03:34:49 -0800 (PST)
MIME-Version: 1.0
References: <1badf10aba764191a1a752edcbf90389@realtek.com>
In-Reply-To: <1badf10aba764191a1a752edcbf90389@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Mar 2022 12:34:12 +0100
Message-ID: <CAPDyKFoa6d8_8VXp1QcTguuq3d9kX=g8H3yJo-ZJmF9neE_JKQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: rtsx: add 74 Clocks in power on flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 2 Mar 2022 at 10:43, Ricky WU <ricky_wu@realtek.com> wrote:
>
> SD spec definition:
> "Host provides at least 74 Clocks before issuing first command"
> After 1ms for the voltage stable then start issuing the Clock signals
>
> if POWER STATE is
> MMC_POWER_OFF to MMC_POWER_UP to issue Clock signal to card
> MMC_POWER_UP to MMC_POWER_ON to stop issuing signal to card
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Greg, I verified that this shouldn't conflict with the changes you
have picked up already for the rtsx mmc driver.

Kind regards
Uffe

> ---
> v2:
> modify commit message
> move mdelay(5) to host->power_delay_ms
> replace host->power_state with host->prev_power_state
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2a3f14afe9f8..d26803d3f4ca 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -38,10 +38,7 @@ struct realtek_pci_sdmmc {
>         bool                    double_clk;
>         bool                    eject;
>         bool                    initial_mode;
> -       int                     power_state;
> -#define SDMMC_POWER_ON         1
> -#define SDMMC_POWER_OFF                0
> -
> +       int                     prev_power_state;
>         int                     sg_count;
>         s32                     cookie;
>         int                     cookie_sg_count;
> @@ -909,7 +906,7 @@ static int sd_set_bus_width(struct realtek_pci_sdmmc *host,
>         return err;
>  }
>
> -static int sd_power_on(struct realtek_pci_sdmmc *host)
> +static int sd_power_on(struct realtek_pci_sdmmc *host, unsigned char power_mode)
>  {
>         struct rtsx_pcr *pcr = host->pcr;
>         struct mmc_host *mmc = host->mmc;
> @@ -917,9 +914,14 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         u32 val;
>         u8 test_mode;
>
> -       if (host->power_state == SDMMC_POWER_ON)
> +       if (host->prev_power_state == MMC_POWER_ON)
>                 return 0;
>
> +       if (host->prev_power_state == MMC_POWER_UP) {
> +               rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
> +               goto finish;
> +       }
> +
>         msleep(100);
>
>         rtsx_pci_init_cmd(pcr);
> @@ -940,10 +942,15 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (err < 0)
>                 return err;
>
> +       mdelay(1);
> +
>         err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
>         if (err < 0)
>                 return err;
>
> +       /* send at least 74 clocks */
> +       rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
> +
>         if (PCI_PID(pcr) == PID_5261) {
>                 /*
>                  * If test mode is set switch to SD Express mandatorily,
> @@ -968,7 +975,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>                 }
>         }
>
> -       host->power_state = SDMMC_POWER_ON;
> +finish:
> +       host->prev_power_state = power_mode;
>         return 0;
>  }
>
> @@ -977,7 +985,7 @@ static int sd_power_off(struct realtek_pci_sdmmc *host)
>         struct rtsx_pcr *pcr = host->pcr;
>         int err;
>
> -       host->power_state = SDMMC_POWER_OFF;
> +       host->prev_power_state = MMC_POWER_OFF;
>
>         rtsx_pci_init_cmd(pcr);
>
> @@ -1003,7 +1011,7 @@ static int sd_set_power_mode(struct realtek_pci_sdmmc *host,
>         if (power_mode == MMC_POWER_OFF)
>                 err = sd_power_off(host);
>         else
> -               err = sd_power_on(host);
> +               err = sd_power_on(host, power_mode);
>
>         return err;
>  }
> @@ -1506,10 +1514,11 @@ static int rtsx_pci_sdmmc_drv_probe(struct platform_device *pdev)
>
>         host = mmc_priv(mmc);
>         host->pcr = pcr;
> +       mmc->ios.power_delay_ms = 5;
>         host->mmc = mmc;
>         host->pdev = pdev;
>         host->cookie = -1;
> -       host->power_state = SDMMC_POWER_OFF;
> +       host->prev_power_state = MMC_POWER_OFF;
>         INIT_WORK(&host->work, sd_request);
>         platform_set_drvdata(pdev, host);
>         pcr->slots[RTSX_SD_CARD].p_dev = pdev;
> --
> 2.25.1
