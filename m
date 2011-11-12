From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v4] mmc: sdhci: remove "state" argument from sdhci_suspend_host
Date: Fri, 11 Nov 2011 22:08:36 -0500
Message-ID: <87k476hwaz.fsf@laptop.org>
References: <1320314985-9536-1-git-send-email-manuel.lauss@googlemail.com>
	<4EB3BAA3.3020408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58346 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab1KLDIg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 11 Nov 2011 22:08:36 -0500
In-Reply-To: <4EB3BAA3.3020408@intel.com> (Adrian Hunter's message of "Fri, 04
	Nov 2011 12:12:51 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 04 2011, Adrian Hunter wrote:
> On 03/11/11 12:09, Manuel Lauss wrote:
>> Drop the "state" argument from sdhci_suspend_host.  Its only user
>> is the PCI glue;  this allows to move all SDHCI glues to use
>> dev_pm_ops instead.
>> 
>> Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks!  Pushed to mmc-next for 3.3 with Adrian's ACK.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
