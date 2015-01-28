From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 0/2] mmc: pwrseq: Add support to multiple gpios in pwrseq simple
Date: Wed, 28 Jan 2015 13:16:21 +0000
Message-ID: <1422450981-9328-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This patchset adds support to reset/powerup multiple gpio pins on a given
sdio bus. The use case is simple, on sdio we could have multiple devices
like WLAN, BT which are controlled by there own reset lines. So having
multiple reset is something more useful in such cases.

Without this patch I could not get BT and WLAN working at same time on IFC6410.

Thanks,
srini

Srinivas Kandagatla (2):
  mmc: pwrseq: Add support to control multiple gpios in simple pwrseq
  mmc: pwrseq: Update document with multiple gpios support

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  7 ++-
 drivers/mmc/core/pwrseq_simple.c                   | 64 +++++++++++++++-------
 2 files changed, 49 insertions(+), 22 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
