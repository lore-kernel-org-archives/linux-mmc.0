From: "Dasgupta, Romit" <romit@ti.com>
Subject: RE: mmcqd cpu utilization
Date: Thu, 3 Sep 2009 01:30:41 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DD57A8B3@dbde02.ent.ti.com>
References: <007301ca2bf2$2888e2a0$544ff780@am.dhcp.ti.com>
 <20090902194036.07c1f72c@mjolnir.ossman.eu>
 <00ae01ca2c07$98d416f0$544ff780@am.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47736 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbZIBUA6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2009 16:00:58 -0400
In-Reply-To: <00ae01ca2c07$98d416f0$544ff780@am.dhcp.ti.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, 'Pierre Ossman' <pierre@ossman.eu>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "hch@lst.de" <hch@lst.de>

Madhu,
>
>> My guess would be that the omap driver doesn't (cannot?) use the
>> hardware to wait for busy to end, so the system must poll.
>>
>So your guess hints probably at "wait_for_completion(&complete)".
>Am I correct?
>
Madhu wait_for_completion is blocking call. Please check 'omap_mmc_request'
