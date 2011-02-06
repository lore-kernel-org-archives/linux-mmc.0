From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [BUG] CMD52 sent as first command not CMD0
Date: Sun, 6 Feb 2011 16:09:56 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE69934F1C6A16@irsmsx501.ger.corp.intel.com>
References: <C85F98EE-B8C5-4037-A0FF-203265A7575C@marvell.com>
 <20110206003845.GA15019@void.printf.net>
 <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11341 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752761Ab1BFQKH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Feb 2011 11:10:07 -0500
In-Reply-To: <BC6C6C10-631A-4482-BA1B-C6F0057BC54A@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Albert Herranz <albert_herranz@yahoo.es>

 
> 
> nothing negative but reset is meant to reinit the card.  This is the power up sequence for the 1st
> time a card is detected.
> There is no reason to do this if no card has yet enumerated.  If a sdio card was there I completely
> agree with the mod since we need to reset
> the card.

What about using linux as a bootloader, or just using kexec?
The first linux could have initialized the card, and we want to put everything back to known state.

This is a valid reason why you want to make sure to reset the card at the first place.

Regards,
Pierre
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

