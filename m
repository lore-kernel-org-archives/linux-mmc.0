From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RFC PATCH 0/4] mmc: sdhci: Support maximum DMA latency request via PM QoS
Date: Wed, 22 Jul 2015 12:03:46 +0000 (UTC)
Message-ID: <loom.20150722T135723-76@post.gmane.org>
References: <1427204440-3533-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37201 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934035AbbGVMEF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 08:04:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1ZHskk-0004uB-48
	for linux-mmc@vger.kernel.org; Wed, 22 Jul 2015 14:04:02 +0200
Received: from mon69-7-83-155-44-161.fbx.proxad.net ([83.155.44.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2015 14:04:02 +0200
Received: from hadess by mon69-7-83-155-44-161.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 22 Jul 2015 14:04:02 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Adrian Hunter <adrian.hunter <at> intel.com> writes:
> Ad hoc testing with Lenovo Thinkpad 10 showed a stress
> test could run for at least 24 hours with the patches,
> compared to less than an hour without.

I've had the same sort of problems on 2 different BayTrail tablets (a Onda
v975w and a WinBook TW100), usually hanging hard during package installation
and was wondering whether you would resubmit your patches to be merged (I
understand that the CPU detection was problematic), or whether I should ship
those in our vendor kernel in the meanwhile.

I'll report shortly how well that patch series works after testing.

> These patches are on top of my driver strength patches
> which are on top of my re-tuning patches.

Those 2 patchsets got merged upstream now, correct?

Cheers


