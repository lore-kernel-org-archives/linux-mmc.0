From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: Don't start commands while busy
Date: Fri, 20 Feb 2015 12:31:14 -0800
Message-ID: <CAD=FV=UyKg1AWq3=tnD=cd438c0xcE7iZCHv6uSjABfJdN-eEQ@mail.gmail.com>
References: <1424458179-5456-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43927 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbbBTUbP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Feb 2015 15:31:15 -0500
Received: by iebtr6 with SMTP id tr6so10612833ieb.10
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2015 12:31:15 -0800 (PST)
In-Reply-To: <1424458179-5456-1-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Doug Anderson <dianders@chromium.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

On Fri, Feb 20, 2015 at 10:49 AM, Doug Anderson <dianders@chromium.org> wrote:
> We've seen problems on some WiFi modules where we seem to send a CMD53
> (which requires the data lines) while the module is asserting busy.
> We shouldn't do that.
>
> The Designware Databook says that before issuing a new data transfer
> command we should check for busy, so that's what we'll do.
>
> We'll leverage the existing dw_mmc knowledge about whether it should
> wait for the previous command to finish to know whether we should
> check for busy before sending the command.  This means we won't end up
> incorrectly waiting for things like CMD52 (SDIO) or CMD13 (SD) which
> don't use the data line.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Sorry for the quick spin.  After I posted this I re-read all the
messages and it looks like Addy has an actual SD card (not SDIO) that
is also asserting busy.  He's seeing it assert busy around the clock
update.

I believe his bug can be fixed by also adding the busy check to
mci_send_cmd(), so I'll shortly post V2 of this patch.  Hopefully Addy
will be able to test all 3 of my patches together and his card will be
totally happy.

-Doug
