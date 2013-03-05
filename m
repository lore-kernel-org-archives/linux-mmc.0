From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/12] ARM: mxs: move to generic DMA device tree binding
Date: Tue, 5 Mar 2013 19:39:00 +0000
Message-ID: <201303051939.00808.arnd@arndb.de>
References: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1362486244-24593-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Marek Vasut <marek.vasut@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>, Huang Shijie <b32955@freescale.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <dedekind1@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Chris Ball <cjb@laptop.org>, alsa-devel@alsa-project.org, linux-serial@vger.kernel.org, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 05 March 2013, Shawn Guo wrote:
> The series converts mxs-dma and its clients to generic DMA device tree
> binding/helper.
> 
> I published a branch below to ease people who is willing to help
> testing the series.

Looks all good, aside from the bug I found in the first patch.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
