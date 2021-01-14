Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4252AC433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3AB221E2
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 09:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbhANJOh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 04:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbhANJOW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 04:14:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D6C061795
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 01:13:41 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id m13so5586854ljo.11
        for <linux-mmc@vger.kernel.org>; Thu, 14 Jan 2021 01:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdctETf80LWjU6yJ+2AwRyQgEwX7yPhocsVpx0q/Gaw=;
        b=Welez8l5oKcIq/HqjL0V12xIb/B4MRaJynM2PZotiGt9Q6bUXGy/SJFygsI3NcrZ2v
         y69l16E8WhxcA52pS0acwNrVMTvOIo0NweVT67sdvRgXlBGtPczOteef2YkGB7rM5cZq
         fLA1nZcrOS9dmKzBkjrFJ+La1B41o+pIdv2YQnF9hiHT0cvS3CAoRY5JbQ6UkhRj1PMw
         idmXN3f8cuG/tk9LveG/hOSQpiMylh5NyUMlW8r1qe+atx72OoM+oDcckW+V+YJAmAHf
         7g7erDJzlbWA5Ypl/skub4LlQhogpoSEA3QC/ggU6F25x/lJsGWkKj6wBkQg/WR45MEW
         usKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdctETf80LWjU6yJ+2AwRyQgEwX7yPhocsVpx0q/Gaw=;
        b=sZjt5j1LubKK4mYDVUm31hMYPmEhXcXxk1cH0ef07eRCmiVJ+SBiYhv5o8s6UwE0a8
         g08bcAd6ovfqBttsLb5iwWVYv05q3ZgYLo501pEcswVlONJVRSKRgIb3WlLm6W/ytz/Z
         ZaUFLdDtgn4xRukUdoAEXU2XS6WsKsJp5sLKiDuf8iHgOIAapKf0U0Cr+5vi1Lrdar0J
         LBRkXGN+KDbmvvnTWSSg9VkfTXDXo2pMTS2HFmF6vKWYk83Em3CHw7FKuZLf6LrIjYou
         rcZaJYiMJZVwWrg6F1wlFOnhM5JSwnUZhqeO3JQ3zIwCF2FDXB6EaQ7KVKZ2/1JVYe4v
         6dNQ==
X-Gm-Message-State: AOAM530qnXx2useVKR9sn90vcW8CQ8W7Vyu8s6ZoeWZWFZhFSsycVDEm
        F9PHHN+7JJv3qyxqD0R1/F0Np5gtgBMYOn7hfYgArg==
X-Google-Smtp-Source: ABdhPJzmBdNjASOcvMQWZppTC5PU5/rTE3C69C6JfPEwy8BDM3wXmu7aJ4VP3DCZGiJ/dYAc1w0uXNmd1qAtpSlllng=
X-Received: by 2002:a2e:878a:: with SMTP id n10mr2726581lji.236.1610615619691;
 Thu, 14 Jan 2021 01:13:39 -0800 (PST)
MIME-Version: 1.0
References: <CANqTbdb4gZYQUAZzatwymy-S9Ajb=PhfP53_D2TYLJp0zw4HxQ@mail.gmail.com>
 <20210113205434.GA1926338@bjorn-Precision-5520>
In-Reply-To: <20210113205434.GA1926338@bjorn-Precision-5520>
From:   Victor Ding <victording@google.com>
Date:   Thu, 14 Jan 2021 20:13:03 +1100
Message-ID: <CANqTbdb7iHdKtXv2H5Qrj+C52u1e1mL-QRE5x+vqYQ4NjmAf1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Disable ASPM until its LTR and L1ss state
 is restored
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        linux-mmc@vger.kernel.org, Alex Levin <levinale@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sukumar Ghorai <sukumar.ghorai@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 14, 2021 at 7:54 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Wed, Jan 13, 2021 at 01:16:05PM +1100, Victor Ding wrote:
> > On Wed, Jan 13, 2021 at 9:32 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Tue, Jan 12, 2021 at 04:02:04AM +0000, Victor Ding wrote:
> > > > Right after powering up, the device may have ASPM enabled; however,
> > > > its LTR and/or L1ss controls may not be in the desired states; hence,
> > > > the device may enter L1.2 undesirably and cause resume performance
> > > > penalty. This is especially problematic if ASPM related control
> > > > registers are modified before a suspension.
> > >
> > > s/L1ss/L1SS/ (several occurrences) to match existing usage.
> > >
> > I'll update it in the next version.
> > >
> > > > Therefore, ASPM should disabled until its LTR and L1ss states are
> > > > fully restored.
> > > >
> > > > Signed-off-by: Victor Ding <victording@google.com>
> > > > ---
> > > >
> > > >  drivers/pci/pci.c       | 11 +++++++++++
> > > >  drivers/pci/pci.h       |  2 ++
> > > >  drivers/pci/pcie/aspm.c |  2 +-
> > > >  3 files changed, 14 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index eb323af34f1e..428de433f2e6 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -1660,6 +1660,17 @@ void pci_restore_state(struct pci_dev *dev)
> > > >       if (!dev->state_saved)
> > > >               return;
> > > >
> > > > +     /*
> > > > +      * Right after powering up, the device may have ASPM enabled;
> > >
> > > I think this could be stated more precisely.  "Right after powering
> > > up," ASPM should be *disabled* because ASPM Control in the Link
> > > Control register powers up as zero (disabled).
> > >
> > Good suggestion; I'll reword in the next version.
> > However, ASPM should be *disabled* for the opposite reason - ASPM Control
> > in the Link Control register *may* power as non-zero (enabled).
> > (More answered in the next section)
> > >
> > > > +      * however, its LTR and/or L1ss controls may not be in the desired
> > > > +      * states; as a result, the device may enter L1.2 undesirably and
> > > > +      * cause resume performance penalty.
> > > > +      * Therefore, ASPM is disabled until its LTR and L1ss states are
> > > > +      * fully restored.
> > > > +      * (enabling ASPM is part of pci_restore_pcie_state)
> > >
> > > If we're enabling L1.2 before LTR has been configured, that's
> > > definitely a bug.  But I don't see how that happens.  The current code
> > > looks like:
> > >
> > >   pci_restore_state
> > >     pci_restore_ltr_state
> > >       pci_write_config_word(dev, ltr + PCI_LTR_MAX_SNOOP_LAT, *cap++)
> > >       pci_write_config_word(dev, ltr + PCI_LTR_MAX_NOSNOOP_LAT, *cap++)
> > >     pci_restore_aspm_l1ss_state
> > >       pci_write_config_dword(dev, aspm_l1ss + PCI_L1SS_CTL1, *cap++)
> > >     pci_restore_pcie_state
> > >       pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++])
> > >
> > > We *do* restore PCI_L1SS_CTL1, which contains "ASPM L1.2 Enable",
> > > before we restore PCI_EXP_LNKCTL, which contains "ASPM Control", but I
> > > don't think "ASPM L1.2 Enable" by itself should be enough to allow
> > > hardware to enter L1.2.
> > >
> > > Reading PCIe r5.0, sec 5.5.1, it seems like hardware should ignore the
> > > PCI_L1SS_CTL1 bits unless ASPM L1 entry is enabled in PCI_EXP_LNKCTL.
> > >
> > > What am I missing?
> > >
> > Correct; however, PCI_EXP_LNKCTL may power up as non-zero, i.e. has
> > ASPM Control enabled. BIOS may set PCI_EXP_LNKCTL (and
> > PCI_L1SS_CTL1) before Kernel takes control. When BIOS does so, there
> > is a brief period between powering up and Kernel restoring LTR state
> > that L1.2 is enabled but LTR isn't configured.
>
> IIUC you're saying that ASPM Control powers up as zero, but BIOS
> enables ASPM before transferring control to the OS.  That makes sense,
> but I wouldn't describe that as "the device powering up with ASPM
> enabled."
>
Correct.
>
> If BIOS enables L1SS (specifically, if it enables L1.2) when LTR
> hasn't been configured, that sounds like a BIOS defect.
>
Very good point. I'll withdraw this patch then.
