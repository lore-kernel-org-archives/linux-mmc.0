From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Date: Fri, 17 Aug 2018 12:02:01 +0200
Message-ID: <20180817100201.d762mirtkngr3am5@verge.net.au>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180815202405.GA13760@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180815202405.GA13760@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Aug 15, 2018 at 02:24:05PM -0600, Rob Herring wrote:
> On Tue, Aug 14, 2018 at 01:34:34PM +0100, Fabrizio Castro wrote:
> > Document RZ/G2M (R8A774A1) SoC bindings.
> > 
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Not sure why you didn't use 'dt-bindings: mmc: ' for the subject like 
> the others, but anyways:
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
