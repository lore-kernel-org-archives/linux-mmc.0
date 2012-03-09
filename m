From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: tmio_mmc: do not enable card hotplug interrupts, if unused
Date: Thu, 08 Mar 2012 23:29:10 -0500
Message-ID: <m2fwdiqtwp.fsf@bob.laptop.org>
References: <alpine.DEB.2.00.1202221314351.3136@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1202221314351.3136@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 22 Feb 2012 13:16:09 +0100 (CET)")
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Feb 22 2012, Guennadi Liakhovetski wrote:
> If TMIO MMC is used in polling mode, or the card is non-removable, or
> card-detection is performed, using an external interrupt, there is no
> need to enable controller native card hotplug interrupts.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
