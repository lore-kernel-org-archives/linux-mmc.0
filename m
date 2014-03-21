From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Backporting eMMC v5 support to Linux 3.4
Date: Fri, 21 Mar 2014 13:28:44 +0100
Message-ID: <20140321122844.GA5417@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:45732 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbaCUM2q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Mar 2014 08:28:46 -0400
Received: from egtvedt by cassarossa.samfundet.no with local (Exim 4.80)
	(envelope-from <egtvedt@samfundet.no>)
	id 1WQyZ2-0007P3-3I
	for linux-mmc@vger.kernel.org; Fri, 21 Mar 2014 13:28:44 +0100
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I have a device, which has received an eMMC v5 device, and thus the 3.4
kernel the vendor provides does not identify the flash chip anymore.

Looking at the kernel history, it seems very easy to backport support for it.
Would it be as easy as cherry picking commit 6636bad8?
  mmc: core: Update the ext-csd.rev check for eMMC5.1

And just when I'm on backporting, perhaps fetching commit 7c4f10ac
  mmc: core: production year for eMMC 4.41 and later

Or have I forgotten anything vital?

-- 
Hans-Christian Egtvedt
