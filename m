From: Philip Rakity <prakity@marvell.com>
Subject: UHS Support
Date: Thu, 17 May 2012 21:03:30 -0700
Message-ID: <A11AF76B-CF0B-4EC2-9B87-79325B74526D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:56212 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752061Ab2EREG0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 May 2012 00:06:26 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Aaron Lu <Aaron.Lu@amd.com>, Arindam Nath <arindam.nath@amd.com>


Voltage for vcc/vccq is supplied on some of our boards for SD using either a dedicated voltage supply at 3.3v.

The SD controller indicates in the capability1 register (caps[1])  that UHS is supported but since 1.8v is not available in practice there is no support.

There are two ways I can see to solve this problem

a) allow caps[1] to be passed in (like caps[0]) is today via a quirk) and have the caller to sdhci_add_host() just clear the bits for UHS support.
b) define a new quirk that indicates UHS is not supported.

I favor a) but wanted the list to have a chance to respond if there is a preference.

Philip