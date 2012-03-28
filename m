From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] sh: ecovec: switch SDHI controllers to card polling
Date: Wed, 28 Mar 2012 15:27:53 +0900
Message-ID: <20120328062753.GU26543@linux-sh.org>
References: <Pine.LNX.4.64.1201281929450.27970@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1201281929450.27970@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sat, Jan 28, 2012 at 07:36:24PM +0100, Guennadi Liakhovetski wrote:
> Polling for card hotplug events is a better option than using SDHI native
> hotplug interrupt, because the latter option forces the controller to stay
> permanently powered up and enabled.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> It is a kind of an RFC. We do in general prefer SDHI polling to SDHI 
> native hotplug detection for the above reason, but there might well be 
> other reasons, why this is not a good idea in this specific case. If there 
> are such, I'd love to hear about them.
> 
I've not heard any more about this one way or the other, so should I
assume you still want it applied? At least we can revert it if one of
these cases pops up, and in the interim it's always preferable to lean
towards better power management for a default.
