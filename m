From: matthieu castet <castet.matthieu@free.fr>
Subject: password protected mmc/sd handling
Date: Sun, 15 Jan 2012 18:16:12 +0100
Message-ID: <20120115181612.42883c75@mat-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-g21.free.fr ([212.27.42.6]:41011 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab2AORQV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 15 Jan 2012 12:16:21 -0500
Received: from mat-laptop (unknown [81.57.151.96])
	by smtp6-g21.free.fr (Postfix) with ESMTP id E9C5282501
	for <linux-mmc@vger.kernel.org>; Sun, 15 Jan 2012 18:16:14 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

some sdcard support password protection. 
It can be useful on some embedded system (smartphone for example)
where you don't want other people reading your data if you loose it
(and you can't use encryption because of extra cpu usage).

But that doesn't seem supported on linux.
Is there any technical reason for that (not secure, not supported by
all cards, ...) ?

There was an attempt to support it 6 years ago [1], but it wasn't
merged in the main kernel.

Matthieu



[1] http://thread.gmane.org/gmane.linux.kernel/373855
