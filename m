From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [comments] MMC: Reliable write support.
Date: Tue, 29 Mar 2011 09:01:31 +0200
Message-ID: <201103290901.31680.arnd@arndb.de>
References: <1301001751-30785-1-git-send-email-andreiw@motorola.com> <201103251614.29893.arnd@arndb.de> <AANLkTi=+LOy6V4hLsjaDd60xjEWm7jtYXaW8-4j=7TCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:53746 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418Ab1C2HBi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 03:01:38 -0400
In-Reply-To: <AANLkTi=+LOy6V4hLsjaDd60xjEWm7jtYXaW8-4j=7TCQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Tuesday 29 March 2011, Andrei Warkentin wrote:
> On Fri, Mar 25, 2011 at 10:14 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> I confirmed with two MMC vendors that there is no "flush". Once the
> DAT transfer completes, the data is stored on non-volatile storage as
> soon as the busy status is cleared.
> 
> Reliable writes are still "more reliable" because if the DAT transfer
> is interrupted (power or reset through CMD0/CMD15 or hw pin for eMMC),
> you have predictable flash contents. So it makes sense to map REQ_FUA
> to it (and REQ_META, I would guess).

Yes, sounds good.

So I guess on MLC flash, a reliable write will go to a flash page
that does not have data in any of its paired pages.

	Arnd
