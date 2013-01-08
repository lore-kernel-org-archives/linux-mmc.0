From: Sergey Priporov <spriporov@gmail.com>
Subject: Re: [RFC PATCH 00/11] [FS, MM, block,      MMC]: eMMC High Priority Interrupt Feature
Date: Tue, 8 Jan 2013 17:55:12 +0000 (UTC)
Message-ID: <loom.20130108T185414-599@post.gmane.org>
References: <1334730332-22244-1-git-send-email-svenkatr@ti.com> <3a028a6583c7fac372c8711930fc1874.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:39562 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756574Ab3AHSE5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Jan 2013 13:04:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1TsdXu-0000Td-54
	for linux-mmc@vger.kernel.org; Tue, 08 Jan 2013 19:05:06 +0100
Received: from 76-220-45-183.lightspeed.sntcca.sbcglobal.net ([76.220.45.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 19:05:06 +0100
Received: from spriporov by 76-220-45-183.lightspeed.sntcca.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 08 Jan 2013 19:05:06 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi Venkat,

I was looking for some explanations of eMMC behavior in products we  ar=
e=20
developing now and found your comments around eMMC here. Our observatio=
n shows=20
that that eMMC performance vary significantly and depends on volume of =
data to=20
write during time slot and temperature. After a heavy write test was ru=
n for=20
some time for a good performance eMMC (showing 10-12MB/s of the write=20
performance on big blocks) its write performance degraded to the 4-5MB/=
s.
We even observed performance lowest level as 65KB/s!=20
There are a lot of Write type of operations necessary into dedicated eM=
MC=20
partition by requirements.
The side effect is that long write operations block  Application UI to =
redraw=20
the  views  because it requires Read operations.
Visually we see =E2=80=9CBlank Dark Screen=E2=80=9D for few seconds and=
 even ANRs. So HMI may=20
help us.

Question:  Did you finish research with HPI to try ?  Which type of eMM=
C did=20
you use?

P.S. We use TI BSP for OMAP3630 for Android=20


