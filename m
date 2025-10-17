Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E03570AA
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707865; cv=none; b=cmsm2g1lHhshQ0reFWmigb9vzMf0qm/8JMBiQNoHj8WnfF8QQuCnbUyHtVFWvl/pvDKGxEE33b3CWc8R/gb5t2xSZldUy2O4ZNu6PRPnc1Xq+OoaCrCDAfuYL8UHCeqOalpep5OE62ThhCd3D/0p6Q0xwP4DRvlhZbdUKLUbTbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707865; c=relaxed/simple;
	bh=R0VsoZSkHjZ26UH7z2HOvsvFWBEj2Q4fUDUQl1B0O04=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKEE/cK/juy+LLv+VnJPlTipaKCbsdHkUen2nl5+nEd3SnYR2pE0vk9InQOIXj5z95J2TyK16wsQ3OKM1xWKza3Qo5Um4WKXa/JIqgueJvVjQ8NXF4wLuO1KWw6jlncilRTCz1gyYgrd0rux3NZpYAC6RFg+QA4Z8a683aetk9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJYtITHy; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJYtITHy"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-63d8788b18dso1963494d50.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707862; x=1761312662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Br3nfQzM2b3iJlnKoC1ZBTO0ZyoeYGEnZGNsOjE4j9E=;
        b=qJYtITHyP2RzDe7EDTVKBD8AADZEZuoenXU2mFaVPbGOm2YmmGZGbW7ZdEj9DaK7Rd
         Pum3WWSGT8EnKsj48fpdpmlEg3D1BeD0CoHut4/ZOnWqMk6XIz+MSKJaFnHG6lXnm8Xm
         GcYswHSX3to90Syg1XSihxVcSw8q2RmWQr17hNGysWu+UtOs+jkRqHlbPqcIoUUsUqik
         2u6YMJsZHpEO9t036qG1+P8+EKeg4iicw4ozIb1RsanaiN9dJc7rbr++QwW4Pq1d7ZUp
         GldznxesNF/8HJFhRL9w1Ap2/DJOTJUI4HJMQxhNHDK55+dam7+7upCgU0vvIp0hJJqY
         nUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707862; x=1761312662;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Br3nfQzM2b3iJlnKoC1ZBTO0ZyoeYGEnZGNsOjE4j9E=;
        b=u006HXHHb3O2OCUplBoJFks2u76fBKwOs1+fr/FLtDHWvvXL+kpYbssybarIwBgIv/
         jU1l3bgIkEvyoateON41tE2Pa7EFRCTpU7UEjxae/oyhWiB4KCw6N16A0+tOAelsS8/G
         lMJ2B/eoqSz9856BFSEyjIA5vDgS5Nu/UyEbryXzIV0N4e320ooaQ8+iZn8E/Ovzv4lf
         K6Oa9+2t72aSEkhjfKHbrvJdnPRKo3AwLjQDIpAwOcK5VQc2VH3HRiC+yECHeLcPRb2C
         Ce602ud17oK6BeT5z4IgAG+daILO0cAUQRPysRi3CXBpX9e1zBlbNXFdkVnm6ZQx2gB1
         Yi8w==
X-Forwarded-Encrypted: i=1; AJvYcCXEETCnhjGsZm5VCBX2FtAUZDSpo5WUzl5pxE1S0qq0CUq3MWb4hm3go9o5EV+F2qG7daWyn27snqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkX1SfcxJB+BHk8tKPyuPhRSfFuxmb7feV0B6XyQn1UhgF3s5/
	XgRdbeh4vZLxWYuYDULrf/QByZx89dTuNhAgcGOVjSZVkMaim/FAXBuugOdi6WHvxiHnekPRbvu
	dFTIhB5PZb7ZGtuP3TEsiFxAC8GH3So0w/Nv774awfw==
X-Gm-Gg: ASbGncu1tspBR9RJEnpx00aZvYjp5f/rnqlx47n0C+9VagPnC045Zegl6eym+WLJPpO
	IZ1qqvSZiKvRfqyHSBm296OJwk+9Qz4Fr27yKHyssddjcjzOmBASQDqYUUxMcwEqQzRc+ktJkQ/
	5wukAZSylUT+EutW0BCdgN2BH0ndMITUTE9Fbyu5uYPZmZKz07GL4slbOuaBG4OF1iYqfI5Cg1c
	AtbZ1bsjos5b3y0FgM0gFsNng/2JsM7LV8/0rX58zenfeJzdDNQZ8DbuFZHCC/FeaH4cW3p
X-Google-Smtp-Source: AGHT+IFFgXVwv8BszKaNUvdFbTswUwdhsjnc0N1Y5vZRAO8iuIgw2PCBtVpU4KZfk6TVZIzG+FO2cjdcx5N2Qe6thbI=
X-Received: by 2002:a05:690e:150b:b0:63c:f70d:900 with SMTP id
 956f58d0204a3-63e1613dfe5mr3765508d50.28.1760707862038; Fri, 17 Oct 2025
 06:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002005714.6380-1-pedrodemargomes@gmail.com> <f382afdf-3194-49b3-9343-ad700697359e@microchip.com>
In-Reply-To: <f382afdf-3194-49b3-9343-ad700697359e@microchip.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:24 +0200
X-Gm-Features: AS18NWBjvTZr303gBofjqSsc06EFw7hFnsWxEhiaWEqalWBtsd2N0DyeNrWT8l0
Message-ID: <CAPDyKFoEpNvs+c=JFUmV+RiVES55gLmrcurCW_DBojpiCjRZnQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: use octal file permissions instead of symbolic
To: Aubin Constans <aubin.constans@microchip.com>
Cc: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 15:57, Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> On 02/10/2025 02:57, Pedro Demarchi Gomes wrote:
> > As stated in Documentation/dev-tools/checkpatch.rst, octal file
> > permissions are preferred over symbolic constants because they are
> > easier to read and understand. Replace symbolic permissions with
> > their octal equivalents.
> >
> > Signed-off-by: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
> > ---
> >   drivers/mmc/core/block.c       |  6 +++---
> >   drivers/mmc/core/bus.h         |  2 +-
> >   drivers/mmc/core/mmc.c         |  4 ++--
> >   drivers/mmc/core/mmc_test.c    |  4 ++--
> >   drivers/mmc/core/sd.c          |  2 +-
> >   drivers/mmc/host/atmel-mci.c   | 10 +++++-----
>
> Each driver may require its dedicated patch and dedicated subject, may not it?

Yes, in general this is the preferred way. However, when it comes to
more trivial clean-up patches, I think one bigger patch works better.

Kind regards
Uffe


>
> >   drivers/mmc/host/davinci_mmc.c |  6 +++---
> >   drivers/mmc/host/dw_mmc.c      | 10 +++++-----
> >   drivers/mmc/host/omap.c        |  4 ++--
> >   drivers/mmc/host/omap_hsmmc.c  |  4 ++--
> >   10 files changed, 26 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> > index 9cc47bf94804..78dc1a9ca2ef 100644
> > --- a/drivers/mmc/core/block.c
> > +++ b/drivers/mmc/core/block.c
> > @@ -387,10 +387,10 @@ static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
> >          if (a == &dev_attr_ro_lock_until_next_power_on.attr &&
> >              (md->area_type & MMC_BLK_DATA_AREA_BOOT) &&
> >              md->queue.card->ext_csd.boot_ro_lockable) {
> > -               mode = S_IRUGO;
> > +               mode = 0444;
> >                  if (!(md->queue.card->ext_csd.boot_ro_lock &
> >                                  EXT_CSD_BOOT_WP_B_PWR_WP_DIS))
> > -                       mode |= S_IWUSR;
> > +                       mode |= 0200;
> >          }
> >
> >          mmc_blk_put(md);
> > @@ -3244,7 +3244,7 @@ static void mmc_blk_add_debugfs(struct mmc_card *card, struct mmc_blk_data *md)
> >
> >          if (mmc_card_mmc(card)) {
> >                  md->ext_csd_dentry =
> > -                       debugfs_create_file("ext_csd", S_IRUSR, root, card,
> > +                       debugfs_create_file("ext_csd", 0400, root, card,
> >                                              &mmc_dbg_ext_csd_fops);
> >          }
> >   }
> > diff --git a/drivers/mmc/core/bus.h b/drivers/mmc/core/bus.h
> > index cfd0d02d3420..8b69624fa46e 100644
> > --- a/drivers/mmc/core/bus.h
> > +++ b/drivers/mmc/core/bus.h
> > @@ -20,7 +20,7 @@ static ssize_t mmc_##name##_show (struct device *dev, struct device_attribute *a
> >          struct mmc_card *card = mmc_dev_to_card(dev);                           \
> >          return sysfs_emit(buf, fmt, args);                                      \
> >   }                                                                              \
> > -static DEVICE_ATTR(name, S_IRUGO, mmc_##name##_show, NULL)
> > +static DEVICE_ATTR(name, 0444, mmc_##name##_show, NULL)
> >
> >   struct mmc_card *mmc_alloc_card(struct mmc_host *host,
> >                                  const struct device_type *type);
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index 5be9b42d5057..e4b7829469ea 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -830,7 +830,7 @@ static ssize_t mmc_fwrev_show(struct device *dev,
> >                                    card->ext_csd.fwrev);
> >   }
> >
> > -static DEVICE_ATTR(fwrev, S_IRUGO, mmc_fwrev_show, NULL);
> > +static DEVICE_ATTR(fwrev, 0444, mmc_fwrev_show, NULL);
> >
> >   static ssize_t mmc_dsr_show(struct device *dev,
> >                              struct device_attribute *attr,
> > @@ -846,7 +846,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
> >                  return sysfs_emit(buf, "0x%x\n", 0x404);
> >   }
> >
> > -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> > +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
> >
> >   static struct attribute *mmc_std_attrs[] = {
> >          &dev_attr_cid.attr,
> > diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> > index 80e5d87a5e50..62b4983c1ef5 100644
> > --- a/drivers/mmc/core/mmc_test.c
> > +++ b/drivers/mmc/core/mmc_test.c
> > @@ -3218,12 +3218,12 @@ static int mmc_test_register_dbgfs_file(struct mmc_card *card)
> >
> >          mutex_lock(&mmc_test_lock);
> >
> > -       ret = __mmc_test_register_dbgfs_file(card, "test", S_IWUSR | S_IRUGO,
> > +       ret = __mmc_test_register_dbgfs_file(card, "test", 0644,
> >                  &mmc_test_fops_test);
> >          if (ret)
> >                  goto err;
> >
> > -       ret = __mmc_test_register_dbgfs_file(card, "testlist", S_IRUGO,
> > +       ret = __mmc_test_register_dbgfs_file(card, "testlist", 0444,
> >                  &mtf_testlist_fops);
> >          if (ret)
> >                  goto err;
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index ec02067f03c5..5ed6bc47f1c4 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -744,7 +744,7 @@ static ssize_t mmc_dsr_show(struct device *dev, struct device_attribute *attr,
> >          return sysfs_emit(buf, "0x%x\n", 0x404);
> >   }
> >
> > -static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> > +static DEVICE_ATTR(dsr, 0444, mmc_dsr_show, NULL);
> >
> >   MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> >   MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> > diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> > index 777342fb7657..d4a504f0aded 100644
> > --- a/drivers/mmc/host/atmel-mci.c
> > +++ b/drivers/mmc/host/atmel-mci.c
> > @@ -609,12 +609,12 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
> >          if (!root)
> >                  return;
> >
> > -       debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
> > -       debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
> > -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> > -       debugfs_create_xul("pending_events", S_IRUSR, root,
> > +       debugfs_create_file("regs", 0400, root, host, &atmci_regs_fops);
> > +       debugfs_create_file("req", 0400, root, slot, &atmci_req_fops);
> > +       debugfs_create_u32("state", 0400, root, &host->state);
> > +       debugfs_create_xul("pending_events", 0400, root,
> >                             &host->pending_events);
> > -       debugfs_create_xul("completed_events", S_IRUSR, root,
> > +       debugfs_create_xul("completed_events", 0400, root,
> >                             &host->completed_events);
> >   }
> >
> > diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> > index c691f1b60395..3174e7ac65b3 100644
> > --- a/drivers/mmc/host/davinci_mmc.c
> > +++ b/drivers/mmc/host/davinci_mmc.c
> > @@ -145,17 +145,17 @@
> >   #define MAX_NR_SG      16
> >
> >   static unsigned rw_threshold = 32;
> > -module_param(rw_threshold, uint, S_IRUGO);
> > +module_param(rw_threshold, uint, 0444);
> >   MODULE_PARM_DESC(rw_threshold,
> >                  "Read/Write threshold. Default = 32");
> >
> >   static unsigned poll_threshold = 128;
> > -module_param(poll_threshold, uint, S_IRUGO);
> > +module_param(poll_threshold, uint, 0444);
> >   MODULE_PARM_DESC(poll_threshold,
> >                   "Polling transaction size threshold. Default = 128");
> >
> >   static unsigned poll_loopcount = 32;
> > -module_param(poll_loopcount, uint, S_IRUGO);
> > +module_param(poll_loopcount, uint, 0444);
> >   MODULE_PARM_DESC(poll_loopcount,
> >                   "Maximum polling loop count. Default = 32");
> >
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index c5db92bbb094..2380ab82812a 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -175,12 +175,12 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
> >          if (!root)
> >                  return;
> >
> > -       debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
> > -       debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
> > -       debugfs_create_u32("state", S_IRUSR, root, &host->state);
> > -       debugfs_create_xul("pending_events", S_IRUSR, root,
> > +       debugfs_create_file("regs", 0400, root, host, &dw_mci_regs_fops);
> > +       debugfs_create_file("req", 0400, root, slot, &dw_mci_req_fops);
> > +       debugfs_create_u32("state", 0400, root, &host->state);
> > +       debugfs_create_xul("pending_events", 0400, root,
> >                             &host->pending_events);
> > -       debugfs_create_xul("completed_events", S_IRUSR, root,
> > +       debugfs_create_xul("completed_events", 0400, root,
> >                             &host->completed_events);
> >   #ifdef CONFIG_FAULT_INJECTION
> >          fault_create_debugfs_attr("fail_data_crc", root, &host->fail_data_crc);
> > diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> > index 52ac3f128a1c..5fc7d6d722b7 100644
> > --- a/drivers/mmc/host/omap.c
> > +++ b/drivers/mmc/host/omap.c
> > @@ -326,7 +326,7 @@ mmc_omap_show_cover_switch(struct device *dev, struct device_attribute *attr,
> >                         "closed");
> >   }
> >
> > -static DEVICE_ATTR(cover_switch, S_IRUGO, mmc_omap_show_cover_switch, NULL);
> > +static DEVICE_ATTR(cover_switch, 0444, mmc_omap_show_cover_switch, NULL);
> >
> >   static ssize_t
> >   mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
> > @@ -338,7 +338,7 @@ mmc_omap_show_slot_name(struct device *dev, struct device_attribute *attr,
> >          return sprintf(buf, "%s\n", slot->pdata->name);
> >   }
> >
> > -static DEVICE_ATTR(slot_name, S_IRUGO, mmc_omap_show_slot_name, NULL);
> > +static DEVICE_ATTR(slot_name, 0444, mmc_omap_show_slot_name, NULL);
> >
> >   static void
> >   mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> > index adc0d0b6ae37..5c679b795af1 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -747,7 +747,7 @@ omap_hsmmc_show_slot_name(struct device *dev, struct device_attribute *attr,
> >          return sprintf(buf, "%s\n", mmc_pdata(host)->name);
> >   }
> >
> > -static DEVICE_ATTR(slot_name, S_IRUGO, omap_hsmmc_show_slot_name, NULL);
> > +static DEVICE_ATTR(slot_name, 0444, omap_hsmmc_show_slot_name, NULL);
> >
> >   /*
> >    * Configure the response type and send the cmd.
> > @@ -1673,7 +1673,7 @@ DEFINE_SHOW_ATTRIBUTE(mmc_regs);
> >   static void omap_hsmmc_debugfs(struct mmc_host *mmc)
> >   {
> >          if (mmc->debugfs_root)
> > -               debugfs_create_file("regs", S_IRUSR, mmc->debugfs_root,
> > +               debugfs_create_file("regs", 0400, mmc->debugfs_root,
> >                          mmc, &mmc_regs_fops);
> >   }
> >
> > --
> > 2.39.5
> >
>
