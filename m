Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFEDC433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jan 2022 17:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588358AbiAYRbM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588309AbiAYR3v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2022 12:29:51 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC603C061747
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z19so21464859lfq.13
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pQwgp48lKGhsHaoFh8Uisi3uUWmDyLIMjsFztI0K/Po=;
        b=vvrRPqhmBIEym3CvXBIi1lasPvXtzsCZo6cARX5i/YsVM30VvZoE1L4ZCtoX1+PttS
         oOSPJvk4Tr35cBEWR33lWnCwI12bjRNzCB34XiyB11yTQ7S0inpqA8jbv/wngWSjthgl
         yigM9KScQRDAEGjEAcfZVcEuLyShddHgkGfvaca+9LuxGvox9lgTGiM7otXB4oC3FfGS
         e7HmVdJxRYIZ2IdW0GOLUoU3SR+hA89LEpmNwWIth/X1REH8d2VHPGCjofD6RppOC+84
         J5tSlGNctkKWSM2xvlLQfTg9xtsjYTAxAUOx+yrQg5Koce/9p4ypRNtlZBaFNKptWQrm
         VpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pQwgp48lKGhsHaoFh8Uisi3uUWmDyLIMjsFztI0K/Po=;
        b=bm9nT6NaIqBlyL/HC59RpUCmFsGnDXGvOEF+x7d6vOpAkvoSMFZQAWfnnrGuheobDo
         iaZUvs26fds4utp/r8SLokxw2Oj07UmKN4ZjvxDNNW92x/glZtPtRahE6o2V7EAuMY9E
         2DvUl2eCRWb6ryy8Q8OQ83eIvomvsOzLkAc7be9CJt3dLwC2hmib5MDCJpiwPEUpIcLs
         H1S1154rZEFWVvMjT11gUAa+UukW+ezkyMMy2XsEEh0tDOJBV/A4WILkoOUADlkRpWxP
         RHmlH10kbfHEFxlR0u3MYLrycsl8ZZyWG41KHo6nZbPoEPUMh10QDNWNk7igxkkbV+4m
         2VGw==
X-Gm-Message-State: AOAM530XFVU5q/7T2Vow1xHq4AcbYfv2QgMrSvOXGNdqFeXK5Kyr0kEK
        H1bfr1ICox5/I2n8j71smRUVRjUsHwTKaEIRrPcZGg==
X-Google-Smtp-Source: ABdhPJwRrLX3A/HcZ9ZssQ8V6JvhHCQttum4X6h1JaUG8+vmEjURJZeoNNAvZiUoIaGzgcaF+nK780mJNMQRhhEsPiM=
X-Received: by 2002:a05:6512:2348:: with SMTP id p8mr6210097lfu.71.1643131788978;
 Tue, 25 Jan 2022 09:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20220113094404.64510-1-quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220113094404.64510-1-quentin.schulz@theobroma-systems.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Jan 2022 18:29:12 +0100
Message-ID: <CAPDyKFrfUbPWPKsBoctWdg+afoUgzNjMM9197U3KROTPx531kA@mail.gmail.com>
Subject: Re: [PATCH v2] add README
To:     quentin.schulz@theobroma-systems.com
Cc:     linux-mmc@vger.kernel.org, avri.altman@wdc.com,
        Quentin Schulz <foss+kernel@0leil.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 13 Jan 2022 at 10:44, <quentin.schulz@theobroma-systems.com> wrote:
>
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>
> This adds a README to the project so that the contribution process is
> explicit as well as the licenses that apply to the source code.
>
> Cc: Quentin Schulz <foss+kernel@0leil.net>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe


> ---
>
> v2:
>  - added Avri to the list of maintainers
>  - fixed aboive typo
>  - updated license to only mention GPL-2.0-only as BSD-3-Clause is
>  compatible with GPL-2.0-only projects, as mentioned in
>  3rdparty/hmac_sha/ files
>
>  README | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 README
>
> diff --git a/README b/README
> new file mode 100644
> index 0000000..71a4e7d
> --- /dev/null
> +++ b/README
> @@ -0,0 +1,31 @@
> +MMC tools (mmc-utils)
> +=====================
> +
> +mmc-utils is a tool for configuring MMC storage devices from userspace.
> +
> +Contribution guidelines
> +-----------------------
> +
> +The project works using a mailing list patch submission process, similar to the
> +process used for the Linux kernel itself.
> +
> +One can document themselves by reading how to submit a patch in the official
> +Linux kernel documentation:
> +https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> +
> +Not all sections apply but it should be a good way to get started.
> +
> +A patch should be sent as a mail (not as an attachement, see documentation
> +above) to the linux-mmc@vger.kernel.org mailing list with maintainers as
> +Cc recipients.
> +
> +Maintainers
> +-----------
> +
> +Avri Altman <avri.altman@wdc.com>
> +Ulf Hansson <ulf.hansson@linaro.org>
> +
> +License
> +-------
> +
> +This project is licensed under GPL-2.0-only.
> --
> 2.34.1
>
