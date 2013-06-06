From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v3 1/2] mmc: tmio: fix unbalanced power-on calls with clock-gating enabled
Date: Thu, 06 Jun 2013 11:48:38 -0400
Message-ID: <8761xr6y09.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
	<871u8f8nxb.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1306061625290.32566@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1306061625290.32566@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 6 Jun 2013 16:35:44 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Jun 06 2013, Guennadi Liakhovetski wrote:
> With MMC clock gating enabled the MMC core currently calls MMC host driver's
> .set_ios() method with .power_mode == MMC_POWER_ON and the clock value set
> either to 0 or to the target rate. The tmio MMC driver then wrongly
> translates the latter calls to card slot power-on requests, even when the
> slot already was on. This patch fixes the driver to avoid needlessly
> incrementing power-supplying regulator's use count.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>
> v3: rebased on top of current mmc-next / 3.10-rc

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
