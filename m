From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: host: tmio: drop superfluous exit path
Date: Fri, 6 Jan 2017 09:51:22 +0100
Message-ID: <20170106085122.GA24437@verge.net.au>
References: <20170106083833.22137-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170106083833.22137-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 06, 2017 at 09:38:33AM +0100, Wolfram Sang wrote:
> The probe exit path on error does nothing since commit 94b110aff8679b
> ("mmc: tmio: add tmio_mmc_host_alloc/free()"), so we can bail out
> immediately.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
