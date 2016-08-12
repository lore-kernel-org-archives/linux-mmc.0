From: Guodong Xu <guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v5 0/2] mmc: dw_mmc: host controller reset support
Date: Fri, 12 Aug 2016 16:51:24 +0800
Message-ID: <1470991886-22412-1-git-send-email-guodong.xu@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, guodong.xu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

mmc host controller registers may in abnormal state if mmc is used in
bootloader, eg. to load kernel from eMMC. Some controllers cann't
clear their registers when clk is set. They use dedicated reset
logics to do this.

In this patch, a 'resets' property is added into dw_mmc dts
node. When driver does parse_dt and probe, it calls reset API to
triiger 'reset' of dwmmc host controller. When probe error or
remove, it calls reset API to assert it.

Chip vendor's actual reset logics is implemented in reset driver, not
in dw_mmc code.

Please also refer to Documentation/devicetree/bindings/reset/reset.txt

Changelog:
v5:
 * rebase onto https://github.com/jh80chung/dw-mmc
v4:
 * add reset_control_assert() and usleep() before calling _deassert().

Guodong Xu (2):
  Documentation: synopsys-dw-mshc: add binding for resets
  mmc: dw_mmc: add reset support to dwmmc host controller

 .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  4 ++++
 drivers/mmc/host/dw_mmc.c                          | 23 +++++++++++++++++++++-
 include/linux/mmc/dw_mmc.h                         |  2 ++
 3 files changed, 28 insertions(+), 1 deletion(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
