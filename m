From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] arm64: dts: r8a7795: set maximum frequency for SDHI
 clocks
Date: Wed, 10 Aug 2016 10:44:44 +0200
Message-ID: <20160810084443.GC6276@verge.net.au>
References: <1469120504-2037-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469120504-2037-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Jul 21, 2016 at 07:01:44PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Define the upper limit otherwise the driver cannot utilize max speeds.

Thanks, I have queued this up for v4.9.
