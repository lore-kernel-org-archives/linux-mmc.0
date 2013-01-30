From: "Bruce Ford (bford)" <bford@micron.com>
Subject: MMC Driver Throughput
Date: Wed, 30 Jan 2013 18:35:30 +0000
Message-ID: <DB9374B0B2CB664D9425A1916C7DE85A36804AA8@NTXBOIMBX06.micron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from masquerade.micron.com ([137.201.242.130]:16908 "EHLO
	masquerade.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755307Ab3A3Sfc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jan 2013 13:35:32 -0500
Received: from mail.micron.com (ntxboicas01.micron.com [137.201.84.60])
	by masquerade.micron.com (8.13.6/8.13.6) with ESMTP id r0UIZUDi019823
	for <linux-mmc@vger.kernel.org>; Wed, 30 Jan 2013 11:35:30 -0700
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Question:

Has any testing been done to determine the maximum data throughput to/from 
a MMC device; assuming the MMC device takes zero time to complete tasks?

Put another way - at what level of IOPS does the kernel/driver become the 
bottleneck, instead of the storage device?

Sorry if the question is slightly off forum topic - but it is MMC driver related.  
Worth a shot.

Thx --Bruce
