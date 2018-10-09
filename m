From: Adam Ford <aford173@gmail.com>
Subject: Pinmuxing and SDHC speeds on sdhci-esdhc-imx
Date: Tue, 9 Oct 2018 08:38:27 -0500
Message-ID: <CAHCN7xJnqbzyx=wFw4XY+NWRP_Y4RTVjeeyU3wSAsGtSUyG9Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, aisheng.dong@nxp.com, haibo.chen@freescale.com, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-mmc@vger.kernel.org

I have a question regarding the pinstate and the corresponding uhs_signaling.

The uhs_signaling shows a variety of timing options,

 MMC_TIMING_UHS_SDR12,  MMC_TIMING_UHS_SDR25:,  MMC_TIMING_UHS_SDR50,
MMC_TIMING_UHS_SDR104,  MMC_TIMING_MMC_HS200,  MMC_TIMING_UHS_DDR50,
MMC_TIMING_MMC_DDR52,  MMC_TIMING_MMC_HS400, and MMC_TIMING_LEGACY

However the esdhc_change_pinstate function only lists
MMC_TIMING_UHS_SDR50, MMC_TIMING_UHS_DDR50, MMC_TIMING_UHS_SDR104,
MMC_TIMING_MMC_HS200, and MMC_TIMING_MMC_HS40, and a defaut.

>From what I can tell, this means that  MMC_TIMING_MMC_DDR52 uses the
default pinmux.  I am wondering if it should use pins_100mhz.  We have
an eMMC part that we want to operate at this point and it seems like
it missing.  If so, I can submit a patch.

It also seems like that SDR12, SDR25 use the default.  I assume this is OK.

adam
