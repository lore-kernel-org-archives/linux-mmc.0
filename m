From: Arumugam <arumugam.j@mistralsolutions.com>
Subject: Re: regression: b43-sdio: probe of mmc0:0001:1 failed with error -16
Date: Tue, 31 May 2016 05:17:49 +0000 (UTC)
Message-ID: <loom.20160531T071146-946@post.gmane.org>
References: <4CCDA454.708@arndnet.de> <AANLkTin80pwnb1DX8OdZK3Wgsq0nj==G9VM3pahsmo0U@mail.gmail.com> <4CCDE4EB.7060001@arndnet.de> <AANLkTik52SVa0SC_RtNtgFu2U9Gye7BKtQ7jNgMPKe=W@mail.gmail.com> <4CCE74DB.8000206@arndnet.de> <AANLkTinhYqhcQor3PhTKoS3At3Tt2Qv5WAGSirfR8eNG@mail.gmail.com> <4CCECD09.2010505@arndnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:33755 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750868AbcEaFSB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 31 May 2016 01:18:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkm-linux-mmc@m.gmane.org>)
	id 1b7c3y-0007TR-Dw
	for linux-mmc@vger.kernel.org; Tue, 31 May 2016 07:17:58 +0200
Received: from 51.227-broadband.acttv.in ([51.227-broadband.acttv.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2016 07:17:58 +0200
Received: from arumugam.j by 51.227-broadband.acttv.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mmc@vger.kernel.org>; Tue, 31 May 2016 07:17:58 +0200
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi 

I'm facing the issue of "wlan_sdio: probe of mmc0:0001:1 failed with error -5"
 I have put debug logs and found the problem is occuring in
drv->probe(func,id) in drivers/mmc/core/sdio_bus.c, Since I'm a newbie i'm
not sure where to proceed. So any guidance is heartly appreciated.



Regards
Arumugam



