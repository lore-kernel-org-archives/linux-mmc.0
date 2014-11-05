From: Mickael Legrand <mle@netgem.com>
Subject: Re: [PATCH 2/2] mmc-utils: add support to create gp partition
Date: Wed, 5 Nov 2014 09:24:17 +0000 (UTC)
Message-ID: <loom.20141105T102237-925@post.gmane.org>
References: <1398336472-16679-1-git-send-email-balajitk@ti.com> <1398336472-16679-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49996 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbaKEJaJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Nov 2014 04:30:09 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1Xlwuj-0007Mb-7U
	for linux-mmc@vger.kernel.org; Wed, 05 Nov 2014 10:30:05 +0100
Received: from gw.netgem.com ([195.68.2.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 10:30:05 +0100
Received: from mle by gw.netgem.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Wed, 05 Nov 2014 10:30:05 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

can I suggest to you this little fix:
--- mmc-utils.ref/mmc_cmds.c	2014-11-05 09:38:49.567266375 +0100
+++ mmc-utils/mmc_cmds.c	2014-11-05 10:15:00.002010783 +0100
@@ -618,7 +618,7 @@
 	ext_attr =3D strtol(argv[5], NULL, 10);
 	device =3D argv[6];
=20
-	if (partition < 0 || partition > 4) {
+	if (partition < 1 || partition > 4) {
 		 printf("Invalid gp parition number valid range [1-4]\n");
 		 exit(1);
 	}

regards,
Micka=C3=ABl




