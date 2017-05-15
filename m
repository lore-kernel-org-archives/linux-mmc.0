From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/8] mmc: dt: pwrseq-simple: Invent power-off-delay-us
Date: Mon, 15 May 2017 13:08:25 +0200
Message-ID: <CAPDyKFqhbGqanoQqFsLrLaBXsQ5WdFrrunkvB2eOoJqH+W6jdQ@mail.gmail.com>
References: <1494260477-25163-1-git-send-email-ulf.hansson@linaro.org>
 <1494260477-25163-2-git-send-email-ulf.hansson@linaro.org> <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170512200300.a2hq546ra42ptlz5@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Wei Xu <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 12 May 2017 at 22:03, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, May 08, 2017 at 06:21:10PM +0200, Ulf Hansson wrote:
>> During power off, after the GPIO pin has been asserted, some devices like
>> the Wifi chip from TI, Wl18xx, needs a delay before the host continues with
>> clock gating and turning off regulators as to follow a graceful shutdown
>> sequence.
>>
>> Therefore invent an optional power-off-delay-us DT binding for
>> mmc-pwrseq-simple, to allow us to support this constraint.
>
> Do you really need this to be programmable per device. A delay is not
> going to hurt devices that don't need it.

Well, that depends on what "hurt" means. The device would still be
properly shut down, only that it would take unnecessary longer to do
so.

I think the problem here, is that this delay may also affect system
suspend/resume time of the device, if the device powers off/on in this
sequence.

>
> Sorry, but this is exactly what I don't like about "simple" bindings:
> adding one property at a time.

I understand you opinion, which in the end is a matter of taste/flavor.

However, for me this just follows the existing approach - and suddenly
say no to this, doesn't really seems right either.

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
