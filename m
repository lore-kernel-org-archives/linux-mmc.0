From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] mmc: MMC 4.4 DDR support
Date: Fri, 08 Oct 2010 10:02:21 +0300
Message-ID: <4CAEC1FD.6060607@nokia.com>
References: <DFA7B5FE-718A-484B-BA1D-D1B44E3A5A32@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49354 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048Ab0JHHCp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Oct 2010 03:02:45 -0400
In-Reply-To: <DFA7B5FE-718A-484B-BA1D-D1B44E3A5A32@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 01/10/10 06:01, ext Philip Rakity wrote:
>
> I was wondering if we could remove one of the CAPS for DDR voltage (MMC_CAP_1_8V_DDR and MMC_CAP_1_2V_DDR). Both 1.2 and 1.8v are defined in the JEDEC Standard No. 84-A441.
>
> The sd 3.0 host controller only defines the option for 1.8v.  I cannot see a way to set 1.2v.
>
> If this makes sense I can prepare a patch.--

If the host controller does not support 1.2V DDR then it should definitely
not set MMC_CAP_1_2V_DDR.  That is precisely what the caps are for.


> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

