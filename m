Return-Path: <SRS0=j7Ik=DM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB16C4727E
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A411920848
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Oct 2020 13:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W0kTDSNY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgJENE3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Oct 2020 09:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgJENEK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A50C0613A9
        for <linux-mmc@vger.kernel.org>; Mon,  5 Oct 2020 05:51:32 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y194so4163074vsc.4
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2020 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o06J1+Od5Vgxwuast3aD7MfhDeyMcGmESv1mnKw18yM=;
        b=W0kTDSNY8VQOfr1noiJ4/53xraarP75EXCNRTdt+kuU5QX/z7peWWSdAS3LpPmInlU
         aCyKqN1xURSs9WNZ/MFbYHb4dHin45hUSHfkwHJtndAUP7TSZ47SLetzYE8Xwp0QSH6+
         pNLvi0QJxiMWW+bQK5T7dwp3SwQ87ik8KkbvE+3q8197apYC1wRTl35WtUdEhVGqvkR5
         FG3Vzofbw03Nr3Qr1BjpjzcgdupqYQuIuAvJzvhGSzr1Bmu3lBVRN3QsCQlfWquRT0uz
         rFmYSV22tgOwv1LHwG5q5bILkyQUu/++IiAoicdijniMagarUm0mFf7Rh5AohJDKpzf7
         wP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o06J1+Od5Vgxwuast3aD7MfhDeyMcGmESv1mnKw18yM=;
        b=jMza/9nMJyqJ4ewwMxtGvB9/x1BxbPRD0AG497YCXzhVY/5kg49ccw3pVcnXHKg595
         glDMSz2LDqXE0SI+v4NsOzEVV+AaXLk9fQ58YiWnySE5Fev4gs7hd+22QNTlReehu/5j
         aRTwD/snP+AyxifBQOV/YQs0q2VKOhchpUb2cIRComo9mR/7z91ZwbdFVvCWZGXHm5g9
         xFVXkyJ6BPbquOVoXuSC+YiEm7YSD38LezjIDQUUJ9obg+uevECiyG9e7Nc6pzzATAW6
         XcliaksS/eI/aZ89nwEQcKz7k0xChZrt8YbT4g8fre9mUnXNokL5AVx4L69qqAiF2NEB
         JQkA==
X-Gm-Message-State: AOAM533QUG94Bk4BHO9noGRavhGK3M0FLRf6/z0OUZ4UDlxEJZ5Gvz1y
        CMbO6pm5Mk6XwDZyDbUnmSxbM80YDj/caio6c6S6fdGMWBhQwA==
X-Google-Smtp-Source: ABdhPJzDjjafmkBjirzc0t6dbSaI9fKF+lsw5l6xf3VR7Zt9Iqx/t8sX7S+187oQDcnOUN+C435YsoN1I68UQhIZkpI=
X-Received: by 2002:a05:6102:910:: with SMTP id x16mr2725173vsh.42.1601902291431;
 Mon, 05 Oct 2020 05:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
In-Reply-To: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Oct 2020 14:50:54 +0200
Message-ID: <CAPDyKFrCMWtKQOrTaFtmsWsQ1x0dHHmV3SvXuGFcYE-PgeoB6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: AMDI0040: Set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Shirish.S@amd.com,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 28 Sep 2020 at 23:59, Raul E Rangel <rrangel@chromium.org> wrote:
>
> This change fixes HS400 tuning for devices with invalid presets.
>
> SDHCI presets are not currently used for eMMC HS/HS200/HS400, but are
> used for DDR52. The HS400 retuning sequence is:
>
>     HS400->DDR52->HS->HS200->Perform Tuning->HS->HS400
>
> This means that when HS400 tuning happens, we transition through DDR52
> for a very brief period. This causes presets to be enabled
> unintentionally and stay enabled when transitioning back to HS200 or
> HS400. Some firmware has invalid presets, so we end up with driver
> strengths that can cause I/O problems.
>
> Fixes: 34597a3f60b1 ("mmc: sdhci-acpi: Add support for ACPI HID of AMD Controller with HS400")
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> I decided to abandon adding the preset_value_support for now. Enabling
> presets for the AMD controller currently results in using invalid
> presets for HS400. This is because sdhci_get_preset_value is using a
> non-standard HS400 register that the AMD controller does not support.
>
> I think preset_value_support also needs more thought. Since HS400
> re-tuning requires switching to HS, DDR52, and HS200, if one of those
> timings is not in the list, we would need to disable presets.
>
> I chose this approach to avoid any additional complexity.
>
>  drivers/mmc/host/sdhci-acpi.c | 37 +++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 284cba11e2795..d335a34ad05b3 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -662,6 +662,43 @@ static int sdhci_acpi_emmc_amd_probe_slot(struct platform_device *pdev,
>             (host->mmc->caps & MMC_CAP_1_8V_DDR))
>                 host->mmc->caps2 = MMC_CAP2_HS400_1_8V;
>
> +       /*
> +        * There are two types of presets out in the wild:
> +        * 1) Default/broken presets.
> +        *    These presets have two sets of problems:
> +        *    a) The clock divisor for SDR12, SDR25, and SDR50 is too small.
> +        *       This results in clock frequencies that are 2x higher than
> +        *       acceptable. i.e., SDR12 = 25 MHz, SDR25 = 50 MHz, SDR50 =
> +        *       100 MHz.x
> +        *    b) The HS200 and HS400 driver strengths don't match.
> +        *       By default, the SDR104 preset register has a driver strength of
> +        *       A, but the (internal) HS400 preset register has a driver
> +        *       strength of B. As part of initializing HS400, HS200 tuning
> +        *       needs to be performed. Having different driver strengths
> +        *       between tuning and operation is wrong. It results in different
> +        *       rise/fall times that lead to incorrect sampling.
> +        * 2) Firmware with properly initialized presets.
> +        *    These presets have proper clock divisors. i.e., SDR12 => 12MHz,
> +        *    SDR25 => 25 MHz, SDR50 => 50 MHz. Additionally the HS200 and
> +        *    HS400 preset driver strengths match.
> +        *
> +        *    Enabling presets for HS400 doesn't work for the following reasons:
> +        *    1) sdhci_set_ios has a hard coded list of timings that are used
> +        *       to determine if presets should be enabled.
> +        *    2) sdhci_get_preset_value is using a non-standard register to
> +        *       read out HS400 presets. The AMD controller doesn't support this
> +        *       non-standard register. In fact, it doesn't expose the HS400
> +        *       preset register anywhere in the SDHCI memory map. This results
> +        *       in reading a garbage value and using the wrong presets.
> +        *
> +        *       Since HS400 and HS200 presets must be identical, we could
> +        *       instead use the the SDR104 preset register.
> +        *
> +        *    If the above issues are resolved we could remove this quirk for
> +        *    firmware that that has valid presets (i.e., SDR12 <= 12 MHz).
> +        */
> +       host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
> +
>         host->mmc_host_ops.select_drive_strength = amd_select_drive_strength;
>         host->mmc_host_ops.set_ios = amd_set_ios;
>         host->mmc_host_ops.execute_tuning = amd_sdhci_execute_tuning;
> --
> 2.28.0.709.gb0816b6eb0-goog
>
