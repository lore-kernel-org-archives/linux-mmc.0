From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 1/8] SH: constify multiple DMA related objects and references to them
Date: Mon, 26 Apr 2010 16:10:39 +0900
Message-ID: <20100426071039.GG11770@linux-sh.org>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange> <Pine.LNX.4.64.1004211731440.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1004211731440.5292@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Wed, Apr 21, 2010 at 05:36:49PM +0200, Guennadi Liakhovetski wrote:
> Lists of DMA channels and slaves are not changed, make them constant. Besides,
> SH7724 channel and slave configuration of both DMA controllers is identical,
> remove the extra copy of the configuration data.

I've applied this one, thanks.
