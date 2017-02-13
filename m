From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/4] mmc: host: tmio: don't BUG on unsupported stop
 commands
Date: Mon, 13 Feb 2017 13:40:50 +0100
Message-ID: <20170213124050.GB29718@verge.net.au>
References: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
 <20170212111227.1550-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170212111227.1550-4-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 12, 2017 at 12:12:26PM +0100, Wolfram Sang wrote:
> Halting the kernel on an unsupported stop command seems overkill, report
> the error and say what we already did (due to autocmd12) instead.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
