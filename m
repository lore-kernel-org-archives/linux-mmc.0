From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Subject: [PATCH 0/2] Add SDHI support to r8a774a1
Date: Tue, 14 Aug 2018 13:34:32 +0100
Message-ID: <1534250074-15890-1-git-send-email-fabrizio.castro@bp.renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Paterson <Chris.Paterson2@renesas.com>, Biju Das <biju.das@bp.renesas.com>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Dear All,

this series aims at documenting SDHI support for RZ/G2M (a.k.a. R8A774A1).

Cheers,
Fab

Fabrizio Castro (2):
  mmc: renesas_sdhi_internal_dmac: Whitelist r8a774a1
  mmc: renesas_sdhi: Add r8a774a1 support

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 4 +++-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c      | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
2.7.4
