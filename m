From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] mmc: renesas_sdhi: Add r8a774a1 support
Date: Wed, 15 Aug 2018 14:24:05 -0600
Message-ID: <20180815202405.GA13760@rob-hp-laptop>
References: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1534250074-15890-3-git-send-email-fabrizio.castro@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 14, 2018 at 01:34:34PM +0100, Fabrizio Castro wrote:
> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Not sure why you didn't use 'dt-bindings: mmc: ' for the subject like 
the others, but anyways:

Reviewed-by: Rob Herring <robh@kernel.org>
