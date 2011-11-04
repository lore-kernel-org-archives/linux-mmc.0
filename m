From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: Incorrect checkpatch warning
Date: Fri, 4 Nov 2011 06:23:49 -0400
Message-ID: <CAGxe1ZFxE+ktigoTQjsCx8AYJbSfT+FDa9ms4Y=d8P96enzxSA@mail.gmail.com>
References: <4EB39BB4.3060508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43446 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783Ab1KDKXv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 06:23:51 -0400
In-Reply-To: <4EB39BB4.3060508@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: joe@perches.com, linux-kernel@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>

On 4 November 2011 04:00, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
> Hi
>
> This checkpatch warning looks wrong:
>
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/v=
ariable
> #73: FILE: drivers/mmc/host/sdhci-pci-data.c:5:
> +EXPORT_SYMBOL_GPL(sdhci_pci_get_data);
>
> The patch has this:
>
> diff --git a/drivers/mmc/host/sdhci-pci-data.c b/drivers/mmc/host/sdh=
ci-pci-data.c
> new file mode 100644
> index 0000000..a611217
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-data.c
> @@ -0,0 +1,5 @@
> +#include <linux/module.h>
> +#include <linux/mmc/sdhci-pci-data.h>
> +
> +struct sdhci_pci_data *(*sdhci_pci_get_data)(struct pci_dev *pdev, i=
nt slotno);
> +EXPORT_SYMBOL_GPL(sdhci_pci_get_data);
>since it is a prototype you get that message. use EXPORT_SYMBOL below =
the function definition and not below prototype declaration
>
> Regards
> Adrian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
