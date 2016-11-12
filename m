From: Jamie Huang <jamienstar@163.com>
Subject: RT throttling and mmc hardware interrupt timeout
Date: Sat, 12 Nov 2016 17:56:32 +0800
Message-ID: <20161112175632.310c819a@JAMIE>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m12-15.163.com ([220.181.12.15]:34037 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752476AbcKLJ5Q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 12 Nov 2016 04:57:16 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all:
	Recently, I do test with btrfs filesystem on emmc. When I see
	the message "sched: RT throttling activated", uart, network and
	other peripherals are not responding.
	But, the timer is ok, so I can see the following messages:
	"mmc0: Timeout waiting for hardware interrupt." again and again.
	Finally, "I/O error" messages are coming and the btrfs
	filesystem crashes.

	I think, because I use threadirqs, so most irqs are processed
	in threads, yes, RT threads. When "sched: RT throttling
	activated" comes out, RT threads can not be execute for some
	time, so, we can see mmc interrupt timeout message.

	My kernel version is 3.10.55, I know that's very old. Still,
	I want to know, is there any patch for this problem? Or does
	any one encounter the same problem?  Thank you.

