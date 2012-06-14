From: "Franky Lin" <frankyl@broadcom.com>
Subject: Re: Where to power on the wifi device before loading the
 driver.
Date: Thu, 14 Jun 2012 09:45:56 -0700
Message-ID: <4FDA1544.1020701@broadcom.com>
References: <6B4D417B830BC44B8026029FD256F7F1C377BFFE88@HKMAIL01.nvidia.com>
 <4FD8CED9.6030901@broadcom.com>
 <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:3738 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055Ab2FNQqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jun 2012 12:46:55 -0400
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1C377BFFE89@HKMAIL01.nvidia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>, "'linux-wireless@vger.kernel.org'" <linux-wireless@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "'linux-mmc@vger.kernel.org'" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mursalin Akon <makon@nvidia.com>, Rakesh Kumar <krakesh@nvidia.com>

On 06/13/2012 09:17 PM, Wei Ni wrote:
> Wei: Yes, in OOB mode, it's easy to add a device node in the DT, to p=
ass
> the gpio property to brcmfmac driver. But the NO-OOB mode doesn=92t u=
se the
> virtual platform device, so we can't pass the gpio to driver. We need=
 to find
> a way to support these two mode both.
> Could we use the virtual platform device both for OOB and NO-OOB mode=
? so that
> we can implement power control in these two mode, and we can add a fl=
ags to
> control if need to power on or not.

Of course you can use it for non OOB.

> BTW, does that power on sequence is generally for 4329?

Yes.

Regards.
=46ranky

