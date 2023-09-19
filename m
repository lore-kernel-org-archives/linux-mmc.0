Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DAEDE989
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Sep 2023 07:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjISHbk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Sep 2023 03:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjISHbk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Sep 2023 03:31:40 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3318114
        for <linux-mmc@vger.kernel.org>; Tue, 19 Sep 2023 00:31:33 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 498A03F133
        for <linux-mmc@vger.kernel.org>; Tue, 19 Sep 2023 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695108691;
        bh=94LEV8sxRamBwf5ruZOpVUO6tcRznlSXV04hW3XWcFM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ZnCsI1AbjmEpkpDQLNE0a8v1x2EgDByQ0IBdZeV9SigoVk4YZKXERqNiDm3Aw28GJ
         HOsMRgu8mlR2qzIb8TEI+6Dby6jc5TIavmCdezDQxjc80nYtGoTvVo+d0qyTOcIiKr
         VXzoq5iHdMy+Oc0A0QjFL5izeBICRqS0JuJwcL/h2aoqqapgXjsu/7az9w7BJsM5CZ
         i7A0p0cINT63upvbri+xE6z3VeVEXhwdkB7iGc0iM9Q/+a26ls/ToP3aFKrSZ0sTfP
         2y+ZXNeHhOKuSRiminlbY7QZmEqW7rX8doiPXah3m0XmQPYB1X0iXg35NuoVkSZ9Gn
         0pEjcYMSssF8w==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-68fb0b81151so5930246b3a.1
        for <linux-mmc@vger.kernel.org>; Tue, 19 Sep 2023 00:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695108690; x=1695713490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94LEV8sxRamBwf5ruZOpVUO6tcRznlSXV04hW3XWcFM=;
        b=Ks0yYIW0kmN5GQH6k1OXDS/DTMLoyslopl1xQhhufga982BCpaQYUvCLBNSb4uqRwh
         YJJHtf//Nni9zRUjjfDkfxFm1x9VPx9D1hgcbfDB7Wi2tdB+C1GJUJH0wit/xE7Ft+Tv
         K426EbzZxAlkjSpdnWf8S+irGy3Xaf77ok7hwozGby1BFqVL/G98niaXK06ODbcV8gji
         LUXvXSMGJs6hITjuh+AuoKC7ZGQWx4LElx+8MAZF934W/UsFIn3Q9NwXR4xLLRrs1my7
         1hl6hD9910LrhR9x0RnMqqtCLt7qjEy2a5BuNhH0WjzD8iLp+3wHuhsBNZT37dzsz97N
         yQxw==
X-Gm-Message-State: AOJu0YyvZOBviwFYNLkoD4jVQRQY4mInZd0KU1OVIYUWsHvsOIm294v8
        6pTbW8fRuS2mCoTeKBOHOYCPd6uK0gTg1DLt/yQWk2O7XgJRW2SjHiYuY8gtGp+zx5AHFHVE1Vf
        syIbwXkI6HdEr4tQdnHjodtBGKW+PV6KYH545n8KoreZcq5dzc/r5qw==
X-Received: by 2002:a05:6a20:3d83:b0:154:a579:b0ff with SMTP id s3-20020a056a203d8300b00154a579b0ffmr16062464pzi.19.1695108689950;
        Tue, 19 Sep 2023 00:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0EAwF9oz7bRlARRsntNHNxq3AvpLMEzLX23ZxAs9aXP+tFyCsPmoWrkzvt80juB1lJbxZxpioLXTA6+OBUbw=
X-Received: by 2002:a05:6a20:3d83:b0:154:a579:b0ff with SMTP id
 s3-20020a056a203d8300b00154a579b0ffmr16062442pzi.19.1695108689656; Tue, 19
 Sep 2023 00:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com> <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
In-Reply-To: <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 15:31:16 +0800
Message-ID: <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     ulf.hansson@linaro.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, kangzhen.lou@dell.com,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Victor,

On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > >
> > > Due to a flaw in the hardware design, the GL975x replay timer frequen=
tly
> > > times out when ASPM is enabled. As a result, the system will resume
> > > immediately when it enters suspend. Therefore, the replay timer
> > > timeout must be masked.
> >
> > This patch solves AER error when its PCI config gets accessed, but the
> > AER still happens at system suspend:
> >
> > [ 1100.103603] ACPI: EC: interrupt blocked
> > [ 1100.268244] ACPI: EC: interrupt unblocked
> > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
> > 0000:00:1c.0
> > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > status/mask=3D00001000/00002000
> > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> Could you try applying the patch and re-testing again after restarting
> the system?

Same issue happens after coldboot.

> Because I applied the patch and restarted the system and it didn't happen=
.
> The system can enter suspend normally.
>
> If you still have the issue after following the above instructions,
> please provide me with your environment and I will verify it again.

The patch gets applied on top of next-20230918. Please let me know
what else you want to know.

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > ---
> > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhc=
i-pci-gli.c
> > > index d83261e857a5..d8a991b349a8 100644
> > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > @@ -28,6 +28,9 @@
> > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > >
> > > +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT=
(12)
> > > +
> > >  #define SDHCI_GLI_9750_CFG2          0x848
> > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > @@ -152,6 +155,9 @@
> > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > >
> > > +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT=
(12)
> > > +
> > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> > >
> > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host =
*host)
> > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> > >
> > > +       /* mask the replay timer timeout of AER */
> > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value=
);
> > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value=
);
> > > +
> > >         gl9750_wt_off(host);
> > >  }
> > >
> > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_s=
lot *slot)
> > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> > >
> > > +       /* mask the replay timer timeout of AER */
> > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value=
);
> > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value=
);
> > > +
> > >         gl9755_wt_off(pdev);
> > >  }
> > >
> > > --
> > > 2.25.1
> > >
