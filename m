From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v7 0/3] Add modules to support realtek PCIE card reader
Date: Wed, 07 Nov 2012 14:41:00 -0500
Message-ID: <87r4o56w1f.fsf@octavius.laptop.org>
References: <cover.1351481260.git.wei_wang@realsil.com.cn>
	<508F4A88.8010207@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36082 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414Ab2KGTlP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 7 Nov 2012 14:41:15 -0500
In-Reply-To: <508F4A88.8010207@realsil.com.cn> (wwang's message of "Tue, 30
	Oct 2012 11:33:28 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wwang <wei_wang@realsil.com.cn>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "oakad@yahoo.com" <oakad@yahoo.com>, "bp@alien8.de" <bp@alien8.de>

Hi,

On Mon, Oct 29 2012, wwang wrote:
> Hi Chris, Samuel and Alex:
>
> Can you help to review this patchset, please?
>
> I have asked Greg to remove rts_pstor from the staging tree. So this
> driver have to be merged into 3.8 kernel, or else Realtek'sPCI-E card
> reader can not be accessed easily.

I'm happy with the MMC portion.  I think we're mainly waiting for the
MFD patch -- Samuel, do you have any remaining review comments that need
to be fixed?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
