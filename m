From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Help with writing to micro SD card
Date: Thu, 14 May 2015 23:07:31 +0100
Message-ID: <20150514230731.6f063685@lxorguk.ukuu.org.uk>
References: <5554FF76.2010206@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 251.110.2.81.in-addr.arpa ([81.2.110.251]:54807 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933686AbbENWHn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 18:07:43 -0400
In-Reply-To: <5554FF76.2010206@lwfinger.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

> When I received the tablet, I used dd to back up the internal card. When I used 
> a block size of 4M in that operation, it also froze; however, the standard block 
> size (512) worked. That suggests that the standard Linux r/w operations on the 
> device are too fast.

Unlikely.

> What should I do to get some debug information?

As its Baytrail-T make sure you have

- Current BIOS
- Latest kernel

If it persists try disabling power management on the SD card interface.
It may be worth reading through the ASUS T100TA bug reports and
workarounds as that is probably the most poked at platform for BYT/T


Alan
