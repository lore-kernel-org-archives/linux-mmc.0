From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Thu, 30 Sep 2010 20:01:28 -0700
Message-ID: <DFA7B5FE-718A-484B-BA1D-D1B44E3A5A32@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:54583 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751032Ab0JADHH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 23:07:07 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


I was wondering if we could remove one of the CAPS for DDR voltage (MMC_CAP_1_8V_DDR and MMC_CAP_1_2V_DDR). Both 1.2 and 1.8v are defined in the JEDEC Standard No. 84-A441.

The sd 3.0 host controller only defines the option for 1.8v.  I cannot see a way to set 1.2v. 

If this makes sense I can prepare a patch.