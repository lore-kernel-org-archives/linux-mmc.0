From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH] mmc: core: add the debug message for SET_BLOCK_COUNT
Date: Tue, 7 Feb 2012 16:27:09 +0900
Message-ID: <CAKYAXd-_eA7BKsxWK0Pgz_8r+DeZ+xKdYscHA6qhMO25kVyocQ@mail.gmail.com>
References: <4F30B2E6.60406@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41180 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab2BGH1L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Feb 2012 02:27:11 -0500
Received: by bkcjm19 with SMTP id jm19so5301408bkc.19
        for <linux-mmc@vger.kernel.org>; Mon, 06 Feb 2012 23:27:10 -0800 (PST)
In-Reply-To: <4F30B2E6.60406@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

2012/2/7 Jaehoon Chung <jh80.chung@samsung.com>:
> This patch is added just debug message.
> Almost features need to use the CMD23.
> But we didn't see the debug message for sbc.
> If sbc's message can see, should be help for debugging.
> (We can check whether use the cmd23 or not)
Hi. Jaehoon.
how about using CONFIG_MMC_DEBUG around this debug message.
Thanks.

>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =C2=A0drivers/mmc/core/core.c | =C2=A0 =C2=A06 ++++++
> =C2=A01 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8a19143..6b72eb8 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -188,6 +188,12 @@ mmc_start_request(struct mmc_host *host, struct =
mmc_request *mrq)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct scatterlist *sg;
> =C2=A0#endif
>
> + =C2=A0 =C2=A0 =C2=A0 if (mrq->sbc) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_debug("<%s: sta=
rting CMD%u arg %08x flags %08x>\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mmc_hostname(host), mrq->sbc->opcode,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0mrq->sbc->arg, mrq->sbc->flags);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pr_debug("%s: starting CMD%u arg %08x flag=
s %08x\n",
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mmc_hostname(=
host), mrq->cmd->opcode,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mrq->cmd->arg=
, mrq->cmd->flags);
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
