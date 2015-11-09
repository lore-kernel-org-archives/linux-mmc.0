From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: add ifdef around fault_create_debugfs_attr()
Date: Mon, 9 Nov 2015 14:33:11 +0100
Message-ID: <CAPDyKFrs4VCJgVXpF405HrXZ2oJ+L=3e7hWtYAxYx4=qMHsRYQ@mail.gmail.com>
References: <1446812136-31526-1-git-send-email-adrien+dev@schischi.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34891 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109AbbKINdM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Nov 2015 08:33:12 -0500
Received: by ykek133 with SMTP id k133so263761917yke.2
        for <linux-mmc@vger.kernel.org>; Mon, 09 Nov 2015 05:33:12 -0800 (PST)
In-Reply-To: <1446812136-31526-1-git-send-email-adrien+dev@schischi.me>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrien Schildknecht <adrien+dev@schischi.me>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 6 November 2015 at 13:15, Adrien Schildknecht <adrien+dev@schischi.me> wrote:
> FAIL_MMC_REQUEST can be used without FAULT_INJECTION_DEBUG_FS.
> In this case fault_create_debugfs_attr() will always return an error and
> lead to the deletion of the whole debugfs directory.
>
> This patch makes sure that FAULT_INJECTION_DEBUG_FS is enabled before
> attempting to create the debugfs atttribute.
>
> Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> ---
>  drivers/mmc/core/debugfs.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 154aced..13e842c 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -259,11 +259,13 @@ void mmc_add_host_debugfs(struct mmc_host *host)
>         if (fail_request)
>                 setup_fault_attr(&fail_default_attr, fail_request);
>         host->fail_mmc_request = fail_default_attr;
> +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
>         if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
>                                              root,
>                                              &host->fail_mmc_request)))
>                 goto err_node;
>  #endif
> +#endif
>         return;
>
>  err_node:
> --
> 2.6.2
>

I think you are solving this in the wrong way. Will it really makes
sense to use FAIL_MMC_REQUEST unless FAULT_INJECTION_DEBUG_FS is set,
I don't think so.

I suggest you to change FAIL_MMC_REQUEST from depending on
FAULT_INJECTION to FAULT_INJECTION_DEBUG_FS in /lib/Kconfig.debug.

Kind regards
Uffe
