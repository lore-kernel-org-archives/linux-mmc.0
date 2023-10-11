Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E18CD98F3
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Oct 2023 06:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbjJKGfC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Oct 2023 02:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbjJKGfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Oct 2023 02:35:01 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29C798
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 23:34:59 -0700 (PDT)
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 28BFC40342
        for <linux-mmc@vger.kernel.org>; Wed, 11 Oct 2023 06:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1697006096;
        bh=UMKdS5SnMMrOpMCMYwNeeTyyHh/lJY0Na/By5DR8NHA=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=txPxfoA0mJinslGNZcMWFjN/OmGrLodif954kfpKRo/n5ihbtMjOU1wHm7TJR3E7f
         lQ5kPawwxDIDXGZBA4Do45K9X2nB7L3dxTeIUx4CECno37qRXk4fkBUT3rPpHJ8t24
         nnHysFghGo92w6epZcm+pJyx0znfzjEfMUAgKfyta5bPyQhcXFCl1QBAtxHK5+BGup
         R5khfwIWRTWSdYiahF3I5Ikz5Jb5MkeuUdC3GlC4a8lHNjVw7fFMpebUfwOKZPParZ
         64VoO6CumlY7EYn1SkyuaPG4s6lX3M2BXtrSN6jf26fEusGQaxO5IUDk0YzSiSvM9Q
         wquuphrh7cDNw==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-27cc62af393so2360287a91.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Oct 2023 23:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697006092; x=1697610892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UMKdS5SnMMrOpMCMYwNeeTyyHh/lJY0Na/By5DR8NHA=;
        b=RP2UDwfJYa9aSLdx/zsRb0oXBIIxDmnSflSbkoUJNq/MF6edn5OpOEAj4SPdww/Zv6
         a0ZtoaJo/J2n3DaTVMxy5YuQ4hgUvoQSZUkBPssj+tz+6F+Iduuf8LSOygs72c/PmuBT
         Our+eKwubOXwvhlm+Vsj5/XC24Ny+22IK6uiWqYI7TXomioGjZK3EYRnafbhenQ3jodc
         AJ068qcJWHPfyxKXKkG7t6gh4eFsvaEKVuR84T3iSOeTZ5FFvYc0GXQm5c48KC5iXTjK
         WwYPdO4nezXTmmcdgW2dA7xxWV8Je2tyif87TW8B8BOJcO9dzIYnJ2oI7LBVMEh13ql0
         C/3Q==
X-Gm-Message-State: AOJu0YzeUj0ONBAz2Dq9D49iJktdzIcRP2QwYRDascvWRX3QWA8rGfpi
        NHloq6YQUBmJK6xjcIT6aNIBD/O5w+ql3Q2FrhytVJ4zD/mAscWOiBAtu+pGYcacmlZZUMV+SGN
        cm0U/IN0BrPzqITNzqB/E6p+StFCZTJ9V5aUxNFyoMT4XpXhPKwQSlw==
X-Received: by 2002:a17:90b:207:b0:263:ebab:a152 with SMTP id fy7-20020a17090b020700b00263ebaba152mr17455690pjb.19.1697006092276;
        Tue, 10 Oct 2023 23:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG7Jg8p5JoarrZc0SP0VmvntkNCM4Bi6vD3Oq1kx7GyQ/FZG+mqRHFLHLMNSUEcC96PyTkWuiVj2mriWrNmD5c=
X-Received: by 2002:a17:90b:207:b0:263:ebab:a152 with SMTP id
 fy7-20020a17090b020700b00263ebaba152mr17455674pjb.19.1697006091933; Tue, 10
 Oct 2023 23:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
 <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
 <CAK00qKDnG1o6ZxzY=pGs0J7o_RYYsr1XHxJKirRKeghsp6QOBg@mail.gmail.com>
 <CAAd53p6cgN7QDZXzTsw_DVgOmpv46DY+Ttom5V0vTBVn2jpUQg@mail.gmail.com>
 <CAK00qKA2kaQ2k0Tp=F86BmAMEK=GiAmtLiAQcZRBGVvHOd64MQ@mail.gmail.com>
 <CAAd53p4EemJQfp2nwKTPoGpwPJchZKfC8hKU8zuvtK-YKmM9bQ@mail.gmail.com>
 <CAK00qKCXYg_JPUf=kCxLR1wmi=kmQ25X-ScQ7OYL1zpBKQAQkA@mail.gmail.com>
 <CAAd53p6_qQvp3EJgds_CAnHHSJLBQWc9TYyWpOzNaBZjyoDpeg@mail.gmail.com> <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com>
In-Reply-To: <CAK00qKAhOnGzX8mAUADXDAjExHTQmyb5DyNkZoFht3Cn6bU1Aw@mail.gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Wed, 11 Oct 2023 14:34:39 +0800
Message-ID: <CAAd53p7YD4B9U6C+3RiW_mgMXnGTMNbVmgkAuge5U3ZXVL7FQQ@mail.gmail.com>
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

On Fri, Oct 6, 2023 at 6:30=E2=80=AFPM Victor Shih <victorshihgli@gmail.com=
> wrote:
>
> On Mon, Oct 2, 2023 at 10:18=E2=80=AFAM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> > Hi Victor,
> >
> > On Tue, Sep 26, 2023 at 4:21=E2=80=AFPM Victor Shih <victorshihgli@gmai=
l.com> wrote:
> > >
> > > On Fri, Sep 22, 2023 at 3:11=E2=80=AFPM Kai-Heng Feng
> > > <kai.heng.feng@canonical.com> wrote:
> > > >
> > > > Hi Victor,
> > > >
> > > > On Wed, Sep 20, 2023 at 4:54=E2=80=AFPM Victor Shih <victorshihgli@=
gmail.com> wrote:
> > > > >
> > > > > On Tue, Sep 19, 2023 at 3:31=E2=80=AFPM Kai-Heng Feng
> > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > >
> > > > > > Hi Victor,
> > > > > >
> > > > > > On Tue, Sep 19, 2023 at 3:10=E2=80=AFPM Victor Shih <victorshih=
gli@gmail.com> wrote:
> > > > > > >
> > > > > > > On Tue, Sep 19, 2023 at 12:24=E2=80=AFPM Kai-Heng Feng
> > > > > > > <kai.heng.feng@canonical.com> wrote:
> > > > > > > >
> > > > > > > > Hi Victor,
> > > > > > > >
> > > > > > > > On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victor=
shihgli@gmail.com> wrote:
> > > > > > > > >
> > > > > > > > > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> > > > > > > > >
> > > > > > > > > Due to a flaw in the hardware design, the GL975x replay t=
imer frequently
> > > > > > > > > times out when ASPM is enabled. As a result, the system w=
ill resume
> > > > > > > > > immediately when it enters suspend. Therefore, the replay=
 timer
> > > > > > > > > timeout must be masked.
> > > > > > > >
> > > > > > > > This patch solves AER error when its PCI config gets access=
ed, but the
> > > > > > > > AER still happens at system suspend:
> > > > > > > >
> > > > > > > > [ 1100.103603] ACPI: EC: interrupt blocked
> > > > > > > > [ 1100.268244] ACPI: EC: interrupt unblocked
> > > > > > > > [ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error =
received:
> > > > > > > > 0000:00:1c.0
> > > > > > > > [ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
> > > > > > > > severity=3DCorrected, type=3DData Link Layer, (Transmitter =
ID)
> > > > > > > > [ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] =
error
> > > > > > > > status/mask=3D00001000/00002000
> > > > > > > > [ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout
> > > > > > > >
> > > > > > > > Kai-Heng
> > > > > > > >
> > > > > > >
> > > > > > > Hi, Kai-Heng
> > > > > > >
> > > > > > > Could you try applying the patch and re-testing again after r=
estarting
> > > > > > > the system?
> > > > > >
> > > > > > Same issue happens after coldboot.
> > > > > >
> > > > > > > Because I applied the patch and restarted the system and it d=
idn't happen.
> > > > > > > The system can enter suspend normally.
> > > > > > >
> > > > > > > If you still have the issue after following the above instruc=
tions,
> > > > > > > please provide me with your environment and I will verify it =
again.
> > > > > >
> > > > > > The patch gets applied on top of next-20230918. Please let me k=
now
> > > > > > what else you want to know.
> > > > > >
> > > > > > Kai-Heng
> > > > > >
> > > > >
> > > > > Hi, Kai-Heng
> > > > >
> > > > > If I want to mask the replay timer timeout AER of the upper layer=
 root port,
> > > > > could you give me some suggestions?
> > > > > Or could you provide sample code for my reference?
> > > >
> > > > I am not aware of anyway to mask "replay timer timeout" from root p=
ort.
> > > > I wonder if the device supoprt D3hot? Or should it stay at D0 when
> > > > ASPM L1.2 is enabled?
> > > >
> > > > Kai-Heng
> > > >
> > >
> > > Hi, Kai-Heng
> > >
> > > Do you know any way to mask the replay timer timeout AER of the
> > > upstream port from the device?
> >
> > Per PCIe Spec, I don't think it's possible to only mask 'replay timer t=
imeout'.
> >
> > > The device supports D3hot.
> >
> > Do you think such error plays any crucial rule? Otherwise disable
> > 'correctable' errors may be plausible.
> >
> > Kai-Heng
> >
>
> Hi, Kai-Heng
>
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled.
> This patch solves the AER error of the replay timer timeout for GL975x.
> We have not encountered any other errors so far.

On the system I tested, this patch reduces the occurrence of the
error, but not completely eliminated.

> Does your 'correctable' errors mean the AER error of the replay timer tim=
eout?
> May I ask if you have any other comments on this patch?

Spamming `lspci -vv -s` on the device can still observe the AER error.

I think the "correctable" mask should be optional, let me send a patch
to PCI for comment.

Kai-Heng

>
> Thanks, Victor Shih
>
> > >
> > > Thanks, Victor Shih
> > >
> > > > >
> > > > > Thanks, Victor Shih
> > > > >
> > > > > > >
> > > > > > > Thanks, Victor Shih
> > > > > > >
> > > > > > > > >
> > > > > > > > > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.=
tw>
> > > > > > > > > ---
> > > > > > > > >  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
> > > > > > > > >  1 file changed, 16 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/m=
mc/host/sdhci-pci-gli.c
> > > > > > > > > index d83261e857a5..d8a991b349a8 100644
> > > > > > > > > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > > > > > > > > @@ -28,6 +28,9 @@
> > > > > > > > >  #define PCI_GLI_9750_PM_CTRL   0xFC
> > > > > > > > >  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> > > > > > > > >
> > > > > > > > > +#define PCI_GLI_9750_CORRERR_MASK                       =
       0x214
> > > > > > > > > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
         BIT(12)
> > > > > > > > > +
> > > > > > > > >  #define SDHCI_GLI_9750_CFG2          0x848
> > > > > > > > >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> > > > > > > > >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > > > > > > > > @@ -152,6 +155,9 @@
> > > > > > > > >  #define PCI_GLI_9755_PM_CTRL     0xFC
> > > > > > > > >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> > > > > > > > >
> > > > > > > > > +#define PCI_GLI_9755_CORRERR_MASK                       =
       0x214
> > > > > > > > > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT=
         BIT(12)
> > > > > > > > > +
> > > > > > > > >  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0=
x510
> > > > > > > > >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET   =
 BIT(8)
> > > > > > > > >
> > > > > > > > > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct=
 sdhci_host *host)
> > > > > > > > >         value &=3D ~PCI_GLI_9750_PM_STATE;
> > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL=
, value);
> > > > > > > > >
> > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_=
MASK, &value);
> > > > > > > > > +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER=
_TIMEOUT;
> > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR=
_MASK, value);
> > > > > > > > > +
> > > > > > > > >         gl9750_wt_off(host);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct=
 sdhci_pci_slot *slot)
> > > > > > > > >         value &=3D ~PCI_GLI_9755_PM_STATE;
> > > > > > > > >         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL=
, value);
> > > > > > > > >
> > > > > > > > > +       /* mask the replay timer timeout of AER */
> > > > > > > > > +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_=
MASK, &value);
> > > > > > > > > +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER=
_TIMEOUT;
> > > > > > > > > +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR=
_MASK, value);
> > > > > > > > > +
> > > > > > > > >         gl9755_wt_off(pdev);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.25.1
> > > > > > > > >
