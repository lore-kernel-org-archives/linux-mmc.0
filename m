From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 0/4 v3] mmc: tmio: don't access nonexisting registers
Date: Wed, 23 Mar 2011 14:48:59 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

v3: fix wrong chip name in 2 out of 4 commit messages, patches themselves 
are unchanged.

Some tmio implementations don't implement registers above 0xff. The driver 
must take care not to access them in such cases.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
