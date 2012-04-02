From: Alan Cooper <alcooperx@gmail.com>
Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't support
 UHS modes.
Date: Mon, 2 Apr 2012 14:29:18 -0400
Message-ID: <CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
References: <1331927657-2849-1-git-send-email-acooper@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51458 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab2DBS3T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 14:29:19 -0400
Received: by vcqp1 with SMTP id p1so1863823vcq.19
        for <linux-mmc@vger.kernel.org>; Mon, 02 Apr 2012 11:29:19 -0700 (PDT)
In-Reply-To: <1331927657-2849-1-git-send-email-acooper@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org

Still hoping for comments on the patch.

Thanks
Al

On Fri, Mar 16, 2012 at 3:54 PM, Al Cooper <acooper@gmail.com> wrote:
> The driver should not try to switch to 1.8V when the SD 3.0 host
> controller does not have any UHS capabilities bits set (SDR50, DDR50
> or SDR104). See page 72 of "SD Specifications Part A2 SD Host
> Controller Simplified Specification Version 3.00" under
> "1.8V Signaling Enable". Instead of setting SDR12 and SDR25 in the ho=
st
> capabilities data structure for all V3.0 host controllers, only set t=
hem
> if SDR104, SDR50 or DDR50 is set in the host capabilities register. T=
his
> will prevent the switch to 1.8V later.
>
> Signed-off-by: Al Cooper <acooper@gmail.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8d66706..cdf900e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2762,8 +2762,9 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0mmc_card_is_removable(mmc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>
> - =A0 =A0 =A0 /* UHS-I mode(s) supported by the host controller. */
> - =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 /* Any UHS-I mode in caps implies SDR12 and SDR25 suppo=
rt. */
> + =A0 =A0 =A0 if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT_SDR=
50 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_SUPPORT_DDR50))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_UHS_SDR12 | MMC=
_CAP_UHS_SDR25;
>
> =A0 =A0 =A0 =A0/* SDR104 supports also implies SDR50 support */
> --
> 1.7.6
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
