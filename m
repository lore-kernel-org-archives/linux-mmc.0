From: Patrick Fu <Patrick.Fu@Atheros.com>
Subject: RE: why would an SD card, after 12 hours, start to fail recording
 video?
Date: Thu, 26 May 2011 12:50:57 +0800
Message-ID: <6AAC4214B9104E409FF4885ACB62A96101A78AD977@SHEXMB-01.global.atheros.com>
References: <alpine.DEB.2.00.1105241307400.3975@localhost6.localdomain6>
 <201105242124.13856.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atheros.com ([12.19.149.2]:36079 "EHLO mail.atheros.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab1EZEwE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2011 00:52:04 -0400
Received: from mail.atheros.com ([10.10.20.108])
	by sidewinder.atheros.com
	for <linux-mmc@vger.kernel.org>; Wed, 25 May 2011 21:51:33 -0700
In-Reply-To: <201105242124.13856.arnd@arndb.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Arnd,

Arnd Bergmann wrote:
> On Tuesday 24 May 2011 19:11:48 Robert P. J. Day wrote:
> >   a maddeningly vague question -- i'm currently after more information
> > -- but i've been told about an issue where someone is recording video
> > to an SD card and, after 12 hours, the units begin to "fail."  that's
> > all the info i have at the moment, i hope to get more so i don't even
> > know what the definition of "fail" is here, or the brands or models or
> > vendors involved, only what you read above.
> >
> >   has anyone run across something like this before?  again, i realize
> > this is annoyingly vague but if i had a hint as to what might be going
> > on, i might be able to offer some advice.  what could possibly cause
> > properly recording SD cards to start misbehaving after several hours?
> > thanks for any wildly speculative guesses.
> 
> There are many reasons why this could happen:
> 
> * You used a Kingston (or other cheap) SD card with a file system other
>   than FAT32
> 

I'm just curious. How could this thing (file system type) affect read/write operations? 
Could you explain it a little?


Thanks,

Patrick
