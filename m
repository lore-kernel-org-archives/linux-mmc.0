From: Andrei Warkentin <andreiw@motorola.com>
Subject: Block quirks redux + Toshiba performance quirk
Date: Wed,  9 Mar 2011 18:54:04 -0600
Message-ID: <1299718449-15172-1-git-send-email-andreiw@motorola.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:39518 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab1CJAKk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 19:10:40 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A0AtaA009624
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:10:55 -0500 (EST)
Received: from mail-yi0-f42.google.com (mail-yi0-f42.google.com [209.85.218.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p2A0Acs9009577
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 19:10:55 -0500 (EST)
Received: by mail-yi0-f42.google.com with SMTP id 21so735053yic.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 16:10:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

I'm sending this as a new mail instead of a reply-to, because it's really a
different set of patches. I'm holding off on the reliability improvement, because
the generic-code equiv. depends on reliable write support, so I'll wait until everybody
is satisfied with these changes until sending those in.

This is based on linux-next tree with Pierre's quirks.c.

I've tested it on K36 with backported Pierre's changes.

Thanks,
A

