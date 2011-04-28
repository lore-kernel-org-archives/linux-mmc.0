From: "Ryan Liu" <RyanLiu@BENQ.com>
Subject: Question about timer in struct sdhci_host
Date: Thu, 28 Apr 2011 16:29:53 +0800
Message-ID: <33579C238B096249ADEFFC942E9C396301BA2C93@guru-msv.BQC.CORP.COM>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com> <1303291861-1788-9-git-send-email-arindam.nath@amd.com> <DC43BF02-00E5-4090-A472-722156C5E136@marvell.com> <6C03668EAF45B747AF947A1603D1B300EB81A391@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [218.104.47.52] ([218.104.47.52]:8313 "EHLO
	bqc-fe01.BQC.CORP.COM" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754685Ab1D1IpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Apr 2011 04:45:12 -0400
Content-class: urn:content-classes:message
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300EB81A391@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

 
Hi list,

Maybe some simple questions, but I do not find good answers from google.
The timer is setup in sdhci_add_host, and modified to 10s later in
sdhci_send_command.
1. This timer seems to bu used to indicate that host controller does not
send IRQ to the cpu core(ex. ARM) after 10s since sdhci_send_command. Am
I right?
2. Why is 10s? Isn't it too long? User space applications may produce
large MMC requests to the MMC queue.
    Also, cancle the requests will waste much time. The user may think
the device is dead.
Thanks.

Ryan
