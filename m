Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADF0C433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7228204EA
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pp1F3Gn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHEGep (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbgHEGem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:34:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6AEC06174A
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:34:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b26so17576079vsa.13
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2ZiF+evfZ66+HifnXyioxGC5MxoHunhZYeIelbyLK0=;
        b=Pp1F3Gn30EM5c6aAAsf4shLRD0JwsRXxIpCpLuM6vKt8rKp33GZvzZ+lkDYgPiLsXf
         eZwJXF2sV30Uy39U3ktkOCtPYxfRQDoKF8HyLrQ67D7BH1Cm1DDOl5XtHacb3vD3t33M
         ePteu5fZNSYNfBFgtbMuuYdHzw4y6ljHTkMVNGyB/Je9JUXjGtCTsvIo2HYb4vh45Cj9
         W+Kg3fsbkojGqSnPmK36SFLOcR82MXJZlJiWN5AW24RZaL+bAfHt7LVNvoy74RLeo6pR
         mauo67Usaupye6fc94QefbVEMyISOeirNMqzbZtMs9NJDtfjJK60+UIcTNdJDVAtNQ43
         0VDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2ZiF+evfZ66+HifnXyioxGC5MxoHunhZYeIelbyLK0=;
        b=rSv0nPrbnHCTA9OaGeICbdsDK+fC/QeotHyfkPvURJefhP1B0y27jv9o+JgtN7h5cy
         FYAQyeLIeiVDc45/b0tsqkNoDBxZ8jB2e4XxaKg1EsmfC7dGLi5DhKN0C+H8SizZgyzG
         xZdWOdE5QQtKpEr8CRyvNhOR1GsJPqXvvJiR9HdTslTvvCnDcUGiK+lD4bZPNAyvwuaV
         N1CMqBhKTTGyaMhgc9w01r7zx6QOIZ8vsNTnkoeJKbidMAuLJJNSO+bg68OFDwYXcNe3
         6MtNHpIQa/zDCz1m6wY3p/Nvbrp9Fd7lzGuJRyr3vkOtAzX0NQkT4Wg44rgvJhpOncMt
         zGKw==
X-Gm-Message-State: AOAM530ThRyy5GsB1qY1rWNaaF4r1fD0Pr2IhLA3W9WVNpXkHL6kKCEj
        Migu2n1RLKA0fkPWsIx8cCjmjoN9Bpiw6nKfQy1Qdw==
X-Google-Smtp-Source: ABdhPJyRAxMGxKHCQASdyGMOW+VV/QwhN4h2J8nDZRBTQ8jRAAZ8+Pi9OLVoeV6w/H/WWYuftedBrzdoXivBkBl/+EM=
X-Received: by 2002:a67:8c06:: with SMTP id o6mr912216vsd.200.1596609281713;
 Tue, 04 Aug 2020 23:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200720142603.577323-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200720142603.577323-1-vaibhavgupta40@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:34:04 +0200
Message-ID: <CAPDyKFpHxf7xWOy+-qX+DQVtufbD50_imfi51TtsEp6P=iGs7g@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: via-sdmmc: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020 at 16:28, Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
>
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
>
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(),
> pci_enable_wake() and pci_set_power_state() and to do required operations.
> In generic mode, they are no longer needed.
>
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use dev_get_drvdata() to get drv data.
>
> Compile-tested only.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe


> ---
>  drivers/mmc/host/via-sdmmc.c | 33 ++++++++-------------------------
>  1 file changed, 8 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index ef95bce50889..49dab9f42b6d 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1220,9 +1220,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
>                 pci_name(pcidev), (int)pcidev->vendor, (int)pcidev->device);
>  }
>
> -#ifdef CONFIG_PM
> -
> -static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
> +static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
>  {
>         struct sdhcreg *pm_sdhcreg;
>         void __iomem *addrbase;
> @@ -1256,30 +1254,27 @@ static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
>         via_print_sdchc(host);
>  }
>
> -static int via_sd_suspend(struct pci_dev *pcidev, pm_message_t state)
> +static int __maybe_unused via_sd_suspend(struct device *dev)
>  {
>         struct via_crdr_mmc_host *host;
>
> -       host = pci_get_drvdata(pcidev);
> +       host = dev_get_drvdata(dev);
>
>         via_save_pcictrlreg(host);
>         via_save_sdcreg(host);
>
> -       pci_save_state(pcidev);
> -       pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
> -       pci_disable_device(pcidev);
> -       pci_set_power_state(pcidev, pci_choose_state(pcidev, state));
> +       device_wakeup_enable(dev);
>
>         return 0;
>  }
>
> -static int via_sd_resume(struct pci_dev *pcidev)
> +static int __maybe_unused via_sd_resume(struct device *dev)
>  {
>         struct via_crdr_mmc_host *sdhost;
>         int ret = 0;
>         u8 gatt;
>
> -       sdhost = pci_get_drvdata(pcidev);
> +       sdhost = dev_get_drvdata(dev);
>
>         gatt = VIA_CRDR_PCICLKGATT_PAD_PWRON;
>         if (sdhost->power == MMC_VDD_165_195)
> @@ -1294,32 +1289,20 @@ static int via_sd_resume(struct pci_dev *pcidev)
>
>         msleep(100);
>
> -       pci_set_power_state(pcidev, PCI_D0);
> -       pci_restore_state(pcidev);
> -       ret = pci_enable_device(pcidev);
> -       if (ret)
> -               return ret;
> -
>         via_restore_pcictrlreg(sdhost);
>         via_init_sdc_pm(sdhost);
>
>         return ret;
>  }
>
> -#else /* CONFIG_PM */
> -
> -#define via_sd_suspend NULL
> -#define via_sd_resume NULL
> -
> -#endif /* CONFIG_PM */
> +static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
>
>  static struct pci_driver via_sd_driver = {
>         .name = DRV_NAME,
>         .id_table = via_ids,
>         .probe = via_sd_probe,
>         .remove = via_sd_remove,
> -       .suspend = via_sd_suspend,
> -       .resume = via_sd_resume,
> +       .driver.pm = &via_sd_pm_ops,
>  };
>
>  module_pci_driver(via_sd_driver);
> --
> 2.27.0
>
