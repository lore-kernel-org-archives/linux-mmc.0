From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
Subject: Re: [PATCH 2/2] sound: tegra_alc5632: Adjust to of_get_named_gpio() change
Date: Mon, 18 Jun 2012 14:28:25 -0300
Message-ID: <CAAAP30G1qzDn+NKT1is+GJ9K2DS3Sm3QY+=n7s-P-Rop2b7FPQ@mail.gmail.com>
References: <1340037743-12924-1-git-send-email-stigge@antcom.de>
	<1340037743-12924-2-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340037743-12924-2-git-send-email-stigge@antcom.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Roland Stigge <stigge@antcom.de>
Cc: swarren@wwwdotorg.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 18, 2012 at 1:42 PM, Roland Stigge <stigge@antcom.de> wrote:
> of_get_named_gpio() was changed to return -EPROBE_DEFER in case of
> gpios not probed yet. This patch adjusts tegra_alc5632 to this.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
Acked-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
