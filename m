Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E156ECD3437
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Sep 2023 04:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjISEY6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Sep 2023 00:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjISEY5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Sep 2023 00:24:57 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35EFD
        for <linux-mmc@vger.kernel.org>; Mon, 18 Sep 2023 21:24:51 -0700 (PDT)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B402D3F636
        for <linux-mmc@vger.kernel.org>; Tue, 19 Sep 2023 04:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695097488;
        bh=IMtK+jU1aaMg55M9XkRBqz1ntxbDUiDeLgvPp97wNk0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=qve+rFxC6cuevf3T0qYkvISSF4H9bNpwrlM9zIEtDOk0vKYpyr5SRPMFlp6yKWJvS
         vcyLMdl4g++OyBVIuSobVKrJC3RtBKFf2I+Mov6JLbmH8YT3YP1s3vIYRK/Z8ySXwZ
         20p0FiZ36MA5Fh0sjk2EPOgF+MCZ+0kBkxfJGoM6wZ5Zla6Epmfzwhc/A7+yMyqFLd
         GbVi0sUZHsXcVVgHV7lhB3DXySOwEm8gynpMSRDR9ffc6dZe3i1bCzm/9BwEUM1XK5
         MEn4C76oT3rNGfk0kBMrtjk+sKLqpf8BBQoMM29To+ClCs/hixMjynK2Z6Iybramnt
         sWr3RXhcblIIA==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-690bbc5f9f1so850967b3a.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 Sep 2023 21:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695097487; x=1695702287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMtK+jU1aaMg55M9XkRBqz1ntxbDUiDeLgvPp97wNk0=;
        b=VWVpZyxBQkzmK0n7zhzin804uTqbv7wEfeR2PNvIM2NTnvqQVUnj9DoQjOCbB6a4wo
         j7HkEnzc0HTQ4HgYF9OVz/aUNl8yZTxriinOV9lfdOEhHcYQHqHuGdmLwTW9vp+G50x8
         rc1eU2zA09/M5aWyzVPDc+V5nnYyGQSpY0GfXlHJcGO6qHB8dVNDbl53Q3g9OkkpELFS
         Kr4TQPHCuFl7f6PaFQZHGFI5exhhkdZ5Bb/M4Mz+Zdk/eV/9zxxgDPpt28zN9l++RdEC
         +8p5NN74YcB6KrP7EqzRjiRVD5Z3stzJ8KEs2DXuw9sgMsqLP3JlNv2bldIA/U2fd2DT
         e9Ig==
X-Gm-Message-State: AOJu0YzTnd+kVvAN/4ElqqjM+zrQw7dnIObf3ww7NEwRFsY6vOljUqNJ
        TMrCM5VgxaSEz4XAMmH3CPG9laqi5klKJfcUc+c59yEeSGUKWQLitFOoyvB7OvIKOp+Sk2InJ3Q
        CQUVhU3BsREtSdcCl2X/Ng9M06lVzTb0WLoxlufKdoRhCMQ8IlhgAGA==
X-Received: by 2002:a05:6a21:18e:b0:13a:12c2:359e with SMTP id le14-20020a056a21018e00b0013a12c2359emr12692353pzb.2.1695097487145;
        Mon, 18 Sep 2023 21:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfSpGqyN9f9jWsNOnlcse6U3a2kxaJXMtNr6uyc/cwtIZGvdtxdi2SphBoLjW8MxYK7MZ1EDlr3URictaFhME=
X-Received: by 2002:a05:6a21:18e:b0:13a:12c2:359e with SMTP id
 le14-20020a056a21018e00b0013a12c2359emr12692337pzb.2.1695097486878; Mon, 18
 Sep 2023 21:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230918103055.5471-1-victorshihgli@gmail.com>
In-Reply-To: <20230918103055.5471-1-victorshihgli@gmail.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Tue, 19 Sep 2023 12:24:34 +0800
Message-ID: <CAAd53p4qhf+3j=zMs_RXSpLQzn6RGD9yUNcSA12V5aACswgeeQ@mail.gmail.com>
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

On Mon, Sep 18, 2023 at 6:31=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Due to a flaw in the hardware design, the GL975x replay timer frequently
> times out when ASPM is enabled. As a result, the system will resume
> immediately when it enters suspend. Therefore, the replay timer
> timeout must be masked.

This patch solves AER error when its PCI config gets accessed, but the
AER still happens at system suspend:

[ 1100.103603] ACPI: EC: interrupt blocked
[ 1100.268244] ACPI: EC: interrupt unblocked
[ 1100.326960] pcieport 0000:00:1c.0: AER: Corrected error received:
0000:00:1c.0
[ 1100.326991] pcieport 0000:00:1c.0: PCIe Bus Error:
severity=3DCorrected, type=3DData Link Layer, (Transmitter ID)
[ 1100.326993] pcieport 0000:00:1c.0:   device [8086:7ab9] error
status/mask=3D00001000/00002000
[ 1100.326996] pcieport 0000:00:1c.0:    [12] Timeout

Kai-Heng

>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d83261e857a5..d8a991b349a8 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -28,6 +28,9 @@
>  #define PCI_GLI_9750_PM_CTRL   0xFC
>  #define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
>
> +#define PCI_GLI_9750_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -152,6 +155,9 @@
>  #define PCI_GLI_9755_PM_CTRL     0xFC
>  #define   PCI_GLI_9755_PM_STATE    GENMASK(1, 0)
>
> +#define PCI_GLI_9755_CORRERR_MASK                              0x214
> +#define   PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT         BIT(12)
> +
>  #define SDHCI_GLI_9767_GM_BURST_SIZE                   0x510
>  #define   SDHCI_GLI_9767_GM_BURST_SIZE_AXI_ALWAYS_SET    BIT(8)
>
> @@ -561,6 +567,11 @@ static void gl9750_hw_setting(struct sdhci_host *hos=
t)
>         value &=3D ~PCI_GLI_9750_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9750_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9750_CORRERR_MASK, value);
> +
>         gl9750_wt_off(host);
>  }
>
> @@ -770,6 +781,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot =
*slot)
>         value &=3D ~PCI_GLI_9755_PM_STATE;
>         pci_write_config_dword(pdev, PCI_GLI_9755_PM_CTRL, value);
>
> +       /* mask the replay timer timeout of AER */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, &value);
> +       value |=3D PCI_GLI_9755_CORRERR_MASK_REPLAY_TIMER_TIMEOUT;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_CORRERR_MASK, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.25.1
>
