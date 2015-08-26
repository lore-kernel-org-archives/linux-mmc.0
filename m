From: "Anand Patil (anandpatil)" <anandpatil@micron.com>
Subject: eMMC feature backward compatibility
Date: Wed, 26 Aug 2015 21:43:20 +0000
Message-ID: <3733EC32093177499B085F9A47F3D7FE05447719@NTXBOIMBX05.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:62142 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbbHZVnX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Aug 2015 17:43:23 -0400
Received: from mail.micron.com (ntxboicas02.micron.com [137.201.20.138])
	by mailout.micron.com (8.14.4/8.14.6) with ESMTP id t7QLhLtD027263
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-mmc@vger.kernel.org>; Wed, 26 Aug 2015 15:43:21 -0600
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,
         If I use linux 3.4.0 mainline does that guarantee mmc block/core.c  would support  eMMC features from  V4.0 to V 4.5 (JEDEC standard) without any gaps?

Warm Regards,
Anand Patil

