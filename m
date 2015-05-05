From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [Linux-kernel] [RFC PATCH 5/7] mmc: sh_mobile_sdhi: Add UHS-I
 mode support
Date: Tue, 05 May 2015 11:35:21 +0300
Message-ID: <554880C9.8080201@codethink.co.uk>
References: <1430396995.5802.39.camel@xylophone.i.decadent.org.uk> <1430397136.5802.44.camel@xylophone.i.decadent.org.uk> <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34239 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965262AbbEEIf1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:35:27 -0400
In-Reply-To: <CAPDyKFodZscxZJmKgYyMV8m8mNWYc9GitkoKbixTKS5r7rv_fA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 05/05/15 10:56, Ulf Hansson wrote:
> On 30 April 2015 at 14:32, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>> Implement voltage switch, supporting modes up to SDR-50.
>>
>> Based on work by Shinobu Uehara, Rob Taylor, William Towle and Ian Molton.
>>
>> This uses two voltage regulators, one external and one on the pfc.
> 
> Why two? If there is a parent child relation ship, that should be
> handled through the regulator tree, right!? Please elaborate.

The card main power is separate from the IO line voltages.

To get to the high-speed, card power is left at 3.3V and the IO
voltage is changed to 1.8V.

In the systems we have the power gate is separate from the controls
for the IO but not integrated into the MMC controller itself.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
