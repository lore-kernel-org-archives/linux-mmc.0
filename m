Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC29C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2F7822D04
	for <linux-mmc@archiver.kernel.org>; Tue, 26 Jan 2021 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392711AbhAZOLZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 Jan 2021 09:11:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391192AbhAZOLM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 26 Jan 2021 09:11:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C36022DFB;
        Tue, 26 Jan 2021 14:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611670212;
        bh=GB4LM+e+KeQGmPPaLGcE23K9W8YeHZUp43KVm86dkoA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i7uSImQguDH5lJDoFDoN2maBLvW1GpbbrufKZVE4cQBo8cXKNsyvoYJETsxfFNny0
         X922heTn/Md9zsoDABajJXyvr3oYttOinUXgvYni4sKnWa49/3TrpWWS0dJ4a98h3x
         6SqIA/VrVDzTsWeYU7cQb6e7Joe9fG07rKh+ablVnJmvMNBpNfpVkBL43mvugJU4G+
         qtUewldsJ7XMQw350kaNvoJORSFL7VGwAFz7f9vxw8usB/bq/aJBqL4lgzdqu9XdQ4
         U/MOJYK59W9rpH0qWAFLvW/xbpwe64lrKb1H3CFKRUlj+6Wsu2f4cmZzIUS9lv8GS9
         votvddrUrAYhw==
Received: by mail-ot1-f54.google.com with SMTP id s2so14075395otp.5;
        Tue, 26 Jan 2021 06:10:12 -0800 (PST)
X-Gm-Message-State: AOAM5337LYhsSfgI07pSjUk4sxKhsXs9MeFTi/naMUCfjMphlg7MgDgD
        TN83QwCsUzGA1/Z3SlrCGxv+NO0XwgI6pFmulGo=
X-Google-Smtp-Source: ABdhPJw7ommRj9+grbObZCNjDx1zbb9kddzZfzWL972a7v/ySOvAuA/pnVFKhfW2s+774OmbYvq4E5qfNtKYQWjbJ2g=
X-Received: by 2002:a05:6830:139a:: with SMTP id d26mr4103374otq.305.1611670211771;
 Tue, 26 Jan 2021 06:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20210126095230.26580-1-ulf.hansson@linaro.org>
In-Reply-To: <20210126095230.26580-1-ulf.hansson@linaro.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 26 Jan 2021 15:09:55 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2MyPc81OdOsOryVgGqomum-UL=5vEDGjtdwNPUJKFFjw@mail.gmail.com>
Message-ID: <CAK8P3a2MyPc81OdOsOryVgGqomum-UL=5vEDGjtdwNPUJKFFjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix linking err for sdhci-brcmstb
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 26, 2021 at 10:52 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> The implementation of sdhci_pltfm_suspend() is only available when
> CONFIG_PM_SLEEP is set, which triggers a linking error:
>
> "undefined symbol: sdhci_pltfm_suspend" when building sdhci-brcmstb.c.
>
> Fix this by implementing the missing stubs when CONFIG_PM_SLEEP is unset.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Nicolas Schichan <nschichan@freebox.fr>
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>
