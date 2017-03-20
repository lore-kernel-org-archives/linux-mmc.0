From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: tmio: always get number of taps
Date: Mon, 20 Mar 2017 09:30:57 +0100
Message-ID: <20170320083057.GD21538@verge.net.au>
References: <20170317090450.18593-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317090450.18593-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 17, 2017 at 10:04:50AM +0100, Wolfram Sang wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> 
> Current code gets number of taps only once and keeps the value. This is
> not correct, we need to obtain it every time before executing tuning,
> so remove the outer if-block.
> 
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> [wsa: extracted from a larger patch and reworded commit message]
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
