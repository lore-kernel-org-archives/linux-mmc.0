From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Devicetree: Initialization order of mmc block devices?
Date: Thu, 19 Jul 2012 13:13:45 +0000
Message-ID: <201207191313.46178.arnd@arndb.de>
References: <5006571A.7060103@de.bosch.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50483 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2GSNNy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jul 2012 09:13:54 -0400
In-Reply-To: <5006571A.7060103@de.bosch.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Wohlrab Knut (CM-AI/PJ-CA33)" <Knut.Wohlrab@de.bosch.com>

On Wednesday 18 July 2012, Dirk Behme wrote:
> Any idea how we could influence the initialization order of the mmc 
> block devices using a DT based kernel? Ensuring that the internal, hard 
> wired mmc card is always mapped to mmcblk0?

I think the best solution would be to parse the "/aliases" device node
and look for an "mmc0" or "mmc1" property with a phandle to the respective
device. That's how we sort the serial ports. We have the of_alias_get_id()
function to pick out a node from there, so it should be possible to use
that in the mmc core similar to how we use it in the uart drivers.

	Arnd
