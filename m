From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/4] mmc: slot-gpio: switch to use flags when getting GPIO
Date: Mon, 22 Sep 2014 14:37:51 +0200
Message-ID: <CACRpkdbBq0VCBAOv7QX8pk73-_hU5Yy6QWURr5NohpG+osaYow@mail.gmail.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org>
	<CAPDyKFqw2N9zg41iz=qo3kQghmdYpafYdy545NYuu-Ji6pJELQ@mail.gmail.com>
	<541FDBC0.4020302@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <541FDBC0.4020302@intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 22, 2014 at 10:20 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:

> Unfortunately it doesn't seem to work.  I needed the patch
> below.
>
>
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Mon, 22 Sep 2014 11:01:16 +0300
> Subject: [PATCH] gpio: Fix gpio direction flags not getting set
>
> GPIO direction flags are not getting set because
> an 'if' statement is the wrong way around.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Oopps that's a bug, patch applied for fixes, so it'll work when
this hits upstream.

Alex: confirm?

Yours,
Linus Walleij
