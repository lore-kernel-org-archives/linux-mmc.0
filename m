From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: fix typo around pr_info() call
Date: Thu, 3 Nov 2011 17:42:36 +0530
Message-ID: <CANfBPZ-Z5PZFwW1uderk5A1FzNKFq=9f-RTOSg0Lre5CX-NDUw@mail.gmail.com>
References: <1320319482-9809-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36691 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933172Ab1KCMM6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 3 Nov 2011 08:12:58 -0400
Received: by mail-iy0-f177.google.com with SMTP id p10so1549177iap.8
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2011 05:12:57 -0700 (PDT)
In-Reply-To: <1320319482-9809-1-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Thu, Nov 3, 2011 at 4:54 PM, Daniel Mack <zonque@gmail.com> wrote:
> This was introduced by a3c76eb9 ("mmc: replace printk with appropriat=
e
> display macro").
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Girish K S <girish.shivananjappa@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index e8ff123..101cd31 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap=
_hsmmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->protect_card) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info"%s: cover is op=
en, "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_info("%s: cover is o=
pen, "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "card is now inaccessible\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(host->mmc));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->protect_card =3D=
 1;
> --
> 1.7.6.4
>

Thanks ! But this has been fixed and is available in mmc-next
