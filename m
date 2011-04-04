From: Andrei Warkentin <andreiw@motorola.com>
Subject: Trim/erase code cleanup?
Date: Mon, 4 Apr 2011 08:14:49 -0500
Message-ID: <BANLkTinBbPVQ0L+_Myv07khTrmZVSGPWcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:43698 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1DDNOw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:14:52 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34DFCcY001368
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:15:12 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34DCf0X000289
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 09:15:11 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so6480118wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 06:14:49 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi group,

Is there any reason why we can't move mmc_erase and friends from
core/core.c to card/block.c? mmc_erase is  not used anywhere in
drivers/mmc/core
and is otherwise block function-specific. Among obvious benefits, this
makes making changes to the code simpler as now you
just need to rebuild the block module...

Thanks,
A
