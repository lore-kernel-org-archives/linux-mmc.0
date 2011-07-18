From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: Question regarding SDR104 bus speed mode
Date: Mon, 18 Jul 2011 10:51:52 +0530
Message-ID: <000001cc450a$9c94aac0$d5be0040$@org>
References: <dd8e0dfbe0f4d466cc39fb67a2a4e4a3.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:17095 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab1GRFV5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jul 2011 01:21:57 -0400
In-Reply-To: <dd8e0dfbe0f4d466cc39fb67a2a4e4a3.squirrel@www.codeaurora.org>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Subhash Jadavani' <subhashj@codeaurora.org>, linux-mmc@vger.kernel.org, prakity@marvell.com, arindam.nath@amd.com

Arindam/Philips,

Can you help me with below query?

Regards,
Subhash

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
> Sent: Thursday, July 14, 2011 5:09 PM
> To: linux-mmc@vger.kernel.org; prakity@marvell.com;
> arindam.nath@amd.com
> Subject: Question regarding SDR104 bus speed mode
> 
> Hi Arindam, Philips and All,
> 
> According to SD 3.0 spec (section 3.9.6), cards may require current
> upto
> 800 mA while running in SDR104. However Max. supported current from
> PMIC
> regulator connected to sd card slot on my board is 600mA.
> 
> I have these questions:
> 1. So does this mean we can't support the SDR104 mode if regulator
> current
> driving capacity is not upto 800 mA?
> 
> 2. I am able to make SD card run in SDR104 mode even if the max.
> current
> supplied by regulator is upto 600 mA. So is this 800mA requirement is
> **must** condition to support SDR104 mode reliably?
> 
> Regards,
> Subhash
> 
> --
> Sent by a consultant of the Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
> Forum.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

