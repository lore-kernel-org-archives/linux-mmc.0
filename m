From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 0/4] mmc: pwrseq-simple: add various functionality for devices
Date: Thu,  1 Dec 2016 22:17:38 -0800
Message-ID: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Primarily these additions are used with wifi cards that have an
power down pin, and timing constraints betweens assertions/deassertions.

Matt Ranostay (4):
  mmc: pwrseq-simple: add an optional pre-power-on-delay
  mmc: pwrseq-simple: add support for power down GPIO pins
  mmc: pwrseq-simple: allow inverting of off state logic
  mmc: pwrseq-simple: add disable-post-power-on option

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt  |  8 ++++
 drivers/mmc/core/pwrseq_simple.c                   | 49 +++++++++++++++++-----
 2 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
