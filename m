From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/14] mmc: mmci: Don't pretend all variants to have
 MMCIMASK1 register
Date: Mon, 15 Jan 2018 02:01:36 +0100
Message-ID: <CACRpkdb3iS7FuGbC3n9xpazvtEW7AjbLKNZ5vKpJAv2D8c4sbA@mail.gmail.com>
References: <1515759368-16946-1-git-send-email-patrice.chotard@st.com> <1515759368-16946-2-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515759368-16946-2-git-send-email-patrice.chotard-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Patrice CHOTARD <patrice.chotard-qxv4g6HH51o@public.gmane.org>
Cc: Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 12, 2018 at 1:15 PM,  <patrice.chotard-qxv4g6HH51o@public.gmane.org> wrote:

> From: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>
>
> Two mask registers are used in order to select which events have to
> actually generate an interrupt on each IRQ line.
>
> It seems that in the single-IRQ case it's assumed that the IRQs lines
> are simply OR-ed, while the two mask registers are still present. The
> driver still programs the two mask registers separately.
>
> However the STM32 variant has only one IRQ, and also has only one mask
> register.
>
> This patch prepares for STM32 variant support by making the driver using
> only one mask register.
>
> This patch also optimize the MMCIMASK1 mask usage by caching it into
> host->mask1_reg which avoid to read it into mmci_irq().
>
> Tested only on STM32 variant. RFT for variants other than STM32
>
> Signed-off-by: Andrea Merello <andrea.merello-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>

Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
