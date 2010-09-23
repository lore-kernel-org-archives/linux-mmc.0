From: sunil <usdutt@gmail.com>
Subject: mmc-spi block driver
Date: Thu, 23 Sep 2010 14:48:16 +0000 (UTC)
Message-ID: <loom.20100923T163849-19@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60038 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753814Ab0IWOzK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Sep 2010 10:55:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1OynCT-0004Cc-AJ
	for linux-mmc@vger.kernel.org; Thu, 23 Sep 2010 16:55:05 +0200
Received: from 59.96.101.123 ([59.96.101.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 16:55:05 +0200
Received: from usdutt by 59.96.101.123 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 16:55:05 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi All,
I am working on integrating the mmc driver on Linux and when I try to mount the
device I always get the error "mounting /dev/mmc on m failed: Invalid argument" .
I also see that when ever I try to mount,the drivers request function is invoked
to read the first sector(MBR).Thus the driver always reads the MBR and returns
to the filesystem.The moment I load the driver the drivers request function is
invoked to read the first 8 sectors.The data for the block0 is as follows .The
rest blocks are all 0.
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000004bc1f59e00
033d061cfcd9f90007531e000000000000000000000000000000000000000000000000055aa.
Interpreting the above data I could see that the volumeID is present at the
sector location 0x000000f9.
After giving this information I feel the file system should interpret the MBR's
partition table and issue request with the calculated sector address.

he following are the instructions I have followed to mount the module.
mknode /dev/mmc b 254 0.
mount -t vfat /dev/mmc /mmc.(invalid argument)

When ever I do the mount I could see the drivers request function is invoked to
read the first sector(sector 0).What should I do to make the file system read
the volume ID (0x00000f9) sector.
Can any one help me in debugging this issue.
Regards,
Sunil

