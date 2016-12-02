From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: pwrseq-simple: allow inverting of off state logic
Date: Fri, 2 Dec 2016 07:57:41 +0100
Message-ID: <CAPDyKFrYVL52N22JVDA3wiWLAwUhht+6-=fi9kbGA8DYu=zPiA@mail.gmail.com>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting> <1480659462-29536-4-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480659462-29536-4-git-send-email-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2 December 2016 at 07:17, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org> wrote:
> Some devices need a logic level low instead of high to be in the
> off state.
>
> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
> ---
>  .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt         |  2 ++
>  drivers/mmc/core/pwrseq_simple.c                          | 15 +++++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> index 703a714201d8..bea306d772d1 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
> @@ -22,6 +22,8 @@ Optional properties:
>         the reset-gpios (if any) are asserted
>  - post-power-on-delay-ms : Delay in ms after powering the card and
>         de-asserting the reset-gpios (if any)
> +- invert-off-state: Invert the power down state for the reset-gpios (if any)
> +       and pwrdn-gpios (if any)

We already have DT bindings to describe GPIO pins as active high or
low. I think we should be able to use that instead, don't you think?

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
