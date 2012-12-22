From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] pci: Add a quirk for the Ricoh 0xe22 SD card reader
Date: Fri, 21 Dec 2012 21:05:03 -0500
Message-ID: <87ehii6dv4.fsf@laptop.org>
References: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda600.1354385950.git.luto@amacapital.net>
	<33c411da9bb44eae8a5f9e0609f8eb0aa4eda601.1354385950.git.luto@amacapital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59771 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab2LVCF3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Dec 2012 21:05:29 -0500
In-Reply-To: <33c411da9bb44eae8a5f9e0609f8eb0aa4eda601.1354385950.git.luto@amacapital.net>
	(Andy Lutomirski's message of "Sat, 1 Dec 2012 12:37:20 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-mmc@vger.kernel.org, Manoj Iyer <manoj.iyer@canonical.com>, stable@kernel.org

Hi Bjorn,

On Sat, Dec 01 2012, Andy Lutomirski wrote:
> Otherwise it fails like this on cards like the Transcend 16GB SDHC card:
> mmc0: new SDHC card at address b368
> mmcblk0: mmc0:b368 SDC   15.0 GiB
> mmcblk0: error -110 sending status command, retrying
> mmcblk0: error -84 transferring data, sector 0, nr 8, cmd respons
> e 0x900, card status 0xb0
>
> Tested on my Lenovo x200 laptop.
>
> Signed-off-by: Andy Lutomirski <luto@amacapital.net>
> Acked-by: Chris Ball <cjb@laptop.org>

Ping -- this is an important patch for getting SD cards working on
Thinkpads, please can you pick it up?

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
