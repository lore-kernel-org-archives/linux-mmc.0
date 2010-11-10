From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/5] mmc: do not clear the host->pm_flags when suspend
Date: Wed, 10 Nov 2010 22:28:11 +0200
Message-ID: <AANLkTik1c0G2HNcXGboP8WA8vo9YvwYkUpM2=MGf-cLW@mail.gmail.com>
References: <1289402889-14160-1-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-2-git-send-email-peppe.cavallaro@st.com>
 <1289402889-14160-3-git-send-email-peppe.cavallaro@st.com> <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:62889 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327Ab0KJU2d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Nov 2010 15:28:33 -0500
Received: by pxi15 with SMTP id 15so272936pxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 10 Nov 2010 12:28:33 -0800 (PST)
In-Reply-To: <1289402889-14160-4-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

Hi Giuseppe,

On Wed, Nov 10, 2010 at 5:28 PM, Giuseppe CAVALLARO
<peppe.cavallaro@st.com> wrote:
> HC driver will be able to use the pm_flags to
> undestand if the system can be woken-up by the driver.
> So the mmc_suspend_host hasn't to reset this field
> in the host structure.
>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 569e94d..6d2d6e4 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1276,7 +1276,6 @@ int mmc_suspend_host(struct mmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_claim_host(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detach_bus(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_release_host(host)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pm_flags =3D 0;

This is elapsed because the card is removed at this point (e.g. SDIO
returned -ENOSYS).

Why would you want to use flags, set by a function driver of an SDIO
card, that was just removed ?

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> --
> 1.5.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
