From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH v1 2/5] mmc: card: Do not scan RPMB partitions
Date: Wed, 11 Jul 2012 09:35:43 +0900
Message-ID: <CAKYAXd-Qn7EZfSw-Q=+0L3P1bE6q_ofPoEqC6eCM9HmFND6qHg@mail.gmail.com>
References: <1341564244-6178-1-git-send-email-loic.pallardy@stericsson.com>
	<1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41435 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028Ab2GKAfo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jul 2012 20:35:44 -0400
Received: by wgbds11 with SMTP id ds11so4099671wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jul 2012 17:35:43 -0700 (PDT)
In-Reply-To: <1341564244-6178-3-git-send-email-loic.pallardy@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Loic Pallardy <loic.pallardy@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@linaro.org>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Ulf Hansson <ulf.hansson@stericcson.com>, Johan Rudholm <johan.rudholm@stericsson.com>

>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index 276d21c..1b202fe 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -1521,6 +1521,9 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct
> mmc_card *card,
>  	md->disk->queue = md->queue.queue;
>  	md->disk->driverfs_dev = parent;
>  	set_disk_ro(md->disk, md->read_only || default_ro);
> +	md->disk->flags = GENHD_FL_EXT_DEVT;
Currrenlty mmc have been setting minors to CONFIG_MMC_BLOCK_MINORS.
Why did you add GENHD_FL_EXT_DEVT ?

Thanks.
