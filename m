From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 2/5] MMC: Allow function-specific quirks.
Date: Thu, 10 Mar 2011 16:09:28 +0100
Message-ID: <201103101609.28223.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <1299718449-15172-3-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:55587 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788Ab1CJPJb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 10:09:31 -0500
In-Reply-To: <1299718449-15172-3-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 10 March 2011, Andrei Warkentin wrote:
> 
> This allows us to create quirks for block devices, without
> creating messy Kconfig dependencies, or polluting core/ with
> function-specific code.

The change looks good to me, but it's hard to read because
you are moving around code and changing it in one patch.

A better split of the first three patches would be to first
move the code to a header file without changing it, and then
make the changes.

Or you could directly add the code to the header file when you
introduce it in the first patch.

> Change-Id: I0fd466f115718a23edd0636e1e73d91c77b63887

Please remove these lines.

	Arnd
