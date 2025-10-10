Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F125A2DA;
	Fri, 10 Oct 2025 13:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104646; cv=none; b=W7Iq/6FGL45fJ6/2KqmK4a9NsZBsjQJe//6W3+F3DsYH2EFMNPUYSpyjINl5mGXUdjEl2dDcpZkVsEJQyO31y7U9t2mXWd9cb1Z6xkgZ3v95uF04WQnYOcZWrwdtARrkFbD1eBK2h9T0tQSV2Khe38YMt1RptHtuaMKiznibUxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104646; c=relaxed/simple;
	bh=F5dmuxigOsbJkkUVJHpiKV2nhPRa207poDWsucgwdVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IYChsUxvjuV7Rob2i7qXXLXugtS3vWLbPnG2Z0IhI1E/Z1hKacSlxKugGq73MiAW2KhTXP3aQTBsxJFRrKu4T8P4dWlP9BBAEh/y3+Jf+oqnowLtXlDVwXcSiouCQb6hrM369kD/RoLqV5dGy6p1HVNZp5V9FiMGRCLMa0INiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=T4eE7aGW; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="T4eE7aGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1760104644; x=1791640644;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F5dmuxigOsbJkkUVJHpiKV2nhPRa207poDWsucgwdVE=;
  b=T4eE7aGWFMCEpxYB+prxFV20tBSNca81VOkVM0/3QIMYoeJLz5B86VB8
   UzCKCMU+j6KivpsHdGb/w4V7cFG1+BuQ8kGCQ5mVOcQeK53u2RZxxo5Br
   PIaNrdk5b1DxxAPeHayj+hAr6ooHS01f9OyaSzZmrqPFlhTQALpwFoWOl
   APb1oOjQHFhNRDGSsTuRormM8fZ9I/+4MVUyBqiZWr1E+Wd4f0p3eygsZ
   lk37F8r590snPGGUapm0xbjDPUUwpk9RvQvIRXCT94czdTOUlkcnizu94
   l7fuXoSA4gv3ib/BGySNLOJlYnfHtOPg43UzqhTAhEEJCimUnxH3//O0p
   g==;
X-CSE-ConnectionGUID: vQSa1ukxSb+jda2eRKjdDQ==
X-CSE-MsgGUID: z6CwOF5ETt+Hlz59kVyFvA==
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="46983394"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Oct 2025 06:57:22 -0700
Received: from chn-vm-ex4.mchp-main.com (10.10.87.33) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 10 Oct 2025 06:57:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.27; Fri, 10 Oct 2025 06:57:03 -0700
Received: from [10.171.248.111] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 10 Oct 2025 06:57:01 -0700
Message-ID: <f382afdf-3194-49b3-9343-ad700697359e@microchip.com>
Date: Fri, 10 Oct 2025 15:57:17 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: use octal file permissions instead of symbolic
To: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Ulf Hansson
	<ulf.hansson@linaro.org>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20251002005714.6380-1-pedrodemargomes@gmail.com>
Content-Language: en-US, fr
From: Aubin Constans <aubin.constans@microchip.com>
In-Reply-To: <20251002005714.6380-1-pedrodemargomes@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 02/10/2025 02:57, Pedro Demarchi Gomes wrote:
> As stated in Documentation/dev-tools/checkpatch.rst, octal file
> permissions are preferred over symbolic constants because they are
> easier to read and understand. Replace symbolic permissions with
> their octal equivalents.
> 
> Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> ---
>   drivers/mmc/core/block.c       |  6 +++---
>   drivers/mmc/core/bus.h         |  2 +-
>   drivers/mmc/core/mmc.c         |  4 ++--
>   drivers/mmc/core/mmc_test.c    |  4 ++--
>   drivers/mmc/core/sd.c          |  2 +-
>   drivers/mmc/host/atmel-mci.c   | 10 +++++-----

Each driver may require its dedicated patch and dedicated subject, may not it?

>   drivers/mmc/host/davinci_mmc.c |  6 +++---
>   drivers/mmc/host/dw_mmc.c      | 10 +++++-----
>   drivers/mmc/host/omap.c        |  4 ++--
>   drivers/mmc/host/omap_hsmmc.c  |  4 ++--
>   10 files changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 9cc47bf94804..78dc1a9ca2ef 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -387,10 +387,10 @@ static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
>          if (a == &dev_attr_ro_lock_until_next_power_on.attr &&
>              (md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
>              md->queue.card->ext_csd.boot_ro_lockable) {
> -               mode = S_IRUGO;
> +               mode = 0444;
>                  if (!(md->queue.card->ext_csd.boot_ro_lock &
>                                  EXT_CSD_BOOT_WP_B_PWR_WP_DIS))
> -                       mode |= S_IWUSR;
> +                       mode |= 0200;
>          }
> 
>          mmc_blk_put(md);
> @@ -3244,7 +3244,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> 
>          if (mmc_card_mmc(card)) {
>                  md->ext_csd_dentry =
> -                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> +                       debugfs_create_file("ext_csd", 0400, root, card,
>                                              &mmc_dbg_ext_csd_fops);
>          }
>   }
> diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
> index cfd0d02d3420..8b69624fa46e 100644
> --- a/drivers/mmc/core/bus.h
> +++ b/drivers/mmc/core/bus.h
> @@ -20,7 +20,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
>          struct mmc_card *card = mmc_dev_to_card(dev);                           \
>          return sysfs_emit(buf, fmt, args);                                      \
>   }                                                                              \
> -static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
> +static DEVICE_ATTR(name, 0444, mmc_##name##_show, NULL)
> 
>   struct mmc_card *mmc_alloc_card(struct mmc_host *host,
>                                  const struct device_type *type);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 5be9b42d5057..e4b7829469ea 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -830,7 +830,7 @@ static ssize_t mmc_fwrev_show(struct device *dev,
>                                    card->ext_csd.fwrev);
>   }
> 
> -static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
> +static DEVICE_ATTR(fwrev, 0444, mmc_fwrev_show, NULL);
> 
>   static ssize_t mmc_dsr_show(struct device *dev,
>                              struct device_attribute *attr,
> @@ -846,7 +846,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>                  return sysfs_emit(buf, "0x%x\n", 0x404);
>   }
> 
> -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
> 
>   static struct attribute *mmc_std_attrs[] = {
>          &dev_attr_cid.attr,
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 80e5d87a5e50..62b4983c1ef5 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3218,12 +3218,12 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
> 
>          mutex_lock(&mmc_test_lock);
> 
> -       ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
> +       ret = __mmc_test_register_dbgfs_file(card, "test", 0644,
>                  &mmc_test_fops_test);
>          if (ret)
>                  goto err;
> 
> -       ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
> +       ret = __mmc_test_register_dbgfs_file(card, "testlist", 0444,
>                  &mtf_testlist_fops);
>          if (ret)
>                  goto err;
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index ec02067f03c5..5ed6bc47f1c4 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -744,7 +744,7 @@ static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
>          return sysfs_emit(buf, "0x%x\n", 0x404);
>   }
> 
> -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
> 
>   MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
>   MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 777342fb7657..d4a504f0aded 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -609,12 +609,12 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
>          if (!root)
>                  return;
> 
> -       debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
> -       debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> -       debugfs_create_xul("pending_events", S_IRUSR, root,
> +       debugfs_create_file("regs", 0400, root, host, &atmci_regs_fops);
> +       debugfs_create_file("req", 0400, root, slot, &atmci_req_fops);
> +       debugfs_create_u32("state", 0400, root, &host->state);
> +       debugfs_create_xul("pending_events", 0400, root,
>                             &host->pending_events);
> -       debugfs_create_xul("completed_events", S_IRUSR, root,
> +       debugfs_create_xul("completed_events", 0400, root,
>                             &host->completed_events);
>   }
> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index c691f1b60395..3174e7ac65b3 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -145,17 +145,17 @@
>   #define MAX_NR_SG      16
> 
>   static unsigned rw_threshold = 32;
> -module_param(rw_threshold, uint, S_IRUGO);
> +module_param(rw_threshold, uint, 0444);
>   MODULE_PARM_DESC(rw_threshold,
>                  "Read/Write threshold. Default = 32");
> 
>   static unsigned poll_threshold = 128;
> -module_param(poll_threshold, uint, S_IRUGO);
> +module_param(poll_threshold, uint, 0444);
>   MODULE_PARM_DESC(poll_threshold,
>                   "Polling transaction size threshold. Default = 128");
> 
>   static unsigned poll_loopcount = 32;
> -module_param(poll_loopcount, uint, S_IRUGO);
> +module_param(poll_loopcount, uint, 0444);
>   MODULE_PARM_DESC(poll_loopcount,
>                   "Maximum polling loop count. Default = 32");
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..2380ab82812a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -175,12 +175,12 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
>          if (!root)
>                  return;
> 
> -       debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
> -       debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
> -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> -       debugfs_create_xul("pending_events", S_IRUSR, root,
> +       debugfs_create_file("regs", 0400, root, host, &dw_mci_regs_fops);
> +       debugfs_create_file("req", 0400, root, slot, &dw_mci_req_fops);
> +       debugfs_create_u32("state", 0400, root, &host->state);
> +       debugfs_create_xul("pending_events", 0400, root,
>                             &host->pending_events);
> -       debugfs_create_xul("completed_events", S_IRUSR, root,
> +       debugfs_create_xul("completed_events", 0400, root,
>                             &host->completed_events);
>   #ifdef CONFIG_FAULT_INJECTION
>          fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 52ac3f128a1c..5fc7d6d722b7 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -326,7 +326,7 @@ mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
>                         "closed");
>   }
> 
> -static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
> +static DEVICE_ATTR(cover_switch, 0444, mmc_omap_show_cover_switch, NULL);
> 
>   static ssize_t
>   mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
> @@ -338,7 +338,7 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
>          return sprintf(buf, "%s\n", slot->pdata->name);
>   }
> 
> -static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
> +static DEVICE_ATTR(slot_name, 0444, mmc_omap_show_slot_name, NULL);
> 
>   static void
>   mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index adc0d0b6ae37..5c679b795af1 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -747,7 +747,7 @@ omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
>          return sprintf(buf, "%s\n", mmc_pdata(host)->name);
>   }
> 
> -static DEVICE_ATTR(slot_name, S_IRUGO, omap_hsmmc_show_slot_name, NULL);
> +static DEVICE_ATTR(slot_name, 0444, omap_hsmmc_show_slot_name, NULL);
> 
>   /*
>    * Configure the response type and send the cmd.
> @@ -1673,7 +1673,7 @@ DEFINE_SHOW_ATTRIBUTE(mmc_regs);
>   static void omap_hsmmc_debugfs(struct mmc_host *mmc)
>   {
>          if (mmc->debugfs_root)
> -               debugfs_create_file("regs", S_IRUSR, mmc->debugfs_root,
> +               debugfs_create_file("regs", 0400, mmc->debugfs_root,
>                          mmc, &mmc_regs_fops);
>   }
> 
> --
> 2.39.5
> 

