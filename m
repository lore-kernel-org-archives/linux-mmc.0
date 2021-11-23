Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EB8C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Nov 2021 11:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhKWLR3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbhKWLR2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Nov 2021 06:17:28 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE6C061714
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 03:14:20 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c32so90218496lfv.4
        for <linux-mmc@vger.kernel.org>; Tue, 23 Nov 2021 03:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2vpqtZzJw20Et8gdSKZ5+LZSgorGMpscNsnyF4iAFU=;
        b=oIS8T4jNlyyNbTML+PmFXPAndBXTHil4AJo0BjaeUiF2OhQlzglcdrFVy/fyOi7qfy
         Cloh8kwczPLdgpYPEXiJNulzojyVu/DUqElCIDKaP577c7927/tItDxrCoGpc3Dm9zor
         9kIdFWqiKxCDrCxdKxUrvBW9jHBnohivV/x5nraVwKF0LrorL8SvCL2FxKv9yuHzMdz2
         AVxdovdMjs2LMcBIWitlGB+VsT5Syc/8bn7juJdEnrbvveMiiTp9d96zvrK80M4/DbwD
         AleOGWs9+sQ2Dz14fq2Dnv5Emuv2xD8OjltdX+2ATgdS4Nn/vCzYGLlV0NWh5euBWjkJ
         RkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2vpqtZzJw20Et8gdSKZ5+LZSgorGMpscNsnyF4iAFU=;
        b=6+dpCjmu/gK0yprJKOCYmPOG3RyfeVOPmATJjp2KlAiu8hMtlGVp36iC0z828G2WqU
         s02eFC9C0l3FVwfpnm6z4N8vS7F1//aHVF8Vzbaf8uOxj/agGoasJbIo3PGMt+PXlYXb
         pmDzqM9osdd5RznCizubf0Jx+HOUBc0jtYrOo1Vs+MKrLvy0eb0/C2GvJKs5J/0S+p3O
         al3gwNAcxp721/PD0wHftlXHVGTlSGaZjUFNZB369fveKndDDAkd6BORdlotGaRWTfqA
         YvqHuyolKE2oDIUDVpgpklu9c7u+vMAMqnMv+snDcMC19v6/kN8FfxtDS+4WFRhVqnOc
         5zuw==
X-Gm-Message-State: AOAM5312ECCpJLKztmjunEmugmplGlEFS7KdlTKg28zc8aKQ7S7mjn6A
        MGuMuMElGH0xlS4RBH0gI7nZ9IKQOZzJL0l/rMNzUw==
X-Google-Smtp-Source: ABdhPJzbwCtHfNPPkgln/I4+w+Qu3sIY5e+oPQhe3uSrc+ijbL6b7R0IZJVSbNvmQWYRKcNMXeboQ6LB5h6XEUyGK6c=
X-Received: by 2002:a05:6512:3d07:: with SMTP id d7mr3937129lfv.233.1637666058738;
 Tue, 23 Nov 2021 03:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20211122170536.7725-1-hdegoede@redhat.com>
In-Reply-To: <20211122170536.7725-1-hdegoede@redhat.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 12:13:42 +0100
Message-ID: <CAPDyKFqtYJ2aT+brhAG9r-VTuK=-25nEAXhw_M7yWhUSJN=BXg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] ACPI: acpi_device_override_status() changes
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Nov 2021 at 18:05, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Rafael,
>
> As requested here is a v2 of my series previously titled:
> "ACPI: scan: Skip turning off some unused objects during scan"
>
> Which was a regression fix series for the commit c10383e8ddf4
> ("ACPI: scan: Release PM resources blocked by unused objects")
> change, but that has been reverted now. So as requested here is
> a v2 changing the wording of various commit messages since these
> changes are still useful to have regardless.
>
> Patch 1/7 is a v2/resend of the "ACPI / x86: Drop PWM2 device on
> Lenovo Yoga Book from always present table" patch. You requested
> changing the commit message of this one a bit to make it sound
> less like a regression fix (which it is not). But you already
> have the previous version of this patch in your bleeding-edge
> branch, with a "Cc: 5.1+ <stable@vger.kernel.org> # 5.1+"
> added ?  So depending on which version you want you can either
> skip this patch when applying this series, or replace it with
> the version from this series.
>
> Patches 2-4 are the main changes to make the always_present
> quirk handling more flexible, changing it into a status_override
> mechanism + adding a quirk for the GPD win and pocket to fix
> an issue with those in a more elegant matter then the current
> kludge in the sdhci-acpi code.
>
> Patch 5 is an unrelated patch which touches the override-status
> quirk table, so it needed to be rebased and I decided to add it
> to this series to make it clear that its v2 needs to be applied
> on top of the other ACPI changes from this series.
>
> Patches 6+7 cleanup the sdhci-acpi code, removing the now no
> longer needed ugly kludge for the GPD win/pocket. These can
> be merged independently from patches 1-5, through the mmc
> tree, as long as they get send to Linus during the same
> kernel cycle as the ACPI bits.

This sounds like the mmc changes are really not that independent after
all. What about bisectability?

An option is to funnel the sdhci patches together with the ACPI
patches through Rafael's tree. You have my ack for this, but let's
wait for Adrian's ack too.

[...]

Kind regards
Uffe
