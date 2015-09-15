From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH-v2 0/3] mmc: sdhci-pxav3: Fix tabbing issue
Date: Tue, 15 Sep 2015 14:28:33 +0200
Message-ID: <CAPDyKFov6uADy_o944hZS9es6hkr4WM9EV1t9MXe94TcwEHuwQ@mail.gmail.com>
References: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441625471-16315-1-git-send-email-vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vaibhav Hiremath <vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 7 September 2015 at 13:31, Vaibhav Hiremath
<vaibhav.hiremath-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Trivial patch-series, which fixes the tabbing issue in the driver,
> uses the BIT macro for bit fields and prints notice on -EPROBE_DEFER
> in sdhci_add_host() function on regulator unavailability.
>
> V1 => V2
> ========
>  - Fixed all comments from Joe, mostly alignment changes
>  - Separated BIT macro usage patch into new one.
>  - changed error to kernel notice for EPROBE_DEFER in sdhci_add_host()
>
> Note: This patch-series should get merged before another series -
>
> [PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller
>
> Vaibhav Hiremath (3):
>   mmc: sdhci-pxav3: Fix tabbing issue
>   mmc: sdhci-pxav3: Use BIT macro for bit field definitions
>   mmc: sdhci: print notice on -EPROBE_DEFER in sdhci_add_host() fn
>
>  drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
>  drivers/mmc/host/sdhci.c       |  5 ++++-
>  2 files changed, 27 insertions(+), 24 deletions(-)
>
> --
> 1.9.1
>

Hi Vaibhav,

FYI, I won't be picking up any of these patches. Primarily because I
don't think they improves the code and other people also seems to
agree to that.

Regarding patch1 and similar patches which deals with only fixing
checkpatch warnings/errors. In most cases I don't like such changes,
as they makes it harder to use "git blame" when you want to find out
which commit that introduced a change.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
