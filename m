From: Saeed Bishara <saeed@marvell.com>
Subject: RE: [PATCH] mmc: Add architecture dependency for Marvell SoC
	controller
Date: Wed, 15 Sep 2010 12:55:33 +0300
Message-ID: <FCBE654890C0334289D0AD3AF4EF009FD18EE74AA8@IL-MB01.marvell.com>
References: <1284366279-17140-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20100914190549.GA21918@void.printf.net>
 <20100915094006.GA21620@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from galiil.marvell.com ([199.203.130.254]:35449 "EHLO
	galiil.marvell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385Ab0IOLBF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Sep 2010 07:01:05 -0400
In-Reply-To: <20100915094006.GA21620@sirena.org.uk>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>

 

>-----Original Message-----
>From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
>Sent: Wednesday, September 15, 2010 11:40 AM
>To: Chris Ball
>Cc: Saeed Bishara; Andrew Morton; linux-mmc@vger.kernel.org; 
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] mmc: Add architecture dependency for 
>Marvell SoC controller
>
>On Tue, Sep 14, 2010 at 08:05:49PM +0100, Chris Ball wrote:
>
>> This is fine with me.  Saeed, please can you ACK the choice of
>> platforms if you agree?
>
>If the list of platforms is wrong we should probably also improve the
>help text :)
I think the PLAT_PXA it too general, maybe you better specify the exact ARCH (ARCH_MMP).
saeed
>