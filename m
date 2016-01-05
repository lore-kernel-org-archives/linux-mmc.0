From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 00/11] mmc: use sdhci_pltfm_init for private allocation and clean up
Date: Tue, 05 Jan 2016 12:45:19 +0100
Message-ID: <8511961.x8LNDTDGG7@wuerfel>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, srinivas.kandagatla-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, maxime.coquelin-qxv4g6HH51o@public.gmane.org, patrice.chotard-qxv4g6HH51o@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 05 January 2016 18:51:28 Jisheng Zhang wrote:
> These patches are to complete the TODO in Commit 0e748234293f ("mmc:
> sdhci: Add size for caller in init+register"), I.E:
> 
> - todo: migrate clients to using allocation this way
> - todo: remove priv variable once migration is complete
> 

Very nice series!

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

	Arnd
