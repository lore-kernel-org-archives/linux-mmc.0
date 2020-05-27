Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63419C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 08:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E42620DD4
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 08:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590566415;
	bh=d9TUiQiemJivlD8ZQRk3IQzpz+r7I3SSsNJzQqkYqWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nFxUeoi+zvfm7f8gC6oKQiZsyAQJ4lVbe0P3s2BO3NlspRIzUMfY2IvlQLDM+Yoyx
	 uPbxx62XQ2ue6i2nquto7ByIhVr4JjsGajfnMto2IH0We/GoNOVY+DU/eeuZpkyDDU
	 gZUD8ZJsUnMa+OEYe04PuUo//0VCa3jqdVK1e5po=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgE0IAL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 04:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729102AbgE0IAL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 27 May 2020 04:00:11 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FD120C56;
        Wed, 27 May 2020 08:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590566410;
        bh=d9TUiQiemJivlD8ZQRk3IQzpz+r7I3SSsNJzQqkYqWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9M4Kzff6ihvz7BuTtJLymGlAGY31k3nyVjk9fYaQCgJ6vNLBDRwfWUzmvH7GuxrD
         k2WL7krwHXnDStI2CVqQ5+5QZ9fYZ7kdSUmzF6v0wb8AB4CyzcpHwZ4OWQ42qbuS+Q
         Rl4bCbf5uiIe7rVn3Jbysqa+5a2WDfwEQe1lo1QA=
Received: by pali.im (Postfix)
        id 0E40BBF4; Wed, 27 May 2020 10:00:07 +0200 (CEST)
Date:   Wed, 27 May 2020 10:00:07 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>
Subject: Re: [PATCH 2/2] mmc: core: Export device/vendor ids from Common CIS
 for SDIO cards
Message-ID: <20200527080007.gtd7w7fzwfrk4pef@pali>
References: <20200526154334.21222-1-pali@kernel.org>
 <20200526154334.21222-2-pali@kernel.org>
 <CAPDyKFq4KxT+m6nZbi9fM0Pf=JYkT7TTfERDxtUVX5qAiLAQBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPDyKFq4KxT+m6nZbi9fM0Pf=JYkT7TTfERDxtUVX5qAiLAQBQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wednesday 27 May 2020 09:39:50 Ulf Hansson wrote:
> On Tue, 26 May 2020 at 17:43, Pali Rohár <pali@kernel.org> wrote:
> >
> > Device/vendor ids from Common CIS (Card Information Structure) may be
> > different as device/vendor ids from CIS on particular SDIO function.
> >
> > Export these "main" device/vendor ids for SDIO and SD combo cards at top
> > level mmc device in sysfs so userspace can do better identification of
> > connected SDIO and SD combo cards.
> 
> What would userspace do with this information, more exactly?

Userspace can e.g. write udev rules based on Common CIS vendor/device
id. Or can exactly identify SDIO card by CIS vendor/device id. Also it
can be suitable for "lssdio" tool to print all information about SDIO
card.

Currently I do not know any way how userspace can retrieve these ids for
particular SDIO card. And correct identification is important.

Other important thing is that kernel on some places (e.g. mmc quirks)
uses Common CIS vendor/device id and on other places (e.g. binding
drivers) it uses SDIO function device/vendor ids.

So for debugging and developing kernel drivers it is needed to know
correct Common CIS vendor/device id and SDIO functions vendor/device
ids.

> Isn't it just sufficient to give events per SDIO func, as we already
> do in sdio_bus_uevent()?

No because some SDIO cards have different Common CIS vendor/device id
and different vendor/device ids for particular SDIO functions.

Common CIS vendor/device id is the "main" identification of SDIO card,
functions vendor/device ids just identify one of those functions.

For example look at my patch "mmc: sdio: Fix macro name for Marvell
device with ID 0x9134" [1]. Without knowing correct CIS vendor/device id
I was not able to fully understand problem and mess with names and ids.
Because mmc quirks list uses CIS vendor/device ids (I guess for obvious
reason as SDIO functions are not enumerated yet).

[1] - https://lore.kernel.org/linux-mmc/20200522144412.19712-2-pali@kernel.org/

> Kind regards
> Uffe
> 
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <marek.behun@nic.cz>
> > ---
> >  drivers/mmc/core/bus.c  |  7 +++++++
> >  drivers/mmc/core/sd.c   | 26 +++++++++++++++++++++++++-
> >  drivers/mmc/core/sdio.c | 20 +++++++++++++++++++-
> >  3 files changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> > index 103eea7cd..5d4b28b29 100644
> > --- a/drivers/mmc/core/bus.c
> > +++ b/drivers/mmc/core/bus.c
> > @@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >                         return retval;
> >         }
> >
> > +       if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
> > +               retval = add_uevent_var(env, "SDIO_ID=%04X:%04X",
> > +                                       card->cis.vendor, card->cis.device);
> > +               if (retval)
> > +                       return retval;
> > +       }
> > +
> >         if (card->type != MMC_TYPE_SDIO) {
> >                 retval = add_uevent_var(env, "MMC_NAME=%s", mmc_card_name(card));
> >                 if (retval)
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index 76c7add36..ee1a51ff6 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -707,7 +707,12 @@ static ssize_t mmc_dsr_show(struct device *dev,
> >
> >  static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
> >
> > +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> > +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> > +
> >  static struct attribute *sd_std_attrs[] = {
> > +       &dev_attr_vendor.attr,
> > +       &dev_attr_device.attr,
> >         &dev_attr_cid.attr,
> >         &dev_attr_csd.attr,
> >         &dev_attr_scr.attr,
> > @@ -726,7 +731,26 @@ static struct attribute *sd_std_attrs[] = {
> >         &dev_attr_dsr.attr,
> >         NULL,
> >  };
> > -ATTRIBUTE_GROUPS(sd_std);
> > +
> > +static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute *attr,
> > +                                int index)
> > +{
> > +       struct device *dev = container_of(kobj, struct device, kobj);
> > +       struct mmc_card *card = mmc_dev_to_card(dev);
> > +
> > +       /* CIS vendor and device ids are available only for Combo cards */
> > +       if ((attr == &dev_attr_vendor.attr || attr == &dev_attr_device.attr) &&
> > +           card->type != MMC_TYPE_SD_COMBO)
> > +               return 0;
> > +
> > +       return attr->mode;
> > +}
> > +
> > +static const struct attribute_group sd_std_group = {
> > +       .attrs = sd_std_attrs,
> > +       .is_visible = sd_std_is_visible,
> > +};
> > +__ATTRIBUTE_GROUPS(sd_std);
> >
> >  struct device_type sd_type = {
> >         .groups = sd_std_groups,
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index ebb387aa5..d708e0fbc 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -27,6 +27,24 @@
> >  #include "sdio_ops.h"
> >  #include "sdio_cis.h"
> >
> > +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> > +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> > +MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> > +MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
> > +
> > +static struct attribute *sdio_std_attrs[] = {
> > +       &dev_attr_vendor.attr,
> > +       &dev_attr_device.attr,
> > +       &dev_attr_ocr.attr,
> > +       &dev_attr_rca.attr,
> > +       NULL,
> > +};
> > +ATTRIBUTE_GROUPS(sdio_std);
> > +
> > +struct device_type sdio_type = {
> > +       .groups = sdio_std_groups,
> > +};
> > +
> >  static int sdio_read_fbr(struct sdio_func *func)
> >  {
> >         int ret;
> > @@ -598,7 +616,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
> >         /*
> >          * Allocate card structure.
> >          */
> > -       card = mmc_alloc_card(host, NULL);
> > +       card = mmc_alloc_card(host, &sdio_type);
> >         if (IS_ERR(card)) {
> >                 err = PTR_ERR(card);
> >                 goto err;
> > --
> > 2.20.1
> >
