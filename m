From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: A MMC card transfer issue
Date: Mon, 31 Jan 2011 12:18:55 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101311204060.8580@xanadu.home>
References: <4CD8DE9C.4040505@dsn.okisemi.com>
 <6076934B-27C2-4766-B101-793C7447C71C@marvell.com>
 <0F933C1424BF45E3BD2E13358BD3C89E@hacdom.okisemi.com>
 <7BDF62B4-A11A-4CB4-9F80-F2206C2655F9@marvell.com>
 <A32C38D81702478B9AB8626F523E79BB@hacdom.okisemi.com>
 <0DBFCBB8-B4A3-46A6-A68D-14FAED451619@marvell.com>
 <9992F28C7C0C445E956D351E3774C821@hacdom.okisemi.com>
 <82CB4E44-6543-4578-ACE4-37850FC4A49A@marvell.com>
 <EE9384C765994E26857C78E3D3A19304@hacdom.okisemi.com>
 <"AF584C10-A796-4 3 5 B-8AB2-DA6D6C0E3FD7"@marvell.com>
 <DE7D3AAF538943459079D18D0CE6ED44@hacdom.okisemi.com>
 <DDF13C55-A8A1-45C1-AE9A-A76754ED7008@marvell.com>
 <4425BB0054B748C68A25DD1DFBBB52A7@hacdom.okisemi.com>
 <5E1B7BBD-C96E-4CC0-B03B-ADCEB0120085@marvell.com>
 <0C438F11-132E-4639-820D-0E42EEDCD6E7@marvell.com>
 <671E3EC021E946A383C65F07A0101B27@hacdom.okisemi.com>
 <16706427-F00E-46F3-B0B4-9B7F06AD0E71@marvell.com>
 <5CBEE3CD-E95A-4657-8842-D87B5F1F9AC1@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:31157 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299Ab1AaRS4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Jan 2011 12:18:56 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFW006W3DFJANF0@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 31 Jan 2011 12:18:56 -0500 (EST)
In-reply-to: <5CBEE3CD-E95A-4657-8842-D87B5F1F9AC1@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Toshiharu Okada <toshiharu-linux@dsn.okisemi.com>, Manabu Miyata <miyata669@dsn.okisemi.com>, Takahiro Shimizu <shimizu394@dsn.okisemi.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Mon, 31 Jan 2011, Philip Rakity wrote:

> The transcend mmc card does not have the PHYSICAL pins for 4 bit mode; only 1 bit can be supported.
> 
> Testing the bus width is the recommend way to find out the bus width.  The current behavior when the
> QUIRK is not defined is to default to 4 bit mode (same as has been done historically).
> 
> The only way to guarantee that cards really do work would be to default to 1 bit mode but this has a
> 4x performance degradation.
> 
> One possible solution would be to try to do a test read operation on the mmc card if the bus test failed
> and see if there is an error.  In this case change the bus width to 1 bit.
> 
> a) Do you think this is a good idea?  --
> b) How to plumb it in ?  -- can you sketch something out and I will try to implement it.

Sure.  This is probably a good thing to attempt lowering the bus width 
on errors.  In mmc_request_done() you could attempt switching to a 
narrower bus width and reattempt the failed command if that command was 
about some data transfer and the error was -ETIMEDOUT.


Nicolas
