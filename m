From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/3] tmio: let platforms decide upon write-protection
 availability
Date: Tue, 11 May 2010 11:52:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:58010 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932427Ab0EKJw2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 11 May 2010 05:52:28 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

Some platforms and card-formats do not have a write-protect detection. Let 
tmio_mmc users switch WP-detection off, if desired, switch it off for the 
micro-SD slot on the kfr2r09 SuperH board.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
