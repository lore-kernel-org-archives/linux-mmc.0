From: "Ernst Schwab" <eschwab@online.de>
Subject: Re: Request for SPI testing
Date: Wed, 30 Jun 2010 14:44:18 +0200
Message-ID: <468B0A93D64C4E42BCC9C85B40F40AE0@ip065>
References: <AANLkTimVajsJq9lRSLbv8_lzu7g_CL5ptmV5OLG6dBds@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58353 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab0F3MoW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2010 08:44:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, spi-devel-general@lists.sourceforge.net, linux-mmc@vger.kernel.org, Antonio Ospite <ospite@studenti.unina.it>, Ned Forrester <nfor>

Hi Grant,

> I've pushed out Ernst's spi bus locking API patches to the following
> branch.  Before I push them into linux-next, I'd like to get some
> testing.  Can I have some volunteers please to pull this branch and
> give it a spin?  Bonus points for people who have mmc cards
> multiplexed with other devices on their SPI bus.

Thanks for bringing up this topic.

We are working with these two patches (except the 
spin_lock_irqsave modification and the 'bool' datatype 
for bus_lock_flag) for several months on our system 
(powerpc, MPC8314, kernel 2.6.32.7 and 2.6.32.14) 
that makes heavy use of several SPI devices: 9 x EEPROM, 
3 x dataflash, MMC and 2 x MDIO-pseudo-SPI (with a special 
SPI-to-MDIO bus driver).
The MMC is used rarely, but the rest is essential for 
system operation. Until now, we observed no problems,
even when copying EEPROM data to MMC. So you may add
my 'tested-by'.

Best regards
Ernst

