From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/5] mmc: sh_mmcif: Various minor improvements
Date: Mon, 27 Jun 2016 11:22:03 +0200
Message-ID: <CAPDyKFr=38jCG=G=yTOiqhgXqNHCBvwh7L6FAC5N=KKY-UYfPw@mail.gmail.com>
References: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:38440 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbcF0JWG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jun 2016 05:22:06 -0400
Received: by mail-wm0-f50.google.com with SMTP id r201so105727296wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jun 2016 02:22:05 -0700 (PDT)
In-Reply-To: <1466514770-9462-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Baolin Wang <baolin.wang@linaro.org>

On 21 June 2016 at 15:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> When looking for mmc drivers that has special treatmeant of the ERASE command,
> the sh_mmcif driver is one of them, I took the opportunity to improve some of
> that related code.
>
> This is not tested on HW, so I would appreciate if someone that still cares
> about this driver can do a quick test of these changes.
>
> Ulf Hansson (5):
>   mmc: core: Allow hosts to specify non-support for SD commands
>   mmc: sh_mmcif: Enable MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO
>   mmc: sh_mmcif: Use response type to know when to enable busy detection
>   mmc: sh_mmcif: Inform the mmc core about the max busy timeout
>   mmc: sh_mmcif: Use a 10s timeout in the error recovery path
>
>  drivers/mmc/core/core.c     |  9 +++++---
>  drivers/mmc/host/sh_mmcif.c | 53 ++++++++++-----------------------------------
>  include/linux/mmc/host.h    |  1 +
>  3 files changed, 18 insertions(+), 45 deletions(-)
>
> --
> 1.9.1
>

I decided to queue up this series to get it tested in next/kernelci.

If any objections, please let me know!

Kind regards
Uffe
