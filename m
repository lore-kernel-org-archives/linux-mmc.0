From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio, bcm-kona, LLVMLinux: Remove use of __initconst
Date: Wed, 24 Sep 2014 13:40:54 +0200
Message-ID: <CACRpkdZqtP+Q1NODQbT8ZfaViGvww+MwaPYPpN3_GdxZha44cQ@mail.gmail.com>
References: <20140923212922.GG12270@beef>
	<1411512908-19237-1-git-send-email-behanw@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1411512908-19237-1-git-send-email-behanw@converseincode.com>
Sender: linux-gpio-owner@vger.kernel.org
To: behanw@converseincode.com
Cc: Christian Daudt <bcm@fixthebug.org>, Chris Ball <chris@printf.net>, Alexandre Courbot <gnurou@gmail.com>, Matt Porter <mporter@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ray Jui <rjui@broadcom.com>, Mark Charlebois <charlebm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 24, 2014 at 12:55 AM,  <behanw@converseincode.com> wrote:

> From: Behan Webster <behanw@converseincode.com>
>
> The __initconst is in the wrong place, and when moved to the correct place
> it uncovers an error where the variable is used by non-init data structures.
>
> Instead merely make them const and put the const in the right spot.
>
> Signed-off-by: Behan Webster <behanw@converseincode.com>
> Reviewed-by: Mark Charlebois <charlebm@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Matt Porter <mporter@linaro.org>

Patch applied.

Yours,
Linus Walleij
