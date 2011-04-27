From: Philip Rakity <prakity@marvell.com>
Subject: SD Patches
Date: Tue, 26 Apr 2011 19:50:57 -0700
Message-ID: <D25F80F1-828E-40C1-B60A-207EEE2DA4E2@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:43601 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902Ab1D0Cx6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 22:53:58 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arindam Nath <arindam.nath@amd.com>


Chris,

It is important that the patches are put into the linux code for testing.

I have tested and reviewed the code but NOT extensively.

It works for me doing eMMC (DDR)  and SDIO (SDR50).

I certainly have no issue with saying I have reviewed the code and tested it -- but again only in the areas I am looking at.

With this provision feel free to add 

Reviewed and Tested-by to the code so we can move forward with its integration into mmc-next.

Philip

