From: Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v5 0/3] mmc: sh_mobile_sdhi: fix missing r7s72100 clocks
Date: Fri, 20 Jan 2017 22:06:01 -0500
Message-ID: <20170121030604.7672-1-chris.brandt@renesas.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Brandt <chris.brandt-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

At first this started out as a simple typo fix, until I realized
that the SDHI in the RZ/A1 has 2 clocks per channel and both need
to be turned on/off.

This patch series adds the ability to specify 2 clocks instead of
just 1, and does so for the RZ/A1 r7s72100.

This patch has been tested on an RZ/A1 RSK board. Card detect works
fine as well as bind/unbind.

v5:
* Take implementation details out of DT documentation and put into
  the driver code.

v4:
* No code changes, only text udpates to explain why there are 2 clocks
  and why we need to treat them as 1 clock.

Chris Brandt (3):
  mmc: sh_mobile_sdhi: add support for 2 clocks
  mmc: sh_mobile_sdhi: explain clock bindings
  ARM: dts: r7s72100: update sdhi clock bindings

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 24 ++++++++++++++++++++++
 arch/arm/boot/dts/r7s72100.dtsi                    | 17 ++++++++++-----
 drivers/mmc/host/sh_mobile_sdhi.c                  | 24 ++++++++++++++++++++++
 include/dt-bindings/clock/r7s72100-clock.h         |  6 ++++--
 4 files changed, 64 insertions(+), 7 deletions(-)

-- 
2.10.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
