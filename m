From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v3 0/6] UHS-I support for sh_mobile_sdhi
Date: Fri, 26 Jun 2015 16:25:38 +0100
Message-ID: <1435332338.23818.15.camel@codethink.co.uk>
References: <1435332116.23818.7.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435332116.23818.7.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

I accidentally used an older shortlog and diffstat in that cover mail;
here are the correct ones.

Ben.

Ben Hutchings (5):
  mmc: tmio: Add UHS-I mode support
  pinctrl: sh-pfc: Implement pinconf power-source param for voltage
    switching
  pinctrl: sh-pfc: r8a7790: Implement voltage switching for SDHI
  mmc: sh_mobile_sdhi: Add UHS-I mode support
  ARM: shmobile: lager: Enable UHS-I SDR-50

Ian Molton (1):
  ARM: shmobile: lager: Set clock rates for SDHI

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  4 +-
 arch/arm/boot/dts/r8a7790-lager.dts                | 28 ++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c                  | 60 +++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h                        |  3 +
 drivers/mmc/host/tmio_mmc_pio.c                    | 31 ++++++++++
 drivers/pinctrl/sh-pfc/core.c                      |  2 +-
 drivers/pinctrl/sh-pfc/core.h                      |  1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c               | 67 +++++++++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   | 34 ++++++++++-
 drivers/pinctrl/sh-pfc/sh_pfc.h                    |  6 ++
 10 files changed, 229 insertions(+), 7 deletions(-)


