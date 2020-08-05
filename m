Return-Path: <SRS0=eJC8=BP=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48536C433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DC5922CA0
	for <linux-mmc@archiver.kernel.org>; Wed,  5 Aug 2020 06:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ckLt2Hja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgHEGee (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgHEGee (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2020 02:34:34 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE938C061756
        for <linux-mmc@vger.kernel.org>; Tue,  4 Aug 2020 23:34:33 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id l184so8573000vki.10
        for <linux-mmc@vger.kernel.org>; Tue, 04 Aug 2020 23:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Izm9CrPLohryxU3MDcr4vOdCg89l4cBAjIrruJENdp0=;
        b=ckLt2HjalR4fWHRxNoET0unnn2lxQb7Gdmn+8jgKHcHj6KUBZNW5cYd1C0og9dqMkm
         rTunozbRodwFbCT5D9790M813rgEb3Ich+lQg9nezzX+bifywuafpGRryopnFhr4bvnf
         siuDdd+tAlWXfwnqGTk620BIEuk84JAyps9JgLbJRFboTH6lKk2HCcVOFLT//ZjxpvzH
         KlagF+zSZFnCTOMZRCWhaOQXynxfx8ZCAfhtw6Rb35f0cfZR3g0YMQuGP3LlFUBS/RDo
         ZRGOq+yPKId5vZfkp0vwwnSyQ5/NCDoI2r2G+w0+gMAgAKuT+GYqiLBpdfiWZ9Fw0L/9
         wsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Izm9CrPLohryxU3MDcr4vOdCg89l4cBAjIrruJENdp0=;
        b=UZz+058kvnyfDAF0YI25hKO+GMxrpI1QtgIYxQFTp5B5Qq1k8uRvysuLhehE/PymwS
         8ummg/MT7jd1VNGV0D/vpNoEAKEkB75igHMsCyk57dS07YA+pNHYIUR5aCh6U9Km/0Ai
         pQgP3C9jOscDtWVbD2xJTwB2GFgcFYZxgS9BmFp53fCxtSNEP9vnm1f4zJ3rIEyHa5WC
         2tGOdCkgyrNZbs+aMSwaNNnXhX7STn41RCHhbim142Z0jsVCygHwnThBeTKwas0ckiyi
         3XgxxUDWkY1J26mB+IjZNblP83ZJizsKrPAqBx17y1orLDoaXaafYmxJEq62j+sXhb81
         bcKg==
X-Gm-Message-State: AOAM531Ywv0D6J8lmd/rRphfHfWcSZQJ+SlIh4QrjRxIP89p25h9kB5u
        N2wpOJPccvjtyxp9Bz8b20oR2nIZ+YFOSJ1QsjZf6WBW7nOgBQ==
X-Google-Smtp-Source: ABdhPJwjmHEG+n503eEdN9m4EYLCPgDwJUUK64dQ97cRm46R32hGYZGULEUvMG3ioxWlxIk1R/m3RFa0ZCeKhSZoMBo=
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr1304488vkc.53.1596609273140;
 Tue, 04 Aug 2020 23:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200720111625.306681-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200720111625.306681-1-vaibhavgupta40@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Aug 2020 08:33:55 +0200
Message-ID: <CAPDyKFo_skSjZ0gfLNNgx2rdDDu3gTJ4Lc+40t=Jb1KPoBBaiA@mail.gmail.com>
Subject: Re: [PATCH v1] memstick: jmb38x_ms: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Jul 2020 at 13:19, Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
>
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
>
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(),
> pci_set_power_state() and pci_set_master() to do required operations. In
> generic mode, they are no longer needed.
>
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use to_pci_dev() and dev_get_drvdata() to get
> "struct pci_dev*" variable and drv data.
>
> Compile-tested only.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Applied for next (a while ago), thanks!
Kind regards
Uffe


> ---
>  drivers/memstick/host/jmb38x_ms.c | 38 +++++++++----------------------
>  1 file changed, 11 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index 0a9c5ddf2f59..2aa9592917d9 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -793,11 +793,10 @@ static int jmb38x_ms_pmos(struct pci_dev *pdev, int flag)
>          return 0;
>  }
>
> -#ifdef CONFIG_PM
> -
> -static int jmb38x_ms_suspend(struct pci_dev *dev, pm_message_t state)
> +static int __maybe_unused jmb38x_ms_suspend(struct device *dev)
>  {
> -       struct jmb38x_ms *jm = pci_get_drvdata(dev);
> +       struct jmb38x_ms *jm = dev_get_drvdata(dev);
> +
>         int cnt;
>
>         for (cnt = 0; cnt < jm->host_cnt; ++cnt) {
> @@ -806,26 +805,17 @@ static int jmb38x_ms_suspend(struct pci_dev *dev, pm_message_t state)
>                 memstick_suspend_host(jm->hosts[cnt]);
>         }
>
> -       pci_save_state(dev);
> -       pci_enable_wake(dev, pci_choose_state(dev, state), 0);
> -       pci_disable_device(dev);
> -       pci_set_power_state(dev, pci_choose_state(dev, state));
> +       device_wakeup_disable(dev);
> +
>         return 0;
>  }
>
> -static int jmb38x_ms_resume(struct pci_dev *dev)
> +static int __maybe_unused jmb38x_ms_resume(struct device *dev)
>  {
> -       struct jmb38x_ms *jm = pci_get_drvdata(dev);
> +       struct jmb38x_ms *jm = dev_get_drvdata(dev);
>         int rc;
>
> -       pci_set_power_state(dev, PCI_D0);
> -       pci_restore_state(dev);
> -       rc = pci_enable_device(dev);
> -       if (rc)
> -               return rc;
> -       pci_set_master(dev);
> -
> -       jmb38x_ms_pmos(dev, 1);
> +       jmb38x_ms_pmos(to_pci_dev(dev), 1);
>
>         for (rc = 0; rc < jm->host_cnt; ++rc) {
>                 if (!jm->hosts[rc])
> @@ -837,13 +827,6 @@ static int jmb38x_ms_resume(struct pci_dev *dev)
>         return 0;
>  }
>
> -#else
> -
> -#define jmb38x_ms_suspend NULL
> -#define jmb38x_ms_resume NULL
> -
> -#endif /* CONFIG_PM */
> -
>  static int jmb38x_ms_count_slots(struct pci_dev *pdev)
>  {
>         int cnt, rc = 0;
> @@ -1030,13 +1013,14 @@ static struct pci_device_id jmb38x_ms_id_tbl [] = {
>         { }
>  };
>
> +static SIMPLE_DEV_PM_OPS(jmb38x_ms_pm_ops, jmb38x_ms_suspend, jmb38x_ms_resume);
> +
>  static struct pci_driver jmb38x_ms_driver = {
>         .name = DRIVER_NAME,
>         .id_table = jmb38x_ms_id_tbl,
>         .probe = jmb38x_ms_probe,
>         .remove = jmb38x_ms_remove,
> -       .suspend = jmb38x_ms_suspend,
> -       .resume = jmb38x_ms_resume
> +       .driver.pm = &jmb38x_ms_pm_ops,
>  };
>
>  module_pci_driver(jmb38x_ms_driver);
> --
> 2.27.0
>
