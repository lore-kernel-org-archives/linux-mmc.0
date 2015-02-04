From: Mario <nutrinfnon@gmx.com>
Subject: mmc0: error -84 whilst initialising SD card
Date: Wed, 04 Feb 2015 06:37:59 +0100
Message-ID: <54D1B037.6010909@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.tre.it ([62.13.171.13]:49444 "EHLO relay2.tre.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbbBDGIX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 4 Feb 2015 01:08:23 -0500
Received: from abox.gian.it (u559131.xgsnun6.imtp.tachikawa.mopera.net [1.72.59.131])
	by relay2.tre.it  with ESMTP id t145c6Y1028906-t145c6Y3028906
	(version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <linux-mmc@vger.kernel.org>; Wed, 4 Feb 2015 06:38:12 +0100
Received: from localhost ([127.0.0.1])
	by abox.gian.it with esmtp (Exim 4.80)
	(envelope-from <nutrinfnon@gmx.com>)
	id 1YIsf3-0008Gm-Ja
	for linux-mmc@vger.kernel.org; Wed, 04 Feb 2015 06:38:01 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,


  I wrote to Intel support without success. They answer me that I must 
ask to tablet manufacturer, but I know it is impossible.

I try to ask here, with short question:

Object:
TABLET CHUWI VX8 3G Atom Z3735G

Description:
POWER OFF
-> SWITCH ON
  -> BOOT Linux-3.19.0-rc6
   -> ERROR "mmc0: error -84 whilst initialising SD card"
    -> no sd device


POWER OFF
-> SWITCH ON
  -> BOOT Linux-3.10.20_from_original_android_installation
   -> mmc initialized successfully
    -> sd device works fine
     -> REBOOT without switch off tablet
      -> BOOT Linux-3.19.0-rc6 (ABOVE GOES IN ERROR)
       -> mmc initialized successfully
        -> sd device works fine with 3.19.0-rc6 too


Thanks.


I think it is possible ssh login to tablet trough IPv6 if it is necessary.

