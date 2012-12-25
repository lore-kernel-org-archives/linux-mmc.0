From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 2/8] MFD:rtsx: Remove redundant code
Date: Tue, 25 Dec 2012 12:11:11 +0100
Message-ID: <20121225111111.GD7692@liondog.tnic>
References: <cover.1356403281.git.wei_wang@realsil.com.cn>
 <29a6ff4a0fa5f8f307ed98de97b2ef9643352782.1356403281.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36197 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab2LYLLN (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Dec 2012 06:11:13 -0500
Content-Disposition: inline
In-Reply-To: <29a6ff4a0fa5f8f307ed98de97b2ef9643352782.1356403281.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com

On Tue, Dec 25, 2012 at 10:43:03AM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> In function rtsx_pci_add_sg_tbl, the statement "ptr++" is useless.
> 
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>

Acked-by: Borislav Petkov <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
