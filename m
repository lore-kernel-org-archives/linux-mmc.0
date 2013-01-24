From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Date: Thu, 24 Jan 2013 10:39:48 -0500
Message-ID: <87pq0uh9ob.fsf@laptop.org>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
	<1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
	<Pine.LNX.4.64.1301241630160.7826@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1301241630160.7826@axis700.grange> (Guennadi
	Liakhovetski's message of "Thu, 24 Jan 2013 16:34:45 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Jan 24 2013, Guennadi Liakhovetski wrote:
> After an internal discussion it occurred to us, that this binding
>
> On Wed, 23 Jan 2013, Guennadi Liakhovetski wrote:
>
> [snip]
>
>> +- toshiba,mmc-cap-sdio-irq	: SDIO IRQ signalling should be used, if
>> +	supported by the hardware, i.e. set MMC_CAP_SDIO_IRQ if
>> +	TMIO_MMC_SDIO_IRQ is also set
>
> actually isn't tmio-mmc specific, so, it can be moved to [1] as
>
> +- cap-mmc-sdio-irq: SDIO IRQ is supported on this hardware
>
> Chris, what do you think?

Sounds right; perhaps we should call it "enable-sdio-irq" for consistency
with the existing "enable-sdio-wakeup" (which sets a pm_caps flag)?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
