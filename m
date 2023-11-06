Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84903C4332F
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Nov 2023 12:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjKFMqS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Nov 2023 07:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjKFMqC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Nov 2023 07:46:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2560E10FE
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 04:45:35 -0800 (PST)
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 302D33F129
        for <linux-mmc@vger.kernel.org>; Mon,  6 Nov 2023 12:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699274734;
        bh=Kv5qXMtHe1RqB/IAdF3q285FqfuFYmP+L0xdtku424s=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=ohC+2P6eIz9UEIwqG6CI5nbi37GUpZWibYGKuK0mqBUXK9lqBp5dMM9a7qEAOh0WC
         bVy4uj2NJkOQ6aapoLUAQ8Y2RP9Eh+r8C39Hx/FHc6lBodK7R+0I9/EO3sccLQ8Z8d
         A6s8N/K5l1JZQb6ZBGDQpoMn3fvGvoZhgHRlKlZPFd8bEE8savuzluty0VK01QCcUx
         iABS0tlFpFUwOSPuPcZ+n+hoMJOCk92KxqdOGQKMgm0n94ojIVHrxaqGG/KWsLA4ty
         //OJNFdsOKy0vUjOfFxB+QBTVXEKChzZdQ+0AbRjUQdFTDl1xF8t81t2Sq96c+WCFJ
         /cZlw4R1v5k+Q==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2803256bc44so3333972a91.1
        for <linux-mmc@vger.kernel.org>; Mon, 06 Nov 2023 04:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699274732; x=1699879532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kv5qXMtHe1RqB/IAdF3q285FqfuFYmP+L0xdtku424s=;
        b=PMH56iXF4TtsDyk8S7BeeA6arPEtDFe4ceD+oi88BOMQmYWPx59KdZ0C6riqsmF8kC
         +P4E304U4l3z6RjIpooeFwG18hvAOtfLJzFQPrjF089fOMmNi7bbx465YMcMJYIGEROD
         voUiHM7DdCImzH2iM8NJqrYJR/uGgxyD/cYZB/UfgksvKbVt8XtwnF5a3XCIihrOYgeq
         nVNS9nCduKwxn8BGXZaOOFUgbJkXA3uOpHxgyjBGgPgvlhYU/V3evAJ9cTiGPWQkqI02
         It7oAn4rb3tsaJ5gt5OFWkIm0FGPYY3EjHVx5oqmDBLmrun71HWFuuaotQIu8MeGiu0C
         nMJA==
X-Gm-Message-State: AOJu0YwLfkzLTE+xRxusYhXZv8Fh26pbBWVrHvjTvhUjbz0uJdbykhbb
        FyXVO/WiZbKEMdunCOPo6OMJebpQtRY4ARdo1O0SkvFVJYoSECAHbde9CxlxBM24jHOUlYcKxtV
        KTXiT77rUVorMyo4hF1gWKQY3hDq5kxgf8HdD1P+5M/3Tihv9/yOvwQ==
X-Received: by 2002:a17:90a:319:b0:280:c7c:3069 with SMTP id 25-20020a17090a031900b002800c7c3069mr20802008pje.7.1699274732423;
        Mon, 06 Nov 2023 04:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEh2XiLPI3ndF2x/X6bn2IJNKH5McXJDdk/jTsZOxEv6ay1/WonhiHxfGBgkouzA8kJ3g5is6gUmNd6KZOSgt4=
X-Received: by 2002:a17:90a:319:b0:280:c7c:3069 with SMTP id
 25-20020a17090a031900b002800c7c3069mr20801988pje.7.1699274732095; Mon, 06 Nov
 2023 04:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20231018103337.34622-1-victorshihgli@gmail.com> <d18a2569-ebc3-484f-927a-5e3682457469@intel.com>
In-Reply-To: <d18a2569-ebc3-484f-927a-5e3682457469@intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 6 Nov 2023 14:45:18 +0200
Message-ID: <CAAd53p5Q5-RVHWytst7=tCNW+A+Sc_swAgUQemQLF27CLbH7+A@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci-pci-gli: GL975[05]: Mask the replay timer
 timeout of AER
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, SeanHY.Chen@genesyslogic.com.tw,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Nov 6, 2023 at 11:29=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 18/10/23 13:33, Victor Shih wrote:
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
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

I'll send another patch to address the issue I am seeing.

Kai-Heng

>
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
> >  #define PCI_GLI_9750_PM_CTRL 0xFC
> >  #define   PCI_GLI_9750_PM_STATE        GENMASK(1, 0)
> >
> > +#define PCI_GLI_9750_CORRERR_MASK                            0x214
> > +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT       BIT(12)
> > +
> >  #define SDHCI_GLI_9750_CFG2          0x848
> >  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> > @@ -152,6 +155,9 @@
> >  #define PCI_GLI_9755_PM_CTRL     0xFC
> >  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
> >
> > +#define PCI_GLI_9755_CORRERR_MASK                            0x214
> > +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT       BIT(12)
> > +
> >  #define SDHCI_GLI_9767_GM_BURST_SIZE                 0x510
> >  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET          BIT(8)
> >
> > @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *h=
ost)
> >       value &=3D ~PCI_GLI_9750_PM_STATE;
> >       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> > +     value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +     pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> > +
> >       gl9750_wt_off(host);
> >  }
> >
> > @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slo=
t *slot)
> >       value &=3D ~PCI_GLI_9755_PM_STATE;
> >       pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> > +     value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> > +     pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> > +
> >       gl9755_wt_off(pdev);
> >  }
> >
>
