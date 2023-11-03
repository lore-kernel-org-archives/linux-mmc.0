Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1857FC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  3 Nov 2023 10:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjKCK3G (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 3 Nov 2023 06:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjKCK3F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Nov 2023 06:29:05 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F13D7
        for <linux-mmc@vger.kernel.org>; Fri,  3 Nov 2023 03:29:00 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso261566276.3
        for <linux-mmc@vger.kernel.org>; Fri, 03 Nov 2023 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699007339; x=1699612139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHXSWJ2cpn8cbZ9gOeRdIq5F7XsE7dwhucIAWozFSUU=;
        b=TvQJT42VYil5NZWpICSmb3Lk1wJ+2GwraTIF/AM1C0Shu2KZ9qORFHTHVPtLAG15mV
         tppqlkMiZlPgPglT3uyU5O9NrhxXTJO7GFUSKreTa59jXiq0LEcPTKBIXzOzNVTv1TAN
         fjUH/AhFPxVCJCz525dEZEOFYCj1Y4snX/s4/TW7CPcaMe9CmTrZ8OC7oe9xLFEk/q1v
         FCOVqAv2pE+OVNcpKal2P6sTcfhWXavdWWLFj/Sjl0BhXIjRGNnWnzqNzuTs7z8avG3M
         YZpWI01bfoGdZnm9kbBVaJhzCSojyrqnH9Lxbo2RdWABvNHgfgDrFwqmHMCy1Qp/0T5W
         HuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699007339; x=1699612139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHXSWJ2cpn8cbZ9gOeRdIq5F7XsE7dwhucIAWozFSUU=;
        b=jz0A80t46azmFZrMMUEyUyk6HbKBaj2eGzBNL28O7PL5DnsLCshNkpjnFdi/kRCSDr
         aPy8MFUtZRmJ8ezkAvYOSGussJ0e3WYD9J3PQQsLROlwfi+inakQjGNhD8+ZxbbAN5P2
         48kksl5g1uKVMwYkNQz2fizySibQpR6zQ0mXBPJhLVUAA7Mgv/Dj6jKJcWIWnp3EZa+X
         YyfuuOw/MSVfqXDGNy1QvSJoPv20CqY2+SE5+PGPNLU4Tq267VDRhXDf6gfMYL+tDnut
         KAv/T4k3sWIf/j9JxBTS0y+pWYIqP5JvpGorWKB5qI91iB9kR8V6urboJxtS4qGOQzAu
         CLTg==
X-Gm-Message-State: AOJu0YyvcJKy7RoHcMu7Ego4rYU6dAJW5xaDpyD3dtqCb7btNI3uR1aj
        vkWWwtOXZ4+twoRm83cKSrFkLovnDdCL1t7eZPQgSBTNj5L4Xvsi
X-Google-Smtp-Source: AGHT+IG+qA+WjvhaxYbyxoaQOIdfycGjz1OtLLPJrf8itwFWPzAwlic+zj3WhYYmZIE06mrYDmjSJlUQHnmzuObqD60=
X-Received: by 2002:a25:d80f:0:b0:da0:c581:6663 with SMTP id
 p15-20020a25d80f000000b00da0c5816663mr21968266ybg.28.1699007339179; Fri, 03
 Nov 2023 03:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com> <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com>
In-Reply-To: <CAK00qKBH5P3naXUHhbQ3zgMzQrUxy=v8r84a8RCcdNORVoRPkA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 11:28:22 +0100
Message-ID: <CAPDyKFob14Tc4c0UxRfj2qbXJkDn7NRwNwRuYQ6m9t3c27Kp=Q@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        SeanHY.Chen@genesyslogic.com.tw, kai.heng.feng@canonical.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 3 Nov 2023 at 11:13, Victor Shih <victorshihgli@gmail.com> wrote:
>
> Hi, Ulf
>
> Please help review this patch and give me some advice.
> I look forward to your reply.
>
> Thanks, Victor Shih

I don't have in-depth knowledge of how to properly solve this for pci,
so I am relying on Kai and others to help review.

>
> On Wed, Oct 18, 2023 at 6:33=E2=80=AFPM Victor Shih <victorshihgli@gmail.=
com> wrote:
> >
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Due to a flaw in the hardware design, the GL975x replay timer frequentl=
y
> > times out when ASPM is enabled. As a result, the warning messages that =
will
> > often appear in the system log when the system accesses the GL975x
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

The code looks good to me, but let's allow Kai to get some time to
come back to this before I apply it.

Kind regards
Uffe

> > ---
> >
> > Updates in V2:
> >  - Modify the commit message.
> >
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index d83261e857a5..d8a991b349a8 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -28,6 +28,9 @@
> >  #define PCI_GLI_9750_PM_CTRL   0xFC
> >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> >
> > +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(1=
2)
> > +
> >  #define SDHCI_GLI_9750_CFG2          0x848
> >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > @@ -152,6 +155,9 @@
> >  #define PCI_GLI_9755_PM_CTRL     0xFC
> >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> >
> > +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(1=
2)
> > +
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> >
> > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >         value &=3D ~PCI_GLI_9750_PM_STATE;
> >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> >
> > +       /* mask the replay timer timeout of AER */
> > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> > +
> >         gl9750_wt_off(host);
> >  }
> >
> > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >         value &=3D ~PCI_GLI_9755_PM_STATE;
> >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> >
> > +       /* mask the replay timer timeout of AER */
> > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> > +
> >         gl9755_wt_off(pdev);
> >  }
> >
> > --
> > 2.25.1
> >
