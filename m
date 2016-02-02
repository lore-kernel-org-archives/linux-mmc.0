From: Mason <slash.tmp@free.fr>
Subject: arasan,sdhci.txt "compatibility" DT binding
Date: Tue, 2 Feb 2016 10:49:25 +0100
Message-ID: <56B07BA5.4060407@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:32936 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754227AbcBBJte (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Feb 2016 04:49:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Michal Simek <monstr@monstr.eu>, Anton Vorontsov <anton@enomsg.org>, Xiaobo Xie <x.xie@freescale.com>, Suman Tripathi <stripathi@apm.com>, Shawn Lin <shawn.lin@rock-chips.com>

Hello everyone,

Documentation/devicetree/bindings/mmc/arasan,sdhci.txt states:

Required Properties:
  - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'

What do 8.9a, 4.9a, and 5.1 refer to?

$ git ls Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
da795ec26e25 mmc: sdhci-of-arasan: Add the support for sdhci-5.1
308f3f8d8112 mmc: sdhci-of-arasan: Add the support for sdhci-arasan4.9a
e3ec3a3d11ad mmc: arasan: Add driver for Arasan SDHCI


I found two Arasan data sheets.

The first data sheet, created 2010-02-19, is titled
"SD3.0 / SDIO3.0 / eMMC4.4 AHB Host Controller"
and the documentation revision number is 6.0

The revision history mentions:

1.0	05.02.2005
1.1	02.08.2006
1.2	03.10.2006
1.3	03.27.2006
1.4	04.11.2006
1.5	04.18.2006
1.6	05.18.2006
1.7	06.05.2006
1.8	10.06.2006
1.9	19.06.2006
2.0	01.08.2007
2.1	01.30.2007
2.2	02.22.2007
2.3	04.30.2007
2.4	05.07.2007
2.5	06.04.2007
2.6	06.25.2007
2.7	06.29.2007
2.8	07.24.2007
2.9	07.31.2007
3.0	11.12.2007
3.1	11.14.2007
3.2	11.21.2007
3.3	12.13.2007
3.4	12.15.2007
3.5	04.11.2008
3.6	08.19.2008
3.7	10.11.2008
3.7a	11.11.2008
3.8a	11.25.2008
3.9a	01.22.2009
4.0a	02.13.2009
4.1a	04.06.2009
4.2a	06.16.2009
5.0	07.01.2009
5.1	07.13.2009
5.2	07.16.2009
5.3	07.29.2009
5.4	08.17.2009
5.5	08.29.2009
5.6	09.30.2009
5.7	11.04.2009
5.8	12.04.2009
5.9	01.19.2010
6.0	02.19.2010


The second data sheet, created 2012-09-07, is titled
"SD3.0 / SDIO3.0/ eMMC4.5 Host Controller"
and the documentation revision number is 1.13

Revision history mentions a "new architecture" for rev 1.0
in 2011-06-01


Neither of these data sheets mention anything about a 4.9a or 8.9a
version of the controller... And I don't think 5.1 refers to the
documentation rev, right?

So what do 8.9a, 4.9a, and 5.1 refer to?

Regards.
