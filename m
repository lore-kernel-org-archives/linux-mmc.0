From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RESEND PATCH v5 0/2] Add phy support for arasan,sdhci-5.1
Date: Fri, 19 Feb 2016 10:18:42 +0800
Message-ID: <1455848322-2210-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


Hello Ulf and Adrian,

Sorry for delay the new version for this topic. Actually I have no
platform available to test phy stuff since v4. Now, I can rework it.:)
I remove rpm support from v5 because this patchset just need to focus
on phy stuff, which will make the changes more precise. Another reason
is that phy_power_on take too much time from rpm, however the power profit
gained from phy_power_off is little due to the low power mechanism with the
phy itself observed from experiments.

v4 can be found here:
https://patchwork.kernel.org/patch/7463251/

Note:
Phy is mandatory requirement for arasan,sdhci-5.1, so we introduce
generic phy support for sdhci-of-arasan.


Shawn Lin (2):
  Documentation: bindings: add description of phy for sdhci-of-arasan
  mmc: sdhci-of-arasan: add phy support for sdhci-of-arasan

 .../devicetree/bindings/mmc/arasan,sdhci.txt       | 20 ++++++-
 drivers/mmc/host/sdhci-of-arasan.c                 | 66 ++++++++++++++++++++--
 2 files changed, 80 insertions(+), 6 deletions(-)

-- 
2.3.7


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
