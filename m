From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 4/4] mmc: host: tmio: fill in response from auto cmd12
Date: Mon, 13 Feb 2017 13:58:19 +0100
Message-ID: <20170213125819.GC29718@verge.net.au>
References: <20170212111227.1550-1-wsa+renesas@sang-engineering.com>
 <20170212111227.1550-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170212111227.1550-5-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 12, 2017 at 12:12:27PM +0100, Wolfram Sang wrote:
> After we received the dataend interrupt, R1 response register carries
> the value from the automatically generated stop command. Report that
> info back to the MMC block layer, so we will be notified in case of e.g.
> ECC errors which happened during the last transfer.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
