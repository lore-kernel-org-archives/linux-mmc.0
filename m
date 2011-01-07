From: Edward Falk <falk@efalk.org>
Subject: Re: SD power-control necessary?
Date: Fri, 07 Jan 2011 11:53:10 -0800
Message-ID: <4D276F26.3090107@efalk.org>
References: <4D272592.6000508@yahoo.es> <4D273335.6010605@efalk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from a.mail.sonic.net ([64.142.16.245]:52213 "EHLO a.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755486Ab1AGTxN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 Jan 2011 14:53:13 -0500
In-Reply-To: <4D273335.6010605@efalk.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hein_Tibosch <hein_tibosch@yahoo.es>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 01/07/2011 07:37 AM, Edward A. Falk wrote:

> Just a random thought: allowing the driver to power off the SD card will
> defeat the "power-on memory protect" feature. This is how the supposedly
> secure G2 was jailbroken.

Ahh, I see we're talking about a removable SD card.  In that case, 
jailbreaking is not an issue, so yes, the driver should be able to 
remove power from the device.
