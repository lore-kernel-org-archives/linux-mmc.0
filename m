From: Chris Ball <cjb@laptop.org>
Subject: Re: SDHCI: Ricoh [1180:e823] unable to mount MMC cards.
Date: Thu, 31 Mar 2011 13:26:36 -0400
Message-ID: <m3zkoburoz.fsf@pullcord.laptop.org>
References: <4D93AD5C.1070308@canonical.com>
	<m34o6k43c4.fsf@pullcord.laptop.org> <4D93BDA9.1020107@canonical.com>
	<m3vcz02mi1.fsf@pullcord.laptop.org> <4D948BC4.6020904@canonical.com>
	<m3sju3z6yc.fsf@pullcord.laptop.org> <4D949298.4000701@canonical.com>
	<m3oc4rz5kp.fsf@pullcord.laptop.org> <4D94A510.4040509@canonical.com>
	<m3fwq3z1yu.fsf@pullcord.laptop.org> <4D94B552.8020108@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:57351 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab1CaRUp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 31 Mar 2011 13:20:45 -0400
In-Reply-To: <4D94B552.8020108@canonical.com> (Manoj's message of "Thu, 31 Mar
	2011 12:09:38 -0500")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Manoj <manoj.iyer@canonical.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 31 2011, Manoj wrote:
> Sorry about that... dmesg is attached.

Thanks.  I see that the Ricoh code didn't run and that the PCI ID in
the patch is wrong; in include/linux/pci_ids.h, it should be:

#define PCI_DEVICE_ID_RICOH_R5C823     0xe823

So, please retry with the "e" there in place and resend full dmesg.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
