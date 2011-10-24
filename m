From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 1/1] mmc: core: Use delayed work in clock gating framework
Date: Mon, 24 Oct 2011 09:23:43 +0200
Message-ID: <CACRpkdY1WE8KrFW1qjLJk_sMivicqwDtBVzNDVN6H-3utw0isw@mail.gmail.com>
References: <1319035713-4979-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:52607 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab1JXHXo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 03:23:44 -0400
In-Reply-To: <1319035713-4979-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org

On Wed, Oct 19, 2011 at 4:48 PM, Sujit Reddy Thumma
<sthumma@codeaurora.org> wrote:

> Current clock gating framework disables the MCI clock as soon as the
> request is completed and enables it when a request arrives. This aggr=
essive
> clock gating framework when enabled cause following issues:
>
> When there are back-to-back requests from the Queue layer, we unneces=
sarily
> end up disabling and enabling the clocks between these requests since=
 8 MCLK
> clock cycles is a very short duration compared to the time delay betw=
een
> back to back requests reaching the MMC layer. This overhead can effec=
t the
> overall performance depending on how long the clock enable and disabl=
e
> calls take which is platform dependent. For example on some platforms=
 we
> can have clock control not on the local processor, but on a different
> subsystem and the time taken to perform the clock enable/disable can =
add
> significant overhead.

OK I see the problem. At one point it was suggested to use the delayed
disable facilities in runtime PM for avoiding this, but it never materi=
alized.

> Fix this by delaying turning off the clocks by posting request on
> delayed workqueue. Also cancel the unscheduled pending work, if any,
> when there is access to card.

(...)
> @@ -252,10 +252,11 @@ struct mmc_host {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_reques=
ts; =A0 /* internal reference counter */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_delay; =A0 =A0=
 =A0/* number of MCI clk hold cycles */
> =A0 =A0 =A0 =A0bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_gated;=
 =A0 =A0 =A0/* clock gated */
> - =A0 =A0 =A0 struct work_struct =A0 =A0 =A0clk_gate_work; /* delayed=
 clock gate */
> + =A0 =A0 =A0 struct delayed_work =A0 =A0 clk_gate_work; /* delayed c=
lock gate */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_old; =A0 =A0 =A0=
 =A0/* old clock value cache */
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_lock; =A0 =A0=
 =A0 /* lock for clk fields */
> =A0 =A0 =A0 =A0struct mutex =A0 =A0 =A0 =A0 =A0 =A0clk_gate_mutex; /*=
 mutex for clock gating */
> +#define MMC_CLK_GATE_DELAY =A0 =A0 50 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* =
in milliseconds*/
> =A0#endif

What's the rationale of having this in the middle of the struct
in the .h-file?

Move it inside the #ifdef in host.c instead, and also provide
some rationale about the choice of 50 ms.

Maybe we should even provide a sysfs or debugfs entry for
tweaking that value, as has been suggested in the past.
However that's no big deal for me...

Do you have a patch to your msm_sdcc.c that enables the
gating to take effect as well? Does it solve the problems
pointed out by Russell when I tried the same type of patch
to mmci.c?
http://marc.info/?l=3Dlinux-mmc&m=3D129146545916794&w=3D2

Yours,
Linus Walleij
