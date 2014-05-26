From: Hans de Goede <hdegoede@redhat.com>
Subject: Avoiding / recovering from end bit errors with sdio device (bcm43362)
Date: Mon, 26 May 2014 11:13:10 +0200
Message-ID: <538305A6.5000105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52254 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbaEZJNN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 26 May 2014 05:13:13 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>, Arend van Spriel <arend@broadcom.com>

Hi All,

Every few hours (on average) the bcm43362 sdio wifi on 2 different
model allwinner boards I've throws an EBE error. The error handling
code successfully send a stop command after this, but still any
other command after that ends with a data time out error (which again
gets followed by a successful stop command).

Does this indicate a problem with the sdio device (driver), or could
this also be triggered by a bug in the mmc host driver?

One thing worth noticing hereby is that the brcmfmac drivers sdio
drivestrength table mentions that it is for 1.8v signalling, where
as the SoC side of things is using 3.3v signalling (this cannot
be changed).

Any help to further debug this would be greatly appreciated.

Thanks & Regards,

Hans
