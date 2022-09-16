Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438D1ECAAD8
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Sep 2022 17:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIPR6z (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Sep 2022 13:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIPR6y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Sep 2022 13:58:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DDA6C77
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 10:58:53 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l14so51209441eja.7
        for <linux-mmc@vger.kernel.org>; Fri, 16 Sep 2022 10:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zd/o9M8DI6uCrxhdOmsIDeIBqPxRjAyKBLA8DBswRu4=;
        b=m90z0oUISdCEVrhjQ9uxUANR3NM+rrTnamL16T2Nn3vpLe8WXEL5NAp9AqZl3J8vn3
         O1bpIw1FDkyRbTfK3j31cJfLWEUs8sjFb6PpwBZNdO8ZdCnnCBOMYLvGkwaiS+jSe0yh
         LITIPcmoQS+/LNf6Lmk5/rkBj/Av0e9+yhuhi6wIOH04IRjfPAZnrBkEo5esTJ+nFUq8
         CoG5N3mYBX7CpdlAG3aRZKeoyPvu3UUiNwtWBc68j19ZR8uAOMN5UuxUiVXtvvgdqp9d
         ju1FyVwDb+4eFmf7i+v3y4zmgTNKp6u/69gro38QCm3jEeL2rpi11snDAX9wOz2FlVSK
         sD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zd/o9M8DI6uCrxhdOmsIDeIBqPxRjAyKBLA8DBswRu4=;
        b=Aw3jqhmAeD3T/ztHMlD2MNROIXg+6HZnyOcpAJpamqUwPo+kP5Kv6LPMtNJX4+cMsX
         sAItsCpbuJp97eBLTJQwbq93B/rCGRWozZMVNmjMszZZ7KFsp5al7YL21WB+3y+odrvo
         qKYd3Jnum0aU02db24MJjiEYWE9SvEIpD6mRkwW+ftiy4KILgVQjpEp5wgkHdM//AiaG
         w05YTtsHP9iqgclhrRmxdPkY17wvDOK4SbUZsHVGk5lvAR+HehPe0sR5xyoKFUYKDJAx
         PxYORYjCgvrl1ojUgXX9lWw/pg6/xqh1mRwjQ4k5vDY30KYiF6aF5O6SWuEDc3hCnvWb
         T0CA==
X-Gm-Message-State: ACrzQf12beUATpDms8L/hlXeKnGCghb+ajPtWvXRe936CoiV3HGZZ3PX
        gRTvi4qsfnCsnPlj0AZ4IQxXWwLq4ajeN85IQXyTP8nEPKf5MA==
X-Google-Smtp-Source: AMsMyM69Euu4DOD30Wd1AHTVKT487yinq2VcXobq8TR0kzMsZGA+ymFgkuKfAvxrsz9WGg22sPg7VqALnRIfWZ//76g=
X-Received: by 2002:a17:907:3f26:b0:77c:2508:3c08 with SMTP id
 hq38-20020a1709073f2600b0077c25083c08mr4403073ejc.532.1663351131443; Fri, 16
 Sep 2022 10:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220912212847.1337868-1-ptf@google.com> <925b6e37-051f-927c-350a-cd767d88d72b@intel.com>
In-Reply-To: <925b6e37-051f-927c-350a-cd767d88d72b@intel.com>
From:   Patrick Thompson <ptf@google.com>
Date:   Fri, 16 Sep 2022 13:58:40 -0400
Message-ID: <CAJs+hrEiMP1hxZ06rnHWeUbvsau5C3D3aScSTmU4tEwvQ8Zm5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-core: Disable cqe for ASUS 1100FK family devices
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linux MMC development <linux-mmc@vger.kernel.org>,
        Sangwhan Moon <sxm@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi again,

I made a mistake while testing this patch, please do not merge it as
it does not fix any issues. We will send out a v2 patch shortly.

Thanks,
Patrick


On Tue, Sep 13, 2022 at 2:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 13/09/22 00:28, Patrick Thompson wrote:
> > From: ptf <ptf@google.com>
> >
> > The CQE implementation for the eMMC in the ASUS 1100FK family of devices
> > is broken. This causes installations to fail and thus we are disabling
> > CQE for this family of devices.
> >
> > Signed-off-by: Patrick Thompson <ptf@google.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> > ---
> >
> > Hello,
> >
> > I was hoping to get some advice on adapting this patch to target the
> > eMMC directly instead of a family of laptops. One idea is to use the
> > PCI-id of the controller (in this case [8086:4dc4]). Would that make
> > sense? Is there someone with more knowledge on the subject that could
> > confirm that the [8086:4dc4] device doesn't have a working CQE?
>
> In these cases the issue is suspected to be BIOS. Best solution is to
> disable CQE.
>
> >
> > Thank you,
> > Patrick
> >
> >
> >  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 622b7de96c7f..3ba0250559e7 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -890,7 +890,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
> >  {
> >       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_GLK_EMMC &&
> >              (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> > -             dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> > +             dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> > +             dmi_match(DMI_PRODUCT_FAMILY, "ASUS BR1100FKA"));
> >  }
> >
> >  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>
