From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4] MMC: MMC boot partitions support.
Date: Wed, 30 Mar 2011 14:03:20 +0200
Message-ID: <201103301403.20779.arnd@arndb.de>
References: <1300533491-2378-2-git-send-email-andreiw@motorola.com> <1300828300-8677-2-git-send-email-andreiw@motorola.com> <AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:62305 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755068Ab1C3MD3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2011 08:03:29 -0400
In-Reply-To: <AANLkTinMu57VyaVK3zBpePdJ-Yi=g9zt2833UtbcRpM5@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Wednesday 30 March 2011, Andrei Warkentin wrote:
> On Tue, Mar 22, 2011 at 4:11 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> > Allows device MMC boot partitions to be accessed. MMC partitions
> > are treated effectively as separate block devices on the same
> > MMC card.
> >
> 
> Anyone has any opinions on these changes as being good or bad?
> Anything I should do differently? Or does everyone like this?

I have no objections to the code, but I don't completely understand
what it does. Maybe you can elaborate more in the patch description.

A few questions from me that I suppose should be answered by the
description:

* Is each of the MMC partitions in turn a partitionable device
  like the user partition with its mmcblk0p1/p2/p3... devices?

* Will this patch impact device naming? Suppose you have an
  existing machine with mmcblk0 and mmcblk1 on two physical
  eMMC devices. When you show the partitions as new block
  devices, could it happen that the names are now different
  as you get additional devices inbetween? That would need to
  be documented carefully, as it could break existing setups.

* What devices specifically have these new partitions? Only eMMC 4.4
  or also other versions?

* Would the same method work to support the secure partition on
  SD cards?

* How does a user identify which hardware partition corresponds to
  a given block device and vice versa?

	Arnd
