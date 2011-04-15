From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: fix a race between card-detect rescan and clock-gate
 work instances
Date: Fri, 15 Apr 2011 14:29:33 -0500
Message-ID: <BANLkTimR5GfpvDrFgFi6TXw5kGdbtSqPeg@mail.gmail.com>
References: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:58615 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756707Ab1DOT3g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2011 15:29:36 -0400
In-Reply-To: <Pine.LNX.4.64.1104152006110.18593@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <damm@opensource.se>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>

On Fri, Apr 15, 2011 at 1:08 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently there is a race in the MMC core between a card-detect
> rescan work and the clock-gating work, scheduled from a command
> completion. Fix it by removing the dedicated clock-gating mutex and
> using the MMC standard locking mechanism instead.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <damm@opensource.se>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> ---
> =A0drivers/mmc/core/host.c =A0| =A0 =A09 ++++-----
> =A0include/linux/mmc/host.h | =A0 =A01 -
> =A02 files changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 461e6a1..2b200c1 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -94,7 +94,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_ho=
st *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock=
, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mutex_lock(&host->clk_gate_mutex);
> + =A0 =A0 =A0 mmc_claim_host(host);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->clk_lock, flags);
> =A0 =A0 =A0 =A0if (!host->clk_requests) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock=
, flags);
> @@ -104,7 +104,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_=
host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_debug("%s: gated MCI clock\n", mmc_=
hostname(host));
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock, flags);
> - =A0 =A0 =A0 mutex_unlock(&host->clk_gate_mutex);
> + =A0 =A0 =A0 mmc_release_host(host);
> =A0}
>
> =A0/*
> @@ -130,7 +130,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
> =A0{
> =A0 =A0 =A0 =A0unsigned long flags;
>
> - =A0 =A0 =A0 mutex_lock(&host->clk_gate_mutex);
> + =A0 =A0 =A0 mmc_claim_host(host);
> =A0 =A0 =A0 =A0spin_lock_irqsave(&host->clk_lock, flags);
> =A0 =A0 =A0 =A0if (host->clk_gated) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock=
, flags);
> @@ -140,7 +140,7 @@ void mmc_host_clk_ungate(struct mmc_host *host)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0host->clk_requests++;
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->clk_lock, flags);
> - =A0 =A0 =A0 mutex_unlock(&host->clk_gate_mutex);
> + =A0 =A0 =A0 mmc_release_host(host);
> =A0}
>
> =A0/**
> @@ -215,7 +215,6 @@ static inline void mmc_host_clk_init(struct mmc_h=
ost *host)
> =A0 =A0 =A0 =A0host->clk_gated =3D false;
> =A0 =A0 =A0 =A0INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work=
);
> =A0 =A0 =A0 =A0spin_lock_init(&host->clk_lock);
> - =A0 =A0 =A0 mutex_init(&host->clk_gate_mutex);
> =A0}
>
> =A0/**
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index bcb793e..eb792cb 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -183,7 +183,6 @@ struct mmc_host {
> =A0 =A0 =A0 =A0struct work_struct =A0 =A0 =A0clk_gate_work; /* delaye=
d clock gate */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0clk_old; =A0 =A0 =A0=
 =A0/* old clock value cache */
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0clk_lock; =A0 =A0=
 =A0 /* lock for clk fields */
> - =A0 =A0 =A0 struct mutex =A0 =A0 =A0 =A0 =A0 =A0clk_gate_mutex; /* =
mutex for clock gating */
> =A0#endif
>
> =A0 =A0 =A0 =A0/* host specific block data */
> --
> 1.7.2.5

I've looked at this when Guennadi sent the original email and it looks
good to me FWIW.

A
