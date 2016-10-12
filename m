From: Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] mmc: sdhci-iproc: Add byte register access support
Date: Wed, 12 Oct 2016 11:35:50 -0700
Message-ID: <1476297352-7812-1-git-send-email-scott.branden@broadcom.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Scott Branden <scott.branden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add brcm,sdhci-iproc compat string and code for support of newer versions of
sdhci-iproc controller that allow byte-wise register accesses.

Scott Branden (2):
  mmc: sdhci-iproc: Add brcm,sdhci-iproc compat string in bindings
    document
  mmc: sdhci-iproc: support standard byte register accesses

 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |  1 +
 drivers/mmc/host/sdhci-iproc.c                     | 35 ++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.5.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
