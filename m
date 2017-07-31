From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 12/12] mmc: bcm2835: constify mmc_host_ops structures
Date: Mon, 31 Jul 2017 07:55:16 +0200
Message-ID: <0beb2ef0-0a2d-5289-2956-af106d092cf6@i2se.com>
References: <1501307981-29745-1-git-send-email-Julia.Lawall@lip6.fr>
 <1501307981-29745-13-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:59623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdGaF4H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jul 2017 01:56:07 -0400
In-Reply-To: <1501307981-29745-13-git-send-email-Julia.Lawall@lip6.fr>
Content-Language: de-DE
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Am 29.07.2017 um 07:59 schrieb Julia Lawall:
> The mmc_host_ops structure is only stored in the ops field of an
> mmc_host structure, which is declared as const.  Thus the mmc_host_ops
> structure itself can be const.
>
> Done with the help of Coccinelle.
>
> // <smpl>
> @r disable optional_qualifier@
> identifier i;
> position p;
> @@
> static struct mmc_host_ops i@p = { ... };
>
> @ok1@
> struct mmc_host *mmc;
> identifier r.i;
> position p;
> @@
> mmc->ops = &i@p
>
> @bad@
> position p != {r.p,ok1.p};
> identifier r.i;
> struct mmc_host_ops e;
> @@
> e@i@p
>
> @depends on !bad disable optional_qualifier@
> identifier r.i;
> @@
> static
> +const
>  struct mmc_host_ops i = { ... };
> // </smpl>
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
