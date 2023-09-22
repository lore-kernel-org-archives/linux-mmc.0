Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F63E7D0D8
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Sep 2023 07:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjIVHLN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Sep 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjIVHLL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Sep 2023 03:11:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB0B198
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 00:11:03 -0700 (PDT)
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DC96E41DB4
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 07:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695366660;
        bh=32y6QHnxViOsZUOoPcCiP72zawebasLjgpKpSnUSB6U=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=EonPbVMGxqAxqIDxkbZp33AITVnkrRBYQbysMpYcwDrgD8G7qFBJCKXh5RYcS0O2K
         8hDDPJziwrh1Yxs90aK9IAk4bW0lgQhQz2eVXgkjBPNLT6+GFlMNBq6MakIc0oWXPm
         Ph+vK4k+WwnX40OdM/iHzlTJt8ZEV3OTFB4+SIJsXFWIl4kQpnmVnieCDwkODSBV/y
         ejc72lvLMvwg+eocQz3gMgNIb8ohm0Oom/GNaLxGck0beXW+XvLdMSmgRMTQ8Cwkr5
         eWk3cwqaesBYrjsMRaKySlXmRURLPCZgcJ0d4nO7OZDx6qmE+8egN12tCpqf49Pt6X
         qyLEnEO/iNWqA==
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-277118dab4dso222170a91.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Sep 2023 00:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695366656; x=1695971456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32y6QHnxViOsZUOoPcCiP72zawebasLjgpKpSnUSB6U=;
        b=w81rN5h3bgRxaC8QnDqQJIXVSMrMnWN/BDhX2F7hLITD4h3+KwmjtM1MKNaLfWohh5
         n20NcVhG26/FED6RkLaQtnNelfMu/T+Z73mviL8zEhXCmfrLO0LEQzuMeM6FsKWMlEkC
         EPgd4D52MK1nYWo4j45arVnwACAz/6qQSwzPaIS9OCHE/AOs9u7mvqjmHq8GLmVDOT66
         OeYFdH9KB1Mtsz9rRuoVlOYtA1Lw0UZ4vGqm/Zcm4zZsMDaZWUXapaK5nBzD75nfMJyP
         mpDiYrvpz1HeI2Nnl/pDXLxd6c1w5m3KBpuPmLNQTmPHVZm1bKOd87d4zyvcfrqXG90Y
         hFLg==
X-Gm-Message-State: AOJu0YwvsoR39HBCcQl5nYcfUoo6UTJ10/U68+UZqFPk8P/hyGSjqEAT
        h2Jd/5myZUd7tVvirAixfPdBGxXQ7p/Xehxvk292wpRaIXm11MDwFTPvg/iBH3ZLZlBuQdboUNB
        OZq06SrV8Gy0Q5f14hH/bFQ9S83HDOqNjG0MB+Tyb0ZoyKsIEKRd3Wg==
X-Received: by 2002:a17:90b:1018:b0:274:84e4:4ef8 with SMTP id gm24-20020a17090b101800b0027484e44ef8mr8134172pjb.32.1695366655860;
        Fri, 22 Sep 2023 00:10:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGod7CcERn2eMZR/UVTGo78WSbu0rFiusPo9zXcqFuZ4I5paN2ltrtP4yo1wndlXn4mtKrdxLetX9V84XrL8uw=
X-Received: by 2002:a17:90b:1018:b0:274:84e4:4ef8 with SMTP id
 gm24-20020a17090b101800b0027484e44ef8mr8134161pjb.32.1695366655510; Fri, 22
 Sep 2023 00:10:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com> <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
In-Reply-To: <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Fri, 22 Sep 2023 15:10:42 +0800
Message-ID: <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
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

On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Hi Victor,
> > > >
> > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > > >
> > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > >
> > > > > Due to a flaw in the hardware design, the GL975x replay timer fre=
quently
> > > > > times out when ASPM is enabled. As a result, the system will resu=
me
> > > > > immediately when it enters suspend. Therefore, the replay timer
> > > > > timeout must be masked.
> > > >
> > > > This patch solves AER error when its PCI config gets accessed, but =
the
> > > > AER still happens at system suspend:
> > > >
> > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received=
:
> > > > 0000:00:1c.0
> > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
> > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
> > > > status/mask=3D00001000/00002000
> > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > >
> > > > Kai-Heng
> > > >
> > >
> > > Hi, Kai-Heng
> > >
> > > Could you try applying the patch and re-testing again after restartin=
g
> > > the system?
> >
> > Same issue happens after coldboot.
> >
> > > Because I applied the patch and restarted the system and it didn't ha=
ppen.
> > > The system can enter suspend normally.
> > >
> > > If you still have the issue after following the above instructions,
> > > please provide me with your environment and I will verify it again.
> >
> > The patch gets applied on top of next-20230918. Please let me know
> > what else you want to know.
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> If I want to mask the replay timer timeout AER of the upper layer root po=
rt,
> could you give me some suggestions?
> Or could you provide sample code for my reference?

I am not aware of anyway to mask "replay timer timeout" from root port.
I wonder if the device supoprt D3hot? Or should it stay at D0 when
ASPM L1.2 is enabled?

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Thanks, Victor Shih
> > >
> > > > >
> > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > ---
> > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/=
sdhci-pci-gli.c
> > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > @@ -28,6 +28,9 @@
> > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > >
> > > > > +#define PCI_GLI_9750_CORRERR_MASK                              0=
x214
> > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT        =
 BIT(12)
> > > > > +
> > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > @@ -152,6 +155,9 @@
> > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > >
> > > > > +#define PCI_GLI_9755_CORRERR_MASK                              0=
x214
> > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT        =
 BIT(12)
> > > > > +
> > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
> > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
> > > > >
> > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_h=
ost *host)
> > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value)=
;
> > > > >
> > > > > +       /* mask the replay timer timeout of AER */
> > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &v=
alue);
> > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
;
> > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, v=
alue);
> > > > > +
> > > > >         gl9750_wt_off(host);
> > > > >  }
> > > > >
> > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_p=
ci_slot *slot)
> > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value)=
;
> > > > >
> > > > > +       /* mask the replay timer timeout of AER */
> > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &v=
alue);
> > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
;
> > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, v=
alue);
> > > > > +
> > > > >         gl9755_wt_off(pdev);
> > > > >  }
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
