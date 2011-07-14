From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: Question regarding SDR104 bus speed mode
Date: Thu, 14 Jul 2011 04:38:34 -0700 (PDT)
Message-ID: <dd8e0dfbe0f4d466cc39fb67a2a4e4a3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:40099 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509Ab1GNLiq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jul 2011 07:38:46 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, prakity@marvell.com, arindam.nath@amd.com

Hi Arindam, Philips and All,

According to SD 3.0 spec (section 3.9.6), cards may require current upto
800 mA while running in SDR104. However Max. supported current from PMIC
regulator connected to sd card slot on my board is 600mA.

I have these questions:
1. So does this mean we can't support the SDR104 mode if regulator current
driving capacity is not upto 800 mA?

2. I am able to make SD card run in SDR104 mode even if the max. current
supplied by regulator is upto 600 mA. So is this 800mA requirement is
**must** condition to support SDR104 mode reliably?

Regards,
Subhash

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

