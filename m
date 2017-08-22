From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v3] mmc: renesas_sdhi: Add r8a7743/5 support
Date: Tue, 22 Aug 2017 10:00:08 +0200
Message-ID: <20170822080008.GE30838@verge.net.au>
References: <CAMuHMdWUxxp75u1VSLY3WnObmhSMDvP3skr9Uf3rV4Bf-ixy_w@mail.gmail.com>
 <1503318311-48664-1-git-send-email-biju.das@bp.renesas.com>
 <20170821124305.GA4276@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170821124305.GA4276@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Biju Das <biju.das@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Magnus Damm <magnus.damm@gmail.com>, Chris Paterson <chris.paterson2@renesas.com>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 21, 2017 at 02:43:05PM +0200, Wolfram Sang wrote:
> On Mon, Aug 21, 2017 at 01:25:11PM +0100, Biju Das wrote:
> > Add support for r8a7743/5 SoC. Renesas RZ/G1[ME] (R8A7743/5) SDHI
> > is identical to the R-Car Gen2 family.
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Its probably time for some fallback compatibility strings but
I think that should be done as follow-up (likely by me) in a considered
way. So this patch is fine in my books.

Acked-by: Simon Horman <horms+renesas@verge.net.au>
