From: Pavel Kiryukhin <vksavl@gmail.com>
Subject: Re: cmd12 fails to stop out of range reads on Sandisk 2Gb microSD
 card.
Date: Thu, 04 Mar 2010 00:47:54 +0300
Message-ID: <4B8ED90A.5020605@gmail.com>
References: <4B8ED7F1.5040204@gmail.com>
Reply-To: vksavl@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:53135 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756657Ab0CCVqY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2010 16:46:24 -0500
Received: by bwz1 with SMTP id 1so293970bwz.21
        for <linux-mmc@vger.kernel.org>; Wed, 03 Mar 2010 13:46:23 -0800 (PST)
In-Reply-To: <4B8ED7F1.5040204@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: vksavl@gmail.com

On 03/04/2010 12:43 AM, Pavel Kiryukhin wrote:
> Hi,
> There was an issue reported by Cliff Brake some time ago regarding 
> Sandisk 2Gb SD card behavior.
> (http://www.mail-archive.com/linux-mmc@vger.kernel.org/msg00982.html)
> It seems I have similar issue with Sandisk 2Gb microSD:
SD is in SPI mode.
