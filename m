From: javier Martin <javier.martin@vista-silicon.com>
Subject: [BUG] mxcmmc: SD card data transfer blocks.
Date: Tue, 4 Sep 2012 12:44:46 +0200
Message-ID: <CACKLOr1zwz3f2TekuGsbE+y0b_bvUVtyU_V2o_Ph7QK0LDhWpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:50413 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761Ab2IDKor (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Sep 2012 06:44:47 -0400
Received: by wgbdr13 with SMTP id dr13so5467801wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 04 Sep 2012 03:44:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vinod.koul@linux.intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Viresh Kumar <viresh.linux@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>

Hi,
the BUG was found in a Visstrim_M10 i.MX27 based board using the
following script:

#!/bin/sh

i=0
mount /dev/mmcblk0p1 /opt
while [ 0 -eq 0 ]
do
        echo "Iteration $i"
        cp /opt/release.trx /opt/lol.tmp
        sync
        MD5OLD=`md5sum /opt/release.trx | awk '{print $1}'`
        MD5NEW=`md5sum /opt/lol.tmp | awk '{print $1}'`
        if [ $MD5OLD = $MD5NEW ]
        then
                echo "OK: $MD5OLD == $MD5NEW"
        else
                echo "WRONG: $MD5OLD != $MD5NEW"
                dmesg | tail -n 30
        fi
        rm -rf /opt/lol.tmp
        sync
        i=`expr $i + 1`
done


After several iterations the 'cp' process just hangs waiting for a MMC
transfer completion, which never happens.

We've added a timeout so that we can detect whether this problem
occurs or not. Ideally, when a MMC irq is lost we should force a retry
but it seems retries are only handled under certain circumstances by
the upper layers:
http://lxr.linux.no/#linux+v3.5.3/drivers/mmc/core/core.c#L327

Has anybody found the same problem? What is the right way to force a
retry of the data transfer in the host driver?

NOTE: the BUG only triggers when using DMA transfers, not PIO.

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
