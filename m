From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/7] mmc: sh_mmcif: Convert to use runtime PM at
 request idle
Date: Tue, 29 Oct 2013 20:29:24 +0100
Message-ID: <CAPDyKFoF_tZHTLcKSE_HjRXEohDwPkRn7ewhvuUfKQs7uoJS9Q@mail.gmail.com>
References: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:49524 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab3J2T3Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Oct 2013 15:29:24 -0400
Received: by mail-qc0-f176.google.com with SMTP id s19so210431qcw.21
        for <linux-mmc@vger.kernel.org>; Tue, 29 Oct 2013 12:29:24 -0700 (PDT)
In-Reply-To: <1382450846-17144-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 22 October 2013 16:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In a step in removing CONFIG_MMC_CLKGATE, host drivers can implement same
> functionality through runtime PM. This patchset is converting the sh_mmcif
> accordingly.
>
> On the way, it was reasonable to include some minor cleanups to simplify code.
> The first patch has beend sent through an another patchset recently, but since
> it touches related code to this patchset, I decided to fold it in here as well.
>
> An important note, this patchset has only been compile tested. I hope someone
> can help out with proper testing.
>
> Changes in v2:
>         - Adapted "mmc: sh_mmcif: Move clock handling into runtime PM callbacks"
>         patch to maintain behavior of handling clk_get_rate.
>         - Rebased patches on top of the above change.
>
> Ulf Hansson (7):
>   mmc: sh_mmcif: Move away from using deprecated APIs
>   mmc: sh_mmcif: Convert to PM macros when defining dev_pm_ops
>   mmc: sh_mmcif: Convert to clk_prepare|unprepare
>   mmc: sh_mmcif: Use runtime PM to keep resourses active during I/O
>   mmc: sh_mmcif: Move clock handling into runtime PM callbacks
>   mmc: sh_mmcif: Simplify clock and power setup in set_ios
>   mmc: sh_mmcif: Extend clock gating routine for runtime suspend
>
>  drivers/mmc/host/sh_mmcif.c |  138 ++++++++++++++++++++++++-------------------
>  1 file changed, 76 insertions(+), 62 deletions(-)
>
> --
> 1.7.9.5
>

Hi Guennadi.

Just wanted to send you a kind ping on this. I would very much
appreciate any further comments from you.

Kind regards
Ulf Hansson
