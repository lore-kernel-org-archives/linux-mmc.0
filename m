From: Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH v2] mmc: mxs-mmc: Introduce regulator support
Date: Mon, 28 Jan 2019 11:27:30 +0100
Message-ID: <20190128112730.0175049d@erd987>
References: <20190128102022.1880-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128102022.1880-1-martink@posteo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Martin Kepplinger <martink@posteo.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>
List-Id: linux-mmc@vger.kernel.org

Hi Martin,

On Mon, 28 Jan 2019 11:20:22 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds support for explicitly switching the mmc's power on and off
> which is needed for example for WL1837 wifi controllers. ip link set wlan0 down
> doesn't turn off the VMMC regulator which leads to hangs when loading firmware.
> 
> Tested on i.MX28.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> again, this isn't new. it's (rebased and simplified)
> https://patchwork.kernel.org/patch/4365751/
> 
> Thanks Robin for your input!
> 
> revision history
> ----------------
> v1: was just a question why this hasn't gone in earlier.

Not sure why it never made it. I created it for use with a wl1271 which
wan't properly reset in case of a fault. Also combined with imx28.

Regards,
Robin van der Gracht
