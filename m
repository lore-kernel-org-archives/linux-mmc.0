From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] MMC: tmio: fix unbalanced power-on calls with clock-gating enabled
Date: Thu, 06 Jun 2013 07:43:28 -0400
Message-ID: <871u8f8nxb.fsf@octavius.laptop.org>
References: <Pine.LNX.4.64.1304230916270.1422@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1304230916270.1422@axis700.grange> (Guennadi
	Liakhovetski's message of "Tue, 23 Apr 2013 09:29:44 +0200 (CEST)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Apr 23 2013, Guennadi Liakhovetski wrote:
> With MMC clock gating enabled the MMC core currently calls MMC host driver's
> .set_ios() method with .power_mode == MMC_POWER_ON and the clock value set
> either to 0 or to the target rate. The tmio MMC driver then wrongly
> translates the latter calls to card slot power-on requests, even when the
> slot already was on. This patch fixes the driver to avoid needlessly
> incrementing power-supplying regulator's use count.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This doesn't apply to mmc-next -- please could you rebase/resend?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
