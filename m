From: Philip Rakity <prakity@marvell.com>
Subject: MMC DEBUG and Scheduler WARN observation
Date: Tue, 21 Dec 2010 08:40:34 -0800
Message-ID: <3944C8CC-0AED-43D5-B5BD-DDE378F8EE81@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:59884 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751709Ab0LUQoA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Dec 2010 11:44:00 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>


Using linux-next and enabled MMC_DEBUG

on card insert get schedule warn message sched.c line 4000
warn on once test_tsk_need_resched(next));

This warning comes when sdhci.c printk no vmmc regulator found on card insert in add_host.

Phlip