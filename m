From: "Edward A. Falk" <falk@efalk.org>
Subject: Re: SD power-control necessary?
Date: Fri, 07 Jan 2011 07:37:25 -0800
Message-ID: <4D273335.6010605@efalk.org>
References: <4D272592.6000508@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:45285 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab1AGP4m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Jan 2011 10:56:42 -0500
In-Reply-To: <4D272592.6000508@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hein_Tibosch wrote:
> Hello,
> 
> Maybe a stupid question, but when designing new hardware with a slot
> for an sd-card, how essential is it that the driver is able to power off/on
> the card?

Just a random thought: allowing the driver to power off the SD card will 
defeat the "power-on memory protect" feature.  This is how the 
supposedly secure G2 was jailbroken.

	-ed falk
