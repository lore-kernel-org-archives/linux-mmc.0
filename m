From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/5] MMC: Allow function-specific quirks.
Date: Thu, 10 Mar 2011 22:55:05 +0100
Message-ID: <201103102255.05913.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <201103101609.28223.arnd@arndb.de> <AANLkTi=HBwXQL125Zat-wAcZYFE5ZKy9bUzqBfp+sB_u@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61158 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab1CJVzP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 16:55:15 -0500
In-Reply-To: <AANLkTi=HBwXQL125Zat-wAcZYFE5ZKy9bUzqBfp+sB_u@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 10 March 2011 21:41:45 Andrei Warkentin wrote:
> > Or you could directly add the code to the header file when you
> > introduce it in the first patch.
> 
> So basically squash the three patches dealing with quirks infrastructure?

Yes, you could do that, or maybe just squash the first two patches.

	Arnd
