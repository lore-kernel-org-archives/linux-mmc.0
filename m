From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: why would an SD card, after 12 hours, start to fail recording video?
Date: Thu, 26 May 2011 08:01:22 +0200
Message-ID: <201105260801.22805.arnd@arndb.de>
References: <alpine.DEB.2.00.1105241307400.3975@localhost6.localdomain6> <201105242124.13856.arnd@arndb.de> <6AAC4214B9104E409FF4885ACB62A96101A78AD977@SHEXMB-01.global.atheros.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50151 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011Ab1EZGBZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2011 02:01:25 -0400
In-Reply-To: <6AAC4214B9104E409FF4885ACB62A96101A78AD977@SHEXMB-01.global.atheros.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Patrick Fu <Patrick.Fu@atheros.com>
Cc: "Robert P. J. Day" <rpjday@crashcourse.ca>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thursday 26 May 2011, Patrick Fu wrote:
> > There are many reasons why this could happen:
> > 
> > * You used a Kingston (or other cheap) SD card with a file system other
> >   than FAT32
> > 
> 
> I'm just curious. How could this thing (file system type) affect read/write operations? 
> Could you explain it a little?
> 
See my article at https://lwn.net/Articles/428584/ and the survey at https://wiki.linaro.org/WorkingGroups/Kernel/Projects/FlashCardSurvey.

Many cheap cards are designed for a very specific file system layout. If you
do something else, you can have orders of magnitude higher write amplification.

	Arnd
