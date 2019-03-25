From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: usdhi6rol0: mark expected switch fall-throughs
Date: Mon, 25 Mar 2019 14:26:35 +0100
Message-ID: <CAPDyKFoJPZBWZk+htuuvDyAYRVMML=tOMrij5P1v02XGm2DU3Q@mail.gmail.com>
References: <20190320200010.GA14527@embeddedor> <CAPDyKFq7Qcp+WZazg2CiB_nBV7Bsmns2aD-Na_k72Kk9sf9X2g@mail.gmail.com>
 <a69a2138-0515-82f7-ab32-21d62c248829@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a69a2138-0515-82f7-ab32-21d62c248829@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

[...]

> >> @@ -1688,6 +1688,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
> >>         default:
> >>                 dev_err(mmc_dev(host->mmc), "Invalid state %u\n", host->wait);
> >>                 /* mrq can be NULL in this actually impossible case */
> >> +               /* fall through */
> >
> > Please make this one comment.
> >
> >>         case USDHI6_WAIT_FOR_CMD:
> >>                 usdhi6_error_code(host);
> >>                 if (mrq)
> >> @@ -1713,6 +1714,7 @@ static void usdhi6_timeout_work(struct work_struct *work)
> >>                  * If USDHI6_WAIT_FOR_DATA_END times out, we have already unmapped
> >>                  * the page
> >>                  */
> >> +               /* fall through */
> >
> > Ditto.
> >
>
> OK.  The reason why I didn't do that is because the line would exceed the 80 characters
> in both cases. But I'll respin if you are OK with that.
>

What's wrong with having several lines per comment-section?

Kind regards
Uffe
