From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Do not set MMC_CAP_1_8V_DDR in the
 'no-1-8-v' case
Date: Fri, 12 Jun 2015 09:22:15 -0300
Message-ID: <CAOMZO5CSG0uu+yC7tYnW2MXZz_5ZGfpD68QE1uiXfNPxAT_29g@mail.gmail.com>
References: <1434060503-10260-1-git-send-email-festevam@gmail.com>
	<20150612032223.GC16730@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20150612032223.GC16730@shlinux1.ap.freescale.net>
Sender: stable-owner@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Aisheng Dong <aisheng.dong@freescale.com>, kevin.lemoi@savant.com, Otavio Salvador <otavio@ossystems.com.br>, Sascha Hauer <kernel@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Dong,

On Fri, Jun 12, 2015 at 12:22 AM, Dong Aisheng <b29396@freescale.com> wrote:

> I think this patch will break the eMMC DDR 3.3v mode support.

I don't think so.

This patch only changes the behaviour when 'no-1-8-v' property is used.

This custom board has an eMMC that can operate at 1.8V, but the board
itself can only provide 3.3V.

In this case we need to pass 'no-1-8-v' as explained in
Documentation/devicetree/bindings/mmc/mmc.txt:

"- no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
  this system, even if the controller claims it is."

Then in this case we should not set MMC_CAP_1_8V_DDR, which will make
the card to work at 3.3V.

Regards,

Fabio Estevam
