Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88433033E
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707861; cv=none; b=ZFg4rOpSlNcAEytKqZqk7PqEsIuCWXX1fp8oPi4i7+iO68VE6x2SN0LmDbVg6QyxhR6u7pSUUFQrNvk8Q4qQUPX2kPeeFEeZf1pc8R0rNXeH6htnUTKrWgMw5O65ozgwT8eINHroXiLFf0K9HldAwBFb7nbAgekgktTRLj0LJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707861; c=relaxed/simple;
	bh=yBqgkGhF6fiMbls66gfq8iBlnakR1C8wSAHB7YhdWcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmjxhksozSAdsbvnVsCOsLI66whrnmL0nmG6hbuGqvk/yOQfgFdAvIDDfxojpOHThbGP9/iMnAWvzKoYd2Q8m2bmmfHJd/i40Rgk8kNcuebjdBqQ9Cm9w/gxw9KpKk4LJJbWfWpfZ3mhhCfBKUoIbMvPvzEPyquVEULVYZi43ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjK/oE2z; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjK/oE2z"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63cd60ca2b2so2108360d50.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707859; x=1761312659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0FtBhpPzKRpl2tfEyH08eb2+Qv368HkfNVlOBa3xl7s=;
        b=IjK/oE2zVS0F1yDNXnpwJc8IsYhullwy4EJDswj2CAWUU5b3NfO+iHzmYo6WeBvfeb
         SwW9gpd3/JGeUc1wmb7g/O6JG089YySk2jmYvIE8j+ZV27i/X6XyZ3UVOJ83ubjYG6dv
         u2ix26sFJgPrH9oLEuIFHZSHLvW8nZkg49hKsLu4GlttMDHDUY+mjJO3NKLvF9lN1k3w
         H9BvV3F/fQ5UJkPIwNOeRAon0FtL0PuThwOFsf/Zmw7TmIT13BLxjcJbxAfSiksmlBOW
         Jh1Qd4rSAAjsf1VJkokDpw/DLR7tyi6XOU3X+bvpByVIem4uZ/cBp6UwmJE1hcnMPKtm
         dRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707859; x=1761312659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0FtBhpPzKRpl2tfEyH08eb2+Qv368HkfNVlOBa3xl7s=;
        b=nrve4oFIuefciHYniLYBNr0Ds9+VD1i1pC/bzl4SfmHx4X6BfPrZaqyEa55FILhEY6
         IWb4iTyn7AMh2xAqAykhuhq5EFm8ChNDkzS6C15txswC3RulmmCqTyTY3cv7peMl7jrQ
         ILwvT3cuzNcDCziQ0rsQylSrmLPI5wnlTP3LTw4J4TI5YCzyPQadjg6lKSlrowW/vl6l
         PO7+lqznKRbO6sIAhgBzLb3T9Pauv1AcspB6W3XlbtMGlauQdLjhqe14E+E+/89EZqe1
         GZa0ripRZ11Uqq6yqbJcXcHMTIbloEik9BR8x9ke1NNXvvkwEnoygZPYxgZMZ8VP+FK3
         5Xzg==
X-Forwarded-Encrypted: i=1; AJvYcCUVp2G/ry+TfYtIuEHMKxh4Vn1kbO4MenEDBzADuGI0ey8ebpOelXs9uj1LKJnBy2EtLbCxlRV2Pss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxIhrn5NfSULELaLr4giXLiO2eRteM1fR6L99hOaXQ+8IGhQvL
	Gq3BgAigJVWTHNUtOfeFiFsjFD8TRKLr6JVz/wJ03Mk7gbr66LLdcedTl4kqJL+ZpnzrU3Qa2VD
	/Q7gCyQg9OQh9FMTTGH+rPiO0wRsWIwvGymWeuTKJY5jcjnAudGC6
X-Gm-Gg: ASbGncsKka47fypPAQhZK+37ET5GYL648rko6kl/tQ9o4OMWtAtC4nHyGpsA0t4Ddus
	NWanW0ZOnU3tcWl0IUpgJLjzL7Mw88sNGghFb2S3JENzzbPlLxSskmLoaTbUPkZD+3HxZTPDndx
	TSvT86VXnKGy/1bWoxuI/WsMpqmARjWFDgRsIaVeQ55d9c1C2neNc1lK9OQ8fcJ0hVX6xOMBaWa
	PpZQ+3b0VcU2rEK1Yo/vdb7D0O3F4aP8S7yLhKRPNDxLFiSucKXvoWVdu5yUg==
X-Google-Smtp-Source: AGHT+IEW3t+pwNEkPLcIULolGg4W/ugHqNfNlotxQxVsSVYJeOX9eRGV+c6JH1nQvQY/MzTgg+qMMndsOvBPwWYOg7A=
X-Received: by 2002:a53:bf85:0:b0:636:1ebd:5692 with SMTP id
 956f58d0204a3-63e161c6363mr2365508d50.32.1760707858621; Fri, 17 Oct 2025
 06:30:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002005714.6380-1-pedrodemargomes@gmail.com>
In-Reply-To: <20251002005714.6380-1-pedrodemargomes@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:22 +0200
X-Gm-Features: AS18NWB6nKGdnE2NjYqsmPs2qx194tuBwIu-YZ5wiQBgkvusg2MGsM65Cy_vgog
Message-ID: <CAPDyKFpFso+bv4H23Nz4m63aAQ=gjbawNpBXz7N4SQzACaX=Tw@mail.gmail.com>
Subject: Re: [PATCH] mmc: use octal file permissions instead of symbolic
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Aubin Constans <aubin.constans@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 03:04, Pedro Demarchi Gomes
<pedrodemargomes@gmail.com> wrote:
>
> As stated in Documentation/dev-tools/checkpatch.rst, octal file
> permissions are preferred over symbolic constants because they are
> easier to read and understand. Replace symbolic permissions with
> their octal equivalents.
>
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c       |  6 +++---
>  drivers/mmc/core/bus.h         |  2 +-
>  drivers/mmc/core/mmc.c         |  4 ++--
>  drivers/mmc/core/mmc_test.c    |  4 ++--
>  drivers/mmc/core/sd.c          |  2 +-
>  drivers/mmc/host/atmel-mci.c   | 10 +++++-----
>  drivers/mmc/host/davinci_mmc.c |  6 +++---
>  drivers/mmc/host/dw_mmc.c      | 10 +++++-----
>  drivers/mmc/host/omap.c        |  4 ++--
>  drivers/mmc/host/omap_hsmmc.c  |  4 ++--
>  10 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9cc47bf94804..78dc1a9ca2ef 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -387,10 +387,10 @@ static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
>         if (a == &dev_attr_ro_lock_until_next_power_on.attr &&
>             (md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>             md->queue.card->ext_csd.boot_ro_lockable) {
> -               mode = S_IRUGO;
> +               mode = 0444;
>                 if (!(md->queue.card->ext_csd.boot_ro_lock &
>                                 EXT_CSD_BOOT_WP_B_PWR_WP_DIS))
> -                       mode |= S_IWUSR;
> +                       mode |= 0200;
>         }
>
>         mmc_blk_put(md);
> @@ -3244,7 +3244,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
>
>         if (mmc_card_mmc(card)) {
>                 md->ext_csd_dentry =
> -                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                       debugfs_create_file("ext_csd", 0400, root, card,
>                                             &mmc_dbg_ext_csd_fops);
>         }
>  }
> diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
> index cfd0d02d3420..8b69624fa46e 100644
> --- a/drivers/mmc/core/bus.h
> +++ b/drivers/mmc/core/bus.h
> @@ -20,7 +20,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
>         struct mmc_card *card = mmc_dev_to_card(dev);                           \
>         return sysfs_emit(buf, fmt, args);                                      \
>  }                                                                              \
> -static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
> +static DEVICE_ATTR(name, 0444, mmc_##name##_show, NULL)
>
>  struct mmc_card *mmc_alloc_card(struct mmc_host *host,
>                                 const struct device_type *type);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..e4b7829469ea 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -830,7 +830,7 @@ static ssize_t mmc_fwrev_show(struct device *dev,
>                                   card->ext_csd.fwrev);
>  }
>
> -static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
> +static DEVICE_ATTR(fwrev, 0444, mmc_fwrev_show, NULL);
>
>  static ssize_t mmc_dsr_show(struct device *dev,
>                             struct device_attribute *attr,
> @@ -846,7 +846,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>                 return sysfs_emit(buf, "0x%x\n", 0x404);
>  }
>
> -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
>
>  static struct attribute *mmc_std_attrs[] = {
>         &dev_attr_cid.attr,
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 80e5d87a5e50..62b4983c1ef5 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3218,12 +3218,12 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
>
>         mutex_lock(&mmc_test_lock);
>
> -       ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
> +       ret = __mmc_test_register_dbgfs_file(card, "test", 0644,
>                 &mmc_test_fops_test);
>         if (ret)
>                 goto err;
>
> -       ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
> +       ret = __mmc_test_register_dbgfs_file(card, "testlist", 0444,
>                 &mtf_testlist_fops);
>         if (ret)
>                 goto err;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ec02067f03c5..5ed6bc47f1c4 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -744,7 +744,7 @@ static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
>         return sysfs_emit(buf, "0x%x\n", 0x404);
>  }
>
> -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
>
>  MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
>  MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 777342fb7657..d4a504f0aded 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -609,12 +609,12 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>         if (!root)
>                 return;
>
> -       debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
> -       debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> -       debugfs_create_xul("pending_events", S_IRUSR, root,
> +       debugfs_create_file("regs", 0400, root, host, &atmci_regs_fops);
> +       debugfs_create_file("req", 0400, root, slot, &atmci_req_fops);
> +       debugfs_create_u32("state", 0400, root, &host->state);
> +       debugfs_create_xul("pending_events", 0400, root,
>                            &host->pending_events);
> -       debugfs_create_xul("completed_events", S_IRUSR, root,
> +       debugfs_create_xul("completed_events", 0400, root,
>                            &host->completed_events);
>  }
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c691f1b60395..3174e7ac65b3 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -145,17 +145,17 @@
>  #define MAX_NR_SG      16
>
>  static unsigned rw_threshold = 32;
> -module_param(rw_threshold, uint, S_IRUGO);
> +module_param(rw_threshold, uint, 0444);
>  MODULE_PARM_DESC(rw_threshold,
>                 "Read/Write threshold. Default = 32");
>
>  static unsigned poll_threshold = 128;
> -module_param(poll_threshold, uint, S_IRUGO);
> +module_param(poll_threshold, uint, 0444);
>  MODULE_PARM_DESC(poll_threshold,
>                  "Polling transaction size threshold. Default = 128");
>
>  static unsigned poll_loopcount = 32;
> -module_param(poll_loopcount, uint, S_IRUGO);
> +module_param(poll_loopcount, uint, 0444);
>  MODULE_PARM_DESC(poll_loopcount,
>                  "Maximum polling loop count. Default = 32");
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..2380ab82812a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -175,12 +175,12 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
>         if (!root)
>                 return;
>
> -       debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
> -       debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
> -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> -       debugfs_create_xul("pending_events", S_IRUSR, root,
> +       debugfs_create_file("regs", 0400, root, host, &dw_mci_regs_fops);
> +       debugfs_create_file("req", 0400, root, slot, &dw_mci_req_fops);
> +       debugfs_create_u32("state", 0400, root, &host->state);
> +       debugfs_create_xul("pending_events", 0400, root,
>                            &host->pending_events);
> -       debugfs_create_xul("completed_events", S_IRUSR, root,
> +       debugfs_create_xul("completed_events", 0400, root,
>                            &host->completed_events);
>  #ifdef CONFIG_FAULT_INJECTION
>         fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 52ac3f128a1c..5fc7d6d722b7 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -326,7 +326,7 @@ mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
>                        "closed");
>  }
>
> -static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
> +static DEVICE_ATTR(cover_switch, 0444, mmc_omap_show_cover_switch, NULL);
>
>  static ssize_t
>  mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
> @@ -338,7 +338,7 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
>         return sprintf(buf, "%s\n", slot->pdata->name);
>  }
>
> -static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
> +static DEVICE_ATTR(slot_name, 0444, mmc_omap_show_slot_name, NULL);
>
>  static void
>  mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index adc0d0b6ae37..5c679b795af1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -747,7 +747,7 @@ omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
>         return sprintf(buf, "%s\n", mmc_pdata(host)->name);
>  }
>
> -static DEVICE_ATTR(slot_name, S_IRUGO, omap_hsmmc_show_slot_name, NULL);
> +static DEVICE_ATTR(slot_name, 0444, omap_hsmmc_show_slot_name, NULL);
>
>  /*
>   * Configure the response type and send the cmd.
> @@ -1673,7 +1673,7 @@ DEFINE_SHOW_ATTRIBUTE(mmc_regs);
>  static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>  {
>         if (mmc->debugfs_root)
> -               debugfs_create_file("regs", S_IRUSR, mmc->debugfs_root,
> +               debugfs_create_file("regs", 0400, mmc->debugfs_root,
>                         mmc, &mmc_regs_fops);
>  }
>
> --
> 2.39.5
>
