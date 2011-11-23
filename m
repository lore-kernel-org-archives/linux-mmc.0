From: ygardi@codeaurora.org
Subject: sanitize for eMMC v4.5
Date: Wed, 23 Nov 2011 04:09:45 -0800 (PST)
Message-ID: <806ca0964234cf284f0b5ca61ee8df3e.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:61211 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab1KWMJp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Nov 2011 07:09:45 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

sorry for sending it again...(changed the mailing-list)

hello,

i have a few questions regarding the sanitize capability that was added in
v4.5.

1. how often this operation should take place ?
   a. any advantages to perform sanitize in power-up, power-down, or every
X hours when the card in idle ?

2. how this operation should be triggered?
is it external adb command, or is part of the driver operation ?

3. does anyone have a speculated time duration for that operation
according to a card size / vendor ?

thanks,
Yaniv





