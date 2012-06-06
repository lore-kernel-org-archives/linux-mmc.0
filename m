From: "Mark F. Brown" <mark.brown314@gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Allow CAPABILITY_1 Register to be overridden
Date: Tue, 5 Jun 2012 22:11:09 -0400
Message-ID: <CACwGpOA=wEVAdzBK9a1DsbO01OLQWRnBY0a-yfh8RJUjiq2jEQ@mail.gmail.com>
References: <prakity@marvell.com>
	<1338669006-2611-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62321 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab2FFCLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jun 2012 22:11:13 -0400
Received: by weyu7 with SMTP id u7so3995147wey.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Jun 2012 19:11:12 -0700 (PDT)
In-Reply-To: <1338669006-2611-1-git-send-email-prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

Hi Philip,

 Minor nitpicks: You should reuse SDHCI_QUIRK_MISSING_CAPS rather than
adding SDHCI_QUIRK2_MISSING_CAPS2. The less quirks the better IMHO.

Also add an initializer for caps array rather than having an else state=
ment:

Instead of this:
+       } else
+               caps[1] =3D 0;

Do this:
 u32 caps[2] =3D { 0, 0 };

-- Mark

On Sat, Jun 2, 2012 at 4:30 PM,  <philipspatches@gmail.com> wrote:
> From: Philip Rakity <prakity@marvell.com>
>
> CAPABILITY_1 can be changed by the platform code using a quirk
> CAPALBILTY_2 should also be allowed to be redefined.
>
> This is useful if UHS or other modes are not supported that
> are defined in the the register but the platform code has
> specific information that these value should be changed.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A07 +++++--
> =A0include/linux/mmc/sdhci.h | =A0 =A04 +++-
> =A02 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index e626732..0fec448 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2614,8 +2614,11 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0caps[0] =3D (host->quirks & SDHCI_QUIRK_MISSING_CAPS) =
? host->caps :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_readl(host, SDHCI_CAPABILITIES);
>
> - =A0 =A0 =A0 caps[1] =3D (host->version >=3D SDHCI_SPEC_300) ?
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_readl(host, SDHCI_CAPABILITIES_1)=
 : 0;
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps[1] =3D (host->quirks & SDHCI_QUIRK=
2_MISSING_CAPS1) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->caps1 : sdhci_readl(host, SDHCI_C=
APABILITIES_1);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 caps[1] =3D 0;
>
> =A0 =A0 =A0 =A0if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->flags |=3D SDHCI_USE_SDMA;
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index e9051e1..560fe22 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -91,6 +91,7 @@ struct sdhci_host {
> =A0 =A0 =A0 =A0unsigned int quirks2; =A0 /* More deviations from spec=
=2E */
>
> =A0#define SDHCI_QUIRK2_HOST_OFF_CARD_ON =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(1<<0)
> +#define SDHCI_QUIRK2_MISSING_CAPS1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<1)
>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IRQ =
*/
> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
> @@ -155,7 +156,8 @@ struct sdhci_host {
>
> =A0 =A0 =A0 =A0struct timer_list timer; =A0 =A0 =A0 =A0/* Timer for t=
imeouts */
>
> - =A0 =A0 =A0 unsigned int caps; =A0 =A0 =A0/* Alternative capabiliti=
es */
> + =A0 =A0 =A0 unsigned int caps; =A0 =A0 =A0/* replace capability reg=
ister 1 */
> + =A0 =A0 =A0 unsigned int caps1; =A0 =A0 /* replace capability regis=
ter 2 */
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0ocr_avail_sdio; /*=
 OCR bit masks */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0ocr_avail_sd;
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
