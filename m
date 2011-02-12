From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: core: Allow sdio operations in other thread during sdio_add_func()
Date: Fri, 11 Feb 2011 18:34:06 -0800
Message-ID: <AANLkTimyc-sXEhnPtCjQwHbEsdnwGY-ss6SoRSqDOD+d@mail.gmail.com>
References: <loom.20110212T012443-915@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44667 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab1BLCeH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Feb 2011 21:34:07 -0500
Received: by iwn9 with SMTP id 9so3028118iwn.19
        for <linux-mmc@vger.kernel.org>; Fri, 11 Feb 2011 18:34:06 -0800 (PST)
In-Reply-To: <loom.20110212T012443-915@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

On Fri, Feb 11, 2011 at 4:25 PM, Dmitry Shmidt <dimitrysh@android.com> =
wrote:
> commit 9cb71a1eb86a2acf0762d31af633984cf9e24d32
> Author: Dmitry Shmidt <dimitrysh@google.com>
> Date: =A0 Fri Feb 11 16:10:33 2011 -0800
>
> =A0 =A0mmc: core: Allow sdio operations in other thread during sdio_a=
dd_func()
>
> =A0 =A0Signed-off-by: Dmitry Shmidt <dimitrysh@google.com>
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index dec4290..d4e6e6ef 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -834,7 +834,6 @@ int mmc_attach_sdio(struct mmc_host *host)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0mmc_release_host(host);
> =A0 =A0 =A0 =A0err =3D mmc_add_card(host->card);
> - =A0 =A0 =A0 mmc_claim_host(host);
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove_added;
>
> @@ -846,13 +845,12 @@ int mmc_attach_sdio(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto remove_added;
> =A0 =A0 =A0 =A0}
> -
> + =A0 =A0 =A0 mmc_claim_host(host);
> =A0 =A0 =A0 =A0return 0;
>
>
> =A0remove_added:
> =A0 =A0 =A0 =A0/* Remove without lock if the device has been added. *=
/
> - =A0 =A0 =A0 mmc_release_host(host);
> =A0 =A0 =A0 =A0mmc_sdio_remove(host);
> =A0 =A0 =A0 =A0mmc_claim_host(host);
> =A0remove:
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

This is important when wlan driver is doing sdio operations from anothe=
r
  thread during initialization.
This behavior was introduced as a side-effect in patch
  807e8e40673d9628fa7dcdd14423424b4ee5f43b
  mmc: Fix sd/sdio/mmc initialization frequency retries
