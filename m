From: Domenico Andreoli <dr.domenico.andreoli@gmail.com>
Subject: [PATCH 0/2] OF: add MMC binding helpers
Date: Thu, 21 Apr 2011 15:16:52 +0200
Message-ID: <20110421131652.GA15155@dandreoli.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46003 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752561Ab1DUNQ5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 09:16:57 -0400
Received: by wya21 with SMTP id 21so1415526wya.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 06:16:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, spi-devel-general@lists.sourceforge.net

Hi all,

  in working to add OF support to S3C MMC I discovered that some good
code has been already written for the MMC-over-SPI driver. This is
the first attempt to use it to build a common set of OF bindings for
MMC drivers.

Please tell me whether I'm on a good way or not.

cheers,
Domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://cavokz.wordpress.com/gpgkey/
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
