From: Zach Brown <zach.brown-acOepvfBmUk@public.gmane.org>
Subject: [RFC 0/2] Add device tree property and quirk for supporting sdhci
Date: Fri, 23 Sep 2016 15:01:07 -0500
Message-ID: <1474660869-15532-1-git-send-email-zach.brown@ni.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zach.brown-acOepvfBmUk@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Some board configurations can not support sd highspeed mode due to the distance
between the card slot and the controller. The card and controller report that
they are capable of highspeed however, so we need a mechanism for specifying
that the setup is incapable of supporting highspeed mode.

The first patch adds documentation about a new devicetree property
sd-broken-highspeed.

The second patch keeps the sd controller and card from going into highspeed
mode when the property is set.

Chen Yee Chew (1):
  sdhci: Prevent SD from doing high-speed timing when
    sd-broken-highspeed     property is set

Zach Brown (1):
  sdhci: Add device tree property sd-broken-highspeed

 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 arch/arm/boot/dts/ni-77D5.dts                 | 1 -
 drivers/mmc/host/sdhci-pltfm.c                | 3 +++
 drivers/mmc/host/sdhci.c                      | 3 ++-
 drivers/mmc/host/sdhci.h                      | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
