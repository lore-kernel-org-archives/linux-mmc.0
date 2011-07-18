From: Philip Rakity <prakity@marvell.com>
Subject: Re: Question regarding SDR104 bus speed mode
Date: Mon, 18 Jul 2011 08:27:11 -0700
Message-ID: <02B9B20D-2C0C-41C1-BD8D-72FD2C3BCA41@marvell.com>
References: <dd8e0dfbe0f4d466cc39fb67a2a4e4a3.squirrel@www.codeaurora.org>
 <000001cc450a$9c94aac0$d5be0040$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:45404 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751115Ab1GRPbH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jul 2011 11:31:07 -0400
In-Reply-To: <000001cc450a$9c94aac0$d5be0040$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arindam.nath@amd.com" <arindam.nath@amd.com>


On Jul 17, 2011, at 10:21 PM, Subhash Jadavani wrote:

> Arindam/Philips,
> 
> Can you help me with below query?
> 
> Regards,
> Subhash
> 
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
>> Sent: Thursday, July 14, 2011 5:09 PM
>> To: linux-mmc@vger.kernel.org; prakity@marvell.com;
>> arindam.nath@amd.com
>> Subject: Question regarding SDR104 bus speed mode
>> 
>> Hi Arindam, Philips and All,
>> 
>> According to SD 3.0 spec (section 3.9.6), cards may require current
>> upto
>> 800 mA while running in SDR104. However Max. supported current from
>> PMIC
>> regulator connected to sd card slot on my board is 600mA.
>> 
>> I have these questions:
>> 1. So does this mean we can't support the SDR104 mode if regulator
>> current
>> driving capacity is not upto 800 mA?
>> 
>> 2. I am able to make SD card run in SDR104 mode even if the max.
>> current
>> supplied by regulator is upto 600 mA. So is this 800mA requirement is
>> **must** condition to support SDR104 mode reliably?

Check the datasheet for the chip vendor you are using assuming the
chip is soldered down on the board.  Our our system the eMMC chip
is much more flexible then the JEDEC spec allows.  

>> 
>> Regards,
>> Subhash
>> 
>> --
>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>> Forum.
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

