From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 8/8] MFD:rtsx: Use macro defines to replace some
 variables
Date: Tue, 25 Dec 2012 12:14:09 +0100
Message-ID: <20121225111409.GF7692@liondog.tnic>
References: <cover.1356403281.git.wei_wang@realsil.com.cn>
 <9df15689e28b011b5401b09d0a9282d95171dab5.1356403281.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39299 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab2LYLOL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Dec 2012 06:14:11 -0500
Content-Disposition: inline
In-Reply-To: <9df15689e28b011b5401b09d0a9282d95171dab5.1356403281.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com

On Tue, Dec 25, 2012 at 10:43:40AM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> In function rtsx_pci_switch_clock, some variables, such as min_n, max_n,
> and max_div, are not necessary. And those assigned values look very
> obscure for others. It's more proper to use macro definitions here to
> replace these variables.
> 
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
