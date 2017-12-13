From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] mmc: renesas_sdhi: Add MODULE_LICENSE
Date: Wed, 13 Dec 2017 09:30:24 +0100
Message-ID: <20171213083023.5yclad7bnjfh3gxy@verge.net.au>
References: <1513132380-7421-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1513132380-7421-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: stable-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Dec 13, 2017 at 11:33:00AM +0900, Yoshihiro Shimoda wrote:
> From: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> 
> The following error occurs when loading renesas_sdhi_core.c module,
> so add MODULE_LICENSE("GPL v2").
> 
>  renesas_sdhi_core: module license 'unspecified' taints kernel.
> 
> Signed-off-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
> Fixes: 9d08428afb72 ("mmc: renesas-sdhi: make renesas_sdhi_sys_dmac main module file")
> Cc: <stable@vger.kernel.org> # v4.13+
> [Shimoda: Added Fixes tag and Cc to the stable ML]
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
