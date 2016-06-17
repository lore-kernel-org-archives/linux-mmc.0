From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Fri, 17 Jun 2016 12:16:48 -0500
Message-ID: <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com> <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44284 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933704AbcFQRRM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 17 Jun 2016 13:17:12 -0400
In-Reply-To: <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Chen <peter.chen@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Stephen Boyd <stephen.boyd@linaro.org>, oscar@naiandei.net, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linux USB List <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, troy.kisky@boundarydevices.com, Javier Martinez Canillas <javier@osg.samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>, Fabio Estevam <festevam@gmai>

On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
> Add binding doc for generic usb power sequence driver, and update
> generic usb device binding-doc accordingly.
>
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
>  .../devicetree/bindings/usb/usb-device.txt         |  2 ++
>  2 files changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
>
> diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> new file mode 100644
> index 0000000..8ad98382
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
> @@ -0,0 +1,31 @@
> +The power sequence for generic USB Devices
> +
> +Some hard-wired USB devices need to do power sequence to let the
> +device work normally, the typical power sequence like: enable USB
> +PHY clock, toggle reset pin, etc. But current Linux USB driver
> +lacks of such code to do it, it may cause some hard-wired USB devices
> +works abnormal or can't be recognized by controller at all. The
> +power sequence will be done before this device can be found at USB
> +bus.
> +
> +Required properties:
> +- compatible : contains "usb-pwrseq-generic".

In case I have not been clear, no.

I am not going to accept anything along the lines of the current mmc
pwrseq. I am basically okay with Krzysztof's proposal as it is *only*
an added property and not a duplication of information. I'd suggest
you figure out how to make the kernel work with that rather than
trying to work-around whatever kernel limitations there are.

Rob
