From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: enable controller interrupt before calling mmc_start_host
Date: Mon, 8 Oct 2012 13:58:58 +0100
Message-ID: <CAFbHwiQ1YAE3AukJYTOi-9w+NwNO1n-=s7aAa1jZ6R1UdcRWyA@mail.gmail.com>
References: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:62660 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220Ab2JHM7A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Oct 2012 08:59:00 -0400
In-Reply-To: <1349686791-19652-1-git-send-email-yuvaraj.cd@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yuvaraj CD <yuvaraj.cd@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org, will.newton@imgtec.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, thomas.abraham@linaro.org, patches@linaro.org, Yuvaraj CD <yuvaraj.cd@samsung.com>

On Mon, Oct 8, 2012 at 9:59 AM, Yuvaraj CD <yuvaraj.cd@gmail.com> wrote:
> As mmc_start_host is getting called before enabling the dw_mmc controller
> interrupt, there is a problem of missing the SDMMC_INT_CMD_DONE for the
> very first command sent by the sdio_reset.
> This problem occurs only when we disable MMC debugging i.e, MMC_DEBUG [=n].
> Hence this patch enables the dw_mmc controller interrupt before mmc_start_host.
>
> Signed-off-by: Yuvaraj CD <yuvaraj.cd@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)

Ideally I think it would be cleaner to break up the slot
initialization into two parts, one that allocates and sets up the slot
and the other that calls mmc_add_host, but that's a more substantial
bit of work and would also complicate the error handling. This looks
like it should be safe though, so:

Acked-by: Will Newton <will.newton@imgtec.com>
