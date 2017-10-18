From: Jiancheng Xue <xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>
Subject: [PATCH 0/2] mmc: add an specific emmc driver for hi3798cv200-poplar board
Date: Wed, 18 Oct 2017 07:16:26 -0400
Message-ID: <1508325388-7260-1-git-send-email-xuejiancheng@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, project-aspen-dev-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xuejiancheng-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org, hermit.wangheming-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add an specific emmc driver for hi3798cv200-poplar board. Previously, it used the
generic dw-mmc driver with lower performance.

tianshuliang (2):
  dt-bindings: mmc: add bindings for hi3798cv200-dw-mshc
  mmc: dw_mmc: add support for hi3798cv200 specific extensions of
    dw-mshc

 .../bindings/mmc/hi3798cv200-dw-mshc.txt           |  51 ++++++
 drivers/mmc/host/Kconfig                           |   9 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/dw_mmc-hi3798cv200.c              | 191 +++++++++++++++++++++
 4 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/hi3798cv200-dw-mshc.txt
 create mode 100644 drivers/mmc/host/dw_mmc-hi3798cv200.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
