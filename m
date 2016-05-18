From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Consider HLE errors to be data and command errors
Date: Tue, 17 May 2016 21:12:16 -0700
Message-ID: <CAD=FV=VneQR3wurjezBkRhtQiH+q-FfhDN8=Ym=XqtZpVmsdUw@mail.gmail.com>
References: <1426002490-2014-1-git-send-email-dianders@chromium.org>
 <5502CA4E.9060401@samsung.com> <CAD=FV=VX3ix-j4y95W1q8b-aVuVEN+4xsd8WLx2xcE7KPNJwRw@mail.gmail.com>
 <5506707D.40708@samsung.com> <55189F04.8000404@samsung.com>
 <CAD=FV=WFAZqAsXOqunt0fxw87M-FruwUrxuzW0MJsG6UvfSjzA@mail.gmail.com>
 <CAD=FV=UJGcwa_biSCGhD=kS-T+fppCniBFfOHb5ohnwSwSwMMA@mail.gmail.com> <573BCC8D.5090606@kernel-upstream.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35778 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbcEREMS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2016 00:12:18 -0400
Received: by mail-vk0-f47.google.com with SMTP id f66so46211729vkh.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 May 2016 21:12:18 -0700 (PDT)
In-Reply-To: <573BCC8D.5090606@kernel-upstream.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@kernel-upstream.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi,

On Tue, May 17, 2016 at 6:59 PM, Shawn Lin
<shawn.lin@kernel-upstream.org> wrote:
> Could you try this patch to see if you can still find HLE?
>
> @@ -2356,12 +2356,22 @@ static void dw_mci_cmd_interrupt(struct dw_mci
> *host, u32 status)
>  static void dw_mci_handle_cd(struct dw_mci *host)
>  {
>         int i;
> +       int present;
>
>         for (i = 0; i < host->num_slots; i++) {
>                 struct dw_mci_slot *slot = host->slot[i];
>
>                 if (!slot)
>                         continue;
>
> +               present = !(mci_readl(slot->host, CDETECT) & (1 <<
> slot->id));
> +               if (present)
> +                       set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> +               else
> +                       clear_bit(DW_MMC_CARD_PRESENT, &slot->flags);

No, because we don't use the builtin card detect on veyron.  ;)

We use GPIO card detect because we didn't like the way JTAG and SD
interacted.  Also on rk3288 the builtin card detect line had the wrong
voltage domain (you couldn't detect a card when the IO lines were
powered off).  The builtin card detect line is always driven low on
veyron.


I'm nearly certain that the root cause of my HLE errors is actually
related to the same problem addressed by the commit 7c5209c315ea
("mmc: core: Increase delay for voltage to stabilize from 3.3V to
1.8V").  I think that on minnie we're still on the hairy edge and
sometimes the line doesn't transition fast enough.

It appears that increasing this to 30ms avoids the HLE errors.

I _think_ I can actually fully fix this properly by temporarily
engaging the internal pull-ups while the voltage switch is happening.
This will bleed away the voltage just a little bit faster (since lines
are driven low here).  I'll try to confirm that.


In any case, it seems like we should take this patch since (without
this patch) the failure case when you get HLE errors is that the
interrupt controller fires over and over again (with no printouts) and
your system stalls with no error messages.

-Doug
