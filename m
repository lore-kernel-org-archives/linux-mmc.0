From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [v4 0/2] Fix incorrect capability
Date: Mon, 12 Sep 2016 14:35:36 +0200
Message-ID: <CAPDyKFp9K6=Tia3AOX4wT_R_N6x3XizGZoMws1jymKa3iNr8TA@mail.gmail.com>
References: <20160909020840.2718-1-jaedon.shin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160909020840.2718-1-jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Al Cooper <alcooperx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 9 September 2016 at 04:08, Jaedon Shin <jaedon.shin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi all,
>
> This patch serise fixes incorrect capability bit about ADMA 64-bit on
> MIPS based BRCMSTB SoCs. This also includes the change of DT bindings.
>
> Changes in v4:
> - Added commit message to change example nodes.
> - Fixed spelling mistake.
>
> Jaedon Shin (2):
>   mmc: DT: sdhci-brcmstb: Bindings document for common sdhci-brcmstb
>   mmc: sdhci-brcmstb: Fix incorrect capability
>
>  .../mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt}        | 8 +++++---
>  drivers/mmc/host/sdhci-brcmstb.c                                  | 3 +++
>  2 files changed, 8 insertions(+), 3 deletions(-)
>  rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt} (81%)
>
> --
> 2.10.0
>

Thanks, applied for next!

I reverted the change from the DT example code, as Rob pointed out
it's an unnecessary change.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
