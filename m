From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/2] mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
Date: Fri, 17 Aug 2018 12:01:51 +0200
Message-ID: <20180817100151.m7ausfrrznblhbhl@verge.net.au>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-2-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534250074-15890-2-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 14, 2018 at 01:34:33PM +0100, Fabrizio Castro wrote:
> We need r8a774a1 to be whitelisted for SDHI to work on the RZ/G2M,
> but we don't care about the revision of the SoC, so just whitelist
> the generic part number.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
